import { execSync } from 'child_process';
import path from 'path';

export interface GitMetadata {
  lastUpdated?: string;
  lastAuthor?: string;
  contributors: string[];
}

export function getGitMetadata(pagePath: string): GitMetadata {
  try {
    // pagePath es relativo a la carpeta content/docs, ej: "about/index.mdx"
    const absolutePath = path.join(process.cwd(), 'content/docs', pagePath);

    // 1. Obtener el último autor y la fecha del último commit
    const lastCommitInfo = execSync(
      `git log -1 --pretty=format:"%an|%ad" --date=short "${absolutePath}"`,
      { encoding: 'utf8' }
    ).trim();

    // 2. Obtener la lista única de colaboradores del archivo
    const allContributors = execSync(
      `git log --pretty=format:"%an" "${absolutePath}"`,
      { encoding: 'utf8' }
    )
      .split('\n')
      .map(name => name.trim())
      .filter((name, index, self) => name && self.indexOf(name) === index);

    if (!lastCommitInfo) {
      return { contributors: [] };
    }

    const [lastAuthor, lastUpdated] = lastCommitInfo.split('|');

    return {
      lastAuthor,
      lastUpdated,
      contributors: allContributors,
    };
  } catch (error) {
    // Captura cualquier fallo si no hay comandos de Git, no está en repositorio o el archivo no existe en el commit history
    return { contributors: [] };
  }
}

export function getAllGitCreationDates(): Map<string, string> {
  const dates = new Map<string, string>();
  try {
    const output = execSync(
      `git log --reverse --diff-filter=A --pretty=format:"%aI" --name-only content/docs/`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    const lines = output.trim().split('\n');
    let currentDate: string | null = null;

    for (const line of lines) {
      const trimmed = line.trim();
      if (!trimmed) continue;

      // Detect date lines (ISO 8601 format)
      if (/^\d{4}-\d{2}-\d{2}T/.test(trimmed)) {
        currentDate = trimmed.split('T')[0]; // Extract YYYY-MM-DD
      } else if (currentDate && trimmed.startsWith('content/docs/') && !dates.has(trimmed)) {
        dates.set(trimmed, currentDate);
      }
    }
  } catch (error) {
    console.error('Error al obtener fechas de creación de git:', error);
  }
  return dates;
}
