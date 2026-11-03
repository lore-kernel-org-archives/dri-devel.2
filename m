Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF03606A33B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z4RK7crQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DBEC10F727;
	Tue,  3 Nov 2026 17:21:16 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2F910F727
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 17:21:10 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so34181305e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 09:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793726468; x=1794331268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=roOiO3ldaNsjLxe0CYehd5v8rGn8f4LGIVU12eUR/M4=;
 b=z4RK7crQYhI6/GnJwBH78TK92c/676XxdNj+v8JY0Y7m5rQVmNrbFFNuiJQlCa9Df/
 iSj/P4+w8v0icWxemCYb7J5NxHn/qtS/7kuIjuIjicIzxWH/+gA/UAdLlOH4dKtlGKGw
 kWbQPvSV6h51s7OMC/CCLR3wcZ6OZs8BzvgGvG1yCY+DqXHRRWChcgCBFSesZt7/CLP6
 I0GMMZf5SZSUvM3f1dtqniOrf423UuWitrFCU/SkXQ06NYwJwJo1aPGPOuw4bhOg6zTA
 3n9tRr90rDZK6lzu0OC3GncsKuz+AACVTIjXL7Hnu+S2oZeEk1J8yLp5KQWa8AmjIaDw
 SMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726468; x=1794331268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=roOiO3ldaNsjLxe0CYehd5v8rGn8f4LGIVU12eUR/M4=;
 b=b6pGjkeFCPP8XOga7LraLDzHR5iYQhPRs9OLDelce1G9caH6eoAnlcL+Zx/IFMWJvQ
 CABj/M+vtRSUGkHSBYAE4cUa/x3opBwuuPNX57wNfLP9ugO3uVJbjocoSEah+IKV3HEH
 f1Wpta60iocw46Mg02ha/1O/xlrHWgdiz0mMzKcR4m+ozN0cNQqEf2M4qCitDizPnVc8
 wsjT4Ci9vvMCEde40OIUDgYR65kw+hdPGTk1G61QpBVGPnZ5ogh0E+9KoAz7wp+JSNBt
 qRxgVFXEWObCmQD3x1Ou9OkTB2RXfDVFzzc0ZBO2+jTOuPOUxc8KVzD0VmFL8EnJ4lzH
 Ht3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5PuUwakGTD8290kH+RG4QIU7keb411x3BIWC//mNyvaEzBu88LqnaxlH/MLSSsgn8ZYSsBt5tHnU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9N7Sw6yFX6KR/722dk+0WhAaHHSwRIXpbtVr5icZZOjnoqlwVU
 KHJbYy+2IiupvTDCN3CzkHauJMQS+ppaE7TbbwD54NjgsmTF1xU3uO/+
X-Gm-Gg: AYBFou2EpjfwXzePnftlTk+8KTWHhWo7dvQhsApp93WmIUsqp677sA5dS5Utu+TdjyQ
 8Cezyp0k/scuFSNsXMNRLeH38wYHTmlmsE5XiN994SBH9Gxm2gr2conkqGEhuhjG2gh5mYaSrSP
 MTrdnjwIqmRfmE0wGniOW2KIwIBJHvV4lfp7/ssc/57Qu7F+V0htt2kqOvt8ijk0iLVCH3xPf23
 EaVWWcfk1Qz7FhztCkGnOe8KrhNcbLtMMbjWq6xyV08sA3gB/3Ngx7EeybGy/dTIrR0HqskSh3K
 31SfmigUDY4J1NuC4oRu/gnOeM7V3kCcCbClxVSd0NLPdOkaxd8yTdhyZwBsvk/xBUCiWvSA1sA
 yFsZ8AEqpOloGlsGKwN9Nqp+xFSwHOwdqPR0KmSYC6LwKfA8TmYOsr4YF56kVbDS9b7As4kBjRm
 z0mIY7yFHMDDXCJoZsu6Q/QrN2/Sq4QIE8E+iwZhShGnzSBeiD6x/+l46vR8MAPaJmcPbRaeAzM
 xJ+QAx/KAXfHVzxGGBH28X5c/xLGV8XlNOECWxOXk/jZAygJBCwvifkM9OE4LKWuK+DJwkTNP4v
 KwPrdkn1Y9Z1HJ2e1hr/gLBjUjAEpTLK5+kQqDsB2ld0Je32UzMMyNgodBWu2+/05qQ/wlyQ0Wf
 46uFO1TX4BPgkxLyJnj6t1up7IhiSG1OYxqYlBtE=
X-Received: by 2002:a05:600c:811a:b0:4a6:b49f:9ae5 with SMTP id
 5b1f17b1804b1-4ac18e5dac8mr287441665e9.34.1793726468458; 
 Tue, 03 Nov 2026 09:21:08 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:8b77:19e1:26f7:89f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac08b72579sm8800675e9.2.2026.11.03.09.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:21:07 -0800 (PST)
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
Subject: [PATCH 3/4] drm: renesas: rz-du: mipi_dsi: Improve DSI PLL parameter
 selection and cache results
Date: Tue,  3 Nov 2026 17:20:56 +0000
Message-ID: <20261103172057.617203-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Mode validation searched the divider table once, kept the best CPG match
and only then checked the DSI PLL. A divider losing on CPG error alone
was never tried against it, so reachable modes were rejected.

Evaluate each divider on its own and keep the one with the smallest DSI
PLL error, handing it to the CPG via rzv2h_cpg_cache_pll_pars(). The
search also takes the PLLDSI instance as an argument and records it,
walking the instances described by the new num_limits field.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 87 ++++++++++++++-----
 1 file changed, 66 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 5b257f5adf06..682bbb339bef 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/limits.h>
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -55,6 +56,7 @@ struct rzg2l_mipi_dsi_hw_info {
 		const struct rzv2h_pll_limits **limits;
 		const u8 *table;
 		const u8 table_size;
+		const u8 num_limits;
 	} cpg_plldsi;
 	const struct rzg2l_mipi_dsi_timings *dsi_global_timings;
 	unsigned int num_dsi_global_timings;
@@ -69,7 +71,9 @@ struct rzg2l_mipi_dsi_hw_info {
 
 struct rzv2h_dsi_mode_calc {
 	unsigned long mode_freq_khz;
+	unsigned int pll_instance;
 	struct rzv2h_pll_pars dsi_parameters;
+	struct rzv2h_pll_div_pars cpg_dsi_div_parameters;
 };
 
 struct rzg2l_mipi_dsi {
@@ -671,43 +675,83 @@ static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_f
 	return 0;
 }
 
-static unsigned int rzv2h_dphy_mode_clk_check(struct rzg2l_mipi_dsi *dsi,
-					      unsigned long mode_freq)
+static unsigned int rzv2h_dphy_check_instance(struct rzg2l_mipi_dsi *dsi,
+					      unsigned long mode_freq,
+					      unsigned int pll_instance)
 {
 	u64 hsfreq_millihz, mode_freq_hz, mode_freq_millihz;
+	struct rzv2h_pll_div_pars best_cpg_dsi_parameters;
 	struct rzv2h_pll_div_pars cpg_dsi_parameters;
+	struct rzv2h_pll_pars best_dsi_parameters;
 	struct rzv2h_pll_pars dsi_parameters;
+	bool found_valid_parameters = false;
 	bool parameters_found;
-	unsigned int bpp;
+	unsigned int bpp, i;
 
+	best_dsi_parameters.error_millihz = S64_MAX;
 	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 	mode_freq_hz = mul_u32_u32(mode_freq, KILO);
 	mode_freq_millihz = mode_freq_hz * MILLI;
-	parameters_found =
-		rzv2h_get_pll_divs_pars(dsi->info->cpg_plldsi.limits[0],
-					&cpg_dsi_parameters,
-					dsi->info->cpg_plldsi.table,
-					dsi->info->cpg_plldsi.table_size,
-					mode_freq_millihz);
-	if (!parameters_found)
-		return MODE_CLOCK_RANGE;
-
-	hsfreq_millihz = DIV_ROUND_CLOSEST_ULL(cpg_dsi_parameters.div.freq_millihz * bpp,
-					       dsi->lanes);
-	parameters_found = rzv2h_get_pll_pars(&rzv2h_plldsi_div_limits,
-					      &dsi_parameters, hsfreq_millihz);
-	if (!parameters_found)
-		return MODE_CLOCK_RANGE;
+	for (i = 0; i < dsi->info->cpg_plldsi.table_size; i++) {
+		parameters_found =
+			rzv2h_get_pll_divs_pars(dsi->info->cpg_plldsi.limits[pll_instance],
+						&cpg_dsi_parameters,
+						&dsi->info->cpg_plldsi.table[i], 1,
+						mode_freq_millihz);
+		if (!parameters_found)
+			continue;
+
+		hsfreq_millihz = DIV_ROUND_CLOSEST_ULL(cpg_dsi_parameters.div.freq_millihz * bpp,
+						       dsi->lanes);
+		parameters_found = rzv2h_get_pll_pars(&rzv2h_plldsi_div_limits,
+						      &dsi_parameters, hsfreq_millihz);
+		if (!parameters_found)
+			continue;
+
+		if (abs(dsi_parameters.error_millihz) >= 500)
+			continue;
+
+		if (abs(best_dsi_parameters.error_millihz) > abs(dsi_parameters.error_millihz)) {
+			best_cpg_dsi_parameters = cpg_dsi_parameters;
+			best_dsi_parameters = dsi_parameters;
+			found_valid_parameters = true;
+		}
+	}
 
-	if (abs(dsi_parameters.error_millihz) >= 500)
+	if (!found_valid_parameters)
 		return MODE_CLOCK_RANGE;
 
-	memcpy(&dsi->mode_calc.dsi_parameters, &dsi_parameters, sizeof(dsi_parameters));
+	memcpy(&dsi->mode_calc.dsi_parameters, &best_dsi_parameters,
+	       sizeof(best_dsi_parameters));
+	memcpy(&dsi->mode_calc.cpg_dsi_div_parameters, &best_cpg_dsi_parameters,
+	       sizeof(best_cpg_dsi_parameters));
 	dsi->mode_calc.mode_freq_khz = mode_freq;
+	dsi->mode_calc.pll_instance = pll_instance;
+
+	rzv2h_cpg_cache_pll_pars(best_cpg_dsi_parameters, pll_instance);
 
 	return MODE_OK;
 }
 
+static unsigned int rzv2h_dphy_mode_clk_check(struct rzg2l_mipi_dsi *dsi,
+					      unsigned long mode_freq)
+{
+	bool found = false;
+	unsigned int i;
+
+	/*
+	 * Check every instance instead of stopping at the first match, as
+	 * rzv2h_dphy_check_instance() hands the parameters it computes over to
+	 * the CPG, which needs them for whichever PLLDSI ends up feeding the
+	 * encoder.
+	 */
+	for (i = 0; i < dsi->info->cpg_plldsi.num_limits; i++)
+		if (rzv2h_dphy_check_instance(dsi, mode_freq, i) == MODE_OK)
+			found = true;
+
+	return found ? MODE_OK : MODE_CLOCK_RANGE;
+}
+
 static int rzv2h_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_freq,
 				u64 *hsfreq_millihz)
 {
@@ -715,7 +759,7 @@ static int rzv2h_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_f
 	unsigned long status;
 
 	if (dsi->mode_calc.mode_freq_khz != mode_freq) {
-		status = rzv2h_dphy_mode_clk_check(dsi, mode_freq);
+		status = rzv2h_dphy_check_instance(dsi, mode_freq, 0);
 		if (status != MODE_OK) {
 			dev_err(dsi->dev, "No PLL parameters found for mode clk %lu\n",
 				mode_freq);
@@ -1647,6 +1691,7 @@ static const struct rzg2l_mipi_dsi_hw_info rzv2h_mipi_dsi_info = {
 	.dphy_mode_clk_check = rzv2h_dphy_mode_clk_check,
 	.dphy_conf_clks = rzv2h_dphy_conf_clks,
 	.cpg_plldsi.limits = rzv2h_plldsi_limits,
+	.cpg_plldsi.num_limits = ARRAY_SIZE(rzv2h_plldsi_limits),
 	.cpg_plldsi.table = rzv2h_cpg_div_table,
 	.cpg_plldsi.table_size = ARRAY_SIZE(rzv2h_cpg_div_table),
 	.phy_reg_offset = 0x10000,
-- 
2.56.0

