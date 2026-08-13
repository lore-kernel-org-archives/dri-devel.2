Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F05C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82AD89452;
	Thu, 13 Aug 2026 07:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LO7XnNmk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6A389452
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:06:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79D8840562;
 Thu, 13 Aug 2026 07:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E071F000E9;
 Thu, 13 Aug 2026 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786604795;
 bh=5gkzFo2+VnKiba/m6QDHWuLmIQSEjcsqyeD9BtdYCdE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LO7XnNmksRdPGuuVUvy4uIp1TNqnss+bW1hz0raYz9RVLB9K2Msgsgwbi+S77PMen
 EU929j5yne48ccdwHerg5SVsXmfM/l/6Fsc13FOojuYOe4cA+efThVEz/GwEjv+U7g
 bEUZuO4PJZ0PxH6thkO1thO+J+W63uADRHQ7BT64/Yjc3vPSNeCe1n4zJaSG47bJHR
 /Plvnr6vRz1KaNK4XkEp1In1rN3T/LC5p7IJcb7XUmYuq1E4rA6o95MXLnlu675/Y8
 ptXQEUJYFoSiQ8eJSCg0y24KdXivFsYdEEdgPRfs5Mkf3vnB6kIHeAKCl95shEvTqW
 XPXivBMAj9aAA==
Date: Thu, 13 Aug 2026 09:06:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, 
 zhangqing@rock-chips.com, royalnet026@gmail.com, alchark@flipper.net, 
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/10] dt-bindings: power: rockchip: allow resets in a
 power domain node
Message-ID: <20260813-squid-of-splendid-hail-d968bf@quoll>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-4-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812094106.1391698-4-gahing@gahingwoo.com>
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

On Wed, Aug 12, 2026 at 09:40:58PM +1200, Jiaxing Hu wrote:
> Some domains do not come up in a usable state on their own and need
> their resets cycled once power is on. The RK3576 NPU domains are one
> case: without it the first access after power-on takes an async SError.
> 
> pd-node has no resets property and every nesting level is
> unevaluatedProperties: false, so describing that in DT is rejected
> today. Add it alongside clocks.

This paragraph is redundant. Why are you explaining correct syntax?

> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> index b41db576f..f23c1a118 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -136,6 +136,14 @@ $defs:
>            A number of phandles to clocks that need to be enabled
>            while power domain switches state.
>  
> +      resets:
> +        minItems: 1
> +        maxItems: 30

30 resets per one power domain? and none got to the example in this
file?

> +        description: |

Do not need '|' unless you need to preserve formatting.

> +          A number of phandles to resets that need to be cycled once the power
> +          domain has been switched on, for domains whose logic does not come up
> +          in a usable state by itself.
> +
>        domain-supply:
>          description: domain regulator supply.
>  
> -- 
> 2.43.0
> 
