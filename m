Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AB606B810
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wp8Wt5fq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0207111271B;
	Fri, 30 Oct 2026 10:28:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE2D11270C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:28:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C64C743F1D;
 Fri, 30 Oct 2026 10:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C971F00A15;
 Fri, 30 Oct 2026 10:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356118;
 bh=KwoZ95bpvHODf/63+PHl3/81B2oAWSzOw276xKK+Ugc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Wp8Wt5fq4MTT8MQ1DXltiXZF8/IevynaWFt02BCMqc2xkvbIgr4v8/dtvW8lcE9IZ
 2T0BOOOJdySqnpOMMfe9jPi+n5DRjRy99ocNkqWEN4kPUMx/XzK1fEJzbRYV0qqpDm
 jI/KgDTDeurIhk05xZ2S073/I0djK5CGwkb7B/MKzJiUV4h8KbM8kXeFwZFMUMCfqS
 kDmwIsIaUbYWvnHIDzV/mMtJ9+1YeSxN/7AzGFxhcfNoxXWdfeC1WQrgp7aE85ujsa
 +0y74Pg2gVQaCiVM0SQ1PrqDd1Fw4YypM1hsQUG4SkdWtXdF8WvsWEHtGlaI/IYAsY
 GD+piO/GBshww==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 11:27:46 +0100
Subject: [PATCH v7 14/16] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-reset-state-flag-v7-14-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
In-Reply-To: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7053; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1bmsvKp4SagmrtjjvhX0gFa2fW9KcqjtQVArbwyJ5YI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPCmVL3+36ufys3ULBkz9tXjI8Eln08IpH1uVtO4pNF
 gpaTxaS6pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT8RZmbNjrKb8o5sOPgLwT
 zD9rUowzbk6vWjfLtnQty65ZN0WqniZXHBTR+r7IpDUvpVxguuiSR4wNc3IjvBtfeDCvWC+5W2W
 185ylLk/N+cUXbXCR2Dq/Md4zZ8dD2+QaFvezT3cJeQapXboAAA==
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
 drivers/gpu/drm/drm_ioctl.c       |  4 ++++
 include/uapi/drm/drm.h            | 10 +++++++++
 include/uapi/drm/drm_mode.h       | 17 ++++++++++++++-
 5 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 6bc0d6339f14..16530ce62455 100644
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
index 0dbf04d4aa9e..f666a13da6bf 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -306,4 +306,8 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
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

