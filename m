Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5AEC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F0C10F193;
	Wed,  9 Sep 2026 15:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cVuUiYF8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2574C10F1BE
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 15:04:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30E136020C;
 Wed,  9 Sep 2026 15:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B80F1F00A3A;
 Wed,  9 Sep 2026 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788966288;
 bh=koc31sD8jNUGY12YBBneZjOQV63HfvgiWXOvYIpvhlY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cVuUiYF81lvPxLrEo/jB4FHWll11l3fZla6GDDprhdn944gmL8El2xxvjAVcXqhR7
 hfO0yUEp3xeP5ec6UV3BAY9oILoz9qPNPU7vC6eF/NBNVjfjGfFBq8afm0G+PSrPUm
 diANVBgVxP3uHB3A4FAQKGp9GD+7PeGEsA1041CAKu7JtwOqchVvCUE3X8Cq9IuIJh
 4TKKrS0jxJBU6BrKxKtyMEVj3YgW92YV5YT7rIIGc8Hj6gjSvzLjg7NyitcyljnB5+
 P7b/IggMPQXEepA8h13KMnb8diVXOv6+wxxp+nCqyzCDSFCSZ6auJWmwZ+0m9Y4lEY
 WxSRIcwBp+H4Q==
Date: Wed, 9 Sep 2026 17:04:39 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, p.zabel@pengutronix.de, 
 chunkuang.hu@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, 
 matthias.bgg@gmail.com, granquet@baylibre.com, justin.yeh@mediatek.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc
 divisor overflow
Message-ID: <wdvdeeoo3lpru5266r4sjjaj5s5cbvdjzkjw3vncvltu5vpw2q@rv6h7dzibzsv>
References: <20260701121936.19407-1-angelogioacchino.delregno@collabora.com>
 <20260701121936.19407-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701121936.19407-2-angelogioacchino.delregno@collabora.com>
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

On Wed, Jul 01, 2026 at 02:19:35PM +0200, AngeloGioacchino Del Regno wrote:
> When trying to calculate a PLL rate for target display resolutions
> above 2560x1440, 24bpp, 30Hz, the pixel clock value will be more
> than 32-bits long but the division to finally calculate the digital
> clock divider is being done with div_u64(), which expects a 32bit
> unsigned divisor.
> 
> Fix the overflow by using div64_u64() instead.
> 
> Fixes: 9d9ff3d2a4a5 ("phy: mediatek: hdmi: mt8195: fix wrong pll calculus")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
