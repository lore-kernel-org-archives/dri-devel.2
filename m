Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEBBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB77810F1C1;
	Wed,  8 Jul 2026 16:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GlRdjukd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D268A10F1C1
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:09:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53D2360008;
 Wed,  8 Jul 2026 16:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B981F000E9;
 Wed,  8 Jul 2026 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783526950;
 bh=d0gFAqHdkcz/DkcLNQqPxrqVc3f8gzllG+y1ErzsxJo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GlRdjukdQ4XGf4kYnYdoNKqabIvrA1bfQCmNtAR66fnVnSeXdQbXKeKLjHqZIMGus
 /xOs994uP6PUP7sLXWdyMz24dzzFRt499WQEIWLmKhgW4yn0G/14qWoBixSXoIhvCQ
 A5SOKNUHddf+qFYX223g0mmOnWI8SnL+r66udcda1W2ABsuseinbJ9WgwmI/AmlKxu
 8FmEEFHqzJAdg+oMNkkfsep3bZj7B4p5gxW4f2/sa9RDhVTgzIwEmslhMwqBh8LuA2
 qOb9y0xp6x55iFWSxUfivtJmWyoKQLSYL6nFq45ePVZVeJKp93bR842gaIFvM3ObTt
 OtsJzh0dj340w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 08 Jul 2026 18:08:45 +0200
Subject: [PATCH RFC 8/8] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-drm-reset-state-flag-v1-8-c37dc985485d@kernel.org>
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
In-Reply-To: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qNsLZcKnpU5JSggILRFdVhUYrRG/Qw8F+WUmBgIv5aw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl+ZQK5T993uk5pexydIzWbW+Dz4TcKFg+nlCop967/E
 3gpufBdx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjI3HTG+kTRWzedHq60X3V/
 ej/HwrQE8/m7F+ka3T50MHTKraC+KpEoEd4L678b1YVbpf7ZoaBeydjwwbGd88fif9c8gzkY319
 8sP3f+waeu0xWv1OYX9dUt8+4pc79Idv5/fwN20oLH0ZoBLkDAA==
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

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
Co-developed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 13 +++++++++++++
 include/uapi/drm/drm_mode.h       | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1050dddadb17..cdcc6efb9a00 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1658,10 +1658,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 		drm_dbg_atomic(dev,
 			       "commit failed: page-flip event requested with test-only commit\n");
 		return -EINVAL;
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
 		return -ENOMEM;
 
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
@@ -1673,10 +1680,16 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	copied_objs = 0;
 	copied_props = 0;
 	fence_state = NULL;
 	num_fences = 0;
 
+	if (arg->flags & DRM_MODE_ATOMIC_RESET) {
+		ret = drm_atomic_commit_fill_with_defaults(state);
+		if (ret)
+			goto out;
+	}
+
 	for (i = 0; i < arg->count_objs; i++) {
 		uint32_t obj_id, count_props;
 		struct drm_mode_object *obj;
 
 		if (get_user(obj_id, objs_ptr + copied_objs)) {
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index bd435effdcee..43024028f695 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -1314,10 +1314,21 @@ struct drm_mode_destroy_dumb {
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
+ * This flag cannot be combined with &DRM_MODE_PAGE_FLIP_ASYNC.
+ */
+#define DRM_MODE_ATOMIC_RESET 0x0800
 
 /**
  * DRM_MODE_ATOMIC_FLAGS
  *
  * Bitfield of flags accepted by the &DRM_IOCTL_MODE_ATOMIC IOCTL in
@@ -1326,11 +1337,12 @@ struct drm_mode_destroy_dumb {
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
2.54.0

