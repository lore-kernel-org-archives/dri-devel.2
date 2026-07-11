Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30935C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 15:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98AC710E350;
	Sat, 11 Jul 2026 15:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l2W6jO7G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDFC10E350
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 15:08:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF480411F8;
 Sat, 11 Jul 2026 15:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050AA1F000E9;
 Sat, 11 Jul 2026 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783782510;
 bh=RO0MF0UO52N/BtTir7O87MyPoM0YbxI8BeP9WMXMBa8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=l2W6jO7GmyST4ZStZowKVuylMTRzj91JHzDKY1Bw8IYsi5tftBTA9nh7/2B1/Zzby
 x4cErQwpyvltwy0553zx620THvjKjhoD8PEjb/uxzWchNnBt4CQRD3A8q9Inq+Jyqp
 bHl9bKksHNU3y3/jBPD79OEgcEKEbI3Wy3f4x6YLKKyav5VszCO+YoswItWCm4H29e
 pkKd90f/bQCtAvUrYnPLZ5mzgC93SEtGhtwJ5iVkag+vOuvra8Lu32rojl9EWnDG/e
 ZUukR2eamLdZil3lfBWS3EHnx7Qo5ilnAuyHaVYzOisU9DQgS+iCex3PabUEq1X9Ev
 GjO+bTlT7weUw==
Date: Sat, 11 Jul 2026 17:08:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, jitao.shi@mediatek.com, granquet@baylibre.com, 
 rex-bc.chen@mediatek.com, dmitry.osipenko@collabora.com, ck.hu@mediatek.com, 
 amergnat@baylibre.com, justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
Subject: Re: [PATCH v4 02/12] dt-bindings: display: mediatek: dp: Add
 compatible for MT8196 eDP
Message-ID: <20260711-chital-of-incredible-gaiety-b390c7@quoll>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709113148.49090-3-angelogioacchino.delregno@collabora.com>
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

On Thu, Jul 09, 2026 at 01:31:38PM +0200, AngeloGioacchino Del Regno wrote:
> Add a new compatible for the Embedded DisplayPort IP found in the
> MT8196 SoC.
> 
> This IP is compatible with the previous ones, but not fully.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dp.yaml        | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

