Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8D3C624D0
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2478610E959;
	Mon, 31 Aug 2026 15:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="edguSmqo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28F810E955
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:34:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA2FF40C26;
 Mon, 31 Aug 2026 15:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146D91F000E9;
 Mon, 31 Aug 2026 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190492;
 bh=bRQY7cJ4XRb/qFjibqZxc9M8AxUwTbGZeHLUJFnrnA4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=edguSmqo6vq3hQKfhiruMQZZBt2LWwqW8WaksjT2cWsQsnAvaLZ0r317u/yLyD0wS
 f/DL0hVRtHQNYm/2hag5hsOCWaEDIFAD8xGDBn8+/oX0bv0zh1IseEshpOtnDPSjpK
 gzSzCtEMjEZL32hxWvJZ3/04kqOeB+qMlglc82kB/SAsIkgX6YO8vsE2irts824bOI
 UGkmhb2G9W9t6ijre2HhuyFImI9E5dkL5izvS38cVmUBZjOHJMLRRHORnokQDA55ol
 WYHzHfBjerp3rlXVml5gTmXrEbHNR/8L0UgVphAVDGgD2imsfbqcyb4I5xZZkJoHo7
 3jRsMsj0uv6xg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 17:34:19 +0200
Subject: [PATCH v2 06/13] drm/atomic-helper: Remove
 drm_atomic_helper_crtc_reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-crtc-reset-v2-6-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3052; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xhmtv7h5xi6tMJ9KwEUKj/biSVJ/xc3vmWbu0M8bW3c=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlT5/1tefSxsCW1SKvx1ZRpzobtC22/TNpp3rqfmS/G9
 PNUdj/9jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRz8cZG7p3s8wpCpS49WNX
 ReTOBY2HeO0uLtxj8u7Muk6bYx2mlwuiJZx2aHPxz5Gpvj3ry930RMZ6l4ZJb7InrZW/ajTVcdO
 8jB6+PbOt29lip5Qe0V55SGrfrK0mmS2ZdcblnJe13oWL9mgDAA==
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

All users of drm_atomic_helper_crtc_reset() have been converted to
drm_atomic_helper_crtc_create_state().

Remove the now unused helper.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 19 -------------------
 include/drm/drm_atomic_state_helper.h     |  1 -
 include/drm/drm_crtc.h                    |  2 --
 3 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index d90d1d7c9cf9..b592b7f5f264 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -103,29 +103,10 @@ __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
 
 	crtc->state = crtc_state;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_crtc_reset);
 
-/**
- * drm_atomic_helper_crtc_reset - default &drm_crtc_funcs.reset hook for CRTCs
- * @crtc: drm CRTC
- *
- * Resets the atomic state for @crtc by freeing the state pointer (which might
- * be NULL, e.g. at driver load time) and allocating a new empty state object.
- */
-void drm_atomic_helper_crtc_reset(struct drm_crtc *crtc)
-{
-	struct drm_crtc_state *crtc_state =
-		kzalloc_obj(*crtc->state);
-
-	if (crtc->state)
-		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
-
-	__drm_atomic_helper_crtc_reset(crtc, crtc_state);
-}
-EXPORT_SYMBOL(drm_atomic_helper_crtc_reset);
-
 /**
  * drm_atomic_helper_crtc_create_state - default &drm_crtc_funcs.atomic_create_state hook for crtcs
  * @crtc: crtc object
  *
  * Allocates and  initializes pristine @drm_crtc_state.
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 34a599c3d86d..df70817c94fc 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -42,11 +42,10 @@ struct drm_device;
 
 void __drm_atomic_helper_crtc_state_init(struct drm_crtc_state *state,
 					  struct drm_crtc *crtc);
 void __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
 				    struct drm_crtc_state *state);
-void drm_atomic_helper_crtc_reset(struct drm_crtc *crtc);
 struct drm_crtc_state *
 drm_atomic_helper_crtc_create_state(struct drm_crtc *crtc);
 void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,
 					      struct drm_crtc_state *state);
 struct drm_crtc_state *
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 152349f973e3..12f43253f059 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -428,12 +428,10 @@ struct drm_crtc_funcs {
 	 *
 	 * Reset CRTC hardware and software state to off. This function isn't
 	 * called by the core directly, only through drm_mode_config_reset().
 	 * It's not a helper hook only for historical reasons.
 	 *
-	 * Atomic drivers can use drm_atomic_helper_crtc_reset() to reset
-	 * atomic state using this hook.
 	 */
 	void (*reset)(struct drm_crtc *crtc);
 
 	/**
 	 * @cursor_set:

-- 
2.55.0

