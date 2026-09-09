Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A50C79FBF
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BEA910F1EC;
	Wed,  9 Sep 2026 17:17:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h/Tl62vD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEE610F1EC
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:17:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C68F34177F;
 Wed,  9 Sep 2026 17:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2712D1F00893;
 Wed,  9 Sep 2026 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788974273;
 bh=8VPY0deMqZZdrYnmVNpJtaQIzzwrsHUnmWiCqzQ+mTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=h/Tl62vDVbX7K7x9KxWl4Y1ioFq2FtWmlA0h7fNRPi1yoUVPKOfJQv4aj0vSn/zG0
 o4H+TRVi07XNDX4qm6y8JxgfeANszC3KWbSxV5dP4gZ8Ir9Pj/sSjkArLr06pjCU2C
 VZ8vPxIezLpot7J1zyVd5AjcWlSsvGj8T2Xqlus9nQ1jj9QUYkOQ0+CM8nxcWViVgC
 lABKCMhDvA07ki3Ckc1S3CR0fWaGkRBV2dO9mhIIcm5GD3E/XHMl4PlazfcNHp2sg4
 CTTJKi94WMWXwyEXJ1OlEjxa0u+H6PWGstz3+SyzoHQjmxRPx0/VKRE6zNB1wnqGg3
 YHPzGEhrL4DqQ==
Date: Wed, 9 Sep 2026 19:17:43 +0200
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
Subject: Re: [PATCH v3 07/12] phy: phy-mtk-dp: Support setting volt swing and
 preemphasis values
Message-ID: <voe2zlbmri2mesde2b5ypyj5xtfcaso4i4vsjlkrjfkq2mxxue@5hbymqqlb2da>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-8-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707154245.198361-8-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 07, 2026 at 05:42:40PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for honoring the set_voltages request to set the
> voltage swing and preemphasis values in the .configure() callback.
> 
> For proper hardware cleanup, reset both in the .reset() callback.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
