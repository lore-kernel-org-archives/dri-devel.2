Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61799C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9CF10F2FE;
	Fri, 21 Aug 2026 14:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VY5lS2Sb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6654A10F2D1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43F6943728;
 Fri, 21 Aug 2026 14:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BF81F000E9;
 Fri, 21 Aug 2026 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323273;
 bh=4t69sV5dihHUJa6/i+qrfHsSxWE32PzSL1jqvj5mKAE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VY5lS2Sb75UWokyYdOOfoeGX6o8g8mDbDdFKyUCMmIqg93ZKh4ZSHLEGdkmGXJLH7
 KZP5m/k5YNbIUiJLV2WM0i7lV11fJ11jZlAVpw2HLH5XAGcPV6SVhdCVj/O2H4/+C+
 HwwwQJp1rh50KzP6q9GPnD/azM2WFKE+0qRSu3Typ+zop0atykVPG8a6j0r7V9WJ+Z
 pptCD1EfhMpdnMua/twWmJdU5t7vLduLQXgNig1hJd4jYQjaycaw72vMpb4RiwAENR
 1YdDCSaRloelEggi7P/LklI+YBXT5uWlF3vBsh00EXkJwKmgkoJ4D49Ne2QwPVkpUL
 bfue6cmP75yZw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:22 +0200
Subject: [PATCH 46/70] drm/malidp: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-46-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299; i=mripard@kernel.org;
 h=from:subject:message-id; bh=63efcqfTmKQ+Pi5Ko25XlhC7QTWLL0UXCAdClig9Fnc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyTyTsvd82WpVO2dOkaQzv07DfmH+TPkiDeGNr093S
 PqKO9Z0TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInczmWsT5C13xK+6OArlUre
 n0ZX39rMLJnLaqBgUaB45PYCnYk8wnmsBYc/B7FxTnuZF9YgmiPB2PDr2kk1QamQMuNLuROlOg5
 Yi/w9p76J60DDY6899va7ZkksLtOd2vE1+zp36gr19IX+HwE=
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

The malidp crtc implementation provides a custom reset hook. However,
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
 drivers/gpu/drm/arm/malidp_crtc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index ebe8e1078777..157ff148efe7 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -474,21 +474,21 @@ static void malidp_crtc_destroy_state(struct drm_crtc *crtc,
 	}
 
 	kfree(mali_state);
 }
 
-static void malidp_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *malidp_crtc_create_state(struct drm_crtc *crtc)
 {
-	struct malidp_crtc_state *state = kzalloc_obj(*state);
+	struct malidp_crtc_state *state;
 
-	if (crtc->state)
-		malidp_crtc_destroy_state(crtc, crtc->state);
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
 
-	if (state)
-		__drm_atomic_helper_crtc_reset(crtc, &state->base);
-	else
-		__drm_atomic_helper_crtc_reset(crtc, NULL);
+	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
+
+	return &state->base;
 }
 
 static int malidp_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
@@ -509,11 +509,11 @@ static void malidp_crtc_disable_vblank(struct drm_crtc *crtc)
 }
 
 static const struct drm_crtc_funcs malidp_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = malidp_crtc_reset,
+	.atomic_create_state = malidp_crtc_create_state,
 	.atomic_duplicate_state = malidp_crtc_duplicate_state,
 	.atomic_destroy_state = malidp_crtc_destroy_state,
 	.enable_vblank = malidp_crtc_enable_vblank,
 	.disable_vblank = malidp_crtc_disable_vblank,
 };

-- 
2.55.0

