Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20797C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5645B10F1EB;
	Wed,  9 Sep 2026 17:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XkVQ0vIu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4293110F1EB
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:03:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6FCB405F7;
 Wed,  9 Sep 2026 17:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C281F000FF;
 Wed,  9 Sep 2026 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788973397;
 bh=p2s8uYoBSnPRtzrtxy84WXDVLveffRjaRrPrEHzO3Eg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XkVQ0vIuB6RQIRTUzSey3nGs+UX/fU73qGe5rLJyVH74queEPlJAnPabs0WWtPtc2
 AxwFcbtRNCukAPEqEW7rAq4WamRm6e5w76DIxmlGofvrUfKd0d4x75v7u9tRtkcbDC
 JOTgcuqnOx117t79O/6qN0+IE/2TJ9rK8MLBBsHqfRu8ueC01Gs12akCoHc+tPQTpu
 R85FtifAhbIUhJFuE5Xt77KmJDvQv+HKr6+Q5nDAcNzmAfny9H3TMDj7eeyFonpnuq
 tDHH4fZvp9tjRevl4BB7ecdS22L6GBeX2minc5iWSMTNe7DbPL8JP52sSmaZFVZSqc
 7XoXLn9sP/kQA==
Date: Wed, 9 Sep 2026 19:03:08 +0200
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
Subject: Re: [PATCH v3 03/12] phy: phy-mtk-dp: Allow probing with devicetree
 match
Message-ID: <bkx46kvsmovy2rbjnqwov65whmwnbkoig27iihk7w4qcosqoqf@jymp7vcu3ezi>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707154245.198361-4-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 07, 2026 at 05:42:36PM +0200, AngeloGioacchino Del Regno wrote:
> Make it possible to decouple the registration of the DisplayPort
> PHY driver from the DisplayPort IP driver by adding a devicetree
> match to probe the PHY, registering an OF PHY provider and this
> device's own MMIO regmap - if, and only if, this PHY driver was
> registered with an OF match.
> 
> In order to retain compatibility with older devicetrees that are
> not declaring the DisplayPort PHY as a separate node, the legacy
> code was moved in a `mtk_dp_phy_legacy_probe()` function, which
> gets called if the driver was registered by the DisplayPort one.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
