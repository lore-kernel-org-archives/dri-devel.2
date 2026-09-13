Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44632C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AFF710E04C;
	Sun, 13 Sep 2026 06:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GAJ5dMwy";
	dkim-atps=neutral
Received: from mail-m9395.xmail.ntesmail.com (mail-m9395.xmail.ntesmail.com
 [103.126.93.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 350E910E04C
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 06:17:11 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4d8d80e68;
 Sun, 13 Sep 2026 14:17:08 +0800 (GMT+08:00)
Message-ID: <5f5a3210-44e1-4d56-ab44-aea2fe3cabae@rock-chips.com>
Date: Sun, 13 Sep 2026 14:17:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/rockchip: dsi: Add maximum per lane bit rate
 calculation
To: Heiko Stuebner <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chaoyi Chen <kernel@airkyi.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260812073002.328-1-kernel@airkyi.com>
 <20260812073002.328-2-kernel@airkyi.com> <9674763.CDJkKcVGEf@phil>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <9674763.CDJkKcVGEf@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09969941d03a7kunm769b3eaa96f912
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEsfVhlCTUkZSh4dH05LGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=GAJ5dMwy21VmCnJabb1L9TQt7b2IDU9Uq/uVBCd3W1ZJPdjMZOkOHgn5LiqAgg3GA0pHy4C3q4EUx4G7Hz1skBBdZLC9AW8rueILzdxDsEfhB5+YqQqTqewhPSW77CuWLWUJinCQ0Gmq7MLqHcATbjzdyKYT8nT+8AEEL8AngmA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=XE0FAIY1dIyIhNWdzfvXZWvPYm623Zb2EGWRdg2QQio=;
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

Hi Heiko,

On 9/12/2026 8:32 PM, Heiko Stuebner wrote:
> Am Mittwoch, 12. August 2026, 09:30:00 Mitteleuropäische Sommerzeit schrieb Chaoyi Chen:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Different chips have varying support for the maximum bit rate per lane.
>>
>> Add calculation for the maximum per lane bit rate for various chip
>> platforms.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> [...]
> 
>> @@ -573,6 +574,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
>>  	unsigned long _fbdiv, best_fbdiv;
>>  	unsigned long min_delta = ULONG_MAX;
>>  
>> +	max_mbps = dsi->cdata->max_bit_rate_per_lane / USEC_PER_SEC;
> 
> As the value is called max_bit_rate_per_lane, I guess Sashiko
> is correct in that the max_mbps check should use "<=" ?
> 

Thanks for pointing this out. I'll fix it in v5.

> 
> Heiko

-- 
Best, 
Chaoyi

