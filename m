Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AB606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVhdw8fN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E33910FAC1;
	Fri,  6 Nov 2026 15:12:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894D210FA16
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:12:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B7DB601E3;
 Fri,  6 Nov 2026 15:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A251F008A4;
 Fri,  6 Nov 2026 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793977931;
 bh=jUxCKHB7+fBVHTnsYsB6ZbfY0/Bz21cq0o+BDmQtQw8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nVhdw8fNrMErDHBnN3JBywmVRTGgEij3D0JwNNcj7mZ9HzDpWsA0mEIKlLQUbF5e+
 DsZBi+xUMd8mXlpzwZ8CpKWw/0ctC2fKZvQ39ibsSOArG5za2nAdvId82DvdwlYrKH
 rbqbuZ4yjFbJvlhMLrUshB0GolHGJnyHzLcIvQthWV5k5AnSG0tY2pNtj0v/dR6/Gx
 U7auYdZAPG15jp3PWa25r4AP2bn7Ff0PPDuR5AWy3XqPeuPWubIedGDeIjw80UZMdm
 wIYwa8ZEJIL/KirntBMdpFzy5RlVwE9/g+Ih0vdsaDRcPc91/4NvtvUONmBWHlZxu8
 CWMejZxEYdKtA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 16:11:44 +0100
Subject: [PATCH v8 6/7] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-reset-state-flag-v8-6-50fd046b705f@kernel.org>
References: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
In-Reply-To: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7191; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qN9S7/ryMApPiWW8h1pj3QBolp+BnRivfHLc+Q3dZGE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlv3xmq3z55fMHeH/+eye6UeZvZl3oiwybV8sqzk4VnZ
 nrMy51U3DGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmkt3H2PDliobSBxObwz46
 ZjzKq+8a/Tjk9eJ6o/4Nr/sa7O67zO+6reXTsuuTaErp2nXzzrapUowNvUpHOm2sH0+Qqblqvj1
 6bpACe9uC8lXm6aGntWtYFfVKVQ3XnjI6fOrYFHaeBbXb9j0BAA==
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

From: Sebastian Wick <sebastian.wick@redhat.com>

Userspace currently has no atomic way to reset all KMS object states
to their defaults. To bring a display pipeline to a known state, a
compositor must explicitly set every property on every object, which
requires tracking which properties exist and what their defaults are.

Introduce DRM_MODE_ATOMIC_RESET (0x0800) which, when passed to the
atomic ioctl, fills the commit with default states for all KMS
objects before applying the properties supplied in the request.
Properties not explicitly included in the commit remain at their
defaults (CRTCs inactive, planes disabled, connectors unbound, and
so on).

The flag cannot be combined with DRM_MODE_PAGE_FLIP_ASYNC, since a
full state reset is incompatible with an async flip.

Since the commit contains every CRTC of the device or lease, including
the ones that are disabled before and after it, no page flip event is
attached to those: they can't report a flip, and drm_atomic_crtc_check()
would reject the whole commit. Such a CRTC doesn't count towards the
CRTCs that can signal either, so a commit that leaves them all disabled
while asking for an event is still rejected instead of waiting for an
event that would never come.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
Co-developed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c      |  3 +++
 drivers/gpu/drm/drm_atomic_uapi.c | 44 ++++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/drm_ioctl.c       |  5 +++++
 include/uapi/drm/drm.h            | 10 +++++++++
 include/uapi/drm/drm_mode.h       | 17 ++++++++++++++-
 5 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 8bda2871f394..bb5b8e527fcf 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1614,4 +1614,7 @@ EXPORT_SYMBOL(drm_atomic_get_new_bridge_state);
  * drm_atomic_helper_colorop_create_state() and do not have a per-driver hook.
  *
+ * This is used to report the %DRM_CAP_ATOMIC_RESET capability to userspace,
+ * and as a precondition in drm_atomic_commit_fill_with_defaults().
+ *
  * Returns:
  * True if all objects implement atomic_create_state, false otherwise.
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05..77d0713c7e2d 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1441,8 +1441,27 @@ static int prepare_signaling(struct drm_device *dev,
 	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
 		s32 __user *fence_ptr;
+		bool page_flip_event;
 
 		fence_ptr = get_out_fence_for_crtc(crtc_state->state, crtc);
 
-		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT || fence_ptr) {
+		page_flip_event = arg->flags & DRM_MODE_PAGE_FLIP_EVENT;
+
+		/*
+		 * A commit with the DRM_MODE_ATOMIC_RESET flag contains
+		 * every CRTC of the device or lease, even the ones that are
+		 * disabled before and after the commit. Those can't report
+		 * a page flip, and drm_atomic_crtc_check() would reject the
+		 * whole commit, so don't attach any event to them.
+		 */
+		if (page_flip_event && !fence_ptr &&
+		    (arg->flags & DRM_MODE_ATOMIC_RESET) &&
+		    !crtc_state->active) {
+			struct drm_crtc_state *old_crtc_state;
+
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
+			page_flip_event = old_crtc_state->active;
+		}
+
+		if (page_flip_event || fence_ptr) {
 			struct drm_pending_vblank_event *e;
 
@@ -1454,5 +1473,5 @@ static int prepare_signaling(struct drm_device *dev,
 		}
 
-		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
+		if (page_flip_event) {
 			struct drm_pending_vblank_event *e = crtc_state->event;
 
@@ -1495,5 +1514,6 @@ static int prepare_signaling(struct drm_device *dev,
 		}
 
-		c++;
+		if (page_flip_event)
+			c++;
 	}
 
@@ -1674,4 +1694,11 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	}
 
+	if ((arg->flags & DRM_MODE_ATOMIC_RESET) &&
+			(arg->flags & DRM_MODE_PAGE_FLIP_ASYNC)) {
+		drm_dbg_atomic(dev,
+			       "commit failed: reset cannot be combined with async flip\n");
+		return -EINVAL;
+	}
+
 	state = drm_atomic_commit_alloc(dev);
 	if (!state)
@@ -1689,4 +1716,15 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	num_fences = 0;
 
+	if (arg->flags & DRM_MODE_ATOMIC_RESET) {
+		if (!drm_atomic_implements_create_state(dev)) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		ret = drm_atomic_commit_fill_with_defaults(file_priv, state);
+		if (ret)
+			goto out;
+	}
+
 	for (i = 0; i < arg->count_objs; i++) {
 		uint32_t obj_id, count_props;
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 9039a39c4324..f666a13da6bf 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -34,4 +34,5 @@
 #include <linux/uaccess.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_auth.h>
 #include <drm/drm_crtc.h>
@@ -305,4 +306,8 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 			     dev->mode_config.async_page_flip;
 		break;
+	case DRM_CAP_ATOMIC_RESET:
+		req->value = drm_core_check_feature(dev, DRIVER_ATOMIC) &&
+			     drm_atomic_implements_create_state(dev);
+		break;
 	default:
 		return -EINVAL;
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index bc7ef7684099..b6e2f2edd122 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -796,4 +796,14 @@ struct drm_gem_change_handle {
 #define DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP	0x15
 
+/**
+ * DRM_CAP_ATOMIC_RESET
+ *
+ * If set to 1, the driver supports the &DRM_MODE_ATOMIC_RESET flag in
+ * &DRM_IOCTL_MODE_ATOMIC commits. When supported, userspace can pass that
+ * flag to reset all KMS object states to their defaults before applying
+ * property changes.
+ */
+#define DRM_CAP_ATOMIC_RESET	0x16
+
 /* DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index ed1a660a3dfd..1ab5c0fb3804 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -1329,4 +1329,18 @@ struct drm_mode_destroy_dumb {
  */
 #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400
+/**
+ * DRM_MODE_ATOMIC_RESET
+ *
+ * Reset all KMS object states (CRTCs, planes, connectors, color operations)
+ * to their default values before applying the properties in this commit.
+ * Properties not explicitly included in the commit will remain at their
+ * defaults (CRTCs inactive, planes disabled, connectors unbound, etc.).
+ *
+ * CRTCs that are disabled before and after the commit won't send any
+ * &DRM_MODE_PAGE_FLIP_EVENT.
+ *
+ * This flag cannot be combined with &DRM_MODE_PAGE_FLIP_ASYNC.
+ */
+#define DRM_MODE_ATOMIC_RESET 0x0800
 
 /**
@@ -1341,5 +1355,6 @@ struct drm_mode_destroy_dumb {
 		DRM_MODE_ATOMIC_TEST_ONLY |\
 		DRM_MODE_ATOMIC_NONBLOCK |\
-		DRM_MODE_ATOMIC_ALLOW_MODESET)
+		DRM_MODE_ATOMIC_ALLOW_MODESET |\
+		DRM_MODE_ATOMIC_RESET)
 
 struct drm_mode_atomic {

-- 
2.55.0

