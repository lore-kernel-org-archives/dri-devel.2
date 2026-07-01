Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88329C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E478710E0F8;
	Wed,  1 Jul 2026 12:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="U+CcAyle";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02338995F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908379;
 bh=7w5HNsCWhabDWKMBxO8hdeRtxDEiv7lhKo0ruQE4xqI=;
 h=From:To:Cc:Subject:Date:From;
 b=U+CcAylehC/wE3/SWoO/3Kt+ptI+ce0aPFXmkACIMn7YAbNJyBHO5uVysHxf8A8r9
 Dt047uh4gXiTDx5ctVDm3zVY67ZPl93XkN4nN2Yuo+Dpkb/uayHtgBtXS1Snjd9ODP
 0Zcligy0f1c1gZCtg3th26E50Cri7OG5EpB6H7iZByog8HysCS4D9F5RbzTsBumqtO
 +6XOp8UgdMX+wu4U9Bk1i/OWftLE4zJP8KHn4RXOWoAj/0G0PRYGUhAQQI97kYHnTY
 EI6HiBjAgBaNyavLdc7MbIipp1UeThQ0c8op2tbxgTY/qFR3vfSDj/vdFiKj6Iv/zE
 YM+OglZHCgeuA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A8E517E0909;
 Wed,  1 Jul 2026 14:19:38 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: p.zabel@pengutronix.de, chunkuang.hu@kernel.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, granquet@baylibre.com,
 justin.yeh@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: [PATCH 0/2] MediaTek MT8195 HDMI PHY Fixes
Date: Wed,  1 Jul 2026 14:19:34 +0200
Message-ID: <20260701121936.19407-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
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

This series adds two fixes for the MT8195-class HDMI PHY, found in
MT8195, MT8188 and Genio variants.

This is fixing PLL calculation, and TMDS clock dividers, to achieve
all of the modes requiring data rates higher than 3.4Gbps, with the
successfully tested target being 3840x2160@60Hz.

This was tested on MT8395 MediaTek Genio 1200, Radxa NIO-12L and on
MT8390 MediaTek Genio 700, with 3 different HDMI displays (two TVs
and a 4k LG workstation display).

AngeloGioacchino Del Regno (2):
  phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc divisor overflow
  phy: mediatek: phy-mtk-hdmi-mt8195: Fix TMDS clk bit ratio setting

 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 4 ++--
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.54.0

