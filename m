Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA6ACD37AC
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 02:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9C110E02B;
	Fri, 15 May 2026 02:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bNuiS2Dr";
	dkim-atps=neutral
Received: from mail-m19731103.qiye.163.com (mail-m19731103.qiye.163.com
 [220.197.31.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69CD10E02B
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:53:41 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3e805fe57;
 Fri, 15 May 2026 10:53:37 +0800 (GMT+08:00)
Message-ID: <f9fd086e-9d9f-40a3-9393-7cfa5c426c66@rock-chips.com>
Date: Fri, 15 May 2026 10:53:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] dt-bindings: display: bridge: analogix-dp: Add
 data-lanes support for endpoint
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
 <20260514070133.2275069-3-damon.ding@rock-chips.com>
 <20260514-jolly-confining-997882e502c7@spud>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260514-jolly-confining-997882e502c7@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e298dc37203a3kunm6bd5d8e111d35b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGhofSVZPShpPHUtKTB
 pLTEtWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSEpKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=bNuiS2Dre4Q5BTbn3B1+0fBx2UlyKHcHIU2sndZ4rhJCriwHPmLgl2XgQ0+5OezFxNij6gzxyCaFuJ9XbQD19js2/mtL18ORxirq3opoRFCafpHIl1GwXZuzlWA27nAx7xFTpabrXENpRkIAGv0cmL/NRF6OFA+Vs0hUey4n0NI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=wiOcpYgO5JDj+FjoQaOM0eym/Auz/dWfyTv2lzex6Rs=;
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

On 5/15/2026 2:19 AM, Conor Dooley wrote:
> On Thu, May 14, 2026 at 03:01:32PM +0800, Damon Ding wrote:
>> Add data-lanes property support to the port@1 endpoint for physical
>> lane mapping configuration.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
>>   .../bindings/display/bridge/analogix,dp.yaml  | 24 +++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
>> index 62f0521b0924..a82f9b7776c0 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
>> @@ -36,19 +36,35 @@ properties:
>>         Hotplug detect GPIO.
>>         Indicates which GPIO should be used for hotplug detection
>>   
>> +  data-lanes:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    deprecated: true
> 
> Why are you adding a new property as deprecated? Why does this duplicate
> what you're adding to the port node? At the very least, your commit is
> lacking an explanation.
> pw-bot: changes-requested
> 

Thank you for the review.

I referenced the implementation in 
Documentation/devicetree/bindings/display/msm/dp-controller.yaml. After 
evaluating QCOM DP driver and other drivers, I agree that implementing 
'data-lanes' in the endpoint node is the preferred and common approach 
nowadays.

The top-level `data-lanes` property together with the `deprecated` mark 
was leftover content from my early reference and arrangement, which I 
neglected to delete before submitting. It is redundant, unreasonable and 
should not have been added at all.

I will fix it in the next version.

Best regards,
Damon

> 
>> +    minItems: 1
>> +    maxItems: 4
>> +    items:
>> +      maximum: 3
>> +
>>     ports:
>>       $ref: /schemas/graph.yaml#/properties/ports
>>   
>>       properties:
>>         port@0:
>>           $ref: /schemas/graph.yaml#/properties/port
>> -        description:
>> -          Input node to receive pixel data.
>> +        description: Input node to receive pixel data.
>>   
>>         port@1:
>>           $ref: /schemas/graph.yaml#/properties/port
>> -        description:
>> -          Port node with one endpoint connected to a dp-connector node.
>> +        description: Port node with one endpoint connected to sink device node.
>> +        properties:
>> +          endpoint:
>> +            $ref: /schemas/media/video-interfaces.yaml#
>> +            unevaluatedProperties: false
>> +            properties:
>> +              data-lanes:
>> +                minItems: 1
>> +                maxItems: 4
>> +                items:
>> +                  enum: [ 0, 1, 2, 3 ]
>>   
>>       required:
>>         - port@0
>> -- 
>> 2.34.1
>>

