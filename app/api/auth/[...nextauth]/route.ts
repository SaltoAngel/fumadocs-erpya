import NextAuth from "next-auth"
import KeycloakProvider from "next-auth/providers/keycloak"

const handler = NextAuth({
  providers: [
    KeycloakProvider({
      clientId: process.env.KEYCLOAK_ID!,
      clientSecret: process.env.KEYCLOAK_SECRET!,
      issuer: process.env.KEYCLOAK_ISSUER!,
    }),
  ],
  callbacks: {
    async jwt({ token, account, profile }: any) {
      // Extraer roles de Keycloak al iniciar sesión
      if (profile) {
        token.roles = profile.realm_access?.roles || [];
      }
      return token;
    },
    async session({ session, token }: any) {
      // Pasar los roles a la sesión del cliente
      session.user.roles = token.roles;
      return session;
    },
  },
})

export { handler as GET, handler as POST }
