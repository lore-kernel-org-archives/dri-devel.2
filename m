Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCCACD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 23:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF2E10EC23;
	Wed, 10 Jun 2026 23:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Cs87tXWK";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32BF810EC20
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 23:24:07 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 86A02228;
 Thu, 11 Jun 2026 01:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781133816;
 bh=1VgXq/psbzPZ5ujKREwdsJzxQTcDhvTF80CsspVxDH0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cs87tXWK6hb7EuJl/FYSVlMzECBIoDmVnwjQh86ApEAq4bvqbHWDOezgf2P0NQ/ka
 nBTPwxU7NqsP3yRF/yIFPQKIm2F+KMoiG9GfZ19Fwu4i1W+SS0NLtDUyGR3AivFslr
 dZIqyvBQhMCXRrJHCKDDAhlFZXSy00Sdvzs1CYQs=
Date: Thu, 11 Jun 2026 02:24:04 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] arm64: dts: renesas: r8a779g0: Add DSC
Message-ID: <20260610232404.GD1632628@killaraus.ideasonboard.com>
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
 <20260515-rcar-du-dsc-v3-5-164157820498@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-rcar-du-dsc-v3-5-164157820498@ideasonboard.com>
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

Hi Tomi and Marek,

Thank you for the patch.

On Fri, May 15, 2026 at 12:09:30PM +0300, Tomi Valkeinen wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> The Renesas DSC Display Stream Compression is a bridge embedded in the
> Renesas R-Car V4H SoC. The bridge is placed between DU and DSI1 units.
> 
> The current dtsi file does not represent the DSC at all, and thus the
> pipeline for DSI1 has not been functional.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [tomi.valkeinen: separated the sparrowhawk changes]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> index 82a7278836e5..52a6176f9fd0 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> @@ -2298,6 +2298,35 @@ du_out_dsi0: endpoint {
>  				port@1 {
>  					reg = <1>;
>  					du_out_dsi1: endpoint {
> +						remote-endpoint = <&dsc_in_dsi1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		dsc: dsc@feb8d000 {
> +			compatible = "renesas,r8a779g0-dsc";
> +			reg = <0 0xfeb8d000 0 0x400>;
> +			interrupts = <GIC_SPI 559 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 2819>;
> +			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> +			resets = <&cpg 2819>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					dsc_in_dsi1: endpoint {
> +						remote-endpoint = <&du_out_dsi1>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					dsc_out_dsi1: endpoint {
>  						remote-endpoint = <&dsi1_in>;
>  					};
>  				};
> @@ -2534,7 +2563,7 @@ ports {
>  				port@0 {
>  					reg = <0>;
>  					dsi1_in: endpoint {
> -						remote-endpoint = <&du_out_dsi1>;
> +						remote-endpoint = <&dsc_out_dsi1>;
>  					};
>  				};
>  
> 

-- 
Regards,

Laurent Pinchart
