Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14DBC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC4310E1D2;
	Wed,  9 Sep 2026 15:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mQ8HP/Ra";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8537210E1D2
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 15:06:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A55B26020C;
 Wed,  9 Sep 2026 15:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3D81F00A3A;
 Wed,  9 Sep 2026 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788966392;
 bh=E9ytG7kb5dbrGiKhe0oxqCTTvFC6jYjdhibOnVV1Go8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mQ8HP/RaMQKuI/HcIUaifGof6tg3xWV3kT6LI8eYb9rgbpsVWzV+ByXU0riskHILH
 i0JmeE6OALfZX8nSlHLj3RT5ls0hI/TW0WkTL7/grJm0KzHlKvABBvZlGU9NKbXRQi
 AKpwJXKS2VMOXoeUdMgfSQwVPg7wyMfjHnv4RQYP8tuY1y9LTvmb/iNrGa+cDvMeVh
 WlidRBgitZb7XcL/ODNZi9TqIoC5WWTzvN62bsZwe2rcG4qUsETYMI9E0ITvSOPhYc
 MJP0B5yuO6qm/JyAD8dBlT1mETJEfIRbjxpVnD93WpIpLh8HojMepFQPLK0RpbXtlM
 nJtyhY/CYFlow==
Date: Wed, 9 Sep 2026 17:06:23 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, p.zabel@pengutronix.de, 
 chunkuang.hu@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, 
 matthias.bgg@gmail.com, granquet@baylibre.com, justin.yeh@mediatek.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] phy: mediatek: phy-mtk-hdmi-mt8195: Fix TMDS clk bit
 ratio setting
Message-ID: <5bmxa4pcwkiemubwfjun3dti4szu66gnxe6yw2pudq3wplpc23@inyswc2bdlhw>
References: <20260701121936.19407-1-angelogioacchino.delregno@collabora.com>
 <20260701121936.19407-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701121936.19407-3-angelogioacchino.delregno@collabora.com>
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

On Wed, Jul 01, 2026 at 02:19:36PM +0200, AngeloGioacchino Del Regno wrote:
> The comment in the mtk_phy_tmds_clk_ratio() function clearly and
> correctly explains that the TMDS ratio has to be 1/10 for data
> rates under 3.4Gbps, and 1/40 over that.
> 
> Unfortunately though, the TXC_DIV register setting was wrong, as
> in value 3 means to divide by 8 and, in order to achieve the in
> spec 1/40 (tmds) data rate, this has to divide by 4 instead!
> In order to achieve the correct 1/40 (tmds) data rate, this has

This statement is cut-off!

> 
> Add definitions for the TXC_DIV register values clearly explaining
> the meanings (DIV2, DIV4, DIV8), and program the correct, DIV 4,
> value to the register in mtk_phy_tmds_clk_ratio().
> 
> This fixes out of spec clocking and, with this change, SoCs using
> the MT8195 class HDMI PHYs can now successfully be configured to
> output 3840x2160@60Hz over HDMI.
> 
> Fixes: 45810d486bb4 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

With above comment addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
