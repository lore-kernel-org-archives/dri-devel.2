Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0471606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Ll8gehkX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30EF010F4B6;
	Tue, 24 Nov 2026 11:06:37 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D10310F4B6
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795518389;
 bh=TTFGIJjPz1husjeNRaaCxxGeA1hw8TRijgsgTglhZgQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ll8gehkXU3J0waBF64H0aeHsOAswyjIa+rRVWjrk4GUtXeni+O9uS4VB3PdVFLFfE
 cIUyKqHQAL1s35+Uog8fIZ9Nd16LLEZz6wqH2u54XoL2+VGw4jXfsrXDPWii74CS4U
 DBVOAEYvy9p5iYyKqXDrfx2vDdv5Do67lzyDBiRUXEZ5M1eT2cS9tqMnUqtBjkmOg2
 PPpZJPEA312b5EubHSiVLCapTco7YADU0o1IiKslDwDgjpUbk6z6+UPqW0SzNOcSe/
 YtRC9vFGSuWkPBcazfqO9bVH2/xJ8q4vCNLCuoG8LyU9gNTZA5ciRjRkUfqO4/UePn
 0zDXBRiBFml7w==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B08217E00E8;
 Tue, 24 Nov 2026 12:06:29 +0100 (CET)
Message-ID: <67738c52-3f49-4f26-9638-9536b0fba09e@collabora.com>
Date: Tue, 24 Nov 2026 12:06:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8167: Add DRM nodes for
 primary display path
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>,
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>
References: <20261123085840.8687-1-l.scorcia@gmail.com>
 <20261123085840.8687-3-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261123085840.8687-3-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 09:57, Luca Leonardo Scorcia wrote:
> Add all the DRM nodes required to get DSI and DPI0 to work on MT8167 SoC.
> 
> The primary display pipeline is defined using an OF graph identical to the
> fixed fallback implemented in driver code to maintain compatibility with
> existing boards. Its block sequence is as follows:
> 
> OVL -> COLOR -> CCORR -> AAL -> GAMMA -> DITHER -> RDMA0 -> DSI
> 
> If a board wants to use the DPI0 display output the last connection should
> be overridden in the board DTS. As far as I know however there are no
> devices using the DPI0 display output.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Luca, (Cc Krzysztof)

My brain got looped around the aliases mess - but I have eventually found a good
solution to... the aliases thing, which doesn't imply adding a bunch of MMIOs in
mediatek-drm nor in mmsys.

This solution, though, needs a decent devicetree with a proper description of the
hardware - which is not what you're providing here (and it's not really your fault)

I know I asked you to just drop the aliases, and I'm truly sorry for
   1. Wasting your time here, though only a few minutes, still wasted
   2. Asking you to redo this in a different way

Getting to point 2...

Of course, on all MediaTek SoCs, all of the Display Controller components are
effectively embedded in their own hardware subsystem - and this does effectively
include legacy chips - along with MT8167.

The right thing to do here is something I should've asked you to do on v1, and
that is describing the display controller Sub-IPs exactly as such: so those should
be children (read: subnodes) of mmsys.

This is also because there's no way to use any of the display controller components
if the display controller itself is not powered up (and I can go on with a billion
other reasons but I have no time right now, so sorry again).

Please, move the display controller children to the display controller node.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8167.dtsi | 297 +++++++++++++++++++++++
>   1 file changed, 297 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> index 27cf32d7ae35..a7818fd92edc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> @@ -120,10 +120,297 @@ iommu: m4u@10203000 {
>   			#iommu-cells = <1>;
>   		};
>   
> +		disp_pwm: pwm@1100f000 {
> +			compatible = "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm";
> +			reg = <0 0x1100f000 0 0x1000>;
> +			clocks = <&topckgen CLK_TOP_PWM_MM>, <&mmsys CLK_MM_DISP_PWM_MM>;
> +			clock-names = "main", "mm";
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +			#pwm-cells = <2>;
> +			status = "disabled";
> +		};
> +
>   		mmsys: syscon@14000000 {
>   			compatible = "mediatek,mt8167-mmsys", "syscon";
>   			reg = <0 0x14000000 0 0x1000>;
>   			#clock-cells = <1>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +
> +			port {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				mmsys_main: endpoint@0 {
> +					reg = <0>;
> +					remote-endpoint = <&ovl0_in>;
> +				};
> +			};
> +		};
> +
> +		ovl0: ovl@14007000 {
> +			compatible = "mediatek,mt8167-disp-ovl";
> +			reg = <0 0x14007000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL0>;
> +			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_LOW>;
> +			iommus = <&iommu M4U_PORT_DISP_OVL0>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					ovl0_in: endpoint {
> +						remote-endpoint = <&mmsys_main>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					ovl0_out: endpoint {
> +						remote-endpoint = <&color_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		rdma0: rdma@14009000 {
> +			compatible = "mediatek,mt8167-disp-rdma", "mediatek,mt2701-disp-rdma";
> +			reg = <0 0x14009000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
> +			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
> +			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					rdma0_in: endpoint {
> +						remote-endpoint = <&dither_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					rdma0_out: endpoint {
> +						remote-endpoint = <&dsi_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		wdma: wdma@1400b000 {
> +			compatible = "mediatek,mt8167-disp-wdma", "mediatek,mt8173-disp-wdma";
> +			reg = <0 0x1400b000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_WDMA>;
> +			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
> +			iommus = <&iommu M4U_PORT_DISP_WDMA0>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +		};
> +
> +		color: color@1400c000 {
> +			compatible = "mediatek,mt8167-disp-color";
> +			reg = <0 0x1400c000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_COLOR>;
> +			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					color_in: endpoint {
> +						remote-endpoint = <&ovl0_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					color_out: endpoint {
> +						remote-endpoint = <&ccorr_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		ccorr: ccorr@1400d000 {
> +			compatible = "mediatek,mt8167-disp-ccorr", "mediatek,mt8183-disp-ccorr";
> +			reg = <0 0x1400d000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_CCORR>;
> +			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					ccorr_in: endpoint {
> +						remote-endpoint = <&color_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					ccorr_out: endpoint {
> +						remote-endpoint = <&aal_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		aal: aal@1400e000 {
> +			compatible = "mediatek,mt8167-disp-aal", "mediatek,mt8173-disp-aal";
> +			reg = <0 0x1400e000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_AAL>;
> +			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					aal_in: endpoint {
> +						remote-endpoint = <&ccorr_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					aal_out: endpoint {
> +						remote-endpoint = <&gamma_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		gamma: gamma@1400f000 {
> +			compatible = "mediatek,mt8167-disp-gamma", "mediatek,mt8173-disp-gamma";
> +			reg = <0 0x1400f000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_GAMMA>;
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					gamma_in: endpoint {
> +						remote-endpoint = <&aal_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					gamma_out: endpoint {
> +						remote-endpoint = <&dither_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		dither: dither@14010000 {
> +			compatible = "mediatek,mt8167-disp-dither", "mediatek,mt8183-disp-dither";
> +			reg = <0 0x14010000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_DITHER>;
> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					dither_in: endpoint {
> +						remote-endpoint = <&gamma_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					dither_out: endpoint {
> +						remote-endpoint = <&rdma0_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		dsi: dsi@14012000 {
> +			compatible = "mediatek,mt8167-dsi";
> +			reg = <0 0x14012000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DSI_ENGINE>, <&mmsys CLK_MM_DSI_DIGITAL>,
> +				 <&mipi_tx>;
> +			clock-names = "engine", "digital", "hs";
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_LOW>;
> +			phys = <&mipi_tx>;
> +			phy-names = "dphy";
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +			status = "disabled";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					dsi_in: endpoint {
> +						remote-endpoint = <&rdma0_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					dsi_out: endpoint { };
> +				};
> +			};
> +		};
> +
> +		dpi0: dpi@14013000 {
> +			compatible = "mediatek,mt8167-dpi";
> +			reg = <0 0x14013000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DPI0_PXL>, <&mmsys CLK_MM_DPI0_ENGINE>,
> +				 <&apmixedsys CLK_APMIXED_LVDSPLL>;
> +			clock-names = "pixel", "engine", "pll";
> +			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					dpi0_in: endpoint { };
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					dpi0_out: endpoint { };
> +				};
> +			};
> +		};
> +
> +		mutex: mutex@14015000 {
> +			compatible = "mediatek,mt8167-disp-mutex";
> +			reg = <0 0x14015000 0 0x1000>;
> +			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
>   		};
>   
>   		larb0: larb@14016000 {
> @@ -145,6 +432,16 @@ smi_common: smi@14017000 {
>   			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
>   		};
>   
> +		mipi_tx: dsi-phy@14018000 {
> +			compatible = "mediatek,mt8167-mipi-tx", "mediatek,mt2701-mipi-tx";
> +			reg = <0 0x14018000 0 0x90>;
> +			clocks = <&topckgen CLK_TOP_MIPI_26M_DBG>;
> +			clock-output-names = "mipi_tx0_pll";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>   		imgsys: syscon@15000000 {
>   			compatible = "mediatek,mt8167-imgsys", "syscon";
>   			reg = <0 0x15000000 0 0x1000>;

