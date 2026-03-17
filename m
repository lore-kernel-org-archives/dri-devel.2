Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD394FD875F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF2A10E5C3;
	Tue, 17 Mar 2026 12:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XbbF95ma";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2361210E5C3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:36:18 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso5878519f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773750977; x=1774355777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQxsks4qQJSghSnSeuplqVJSA1aqWlVuszgwUX8HH+g=;
 b=XbbF95ma/G55gN9i63aIoIi9GS+tFvaH8Sku2NEwvgOoDgR7xsbdUju0FwXeKrHDAE
 9qrMub/yownKycP7czgi/WIkv+Q+ZaYsATTZs+dAM0c6ajCQ66qwPYEly4RQjqYXk5Hd
 bpDi3jEtNw4XNlUt8eO10IX7ZoZ9RZ9hVbalX/m1sdh/uddQEmVxEyjcTDblnhAyURxB
 iRUoyhq0bjIha8NJdXZ7Rg0aSKOHirPMOTldGczM4lNxUQ4Cf+SFH604wP0aDx7qiwv3
 Bw81xJgNJjRwUZT3fpoj8zTcsN2we+TNN+SgYbS4l3g//XPfUfA0SDUbux8mtiLHACLa
 bvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773750977; x=1774355777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OQxsks4qQJSghSnSeuplqVJSA1aqWlVuszgwUX8HH+g=;
 b=eWsDQdVUrsNs+P3KJXO1aAnrUbqGKAfS0vQ790JBMkS3qjGOhbY6t/XEZV/+X1TY6s
 y/rFXyhc97VpUzMH62PJsrWR+CakI0ikuI5hZmXfmxdYzWY+Jm5VuxdCSZ7+b28C36hX
 jXTEo/v1yp+aGcwjekBBIQmDbL6wG3xY2tENz6zvqTiaXUjOrpY/P58+GcvmAcittVOG
 aExCPqpotM9I5baQYKINeYa6IhUIrPN+NaeDBLOh/iscWjhfSIg7iCJ6To67ad42GjJA
 PUyEdP5vfTnU0Xk/WbXWjDXVCQeeft81U5ImzzfEpljsIEio7ulFBC2hAqFugqfpKjxP
 2JCA==
X-Gm-Message-State: AOJu0Yyrzd5YQ5SPlaQ6htS2jR4Cz03FTCHIHNwPAbz8Yy7Nga/vwtJa
 ToDScNwcMsznI3t9u/PMWgXcsqdAOQHGeqlF8U3I7VOyh9lELMyUDLdc
X-Gm-Gg: ATEYQzz051hxJc4j1s+s1aqqBPo56+u7J3wNl/iU3wvEmSw/EyENOEcdp/0RSiYMT/J
 EMtqbT38Ux9IBB2GpJWpdr6LrM0uOPPDtoNyM4MMEDJnW9ScOJukP2Pa+lykmPwBS60FC7K/j5v
 6IyP4jd5V0uJtA0BfVs8ouUPPzxGdyntFA0Ti3EDGRaTdFiqDhxW0P3A49pbcb6ORDK1bHlLblR
 Jr02UH7twsxPoXQI7q9LgCU5T99iXLCrwI7HQXHe2EKuA5jPa53SmqO32BGppbsucci4QcWHpR+
 knr5tOKTuKz0pyCPHFXCPc9s4JssJ+Vr0sgIUQw2CU6bPlDT8Jv0Cls3YqJEzuwBhRex4/WFo8a
 bV13EcdHQtO9c1TyQ8yJBZ2XDsaQG/yVyiETYrUzYJXcowqemTZp+N5DXOabLc71A7/Jm1Ey+im
 7Hkk7/wC3XqGTlxGnM948OK+N7+Yr6PCjWNfbTrRoBPQZq0Wyj
X-Received: by 2002:a05:6000:1843:b0:43b:4352:1bda with SMTP id
 ffacd0b85a97d-43b43521df5mr14593796f8f.3.1773750976385; 
 Tue, 17 Mar 2026 05:36:16 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b4f845841sm3247444f8f.11.2026.03.17.05.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 05:36:16 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hugo@hugovil.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 2/2] drm: renesas: rzg2l_mipi_dsi: Fix the power-on sequence
Date: Tue, 17 Mar 2026 12:36:01 +0000
Message-ID: <20260317123610.329630-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317123610.329630-1-biju.das.jz@bp.renesas.com>
References: <20260317123610.329630-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Move reset_control_deassert() and reset_control_assert() from
rzg2l_mipi_dsi_dphy_init()/rzg2l_mipi_dsi_dphy_exit() to
atomic_pre_enable() and atomic_post_disable() respectively, and move
rzg2l_mipi_dsi_set_display_timing() from atomic_pre_enable() to
atomic_enable(), to align with the power-on sequence described in
Figure 34.5 of section "34.4.2.1 Reset" of the RZ/G2L hardware manual
Rev.1.50 May 2025.

According to the hardware manual, LINK registers must be written before
deasserting CMN_RSTB, and the 1ms delay is retained in atomic_pre_enable()
after the deassert.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index e53b48e4de56..9053ce037b75 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -484,7 +484,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	u32 dphytim1;
 	u32 dphytim2;
 	u32 dphytim3;
-	int ret;
 
 	/* All DSI global operation timings are set with recommended setting */
 	for (i = 0; i < ARRAY_SIZE(rzg2l_mipi_dsi_global_timings); ++i) {
@@ -524,12 +523,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM2, dphytim2);
 	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM3, dphytim3);
 
-	ret = reset_control_deassert(dsi->rstc);
-	if (ret < 0)
-		return ret;
-
-	fsleep(1000);
-
 	return 0;
 }
 
@@ -541,8 +534,6 @@ static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi)
 
 	dphyctrl0 &= ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
 	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
-
-	reset_control_assert(dsi->rstc);
 }
 
 static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_freq,
@@ -1030,24 +1021,37 @@ static void rzg2l_mipi_dsi_atomic_pre_enable(struct drm_bridge *bridge,
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
 	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
-
 	ret = rzg2l_mipi_dsi_startup(dsi, mode);
 	if (ret < 0)
 		return;
 
-	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
+	ret = reset_control_deassert(dsi->rstc);
+	if (ret < 0)
+		return;
+
+	if (dsi->rstc)
+		fsleep(1000);
 }
 
 static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
 					 struct drm_atomic_state *state)
 {
 	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
+	const struct drm_display_mode *mode;
+	struct drm_connector *connector;
+	struct drm_crtc *crtc;
 	int ret;
 
 	ret = rzg2l_mipi_dsi_start_hs_clock(dsi);
 	if (ret < 0)
 		goto err_stop;
 
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
+	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
+
+	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
+
 	ret = rzg2l_mipi_dsi_start_video(dsi);
 	if (ret < 0)
 		goto err_stop_clock;
@@ -1074,6 +1078,7 @@ static void rzg2l_mipi_dsi_atomic_post_disable(struct drm_bridge *bridge,
 {
 	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
 
+	reset_control_assert(dsi->rstc);
 	rzg2l_mipi_dsi_stop(dsi);
 }
 
-- 
2.43.0

