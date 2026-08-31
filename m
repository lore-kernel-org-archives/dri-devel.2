Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC9FC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E37B10E95E;
	Mon, 31 Aug 2026 15:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KgVsWauA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61A910E958
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:35:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A8AC60200;
 Mon, 31 Aug 2026 15:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6343C1F000E9;
 Mon, 31 Aug 2026 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190515;
 bh=RHUjuGOmjzSwkBTtkt2vu0tIj9ljYL5+WlpLguz9Jms=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KgVsWauAiS932WcBziSICJH4LOLEuqTa036X0TGz/j78tS/3AKvQfLFW8+udw3y6A
 ez1MTMX/6JrS8P1Y+/M0DOSGdoJNll/SZB0Q9IMJ1GXm9/UxiRhsCHZVBzVV8nM2aL
 dmfB4iP+m4m0vKHbUPNwA3sEm4wFkBTsvYtvFk3u/z33PYWORw2pYYwmBXYh5JqoXY
 LSo8z5dyfxNsX6oL5PuWn7eDzeaKulkfHlZ58/d8IxzRObdHzAvBKs4zqqbFhThOKF
 aRwM12KXT6ViKBIU3jOIJBoVAcu1c9Ukc+S9jO4Nw+L68a5etBHuPayIaI5K7M3kXZ
 euqiwh+5SYnmA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 17:34:25 +0200
Subject: [PATCH v2 12/13] drm/atomic-helper: Remove
 __drm_atomic_helper_crtc_reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-crtc-reset-v2-12-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2752; i=mripard@kernel.org;
 h=from:subject:message-id; bh=LTnMlYcfRnOHw3r2Ut2QzZCjT9yEjV8CR50b3SFFMKU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlT5zNs+SGr3u0owKk8LWndVE3t73OPP8jRMwg/ISBd2
 PUx+Wdcx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIyQTGhrWbOvPCGndXfbC7
 0yCTccOZYU3Ys7Zrhv4frrTuvWbDPEutxWSH3/qiKas2Pfxxlf+JIGPDwztHqp7Gb5l1znKW13E
 usf9hnG07bs18cGLjlHWpMfKMwh+2iAnOLZ3U0G1lme7WWtEMAA==
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

All users of __drm_atomic_helper_crtc_reset() have been converted to use
drm_atomic_helper_crtc_state_init() and atomic_create_state.

Remove the now unused helper.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 26 --------------------------
 include/drm/drm_atomic_state_helper.h     |  2 --
 2 files changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index b592b7f5f264..354fa9c6aca8 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -77,36 +77,10 @@ __drm_atomic_helper_crtc_state_init(struct drm_crtc_state *crtc_state,
 	crtc_state->crtc = crtc;
 	crtc_state->background_color = DRM_ARGB64_PREP(0xffff, 0, 0, 0);
 }
 EXPORT_SYMBOL(__drm_atomic_helper_crtc_state_init);
 
-/**
- * __drm_atomic_helper_crtc_reset - reset state on CRTC
- * @crtc: drm CRTC
- * @crtc_state: CRTC state to assign
- *
- * Initializes the newly allocated @crtc_state and assigns it to
- * the &drm_crtc->state pointer of @crtc, usually required when
- * initializing the drivers or when called from the &drm_crtc_funcs.reset
- * hook.
- *
- * This is useful for drivers that subclass the CRTC state.
- */
-void
-__drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
-			       struct drm_crtc_state *crtc_state)
-{
-	if (crtc_state)
-		__drm_atomic_helper_crtc_state_init(crtc_state, crtc);
-
-	if (drm_dev_has_vblank(crtc->dev))
-		drm_crtc_vblank_reset(crtc);
-
-	crtc->state = crtc_state;
-}
-EXPORT_SYMBOL(__drm_atomic_helper_crtc_reset);
-
 /**
  * drm_atomic_helper_crtc_create_state - default &drm_crtc_funcs.atomic_create_state hook for crtcs
  * @crtc: crtc object
  *
  * Allocates and  initializes pristine @drm_crtc_state.
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index df70817c94fc..480eaae42f45 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -40,12 +40,10 @@ struct drm_private_state;
 struct drm_modeset_acquire_ctx;
 struct drm_device;
 
 void __drm_atomic_helper_crtc_state_init(struct drm_crtc_state *state,
 					  struct drm_crtc *crtc);
-void __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
-				    struct drm_crtc_state *state);
 struct drm_crtc_state *
 drm_atomic_helper_crtc_create_state(struct drm_crtc *crtc);
 void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,
 					      struct drm_crtc_state *state);
 struct drm_crtc_state *

-- 
2.55.0

