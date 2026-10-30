Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A828606A321
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dD3X3vBT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2201128BE;
	Fri, 30 Oct 2026 15:17:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F6A1128C1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:16:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CB40601EE;
 Fri, 30 Oct 2026 15:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3741F000C1;
 Fri, 30 Oct 2026 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373360;
 bh=L8OAWcKNF3AlQQ6VhZ0NwcVhCU6ETs6bj+k/x85IRJM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dD3X3vBTIN5bH1rzNbkn+FGfqYY4zZdUkJk7wvmuz++SVsB3efsWzZBSI9+0Um//6
 TjCJ7iWQXq9SHU68r21mzQPBJEsJa4X5nO7XsxQmymjBUPNvFQXCdtHaPOgQu7S/YS
 WKNXW/looJHu5gDL1dzv+9/FwfvBvnY0ASTxs0ity9F+ix8Loas43/noUFgM3ej4T7
 DnyQkxPXAH4INvv283j6+HnQ4zqGyIyhE2wyWBXQ8wp/vw89kHjZ/ShYDeM2xVwQBc
 mp9nkYdIJoFJGXvDP+QkqWVVOn/jcYQg+1NI+PQ1fVE0jVn5W6XChyyoGohtxi5g0f
 RJ9hy63uG6tDQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:14:05 +0100
Subject: [PATCH v3 35/37] drm/tegra: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-35-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3645; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7xtX5ZbOPIxKyno9pvoAB6n6Jf6NLnvGww7Fiv6yapg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtujcPJHH9v+Ipw3z5cSoiKs21/epbDTnYLRZt1m2y
 2jXdKeZHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAifhsZ6xTdl7ZFn9hxSq6A
 i+tt1uo56vr1TzpWWf35zsQcVC5/+0T8+bJ7nvd6TgcuTda78+hdEGN9usDXVZ9b6zdzHkvUcsx
 Q0IyZt/4h5+d1uk/W6QalLnYo8Mm8ved+1/9KBQff1/fXtOYDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tegra DSI and SOR connector reset implementations create custom
state subclasses, but only initialize a pristine state without resetting
any hardware. This is equivalent to what atomic_create_state expects.
Convert to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>
Cc: linux-tegra@vger.kernel.org
---
 drivers/gpu/drm/tegra/dsi.c | 17 ++++++++---------
 drivers/gpu/drm/tegra/sor.c | 13 +++++--------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 7b595310e737..206405770071 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -786,17 +786,16 @@ static void tegra_dsi_soft_reset(struct tegra_dsi *dsi)
 }
 
-static void tegra_dsi_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+tegra_dsi_connector_create_state(struct drm_connector *connector)
 {
-	struct tegra_dsi_state *state = kzalloc_obj(*state);
+	struct tegra_dsi_state *state;
 
+	state = kzalloc_obj(*state);
 	if (!state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	if (connector->state) {
-		__drm_atomic_helper_connector_destroy_state(connector->state);
-		kfree(connector->state);
-	}
+	__drm_atomic_helper_connector_state_init(&state->base, connector);
 
-	__drm_atomic_helper_connector_reset(connector, &state->base);
+	return &state->base;
 }
 
@@ -818,8 +817,8 @@ tegra_dsi_connector_duplicate_state(struct drm_connector *connector)
 
 static const struct drm_connector_funcs tegra_dsi_connector_funcs = {
-	.reset = tegra_dsi_connector_reset,
 	.detect = tegra_output_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = tegra_output_connector_destroy,
+	.atomic_create_state = tegra_dsi_connector_create_state,
 	.atomic_duplicate_state = tegra_dsi_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index e384cbd0cbf7..16a5ecefbe4f 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1721,5 +1721,5 @@ static void tegra_sor_early_unregister(struct drm_connector *connector)
 }
 
-static void tegra_sor_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *tegra_sor_connector_create_state(struct drm_connector *connector)
 {
 	struct tegra_sor_state *state;
@@ -1727,12 +1727,9 @@ static void tegra_sor_connector_reset(struct drm_connector *connector)
 	state = kzalloc_obj(*state);
 	if (!state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	if (connector->state) {
-		__drm_atomic_helper_connector_destroy_state(connector->state);
-		kfree(connector->state);
-	}
+	__drm_atomic_helper_connector_state_init(&state->base, connector);
 
-	__drm_atomic_helper_connector_reset(connector, &state->base);
+	return &state->base;
 }
 
@@ -1765,8 +1762,8 @@ tegra_sor_connector_duplicate_state(struct drm_connector *connector)
 
 static const struct drm_connector_funcs tegra_sor_connector_funcs = {
-	.reset = tegra_sor_connector_reset,
 	.detect = tegra_sor_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = tegra_output_connector_destroy,
+	.atomic_create_state = tegra_sor_connector_create_state,
 	.atomic_duplicate_state = tegra_sor_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

