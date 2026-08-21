Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704AAC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F317110F2FF;
	Fri, 21 Aug 2026 14:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a7IWduAI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C292410F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A6DC743454;
 Fri, 21 Aug 2026 14:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E36F1F00A3D;
 Fri, 21 Aug 2026 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323304;
 bh=BYa6l5Fho8Ep9989qnn5LDKe5ZMRQ5SoEsn4wHVm0Zk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=a7IWduAIwpZ3Qb4hV2REcWG86N/ZvMI2aVj2DvddCyjBERkM0xIwzyqTXaPjjRcuF
 ph30FV5j7NiMwxKyQyiJpjwovf3iqxtcWFXBaFEFHGeyDPs6rVpRqXPOQ1MxmBMm+7
 x7tTbGvW1RITfLTl1qpASzUCzDR9vMQKiucsI7YyEnpKiARhiopLcjnbubYFqB3yxW
 HgCMlXvQJV4AfCLE/dFNvVbxXgdT3p14omiUpIUrrL9X21fhMprytzoK2Fpqj+rVsQ
 Lp+wTBxfE4DJBwxsGyylWxqUVxaH5wvOUDiIp8FdRxm7zTVeIxDQlYuUbIXCde81Wb
 LMAPKX9FYTMAA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:35 +0200
Subject: [PATCH 59/70] drm/rcar-du: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-59-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3215; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1bjOm5wXcyXycK03MVup0cuEL5KbIkzHL63myTDrSes=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyUI8a+MbV4dZ/9kV2zpF99lGA//o3V/0N602MNySr
 VTEWyDYMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZy+AxjrSi/MJPfwu76FYez
 30/P/37MsNatU6zG1+DskSksF8oWzGjq/FX/5F1RjVfjf8NVvBoLGBu26335+vVjjfmEy0Wz17t
 /Vy4rfq3l2rUyWbojPEq6bY9Ts9bGpWZmq53sba5aGHk9nggA
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

The rcar-du crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), sets driver-specific default values
for the CRC source and index, and frees the previous state. It does
not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
index 6c07c406f725..59c2a4b76137 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
@@ -995,27 +995,24 @@ static void rcar_du_crtc_cleanup(struct drm_crtc *crtc)
 	rcar_du_crtc_crc_cleanup(rcrtc);
 
 	drm_crtc_cleanup(crtc);
 }
 
-static void rcar_du_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *rcar_du_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct rcar_du_crtc_state *state;
 
-	if (crtc->state) {
-		rcar_du_crtc_atomic_destroy_state(crtc, crtc->state);
-		crtc->state = NULL;
-	}
-
 	state = kzalloc_obj(*state);
 	if (state == NULL)
-		return;
+		return ERR_PTR(-ENOMEM);
 
 	state->crc.source = VSP1_DU_CRC_NONE;
 	state->crc.index = 0;
 
-	__drm_atomic_helper_crtc_reset(crtc, &state->state);
+	__drm_atomic_helper_crtc_state_init(&state->state, crtc);
+
+	return &state->state;
 }
 
 static int rcar_du_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
@@ -1153,22 +1150,22 @@ static int rcar_du_crtc_set_crc_source(struct drm_crtc *crtc,
 
 	return ret;
 }
 
 static const struct drm_crtc_funcs crtc_funcs_gen2 = {
-	.reset = rcar_du_crtc_reset,
+	.atomic_create_state = rcar_du_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = rcar_du_crtc_atomic_duplicate_state,
 	.atomic_destroy_state = rcar_du_crtc_atomic_destroy_state,
 	.enable_vblank = rcar_du_crtc_enable_vblank,
 	.disable_vblank = rcar_du_crtc_disable_vblank,
 };
 
 static const struct drm_crtc_funcs crtc_funcs_gen3 = {
-	.reset = rcar_du_crtc_reset,
+	.atomic_create_state = rcar_du_crtc_create_state,
 	.destroy = rcar_du_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = rcar_du_crtc_atomic_duplicate_state,
 	.atomic_destroy_state = rcar_du_crtc_atomic_destroy_state,

-- 
2.55.0

