Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D3ECD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F1110F450;
	Fri,  8 May 2026 11:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PvMNJ0sZ";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9BA10F449
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:17:53 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so1481716f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778239072; x=1778843872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPP4JL0RAe1XpX/h7T3lnNJ3/faSIVf5jmqwVJovOao=;
 b=PvMNJ0sZJEuY486IFZOiaObx9GaQgNGyity7/XN9i9FNN2BvvkW9hXpa7x1ZGsBbnQ
 g2K7Bvy0vigPBG+R1b7xFBk8+V8WvJoECKMz+jnzp1qSV+rGn0V4tKm18D+TIV/AHOoW
 YJfLf2skhJhxr4niVm+Pe3+o/UV6AOUL7JgnPotpWGDC0S2L7fpIhEcKKp4svjc1YEIO
 W/sqjcdDG5IGZy22MpCp6clHJJoJhYaIldeSdQ7mlbMXdYj6ACuFsI6EhqOLLk9+HVZc
 bhiHqLtNzrBYceF6xohtXwMoWwYPp4k36xHpVilOIQY+lmDhg71RHDhUP8UvG3yFZWwr
 pveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778239072; x=1778843872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yPP4JL0RAe1XpX/h7T3lnNJ3/faSIVf5jmqwVJovOao=;
 b=ATTzDfdOEM4n7aO37bvEvtB1I6tLv1B31x4SvHCEfaG+K2mf+XaVkMAL5zXb5oY8Mx
 0i2oki28FioqJ9DXv9ok+bGcQJqg9i4faJMYi4srSkivlYk6Hnpu1q7qGIZVTDtyO4j5
 MIzCAa9KKbsm6mvDVgShdv9TWyhuRDVLSSC+lEqWCXA9j+k+x0wedutTEwJxssRcvXQU
 3l+gzgoVF8+QhfWQMft1J86DxoW79wVdApFu68w1CwWQuPzI5qAs6b8kVymLyIeMbFH0
 qQMwgPQbeZSOk7vZnWf3oKAiY+p1IjiCZuWDueAhUdaNr/WeKDgH4csk4pMVWdqR1Zs0
 uVMw==
X-Gm-Message-State: AOJu0YyWxPpM8vOlIDFChn8AOtyZaVPrpnV6qRGDsmFwvBggnNqFQH6W
 ZzZayPPdWPDmpAt4Vc50GcvUXRJ9fdXQRg8x4Iv3UXfm9KbZfxqBbs0RcF9IFxMb
X-Gm-Gg: Acq92OEvKtFaJVfGCUwxxVkqhvY9+2Q1oKa4sDa0uMWdX3N+TxXqycoHsJzgm9F6j3z
 zvqhldrjBA3uiAioDUKv/RqfSpDChMGESnhJWpmyl1hay7akOYs0pgYhfJ22R6JTm0PApxCFZqD
 5ek9G5JM7QeQ94qzbbn+/AmkoXa2NJ1OcukCNcIeRmireseG1oXHOZjAON8FXUugu6aE9npo4/P
 Pn/K2xSygPsfteRTQKetfdUGiU5tcUgYbiP4EV77vwd6YHt8TeBaqVndG/U5k9CM9GtsQx2OWkr
 wcN/lHOtUMlGgfJpQfVGiNoWiOVvuzEoBZThcVY6nRM9J+a0pRGCP+uOxdRmnS49GbH0+1D4lq5
 5zKg33wWOK/j67MO6S79XPpX7Owisr7PR6k7ay9iw35nQKML37ATGhVelUqVb8/eSawx8ZBx/S2
 tQC1m6/ngoGlhJvAYXqTdKWS4e/mVp57cdA9UL4iaCiVSifVX7f5mlaM8/SKheyWsvHHfcriS65
 tvHFyXSptMXIX1zOgW/8+RGS11tLEzYpi0GhA==
X-Received: by 2002:a05:6000:1868:b0:44f:da54:da6c with SMTP id
 ffacd0b85a97d-4515ce1c84emr20981373f8f.26.1778239071736; 
 Fri, 08 May 2026 04:17:51 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:74ae:919a:e57c:bd9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454916df968sm3535563f8f.25.2026.05.08.04.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:17:51 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/4] drm: renesas: rz-du: Move mode_valid logic to per-SoC
 clock limits
Date: Fri,  8 May 2026 12:17:43 +0100
Message-ID: <20260508111744.771659-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508111744.771659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260508111744.771659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Move pixel clock validation from a fixed encoder check to per SoC
constraints stored in rzg2l_du_device_info.

Pixel clock limits differ across SoCs in the RZ DU family and cannot be
expressed by a single shared rule. For example, RZ/G2UL (R9A07G043U)
limits the DPAD0 pixel clock to 83.5 MHz, while other SoCs such as
RZ/T2H require a wider operating range.

Add mode_clock_min and mode_clock_max fields to rzg2l_du_device_info to
describe the supported pixel clock range for each SoC. Update
rzg2l_du_encoder_mode_valid() to return MODE_CLOCK_LOW when the pixel
clock falls below mode_clock_min and MODE_CLOCK_HIGH when it exceeds
mode_clock_max.

Set the pixel clock limits for RZ/G2UL(R9A07G043U) to 20.875MHz minimum
and 83.5MHz maximum.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Dropped storing info pointer in struct rzg2l_du_encoder as it's not needed.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 2 ++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 6 +++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 0fef33a5a089..3b7162c6e1f4 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -35,6 +35,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g043u_info = {
 			.port = 0,
 		},
 	},
+	.mode_clock_min = 20875,
+	.mode_clock_max = 83500,
 };
 
 static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 58806c2a8f2b..885558eb9547 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -44,10 +44,14 @@ struct rzg2l_du_output_routing {
  * struct rzg2l_du_device_info - DU model-specific information
  * @channels_mask: bit mask of available DU channels
  * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OUTPUT_*)
+ * @mode_clock_min: minimum pixel clock in kHz
+ * @mode_clock_max: maximum pixel clock in kHz
  */
 struct rzg2l_du_device_info {
 	unsigned int channels_mask;
 	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
+	u32 mode_clock_min;
+	u32 mode_clock_max;
 };
 
 #define RZG2L_DU_MAX_CRTCS		1
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index 0e567b57a408..5c672549bc84 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -50,8 +50,12 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
+	struct rzg2l_du_device *rcdu = to_rzg2l_du_device(renc->base.dev);
+	const struct rzg2l_du_device_info *info = rcdu->info;
 
-	if (renc->output == RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83500)
+	if (info->mode_clock_min && mode->clock < info->mode_clock_min)
+		return MODE_CLOCK_LOW;
+	if (info->mode_clock_max && mode->clock > info->mode_clock_max)
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
-- 
2.54.0

