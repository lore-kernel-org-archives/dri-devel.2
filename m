Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42754C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388DB10F301;
	Fri, 21 Aug 2026 14:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FBNV6bht";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DE410F2EF
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F1DA43B1E;
 Fri, 21 Aug 2026 14:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0B11F00A3A;
 Fri, 21 Aug 2026 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323302;
 bh=5mE84ZD3D/RD0+ix3p1PunzsEBBujkIu26g9UVX06lc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FBNV6bhtQ5gd5lKOO8wxOLKL14MZgDZgFxZfRJ9O0h3BE4EBvWH0Hu1HKUyjs0eFu
 bE9gpN+qiPZ392FffVGwVYPIqxwjwerRSIOdkgtISrasRaavT1iNIEJgpvq9a1abUo
 g03RpsU7EQLvHiuKlSsaEsQS58T/QKPBPdSSXARLMvxFSb5RHd9J5pUtdxqmTCypRL
 TXXFvfoR9GqpbVwJpPoKT+OnssAZ92whNgp6hiTKx1xUenKLWdOGux06Jt1ia0M9OI
 nHsJolKi38Pa+Q/BfJybcp+xzckIbHdribScURR5184j5MBz9N1pPF7kffToIWE1j/
 kCQmXEq51bKTA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:34 +0200
Subject: [PATCH 58/70] drm/omapdrm: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-58-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Sskk60/tiOuccTTvKWaTOhHYybYJMjnKLI2LhwD/43A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyUJaSh6tV5jTlsRz3fMy2s/yk5Nd4EM4p9YXx0PSD
 5WEWy53TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInYdzI2nLh+5O+JOuks2+PP
 DwjfYXqpXrF56T7+ozFrMyTCv/6W3vV+7Yurgit63NONuDn+sPzjZayvMxZ00G7f1X+x0vr3bKt
 HPnWxruwPn9YKfxNctGfj6/XivPM5rk2oXNa4KunF8l2fZgQCAA==
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

The omap crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index c1b41e010a00..a9f6a76ebb5e 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -705,22 +705,21 @@ static int omap_crtc_atomic_get_property(struct drm_crtc *crtc,
 		return -EINVAL;
 
 	return 0;
 }
 
-static void omap_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *omap_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct omap_crtc_state *state;
 
-	if (crtc->state)
-		__drm_atomic_helper_crtc_destroy_state(crtc->state);
-
-	kfree(crtc->state);
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
 omap_crtc_duplicate_state(struct drm_crtc *crtc)
 {
@@ -743,11 +742,11 @@ omap_crtc_duplicate_state(struct drm_crtc *crtc)
 
 	return &state->base;
 }
 
 static const struct drm_crtc_funcs omap_crtc_funcs = {
-	.reset = omap_crtc_reset,
+	.atomic_create_state = omap_crtc_create_state,
 	.set_config = drm_atomic_helper_set_config,
 	.destroy = omap_crtc_destroy,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = omap_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

