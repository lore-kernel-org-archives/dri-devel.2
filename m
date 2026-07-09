Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A97CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0897E10F525;
	Thu,  9 Jul 2026 11:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R+IKC9sN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0566010F517
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:51:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 549CE600C3;
 Thu,  9 Jul 2026 11:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B3F1F000E9;
 Thu,  9 Jul 2026 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597877;
 bh=/0xwM7i2lIM9IJcQa4T6Uk0C+WWnyemV2n6Im6X9o/Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=R+IKC9sNarviM47UrKMjZfUsrwuTZV7QEKdQUmHauJ/7xiJY25b0i6N4mAReE+QV5
 aqXRaAV9eEfcCHEpaOekJCt1axHHookapuv0iHJzMsX7hX38v6WWFB6M5ri6BNLEQt
 pyPEz6jx6HVWeckF8zZqkr6OZ22XZbq63VW62uHSQmRQEovwkpKclC+sl3C3HfwUat
 6H3uuM0LxEr9/9AZhfQQP9399I1QS1R5ag+c4DrozkC/h2ebjPIeRTVF6FY/nS54lp
 Bii6jhLA4h38UHMwGqqAGZuZtSgFy2Qm16XXcLEtcYnKgf0Nc5kzmgxSvBlifGAIbA
 O0xTjpJCpuY5w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:50:32 +0200
Subject: [PATCH 06/60] drm/sysfb: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-6-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 javierm@redhat.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3833; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TUDztFB+vkvHETtgIIzPC+KJuAff2BHZer6mb4WIAzE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3dzsmsHxP7a6ijIvisjZFRL/qsHqpyuvp4jiqb/Mk
 aGc6VUdU1kYhDkZZMUUWZ7IhJ1e3r64ysF+5Q+YOaxMIEMYuDgFYCKncxkbthvJXlq5zYZ9z8Ru
 7cotholfRG7G592Vsdy/fwrvjju5rIWHfT++uvB4rQ7LtBiBat0axoYldteOBzT93P01+NPNIuc
 k17DUMhOluZ1XEzbpMc90WKss5Xvubea3uP66j2WnFS6aywAA
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

drm_sysfb_plane_reset() handles both state creation and teardown of
the previous state through the reset hook, which conflates initial
state allocation with hardware and software reset at resume.

Convert it to drm_sysfb_plane_atomic_create_state(), which only
allocates and initializes a pristine state using
__drm_gem_shadow_plane_state_init(). Update DRM_SYSFB_PLANE_FUNCS to
use .atomic_create_state instead of .reset.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: javierm@redhat.com
---
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h  |  4 ++--
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 30 +++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
index 547f2327af5e..1c31267daa00 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
@@ -132,19 +132,19 @@ int drm_sysfb_plane_helper_get_scanout_buffer(struct drm_plane *plane,
 	.atomic_check = drm_sysfb_plane_helper_atomic_check, \
 	.atomic_update = drm_sysfb_plane_helper_atomic_update, \
 	.atomic_disable = drm_sysfb_plane_helper_atomic_disable, \
 	.get_scanout_buffer = drm_sysfb_plane_helper_get_scanout_buffer
 
-void drm_sysfb_plane_reset(struct drm_plane *plane);
+struct drm_plane_state *drm_sysfb_plane_atomic_create_state(struct drm_plane *plane);
 struct drm_plane_state *drm_sysfb_plane_atomic_duplicate_state(struct drm_plane *plane);
 void drm_sysfb_plane_atomic_destroy_state(struct drm_plane *plane,
 					  struct drm_plane_state *plane_state);
 
 #define DRM_SYSFB_PLANE_FUNCS \
-	.reset = drm_sysfb_plane_reset, \
 	.update_plane = drm_atomic_helper_update_plane, \
 	.disable_plane = drm_atomic_helper_disable_plane, \
+	.atomic_create_state = drm_sysfb_plane_atomic_create_state, \
 	.atomic_duplicate_state = drm_sysfb_plane_atomic_duplicate_state, \
 	.atomic_destroy_state = drm_sysfb_plane_atomic_destroy_state
 
 /*
  * CRTC
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index d2de29caf89e..9a4c210d6f96 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -418,24 +418,36 @@ int drm_sysfb_plane_helper_get_scanout_buffer(struct drm_plane *plane,
 
 	return 0;
 }
 EXPORT_SYMBOL(drm_sysfb_plane_helper_get_scanout_buffer);
 
-void drm_sysfb_plane_reset(struct drm_plane *plane)
+/**
+ * drm_sysfb_plane_atomic_create_state - creates sysfb plane state
+ * @plane: the plane
+ *
+ * This function implements struct &drm_plane_funcs.atomic_create_state for
+ * sysfb planes. It allocates the plane state of type
+ * struct drm_sysfb_plane_state.
+ *
+ * Returns:
+ * A pointer to a new plane state on success, or an ERR_PTR()-encoded
+ * error code otherwise.
+ */
+struct drm_plane_state *
+drm_sysfb_plane_atomic_create_state(struct drm_plane *plane)
 {
 	struct drm_sysfb_plane_state *sysfb_plane_state;
 
-	if (plane->state)
-		drm_sysfb_plane_state_destroy(to_drm_sysfb_plane_state(plane->state));
-
 	sysfb_plane_state = kzalloc_obj(*sysfb_plane_state);
-	if (sysfb_plane_state)
-		__drm_gem_reset_shadow_plane(plane, &sysfb_plane_state->base);
-	else
-		__drm_gem_reset_shadow_plane(plane, NULL);
+	if (!sysfb_plane_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_gem_shadow_plane_state_init(plane, &sysfb_plane_state->base);
+
+	return &sysfb_plane_state->base.base;
 }
-EXPORT_SYMBOL(drm_sysfb_plane_reset);
+EXPORT_SYMBOL(drm_sysfb_plane_atomic_create_state);
 
 struct drm_plane_state *drm_sysfb_plane_atomic_duplicate_state(struct drm_plane *plane)
 {
 	struct drm_device *dev = plane->dev;
 	struct drm_plane_state *plane_state = plane->state;

-- 
2.54.0

