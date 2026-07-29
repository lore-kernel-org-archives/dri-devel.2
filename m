Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEED8C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 01:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EE110E36C;
	Wed, 29 Jul 2026 01:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="euk3LVDo";
	dkim-atps=neutral
Received: from mail-m60247.netease.com (mail-m60247.netease.com
 [210.79.60.247])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CAF10E36C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 01:34:50 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 47f0092e5;
 Wed, 29 Jul 2026 09:34:46 +0800 (GMT+08:00)
Message-ID: <e4b1051c-fc91-44a7-ab29-1da888fcc0c2@rock-chips.com>
Date: Wed, 29 Jul 2026 09:34:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] This series is split from the v15 "Add Type-C DP
 support for RK3399 EVB
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Vinod Koul <vkoul@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
References: <20260727064408.101-1-kernel@airkyi.com> <amgMXujurBrB5B0L@venus>
 <e22072d9-7fee-4f83-9ae9-5428e45c7507@rock-chips.com>
 <amh1sK_4KnD5zTlZ@venus>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <amh1sK_4KnD5zTlZ@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9fab82895203a7kunm36abcb353ae33c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHR0aVh1NT0xNSU0dS0hKSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=euk3LVDokfDwuFpxIXJN4jzuLkRvCtZqL8jRDZoAMRvU+JjIgJ35lxzKyNXNiyGRtGCK9NBFxvWfNY3AwjI7dfY2R/DKuVwUmhyZKQT6VIaXik4yqyNkfEz9392PYWmVGRCtPRe5Cchs2S75m7iquG3+ruNflhaXQLxwkVZbv1o=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=R4MBbntBTw+WzVk7B5pQ1YM1qPjQxWB0im3ZJJbI4sU=;
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

Hi Sebastian,

On 7/28/2026 6:44 PM, Sebastian Reichel wrote:
> Hello Chaoyi,
> 
> On Tue, Jul 28, 2026 at 10:33:48AM +0800, Chaoyi Chen wrote:
>>>> Changes in v4:
>>>> - Link to v3: https://lore.kernel.org/all/20260717072323.96-1-kernel@airkyi.com/
>>>> - Scan the entire typec_bus and attempt to register the hpd bridge,
>>>>   so as not to miss devices that were already added during initialization.
>>>
>>> While that may help with the module being loaded late, it does not
>>> help with triggering the module load in the first place.
>>>
>>> The module does not have any MODULE_DEVICE_TABLE() helping with
>>> that. So basically any system relying on the automatic hpd bridge
>>> registration and using a modular kernel (e.g. the arm64 defconfig or
>>> the kernels usually provided by Linux distributions) requires
>>> manually loading that module to get any graphical output.
>>>
>>
>> Thank you for pointing this out. I will add it in v5.
> 
> Add what exactly? As this code is quite generic, you don't have
> anything for a MODULE_DEVICE_TABLE() (i.e. no OF, no I2C, ...).
> 

That is:

static const struct typec_device_id dp_typec_id[] = {
	{ USB_TYPEC_DP_SID },
	{ },
};
MODULE_DEVICE_TABLE(typec, dp_typec_id);

Just like the modules in drivers/usb/typec/altmodes/ .

> One solution I see to keep the notifier design would be to add
> 
> MODULE_SOFTDEP("pre: aux-hpd-typec-dp-bridge")
> 
> to some other module and piggy-back on it. Alternatively integrate
> it directly to some other module, such as "drm_display_helper",
> which already has DRM_DISPLAY_DP_HELPER and DRM_DISPLAY_DP_TUNNEL.
> Adding TypeC DP AltMode as part of it seems sensible to me.
>

I agree, placing it on the DRM side looks more reasonable.

> FWIW I suggest you test booting your patches work with the arm64
> defconfig before your next submission ;)
>

Oh, I will. It's just that I've always been using buildroot. I'll check 
the situation with other distributions.


> Greetings,
> 
> -- Sebastian

-- 
Best, 
Chaoyi
