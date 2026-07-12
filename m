Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC15FC44506
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3E010E49E;
	Sun, 12 Jul 2026 15:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Byp017tr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E9410E49E
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 15:22:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8256A4325B;
 Sun, 12 Jul 2026 15:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15231F000E9;
 Sun, 12 Jul 2026 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783869734;
 bh=DuaiB+g90evMEnQ75glw9g8iH9UnlpaAQbng8V1ssBs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Byp017trUwl/8psOoSyDdN8PtY7+zecQELkM7ZiyxQf/cRCTQO+ugA+tXHJUoPtj1
 P8Togkk32pLjMyqbfV33rMfj5OXwjMUiYcGjYxuHKsBxZoLXHFqVJAzIks1ND47AD7
 WiIKN5DKkyBMetJJXIHTavH9NHVACUAgWOuGWeH9IE+FKeB4g8MlhdkD2ydvhlY7D6
 HsUXCIUPg5kil7KSF8xcPnpYSpQt2lJFcLKk042r1i5ot5xxVdDAw/3bBhVLT2XrOG
 dwiZili2xMav43/ICOeZV14fGdX2gnE2MYTslx4YI5cHO4mexPM0wp9VPbKwPmyGfN
 TmhTRPn5RxXNQ==
Date: Sun, 12 Jul 2026 17:22:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 chunkuang.hu@kernel.org, 
 p.zabel@pengutronix.de, matthias.bgg@gmail.com, justin.yeh@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek,dsi-phy: Add support for
 MT8196
Message-ID: <20260712-unselfish-topaz-roadrunner-f0bbfb@quoll>
References: <20260701121943.19430-1-angelogioacchino.delregno@collabora.com>
 <20260701121943.19430-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701121943.19430-2-angelogioacchino.delregno@collabora.com>
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

On Wed, Jul 01, 2026 at 02:19:42PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for the MediaTek Kompanio Ultra (MT8196) SoC: this
> chip features a DSI PHY that is similar to the one found in the
> MT8183 SoC, but is a new (incremental) revision with a different
> register layout.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

