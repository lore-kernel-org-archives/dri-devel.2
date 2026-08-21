Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53D1C5DF96
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E312F10F2E8;
	Fri, 21 Aug 2026 14:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ctrfNytj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EFD10F2E4
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D09543FE0;
 Fri, 21 Aug 2026 14:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3551F00A3F;
 Fri, 21 Aug 2026 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323277;
 bh=8vrQ2MbWnCaZ1h4zrG/r9h4KsId76EDISFJWH9cot1g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ctrfNytjcCFedYGtNghDiAYKBHKThUxgE1Tu1xXjYV0RYfGKtHG9IaUMBrXCrSVhQ
 MYD/zEmBedb0CP1Hk6eK1MCM9q0Wzu2rN8qVW9DyKAb4kPLdp62xDhMUEtHgRbw7Pj
 7qLfhWOVrYlVm7ARjN+BEML1vMdbIxXSQgcXADq72Ylzok0iJ6OConM8LfVodrlBCO
 m71pY0ZggmwZvOHAe5XxvYT1icll/H8ncborTxrv4fin+MtGMqsxtVZI5UVPD0Y9bL
 8N2nEIGyJwO4W6Y+kgz07x5twri6kdxiKNUm2fkbFfbPav/ptCdJw3hkX/HW4JGOq8
 OnUTNfUtQ6u5A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:24 +0200
Subject: [PATCH 48/70] drm/atmel-hlcdc: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-48-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dharma Balasubiramani <dharma.b@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=mripard@kernel.org;
 h=from:subject:message-id; bh=l2MvqqxgXAWEc+m05r3QWe/rUJKnmVbRgbTs3U183Go=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdybySWvrJ++OdjD9+XOt68+HVT1cVrGZNsrwTuex2N
 s9BBun3HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiLecZG3Y0qebUBay4vUwo
 e+a6Ta8PL+9mO3xQzid50Ym1T5Tu78jTObRMvsMzXVnujm9v75q73xjrAy7aJpX9TwlXs03e7Vw
 1cyHDLNarH0zeV2zafFFMjO3bal0z33Ov58nanN088/kfXi5dAA==
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

The atmel-hlcdc crtc implementation provides a custom reset hook.
However, this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 9dbac2def333..c2c4c9c3086b 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -527,24 +527,21 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c)
 {
 	drm_crtc_handle_vblank(c);
 	atmel_hlcdc_crtc_finish_page_flip(drm_crtc_to_atmel_hlcdc_crtc(c));
 }
 
-static void atmel_hlcdc_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *atmel_hlcdc_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct atmel_hlcdc_crtc_state *state;
 
-	if (crtc->state) {
-		__drm_atomic_helper_crtc_destroy_state(crtc->state);
-		state = drm_crtc_state_to_atmel_hlcdc_crtc_state(crtc->state);
-		kfree(state);
-		crtc->state = NULL;
-	}
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
 atmel_hlcdc_crtc_duplicate_state(struct drm_crtc *crtc)
 {
@@ -597,11 +594,11 @@ static void atmel_hlcdc_crtc_disable_vblank(struct drm_crtc *c)
 }
 
 static const struct drm_crtc_funcs atmel_hlcdc_crtc_funcs = {
 	.page_flip = drm_atomic_helper_page_flip,
 	.set_config = drm_atomic_helper_set_config,
-	.reset = atmel_hlcdc_crtc_reset,
+	.atomic_create_state = atmel_hlcdc_crtc_create_state,
 	.atomic_duplicate_state =  atmel_hlcdc_crtc_duplicate_state,
 	.atomic_destroy_state = atmel_hlcdc_crtc_destroy_state,
 	.enable_vblank = atmel_hlcdc_crtc_enable_vblank,
 	.disable_vblank = atmel_hlcdc_crtc_disable_vblank,
 };

-- 
2.55.0

