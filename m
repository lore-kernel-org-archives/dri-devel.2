Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ED9CD98C5
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 23:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F57A10EC2C;
	Wed, 10 Jun 2026 23:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GEhPfC8l";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491FA10EC2C
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 23:34:26 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 937B3228;
 Thu, 11 Jun 2026 01:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781134435;
 bh=1C5BT+PWAuHbC8UL6zuNvAxCqq1MTTxJwQYB3lZXSsA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GEhPfC8l2CbVV0e06sSA3Gr+2iRQ5xuezAaZXh4LJ+2+0xS1lhdnxQEDerm8RBrW1
 zO6fexWbYwCiVeqFFHYategxlJYuWCHe5j2XuzQZn0gVwI+nIzSsdRZqy2RxjAGDry
 tbNs2lbxeljHX3Imb2A9pSOK3SLRqg15PfNJGMpw=
Date: Thu, 11 Jun 2026 02:34:23 +0300
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
Subject: Re: [PATCH v3 7/7] arm64: dts: renesas: white-hawk: Add second
 mini-DP output support
Message-ID: <20260610233423.GF1632628@killaraus.ideasonboard.com>
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
 <20260515-rcar-du-dsc-v3-7-164157820498@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-rcar-du-dsc-v3-7-164157820498@ideasonboard.com>
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

Hi Tomi, Geert,

Thank you for the patch.

On Fri, May 15, 2026 at 12:09:32PM +0300, Tomi Valkeinen wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Add support for the mini-DisplayPort connector on the White Hawk
> BreakOut board.  This port is driven by a TI SN65DSI86 DSI to eDP
> bridge, which in turn gets the pixel data from the second DSI channel on
> the R-Car V4H SoC.  Note that this port is not present on the White Hawk

I would write "connector" instead of "port". The White Hawk Single
connects the DSI1 output to a GMSL serializer.

> Single development board.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [tomi.valkeinen: added status=okay for dsc]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  .../arm64/boot/dts/renesas/r8a779g0-white-hawk.dts | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
> index 784d4e8b204c..89d60b83ac4f 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dts
> @@ -12,4 +12,98 @@
>  / {
>  	model = "Renesas White Hawk CPU and Breakout boards based on r8a779g0";
>  	compatible = "renesas,white-hawk-breakout", "renesas,white-hawk-cpu", "renesas,r8a779g0";
> +
> +	sn65dsi86_refclk2: clk-x16 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <38400000>;
> +	};
> +
> +	mini-dp-con2 {
> +		compatible = "dp-connector";
> +		label = "CN15";
> +		type = "mini";
> +
> +		port {
> +			mini_dp_con_in2: endpoint {
> +				remote-endpoint = <&sn65dsi86_out2>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsc {
> +	status = "okay";
> +};
> +
> +&dsi1 {
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			dsi1_out: endpoint {
> +				remote-endpoint = <&sn65dsi86_in2>;
> +				data-lanes = <1 2 3 4>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	pinctrl-0 = <&i2c4_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	bridge@2c {
> +		pinctrl-0 = <&irq1_pins>;
> +		pinctrl-names = "default";
> +
> +		compatible = "ti,sn65dsi86";
> +		reg = <0x2c>;
> +
> +		clocks = <&sn65dsi86_refclk2>;
> +		clock-names = "refclk";
> +
> +		interrupts-extended = <&intc_ex 1 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		enable-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> +
> +		vccio-supply = <&reg_1p8v>;
> +		vpll-supply = <&reg_1p8v>;
> +		vcca-supply = <&reg_1p2v>;
> +		vcc-supply = <&reg_1p2v>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				sn65dsi86_in2: endpoint {
> +					remote-endpoint = <&dsi1_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				sn65dsi86_out2: endpoint {
> +					remote-endpoint = <&mini_dp_con_in2>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&pfc {
> +	i2c4_pins: i2c4 {
> +		groups = "i2c4";
> +		function = "i2c4";
> +	};
> +
> +	irq1_pins: irq1 {
> +		groups = "intc_ex_irq1_a";
> +		function = "intc_ex";
> +	};
>  };
> 

-- 
Regards,

Laurent Pinchart
