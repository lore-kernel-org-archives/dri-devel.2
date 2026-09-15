Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9B6C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5086F10F08E;
	Tue, 15 Sep 2026 14:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g39Npt6X";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA9510F037
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:25:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E08AF600C8;
 Tue, 15 Sep 2026 14:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8C01F000FF;
 Tue, 15 Sep 2026 14:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482331;
 bh=7La0JXiwqtIL/5j1sYzaou7Mh7+YCozrVXCv2/Uuelk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=g39Npt6XCvQ6DxJagm3ckUA3pmNt0O+FkUWrEzQSOGviRSzybrjDoPdZa5Nj/ZxUZ
 nUqAL2ZhyL7OkW1i6illp2JFNWDhMBxg0JjaZ3WDZmF4VmQsaTd3hgtzbyXXv2Xi5M
 ASdbkXgelZPsqFIuMWxJFy3WB2PVJ0JsoaBKkoVBOBKh3j2db/DZxzd5nYWXUjxu6b
 TL/PeqWRA8P4w0r8W3ngaEHXFMtx7gskDkAgKNVlHuEiZSZ4cj+miXLtn3oZ+y5FFu
 LpNve1PqQ3gePS+sme0KJvZY6BaA0KBzVT1EOCLnBglt64X1t/NPnh+UnCFba2mAll
 YUh+gAkUpEkcw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 15 Sep 2026 16:24:51 +0200
Subject: [PATCH v5 10/11] drm/atomic-helper: Remove
 __drm_atomic_helper_crtc_reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-no-more-crtc-reset-v5-10-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2814; i=mripard@kernel.org;
 h=from:subject:message-id; bh=KtojP/hmyxfTzx6Lrl5Memb8a+w2CRglQYOMIoJHGxQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQw3jdzdsVl+ytDo0RLbfxfoi++8EBaW/XTMk+v2Yl
 KzMyr51TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInc4masjypJcUuZwHL52xu+
 vOT0vtOsMocPht3/9+DGo0fbfqUG93l/89dIXyTsceze3Ifh1/ONGOtDvnknnX27+pcHz23DsvC
 OpduUn169vfDQthPzvCyvL5vmHfD6jqfzxZ8BOt42/YevH9YDAA==
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
__drm_atomic_helper_crtc_state_init() and atomic_create_state.

Remove the now unused helper.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 26 --------------------------
 include/drm/drm_atomic_state_helper.h     |  2 --
 2 files changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 77b3d0b6674c..eb9de78c4d85 100644
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

