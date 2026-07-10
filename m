Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CA2C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0712C10E251;
	Fri, 10 Jul 2026 21:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BHyLjZuX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F8910E1A5
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:59:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F1D040800;
 Fri, 10 Jul 2026 21:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F61F000E9;
 Fri, 10 Jul 2026 21:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783720781;
 bh=M5cI+rouNpvS1ba2pRKwEZ+ui+wpl9yHzfFSTu9Pa7s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BHyLjZuXOZqkwMBBdp5YFp9sMKVU7KZsn4VVIeZw1Scj2P5UIBAnF4nTMVAazqPWb
 Kpme0uM+Bt6LubHBvykt4TvyhuvrrJzm8TseUXEKUZpjqXXf11ET8h/rArDIxjiyeM
 T/d7d6a2pGD0mfmPd2wBp2C40MTaIxHvp97HaLV0ttKBrNlzp5l06WJkSx/Ji7hkuD
 hqPiw7AaXl3i9aJSZp+N9ki52oJftxlqyoCZOQLdlp4Hhj393X0IbjiaR/S7NIbrRk
 dBrU/5bYNngT+wq9GJclXn8YyCRFQhA6qdkOU2u8AOtu+ChvUzgSrscLiPvOGWsOTf
 HcR/Zu0jBxm0A==
Date: Fri, 10 Jul 2026 16:59:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, chunkuang.hu@kernel.org, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, mripard@kernel.org,
 p.zabel@pengutronix.de, justin.yeh@mediatek.com,
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 jitao.shi@mediatek.com, maarten.lankhorst@linux.intel.com,
 jason-jh.lin@mediatek.com, simona@ffwll.ch, matthias.bgg@gmail.com,
 airlied@gmail.com, linux-mediatek@lists.infradead.org, tzimmermann@suse.de
Subject: Re: [PATCH 01/10] dt-bindings: display: mediatek: dsc: Add MT8196
 compatible
Message-ID: <178372078005.1413006.12439017339220224450.robh@kernel.org>
References: <20260701121950.19454-1-angelogioacchino.delregno@collabora.com>
 <20260701121950.19454-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701121950.19454-2-angelogioacchino.delregno@collabora.com>
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


On Wed, 01 Jul 2026 14:19:41 +0200, AngeloGioacchino Del Regno wrote:
> Add compatible for the Display Stream Compression (DSC) IP found
> in the display controller of the MT8196 SoC.
> 
> This IP is compatible with the one found in MT8195.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsc.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

