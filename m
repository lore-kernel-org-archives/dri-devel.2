Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A170C88E5A
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1D010E88E;
	Sun, 13 Sep 2026 10:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MDNgxXDs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218D810E88E
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 10:56:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6CFE44838;
 Sun, 13 Sep 2026 10:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E5A1F00893;
 Sun, 13 Sep 2026 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789296980;
 bh=4lfyUI7+Tc/Mb2QBy6WdYhNYHUjaxuxidXp/ImzOKso=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=MDNgxXDs/qfL2+bBSwRLh8Zolqio39Jl2Ern1bn9MCzxsW+oSFKQJS1Ag/E2NNYQE
 e14DpFo1W8eZ5U1lB4f2VodT805452hsUQFEYWg/ztg/5nBtb9d2p9tSV2MhiQSCRq
 lJrxb90/D/9pRDWI+iP4dCVJYt9YLZPEN9MiNi/J8KpSUxaHXyE1rceDeQNQH5MqCM
 RCc+I7/Nesk9xls0DYV1SvAMFRNDqtzZCV96Pkm/LWh/u/r9jwoRCHJddcTowkOxmw
 xL+S75lju5jxzAbWA+mThhmgjgLiYj8Dx0KSilRz/qK9rZiW76Y/4PlmpOpqbl22tq
 pyk0j8dMTnUSw==
From: Vinod Koul <vkoul@kernel.org>
To: mani@kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, neil.armstrong@linaro.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, justin.yeh@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 kernel@collabora.com
In-Reply-To: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 00/12] PHY: MediaTek DP PHY refactor and MT8196 eDP
Message-Id: <178929697500.215437.15947728409079441751.b4-ty@kernel.org>
Date: Sun, 13 Sep 2026 16:26:15 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Thu, 10 Sep 2026 11:20:26 +0200, AngeloGioacchino Del Regno wrote:
> Changes in v4:
>  - Removed error checking from all regmap_(bulk_){read,write} calls
>    as those are on MMIO and can't fail (Mani)
>  - Changed some of the error prints in mtk_dp_phy_get_one_cal_para()
>    to dev_err_probe() (Mani, Sashiko)
> 
> Changes in v3:
>  - Added missing bitfield.h, pm_runtime.h includes (Sashiko)
>  - Set calibration data before registering PHY (Sashiko)
>  - Enable PM Runtime before creating PHY device (Sashiko)
>  - Continue poweroff if some write fails, but still return failure
>    as that would be a partial poweroff anyway (Sashiko)
>  - Added zero driving params to fix default calibration data setting (Sashiko)
>  - Added NULL check on device_Get_match_data (Sashiko)
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: phy: Document MT8195 and MT8196 DisplayPort PHYs
        commit: 1e432224ed9b31607802ff4e370b73468ca9a452
[02/12] phy: phy-mtk-dp: Rename regs to regmap in struct mtk_dp_phy
        commit: da3c07602f6761403a2ee1b155e7645465c0d36f
[03/12] phy: phy-mtk-dp: Allow probing with devicetree match
        commit: e78be6a5410cf74534be19b3be1090c325132f56
[04/12] phy: phy-mtk-dp: Migrate register offsets to SoC specific pdata
        commit: ae859204b519a384ad0136c21599bab9321090ce
[05/12] phy: phy-mtk-dp: Implement power_on and power_off PHY callbacks
        commit: 10e7b846fc5ed8d3420fc8eb1c0b4524e952b4ac
[06/12] phy: phy-mtk-dp: Support set_lanes in configure and properly cleanup
        commit: 0382b9948627e091aeffcb8be311ea2b26dc1665
[07/12] phy: phy-mtk-dp: Support setting volt swing and preemphasis values
        commit: 283aa3fbbc80e1c1b23264f0bd00a96f5cebbbec
[08/12] phy: phy-mtk-dp: Add support for digital and analog calibration
        commit: 7cf38eb0ab595fc312bef06faedf8a0f0dcb8fcd
[09/12] phy: phy-mtk-dp: Rewrite and document default driving param macros
        commit: 5d907e1bac8a4bf3209fca42ac93c9d2c7f723f8
[10/12] phy: phy-mtk-dp: Add bitrate register val definitions to SoC data
        commit: 53e25169561a500dbcc4992dad17795a11e3e6bf
[11/12] phy: phy-mtk-dp: Add PHYD Lane EN register mask to SoC data
        commit: 09782cc51273ba594905633e1e59ee3c3b82fe6a
[12/12] phy: phy-mtk-dp: Add support for MT8196 eDP PHY
        commit: 6fe4d5beac728b447e77dab158985550ae58718c

Best regards,
-- 
~Vinod


