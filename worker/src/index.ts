/**
 * Cloudflare Worker for get.meshbrow.dev
 *
 * Routes:
 *   GET / → serves install.sh (shell script installer)
 *   GET /install.sh → same as above
 *
 * DNS: CNAME get.meshbrow.dev → meshbrow-install.{account}.workers.dev
 */

const INSTALL_SCRIPT_URL =
	"https://raw.githubusercontent.com/meshbrow-dev/homebrew-tap/main/install.sh";

export default {
	async fetch(request: Request): Promise<Response> {
		const url = new URL(request.url);
		const path = url.pathname;

		if (path === "/" || path === "/install.sh") {
			const resp = await fetch(INSTALL_SCRIPT_URL);
			if (!resp.ok) {
				return new Response("Failed to fetch install script", { status: 502 });
			}
			const script = await resp.text();
			return new Response(script, {
				headers: {
					"Content-Type": "text/plain; charset=utf-8",
					"Cache-Control": "public, max-age=300",
				},
			});
		}

		return new Response("Not found. Usage: curl -sSL https://get.meshbrow.dev | sh\n", {
			status: 404,
			headers: { "Content-Type": "text/plain" },
		});
	},
};
