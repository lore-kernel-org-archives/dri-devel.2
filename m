Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EECDC5321C
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B1AF10E30A;
	Mon, 27 Jul 2026 07:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jyWqde0x";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179C910F4CE
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:18:03 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-ca034c989e2so560214a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784949482; x=1785554282; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G9jy5raEKPdDIP6H9Rn1M27tE88CgVPDyIdAEUIQ/3U=;
 b=jyWqde0xYyc+PWd0XzOGO8ip7WVqVMxX027JrKSfgId73hZ1zGth/Nq6qLtjJc4nxv
 lNjpqHl2kfLc8GIFN+LAMbcnfIxobJKpKp6SEj9ACSVXm8tXzA8XWQ1NbxKpV3w4Yl9J
 hy+PmCqw8nFMXkbxUPyc1x7y++pdITUwzCAS2V0rOyTxDGazoNTJYXcVfbdJwBnFJkLK
 30VwzjZrHYO7Uo20uCSTUhAIOESm5LAYqPSOfNh1Pgey1gztajQP6UZ6qKPfKFDDerT1
 5a+ncvtVRW4aqwhul5rZuyyw0KB/eoOqRfeRzl8EEoaxqHRyU/qzvCjzrYodOxt3RNLx
 aHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784949482; x=1785554282;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G9jy5raEKPdDIP6H9Rn1M27tE88CgVPDyIdAEUIQ/3U=;
 b=Lp3cMQY6VOlOTU/F+TsDq5EefsOZKN8U/KlLgEcUNzm2kFCAOxCdR4huw5ylxsd2tV
 fq5Wro/lezSoMjzpd5A5rXJLoMaQo9Rx6R89kZ3+lJGiq6N4N2QVQMHGUIVhMX7/gdaV
 Q9wvkCY8UF15AuXWZlsb3hM/1EZkgnhQ866DSDvhT5I3S8iCCoP1GVBGHhxvocqyUa4t
 ZOld7UCz6reQtIZsC6rBJJPtiqtpesbzozPTeftIHoC/3PyRuhuDCzt8zxD5vRs9w0D3
 9fg2goyZwI2FWF1TFmmDaWjONpcy4Z1XhWt73i/y4nvI6i0trxfcbCEl31El5HQ+Sq1H
 Nn5A==
X-Gm-Message-State: AOJu0YwytRKleMrH4Rp36V/CaHsopV9QEUstHmGV/99CAVm0Id0Ngmkg
 M6Vclkki6+60VZUvFemgTSbXpPAHRqMI3VxPUhEt+RMLGYK6HUNBapox
X-Gm-Gg: AR+sD10T4nw3iTWlHDo3VrqEi6QC8EH0SDnOK+q9BIOpwNRFLzmdeapchMVb9PpMwXD
 FoXxoN7UddqQwnFRW/DARMhts9KfjlMpXPTfwOODrjv3r91nV3thHJJ0xoqcdVgM/BR+x42WRwP
 oMNrqZzPhhTYDODYFrjdo8HYM6GNDicgxewMPncMosGJMOR01zNw+RXVrGZiFnjNOGw4iYXGcyh
 twCWkEyNjREqLiNXJmYUvxk096RhIEOH1+EngloYb1iWKCXENvMH3NeByQMHOcv+MMjAFyHsMsP
 WZhcExAIXxlYR8B1vmoWgIET++gUlh+Xn7ngCv9qvkkB8bh7d7WRT+fjIcb139PSgN/VO6P9tM0
 3qXCvwt06VO0hijvng24Ys7vA2e95uxnDw+UN7AtYobyS/DFGv7dndSA3WMTlZ16Bpg==
X-Received: by 2002:a05:6a00:35cc:b0:848:44d2:72a2 with SMTP id
 d2e1a72fcca58-84e5944c07fmr653876b3a.27.1784949482608; 
 Fri, 24 Jul 2026 20:18:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:18:01 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:38 -0400
Subject: [PATCH 06/17] clk: spacemit: k3: parent eDP/DP pixel clock to the
 PHY PLL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-6-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
In-Reply-To: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

The APMU eDP/DP pixel-clock muxes were parented to a placeholder, because
their real parents (the DP PHY PLLs) did not exist as clocks yet. They do
now, so point each mux at its PLL and let the pixel clock reach the
controller through the clock framework.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 drivers/clk/spacemit/ccu-k3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/ccu-k3.c
index cb0c4277f72a..afbbbd797826 100644
--- a/drivers/clk/spacemit/ccu-k3.c
+++ b/drivers/clk/spacemit/ccu-k3.c
@@ -937,13 +937,13 @@ CCU_MUX_DIV_GATE_FC_DEFINE(ufs_aclk, ufs_aclk_parents, APMU_UFS_CLK_RES_CTRL, 5,
 
 static const struct clk_parent_data edp0_pclk_parents[] = {
 	CCU_PARENT_HW(lcd_pxclk),
-	CCU_PARENT_NAME(external_clk),
+	CCU_PARENT_NAME(edp0_pll_pxclk),
 };
 CCU_MUX_GATE_DEFINE(edp0_pxclk, edp0_pclk_parents, APMU_LCD_EDP_CTRL, 2, 1, BIT(1), 0);
 
 static const struct clk_parent_data edp1_pclk_parents[] = {
 	CCU_PARENT_HW(dsi4ln2_lcd_pxclk),
-	CCU_PARENT_NAME(external_clk),
+	CCU_PARENT_NAME(edp1_pll_pxclk),
 };
 CCU_MUX_GATE_DEFINE(edp1_pxclk, edp1_pclk_parents, APMU_LCD_EDP_CTRL, 18, 1, BIT(17), 0);
 

-- 
2.43.0

