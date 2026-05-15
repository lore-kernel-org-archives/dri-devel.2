Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B5DCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 03:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0217810F3BA;
	Fri, 15 May 2026 03:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UZB7lH4h";
	dkim-atps=neutral
X-Greylist: delayed 159202 seconds by postgrey-1.36 at gabe;
 Fri, 15 May 2026 03:58:03 UTC
Received: from mail-m83145.xmail.ntesmail.com (mail-m83145.xmail.ntesmail.com
 [156.224.83.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723E610F3BE
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 03:58:02 +0000 (UTC)
Received: from [172.16.12.43] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3e82fac39;
 Fri, 15 May 2026 11:57:58 +0800 (GMT+08:00)
Message-ID: <2f653664-27e9-4632-97e9-8b59cf7e585e@rock-chips.com>
Date: Fri, 15 May 2026 11:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: display: rockchip: analogix-dp:
 Expose inherited properties
To: Conor Dooley <conor@kernel.org>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
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
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260514-upstate-sneer-0b6e78682798@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e29c8ae0703a3kunmd1b8d9bd125afa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSktLVkIYTR8aHkgdTE0YSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=UZB7lH4hvEXP3pLiPNBhvVIN/gQNsy9iafLoKvDKgsRRFlrJKAecHptJ7/J77wyBeceuZOOprBHD36ae6nHJk5rWBHxxSgKKrOX7JTLhssGbJxofO/ZsqaDhRPiJGMf+/tYd2AQbZfHuNBGK4/0Iow6PsrJyKqHXbi5WbuimHJU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=num2dBkmQCmOz3VFEseziFih+L9BmXJ8Dbo1P1UCNNw=;
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

On 5/15/2026 2:16 AM, Conor Dooley wrote:
> On Thu, May 14, 2026 at 03:01:31PM +0800, Damon Ding wrote:
>> Expose the inherited properties from the base analogix-dp schema
>> to satisfy unevaluatedProperties constraints.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> Given it's unevaluatedProperties, not addtionalProperties, this patch
> shouldn't be needed?
> 

When I remove both the top-level data-lanes property and those explicit 
"xxx: true" property entries and run the dtbs check with:

make CHECK_DTBS=y CROSS_COMPILE=aarch64-linux-gnu- LT0=none LLVM=1 
LLVM_IAS=1 ARCH=arm64 rockchip/rk3588-evb1-v10.dtb 
rockchip/rk3588s-evb1-v10.dtb rockchip/rk3399-sapphire-excavator.dtb 
rockchip/rk3576-evb1-v10.dtb -j4

It results in validation errors like these:

/home/ding/drm-misc/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb: 
edp@27dc0000: ports:port@1:endpoint: Unevaluated properties are not 
allowed ('data-lanes' was unexpected)
         from schema $id: 
http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
/home/ding/drm-misc/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb: 
edp@27dc0000: Unevaluated properties are not allowed ('force-hpd', 
'interrupts', 'phy-names', 'phys', 'ports', 'reg' were unexpected)
         from schema $id: 
http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#

I suspect that the properties defined in the child binding are 
overriding/masking all the inherited properties from the parent Analogix 
DP schema.

Is there a better way to fix this issue without explicitly listing all 
inherited properties as true?

Best regards,
Damon

>> ---
>>   .../bindings/display/rockchip/rockchip,analogix-dp.yaml    | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> index bb75d898a5c5..896ded87880f 100644
>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> @@ -50,6 +50,13 @@ properties:
>>     aux-bus:
>>       $ref: /schemas/display/dp-aux-bus.yaml#
>>   
>> +  reg: true
>> +  interrupts: true
>> +  phys: true
>> +  phy-names: true
>> +  force-hpd: true
>> +  ports: true
>> +
>>   required:
>>     - compatible
>>     - clocks
>> -- 
>> 2.34.1
>>
>>

