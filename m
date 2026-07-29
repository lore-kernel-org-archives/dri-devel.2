Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F269EC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3117510EBF8;
	Wed, 29 Jul 2026 12:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="axZQ/Di6";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F57110EC03
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:32 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so564918f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329731; x=1785934531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AJ88tlR3PQHW+zOWbGYqc/0EZpxNXGTOLvGqYwJVskA=;
 b=axZQ/Di6k9f5sB1triJv1qOM8+Gu3DQPQMzybrkjQJX4lrlpcO4fgPOgoE1weHB0rv
 6fkL4EinxoEzxYNO8wobaCqCWqOpfKESwdxyGZWJ5yhv+jReY8ea/3ZS/4JUgfU8BgyV
 /4anU6f9kComq5VHnZabddwcBC1gFcUnp11zDd4pVFat/jN7IDIj7tpwOzn1CsGAu82w
 bmEBk0irMzt25CYgpZPm69R4idwO6U+9zdvaw+uOWwX/FemfFGDLUq1VTUMag4xQ/A9/
 TmrAMv1YfL4xMZwzhIbkCuWxKCkPrEFOOiQsrsTMFluZxgyqTxiVdNkb6MBjYQ8mwHXh
 SGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329731; x=1785934531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AJ88tlR3PQHW+zOWbGYqc/0EZpxNXGTOLvGqYwJVskA=;
 b=DZIbg/1YNCgXCnUJ9Tz7NQgNfYBqAlpZ0ftW1zZAf0Zyj6DQYC2S9Ca2iEr4rAqk1z
 1MQ8F3zcxj0q7Pd6jNDgBCPAz0Zv4gBXUm3EzOXdq7JaSprX+IUdND/ner0GGV0KLwRb
 2OAQW81mW9nwFc19xKoVVIsdReaeK+rU32fkzo8I8leW9U1a49FvhpmbYABlWlUxXEQj
 e5VGz4NUZ2OnEjtf0K8pHc18p5V/EY0+fO7DRGMbpAgGJW0Oeje8h5hombIKAQtjBG2H
 iiBvfQkAdCV3T41K3xYpxRL3P0wBhogTHsvwjEAk/YW/JZQe0MZ01ncVanQKje8Wciea
 4wfQ==
X-Gm-Message-State: AOJu0Yxg/eB1NTE6Yz2OkGmjsunUHhgZ4cBmdwdVhLNESX51pkf5U3nF
 kBMwdwF6cZpItC1WTs1Uv28KslR9+DEX16EZIS0fB+EhOHfOIGbxeEAoI/ewig==
X-Gm-Gg: AR+sD11ets12P+QPsY19wCNgV/KjJL5lvnIDJ5eT+qTGZquz3jrC3WVfUEkv7fpIFqm
 8U4NSC9GoXSXVbO83yTLe3fQeAcqGPuQeQYu5e1tSD5p3tROg1+j6J7k0mfIlum8/SstkKMrzHh
 TdI4HFRyxIXxIym01uvdOKD+yMs797aDVUZ8eqXP3epvHOsd1GfB/vUMq/Vduy139O6V2iogzMK
 aY473Nm0EJTPW4EPkDCRDGVPFAOmQtfQEVb6mfIB/XeUjaw8yRjVIuRJ97W2SvGTsM2yZcJavjG
 fOTVfrl99MGn+91TopEMK2yxu5l0dsgkHcFETMR3JIFWyW8bLzE72yt8W3YIPyK3t7k16O/O2Ki
 p20UN29Nl7/3BX7RbaM5WxZj3lunhFhjdcddsozq3wTjrS7YkTTv1CecePKiv8khJho02LghVde
 xSb/FJJv+n0+lq3C9c9Ux/Nzfdg9oVQOsfnqfuZiMvNpr8JsSOO4q6nzq5xcWZts2m8R7SrvLHw
 7yU+etUstXSIA==
X-Received: by 2002:a05:6000:400f:b0:46e:7f72:b6fe with SMTP id
 ffacd0b85a97d-47fb1ed8623mr8294416f8f.19.1785329730769; 
 Wed, 29 Jul 2026 05:55:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:29 -0700 (PDT)
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
Subject: [PATCH v2 05/16] drm: renesas: rzg2l_mipi_dsi: Add support for DSI
 PWRRDY
Date: Wed, 29 Jul 2026 13:54:57 +0100
Message-ID: <20260729125516.230757-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
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
v1->v2:
 * Switched to power sequence for handling pwrrdy signal.
 * Dropped header file regmap.h and mfd/syscon.h
 * Added header file pwrseq/consumer.h
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 180384c10264..7fdcee98450b 100644
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
@@ -63,6 +64,7 @@ struct rzg2l_mipi_dsi_hw_info {
 	unsigned long max_dclk;
 	u16 activation_dly;
 	u8 features;
+	bool pwrrdy;
 };
 
 struct rzv2h_dsi_mode_calc {
@@ -87,6 +89,8 @@ struct rzg2l_mipi_dsi {
 	struct clk *vclk;
 	struct clk *lpclk;
 
+	struct pwrseq_desc *pwrseq;
+
 	enum mipi_dsi_pixel_format format;
 	unsigned int num_data_lanes;
 	unsigned int lanes;
@@ -1396,6 +1400,36 @@ static const struct dev_pm_ops rzg2l_mipi_pm_ops = {
  * Probe & Remove
  */
 
+static void rzg2l_mipi_dsi_pwrrdy_off(void *data)
+{
+	pwrseq_power_off(data);
+}
+
+static int rzg2l_mipi_dsi_pwrrdy_init(struct rzg2l_mipi_dsi *dsi)
+{
+	int ret;
+
+	if (!dsi->info->pwrrdy)
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
+	ret = pwrseq_power_on(dsi->pwrseq);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dsi->dev, rzg2l_mipi_dsi_pwrrdy_off, dsi->pwrseq);
+}
+
 static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 {
 	unsigned int num_data_lanes;
@@ -1454,6 +1488,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dsi);
 
+	ret = rzg2l_mipi_dsi_pwrrdy_init(dsi);
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(dsi->dev);
 
 	ret = pm_runtime_resume_and_get(dsi->dev);
-- 
2.43.0

