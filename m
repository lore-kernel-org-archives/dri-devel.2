Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65307C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9DB10F9A2;
	Fri,  4 Sep 2026 09:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bp3mJLS9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4587010F9A2
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:07:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E7B7414F3;
 Fri,  4 Sep 2026 09:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8094D1F00A3D;
 Fri,  4 Sep 2026 09:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512875;
 bh=gBe9CyN0ufA358L93gbBtKncMDOXR7qrOX7gXoLFZ7s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bp3mJLS9Y91KvKVys/sHii7Vjxeuu7blNDVwP5RrIFH/id5XPa1TAt19DC8P+v+gI
 J5tYG8cXHDfAsIQrBaoItfhVTq2VB71hOyE32xlMAGCiZCADWSoBk9HhnGzd5Iir9p
 vdJ5jszKnfPeL9aKxsk9bbiIX/CmMAO8/cxybsrcr6dA5xMLnkZ+buI9p4RsNbkMUN
 iT1tk0rBvO5XJVe6QVhGIZfI5dhpZsYQ2/WmVVaD83ES24lJF/IpDsWTjRiCK1uupX
 x/R92uJuqN/x8ePntpLOdKeyNdVAxJ95TD5DXZun9RKhW9aO43jIDRXsIJsZSVDVEd
 8201QQfrogTUQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:24 +0200
Subject: [PATCH v3 06/13] drm/atomic-helper: Remove
 drm_atomic_helper_crtc_reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-6-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3067; i=mripard@kernel.org;
 h=from:subject:message-id; bh=f3gx9WryK1m/n8KAzOTVV/3JhZ9ny4PytCdFy+HeLkw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzunzbkplfPJganinEWXW4R7ZUvOrIvZfRdvbyAdsyP
 RfFqZR0TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIlU1zM2nK5wkbji+ilZuPp1
 aROrrIlR7A5HkWxdXdMgi9Xrf+ie4t607324vAzTNmWNQ7n6sqqM9ZksmlFbD+2SPT2rqG/vDoG
 YsHWd0/29BO9d/D5ZzOjIpujewoNsmy5paV4S0H7Xf+H7DAA=
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
 include/drm/drm_crtc.h                    |  3 ---
 3 files changed, 23 deletions(-)

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
index 152349f973e3..746d049f1b6e 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -427,13 +427,10 @@ struct drm_crtc_funcs {
 	 * @reset:
 	 *
 	 * Reset CRTC hardware and software state to off. This function isn't
 	 * called by the core directly, only through drm_mode_config_reset().
 	 * It's not a helper hook only for historical reasons.
-	 *
-	 * Atomic drivers can use drm_atomic_helper_crtc_reset() to reset
-	 * atomic state using this hook.
 	 */
 	void (*reset)(struct drm_crtc *crtc);
 
 	/**
 	 * @cursor_set:

-- 
2.55.0

