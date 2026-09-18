Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDA5C982E0
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E761210F3D3;
	Fri, 18 Sep 2026 14:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SEgeU/Hn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC89A10F3C8
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:18:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9468D43D93;
 Fri, 18 Sep 2026 14:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0D41F000FF;
 Fri, 18 Sep 2026 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789741119;
 bh=XS3XWsQS/wsJtDoSQO+mZMWhw7DtPyBFXXLY/FPwBKQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SEgeU/HnYxhDq5V1fO8AS+IuEcp0vYFEr9p9DXDBIHAeE4XesjOMgUkzj35OsPhr5
 rL2truSuMKBXLNs3CDla6u4QbEI9+w7MiMo/2sDP5vh3BbQxaiWirnjCCNdE8DhRRO
 EgwyFG5tnPyRglSa5X+rtgaLmqYPBjwvLMViGgS/8DLvwaBOAcX6RXkNwZW1SZHZyd
 zcf9a7NG7uxGV5iDHSUmIAbxkAxE7wG9NQqEEnn5FHtAFhT3vJwO8Y7yaMA4etVzUa
 STejFyRM+Uuo/QCsOh4lBHgEsQoi7SvZi1Ogad0B292RpFKFTDvcfXu3aTX4rZCjdG
 jqHrDp1SW8nlQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 18 Sep 2026 16:17:59 +0200
Subject: [PATCH v4 10/13] drm/atomic: Allow filling a commit with pristine
 object states
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-drm-reset-state-flag-v4-10-5ad106370f05@kernel.org>
References: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
In-Reply-To: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6028; i=mripard@kernel.org;
 h=from:subject:message-id; bh=inWTgkDtp0vChZ9VKuHwhKGj/PyO3yywRvlVuv2aAuM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlrPYTjFF9ZagTnT2eXnnfP8HyvOHdUg2SHcU56WlTfk
 tL/M9s6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwEQuGDM2PGeJVuX54uanYXhO
 cYYr0/5La7QYGjO2NPyNXf9mr9TZl4e80kV/nf27rHP1gnNZRaf+M9apJzBHrypfcE1Z/OGxOXe
 vHFwo96dSepJ39vrwTtdfSZbtb5fsDDzGnvjwNkuz9pH3bsEA
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

The upcoming DRM_MODE_ATOMIC_RESET flag will need to create an atomic
commit that brings the entire device back to a pristine state, as if
no configuration had ever been applied.

Create drm_atomic_commit_fill_with_defaults() which iterates over all
CRTCs, planes, connectors, and color operations in the device and
inserts a fresh default state for each one into the commit. This uses
the atomic_create_state() hooks rather than atomic_duplicate_state(),
since atomic_create_state() provides exactly this pristine state on a
per-object basis.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 108 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_ioctl.c  |   1 +
 include/drm/drm_atomic.h     |   3 +-
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 7a77051096c9..b039edaa3271 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1647,10 +1647,118 @@ bool drm_atomic_implements_create_state(struct drm_device *dev)
 
 	return true;
 }
 EXPORT_SYMBOL(drm_atomic_implements_create_state);
 
+/**
+ * drm_atomic_commit_fill_with_defaults - populate a commit with pristine states
+ * @commit: atomic commit to fill
+ *
+ * Iterate over all CRTCs, planes, connectors, and color operations in
+ * the device and insert a freshly created default state for each one
+ * into @commit. The states are created through the atomic_create_state()
+ * hooks, producing the same initial state the driver starts with rather
+ * than a copy of the current hardware state.
+ *
+ * This is meant to be used with the %DRM_MODE_ATOMIC_RESET flag, which
+ * needs to bring the device back to a known baseline before applying
+ * userspace property changes on top.
+ *
+ * Returns:
+ * 0 on success, or a negative error code on failure.
+ */
+int drm_atomic_commit_fill_with_defaults(struct drm_atomic_commit *commit)
+{
+	struct drm_device *dev = commit->dev;
+	struct drm_mode_config *config = &dev->mode_config;
+	struct drm_crtc *crtc;
+	struct drm_plane *plane;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	struct drm_colorop *colorop;
+	int ret;
+
+	drm_WARN_ON(dev, !commit->acquire_ctx);
+
+	/*
+	 * Private objects are ignored because none have userspace
+	 * properties we might want to reset. atomic_check
+	 * implementations will derive or infer their private obj state
+	 * from the state that will end up being committed anyway.
+	 */
+	drm_for_each_colorop(colorop, dev) {
+		struct drm_colorop_state *colorop_state;
+
+		ret = drm_modeset_lock(&colorop->plane->mutex, commit->acquire_ctx);
+		if (ret)
+			return ret;
+
+		colorop_state = drm_atomic_helper_colorop_create_state(colorop);
+		if (IS_ERR(colorop_state))
+			return PTR_ERR(colorop_state);
+
+		drm_atomic_commit_set_colorop_state(commit, colorop, colorop_state);
+	}
+
+	drm_for_each_plane(plane, dev) {
+		struct drm_plane_state *plane_state;
+
+		ret = drm_modeset_lock(&plane->mutex, commit->acquire_ctx);
+		if (ret)
+			return ret;
+
+		plane_state = plane->funcs->atomic_create_state(plane);
+		if (IS_ERR(plane_state))
+			return PTR_ERR(plane_state);
+
+		drm_atomic_commit_set_plane_state(commit, plane, plane_state);
+	}
+
+	drm_for_each_crtc(crtc, dev) {
+		struct drm_crtc_state *crtc_state;
+
+		ret = drm_modeset_lock(&crtc->mutex, commit->acquire_ctx);
+		if (ret)
+			return ret;
+
+		crtc_state = crtc->funcs->atomic_create_state(crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+
+		drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
+	}
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		struct drm_connector_state *connector_state;
+
+		ret = drm_modeset_lock(&config->connection_mutex, commit->acquire_ctx);
+		if (ret) {
+			drm_connector_list_iter_end(&conn_iter);
+			return ret;
+		}
+
+		connector_state = connector->funcs->atomic_create_state(connector);
+		if (IS_ERR(connector_state)) {
+			drm_connector_list_iter_end(&conn_iter);
+			ret = PTR_ERR(connector_state);
+			return ret;
+		}
+
+		ret = drm_atomic_commit_set_connector_state(commit, connector, connector_state);
+		if (ret) {
+			connector->funcs->atomic_destroy_state(connector, connector_state);
+			drm_connector_list_iter_end(&conn_iter);
+			return ret;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_commit_fill_with_defaults);
+
 /**
  * drm_atomic_add_encoder_bridges - add bridges attached to an encoder
  * @state: atomic state
  * @encoder: DRM encoder
  *
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 9039a39c4324..0dbf04d4aa9e 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -31,10 +31,11 @@
 #include <linux/export.h>
 #include <linux/nospec.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_auth.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_ioctl.h>
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 94356566a514..841a11ee2fda 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -700,11 +700,12 @@ int drm_crtc_commit_wait(struct drm_crtc_commit *commit);
 
 struct drm_atomic_commit * __must_check
 drm_atomic_commit_alloc(struct drm_device *dev);
 void drm_atomic_commit_clear(struct drm_atomic_commit *state);
 
-bool drm_atomic_can_create_state(struct drm_device *dev);
+bool drm_atomic_implements_create_state(struct drm_device *dev);
+int drm_atomic_commit_fill_with_defaults(struct drm_atomic_commit *commit);
 
 /**
  * drm_atomic_commit_get - acquire a reference to the atomic state
  * @state: The atomic state
  *

-- 
2.55.0

