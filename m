Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A687CC88E40
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D393110F222;
	Wed,  9 Sep 2026 17:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nl4q23VJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A43110F222
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:26:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1DD6640A38;
 Wed,  9 Sep 2026 17:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2301F000FF;
 Wed,  9 Sep 2026 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788974764;
 bh=SP6jmQqIOLrkVvQFwD6N9WK9kKibbvJko54SPU9/I58=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nl4q23VJ5Bm5v7pAPhT0FU5OXL0bq5WJU1l32a55XGKzfUR69tUcrge+B6lV3RU2B
 3AHjhFmXm5sK4D1zu5dK3s99hvKvhjKA/G6fmJfI87yA1aTqkCej67GTeeLLrTALCo
 LRAdzsW2J+2SCJv3PNJKPckBndFwi5KB1e3jziA98+cwrcQhr3nGD9z1haUZLF1+0n
 pzvj/U1vA65Oy20ntN4HC+ejsMV3qALbI96pD0duvwY8Eot2EgTa/JEWli3gc18o0r
 rikvNe+39scM4J9j8AgFo5OQ9f3FBzJdzyor8NvfNHP2PSR/4XemWgNdFA77J4t+5l
 CneQU4HMOtzaw==
Date: Wed, 9 Sep 2026 19:25:54 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, 
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, justin.yeh@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v3 12/12] phy: phy-mtk-dp: Add support for MT8196 eDP PHY
Message-ID: <nz5vqejravxuaxdodfjb5mdmdndevwe75rtbfi7ndow3qlqdim@xuo2awaygbv2>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-13-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707154245.198361-13-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 07, 2026 at 05:42:45PM +0200, AngeloGioacchino Del Regno wrote:
> The MT8196 SoC features an updated PHY IP compared to the older
> ones, and there is one that is specific to Embedded DisplayPort.
> 
> Add support for the eDP PHY found in the MediaTek MT8196 SoC and
> all of its variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
