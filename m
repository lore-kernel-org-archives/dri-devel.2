Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4DFC88E42
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C7FC10F0D2;
	Fri, 11 Sep 2026 05:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m4bAq3t6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5871210F0D2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 05:20:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F528431E1;
 Fri, 11 Sep 2026 05:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DED1F000FF;
 Fri, 11 Sep 2026 05:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789104016;
 bh=zQkaItX0xqo5kFCTOPQvErm+zlth+OHMFg4BhhYP06c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=m4bAq3t6xGNaDJIAUQZb5j72asbrzo3kHL9Z95osZGv0FSm+lI+GiTji1/5h9z5Na
 SdjWZapU5O7ZCqDBU0DO09eDrxABIvz97cYjMC5Sdlvhjd4X65ZXLa4WMgQxwLAfnw
 p9jylw7kLyiJSZgPD1NI/ALAdP0vRi3xXBZRcwL5Hn+liVDz3xBDuD7GQCAElU31VC
 Jf0bkgZ6zZAIaQATdwkyLAjemkhynonHl+/zp5qmoYsh5h7rdN9VHgJv7mr/2eJp+2
 s2LQia0fpY/ORQRx0byN3JPmVrc3YfSs2jFAg80Z/4xUVfwd49977V0nZhvvgkZL11
 oY7j5hhsHvZlg==
Date: Fri, 11 Sep 2026 07:20:06 +0200
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
Subject: Re: [PATCH v4 11/12] phy: phy-mtk-dp: Add PHYD Lane EN register mask
 to SoC data
Message-ID: <dcywgc2ccerd6h7rsib5dak2tmanhy6tnbl3fuzvl4ni2ua2lw@jiqbmfni7uou>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
 <20260910092038.48291-12-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910092038.48291-12-angelogioacchino.delregno@collabora.com>
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

On Thu, Sep 10, 2026 at 11:20:37AM +0200, AngeloGioacchino Del Regno wrote:
> In preparation for adding support for the eDP PHY found in newer
> SoCs, transfer the register mask for PHYD_TX_LN_EN to SoC specific
> data.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
