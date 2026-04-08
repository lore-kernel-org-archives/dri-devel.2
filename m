Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D7A1073CA4
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CECD110E628;
	Wed,  8 Apr 2026 12:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eE08sLBO";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF6E10E628
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:11:59 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id E52B71121;
 Wed,  8 Apr 2026 14:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775650230;
 bh=yLrg4EEZxTbl+jYp5ekc58SS/dTtJj5GLA5g+mQUWpU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eE08sLBOA2/vKse0f9R2TP0XQyBErO4x5TJdtpQwiASGnQm0zgUS886oour18MVB8
 SqtxtKyaTMOyrTGZ/sqYE6l9XMdKL/hwUYgJID7s+7Rsh+cIX+gGKSSO+x6+dwWfZZ
 MeOvio4SFkomkJNO21g1xj+vxWXj8GnSVi1OKMWw=
Date: Wed, 8 Apr 2026 15:11:56 +0300
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
Subject: Re: [PATCH v6 20/21] arm64: dts: renesas: r9a09g047: Add DU{0, 1} and
 DSI nodes
Message-ID: <20260408121156.GF1928916@killaraus.ideasonboard.com>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <ca31352b03689fa9902660be5cb4d0972ce04304.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca31352b03689fa9902660be5cb4d0972ce04304.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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

On Wed, Apr 08, 2026 at 12:37:05PM +0200, Tommaso Merciai wrote:
> Add DU0, DU1, DSI nodes to RZ/RZG3E SoC DTSI.
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v5->v6:
>  - Update ports numbering accordingly to the latest DT bindings.
> 
> v4->v5:
>  - Rename du0_out_dsi0 into du0_out_dsi.
>  - Rename du1_out_dsi0 into du1_out_dsi.
>  - Drop renesas,id entry from DU nodes.
> 
> v3->v4:
>  - No changes.
> 
> v2->v3:
>  - No changes.
> 
> v1->v2:
>  - Use single compatible string instead of multiple compatible strings
>    for the two DU instances, leveraging a 'renesas,id' property to
>    differentiate between DU0 and DU1.
>  - Use vclk instead of vclk1 for DSI Node and set to the right position.
> 
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 120 +++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> index f2fdaadd9d39..25d3a503a6cc 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> @@ -1585,6 +1585,126 @@ csi2cru: endpoint@0 {
>  			};
>  		};
>  
> +		dsi: dsi@16430000 {
> +			compatible = "renesas,r9a09g047-mipi-dsi";
> +			reg = <0 0x16430000 0 0x20000>;
> +			interrupts = <GIC_SPI 874 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 875 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 876 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 877 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 878 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 879 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 880 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "seq0", "seq1", "vin1", "rcv",
> +					  "ferr", "ppi", "debug";
> +			clocks = <&cpg CPG_MOD 0xec>, <&cpg CPG_MOD 0xe9>,
> +				 <&cpg CPG_MOD 0xe8>, <&cpg CPG_MOD 0xea>,
> +				 <&cpg CPG_MOD 0x190>, <&cpg CPG_MOD 0xeb>;
> +			clock-names = "pllrefclk", "aclk", "pclk", "vclk",
> +				      "lpclk", "vclk2";
> +			resets = <&cpg 0xd8>, <&cpg 0xd7>;
> +			reset-names = "arst", "prst";
> +			power-domains = <&cpg>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					dsi_in0: endpoint {
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					dsi_in1: endpoint {
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					dsi_out: endpoint {
> +					};
> +				};
> +			};
> +		};
> +
> +		du0: display@16460000 {
> +			compatible = "renesas,r9a09g047-du";
> +			reg = <0 0x16460000 0 0x10000>;
> +			interrupts = <GIC_SPI 882 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 0xed>,
> +				 <&cpg CPG_MOD 0xee>,
> +				 <&cpg CPG_MOD 0xef>;
> +			clock-names = "aclk", "pclk", "vclk";
> +			power-domains = <&cpg>;
> +			resets = <&cpg 0xdc>;

I'm a bit concerned here. The same reset line is shared by the FCP, VSP
and DU. The FCP driver doesn't currently control it, but the VSP and DU
both assert and de-assert reset, without any coordination. Does it work
by chance ?

> +			renesas,vsps = <&vspd0 0>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					du0_out_dsi: endpoint {
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					du0_out_lvds0: endpoint {
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					du0_out_lvds1: endpoint {
> +					};
> +				};
> +			};
> +		};
> +
> +		du1: display@16490000 {
> +			compatible = "renesas,r9a09g047-du";
> +			reg = <0 0x16490000 0 0x10000>;
> +			interrupts = <GIC_SPI 922 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 0x1a8>,
> +				 <&cpg CPG_MOD 0x1a9>,
> +				 <&cpg CPG_MOD 0x1aa>;
> +			clock-names = "aclk", "pclk", "vclk";
> +			power-domains = <&cpg>;
> +			resets = <&cpg 0x11e>;
> +			renesas,vsps = <&vspd1 0>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					du1_out_dsi: endpoint {
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					du1_out_rgb: endpoint {
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					du1_out_lvds1: endpoint {
> +					};
> +				};
> +			};
> +		};
> +
>  		fcpvd0: fcp@16470000 {
>  			compatible = "renesas,r9a09g047-fcpvd",
>  				     "renesas,fcpv";

-- 
Regards,

Laurent Pinchart
