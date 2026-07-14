Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAB6C44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61CA10E085;
	Tue, 14 Jul 2026 16:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jz+9Czek";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9825110E085
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 16:42:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA34B405FF;
 Tue, 14 Jul 2026 16:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ED61F000E9;
 Tue, 14 Jul 2026 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784047327;
 bh=k61jezHC3k/RbNT9F3tzR3+tjmPaHQC3k1irVJlQASY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Jz+9CzekUY1eftq3OxsUOGnOISpZqtktT0tAgq7mvu+rrHDWAkEdGbOVs0K8Gg3QC
 b5aaXIH/ZMAaxTXSgPmRJqRvDW2TKxz1OXFgI66JwZPhI7E4nr+T0JEfJjGiT5P27W
 nJImc7zIO3QScevDh3Bkkz17U2GppED6C15BmEe325W5AnfsRjWNhz8FlZoH8eFoH8
 03LENgZV+8yKzGCIQtxrpu+0sH4uPslR8zAbEOOUAW1aDopUrBInyka1ERI8Z621Wk
 Pi91ocPthGdpsrOaWaL12/IlkoTc6fJOtnfw8o0xojHG/3Jmuv8bCKbkudvZPuJf3U
 DwGKZI6sr/25Q==
Date: Tue, 14 Jul 2026 22:12:03 +0530
From: Vinod Koul <vkoul@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, neil.armstrong@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 justin.yeh@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/2] phy: mediatek: Add support for MT8196 MIPI DSI PHY
Message-ID: <alZm25Ro_WdKigPd@vaman>
References: <20260713103805.23030-1-angelogioacchino.delregno@collabora.com>
 <20260713103805.23030-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713103805.23030-3-angelogioacchino.delregno@collabora.com>
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

On 13-07-26, 12:38, AngeloGioacchino Del Regno wrote:
> Add support for the MIPI DSI PHY found in the MediaTek MT8196 SoC
> and its variants.
> This PHY has a different register layout and provides support for
> more hardware features compared to the previous generation.
> 
> This initial driver only adds support for basic functionality that
> is necessary to drive MIPI DSI displays as a D-PHY.
> 
> Feature additions like lane-swap, DPHY/CPHY switching, dual-port,
> and others, may be done in the future.

This seems to fail to build

https://patchwork.kernel.org/project/linux-phy/patch/20260713103805.23030-2-angelogioacchino.delregno@collabora.com/

-- 
~Vinod
