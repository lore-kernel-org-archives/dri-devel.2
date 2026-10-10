Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D7ACA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE93210E71B;
	Sat, 10 Oct 2026 11:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YjFCmdA3";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB70710E6E0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:56:06 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48b02b1b4cfso1722929f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 04:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791633365; x=1792238165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qv9bAeFxVCYRZjcdo00nj7An4pwjaNEncFgD0tELhn8=;
 b=YjFCmdA3GydoTRrXWD/TbwnHDVwXDfweJji7Rdo5NBoNqk0IaRCDYcL+bQjqVXMBmn
 OwIsVcM2Li/qzJt/KenBZImL1cbWNGz5SFxxXRu1CnWhlg1VAJE5NVRpDr8z54bKStQF
 ZQIsab+xQq4818F5+nXisx/K+O2ZfTD8Iq8N9u8yRVVFInvOygDiGRgF2XMu+r2jt+fJ
 9nvn7+/pPEAz+qJjng29FzwFDf6fpiy7E84ms514iehg1wbD2NjqYHPqUm62nW9LteYP
 t9FGwokr7OeS198Z6Z1hJxTf+nzKZOKUISQb6R2VskDTzwxeqGDkCTC6i0JWvN+LHhhO
 dnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791633365; x=1792238165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qv9bAeFxVCYRZjcdo00nj7An4pwjaNEncFgD0tELhn8=;
 b=qK/CMUe4bDH4OupeNvW/yisf5ckavhix+ab7zVK5t32Cc3W3eiDL62ocBXWD97OxsV
 kS/h6dIdOhKAnWNW0+w12nP+aU6CD2AJ3ZO8h+JDlHozU1dblMWeqfTowMV+i/S8yxF+
 BP+AfUEk4POYYHqXu9p4uWL8CMtlO5PCmI6Gnf8G14q5ToO9rSa725pKThYm9nuSHtjN
 tYqLjP85BG2CELl7FCD7iPFbwsdu408Z+AsqSa+93Vd3U5jB1pBOOeVI+z2/Nwsi+xg/
 QaeQ7jSlH88h5rpru4RCjR0xiIgmbN1eyh0vHdWNP1A5osNwLHIyjdCrnrmoTHF2sLDv
 AaaA==
X-Forwarded-Encrypted: i=1;
 AKwUvByitI4P6Ar3jJQ9SUkG1jEXkcL6OfHhA7FALgG+YkhBpsw1eMfhHVEvRQWa3CnnzJDOyJMpS7XlzI8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIXZVfUUI1vOepeiUCT9a8YZPHEul04dFkMjpvsKGxH2ZNMz0TD
 TXbO02paNsxjGNEu0d9HKIPwYYTGH+lhOQX9pQv7DJ7kqXhJUQVymIh+
X-Gm-Gg: AYBFou1im8BfElFgnpSD1unPBNTxNon3hv9DdE/YnT9rh34EfVBuZ+BfT8PX+pd49Ba
 eDq/LlZXvTZf5htRpVlWZidXnSws08Qbd2GGTO/bj4sgsJissqR1iIZ/CMVP14y24J7qDpxoAqT
 qQjQv1mEI53urdx7TXk8noL80ktm2bxNdUVqP6Ok4HcxsJ/2Sw3qErLa9YxRmUwcsv2hmPLJNE/
 tLux4nCB8pZ9hHiukIVy6Lke5Pjc7nZHmSKxqmHP0vMiT0Mb2cM2+bmMVfDtEOzZeeVTasm72/e
 4uVReuYi0xtsYIjK2IfIFv7zmcOw7lE0VbmU5IJsdL3A7Okoid2SL5MRlV2b1wDp2mPBbne98a/
 ho/EimDh/KlVL3dNrXOQfUZ8GSQZZ0JsGj+58MJ+4jfd1bPqX9cs2XLBt3X4CizLudXfvaMNeKX
 0iuz6/NUp3YCCCl2Bwk5mth2n587oCaK0TRA1ZIiUvXthqwDoS7rD41g0HvmdBf6Z1uQ==
X-Received: by 2002:adf:e00b:0:10b0:48a:fff3:f9c1 with SMTP id
 ffacd0b85a97d-48db9482030mr6898560f8f.20.1791633364955; 
 Sat, 10 Oct 2026 04:56:04 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm8746340f8f.43.2026.10.10.04.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 04:56:04 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Fabien Parent <fparent@baylibre.com>,
 chunhui dai <chunhui.dai@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 4/7] clk: mediatek: mt8167: Correct HDMI-related clock
 definitions
Date: Sat, 10 Oct 2026 13:54:04 +0200
Message-ID: <20261010115539.9237-5-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010115539.9237-1-l.scorcia@gmail.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
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

On the mt8167 SoC, the tvdpll_ck clock is used to clock the DPI1 pixel
signal that is hardwired to the HDMI interface.
The clocks used by those two blocks must match and they have to be changed
according to the mode clock appropriate for the display resolution. Fix a
couple of issues with the current HDMI clock definitions:

- The hdmi_ref divider references the same register and offset of its
  parent tvdpll. Make sure to flag it as a read only divider as its rate
  must be set by the DPI driver only.
- Both hdmi_ref and tvdpll_ck derive their clock from the same tvdpll
  parent clock, but its rate must be set by the DPI driver only. Unset the
  CLK_SET_RATE_PARENT flag that is implicitly set by the FACTOR() macro.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c | 2 +-
 drivers/clk/mediatek/clk-mt8167.c            | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
index 3e8611991de7..a7d38c194759 100644
--- a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
@@ -87,7 +87,7 @@ static const struct mtk_pll_data plls[] = {
 
 static const struct mtk_clk_divider adj_divs[] = {
 	DIV_ADJ_FLAG(CLK_APMIXED_HDMI_REF, "hdmi_ref", "tvdpll",
-		     0x1c4, 24, 3, CLK_DIVIDER_POWER_OF_TWO),
+		     0x1c4, 24, 3, CLK_DIVIDER_POWER_OF_TWO | CLK_DIVIDER_READ_ONLY),
 };
 
 static int clk_mt8167_apmixed_probe(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index c64d918c37de..a14f0736cdcf 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -75,7 +75,11 @@ static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_TOP_CLK26M, "clk26m_ck", "clk26m", 1, 1),
 	FACTOR(CLK_TOP_CLK26M_D2, "clk26m_d2", "clk26m", 1, 2),
 	FACTOR(CLK_TOP_MIPI_26M, "mipi_26m", "clk26m", 1, 1),
-	FACTOR(CLK_TOP_TVDPLL, "tvdpll_ck", "tvdpll", 1, 1),
+	/*
+	 * The tvdpll_ck clock should not propagate rate changes to its parent
+	 * clock so the dpi driver can have full control over PLL and divider.
+	 */
+	FACTOR_FLAGS(CLK_TOP_TVDPLL, "tvdpll_ck", "tvdpll", 1, 1, 0),
 	FACTOR(CLK_TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll_ck", 1, 2),
 	FACTOR(CLK_TOP_TVDPLL_D4, "tvdpll_d4", "tvdpll_ck", 1, 4),
 	FACTOR(CLK_TOP_TVDPLL_D8, "tvdpll_d8", "tvdpll_ck", 1, 8),
-- 
2.43.0

