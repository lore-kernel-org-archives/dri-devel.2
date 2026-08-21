Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BEFC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7933910F2F0;
	Fri, 21 Aug 2026 14:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L+2m/RDz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0056A10E1FA
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD31240AF5;
 Fri, 21 Aug 2026 14:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B681F000E9;
 Fri, 21 Aug 2026 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323270;
 bh=ELJR+yZRMxTTE/D721IOqTuD4KT+YjVxFp9VoqsCwDw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=L+2m/RDz0wts9YiBZFja1a+2hOwy92vXp+dWKzipli+e2NNwAVpaAL0K/uborGbcl
 eXzdzj4tLHKrGAOrGwnCX/Dzk0SsVGN7tcJI3V4p92kSIuLLlQJD0FaxpP7lDgSNXl
 6e/DI1aYZ8Gm04CAg4X4YLhKUQTV+RR1UML8tla26SxXfew3QWictrMztEJ6OrEZVh
 tJdqEWxLEfZmXPHVphZQ70xuxRInyvWO1QXxHbr78rDBcnxwHqTlPX5NDO81Es2o9o
 jSLQ0DrW2hD0JHMIfkWkRJ6d0UAhV9f4kq79U0u2vtyotOkciZaLZyaC9MxJh4yr/q
 2P4xj5MtbELYg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:21 +0200
Subject: [PATCH 45/70] drm/komeda: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-45-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xCYbzEg1kI6IQ0wKgtmeWxQXpS6ydXVunox+J86j1is=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyTxyH8qWbDRzFWvWvHyo1kGqV35xbodPENeGC9Ffn
 z2WCFvQMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYi5sbYcGjJfK3dbtpvj3vt
 PzZ5xpOGbsV4k4mMM/yl0nMLG/TrI0Obf1zaFXrx8seZFixzVZdMZ2z4HH1vv9e6UlFDtaQjYr9
 3ub9eKZW14nnvWtPjAjEvbZT2rZ24SfdZTdOtmsApD0uCtIwB
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

The komeda crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index e8cb782a6f8e..e1165b6d8bfd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -491,23 +491,21 @@ static const struct drm_crtc_helper_funcs komeda_crtc_helper_funcs = {
 	.atomic_disable	= komeda_crtc_atomic_disable,
 	.mode_valid	= komeda_crtc_mode_valid,
 	.mode_fixup	= komeda_crtc_mode_fixup,
 };
 
-static void komeda_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *komeda_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct komeda_crtc_state *state;
 
-	if (crtc->state)
-		__drm_atomic_helper_crtc_destroy_state(crtc->state);
-
-	kfree(to_kcrtc_st(crtc->state));
-	crtc->state = NULL;
-
 	state = kzalloc_obj(*state);
-	if (state)
-		__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
+
+	return &state->base;
 }
 
 static struct drm_crtc_state *
 komeda_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
 {
@@ -553,11 +551,11 @@ static void komeda_crtc_vblank_disable(struct drm_crtc *crtc)
 
 static const struct drm_crtc_funcs komeda_crtc_funcs = {
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
-	.reset			= komeda_crtc_reset,
+	.atomic_create_state = komeda_crtc_create_state,
 	.atomic_duplicate_state	= komeda_crtc_atomic_duplicate_state,
 	.atomic_destroy_state	= komeda_crtc_atomic_destroy_state,
 	.enable_vblank		= komeda_crtc_vblank_enable,
 	.disable_vblank		= komeda_crtc_vblank_disable,
 };

-- 
2.55.0

