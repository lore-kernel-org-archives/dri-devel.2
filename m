Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F3606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXs5Fj86
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C0F10F72D;
	Tue,  3 Nov 2026 17:21:19 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B8510F73F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 17:21:11 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso36302125e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 09:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793726469; x=1794331269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y82kaLlVdTMG/Dxoi+XgELgK4jbU4ivpOZ2fmcDfzkY=;
 b=rXs5Fj86J0lkFU86yD2ehOX63laSoWS7Akkg26BEvQLYUxLfZEPLtIjsYQrsjq1xaE
 5Q6WnrsvVrvKb4Vnzu08MTvD7lbmmwP9goL1jgNlG9Lj32EK4JhKQMkTfaoLcD/eS/oa
 +Bs+M7RNoN3SZvAEW2vA+LmVPUFlLnLT89wAa0Ql5CYkJzuiYP9hUru5qYP3IlUPyCGY
 PlgWJnxFk77BjLLQp8l1VMAnHUjeDOwHDp720GMDJOWBIFWjb3tOEh+5Ll8J3bSrRZ15
 29gMGNKwnrutrqNWbA7HhhhFFm+CKik65dzwcWueBFtak0he+JoniJJjbS8ZELqN0wAa
 Zsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726469; x=1794331269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y82kaLlVdTMG/Dxoi+XgELgK4jbU4ivpOZ2fmcDfzkY=;
 b=apyslcplue9SaXIPkIRT5iWS+sohBvp+JuQZ9c0NVdmUPlNWMpUFFpnxeJKOp3HatQ
 17KZA2QyzdSMQxgNx9Mr/CqQptSQzQapbDyXdgDgBLQbgLWa2yj3+95PvKIDJ87ckv8y
 EKKsETxv50kJ3CeNrVOZU4jMqV4OC/u0r0ItYhd72M+s2xLopPIDyTRtZLtqv+//NdMp
 en+j5ZltxUi9MduCAxS+ZQ14ghwyBs1xOwXUTZSPLBmSiqgumS26s+HilRDLyLYPbe82
 rODgtdXM4bgmBMApRSk49mAskBmYj3lGSABfWdyN8AJFSilNT36KtkAEOWGIe9Iqh036
 tlGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTnhlHhfWphgAGGHfW2qWrI3hsuos3beZ2CWQGPvzY/AQO2++l0ryZvTrnSUuTBHSj8ofFiOSEcJ0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z87+fWZIgSzKlR2Vs4yQRhYKDOvCBT+Gb4N4DwzvScY0Qrz9lSv
 psVP9SPMEChGhmZZZzC7tXFNQ4W/xF21YcGCzieznoBQCh66jxfSHNL8pCsFnjiWthux1A==
X-Gm-Gg: AYBFou2Q5XGe8pgpY+jHVDwqDKEB8OtGjgTETFtcCS6dIuCscjDeQusTG2D5Clt3PhR
 E2m7pvqxC1KbNBU6iw4KvjcWLa/vTbGL5nIMdIp0RRcQj61jzUwWiJmGWJ2RlB+6ywZB9w3Y0D4
 MehHJKunQ33vBzWXYUaREKAS0iNVLJWPwplFPmE5POCIRN208KswSL1suSxES3hW98XCIceEO5p
 qFHDwX9F6W8XLSIPVms6R9xDOlt9pWF5u5RnYMUQ+apF2XBxoI3cm9oomPFrFMUdMZfep6eN8WK
 jQ6J268r8HoJT2q3DfwNveh+l1RSY7AD/AfWXsgLKOM2c802Y2oRL/P928tgdQzbjsIulhMHzUj
 6SlB+F3t0F+Vp9m5QHE2Fs9FhtsDaWJTAvOb4BnsYM0baBjaygvBUUvf7E2/BGkGrCT6dQe9II6
 IkUMXIXh/UX2L6c0avMCZWV9hCprRZKGhBkn4EqgandAT3K/Eb3RYAxoe/Z+IPAHmZ/GTrDJyG/
 BbXd02987n3zUpJftkLKkdxSYukpX13foR1QPVWSwp3aosxmTGQx+UM6NOcncv/nIV+NGbrLa6d
 HjeuzcP7WT/e4L5LhqmEUijFh/YHObpFlDXJyWh+QxrOzVOuhGdYw6togNRMVL0iEvRZ4uZTpiG
 rQq1OR1bBQT8fPJ8O0YNTAr5RaM7gDfjndIYNDVs=
X-Received: by 2002:a05:600c:674f:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4ac1228a434mr330482525e9.0.1793726469286; 
 Tue, 03 Nov 2026 09:21:09 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:8b77:19e1:26f7:89f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac08b72579sm8800675e9.2.2026.11.03.09.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:21:08 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH 4/4] drm: renesas: rz-du: mipi_dsi: Add fallback CPG PLLDSI
 parameter search
Date: Tue,  3 Nov 2026 17:20:57 +0000
Message-ID: <20261103172057.617203-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103172057.617203-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261103172057.617203-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

For each PLLDSI divider, rzv2h_dphy_check_instance() only considers the
CPG PLLDSI parameters with the smallest frequency error. If they do not
lead to a DSI PLL setting less than 0.5 Hz off the required HS clock,
the divider is skipped, even though a CPG setting with a slightly larger
error could work. Modes such as <mode, lanes, format> are therefore
rejected on RZ/V2H(P), RZ/V2N and RZ/G3E.

If no divider gives a usable pair, search again with
rzv2h_cpg_get_pll_pars_validate(), accepting CPG candidates up to 50 Hz
off the target whose DSI PLL setting is less than 0.5 Hz off the HS clock.
The first accepted pair is used, so the pixel clock may be slightly less
accurate, but the mode can be driven.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 85 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 682bbb339bef..c23c7f43a560 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -42,6 +42,9 @@ MODULE_IMPORT_NS("RZV2H_CPG");
 #define RZ_MIPI_DSI_FEATURE_16BPP	BIT(0)
 #define RZ_MIPI_DSI_FEATURE_PWRRDY	BIT(1)
 
+#define RZV2H_DSI_PLL_MAX_ERR_MILLIHZ		500
+#define RZV2H_CPG_PLLDSI_MAX_ERR_MILLIHZ	(50 * MILLI)
+
 struct rzg2l_mipi_dsi;
 
 struct rzg2l_mipi_dsi_hw_info {
@@ -76,6 +79,13 @@ struct rzv2h_dsi_mode_calc {
 	struct rzv2h_pll_div_pars cpg_dsi_div_parameters;
 };
 
+struct rzv2h_dsi_validator_context {
+	struct rzv2h_pll_pars *dsi_pars;
+	unsigned int lanes;
+	unsigned int bpp;
+	u8 base_divider;
+};
+
 struct rzg2l_mipi_dsi {
 	struct device *dev;
 	void __iomem *mmio;
@@ -675,6 +685,67 @@ static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_f
 	return 0;
 }
 
+static bool rzv2h_dsi_validate_pll_pars(const struct rzv2h_pll_pars *pars, void *context)
+{
+	struct rzv2h_dsi_validator_context *ctx = context;
+	u64 hsfreq_millihz;
+
+	/* Check error threshold for CPG PLL DSI */
+	if (abs(pars->error_millihz) > RZV2H_CPG_PLLDSI_MAX_ERR_MILLIHZ)
+		return false;
+
+	/* Calculate the required DSI frequency */
+	hsfreq_millihz = DIV_U64_ROUND_CLOSEST(pars->freq_millihz, ctx->base_divider);
+	hsfreq_millihz = DIV_ROUND_CLOSEST_ULL(hsfreq_millihz * ctx->bpp, ctx->lanes);
+
+	/* Find DSI PLL parameters */
+	if (!rzv2h_get_pll_pars(&rzv2h_plldsi_div_limits, ctx->dsi_pars, hsfreq_millihz))
+		return false;
+
+	/* Check DSI error threshold */
+	if (abs(ctx->dsi_pars->error_millihz) >= RZV2H_DSI_PLL_MAX_ERR_MILLIHZ)
+		return false;
+
+	return true;
+}
+
+static bool rzv2h_dsi_get_pll_divs_pars(const struct rzv2h_pll_limits *limits,
+					struct rzv2h_pll_div_pars *pars,
+					const u8 *table, u8 table_size, u64 freq_millihz,
+					unsigned int bpp, unsigned int lanes,
+					struct rzv2h_pll_pars *dsi_pars)
+{
+	struct rzv2h_pll_pars temp_dsi_pars;
+	struct rzv2h_dsi_validator_context ctx = {
+		.dsi_pars = &temp_dsi_pars,
+		.lanes = lanes,
+		.bpp = bpp,
+	};
+	struct rzv2h_pll_validator validator = {
+		.validate = rzv2h_dsi_validate_pll_pars,
+		.context = &ctx,
+	};
+	struct rzv2h_pll_div_pars p;
+
+	for (unsigned int i = 0; i < table_size; i++) {
+		ctx.base_divider = table[i];
+
+		if (!rzv2h_cpg_get_pll_pars_validate(limits, &p.pll,
+						     freq_millihz * table[i], &validator))
+			continue;
+
+		p.div.divider_value = table[i];
+		p.div.freq_millihz = DIV_U64_ROUND_CLOSEST(p.pll.freq_millihz, table[i]);
+		p.div.error_millihz = freq_millihz - p.div.freq_millihz;
+
+		*dsi_pars = temp_dsi_pars;
+		*pars = p;
+		return true;
+	}
+
+	return false;
+}
+
 static unsigned int rzv2h_dphy_check_instance(struct rzg2l_mipi_dsi *dsi,
 					      unsigned long mode_freq,
 					      unsigned int pll_instance)
@@ -718,8 +789,18 @@ static unsigned int rzv2h_dphy_check_instance(struct rzg2l_mipi_dsi *dsi,
 		}
 	}
 
-	if (!found_valid_parameters)
-		return MODE_CLOCK_RANGE;
+	if (!found_valid_parameters) {
+		parameters_found =
+			rzv2h_dsi_get_pll_divs_pars(dsi->info->cpg_plldsi.limits[pll_instance],
+						    &best_cpg_dsi_parameters,
+						    dsi->info->cpg_plldsi.table,
+						    dsi->info->cpg_plldsi.table_size,
+						    mode_freq_millihz,
+						    bpp, dsi->lanes,
+						    &best_dsi_parameters);
+		if (!parameters_found)
+			return MODE_CLOCK_RANGE;
+	}
 
 	memcpy(&dsi->mode_calc.dsi_parameters, &best_dsi_parameters,
 	       sizeof(best_dsi_parameters));
-- 
2.56.0

