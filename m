Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249C91073CBA
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7639A10E66E;
	Wed,  8 Apr 2026 13:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="N0MeI2e6";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7998910E66E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 13:57:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B950267F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 06:57:01 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 C4DC23F641
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775656627; bh=DtgfAHIcG2yL3Uyz3ksmN6rTp9I1YSd/gQUgwKu2M3Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N0MeI2e6aQ/+6B/O7ABN+afiQBpZX7ijyHP84mYjd4wAlyLJjC6BjtOJEUeSHj8rm
 /3SrFuUAJrg5PjSprnMAMfUHy87G+VBNMRfdt3dvlfhrIfvhMh9gMPl9fz1AMOtAeN
 MT7zfURwNfRdmaRrjZ31MOWhR3j/x0y3xWaLln0k=
Date: Wed, 8 Apr 2026 14:56:47 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Guangliu Ding <guangliu.ding@nxp.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: imx952: Describe Mali G310 GPU
Message-ID: <adZeny_sRg7t_A3j@e142607>
References: <20260407-master-v3-1-5a05cea0c521@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407-master-v3-1-5a05cea0c521@nxp.com>
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

On Tue, Apr 07, 2026 at 11:15:03AM +0800, Guangliu Ding wrote:
> Support Mali G310 GPU on i.MX952 board. Describe this GPU in the DT.
> Include dummy GPU voltage regulator and OPP tables.
> 
> A hardware GPU auto clock‑gating mechanism has been introduced,
> enabling GPUMIX to automatically manage the GPU clock. This improves
> overall response time.
> 
> Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> This series enable Mali G310 GPU support on i.MX952 boards, the same GPU
> IP as the instance on i.MX95 boards.
> ---
> Changes in v3:
> - Follow the order of interrupts/interrupt-names in arm,mali-valhall-csf.yaml.
> - Drop dt-bindings change in arm,mali-valhall-csf.yaml.
> - Replace "nxp,imx952-mali" with "nxp,imx95-mali" in compatible.
> - Link to v2: https://patch.msgid.link/20260401-master-v2-0-20d3fbcd19d6@nxp.com
> 
> Changes in v2:
> - Improve patch description, adding more GPU information.
> - Remove Reviewed-by tag.
> - Link to v1: https://patch.msgid.link/20260331-master-v1-0-65c8e318d462@nxp.com
> ---
>  arch/arm64/boot/dts/freescale/imx952.dtsi | 36 +++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx952.dtsi b/arch/arm64/boot/dts/freescale/imx952.dtsi
> index 91fe4916ac04..ced09e7a1dc5 100644
> --- a/arch/arm64/boot/dts/freescale/imx952.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx952.dtsi
> @@ -318,6 +318,28 @@ usbphynop2: usbphynop2 {
>  		clock-names = "main_clk";
>  	};
>  
> +	gpu_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-hz-real = /bits/ 64 <500000000>;
> +			opp-microvolt = <920000>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-hz-real = /bits/ 64 <800000000>;
> +			opp-microvolt = <920000>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-hz-real = /bits/ 64 <1000000000>;
> +			opp-microvolt = <920000>;
> +		};
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> @@ -1262,5 +1284,19 @@ usbmisc2: usbmisc@4c200200 {
>  			reg = <0x0 0x4c200200 0x0 0x200>,
>  			      <0x0 0x4c010014 0x0 0x4>;
>  		};
> +
> +		gpu: gpu@4d900000 {
> +			compatible = "nxp,imx95-mali", "arm,mali-valhall-csf";
> +			reg = <0 0x4d900000 0 0x480000>;
> +			interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "job", "mmu", "gpu";
> +			clocks = <&scmi_clk IMX952_CLK_GPU>;
> +			clock-names = "core";
> +			power-domains = <&scmi_devpd IMX952_PD_GPU>;
> +			operating-points-v2 = <&gpu_opp_table>;
> +			dynamic-power-coefficient = <1013>;
> +		};
>  	};
>  };
> 
> ---
> base-commit: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
> change-id: 20260331-master-7ec7ff0fe1b2
> 
> Best regards,
> --  
> Guangliu Ding <guangliu.ding@nxp.com>
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
