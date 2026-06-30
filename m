Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE00C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CAE10EC8F;
	Tue, 30 Jun 2026 13:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nhYqmEaN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD9110EC8D
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:50:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DB67601C1;
 Tue, 30 Jun 2026 13:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CFF1F000E9;
 Tue, 30 Jun 2026 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782827418;
 bh=r5/XEfDRgRNyeD3IF0mg0cZuaZMASN03u9kVorM3GNI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nhYqmEaN4wmBNsZUU8bKra5Imi5s/cf3NZTFsYJHnC9ANATTSlzBlyiq15+sOcFBf
 hH3EEr9IiReV4GshzevMtkVog9DbbxPJbfkLn6q/mhhwLi8qffyASXUGZ9V3Q0YiKG
 jGmGKjX9qFvlLR3zH6VX8aumoTt9j+QBqVERLcpG5XXaDGjegKba4+2jSCoRLvHuAD
 9UPmRGRC3lrVz/FJBPfWWCnzj7EsL3OyzN0p3APlsVDRHRt8Rd8QY8izt/AxXOasor
 I0/PobwDtqMJEsUy3y8Ls9v9o+AYIxZOOdmTOe5/c3mK2FIy+0fe6eyYy40tP2pp3/
 oE1970hKzUkzA==
Date: Tue, 30 Jun 2026 08:50:17 -0500
From: Rob Herring <robh@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-leds@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 Andrew Davis <afd@ti.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: backlight: ti,lp8864: Add backlight
 class properties
Message-ID: <20260630135017.GA2948054-robh@kernel.org>
References: <20260615120353.3409035-1-alexander.sverdlin@siemens.com>
 <20260615120353.3409035-2-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615120353.3409035-2-alexander.sverdlin@siemens.com>
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

On Mon, Jun 15, 2026 at 02:03:47PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Extend the TI LP8864/LP8866 device-tree binding to support backlight
> class properties alongside the existing LED class child node.
> 
> This is a preparatory change for converting the LP8864 driver from a
> pure LED class driver to additionally register a backlight class device,

That's fine, but should have little to do with the binding. The h/w is 
not changing.

> motivated by a use case on a hot-pluggable segment of an I2C bus. The
> generic led-backlight driver (led_bl.c) is a platform driver and thus
> inherently non-hotpluggable, which makes it unsuitable for hardware
> topologies where the backlight controller resides on a hot-pluggable I2C
> bus segment. By making the LP8864 driver itself register a backlight
> class device, it becomes a native I2C driver that properly supports
> hot-plug/unplug events.
> 
> The binding is updated to:
> - Reference backlight common.yaml at the top level, making
>   default-brightness and max-brightness valid optional properties
> - Make the "led" child node optional rather than required, since the
>   backlight class device is now the primary interface
> - Use unevaluatedProperties instead of additionalProperties to properly
>   allow properties inherited from the referenced common schema
> 
> The LED child node is preserved for backward compatibility with existing
> device-trees. No in-tree device-trees reference this binding, so this
> change has no impact on existing mainline users.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  .../bindings/leds/backlight/ti,lp8864.yaml       | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
> index d44232d462bde..11d7e3840c6fb 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/leds/backlight/ti,lp8864.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Texas Instruments - LP8864/LP8866 4/6-Channel LED Driver family
> +title: Texas Instruments - LP8864/LP8866 4/6-Channel LED Backlight Driver family
>  
>  maintainers:
>    - Andrew Davis <afd@ti.com>
> @@ -21,6 +21,9 @@ description: |
>      https://www.ti.com/product/LP8866-Q1
>      https://www.ti.com/product/LP8866S-Q1
>  
> +allOf:
> +  - $ref: common.yaml#
> +
>  properties:
>    compatible:
>      const: ti,lp8864
> @@ -36,9 +39,15 @@ properties:
>    vled-supply:
>      description: LED supply
>  
> +  default-brightness:
> +    maximum: 65535
> +
> +  max-brightness:
> +    maximum: 65535
> +
>    led:
>      type: object
> -    $ref: common.yaml#
> +    $ref: /schemas/leds/common.yaml#

This was already supporting backlight properties. Changing it to leds is 
an ABI break.

The binding was designed to have a child node. Make that work for 
whatever you want to do with the driver. I see no reason to support with 
*and* without a child node.

Rob
