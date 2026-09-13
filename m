Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E06C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 17:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E1D10E13F;
	Sun, 13 Sep 2026 17:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aoRr7LEq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D20410E13F
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:29:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CCEE60E91;
 Sun, 13 Sep 2026 17:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2F21F000FF;
 Sun, 13 Sep 2026 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789320574;
 bh=QKvBVSZkpVAXfRFRpnE9flJzkDgDOAnlGZWWB7mxBu8=;
 h=From:To:Cc:Subject:Date;
 b=aoRr7LEqOK81q1v5DnMEB108n310fPmR+8lLaWhIec5oQJfU1qeo3pX2rgrV9fY0b
 SYdZIY3y7cMZgiMN3Q7fb94EkMQiTFVaSpNE2mrPA9lx59EWYVXOoxAkuYh/hb5mAl
 dBeo2C1SG5G+erEV0L71FiDPuDC9Dd0ID9YLFSZ3ADv2ium8x9yWe/aBbUwodzcVea
 epdW6nDf/tWNCLNSU5ItyK5R6ZYUefIDseigB8joUMmW375wRTEJPYilqgThDMvm9T
 I53q9W7GiKy1qLSfYXK9bEts7oDEKB489R9R73offLjHaEHJyy7LrbXLlZXYzXdH/w
 Nlu7hfswihebw==
From: Sasha Levin <sashal@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Sasha Levin <sashal@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] phy: phy-mtk-dp: Fix pdata array members initialized as
 pointers
Date: Sun, 13 Sep 2026 13:29:29 -0400
Message-ID: <20260913172930.1150324-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Building arm/arm64/i386 allmodconfig with clang fails:

  drivers/phy/mediatek/phy-mtk-dp.c:761:18: error: incompatible pointer
  to integer conversion initializing 'u16' (aka 'unsigned short') with
  an expression of type 'const u16[4]' [-Wint-conversion]
  drivers/phy/mediatek/phy-mtk-dp.c:761:18: error: initializer element
  is not a compile-time constant
  drivers/phy/mediatek/phy-mtk-dp.c:761:18: error: suggest braces around
  initialization of subobject [-Werror,-Wmissing-braces]

14 errors in total, one set per offending member.

off_ana_lane, off_dig_lane and driving_params are declared as arrays in
struct mtk_dp_phy_pdata:

	u16 off_ana_lane[MTK_DP_PHY_MAX_LANES];
	u16 off_dig_lane[MTK_DP_PHY_MAX_LANES];
	u32 driving_params[PHYD_DIG_NUM_DRV_PARA_REGS];

but the SoC data instances initialize them with compound literals. A
compound literal is an object, not an initializer list, so this is not
an array initializer: the member is initialized element-wise from a
scalar, the first element gets the address of the literal truncated to
u16/u32, and the remaining elements are zeroed. Hence the three
diagnostics above - the pointer-to-integer conversion, the address not
being a compile-time constant, and the missing braces.

Arrays are the right type here, since both members are indexed per lane
and driving_params is sized with ARRAY_SIZE(), so drop the casts and use
plain braced initializers.

Found by KernelCI builds of the linus-next tree.

Fixes: ae859204b519 ("phy: phy-mtk-dp: Migrate register offsets to SoC specific pdata")
Fixes: 7cf38eb0ab59 ("phy: phy-mtk-dp: Add support for digital and analog calibration")
Fixes: 6fe4d5beac72 ("phy: phy-mtk-dp: Add support for MT8196 eDP PHY")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index 7108b16d33a27..dbef4a4bd60a9 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -758,9 +758,9 @@ static int mtk_dp_phy_probe(struct platform_device *pdev)
 
 static const struct mtk_dp_phy_pdata mt8195_dp_phy_data = {
 	.off_ana_glb = 0,
-	.off_ana_lane = (const u16[]) { 0x100, 0x200, 0x300, 0x400 },
+	.off_ana_lane = { 0x100, 0x200, 0x300, 0x400 },
 	.off_dig_glb = 0x1000,
-	.off_dig_lane = (const u16[]) { 0x1100, 0x1200, 0x1300, 0x1400 },
+	.off_dig_lane = { 0x1100, 0x1200, 0x1300, 0x1400 },
 	.regs_ana_glb = mt8195_phy_ana_glb_regs,
 	.regs_ana_lane = mt8195_phy_ana_lane_regs,
 	.regs_dig_glb = mt8195_phy_dig_glb_regs,
@@ -773,7 +773,7 @@ static const struct mtk_dp_phy_pdata mt8195_dp_phy_data = {
 		.pmos = 8,
 		.nmos = 8,
 	},
-	.driving_params = (const u32[]) {
+	.driving_params = {
 		[0] = 0,
 		[1] = 0,
 		[2] = 0,
@@ -788,9 +788,9 @@ static const struct mtk_dp_phy_pdata mt8195_dp_phy_data = {
 
 static const struct mtk_dp_phy_pdata mt8196_edp_phy_data = {
 	.off_ana_glb = 0x400,
-	.off_ana_lane = (const u16[]) { 0x0, 0x100, 0x200, 0x300 },
+	.off_ana_lane = { 0x0, 0x100, 0x200, 0x300 },
 	.off_dig_glb = 0x1400,
-	.off_dig_lane = (const u16[]) { 0x1000, 0x1100, 0x1200, 0x1300 },
+	.off_dig_lane = { 0x1000, 0x1100, 0x1200, 0x1300 },
 	.regs_ana_glb = mt8195_phy_ana_glb_regs,
 	.regs_ana_lane = mt8195_phy_ana_lane_regs,
 	.regs_dig_glb = mt8196_phy_dig_glb_regs,
@@ -803,7 +803,7 @@ static const struct mtk_dp_phy_pdata mt8196_edp_phy_data = {
 		.pmos = 8,
 		.nmos = 8,
 	},
-	.driving_params = (const u32[]) {
+	.driving_params = {
 		[0] = 0,
 		[1] = 0,
 		[2] = 0,
-- 
2.53.0

