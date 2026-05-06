import { NextAuthOptions } from "next-auth";
import KeycloakProvider from "next-auth/providers/keycloak";

export const authOptions: NextAuthOptions = {
  providers: [
    KeycloakProvider({
      clientId: process.env.KEYCLOAK_ID!,
      clientSecret: process.env.KEYCLOAK_SECRET!,
      issuer: process.env.KEYCLOAK_ISSUER!,
      profile(profile) {
        const realmRoles = profile.realm_access?.roles || [];
        const clientRoles = Object.values(profile.resource_access || {})
          .flatMap((r: any) => r.roles || []);
        
        const rawRoles = Array.from(new Set([...realmRoles, ...clientRoles]));
        
        // OPTIMIZACIÓN: Si es admin, no necesitamos guardar nada más
        if (rawRoles.includes('admin')) {
          return {
            id: profile.sub,
            name: profile.name ?? profile.preferred_username,
            email: profile.email,
            roles: ['admin'],
          };
        }

        // Filtrar solo roles que nos interesan: "docs" exacto O que empiecen por "docs:"
        const cleanRoles = rawRoles.filter(role => role === 'docs' || role.startsWith('docs:'));

        return {
          id: profile.sub,
          name: profile.name ?? profile.preferred_username,
          email: profile.email,
          roles: cleanRoles,
        };
      },
    }),
  ],
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.roles = (user as any).roles;
      }
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        (session.user as any).roles = token.roles || [];
      }
      return session;
    },
  },
};
