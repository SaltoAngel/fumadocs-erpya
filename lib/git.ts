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
