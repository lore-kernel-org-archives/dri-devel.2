Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD2606A32E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XdkifGLD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5128910EBE6;
	Mon,  2 Nov 2026 08:04:24 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CF110E554
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:22:28 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-35b2c599f43so4272501eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 23:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793604148; x=1794208948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JB/vt8Yqalu6xBIjfgP9QfXpUFDcSpikq6HleBSGoog=;
 b=XdkifGLDqYkkCzVAhcnHdkNrb/GnarAWfhRz1Pt7R9hVKT10bS1WCUkXWn6tUvQ9bh
 W7JSuI96ryfIJUEmgKaQJDQ1SmRezTPfhU6036DJqcDLERP2e+OMNmGTlhNeZyjJzTFX
 GBJuAiAeNShvZKsdQnFf8TQkpozbPqjw9rhwqfpF4knb9x2j7LRDlEluFQVqf/pqJBEs
 gb5LjCNvDnO5ofObj6GLiKAscLeOTZdZaJ171L1xOvxsMEXvIFAjbWKrGV/hkOR3sPT4
 V3+AwPKSiCTND/fHZgxfUI11EUoq8qjkxRJMKW5fypA8SD4XvcfM5kJ3/SOF3Kv5hNQO
 lafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793604148; x=1794208948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JB/vt8Yqalu6xBIjfgP9QfXpUFDcSpikq6HleBSGoog=;
 b=ebFhS7bXGn7fZS1NLQ3SjoS092b86f5vfX4Si9bfp11xxPSZccxMbIKftqk9tFwlUv
 fO2ls9TRE0Yy/OCS5Fck5OfJDfGnBDYOAZ+U2PAGq3/7v5mZns7qKWhA31mQZXd3aozQ
 0v1J/XCtTT+JSFN5Yir2qz8QzaPg5rb/JOyC+z9AJQWZtW4g9+o18KDiqCVcmFBerS/T
 DK/16Cn9YJa0B7hxxgv5lh4i6IN27OiAeBoY3LpHw4QLEvQf0Ay+2CRn98L7zAVo1LF0
 qsdfaQq8DA9zsRJ6vcleKQe+NTpyBfEVke+c0PXi0ThXMAf27HPg2P4DADmAtphTBNE9
 QkpA==
X-Gm-Message-State: APuU4Z8wBPSG5JHIhSWihdL6X6wXNeG3cYZVw03L5ryJu8zjy8N+OVbw
 4OWRdW64EOkDd5fnlOxff0392+FlIk31fbYzBYAiUPUyRqa0a4cOCkky
X-Gm-Gg: AYBFou3MDjturxdquPiUZQvUzP04Tk4a0D4901EWsJbDWUCwoP0YPrpuU5Vq+enX7Wd
 grjmvskxvKC2sV4G1qcmQyumr+WmDCrYaGjRDvXPX4YCf5SDFbs9FjGS5ehhsTGZUUMNK9+tzab
 dVF0igxlG5F2A0FeX3MsZBZ0Hfq1vmZ80qFKKwCn2zoedLioYBFfDPZO7ht4dKviODrmOlePBMd
 rLWOupLbGMKzcIMXmixg9V+HP8/OGFy8fnjw//Ch64xOtkg5bEmNzgS+d/LRT1pEliyJvwLspNt
 Ts2jR3cwrOOzOHBba7itgorcy/POo4JtSGv5SgpyPlH2FS88ZI2JW6FlPvcc5NfM3y81VpUmzRG
 wlZrEWt4UAdbCppzSB5Ivr6PVbHRL+EIhF8f9lwHOUapBIGmPfMxQscyDiBUxLBrKmJTX1EfIxr
 DnrB1UL2vzpDcmdyk5HbE5DDjWPU6GvoboMkdD7hyJlnca7G9OZIx0q86oO3BeBcvXDNgTXrjHL
 vanWw/KQlM6/Lx7miha+tUGKzcVTpKMPTtwc5pAoNOKAH7tNuLnTsEDPtF5nShy6G5qTxW3FGzJ
 KR9Pc4/3HGSMLAgh4FQo8v5tbaa0cZf15oVGGwLEeJ2ynSIdJxc=
X-Received: by 2002:a05:7301:4706:b0:369:eee6:ee2c with SMTP id
 5a478bee46e88-36a4221bc98mr13867197eec.5.1793604147501; 
 Sun, 01 Nov 2026 23:22:27 -0800 (PST)
Received: from localhost.localdomain ([103.178.205.93])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm36376021eec.7.2026.11.01.23.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 23:22:27 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, vkoul@kernel.org,
 neil.armstrong@linaro.org, mani@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] phy: mediatek: mt8195: Check PLL driver setting return value
Date: Mon,  2 Nov 2026 07:21:39 +0000
Message-ID: <20261102072139.3588-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The mtk_hdmi_pll_drv_setting() function can return -EINVAL when
the requested pixel clock is outside its supported range.

Currently, mtk_hdmi_pll_prepare() ignores this return value and
continues with PLL initialization even when the driver settings
fail.

Check the return value and abort PLL preparation on failure to
avoid powering up the PLL with invalid driver settings.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index a4bc1268946d..9658781484f1 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -360,6 +360,7 @@ static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
 {
 	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
 	void __iomem *regs = hdmi_phy->regs;
+	int ret;
 
 	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_TX_POSDIV_EN);
 
@@ -374,7 +375,9 @@ static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
 	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_D2_EN);
 	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_CK_EN);
 
-	mtk_hdmi_pll_drv_setting(hw);
+	ret = mtk_hdmi_pll_drv_setting(hw);
+	if (ret)
+		return ret;
 
 	mtk_phy_clear_bits(regs + HDMI_1_CFG_10, RG_HDMITX21_BG_PWD);
 	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_BIAS_EN);
-- 
2.55.0

