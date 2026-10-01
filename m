Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56114CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0591A10F5D9;
	Thu,  1 Oct 2026 09:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HiOeSsvA";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E41D10F5B1
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 09:40:50 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e66390995so36297025e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790847648; x=1791452448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHkWO7aBhfER+SNZ+kSaAkHEYBGMw8cJJ5ZRGj4410k=;
 b=HiOeSsvA4V5y/w0yqQG1acO1P3RwMf2Sty/noxGqgLotEu5pRJ9gbtErJ0NdVaWNFA
 9AMKr1XYAKhrgbPmkSGP1KMEdiFWk9j/8kMAPXeWmtKgbXb+V0EK0kjeAay15DXJ/3NJ
 +Iv0ylSk2dgH0lVTKl2EOiaT3oaI71Bx93kOD9h0aUZT6mO2/9mgdMabfhU4Ix2DaQuL
 bKU0zbmMKX6TkKx1Z4OOlTB2qLUWwnngHhsu3dkM1OvwlkD4SkU70fuQZTOxtLZjdmZp
 fbGQIwK4DhXqKBRjnz5dLl485CBC52H8OZvbYv5DNP0grPjSexXcRmBGq0abtMhqd7oG
 cn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790847648; x=1791452448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uHkWO7aBhfER+SNZ+kSaAkHEYBGMw8cJJ5ZRGj4410k=;
 b=2u54OuQpQH3Mh/JpFqG73yaqv86GpZklEMM88b4a1Rv/BChIhK1gJX9PrMa1BaPG94
 l9rT53s3is87rUqucBG5mx7SmqxRmpfjNBTDq1BdwyaQnz8w7PlZuJeKKjtsrWAdV5yq
 q+4vDKgkeUpSgHrskIWj5UBdldk+i1QTYmOZDoNvOOxZfFSuK/8n7C0FPGoK5sacRb4F
 r70yp9Ngjz9//UTZoJGl2QEROi2zKyiNEG5/q5eAKrKULk+4HUIltkzASiXTDaXcwTAD
 DoyHvNc025deCyrHS/4O9PkeVIqYbaCr92TlHkZOFesMOC+XwMNtKREEzDjoX25dH4cA
 TNpw==
X-Gm-Message-State: AFuF++kYgpW/JNf9lMW6JCRioRrL7OdoVg0T2EL323mRaB6S/nP1BBFd
 VZqiLhJndgk/aXaCeAYIyguL1tHQDJfmY/6hPgYxfR4kRDbrDNw5ynRJ
X-Gm-Gg: AYBFou0VLKFpy0fDWY8NeiKXXAE2rHqI0AqkHsyY8GWG7ZkMMYmXJ4ka7Wg0bmVIVNd
 RWRuAscU55jUc5RS9HyYfGxMs6uC/vS8+6hbo+1bb31Y8Drl7UVmJGq9xChg906VsGLEMNfSIhg
 utuI/lfGTwRCfHdZgxED6clgVZZETKi5OFX+LsCfG/Fg7xVg2iJtMNGy0LLfkM13RBwnkn7csWT
 20u2E11dDAxunCbDHuvjprG0E0EuALvj6n95w57aA/sPAtDb0NNvH9qLuxc12jVQXo2RXB5r4v9
 kWxzGg1nkVG0PtRcTU0RCR92BRUkzdt481hClGy0zI5adD6r7e1iQLqNRkBgy/jX6YWkFQ8qrJA
 u3Az/0ihg89I9khtIqMy+vRMb+8ZwtLNO5YNCNXRA/ugWSAA2RzTJy4wCowyt2CBYx99GfHMKOd
 kNhhcZqVkTQfQOsyXn0hFQ0VaOnak7ZuYCokykztTVzh5KPxRUvo03TWF5VsJ1JooBtpasXFQC/
 tHl
X-Received: by 2002:a05:600c:1c28:b0:4a0:1aa0:7cfa with SMTP id
 5b1f17b1804b1-4a01afec062mr78985955e9.12.1790847648194; 
 Thu, 01 Oct 2026 02:40:48 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:5563:a938:8fc:9dc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0226201aasm38937725e9.6.2026.10.01.02.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:40:47 -0700 (PDT)
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
Subject: [PATCH v5 4/9] drm: renesas: rzg2l_mipi_dsi: Add support for DSI
 PWRRDY
Date: Thu,  1 Oct 2026 10:40:19 +0100
Message-ID: <20261001094041.135697-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001094041.135697-1-biju.das.jz@bp.renesas.com>
References: <20261001094041.135697-1-biju.das.jz@bp.renesas.com>
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

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Collected tag.
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

