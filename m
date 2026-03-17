Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46610FB5E97
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 01:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70E210E117;
	Tue, 17 Mar 2026 01:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MQeOlmq0";
	dkim-atps=neutral
Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com
 [117.135.214.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D27810E117
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 01:37:16 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 372f3216c;
 Tue, 17 Mar 2026 09:37:10 +0800 (GMT+08:00)
Message-ID: <05a8012d-c1f7-417b-96f8-ec1a41993b26@rock-chips.com>
Date: Tue, 17 Mar 2026 09:37:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] arm64: dts: rockchip: Add eDP node for RK3576
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, alchark@gmail.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 kever.yang@rock-chips.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260310105307.309765-1-damon.ding@rock-chips.com>
 <20260310105307.309765-3-damon.ding@rock-chips.com>
 <9590182.CDJkKcVGEf@workhorse>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <9590182.CDJkKcVGEf@workhorse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cf970940603a3kunm76417074222a43
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4YSVZOGUpITUwaShhPQxpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=MQeOlmq07ycIc1QL4tGgjDuL85uSHPI3xkw6nYsJa7yU+1prZ8PKktKJMqK5SwPdJufqOaA4RldAN9jPxB19GDSRAGpXfK0/ea/DXI3LlkAZIgPQorilo6arCjAGHm5nL0FwSnygNzNpV9fBwJmiWVLAnNUnmmEJVMailCWpYOU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=3Q89cxIkHSk/a2RjqYAjgiexXPdpx/jNB/mz4sMPZKU=;
 h=date:mime-version:subject:message-id:from;
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

Hi Nicolas,

On 3/16/2026 7:31 PM, Nicolas Frattaroli wrote:
> On Tuesday, 10 March 2026 11:53:05 Central European Standard Time Damon Ding wrote:
>> Add support for the eDP output on RK3576 SoC.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3576.dtsi | 28 ++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
>> index a86fc6b4e8c4..14900a66d3e1 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
>> @@ -1446,6 +1446,34 @@ hdmi_out: port@1 {
>>   			};
>>   		};
>>   
>> +		edp: edp@27dc0000 {
>> +			compatible = "rockchip,rk3576-edp";
>> +			reg = <0x0 0x27dc0000 0x0 0x1000>;
>> +			clocks = <&cru CLK_EDP0_24M>, <&cru PCLK_EDP0>, <&cru HCLK_VO0_ROOT>;
>> +			clock-names = "dp", "pclk", "hclk";
>> +			interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
>> +			phys = <&hdptxphy>;
>> +			phy-names = "dp";
>> +			power-domains = <&power RK3576_PD_VO0>;
>> +			resets = <&cru SRST_EDP0_24M>, <&cru SRST_P_EDP0>;
>> +			reset-names = "dp", "apb";
>> +			rockchip,grf = <&vo0_grf>;
>> +			status = "disabled";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				edp_in: port@0 {
>> +					reg = <0>;
>> +				};
>> +
>> +				edp_out: port@1 {
>> +					reg = <1>;
>> +				};
>> +			};
>> +		};
>> +
>>   		sai7: sai@27ed0000 {
>>   			compatible = "rockchip,rk3576-sai";
>>   			reg = <0x0 0x27ed0000 0x0 0x1000>;
>>
> 
> Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> By cross-referencing the TRM, I checked the address, the IRQ number,
> and the power domain, and verified that there are no new check_dtbs
> warnings introduced.
> 
> 

Thanks for the review.

Best regards,
Damon

