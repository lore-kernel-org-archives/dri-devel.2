Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED806CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4453A10F3E4;
	Wed, 30 Sep 2026 13:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nY2UWjV0";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C358D10F3E6
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:09 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b00a0ac65so443939f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775188; x=1791379988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=orKEr4pkx6Zt8Sr9/e1yt+mrcqNsohd1zJEtkEI7wlw=;
 b=nY2UWjV0+yK9MAcjb4ThKECRSOezze6p8x2hpiO0NPB7wnvG5BnwpNWYNCHyiLjCLI
 2TIME1e/t6Ig4AQcuEmJDwiGDfnuoYAuoR4+7aHs8E4ZQs2+yErBC73dw8zN5TcaYV2Q
 iUfbHZFM/C7uks2NbZh/UzsssZYxr2vPcoNYgT8yDrqs/JX68iJvYzJ+1G99+q0uJuXP
 ct0onDn2EWNfzx6C469vajUDZjJWkbrAe/hMVod0ABxpXkA4ykaui3dmT0cn9At+ZfHt
 HhLK3LHg9HVOM+4b9eA7xqJREWPNco1APH069uVaVZPEM4in5gpgEl2qjVQYQsVyw2+f
 SXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775188; x=1791379988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=orKEr4pkx6Zt8Sr9/e1yt+mrcqNsohd1zJEtkEI7wlw=;
 b=Biq7M2aYL0nqujm5fXG5y0ndotZvYjyAOU4T5aFIvW2+qkxDWKRV48zCWf2ENWSPZC
 ZnxmU+zqU5ni4SdFlkAARPz81lhBfltxcFFknUBi1Z1qtY97EVcVZeTT8PB1/7HfjNOI
 tJAsNtcIuLe85yhCYL2WQSomArcagYeJgvpGpe6i83PdKO5iOLtroM97CLzx06JdlQKE
 CkAZiFZLHsLQJorMPIeLidFimJm4v5DFRmot9k93kqUzbFv4r+sOavcjXZGKuuEvOAeQ
 6KuB8kZiCWvVUmp3x+H+lWjbPsSUsb+Nf9504Wtgwb9KvOq/6pCnANcicU5hUIPOHEla
 TbSQ==
X-Gm-Message-State: AFq9FYI38RByIfwOdW6qtPPX0wnLLqkLlewmOLplwIlhj16LWe8WztsI
 ZUrN5npMUnxHChtUK/Gm+XQSlWofReIP1TgbNO0PnUaVEpMTnf8U9HUl
X-Gm-Gg: AYBFou3nd6J9HsdkUPie3uPn22wpcp175U9MdL/+hFOekhh6KK+Z3wTGxwbysEIuB/6
 CTwi3fNYdKatAHh+FSoR7uzLT+oJl5xZ07torTqimaOu6z38seNyAPKxue1mCi6hS4kfxXfA3Q+
 MpRULEYFBn1qkb62RWNmo2fAT2DE9SMrBNSuO5jAzyqAmhKxoZwVyR2yYVLSKBP+5rxF4lqnTD5
 FLGrg8wa4uMa6ff2WeXEAO1pp28+6ejtKEHTVKSpwpNM4pz/1qwaZnbEptVcq3dtRfz7gJ/5Zam
 7RTWSw4N/AbgZveAry6qaoLp4U0Op9+tTwPlPuT0JbvXbEHSvuwS+eSw07nN9tz02yeepMP/c+w
 tJG4w8Jg/dnuVe2PO+Fw9IlPejDV/Plm6jeQUQvM14zatvVpi3SvatMT46XJUxPd3L++AX5Zz7V
 I3Icn5712TzA2XRjbXgiJoXZuQf00DWsN4rvYhLNi3JQpAamWlw3oWBm7tcMKJL/eQWgiFhi3il
 8rXwTysngUOtaWS7GwyjO0=
X-Received: by 2002:a05:6000:4807:b0:48a:f592:fb63 with SMTP id
 ffacd0b85a97d-48b050badd7mr663766f8f.1.1790775188127; 
 Wed, 30 Sep 2026 06:33:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:bade:1500:bcd:b3ec])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f2b02sm3685582f8f.24.2026.09.30.06.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:07 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 4/9] drm: renesas: rzg2l_mipi_dsi: Add support for DSI
 PWRRDY
Date: Wed, 30 Sep 2026 14:32:46 +0100
Message-ID: <20260930133257.23210-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
References: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
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

The register for controlling power to the DSI region is in the SYSC
(System Controller) block. Add support for controlling the DSI PWRRDY
signal so the driver can efficiently manage power to the DSI region.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Dropped pwrrdy variable from struct rzg2l_mipi_dsi_hw_info and instead
   using feature flag RZ_MIPI_DSI_FEATURE_PWRRDY
 * Dropped rzg2l_mipi_dsi_pwrrdy_off() as it is taken care by
   devm_pwrseq_get(). 
v2->v3:
 * Updated powerseq API names.
v1->v2:
 * Switched to power sequence for handling pwrrdy signal.
 * Dropped header file regmap.h and mfd/syscon.h
 * Added header file pwrseq/consumer.h
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index d67e1230b70c..5263b2b8f1ca 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -18,6 +18,7 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/units.h>
@@ -38,6 +39,7 @@ MODULE_IMPORT_NS("RZV2H_CPG");
 #define RZG2L_DCS_BUF_SIZE	128 /* Maximum DCS buffer size in external memory. */
 
 #define RZ_MIPI_DSI_FEATURE_16BPP	BIT(0)
+#define RZ_MIPI_DSI_FEATURE_PWRRDY	BIT(1)
 
 struct rzg2l_mipi_dsi;
 
@@ -87,6 +89,8 @@ struct rzg2l_mipi_dsi {
 	struct clk *vclk;
 	struct clk *lpclk;
 
+	struct pwrseq_desc *pwrseq;
+
 	enum mipi_dsi_pixel_format format;
 	unsigned int num_data_lanes;
 	unsigned int lanes;
@@ -1396,6 +1400,25 @@ static const struct dev_pm_ops rzg2l_mipi_pm_ops = {
  * Probe & Remove
  */
 
+static int rzg2l_mipi_dsi_pwrrdy_init(struct rzg2l_mipi_dsi *dsi)
+{
+	if (!(dsi->info->features & RZ_MIPI_DSI_FEATURE_PWRRDY))
+		return 0;
+
+	dsi->pwrseq = devm_pwrseq_get(dsi->dev, "dsi-pwrrdy");
+	if (IS_ERR(dsi->pwrseq)) {
+		/*
+		 * This platform requires a sequencer. If we can't get it, we
+		 * must return the error (including -EPROBE_DEFER to wait for
+		 * the provider to appear)
+		 */
+		return dev_err_probe(dsi->dev, PTR_ERR(dsi->pwrseq),
+				     "Failed to get required power sequencer\n");
+	}
+
+	return pwrseq_enable(dsi->pwrseq);
+}
+
 static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 {
 	unsigned int num_data_lanes;
@@ -1454,6 +1477,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dsi);
 
+	ret = rzg2l_mipi_dsi_pwrrdy_init(dsi);
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(dsi->dev);
 
 	ret = pm_runtime_resume_and_get(dsi->dev);
-- 
2.43.0

