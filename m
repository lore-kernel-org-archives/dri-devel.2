Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75573CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06A51132BB;
	Mon,  1 Jun 2026 12:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KegN8No0";
	dkim-atps=neutral
Received: from mail-m24125.xmail.ntesmail.com (mail-m24125.xmail.ntesmail.com
 [45.195.24.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABF21132BB
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:24:46 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 409a07d3d;
 Mon, 1 Jun 2026 20:24:42 +0800 (GMT+08:00)
Message-ID: <ba122231-0def-4b62-add7-be3382f07805@rock-chips.com>
Date: Mon, 1 Jun 2026 20:24:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/bridge: analogix_dp: Add validation for
 samsung,lane-count property
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org,
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260529040530.741336-1-damon.ding@rock-chips.com>
 <20260529040530.741336-3-damon.ding@rock-chips.com>
 <178014803941.21632.16225608049285101452.b4-review@b4>
 <DIW1WGLL0GW5.1BGU194UXN0HO@bootlin.com>
 <17160115-6c30-434b-9dab-b768110cd8d6@rock-chips.com>
 <178031536852.7135.7751258958371598959.b4-reply@b4>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <178031536852.7135.7751258958371598959.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e8324b9ba03a8kunme45a265c281ad8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQxlDVk5KTh5NTEhKHh5JSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=KegN8No0Ul0g1aqkwFnVCU6MRRiskVQe+WisAx9eAMChEDDT3viYwbhU1XN65LT9ebEvkJOWvihiZci7HRQHo4FUp/8Sn1l+ubqE9gxZ4o8l8cp7xNKXSy8DxHomGPyqLdKVrAMfk0NLXDEi4PZuKElRlVOH2HSQQ8eEjwwsqbw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=o8OCB2l+ncUQMl80H2dawRBtZl8BrvrP7FFvN2SV8qM=;
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

On 6/1/2026 8:02 PM, Luca Ceresoli wrote:
> Hello Damon,
> 
> On 2026-06-01 10:59:27+08:00, Damon Ding wrote:
>> Hi Luca,
>>
>> On 5/30/2026 9:38 PM, Luca Ceresoli wrote:
>>
>>> On Sat May 30, 2026 at 3:33 PM CEST, Luca Ceresoli wrote:
>>>
>>> Meh, messed up with 'b4 review' :-/ Apologies
>>>
>>> "This sashiko report" [0] was about an enum being signed, so '== 0' could miss
>>> negative numbers coming from bogus DT values higher than 1^31.
>>
>> Ah, I agree. It would be better to add a new inline function to validate
>> that the lane count passed from DT is exactly 1, 2, or 4, just as
>> Sashiko suggested.
>>
>>>>
>>>
>>> And this was about "Additionally, does this check inadvertently allow 3,
>>> which is an invalid DisplayPort lane count?"
>>
>> Yes, the DisplayPort specification only allows lane counts of 1, 2, or
>> 4. I did miss the check for the invalid value 3 in the current code.
>>
>> (BTW: I did not find a common helper function in drm_dp_helper.h to
>> validate valid DP lane counts (1, 2, 4). I'm not sure if it would be
>> better to add a generic lane count validation function to the DP helper
>> library instead, to avoid duplicating the same functionality across
>> individual DP drivers. Perhaps other DP experts could provide some
>> advice on this.)
> 
> A bool function in common code, to be reused by all DP drivers, would be
> good.
> 
> 
> 

Yes, will do in v5.

Best regards,
Damon

