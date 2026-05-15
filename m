Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C1BCD37AC
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 02:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A4510F3A6;
	Fri, 15 May 2026 02:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LqrIEfZA";
	dkim-atps=neutral
Received: from mail-m8286.xmail.ntesmail.com (mail-m8286.xmail.ntesmail.com
 [156.224.82.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5045F10F3A6
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:36:36 +0000 (UTC)
Received: from [172.16.12.43] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3e7fc10ae;
 Fri, 15 May 2026 10:36:32 +0800 (GMT+08:00)
Message-ID: <f290b425-d5e1-46dd-a63e-0fac53067ca0@rock-chips.com>
Date: Fri, 15 May 2026 10:36:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] dt-bindings: display: rockchip: analogix-dp: Fix
 hclk as third clock for RK3588
To: Krzysztof Kozlowski <krzk@kernel.org>
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
References: <20260513074414.2053435-1-damon.ding@rock-chips.com>
 <20260513074414.2053435-2-damon.ding@rock-chips.com>
 <20260514-elegant-agate-pug-449ec2@quoll>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260514-elegant-agate-pug-449ec2@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e297e20f403a3kunmc0deb7cd11afb4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkgfVkMfShlLT0kdS0lKTFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=LqrIEfZA+38ljtZG4tF5/WXxztcTnpzY/0OJHfmpE6+LRkFfaUBXdEd9wAWhiPI+0kT6NObp8PeeC962DlhXclUpfPS8fboSaz+TH7sCUqcyub0csGGdW0gd7744Ue1MZAg6ad/M3haGgxeWshyXu7maKjiAb/B0UcwE2TAEa+k=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=U0zZkFsIJMlo+SmTsm1vbbfTBR0506CjYpUXxe4Vvng=;
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

Hi Krzysztof,

On 5/14/2026 6:03 PM, Krzysztof Kozlowski wrote:
> On Wed, May 13, 2026 at 03:44:05PM +0800, Damon Ding wrote:
>> RK3588 eDP controller requires HCLK_VO1 (video output bus clock)
>> to access the VO1 GRF registers and enable the video datapath.
> 
> To access GRF? Then it is the same clock input.

Not the same as RK3399 case.
(The same as the descriptions in [0])

RK3588 hclk_vo1 related NOC design:

PD_VO1
    hclk_vo1
      └─ pclk_vo1_root

Then the clock tree design:

hclk_vo1 (200M)
├─ hclk_vo1_niu_en
│    └─ hclk_vo1_niu (200M)
├─ hclk_hdcp1_en
│    └─ hclk_hdcp1 (200M)
├─ hclk_i2s5_8ch_en
│    └─ hclk_i2s5_8ch (200M)
├─ hclk_spdif4_en
│    └─ hclk_spdif4 (200M)
├─ hclk_spdifrx1_en
│    └─ hclk_spdifrx1 (200M)
├─ hclk_i2s9_8ch_en
│    └─ hclk_i2s9_8ch (200M)
└─ hclk_i2s6_8ch_en
       └─ hclk_i2s6_8ch (200M)

pclk_vo1_root (150M)
├─ pclk_edp0_en
│    └─ pclk_edp0 (150M)
├─ pclk_edp1_en
│    └─ pclk_edp1 (150M)
├─ pclk_hdmitx1_en
│    └─ pclk_hdmitx1 (150M)
├─ pclk_vo1grf_en
│    └─ pclk_vo1grf (150M)
├─ pclk_hdcp1_en
│    └─ pclk_hdcp1 (150M)
├─ pclk_hdmitx0_en
│    └─ pclk_hdmitx0 (150M)
└─ pclk_trng1_en
      └─ pclk_trng1 (150M)

On RK3399, the 'grf' clock is only used exclusively for GRF register access.

But on RK3576/RK3588, the 'hclk' (HCLK_VO1) acts as the parent clock for 
pclk_vo1_root in NOC design. Meanwhile pclk_vo1_root is further the 
parent of pclk_vo1grf and pclk_edp0/pclk_edp1 in clock tree. So this 
hclk affects both GRF register access and the overall APB clock domain 
of the eDP controller, which makes it necessary to be listed independently.

> 
> AGAIN (reiterated soooo many times by me): you describe here clock
> input, NOT OUTPUT.
> 

You're absolutely right, thank you for the repeated clarification.

I used "video output bus clock" as a shorthand to refer to HCLK_VO1,
which clocks the entire video output domain including eDP and HDMI
interfaces.

I will rephrase the commit message more precisely in the next version.

>>
>> Previously, the clock was enabled implicitly via the 'rockchip,vo-grf'
>> phandle reference, which allowed the eDP to work without explicitly
>> managing the hclk_vo1 clock. However, this is not safe or explicit.
>>
>> Enforce the correct third clock name on a per-compatible basis to
>> standardize clock requirements per SoC. This makes the clock
>> dependency clear and removes reliance on implicit clock enablement
>> from GRF phandle.
>>
>> Fixes: f855146263b1 ("dt-bindings: display: rockchip: analogix-dp: Add support for RK3588")
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>
>> ---
>>
>> Changes in v4:
>> - Modify the commit msg.
>>
>> Changes in v5:
>> - Enforce the correct third clock name on a per-compatible basis.
>> - Modify the commit msg simultaneously.
>> ---
>>   .../rockchip/rockchip,analogix-dp.yaml        | 37 +++++++++++++++++--
>>   1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> index d99b23b88cc5..8001c1facf98 100644
>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> @@ -23,10 +23,7 @@ properties:
>>   
>>     clock-names:
>>       minItems: 2
>> -    items:
>> -      - const: dp
>> -      - const: pclk
>> -      - const: grf
> 
> What is 'grf' clock in such case?
> 

The 'grf' clock here was specifically for RK3399, which is only used for 
GRF register access.

Moreover, the control logic for the new 'hclk' clock is different from 
'grf' clock:
- The 'grf' clock was gated dynamically before/after GRF register access;
- The 'hclk' needs to be enabled during probe and kept running 
continuously [1].

Best regards,
Damon

[0] 
https://lore.kernel.org/all/c349eaf2-5852-4bb6-9dac-f7240e1c8098@rock-chips.com/
[1] 
https://lore.kernel.org/all/20260513074414.2053435-6-damon.ding@rock-chips.com/

