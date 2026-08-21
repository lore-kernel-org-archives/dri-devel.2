Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701D1C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C5710F2F2;
	Fri, 21 Aug 2026 14:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JfiRo+RB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9633810F2D4
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9963361126;
 Fri, 21 Aug 2026 14:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81AC1F000E9;
 Fri, 21 Aug 2026 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323297;
 bh=CnsmaFAgylDWKtDZ3FHx+2lPuiUhX1z8iAZ1+V/AvJE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JfiRo+RBLx4ZLpIAxGhT4G3KF1ljHCCMOLKGrq2H7+U2Jl1SyRNE8YHh2htqZaf+K
 qG62o0grWpcQkGq1rd3tmBxZkgsRHHzOqjFOG+IdanIL/6e0GI+066iMcQ23N3A3KJ
 Rn+lHh2FLwPt7kB0MpdQmPuhAqddal/D67Fyk2iMHxQZvxIoc/eDHJu973IEgGCoNt
 Z4e+6XRb+3lN+FARpxDcFSwtucvn7yUSUFswFAb9jMWJgG2rsaGp5YjN8GQTkH9ej+
 SRR72jdWSeFC8DpCGgXXpcJrvGpY2/c6x+Hv9LY+VlWcBAx8Dbqakx15cWFFW49FZH
 h2J4Oe9s1LYog==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:32 +0200
Subject: [PATCH 56/70] drm/mxsfb: lcdif: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-56-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, 
 imx@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QDaJrKua2s3tk+JyjZAGBJwqt552ARvhZxmU87Kbaxk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyYK7dximvJXboPXnxbXTUwS3Ruzcm5L0f0vMHMMjH
 9Znv6+d1TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmInKJsYp5Y8iCsueSjfoW
 us/ikvhPLZGaYcpkGlT880byg3f8S/lfeJhF1/K2q4p+uHB0V+/Ni4z1ZalBfg2sTj6TuOSvtR9
 VktfR3MIrvj158ZZTNqmTNG5k8KzRvX6o38HgoRBz69Fbul8B
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The lcdif crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Stefan Agner <stefan@agner.ch>
Cc: imx@lists.linux.dev
---
 drivers/gpu/drm/mxsfb/lcdif_kms.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
index 79e0f483ca20..5f0fbec3a390 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -594,22 +594,21 @@ static void lcdif_crtc_atomic_destroy_state(struct drm_crtc *crtc,
 {
 	__drm_atomic_helper_crtc_destroy_state(state);
 	kfree(to_lcdif_crtc_state(state));
 }
 
-static void lcdif_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *lcdif_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct lcdif_crtc_state *state;
 
-	if (crtc->state)
-		lcdif_crtc_atomic_destroy_state(crtc, crtc->state);
-
-	crtc->state = NULL;
-
 	state = kzalloc_obj(*state);
-	if (state)
-		__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
+
+	return &state->base;
 }
 
 static struct drm_crtc_state *
 lcdif_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
 {
@@ -657,11 +656,11 @@ static const struct drm_crtc_helper_funcs lcdif_crtc_helper_funcs = {
 	.atomic_enable = lcdif_crtc_atomic_enable,
 	.atomic_disable = lcdif_crtc_atomic_disable,
 };
 
 static const struct drm_crtc_funcs lcdif_crtc_funcs = {
-	.reset = lcdif_crtc_reset,
+	.atomic_create_state = lcdif_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = lcdif_crtc_atomic_duplicate_state,
 	.atomic_destroy_state = lcdif_crtc_atomic_destroy_state,

-- 
2.55.0

