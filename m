Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B70C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047C710E2EB;
	Fri, 21 Aug 2026 14:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OjW4xjO+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A6710E1FA
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC34C4177B;
 Fri, 21 Aug 2026 14:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E8E1F000E9;
 Fri, 21 Aug 2026 14:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323263;
 bh=UbYDrUUZSJUVbTxG/ZZEl3OvIDTDH8C7nccby0fyRqw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OjW4xjO+a5rU62Js4PMObjMW4lu50SQUGfhEUHXfrtwWm5eM0STBLsDB7nVjSlKAA
 PpLabO/jtxQ504s9G3gA/KZVzsMv1GOx43lO5+sgJ/RCY9yaMsF5xdgNn51cNlHwwr
 QRRI9xyWIMT/eBVV92P7XzLTPHkamGvaPuMVSglXlc4l8z/8tODgW4aAzu+UdRxQ3U
 gLNWHmzzxUKXzxxm3c71g9yauO3G0uWHwiISRC+PMfQiKJxVzgnNLnGjHeF96EkDC0
 qfqyqXRM9Obvs0UvhyQ43J5F/U6aDdwYQvkYEA8JrJUtYd9x3MFr9ORDeQUcLLA8EG
 shJRahcKJjiZg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:18 +0200
Subject: [PATCH 42/70] drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-42-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Gqv3qlxWYOUiDYwG8G/0cssFUkmikQQE+20D1Y7fYf8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyVwWUY3v+ETdDNR9gz5minVYlMp9EIzzkTp7+6GIQ
 g3nFfeOqSwMwpwMsmKKLE9kwk4vb19c5WC/8gfMHFYmkCEMXJwCMJHbUxnrI/R2qddxt5z+9FG1
 lX2pCs+Dt+FpEzNPPKzVuPmny7Rd9JE5yy2N7rNnf1UIHi3LzFjG2PDjolF939fYeZGX9h9j8v6
 1b8uZM+Wb2DY1Rn9N7/lnO2/h07isyd/ld4gu1SwMTwp/IAcA
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

