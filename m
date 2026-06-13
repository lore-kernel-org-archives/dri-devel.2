Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510C1CD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 08:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22F010ED0F;
	Sat, 13 Jun 2026 08:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OAHCPxkJ";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2086910ED0F
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1781338698;
 bh=xpDULfvSGqlETs98W87UX/kuF4lM1kjk45D89odlqmI=;
 b=OAHCPxkJufymq9QStuXkAlwjzUbNH1KpoHFsvSYcPnjtQ8eeFo4AAi1SUQgulgtirOLVFihxe
 SGv5sZfMlSKzuqwzmXANS20DI5++h2wq+ZTlA8e6vE7ke4/UCttAP7ebKhr3ITmWnaWwxypS21Z
 KgOC1DwX8AiGgrXyoMl6qUPDH/A/OqCslNjljZDTMZlVRTrvKy4+8sTz1UvyNBvNBYqLHkQj7W0
 Ab4uGdRmhFq2/EBsNqMjNBslqzSI/sk9eZ1+sM4qYg8MzADcP6bQYO3RvFEJ9+DNp1rsuaf7sKE
 e4iLbhFx6WyjrjOWDtNjILQxnIDJPClGhvN44rwwz2kw==
X-Forward-Email-ID: 6a2d12469b8e0435f022b519
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0e6466aa-a153-446b-b31c-e9b331573358@kwiboo.se>
Date: Sat, 13 Jun 2026 10:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 7/9] arm64: dts: rockchip: rk356x: Add the NPU and
 its IOMMU
To: MidG971 <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, xxm@rock-chips.com,
 chaoyi.chen@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com
References: <20260613070116.438906-1-midgy971@gmail.com>
 <20260613070116.438906-8-midgy971@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260613070116.438906-8-midgy971@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Midgy,

On 6/13/2026 9:01 AM, MidG971 wrote:
> From: Midgy BALON <midgy971@gmail.com>
> 
> The RK3568 has an NVDLA-derived NPU at fde40000 with its own IOMMU at
> fde4b000. Add both nodes (disabled by default) and the NPU power-domain
> child under the PMU power-controller, and point rockchip,pmu at the PMU
> syscon that controls the NPU NoC bus-idle.
> 
> Besides the SCMI compute clock, assign the CRU CLK_NPU so the NPU AXI
> bus clock comes up at 200 MHz rather than the 12 MHz boot default.
> 
> The power-domain deliberately carries no pm_qos: qos_npu sits behind the
> NPU NoC, which is gated until the NPU is brought up, so a genpd power-off
> QoS save would fault reading it.
> 
> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> index 64bdd8b7754b5..313db59c1aed8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> @@ -512,6 +512,13 @@ power-domain@RK3568_PD_GPU {
>  				#power-domain-cells = <0>;
>  			};
>  
> +			pd_npu: power-domain@RK3568_PD_NPU {
> +				reg = <RK3568_PD_NPU>;
> +				clocks = <&cru ACLK_NPU_PRE>,
> +					 <&cru HCLK_NPU_PRE>;
> +				#power-domain-cells = <0>;
> +			};
> +
>  			/* These power domains are grouped by VD_LOGIC */
>  			power-domain@RK3568_PD_VI {
>  				reg = <RK3568_PD_VI>;
> @@ -572,6 +579,37 @@ power-domain@RK3568_PD_RKVENC {
>  		};
>  	};
>  
> +	rknn_core_0: npu@fde40000 {
> +		compatible = "rockchip,rk3568-rknn-core";
> +		reg = <0x0 0xfde40000 0x0 0x1000>,
> +		      <0x0 0xfde41000 0x0 0x1000>,
> +		      <0x0 0xfde43000 0x0 0x1000>;
> +		reg-names = "pc", "cna", "core";
> +		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>,
> +			 <&scmi_clk SCMI_CLK_NPU>, <&cru PCLK_NPU_PRE>;
> +		clock-names = "aclk", "hclk", "npu", "pclk";
> +		assigned-clocks = <&scmi_clk SCMI_CLK_NPU>, <&cru CLK_NPU>;
> +		assigned-clock-rates = <200000000>, <600000000>;

This looks strange, the SCMI clk can be seen as a virtual clock that
changes between normal CRU NPU clk and a PVTPLL NPU clk (depending on
rate). 200 MHz, a typical opp-suspend value (switch to CRU clk instead
of PVTPLL), will set the CLK_NPU rate to 200 MHz, then setting CLK_NPU
to 600 MHz (the lowest rate that activates PVTPLL mode) outside of SCMI
control looks strange.

Suggest you only set SCMI NPU clk rate to 200 or 400 MHz and drop any
special handling, e.g. noc_init, to closer match RK3588 and defer any
use of PVTPLL clk to a future series that also adds OPP support.

> +		resets = <&cru SRST_A_NPU>, <&cru SRST_H_NPU>;
> +		reset-names = "srst_a", "srst_h";
> +		power-domains = <&power RK3568_PD_NPU>;
> +		rockchip,pmu = <&pmu>;

This looks wrong, the rockchip,pmu prop is typically used to reference
PMU GRF, see i.e. pinctrl node, not the power-management that is seem to
be correctly abstracted using power-domains above, please drop this prop.

Regards,
Jonas

> +		iommus = <&rknn_mmu_0>;
> +		status = "disabled";
> +	};
> +
> +	rknn_mmu_0: iommu@fde4b000 {
> +		compatible = "rockchip,iommu";
> +		reg = <0x0 0xfde4b000 0x0 0x40>;
> +		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-names = "aclk", "iface";
> +		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>;
> +		power-domains = <&power RK3568_PD_NPU>;
> +		#iommu-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	gpu: gpu@fde60000 {
>  		compatible = "rockchip,rk3568-mali", "arm,mali-bifrost";
>  		reg = <0x0 0xfde60000 0x0 0x4000>;

