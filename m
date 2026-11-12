Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2369606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5eY6Dmf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD20D10FFE7;
	Thu, 12 Nov 2026 16:32:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C6D10FFE7
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:32:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31545461C0;
 Thu, 12 Nov 2026 16:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904B61F000CA;
 Thu, 12 Nov 2026 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794501150;
 bh=a1VYb6MsL+JSW1DwqEqj/dZl63o2jKzCqvcz/DQI2FE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=C5eY6Dmf1Lq+BjMlfwdhBP0U8MB42Jg3syqr979F8EB/y9L/R+7isFi5nLemCF1Pl
 TKXClpFgeiJQjYhYpfeHnLL4wAc/UKBiu9kaxyCqX5+O/TJPdo4MFbSR1nbFomqczm
 ZfT/uEofuZbNezGdxsYIgjITw6wLLAkVGX+87fO7pi0Dbah0X4ajNFM3ajyFZ7qzl8
 Bm4SxIqZ65ihP4JzUpF4ZayfWvfPSQH0uftaSTu3oeknmLdFBOcdteP4545625tED1
 AB7s7G3Sj7s52KN8U+JKV00Pc2ZYsk122Zu8UTEkbjE27ud6F5WNzA7Fnd/nIE76Jk
 3HRsyPqiSDEgA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 12 Nov 2026 17:31:57 +0100
Subject: [PATCH v10 8/9] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-drm-reset-state-flag-v10-8-cefaa1ed056d@kernel.org>
References: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
In-Reply-To: <20261112-drm-reset-state-flag-v10-0-cefaa1ed056d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9352; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zRcZQPMd6nz9iH0eYe7NsBIk4yySiW1DALC5u6v6k7g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlfXzFW+XRu9br78EIDw8T1x2uvcm7X/Ko5N7TJ5eTzu
 xlX1n2U6ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT+ZbD2PC5YdZMpbyH+37O
 2dnQvJ3NakFg5g2TCQc+7w4uuJyudirkw+IsY88Nkw8b+dy6k/QxeD5jQ2v2HZ1ne+/cbPoz45j
 mVzbnrkfXf31YY/X86uzFDt/T23Je74zYaHjvcyZr95rJ+7RL1wIA
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
 include/uapi/drm/drm_mode.h       | 22 +++++++++++++++++++-
 5 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 4fcce3bb0aa1..da3ac3367177 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1611,10 +1611,13 @@ EXPORT_SYMBOL(drm_atomic_get_new_bridge_state);
  * the current state.
  *
  * Color operations are not checked because they always use
  * drm_atomic_helper_colorop_create_state() and do not have a per-driver hook.
  *
+ * This is used to report the %DRM_CAP_ATOMIC_RESET capability to userspace,
+ * and as a precondition in drm_atomic_commit_fill_with_defaults().
+ *
  * Returns:
  * True if all objects implement atomic_create_state, false otherwise.
  */
 bool drm_atomic_implements_create_state(struct drm_device *dev)
 {
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05..fe6d8cc533bc 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1438,24 +1438,43 @@ static int prepare_signaling(struct drm_device *dev,
 	if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY)
 		return 0;
 
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
 
 			e = create_vblank_event(crtc, arg->user_data);
 			if (!e)
 				return -ENOMEM;
 
 			crtc_state->event = e;
 		}
 
-		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
+		if (page_flip_event) {
 			struct drm_pending_vblank_event *e = crtc_state->event;
 
 			ret = drm_event_reserve_init(dev, file_priv, &e->base,
 						     &e->event.base);
 			if (ret) {
@@ -1492,11 +1511,12 @@ static int prepare_signaling(struct drm_device *dev,
 			}
 
 			crtc_state->event->base.fence = fence;
 		}
 
-		c++;
+		if (page_flip_event)
+			c++;
 	}
 
 	for_each_new_connector_in_state(state, conn, conn_state, i) {
 		struct drm_writeback_connector *wb_conn;
 		struct drm_out_fence_state *f;
@@ -1671,10 +1691,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 		drm_dbg_atomic(dev,
 			       "commit failed: page-flip event requested with test-only commit\n");
 		return -EINVAL;
 	}
 
+	if ((arg->flags & DRM_MODE_ATOMIC_RESET) &&
+	    (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC)) {
+		drm_dbg_atomic(dev,
+			       "commit failed: reset cannot be combined with async flip\n");
+		return -EINVAL;
+	}
+
 	state = drm_atomic_commit_alloc(dev);
 	if (!state)
 		return -ENOMEM;
 
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
@@ -1686,10 +1713,21 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	copied_objs = 0;
 	copied_props = 0;
 	fence_state = NULL;
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
 		struct drm_mode_object *obj;
 
 		if (get_user(obj_id, objs_ptr + copied_objs)) {
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 9039a39c4324..f666a13da6bf 100644
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
@@ -302,10 +303,14 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 		break;
 	case DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP:
 		req->value = drm_core_check_feature(dev, DRIVER_ATOMIC) &&
 			     dev->mode_config.async_page_flip;
 		break;
+	case DRM_CAP_ATOMIC_RESET:
+		req->value = drm_core_check_feature(dev, DRIVER_ATOMIC) &&
+			     drm_atomic_implements_create_state(dev);
+		break;
 	default:
 		return -EINVAL;
 	}
 	return 0;
 }
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index bc7ef7684099..b6e2f2edd122 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -793,10 +793,20 @@ struct drm_gem_change_handle {
  * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC for atomic
  * commits.
  */
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
 	__u64 capability;
 	__u64 value;
 };
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index ed1a660a3dfd..571bb7c6804d 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -1326,10 +1326,29 @@ struct drm_mode_destroy_dumb {
  * To the best of the driver's knowledge, visual artifacts are guaranteed to
  * not appear when this flag is not set. Some sinks might display visual
  * artifacts outside of the driver's control.
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
+ * On a lease, only the objects part of that lease are reset. Partial
+ * pipelines aren't supported: if one of the leased planes or connectors
+ * is bound to a CRTC that isn't leased, or if a leased CRTC drives a
+ * plane or a connector that isn't, the commit fails with -ENOENT.
+ *
+ * This flag cannot be combined with &DRM_MODE_PAGE_FLIP_ASYNC.
+ */
+#define DRM_MODE_ATOMIC_RESET 0x0800
 
 /**
  * DRM_MODE_ATOMIC_FLAGS
  *
  * Bitfield of flags accepted by the &DRM_IOCTL_MODE_ATOMIC IOCTL in
@@ -1338,11 +1357,12 @@ struct drm_mode_destroy_dumb {
 #define DRM_MODE_ATOMIC_FLAGS (\
 		DRM_MODE_PAGE_FLIP_EVENT |\
 		DRM_MODE_PAGE_FLIP_ASYNC |\
 		DRM_MODE_ATOMIC_TEST_ONLY |\
 		DRM_MODE_ATOMIC_NONBLOCK |\
-		DRM_MODE_ATOMIC_ALLOW_MODESET)
+		DRM_MODE_ATOMIC_ALLOW_MODESET |\
+		DRM_MODE_ATOMIC_RESET)
 
 struct drm_mode_atomic {
 	__u32 flags;
 	__u32 count_objs;
 	__u64 objs_ptr;

-- 
2.56.0

