Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3C7C55172
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 00:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D1710E3B7;
	Sun,  2 Aug 2026 00:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jDYxRDST";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3E310E3B7
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 00:25:17 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-51c2a449c57so12524521cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 17:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785630317; x=1786235117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HCbeBbjb0f0nGQRpPw2NSesFjBrvxC65KWjIuP4Aw/E=;
 b=jDYxRDSTt99q0pE75gZ+xtv2ZD/olE6CVpUOQkTvc9Yrv795+sKYhsiMyqz1XjaQxZ
 yoPKRwaPtUjjxnWrtg8FnRuTFryH7/5WVlv9pCup1oXJ7kXW1YJDXOdEb3dUs6d2g2Mn
 P2gAxHyCbytdnuAXFE1cYUhrJK25YmH5eTo4bm5dROErJjsZFb+bHOjcGPVOu1f6+pc/
 ButehHCPp+dFZx06YL7tJXDKZ9e4wqYN7EuuKGpuZUUxF4ChMcdoh5g5/hnDRz1vMs3/
 EJ6YLijIQGdN1AVO+ojGk4iZAyLDcU0EgLbfy+KFOUJs71gsUzko5/8ipNbpmzdbqAaA
 JRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785630317; x=1786235117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HCbeBbjb0f0nGQRpPw2NSesFjBrvxC65KWjIuP4Aw/E=;
 b=T2DkpwVvWKnOvNhXmEmFPH24T8C8sNqom5tw5ipYV1sw4pwVM8H8n2P+gNN40kQ22G
 V2z2AwfFhuEvbfYXSQGT7qWXT0IcdgyxOYXljpoWzUt/J3QxA0NndHJo/Pi98j1Be18v
 C9X+WWlpedMyItNiXsvuWR28puSNROPQBC22zytoCC7kPr/NcN0acquYD9kSc639Gsal
 FXLpgaRmapXIUZkXGF0IIYujNq+jPmgwCC/mIsdWRaLgSH2zH3vgxAz5Q8PY2+8C+pyS
 6EQrDlXLftkferuWFmfY/rG3qZCuJyV172eRvep9b9YqXWvgDMZ1InC8nNeKDt5Sai8y
 hwQQ==
X-Gm-Message-State: AOJu0YzjH23mu3cNLv63eohh284OBZPWJcK1RwalVBwlk6TlKcMTDicR
 mB9BvA4MbHMck+pM+SldemSA1CZM/KoGbC/8XSSI188XhevhELoIdRsz
X-Gm-Gg: AR+sD11DasyDgytO+UdyDlDc19odOnMUVLYg5g2rn9gl6FgthD3DARPdfVIzifmhtfZ
 NzZB/JzXBFldxunvc/Hn/a87JmPbS9WR4HUJsvflSsgFr5wugwhlwjdTd3W5pAlL5nWYrWklxCP
 O1LjUcHLDFVJ2bm2PGa4kFHKLaqULXSjZUw0scHe4JuSfrURSV/KvorgT5JupSgASHftWaggX6u
 c6ID5qIGC7LXrNBPEWABn/3jMB9j8NsrRBKj6e4eeHMspaIx3nKGjt4skzjwCZvtNgDnxJCzhHs
 TRCocbp2rFgJzhpynQMeAe5Gv2UVhundbiA5vYMSatOaEgqctIhTpPijtH7Pck0gGB0AaIhwN24
 tJJ8x4YmavONN463pN7y0oI/4BsBxy2P4maM6o/K1++3NBl7kuX2vsIkW+GOOOnKZ/WrfMRcec/
 4mHkj5mHKt8ZxbcrUv8nTTMm96Nj4N6Eq45Hvz/srTIbIWWTlznuXOZM7btkR5h1TJdqzYCu7Dc
 1feknqfUNO6+5hgUSFzIHhsI0J5jiaMIuAKHAHEj3Gk1KqzLYFp3K8dWu/f990=
X-Received: by 2002:a05:622a:1e0f:b0:51c:21d1:3852 with SMTP id
 d75a77b69052e-52b5676001fmr113318251cf.5.1785630316656; 
 Sat, 01 Aug 2026 17:25:16 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52b4e859ccdsm34497631cf.13.2026.08.01.17.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 17:25:16 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: anitha.chrisanthus@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] drm/kmb: Handle DSI clock enable failures
Date: Sat,  1 Aug 2026 20:25:12 -0400
Message-ID: <20260802002512.486369-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Disable clocks that were enabled before a later DSI clock fails, and
track whether the complete DSI clock set is enabled so teardown does
not disable partially initialized clocks.

Propagate kmb_dsi_clk_init() failures through the display hardware
initialization path instead of continuing with a partially initialized
DSI device.

Fixes: 98521f4d4b4c ("drm/kmb: Mipi DSI part of the display driver")
Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 6 +++++-
 drivers/gpu/drm/kmb/kmb_dsi.c | 9 +++++++++
 drivers/gpu/drm/kmb/kmb_dsi.h | 1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..fef76d6781b4 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -61,6 +61,8 @@ static int kmb_initialize_clocks(struct kmb_drm_private *kmb, struct device *dev
 	drm_info(&kmb->drm, "system clk = %d Mhz", kmb->sys_clk_mhz);
 
 	ret =  kmb_dsi_clk_init(kmb->kmb_dsi);
+	if (ret)
+		return ret;
 
 	/* Set LCD clock to 200 Mhz */
 	clk_set_rate(kmb->kmb_clk.clk_lcd, KMB_LCD_DEFAULT_CLK);
@@ -130,7 +132,9 @@ static int kmb_hw_init(struct drm_device *drm, unsigned long flags)
 		return ret;
 
 	/* Enable display clocks */
-	kmb_initialize_clocks(kmb, &pdev->dev);
+	ret = kmb_initialize_clocks(kmb, &pdev->dev);
+	if (ret)
+		return ret;
 
 	/* Register irqs here - section 17.3 in databook
 	 * lists LCD at 79 and 82 for MIPI under MSS CPU -
diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index 59d0e856392f..07dc4e324426 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -175,9 +175,14 @@ mipi_hs_freq_range[MIPI_DPHY_DEFAULT_BIT_RATES] = {
 
 static void kmb_dsi_clk_disable(struct kmb_dsi *kmb_dsi)
 {
+	if (!kmb_dsi->dsi_clk_enabled)
+		return;
+
 	clk_disable_unprepare(kmb_dsi->clk_mipi);
 	clk_disable_unprepare(kmb_dsi->clk_mipi_ecfg);
 	clk_disable_unprepare(kmb_dsi->clk_mipi_cfg);
+
+	kmb_dsi->dsi_clk_enabled = false;
 }
 
 void kmb_dsi_host_unregister(struct kmb_dsi *kmb_dsi)
@@ -1494,15 +1499,19 @@ static int kmb_dsi_clk_enable(struct kmb_dsi *kmb_dsi)
 	ret = clk_prepare_enable(kmb_dsi->clk_mipi_ecfg);
 	if (ret) {
 		dev_err(dev, "Failed to enable MIPI_ECFG clock: %d\n", ret);
+		clk_disable_unprepare(kmb_dsi->clk_mipi);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(kmb_dsi->clk_mipi_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to enable MIPI_CFG clock: %d\n", ret);
+		clk_disable_unprepare(kmb_dsi->clk_mipi_ecfg);
+		clk_disable_unprepare(kmb_dsi->clk_mipi);
 		return ret;
 	}
 
+	kmb_dsi->dsi_clk_enabled = true;
 	dev_info(dev, "SUCCESS : enabled MIPI clocks\n");
 	return 0;
 }
diff --git a/drivers/gpu/drm/kmb/kmb_dsi.h b/drivers/gpu/drm/kmb/kmb_dsi.h
index 0faadeb9f1dd..8fafcf0d2a96 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.h
+++ b/drivers/gpu/drm/kmb/kmb_dsi.h
@@ -76,6 +76,7 @@ struct kmb_dsi {
 	struct clk *clk_mipi_ecfg;
 	struct clk *clk_mipi_cfg;
 	int sys_clk_mhz;
+	bool dsi_clk_enabled;
 };
 
 /* DPHY Tx test codes */
-- 
2.43.0

