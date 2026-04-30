Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C48FF887E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 01:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3EFF10E41D;
	Thu, 30 Apr 2026 01:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GbDbuhn0";
	dkim-atps=neutral
Received: from mail-m15598.qiye.163.com (mail-m15598.qiye.163.com
 [101.71.155.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9086C10E41D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 01:08:08 +0000 (UTC)
Received: from [172.16.12.43] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3cafb48fb;
 Thu, 30 Apr 2026 09:08:03 +0800 (GMT+08:00)
Message-ID: <fecd104d-4d2c-434e-92c9-21a1dcbb51d4@rock-chips.com>
Date: Thu, 30 Apr 2026 09:08:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: analogix_dp: Extract error pointer from
 correct variable
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Ethan Tidmore <ethantidmore06@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260429030840.704252-1-ethantidmore06@gmail.com>
 <DI5LR1VCMTKO.1S3KLBK8F0XIA@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <DI5LR1VCMTKO.1S3KLBK8F0XIA@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ddbedb9ef03a3kunmbfbb39632c0b60
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHh5CVhodHxlOQ0JKHktNSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=GbDbuhn0jQDxlJSu2mhpHwzx71nLdQgQge75Z98LRAhbPvHQaiy4pxxG7quDY+hz3/YbLsfVw5vEBRS1nfiZJMAxCohDJuQm3SvkkcE0jNmtWWxWWJMjWhQjje1uv+rgQ73hz1iKEZ4c7/2pPXkSXQBhmPSCIlKxJp0P1X3xwIs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=lpf5O8qCZWH+FGNd1blfGI8dHfhCkG/CEfI2wLTwELE=;
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

On 4/29/2026 7:29 PM, Luca Ceresoli wrote:
> On Wed Apr 29, 2026 at 5:08 AM CEST, Ethan Tidmore wrote:
>> In devm_drm_panel_bridge_add() error path the pointer error should be
>> extracted from dp->plat_data->next_bridge but instead it is extracted
>> from bridge, which is a valid pointer and not part of this error path.
>>
>> Extract error pointer from correct variable.
>>
>> Detected by Smatch:
>> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1489 analogix_dp_bind()
>> warn: passing a valid pointer to 'PTR_ERR'
>>
>> Fixes: 1b86a69b61df4 ("drm/bridge: analogix_dp: Apply panel_bridge helper")
>> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> 

Reviewed-by: Damon Ding <damon.ding@rock-chips.com>

Best regards,
Damon

