Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5ECCD5BAF
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 01:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C78510E641;
	Fri, 22 May 2026 01:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LjJGTHD+";
	dkim-atps=neutral
Received: from mail-m8353.xmail.ntesmail.com (mail-m8353.xmail.ntesmail.com
 [156.224.83.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A9310E641
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 01:32:35 +0000 (UTC)
Received: from [172.16.12.43] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3f600a29b;
 Fri, 22 May 2026 09:32:31 +0800 (GMT+08:00)
Message-ID: <e83c4a67-60a0-4615-bc42-3cff413cc363@rock-chips.com>
Date: Fri, 22 May 2026 09:32:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: display: bridge: analogix-dp: Add
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
References: <20260521114459.1394264-1-damon.ding@rock-chips.com>
 <20260521114459.1394264-2-damon.ding@rock-chips.com>
 <20260521-modify-quadrant-8d6a2e36727c@spud>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260521-modify-quadrant-8d6a2e36727c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e4d500a3f03a3kunm9d959ffda60d9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEpDVkNNSRlJTUpDTBlJQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=LjJGTHD+borVrf6IPisbcVU/0kqdtEBiYenWZSDe0S4oyajEECA/VhRUivwJcJ27yf2MrRYNA3peUuTU3+wmUnwM6zJXlyyrV7ZRvLPdZnabyiiP1pflX5J68K2agkh1nszxyYnkPLOlg0d//0dm6KZZXu4hE63j8IKrsaNwgVc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=7hndMH6djPqpqegY7jWQ0hx8/ee+d87YE9b4lTZzGfs=;
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

On 5/22/2026 3:50 AM, Conor Dooley wrote:
> On Thu, May 21, 2026 at 07:44:57PM +0800, Damon Ding wrote:
>> Add data-lanes property support to the port@1 endpoint for physical
>> lane mapping configuration.
>>
>> Lane mapping is mainly used for below scenarios:
>> 1. Correct PCB lane swap and differential line routing crossover
>>     without hardware changes;
>> 2. Adapt mismatched lane pin definitions between SoC and eDP panel;
>> 3. Support multiple panel hardware variants on the same board
>>     by configuring data-lanes in device tree only.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> Sashiko complaint here looks valid.
> pw-bot: changes-requested
> 

Yes, unevaluatedProperties: false should be added to both the port@1
and endpoint nodes.

Will fix in v3.

Best regards,
Damon

> 
>>
>> ---
>>
>> Changes in v2:
>> - Add lane mapping application scenarios in commit message.
>> - Remove redundant deprecated property 'data-lanes' for eDP node.
>> - Update port@1 $ref to /schemas/graph.yaml#/$defs/port-base.
>> ---
>>   .../bindings/display/bridge/analogix,dp.yaml    | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
>> index 62f0521b0924..e34fdb21adb4 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
>> @@ -42,13 +42,20 @@ properties:
>>       properties:
>>         port@0:
>>           $ref: /schemas/graph.yaml#/properties/port
>> -        description:
>> -          Input node to receive pixel data.
>> +        description: Input node to receive pixel data.
>>   
>>         port@1:
>> -        $ref: /schemas/graph.yaml#/properties/port
>> -        description:
>> -          Port node with one endpoint connected to a dp-connector node.
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>> +        description: Port node with one endpoint connected to sink device node.
>> +        properties:
>> +          endpoint:
>> +            $ref: /schemas/media/video-interfaces.yaml#
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

