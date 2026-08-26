Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB15AC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE56310E530;
	Wed, 26 Aug 2026 17:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TBTZq0lz";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B7F10E32C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:49:03 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so181655466b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787766542; x=1788371342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/wefi0qFeMhOmINeqEFWhtcGoedNIJiFtYqNbodY4QM=;
 b=TBTZq0lzVvzclN8a4HTHdcB9vqlgag0rnI+e8cSpOu3d9OJXGGItHKeofkm8h/7YlQ
 Beri0FDMgV9M2H6yVWuaYwJM16RG76dhvMrspf47l6AXOv/Q5T3qZwTsjD4hqw1goUPx
 jxqjCvYdqhj5k8UAuLHcgW1oTbz+Ietb2P2dh+cHASljqx2S3O9PCc/J+nuzc5/uKKns
 jIhW6DFqqBPAl7Wn+hCWHyBn8vI9ZsNNQnCNMxjq511kXnSR98XEHZ1zHhRObUoc0rVD
 8Sijcsf9cx61eC9ToyFg1PbmFD0cYVWFHJUZd5Yt3g2nXSHmJl2CFn/dbHxqGHDEZ9a2
 jtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766542; x=1788371342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/wefi0qFeMhOmINeqEFWhtcGoedNIJiFtYqNbodY4QM=;
 b=P1A4cCjWoTrKtqX7e4WUud2DRk3djn09lQ+Kcm6Sx7QH7k3/XLMu55c93hm4cGoRPt
 l9gAhl1XkI0rijaj7hyzyZDMcPzLOQwrcvu21xnqg5chn0D75G8wUJ9F2cYlJEYkh+WC
 86bHO1fmat5Aj6g95B7rcMBE41CJY3nKPn9HukHwKOMVnchpBQYSYBcg19bVNEl6JvK2
 c9snn5h1ZVjvGBrA75DtaZ61nJufhOO7thK6V82xUysNfJ08XL2ljfeE1IXr9F8PBhie
 LwigLjLL4TmUvB0rRKjS0O0UeA7p3XWktRA++gE3VQuKRsJyPpO9t6S8s17murf30H0q
 ebOw==
X-Gm-Message-State: AFuF++lAjFoByg9kHmc2wwMPdkiwKXQnFl3pksDBlItyjNxBObD4Y+1e
 xp6iEthV+e3Gzaj5B/ZOuoj4rf44KvFYhElVVM3uXbYSnU9uLcD+ByCa
X-Gm-Gg: AR+sD13AahBPSf0JI5qIvoOxtbDkIUGNsLFXRzeeTr7DepPdd6ZcxDXNHH2UODRq8IW
 mhqUCiPR3WqEO+45dCkwKf2QbpRvxKnFdSglmZNuQB1/kU+LCewz6LMM2wvRoPpU8KdZIJaDgLs
 OlZx8u+HmN5Dm4PcvkH58i81Q+pELjsyiXFgEUDwSDyZBIeDVxT8ikUaSDPgx1UQU7hTW1wcroO
 kwP94IUFsk4lTBnGm9/06qKcIglDv6SvixSs315OmiyTwOwnhilZ7GNbetdm2l6TvjXod7ds7AV
 /G0LTdItD9K/Lx0ychBPWqExOrQeweswOpX8gTCwKg/MXV/tXpMoj3hcecaX9IM9IZi1u431gDP
 x0jz6u5xb0D6qmq/WSAlCx+XiGAMXr8CdcAffEBxQnsHyY0iIqRoSshKvbWVYkuP12IXsoj5EMq
 SkmLMvQ2vpZZFQxO390aDcS3u19VFPW9dIVQyweF5QEMxfMeV23LpDfR5m6cJe7aPxiTjT/Hh+L
 YN8XfNxo1j4uRkfIt/xaFy7
X-Received: by 2002:a17:907:1c86:b0:c20:edda:ef5b with SMTP id
 a640c23a62f3a-c250c595d62mr954414166b.14.1787766541633; 
 Wed, 26 Aug 2026 10:49:01 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:aa64:3da0:a259:ecd5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac7fsm777752766b.30.2026.08.26.10.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:49:01 -0700 (PDT)
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
Subject: [PATCH v3 04/13] drm: renesas: rzg2l_mipi_dsi: Add support for DSI
 PWRRDY
Date: Wed, 26 Aug 2026 18:48:38 +0100
Message-ID: <20260826174854.199139-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
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
v2->v3:
 * Updated powerseq API names.
v1->v2:
 * Switched to power sequence for handling pwrrdy signal.
 * Dropped header file regmap.h and mfd/syscon.h
 * Added header file pwrseq/consumer.h
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index d67e1230b70c..7df5f4a4161b 100644
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
+	pwrseq_disable(data);
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
+	ret = pwrseq_enable(dsi->pwrseq);
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

