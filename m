Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A04C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D10E10E099;
	Mon, 28 Sep 2026 10:02:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c50DzNBg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC8710E099
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:02:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8E72405B8;
 Mon, 28 Sep 2026 10:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B37D1F000FF;
 Mon, 28 Sep 2026 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790589755;
 bh=3cjcz3HECHzkqHUBPDnaAvn/WVZzY9Zmb5pnStgN0GE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=c50DzNBgxAU0kzT7G/YVoaZtZHzjXBVkY/kAl0E96iMXuJMjEHGQYedDuBrEftNtf
 CasEQW+pvdmBr72Je+WMyuxey8hZwwXq6W+6ezuZ+eTw7wqTZMKjZXJxVeTedyGShD
 QfTgOa35Ab2X7B3G9Cdu4Nd48syf3T3PVcGu3Kl2Ro+b99QGHxJ7OshZ7BfsS5wxPo
 rb93JneVY2sN6wjn3g57q4Hxrz/BgxeVTvlt+kZ60oaBe4m32hVAU5BowVQMqFdjte
 eaojDU/BYbffCxtaryGAqj53r8Tqjhm1lGMLKqv1WNjGKnz3tpXTz8XNuIDcNKOCge
 5pahmevKoBKhA==
Date: Mon, 28 Sep 2026 12:02:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v1 07/27] dt-bindings: gpu: mali-valhall-csf: Add Mali
 Gen5 AM compatible
Message-ID: <20260928-admirable-spicy-nautilus-71a2ef@quoll>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-8-karunika.choo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922204535.2850094-8-karunika.choo@arm.com>
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

On Tue, Sep 22, 2026 at 09:45:01PM +0100, Karunika Choo wrote:
> Add the generic "arm,mali-gen5-am" compatible for Mali Gen5 AM GPU
> integrations.
> 
> Mali Gen5 AM systems use the external AM_GOVERNOR block for frequency
> scaling, so OPP, cooling and local GPU supply properties are not valid
> for this compatible.
> 
> Add a matching example node.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml    | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index 8eccd4338a2b2..a1e85570b4b3b 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -22,6 +22,7 @@ properties:
>                - nxp,imx95-mali            # G310
>                - rockchip,rk3588-mali
>            - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
> +      - const: arm,mali-gen5-am

Why no SoC specific compatibles? Which platform uses this alone (without
SoC integration)?

>  
>    reg:
>      maxItems: 1
> @@ -146,6 +147,19 @@ allOf:
>          - nvmem-cells
>          - nvmem-cell-names
>          - power-domains
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: arm,mali-gen5-am
> +    then:
> +      properties:
> +        mali-supply: false
> +        sram-supply: false
> +        operating-points-v2: false
> +        opp-table: false
> +        "#cooling-cells": false
> +        dynamic-power-coefficient: false

That's way too much, you need a new binding file.

Best regards,
Krzysztof

