Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29395FB5E85
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 22:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFC010E32E;
	Mon, 16 Mar 2026 22:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KqnrA94u";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7988B10E32E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773701846; x=1805237846;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hzr5V9aWFKluKTyKzmGtoL+ier8qy93welbv7OjWpO8=;
 b=KqnrA94uuhGwEb6zJoICpAwCzYdBdnhB5Kw21gHkkMpFoGFoNhHmKk8L
 R/alwOPhUhue9o6XnEVWJk6r5G960B8r3I+i+lJz3+zHHpI7h3lTlKFyH
 dSrMJPL7PHMLsvSQ/Rxh/XAO7Xzy8ixiJpET4HSxIHYTmYkRRBzH7l+8D
 KW9cHnWnJ8TKOerlAn0ipRUtBMAiRIjMTR67iRy1oIjqHraQguGtq7/ES
 /ZKj9SauGIxyU8yXJNM2EZjOsBh5IwpGw0fp1/VXFjOTzSA5lhm1S4e1J
 i+fAqHlc+F285sxsc9IGVarzUiWNkYCXkud32PJ14ikBwxBphkzRp+EpY Q==;
X-CSE-ConnectionGUID: COkw8HGQQQqtNF68kCBr3A==
X-CSE-MsgGUID: G3R4yzO6R0yrzBoUNxxmkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="77338761"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="77338761"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 15:57:26 -0700
X-CSE-ConnectionGUID: xaJmKbKxQOCkJT70DQQquw==
X-CSE-MsgGUID: ywa4S+EKSZqZ3sI+XiLdvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="227047812"
Received: from chu13-desk.fm.intel.com ([10.80.209.210])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 15:57:26 -0700
From: Austin Hu <austin.hu@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, ville.syrjala@linux.intel.com,
 robin.clark@oss.qualcomm.com
Subject: [PATCH] drm/atomic: clear the state of plane which is unused.
Date: Mon, 16 Mar 2026 15:55:07 -0700
Message-Id: <20260316225507.392191-1-austin.hu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some libdrm user mode apps (including compositor) disable unused
plane with its previously binded CRTC or frame buffer object, but
may not reset its properties like src/dst coordinates, so that some
values of the unused plane state would be sticky. And even with
some Display Engine IP like Intel, a plane disabled from user mode
in current frame may be linked with another plane (e.g. to DMA Y or
UV semi-planar buffer) in KMD driver, so that its sticky UAPI
settings mismatch with the ones programmed to registers.

So clear the unused plane state during each atomic commit, to make
sure each plane state is up to date. This change might be
unnecessary if user mode already clears plane property, but keep it
just in case.

Signed-off-by: Austin Hu <austin.hu@intel.com>
---
 drivers/gpu/drm/drm_atomic.c | 62 ++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index dd9f27cfe991..0ce57e540a86 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -690,6 +690,59 @@ plane_switching_crtc(const struct drm_plane_state *old_plane_state,
 	return true;
 }
 
+/**
+ * drm_atomic_plane_state_reset - reset plane state
+ * @plane: plane to reset
+ * @plane_state: plane state to reset
+ *
+ * This function resets the plane state to its default values, after
+ * the plane is disabled or when the plane state is no longer valid.
+ */
+static int drm_atomic_plane_state_reset(struct drm_plane *plane,
+				      struct drm_plane_state *plane_state)
+{
+	int ret;
+
+	ret = drm_atomic_set_crtc_for_plane(plane_state, NULL);
+	if (ret != 0)
+		return ret;
+
+	drm_atomic_set_fb_for_plane(plane_state, NULL);
+
+	plane_state->crtc_x = 0;
+	plane_state->crtc_y = 0;
+	plane_state->crtc_w = 0;
+	plane_state->crtc_h = 0;
+	plane_state->src_x = 0;
+	plane_state->src_y = 0;
+	plane_state->src_w = 0;
+	plane_state->src_h = 0;
+
+	plane_state->alpha = 0;
+	plane_state->pixel_blend_mode = 0;
+	plane_state->rotation = 0;
+	plane_state->zpos = 0;
+	plane_state->color_encoding = 0;
+	plane_state->color_range = 0;
+
+	drm_atomic_set_colorop_for_plane(plane_state, NULL);
+
+	bool replaced = false;
+
+	ret = drm_property_replace_blob_from_id(
+		plane->dev, &plane_state->fb_damage_clips, 0, -1, -1,
+		sizeof(struct drm_mode_rect), &replaced);
+	if (ret)
+		return ret;
+
+	plane_state->scaling_filter = 0;
+	plane_state->hotspot_x = 0;
+	plane_state->hotspot_y = 0;
+	plane_state->visible = false;
+
+	return 0;
+}
+
 /**
  * drm_atomic_plane_check - check plane state
  * @old_plane_state: old plane state to check
@@ -701,7 +754,7 @@ plane_switching_crtc(const struct drm_plane_state *old_plane_state,
  * Zero on success, error code on failure
  */
 static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
-				  const struct drm_plane_state *new_plane_state)
+				  struct drm_plane_state *new_plane_state)
 {
 	struct drm_plane *plane = new_plane_state->plane;
 	struct drm_crtc *crtc = new_plane_state->crtc;
@@ -721,9 +774,12 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
 		return -EINVAL;
 	}
 
-	/* if disabled, we don't care about the rest of the state: */
+	/*
+	 * if disabled, we don't care about the rest of the state:
+	 * but clear the plane state.
+	 */
 	if (!crtc)
-		return 0;
+		return drm_atomic_plane_state_reset(plane, new_plane_state);
 
 	/* Check whether this plane is usable on this CRTC */
 	if (!(plane->possible_crtcs & drm_crtc_mask(crtc))) {
-- 
2.34.1

