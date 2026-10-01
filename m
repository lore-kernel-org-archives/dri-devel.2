Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D53CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D7B10E1DC;
	Thu,  1 Oct 2026 06:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D9Fnf/ZM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFFB10E1DC
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:26:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADA3E601F6;
 Thu,  1 Oct 2026 06:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7BE1F000FF;
 Thu,  1 Oct 2026 06:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790835992;
 bh=HN3OnHGWWOpF/ZwI1NvzjlO5u7WPecTGoIsEFYzWvH0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=D9Fnf/ZMeu5No5DmfM+oPp5DigF6YDuqnBgw4eXqfEwg+8WKJ/4QJjsU95uHup1/H
 yUFGIKvrL16JplNZyDhwOvgfbGHLC0UYvIdW2mEv1RkPZIwbHsYe5ns3X29wvopZtx
 B47vGkZhYtgr7CZkeodxmFiBwg0I4yJZulwOmXABdWRBXlot1lmcACj/biZNhi7Wlb
 J2lLmMwIGgOjqAX2+ah2Qd7DeAIBCnbfK6FE2TpJS6+34lTcNLj2jHsUKZZF/MAahB
 SaJJQx39fjEdBIsRjDDgoSNc8fmQD33zG0Fe5T2ApHqdtrGJkAkmw88fg9/R1GsbPr
 ZQZNtJYr4HvIg==
Date: Thu, 1 Oct 2026 08:26:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] dt-bindings: display: solomon,ssd16xx: Add
 Solomon SSD1677 controller
Message-ID: <20261001-accurate-amusing-sparrow-d519a5@quoll>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-4-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260927182329.4193961-4-devarsht@ti.com>
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

On Sun, Sep 27, 2026 at 11:53:18PM +0530, Devarsh Thakkar wrote:
> Add solomon,ssd1677 to the controller fallback compatible enum.
> 
> The SSD1677 supports displays up to 960x680 pixels with 10-bit
> pixel-level X/Y RAM addressing. It shares the same command address
> space and GPIO interface as the SSD1683 but differs in addressing
> model, deep sleep behaviour, and initialisation sequence.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> Changes from v1:
>   - New patch: Added support for SSD1677 controller variant in bindings
> 
>  .../bindings/display/solomon,ssd16xx.yaml           | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> index b31fb862de04..1a94ad9b0d94 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> @@ -24,12 +24,13 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          # Good Display 4.2" 400x300 monochrome e-ink panel
> -          - gooddisplay,gdey042t81
> -      - enum:
> -          - solomon,ssd1683
> +    oneOf:
> +      - items:
> +          - enum:
> +              # Good Display 4.2" 400x300 monochrome e-ink panel
> +              - gooddisplay,gdey042t81
> +          - const: solomon,ssd1683

You just added all these lines!

Best regards,
Krzysztof

