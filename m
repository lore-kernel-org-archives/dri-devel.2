Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CC1CD4F3D
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 02:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05EBC10E0A5;
	Mon, 18 May 2026 02:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FwLaaBmh";
	dkim-atps=neutral
Received: from mail-m3294.qiye.163.com (mail-m3294.qiye.163.com
 [220.197.32.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9300010E0A5
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:44:34 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3ec15c82d;
 Mon, 18 May 2026 10:44:29 +0800 (GMT+08:00)
Message-ID: <a7ab01f6-78a4-405f-8160-8af31a8ef99c@rock-chips.com>
Date: Mon, 18 May 2026 10:44:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: display: rockchip: analogix-dp:
 Expose inherited properties
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260514070133.2275069-1-damon.ding@rock-chips.com>
 <20260514070133.2275069-2-damon.ding@rock-chips.com>
 <20260514-upstate-sneer-0b6e78682798@spud>
 <2f653664-27e9-4632-97e9-8b59cf7e585e@rock-chips.com>
 <20260515-confess-hungrily-4f64ce0d8de2@wendy>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260515-confess-hungrily-4f64ce0d8de2@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e38f87b4603a3kunm9c63833a220204
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQk1DSlZISUJPHkwfS0
 pMH0JWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSEpKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=FwLaaBmhRyX/1x2IvWIC8qOmg34/xaCXClSHSdAJaEUcRSf5nX3SBXOZhMb994CUmRYQeSsjZ6y0NOI6bU0UW1xVnMC9WLJxklcjrM2drB63dzkXrU7kaLlmYkFEXYIvDYF0lijlkN3eymJS+Yf77EsmSG7sshWzf/Qm15GFjng=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=mmp02j+JTh/LSA7GCH0kahZIKzpGQLcvXOXcVOAsbFw=;
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

Hi Conor,

On 5/15/2026 5:04 PM, Conor Dooley wrote:
> On Fri, May 15, 2026 at 11:57:58AM +0800, Damon Ding wrote:
>> Hi Conor,
>>
>> On 5/15/2026 2:16 AM, Conor Dooley wrote:
>>> On Thu, May 14, 2026 at 03:01:31PM +0800, Damon Ding wrote:
>>>> Expose the inherited properties from the base analogix-dp schema
>>>> to satisfy unevaluatedProperties constraints.
>>>>
>>>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>>
>>> Given it's unevaluatedProperties, not addtionalProperties, this patch
>>> shouldn't be needed?
>>>
>>
>> When I remove both the top-level data-lanes property and those explicit
>> "xxx: true" property entries and run the dtbs check with:
>>
>> make CHECK_DTBS=y CROSS_COMPILE=aarch64-linux-gnu- LT0=none LLVM=1
>> LLVM_IAS=1 ARCH=arm64 rockchip/rk3588-evb1-v10.dtb
>> rockchip/rk3588s-evb1-v10.dtb rockchip/rk3399-sapphire-excavator.dtb
>> rockchip/rk3576-evb1-v10.dtb -j4
>>
>> It results in validation errors like these:
>>
>> /home/ding/drm-misc/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb:
>> edp@27dc0000: ports:port@1:endpoint: Unevaluated properties are not allowed
>> ('data-lanes' was unexpected)
>>          from schema $id:
>> http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
>> /home/ding/drm-misc/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb:
>> edp@27dc0000: Unevaluated properties are not allowed ('force-hpd',
>> 'interrupts', 'phy-names', 'phys', 'ports', 'reg' were unexpected)
>>          from schema $id:
>> http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
>>
>> I suspect that the properties defined in the child binding are
>> overriding/masking all the inherited properties from the parent Analogix DP
>> schema.
>>
>> Is there a better way to fix this issue without explicitly listing all
>> inherited properties as true?
> 
> The example in this file uses most of the properties that you mention
> above:
>      dp@ff970000 {
>        compatible = "rockchip,rk3288-dp";
>        reg = <0xff970000 0x4000>;
>        interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>        clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
>        clock-names = "dp", "pclk";
>        phys = <&dp_phy>;
>        phy-names = "dp";
>        resets = <&cru 111>;
>        reset-names = "dp";
>        rockchip,grf = <&grf>;
>        pinctrl-0 = <&edp_hpd>;
>        pinctrl-names = "default";
> 
> dt_binding_check reports no problems with this node, so I think the
> problem might lie elsewhere?
> There's no edp node in the dts you mention above, so this looks like an
> interaction with something that's not yet upstream.

Ah, I see.

I did add extra changes to the edp node on my local rk3576-evb1 board 
DTS, which indeed caused this 'asymmetric information' issue and made 
the validation fail incorrectly.

I will try adding the data-lanes property to the example in the binding 
document to ensure dt_binding_check passes cleanly.

> 
> If this is required for the rk3576 edp, then you should include this
> patch in the rk3576 edp support series rather than this one anyway where
> it can actually be evaluated alongside the node it apparently causes
> problems with.

The data-lanes property is actually applicable and useful for all 
Rockchip eDP platforms, not just rk3576.

In the next version, I will modify the series to better separate this 
common data-lanes change from the rk3576 specific eDP support patches.

> 
> pw-bot: changes-requested
> 
>>
>> Best regards,
>> Damon
>>
>>>> ---
>>>>    .../bindings/display/rockchip/rockchip,analogix-dp.yaml    | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>>>> index bb75d898a5c5..896ded87880f 100644
>>>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>>>> @@ -50,6 +50,13 @@ properties:
>>>>      aux-bus:
>>>>        $ref: /schemas/display/dp-aux-bus.yaml#
>>>> +  reg: true
>>>> +  interrupts: true
>>>> +  phys: true
>>>> +  phy-names: true
>>>> +  force-hpd: true
>>>> +  ports: true
>>>> +
>>>>    required:
>>>>      - compatible
>>>>      - clocks
>>>> -- 
>>>> 2.34.1
>>>>
>>>>
>>

Best regards,
Damon

