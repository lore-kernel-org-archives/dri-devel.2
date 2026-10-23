Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BEC606A327
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=SM24z1Mt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF92C10E4C1;
	Fri, 23 Oct 2026 01:11:00 +0000 (UTC)
Received: from mail-m60239.netease.com (mail-m60239.netease.com
 [210.79.60.239])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EA110E4C1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:10:54 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 520edd00c;
 Fri, 23 Oct 2026 09:10:50 +0800 (GMT+08:00)
Message-ID: <7338211c-d354-40a2-a6a3-624472f34611@rock-chips.com>
Date: Fri, 23 Oct 2026 09:10:32 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/rockchip: vop2: Use drm_format_info_min_pitch()
 for plane offsets
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20261022071737.508-1-kernel@airkyi.com>
 <20261022071737.508-2-kernel@airkyi.com> <2024729.6tgchFWduM@diego>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <2024729.6tgchFWduM@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1664f856503a7kunm07c92d492d1190
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQh5KVh9JSUgYTE4aGR9MQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=SM24z1MtDKUdbCHONbq797C3zM0OxGSPuDeKnj0a0orBg9Cnt0r723J3KgLwR9jM7icBaxNI+5FRwFvW7p9XeKJeYyqd8I32L941XvKrOePmyVnulomxv7KudfHyBSKxaPnEYOZVmM++xGXQQ7tLzfTnoEyqEag7Pu7JjpjPRkM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=o9iVjpbRGMBUkX1zQ4j+Bu+fth+Q4PLJuT63aIhz70s=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heiko,

On 10/22/2026 8:59 PM, Heiko Stübner wrote:
> Hi Chaoyi,
> 
> Am Donnerstag, 22. Oktober 2026, 09:17:35 Mitteleuropäische Sommerzeit schrieb Chaoyi Chen:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Use the block aware helper instead of cpp[], the latter aliases
>> char_per_block and is wrong for packed 10-bit formats like NV15,
>> NV20 and NV30.
>>
>> Tested with modetest[0]:
>>
>> ```
>> 	modetest -s 86:3840x2160 -P \
>> 	59@83:3940x2160~96,0,3840,2160+0+0@NV20 -a
>> ```
>>
>> fb size (3940x2160), src at (96, 0) with size (3840x2160),
>> dst at (0, 0) with size (3840x2160)
>>
>> [0]: https://github.com/windowsair/libdrm/tree/src-pos-support
>>
>> Assisted-by: LLM
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>> index 4cce3e336f5b..480aa8c8a8d2 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>> @@ -1290,7 +1290,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
>>  
>>  	afbc_en = drm_is_afbc(fb->modifier);
>>  
>> -	offset = (src->x1 >> 16) * fb->format->cpp[0];
>> +	offset = drm_format_info_min_pitch(fb->format, 0, src->x1 >> 16);
>>  
>>  	/*
>>  	 * AFBC HDR_PTR must set to the zero offset of the framebuffer.
>> @@ -1309,6 +1309,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
>>  		int hsub = fb->format->hsub;
>>  		int vsub = fb->format->vsub;
>>  
>> +		offset = drm_format_info_min_pitch(fb->format, 1, src->x1 >> 16) / hsub;
>>  		offset = (src->x1 >> 16) * fb->format->cpp[1] / hsub;
> 
> missing removal of the replaced line?
> 

Oh, it is. Will fix in v2.

> 
> Heiko
> 
>>  		offset += (src->y1 >> 16) * fb->pitches[1] / vsub;
>>  
>>
> 

-- 
Best, 
Chaoyi

