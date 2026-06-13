Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B48CD98C5
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE4210ECD3;
	Sat, 13 Jun 2026 07:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hAl4WAxR";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81ACF10ECD3
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1781336455;
 bh=qHK4xcuZuyY3VWkKdAkc6bfYV2q4RPDKWtvw4p7wT+w=;
 b=hAl4WAxRxs/ZvxN8Tsnh39Vx+Wd0eFIeV3w0nae8LiNv2Gtw5njjh6FZRT+97DDJZwCTQmOXD
 PZJZVtykDki1fme3042lw0BQve7J8dGRjnRFyke/P7/3WhSf2sCYv7qaHngIvZjhF6ZFuJaEU+V
 9tXkGvk7in9AyhYJyQmUpgwiMO1sYxhU7pQl1AUVCzteGdaOK2b8isJBMyRJTRrDA+8DIdOCg6V
 dAUh3ti8QlkEuvmKk8GL53oEoLIRjWAcOD4pO6R6fpNmucBH67wce6YbdiEsB71qjMOeWkU8uJo
 eMSMPB/bHhlM3IiS2VYfj2ilKbOYSAEPTEYSDCEkhkCQ==
X-Forward-Email-ID: 6a2d09837f2a6d9c19af5dbd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e0f044df-9d34-4e6e-aa48-9e4227b4bdf7@kwiboo.se>
Date: Sat, 13 Jun 2026 09:40:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 8/9] arm64: dts: rockchip: rk3568-rock-3b: Enable
 the NPU
To: MidG971 <midgy971@gmail.com>
Cc: "tomeu@tomeuvizoso.net" <tomeu@tomeuvizoso.net>,
 "ogabbay@kernel.org" <ogabbay@kernel.org>, "heiko@sntech.de"
 <heiko@sntech.de>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xxm@rock-chips.com" <xxm@rock-chips.com>,
 "chaoyi.chen@rock-chips.com" <chaoyi.chen@rock-chips.com>,
 "finley.xiao@rock-chips.com" <finley.xiao@rock-chips.com>,
 "diederik@cknow-tech.com" <diederik@cknow-tech.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
 <20260613070116.438906-9-midgy971@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260613070116.438906-9-midgy971@gmail.com>
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
> Enable the NPU and its IOMMU on ROCK 3B and wire vdd_npu as the NPU
> power domain's domain-supply, so genpd brings the rail up and down with
> the domain (the domain is marked need_regulator). The PVTPLL compute
> clock is brought up later by the driver.
> 
> The rail is no longer kept always-on, so pin it to 1000 mV (the NPU's
> 1 GHz operating voltage; the driver runs a fixed compute rate with no
> devfreq voltage scaling) and mark it boot-on, so it is up before the
> power domain de-idles the NPU NoC at power-on.
> 
> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>  .../arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> index 69001e453732e..d3f9776c2bdc3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> @@ -330,9 +330,10 @@ regulator-state-mem {
>  
>  			vdd_npu: DCDC_REG4 {
>  				regulator-name = "vdd_npu";
> +				regulator-boot-on;

There is no need for the NPU in the bootloader, do not use DT as a
workaround for software issues.

This series mention the PVTPLL NPU clk and seem to contains some
workarounds related to how the PVTPLL clock is handled in TF-A.

The PVTPLL block typically require the pclk and power domain enabled to
function, and this series seem to add workarounds to try and ensure this,
e.g. with noc_init to activate PVTPLL usage.

I would suggest that you do not involve the PVTPLL clock in this initial
NPU support for RK3568, set CLK_NPU to 400 MHz and use it instead of the
SCMI clock, or keep SCMI clk rate less than or equal to 400 MHz to
disable PVTPLL_NEED mode in TF-A.

In a future series you can extend Linux with a proper PVTPLL clk driver
and OPP support for the rocket driver to correctly ensure pclk and pd is
enabled when a PVTPLL clock is managed.

>  				regulator-initial-mode = <0x2>;
> -				regulator-min-microvolt = <500000>;
> -				regulator-max-microvolt = <1350000>;
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;

Please describe the HW, do not add workarounds for software issues or
shortcomings.

Regards,
Jonas

>  				regulator-ramp-delay = <6001>;
>  
>  				regulator-state-mem {
> @@ -787,3 +788,16 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>  		remote-endpoint = <&hdmi_in_vp0>;
>  	};
>  };
> +
> +&pd_npu {
> +	domain-supply = <&vdd_npu>;
> +};
> +
> +&rknn_core_0 {
> +	npu-supply = <&vdd_npu>;
> +	status = "okay";
> +};
> +
> +&rknn_mmu_0 {
> +	status = "okay";
> +};

