Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F442C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C9010F2DD;
	Fri, 21 Aug 2026 14:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wr7EzjO2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D84210F2D1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2648342453;
 Fri, 21 Aug 2026 14:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826171F000E9;
 Fri, 21 Aug 2026 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323290;
 bh=2wCtBfyktFtIb3a3++tWbQEZesKiZS3/VRLEk21Oo4o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Wr7EzjO29BB6DkVxPRFQlBgppMCLPewv7/Na7/v7uiSGsQf70k19zmDz4ROmJshyy
 1dHgJgfTdc0lLX3x0Wl/XF+xjVgmn+SQZLgGEUmsdBtYe/4IqVVMeeDjSssosPqcjZ
 sfZIyOw7t66hyx3z/4ULxBnSw7uwFULPkpZTDM+b6al8hNdd5GsSSmtInDSDOokxYb
 d0DZCooP58C0kcMxxQ3wrJ0M16BL76q3Hv+YK8NHzeg+yhz0rRdnlui0QlbzWespSv
 lGDf4z3Q0QJ++ZLoR3mF1hVRb4MwHDGKQ4pyDaN+VNeObwJs/fnXHCT0NlzdIJ627P
 GA8LgkJ8R31dw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:29 +0200
Subject: [PATCH 53/70] drm/mgag200: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-53-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3406; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5IwznN9rn4PKsTaGqefx/HE4Kw3VmhnL1+wQoQb8Z9o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyfxr6zvXWHmcVD/34lbysg0hga2LU+dduCZUOXH5z
 zXmp24LdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJaPkxNszf5LRxw7srbJc1
 7jL7/O9Rcv17JcmM5cXK8/P+zjla3q+xp3hOWhXzJkejoDjpB2F/eRnr67sebF1++ptSi9rxRdH
 97Xuspkx/umXOlfpF1yWm2ExmZCn3C6tour2nZ1frngNxGhdbAA==
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

The mgag200 crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_drv.h  |  4 ++--
 drivers/gpu/drm/mgag200/mgag200_mode.c | 15 +++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index 3732c62351bb..bccc70983d28 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -405,19 +405,19 @@ void mgag200_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic
 	.atomic_check = mgag200_crtc_helper_atomic_check, \
 	.atomic_flush = mgag200_crtc_helper_atomic_flush, \
 	.atomic_enable = mgag200_crtc_helper_atomic_enable, \
 	.atomic_disable = mgag200_crtc_helper_atomic_disable
 
-void mgag200_crtc_reset(struct drm_crtc *crtc);
+struct drm_crtc_state *mgag200_crtc_atomic_create_state(struct drm_crtc *crtc);
 struct drm_crtc_state *mgag200_crtc_atomic_duplicate_state(struct drm_crtc *crtc);
 void mgag200_crtc_atomic_destroy_state(struct drm_crtc *crtc, struct drm_crtc_state *crtc_state);
 
 #define MGAG200_CRTC_FUNCS \
-	.reset = mgag200_crtc_reset, \
 	.destroy = drm_crtc_cleanup, \
 	.set_config = drm_atomic_helper_set_config, \
 	.page_flip = drm_atomic_helper_page_flip, \
+	.atomic_create_state = mgag200_crtc_atomic_create_state, \
 	.atomic_duplicate_state = mgag200_crtc_atomic_duplicate_state, \
 	.atomic_destroy_state = mgag200_crtc_atomic_destroy_state
 
 void mgag200_set_mode_regs(struct mga_device *mdev, const struct drm_display_mode *mode,
 			   bool set_vidrst);
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 7e07fc3f1a60..4e952655e4f5 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -677,22 +677,21 @@ void mgag200_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic
 	struct mga_device *mdev = to_mga_device(crtc->dev);
 
 	mgag200_disable_display(mdev);
 }
 
-void mgag200_crtc_reset(struct drm_crtc *crtc)
+struct drm_crtc_state *mgag200_crtc_atomic_create_state(struct drm_crtc *crtc)
 {
 	struct mgag200_crtc_state *mgag200_crtc_state;
 
-	if (crtc->state)
-		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
-
 	mgag200_crtc_state = kzalloc_obj(*mgag200_crtc_state);
-	if (mgag200_crtc_state)
-		__drm_atomic_helper_crtc_reset(crtc, &mgag200_crtc_state->base);
-	else
-		__drm_atomic_helper_crtc_reset(crtc, NULL);
+	if (!mgag200_crtc_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_crtc_state_init(&mgag200_crtc_state->base, crtc);
+
+	return &mgag200_crtc_state->base;
 }
 
 struct drm_crtc_state *mgag200_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
 {
 	struct drm_crtc_state *crtc_state = crtc->state;

-- 
2.55.0

