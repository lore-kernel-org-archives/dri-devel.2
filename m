Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74703C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2359C10F2FC;
	Fri, 21 Aug 2026 14:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ksb1G+f6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8152910F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:42:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A4A741FB5;
 Fri, 21 Aug 2026 14:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84C41F000E9;
 Fri, 21 Aug 2026 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323328;
 bh=DdaTjqzvK3Kl53eIaVw4j9DVKDZsVH1F3lIG8n64WSo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ksb1G+f6Jux2J2hqrBxnIRk7kn0xaN4uJri4cn1rpbEEsH6YPpStsuzqxscY/dGNy
 /kKFlZHExybZPSwIgUQp7JfoDJ1K7O78JLZXtiKG91BocvKEz3M+pzKauZMJmbufm6
 /RJlDOnGd8mffgEfKEFXCXLIbhAf7ZOa5zbgXfuP0yn3DJ0yYbOXTXgjZoTzaw/TVW
 n+gdx3QiGCZv6oMKQNkRZPVspc86A1G+mm3Dv6DFbBPjRM7/IHDwpSoa8XpwuIepan
 WVzYAPQONhHM6LmN7LceFhYr3uOQrbsMUsegjMWWsMOVf6tG9Rrkn2dy3BYdYrLeP1
 NfYwdGxlBAxGw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:45 +0200
Subject: [PATCH 69/70] drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-69-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2631; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4hPISWas45PW1aRDfSO3TR6IL6UTwWxVhev4tBlTQEY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyWJPfM8e7lZfH/Py1d9p+5Pule1/H/HRc7+qxy7n4
 1Pv5Hze0TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmcvYMY33JnYSUxFo1L5UK
 icJSpsMXl52eWOqtaLezXippU+TMZccd3c5M0T/Wa7++gS/hvmwAO2OdXWCGbi7Pe1VTs4L5ATc
 7E/aJZV1ZLbltvuBZ3vMT9N8p2Acl12m8axV0UXl4fdc1nxUA
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

