Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90747C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E633310F61B;
	Fri, 14 Aug 2026 14:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QEyLHNvK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E3110F61B
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:57:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCD2A60A58;
 Fri, 14 Aug 2026 14:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177691F00A3A;
 Fri, 14 Aug 2026 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719463;
 bh=Nxn0cfgRyKM5YTZ/u+GrACPJFGr2tNTUD14a5jo364M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QEyLHNvK9GP1boonPghFWQkqL6dxe4JlMJaWD0cZbXox780DSSBiEarm0S4HQzgy9
 ljnw1qaf0tK4x5trE9lb1WmwSbaBaIGBW1GXp3ddzE2a7VaxKywPtF5Ioi8Gxcwklw
 HT8rCFDhDM0fZDBMxEjOD/sCT4hNclKmKZhIviBhzUImtruazqDDZC3KitZHlKbhZ4
 xkZ1O8zCksUzru4o6n3BNzoF7BtlhxcxBRj7krBJZitm+riIlqFYeBxAFaWkoHOCSF
 TtRgxGN9A/4YIXqNMdoki/Zpe3zgvXtk5Iiflz16iimnImzlbXYQ5vGFrZdwVnpS0h
 7DMVjUwSS5ZvQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:56:51 +0200
Subject: [PATCH v2 02/61] drm/gem-atomic-helper: Create
 drm_gem_create_shadow_plane_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-2-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3856; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sLZAwypIMfDGvD9CvIUvn1uST5DmIDwWuhcwMu1Pio0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Okfnn+U0/Fi2S/PQD96OsmuymjrGf7+0f+8V2CJ25
 POKC3nfO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEZI4zNkyO/eG29GKYzDzr
 5LiAPV+3ONqkWphtVVQ7daHCsFbwmsF6aanK9G0ZpeatqhtbO+I/MzZMeqHr47n0X3LqtJNls/t
 O5+/7dv/HPPcZEhOa3H93sjG9/XzJ9cxvrXLz+9v8HCVdJ0YDAA==
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

The GEM shadow-plane helpers only expose reset functions
(drm_gem_reset_shadow_plane and __drm_gem_reset_shadow_plane) that
handle both the initial state allocation and the reset path. The new
atomic_create_state hook requires a function that only allocates and
initializes a pristine state without any side effect.

Create __drm_gem_shadow_plane_state_init() to initialize a
pre-allocated shadow plane state, and
drm_gem_create_shadow_plane_state() to allocate and initialize one
from scratch.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 42 +++++++++++++++++++++++++++++++++
 include/drm/drm_gem_atomic_helper.h     |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index abef865c5f2c..7ef67c2d77ce 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -178,10 +178,52 @@ EXPORT_SYMBOL_GPL(drm_gem_plane_helper_prepare_fb);
 
 /*
  * Shadow-buffered Planes
  */
 
+/**
+ * __drm_gem_shadow_plane_state_init - initializes shadow-buffered plane state
+ * @plane: the plane
+ * @shadow_plane_state: the shadow-buffered plane state
+ *
+ * This function initializes a pre-allocated shadow-buffered plane state.
+ * Helpful for drivers that subclass struct drm_shadow_plane_state.
+ */
+void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
+				       struct drm_shadow_plane_state *shadow_plane_state)
+{
+	__drm_atomic_helper_plane_state_init(&shadow_plane_state->base, plane);
+	drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
+}
+EXPORT_SYMBOL(__drm_gem_shadow_plane_state_init);
+
+/**
+ * drm_gem_create_shadow_plane_state - creates a shadow-buffered plane state
+ * @plane: the plane
+ *
+ * This function implements struct &drm_plane_funcs.atomic_create_state for
+ * shadow-buffered planes. It assumes the new state to be of type
+ * struct drm_shadow_plane_state.
+ *
+ * Returns:
+ * A pointer to a new plane state on success, or an ERR_PTR()-encoded
+ * error code otherwise.
+ */
+struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane)
+{
+	struct drm_shadow_plane_state *shadow_plane_state;
+
+	shadow_plane_state = kzalloc_obj(*shadow_plane_state);
+	if (!shadow_plane_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_gem_shadow_plane_state_init(plane, shadow_plane_state);
+
+	return &shadow_plane_state->base;
+}
+EXPORT_SYMBOL(drm_gem_create_shadow_plane_state);
+
 /**
  * __drm_gem_duplicate_shadow_plane_state - duplicates shadow-buffered plane state
  * @plane: the plane
  * @new_shadow_plane_state: the new shadow-buffered plane state
  *
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index 3e01c619a25e..43657d8fb1c8 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -93,10 +93,13 @@ void __drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane,
 void __drm_gem_destroy_shadow_plane_state(struct drm_shadow_plane_state *shadow_plane_state);
 void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
 				  struct drm_shadow_plane_state *shadow_plane_state);
 
 void drm_gem_reset_shadow_plane(struct drm_plane *plane);
+void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
+				       struct drm_shadow_plane_state *shadow_plane_state);
+struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane);
 struct drm_plane_state *drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane);
 void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,
 					struct drm_plane_state *plane_state);
 
 /**

-- 
2.55.0

