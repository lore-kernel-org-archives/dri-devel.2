Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF395FEA806
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 236B410E70F;
	Wed, 25 Mar 2026 03:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SlF09ECw";
	dkim-atps=neutral
Received: from mail-m49202.qiye.163.com (mail-m49202.qiye.163.com
 [45.254.49.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A03B10E70F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:58:27 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 38331aadd;
 Wed, 25 Mar 2026 11:58:22 +0800 (GMT+08:00)
Message-ID: <70204014-a416-466d-a960-67c86f20f08d@rock-chips.com>
Date: Wed, 25 Mar 2026 11:58:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] drm/bridge: analogix_dp: Rename and simplify
 is_rockchip()
From: Damon Ding <damon.ding@rock-chips.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, hjc@rock-chips.com,
 heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 alchark@gmail.com, cristian.ciocaltea@collabora.com,
 sebastian.reichel@collabora.com, kever.yang@rock-chips.com,
 heiko.stuebner@cherry.de, tomeu@tomeuvizoso.net, amadeus@jmu.edu.cn,
 michael.riesch@collabora.com, didi.debian@cknow.org,
 dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org,
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260319104031.1986946-1-damon.ding@rock-chips.com>
 <20260319104031.1986946-8-damon.ding@rock-chips.com>
 <DHAANFJ6QZKU.5NN7RD47T8TI@bootlin.com>
 <42c0641f-2e37-4ca4-a1ae-e8fde24c8460@rock-chips.com>
Content-Language: en-US
In-Reply-To: <42c0641f-2e37-4ca4-a1ae-e8fde24c8460@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9d2324b76103a3kunmff336bad6b84fe
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ08dTVZMQkJIQ0JOSEIfHRpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=SlF09ECwAohg5Ap+e76ztcvHcMcCup89QUrjufKePOJMVvefgml6iKa8StxI/kX+kdAVs/xzZyPLhe7ih/XAuku/tgibOsQdwu7Gcn/R/rxdWwNJ4Yu5bRB+zkUinUHmn4St1NlijSJtrKPo7wwjYsyCyh22HHDrUiqlZIHUmpE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=9ZTEjmc2Lf7EnWXiGxkpS1MSw/+9KNGdTV6DrlGgK6I=;
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

Hi Luca,

On 3/24/2026 2:12 PM, Damon Ding wrote:
> On 3/24/2026 12:14 AM, Luca Ceresoli wrote:
>> On Thu Mar 19, 2026 at 11:40 AM CET, Damon Ding wrote:
>>> Rename is_rockchip() to analogix_dp_is_rockchip() for naming consistency
>>> and readability, and simplify the code with switch.
>>>
>>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>> Suggested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>>
>> The patch content is OK:
>> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>
>> However this won't apply without [0], correct?
>>
>> So, worth mentioning in the cover letter that this series depends on the
>> [0] series.
>>
>> [0] https://lore.kernel.org/all/20260319071452.1961274-8- 
>> damon.ding@rock-chips.com/
>>
> 
> Yes, I will add it in v3.
> 

BTW: Could you also help review the following two patches [0][1] when 
you get a chance? Your review would be much appreciated.

[0] 
https://lore.kernel.org/all/20251110085823.1197472-1-damon.ding@rock-chips.com/
[1] 
https://lore.kernel.org/all/20251111022103.1350183-1-damon.ding@rock-chips.com/

Best regards,
Damon

