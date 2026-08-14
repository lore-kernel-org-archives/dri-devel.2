Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F48CC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E3A10F622;
	Fri, 14 Aug 2026 14:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MCbJxS1y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0852D10F622
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:57:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8074960A59;
 Fri, 14 Aug 2026 14:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D531F000E9;
 Fri, 14 Aug 2026 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719473;
 bh=qyuLN0yL5j5RG3N0G4l5JMxjSMWwov0zHyak2Yi45Jw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MCbJxS1yaA5tbdnnExkH18G2xRmV81cF6YRQns2DpgW+sAy2W7sn1rJ9HgnEX7YTs
 S9o/i9PjkJkzI8LF8mA/j1AX2XV6svgrmE2Y4oNuye0KC5NbWhi2OZLuIifk13iZUD
 NLQSXGuc05G/pJdulh9EnI1O3iLKV655ad95wvG8pRwAIMagq12UPxCTzUnSzvJElE
 55nPkrV0Qm0MTPDF5iXMuiBCkJ+Wy5ic06ObkYwnaliS0XCvFIx4pOZ8KxVhafOLXQ
 DLAbip02HMl//502tGMAN8ja1tPCeiuZEtjXUViYno7gANcedUNm5+PTpqDOg/RipO
 8AGkVJVE2ZtVw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:56:55 +0200
Subject: [PATCH v2 06/61] drm/sysfb: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-6-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 javierm@redhat.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3887; i=mripard@kernel.org;
 h=from:subject:message-id; bh=oqqmrxoQDuBYHzSFSAXy24Eri/ERsL0QP4aV5UeVI8M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Osf5bXbGVL1i2Nj676DWi9O9+dt6pJXCXllkfLv75
 kjp0tKgjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARUSvGhuOue3klO8/NXbmk
 qceXk1PhxGL9AzceM1RcfnIk5WjrNaa7j/d1vzyn0yuRKOa+pONEN2N9qV9q6Uvm6+ymaz4EpE3
 k+3B+yTXxBXWr+YLvH/BNiub5/Ez/2PpZMbOLW+a+kHjbVsoAAA==
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

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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
2.55.0

