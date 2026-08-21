Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C276C5DF95
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B04210F300;
	Fri, 21 Aug 2026 14:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j8pJucpX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AE910F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:42:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8DF361126;
 Fri, 21 Aug 2026 14:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD331F000E9;
 Fri, 21 Aug 2026 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323323;
 bh=oJHtdcWZoXAW1saCZB5jjRhwdwubsYINIObgsN9SDYM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j8pJucpXhYwqBz/hXbmVoLsChCdNMl/72ChnxyVvTu1InBt/NYV8N0lGZ3E9OYxQ/
 SlFITmOHuP/q4YGTFl/Qrhr4Yhqh/0/4/agCcHlDChmGuzJNZQXDgc39rpdHWOs1AP
 0PVaJZ2zSgQxSEnWrTy9qTrg7fVLUSacBYQ4676rrrPu2DU0/v239yeoCkdi1KIrBG
 rAmA90dBOQzuGt9SVgMxC6BvH3ebbXr/x69b92qlTGrvUB1o3Pn3U8I/AZXPuVziud
 AsCv0Cyb3LeS36/YLiJ0rQtX3+1X3cp4MuM0tOLOUkVYg6tiXlIExjeDLjWLIiCDjL
 tgpGrWoDRQzzg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:43 +0200
Subject: [PATCH 67/70] drm/vkms: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-67-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Melissa Wen <melissa.srw@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; i=mripard@kernel.org;
 h=from:subject:message-id; bh=cAYVeTOkR2uTX7jGIClvJJkOegHIf5wpMkUnOjBP6yk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyaJh/+zZJc/8/nHOwuXBkpUXPP+fT3tmv/J396TEl
 Btn+ba+6pjCwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATCf/IWDGpLXyGiOmvbTmF
 P480Sl3jqKqs2D6x7ACvikdo8erlPhOez40//kJz6cEPUV/YmmruMdbpWyheW7DikVPyV8kJOuy
 ZUs+qzDaWzOS75TGp7ItKnsAFWa38ckd+56dfewquLp3+QhMA
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

The vkms crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), initializes the composer work
struct, and frees the previous state. It does not perform any hardware
reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 079abfba427d..fe17f49305a9 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -84,26 +84,28 @@ static void vkms_atomic_crtc_destroy_state(struct drm_crtc *crtc,
 	WARN_ON(work_pending(&vkms_state->composer_work));
 	kfree(vkms_state->active_planes);
 	kfree(vkms_state);
 }
 
-static void vkms_atomic_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *vkms_atomic_crtc_create_state(struct drm_crtc *crtc)
 {
-	struct vkms_crtc_state *vkms_state = kzalloc_obj(*vkms_state);
+	struct vkms_crtc_state *vkms_state;
 
-	if (crtc->state)
-		vkms_atomic_crtc_destroy_state(crtc, crtc->state);
+	vkms_state = kzalloc_obj(*vkms_state);
+	if (!vkms_state)
+		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_crtc_reset(crtc, &vkms_state->base);
-	if (vkms_state)
-		INIT_WORK(&vkms_state->composer_work, vkms_composer_worker);
+	__drm_atomic_helper_crtc_state_init(&vkms_state->base, crtc);
+	INIT_WORK(&vkms_state->composer_work, vkms_composer_worker);
+
+	return &vkms_state->base;
 }
 
 static const struct drm_crtc_funcs vkms_crtc_funcs = {
 	.set_config             = drm_atomic_helper_set_config,
 	.page_flip              = drm_atomic_helper_page_flip,
-	.reset                  = vkms_atomic_crtc_reset,
+	.atomic_create_state = vkms_atomic_crtc_create_state,
 	.atomic_duplicate_state = vkms_atomic_crtc_duplicate_state,
 	.atomic_destroy_state   = vkms_atomic_crtc_destroy_state,
 	DRM_CRTC_VBLANK_TIMER_FUNCS,
 	.get_crc_sources	= vkms_get_crc_sources,
 	.set_crc_source		= vkms_set_crc_source,

-- 
2.55.0

