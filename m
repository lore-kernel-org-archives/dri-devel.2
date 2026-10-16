Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC91CCCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2A6112655;
	Fri, 16 Oct 2026 07:32:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C8411263A
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:32:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83AE5447AC;
 Fri, 16 Oct 2026 07:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEAF1F000C4;
 Fri, 16 Oct 2026 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792135952;
 bh=kDbIcMvLHjcq2nNU9jCRqVR9NE5rMqWKY2kqh9rCQ3k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GJ6oC91T4JLiDrG2QoNNJPaihT9xwjFaaKdUrQ/Ig/G0d0ggRXzI7OWXbuhVooVBk
 ReenKjX8piN7gTD0CLdbsyAtWJ3fFpyjUvZ9i0wL7pUDCGJL/LAhGkgSTbtwNqGw3M
 tcv7jPgtZOBnlsj4WARZmM6d0MCmozPwbfPMXW19/+LS3lle1XsiV17bEDJut7d43c
 8bHkwPMjGVVW0ylgKoKngs6fftL5mnFX3e0ghQ+tlAVkbBOr48aWwxEIfGKQroooh/
 Mt2pjLMwVnapZEWmoRK4ttSKxTRAwGmgpOaCUyXqxLoDQKsA+wpu2k1p3HPM8TAShe
 XtJScXR7EVoBA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 16 Oct 2026 09:31:41 +0200
Subject: [PATCH v5 09/14] drm/atomic: Add
 drm_atomic_implements_create_state() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-drm-reset-state-flag-v5-9-dad2d64b693b@kernel.org>
References: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
In-Reply-To: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3638; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/07gNicTK2lgKQTWtWxaOFgOZdFvu/uP7c9E5nD3b9c=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkXLz2xK0n/E7vh3SQ/p/jtgTMvfQjwPGt4MPr1PtbnM
 dsOZ/w53DGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmcn06Y61Y6B2/1pzKhw4t
 lgbHJj49brxDaErsg0DTY8rhWuLC/IUVOQWsK7p0XmjMCLt68+1NZcaGbWmmp51Mbk+2Pzqr+vE
 Ry5TJ9rFz2Ry/xfqLSnRNu7UmXHDqj+znpZUL9RL/GF/itVwHAA==
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

The atomic reset path will need to create pristine default states from
scratch for every plane, CRTC, and connector. This requires all of them
to implement the atomic_create_state hook.

Introduce a drm_atomic_implements_create_state() helper that iterates
over all planes, CRTCs, and connectors and returns whether they all
provide the hook. Color operations are excluded since they always use
drm_atomic_helper_colorop_create_state() directly.

This will be used both as a precondition before filling a commit with
default states, and to report the device capability to userspace.

Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h     |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 81591173265d..7a77051096c9 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1598,10 +1598,59 @@ drm_atomic_get_new_bridge_state(const struct drm_atomic_commit *state,
 
 	return drm_priv_to_bridge_state(obj_state);
 }
 EXPORT_SYMBOL(drm_atomic_get_new_bridge_state);
 
+/**
+ * drm_atomic_implements_create_state - check if a device supports creating pristine states
+ * @dev: DRM device
+ *
+ * Check whether every plane, CRTC, and connector in @dev implements the
+ * &drm_plane_funcs.atomic_create_state, &drm_crtc_funcs.atomic_create_state,
+ * and &drm_connector_funcs.atomic_create_state hooks respectively. These hooks
+ * are required to create default states from scratch rather than duplicating
+ * the current state.
+ *
+ * Color operations are not checked because they always use
+ * drm_atomic_helper_colorop_create_state() and do not have a per-driver hook.
+ *
+ * Returns:
+ * True if all objects implement atomic_create_state, false otherwise.
+ */
+bool drm_atomic_implements_create_state(struct drm_device *dev)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+
+	/*
+	 * colorops don't have an atomic_create_state hook but
+	 * drm_atomic_helper_colorop_create_state()
+	 */
+
+	drm_for_each_plane(plane, dev)
+		if (!plane->funcs->atomic_create_state)
+			return false;
+
+	drm_for_each_crtc(crtc, dev)
+		if (!crtc->funcs->atomic_create_state)
+			return false;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (!connector->funcs->atomic_create_state) {
+			drm_connector_list_iter_end(&conn_iter);
+			return false;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return true;
+}
+EXPORT_SYMBOL(drm_atomic_implements_create_state);
+
 /**
  * drm_atomic_add_encoder_bridges - add bridges attached to an encoder
  * @state: atomic state
  * @encoder: DRM encoder
  *
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..72c3d420f40c 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -700,10 +700,12 @@ int drm_crtc_commit_wait(struct drm_crtc_commit *commit);
 
 struct drm_atomic_commit * __must_check
 drm_atomic_commit_alloc(struct drm_device *dev);
 void drm_atomic_commit_clear(struct drm_atomic_commit *state);
 
+bool drm_atomic_implements_create_state(struct drm_device *dev);
+
 /**
  * drm_atomic_commit_get - acquire a reference to the atomic state
  * @state: The atomic state
  *
  * Returns a new reference to the @state

-- 
2.55.0

