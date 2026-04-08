Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0D51073C9E
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 11:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF7010E616;
	Wed,  8 Apr 2026 11:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DuuJODqd";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7F010E616
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 11:32:20 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 23EBD593;
 Wed,  8 Apr 2026 13:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775647851;
 bh=0z9xQ2bkMxCbehPYP0RxKCIo51HJ9ykabJPDevaX8zI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DuuJODqd45EmM8IZgQ24zMJTFDviat/fGzoWxFmdfFb06eXHxfch/amdyCxOpy9jg
 x6jfJMFGhnAUi5ys2p48PTm2XDGciOA7XAXExVSYUZqv5COxTOaIvj8LSa9NN5h0w+
 MpDOEC1GP69B6Zm3EUtHc4KQESh3O4SphF636ayc=
Date: Wed, 8 Apr 2026 14:32:17 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, geert@linux-m68k.org,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 18/21] arm64: dts: renesas: r9a09g047: Add fcpvd{0,1}
 nodes
Message-ID: <20260408113217.GD1928916@killaraus.ideasonboard.com>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <1ba6a98ace4ad9525d054cbaa308d3aeeecfa22a.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ba6a98ace4ad9525d054cbaa308d3aeeecfa22a.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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

On Wed, Apr 08, 2026 at 12:37:03PM +0200, Tommaso Merciai wrote:
> Add fcpvd{0,1} nodes to RZ/G3E SoC DTSI.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v5->v6:
>  - No changes.
> 
> v4->v5:
>  - No changes.
> 
> v3->v4:
>  - No changes.
> 
> v2->v3:
>  - No changes.
> 
> v1->v2:
>  - Squashed fcpvd0 and fcpvd1 patches into a single patch.
>  - Collected tags.
> 
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> index 95a4e30a064d..3115ab4b050f 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> @@ -1584,6 +1584,30 @@ csi2cru: endpoint@0 {
>  				};
>  			};
>  		};
> +
> +		fcpvd0: fcp@16470000 {
> +			compatible = "renesas,r9a09g047-fcpvd",
> +				     "renesas,fcpv";
> +			reg = <0 0x16470000 0 0x10000>;
> +			clocks = <&cpg CPG_MOD 0xed>,
> +				 <&cpg CPG_MOD 0xee>,
> +				 <&cpg CPG_MOD 0xef>;
> +			clock-names = "aclk", "pclk", "vclk";
> +			resets = <&cpg 0xdc>;
> +			power-domains = <&cpg>;
> +		};
> +
> +		fcpvd1: fcp@164a0000 {
> +			compatible = "renesas,r9a09g047-fcpvd",
> +				     "renesas,fcpv";
> +			reg = <0 0x164a0000 0 0x10000>;
> +			clocks = <&cpg CPG_MOD 0x1a8>,
> +				 <&cpg CPG_MOD 0x1a9>,
> +				 <&cpg CPG_MOD 0x1aa>;
> +			clock-names = "aclk", "pclk", "vclk";
> +			resets = <&cpg 0x11e>;
> +			power-domains = <&cpg>;
> +		};

This matches the documentation.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>  	};
>  
>  	stmmac_axi_setup: stmmac-axi-config {

-- 
Regards,

Laurent Pinchart
