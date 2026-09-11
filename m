Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C376EC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F9D10F5FC;
	Fri, 11 Sep 2026 13:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LjWN8EWM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C6D10F5FC
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:21:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C22C42B38;
 Fri, 11 Sep 2026 13:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A353D1F000FF;
 Fri, 11 Sep 2026 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789132885;
 bh=7SmqBHAihMCFa9m/YUNpm6yR7GMIwwV1sCZZ7v8mAzw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LjWN8EWM/bQZFxqHQt+Ex4ROZ61ec0yO3TohWu42g545fB2srtjxDakod212mi5NQ
 c3n3xnnXtW4xyr0nwMnNs6LcHao4OmzwjffSGs6deRe+JYOloPawe7xYujVtN5LLzs
 IcMzT0WkSm3HjMp7UoMEwycT3XLQzX1CRspI699WSXjR1ysGDRSCLL35JBl5WHsRiR
 cJQ8La7b4jF7XUtiL2m3I6zHWkXm+LEUThJ6YLffKWQjefe1WjERXCuAu5aOVdE951
 G+5vnk9oh57VwsvYyCzlan3UqjojW7ZcIqF/Hj6uAqVKoP8AKYpBVbiBhtKYtPTAd0
 aQdkrCgELXkeg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 11 Sep 2026 15:21:09 +0200
Subject: [PATCH v4 2/4] drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-no-more-crtc-reset-v4-2-662e0ccd815c@kernel.org>
References: <20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org>
In-Reply-To: <20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3127; i=mripard@kernel.org;
 h=from:subject:message-id; bh=DQA6+A34kPQ/GJy8foR40C6lQN8z5J8WmlJ0mZHV+gg=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGqkAEjI8hNxVUUbRf79YUjQODRRK2H2/j9vrQCFKAxDe/bUr
 YiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmqkAEgACgkQJ1/OGaI9vnatoAF+IJbt
 LFWjsidnPjVpljyDF196yY7RUjOcHkTwea0vMtZDPS64Jh9AWFJE4SbdifF7AX9lmLWM6nFF2q4
 ucMrJmW3nzxGJPgYnIO9ZssLfzyN0I+PwGKKSZiCqpAgzDSKvjuA=
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
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 19 -------------------
 include/drm/drm_atomic_state_helper.h     |  1 -
 include/drm/drm_crtc.h                    |  3 ---
 3 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index a2ef272e9f27..77b3d0b6674c 100644
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

