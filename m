Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFAECD5BAF
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 01:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A7C10E62A;
	Fri, 22 May 2026 01:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GnvlT/xB";
	dkim-atps=neutral
Received: from mail-m82213647.xmail.ntesmail.com
 (mail-m82213647.xmail.ntesmail.com [8.221.36.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB69010E62A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 01:25:14 +0000 (UTC)
Received: from [172.16.12.43] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3f5fceca6;
 Fri, 22 May 2026 09:25:09 +0800 (GMT+08:00)
Message-ID: <959f90d0-a97e-41f2-b39c-97465e906700@rock-chips.com>
Date: Fri, 22 May 2026 09:25:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: rockchip: analogix-dp: Add data-lanes
 example
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
 <20260521114459.1394264-3-damon.ding@rock-chips.com>
 <20260521-powdery-tux-22a7cf4fadc3@spud>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260521-powdery-tux-22a7cf4fadc3@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e4d494c0303a3kunm0428e0bca4f9b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQxpIVk8dSB1DS0NJTxlDGFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=GnvlT/xBYOdkN9DU1iEt20bXPIo8qdooBfyzFMQY8127vD1w+oeiXdZNszI+FwxKWmNnMLyy7YaSJS+FA/2UIC2njnzt66dgeKAwTfsgzkSJk1Acbr0R4GM9yO6HuaKAHwmCWEYBDEatI0Y/F/Ah0M8H19iQqc4vGHhmxJI0Vl8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=or1x9VMxHGuaR+KEDTWJh5vt8U96cHrmYFhV8rlbjwo=;
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

On 5/22/2026 3:47 AM, Conor Dooley wrote:
> On Thu, May 21, 2026 at 07:44:58PM +0800, Damon Ding wrote:
>> Add data-lanes setting in endpoint example to show actual lane mapping
>> usage.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> Squash this with patch 1.
> pw-bot: changes-requested
> 

Yes, will fix in v3

Best regards,
Damon

> 
>> ---
>>   .../bindings/display/rockchip/rockchip,analogix-dp.yaml          | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> index bb75d898a5c5..cf75c926318b 100644
>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> @@ -151,6 +151,7 @@ examples:
>>             reg = <1>;
>>   
>>             edp_out_panel: endpoint {
>> +            data-lanes = <0 1>;
>>               remote-endpoint = <&panel_in_edp>;
>>             };
>>           };
>> -- 
>> 2.34.1
>>

