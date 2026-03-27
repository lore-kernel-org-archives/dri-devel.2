Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6CC10AB83A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 01:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 181C510EC3B;
	Fri, 27 Mar 2026 01:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mJcAZoZ2";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727BE10EC3B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 01:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774573700;
 bh=m2NMsfxVcSr9MtrRU9gQuBS277Ks3jmJeTd5rK2rKtI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mJcAZoZ2atTAaWiF972aIKGMTdFFe1etiP7MWYfwy5KCIC2nmatcJY0LGbkQATO19
 dkc2D5ikQNVLaVUbN81CRCGf3pyLwwyTJ14jlSwwXxtWQ+XZEZWiZH75K5yf7FxzEQ
 /PSDe2seBIpFBpUjqJZrbxYwAxHqg1NsokAMLmYy4Qq09eNDdVzfreGwwkwgTIPclu
 pkIcOH0G+7qPHx3h7K8ItyLfmsGj7gTJU1LIyo+n4tvsaf2X+XIznrewxfTdIVOUXX
 EHXf4VBc0cnlgEQ46Ffx85XL1h8dCjUku76EOIF47IkRgP3ZTtQVz0MbnVDcaQxASh
 vOrScso0GCK8g==
Received: from [192.168.1.90] (unknown [86.123.23.225])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1A9C917E6130;
 Fri, 27 Mar 2026 02:08:20 +0100 (CET)
Message-ID: <3aec8193-22c4-4c87-8068-5a70f4690047@collabora.com>
Date: Fri, 27 Mar 2026 03:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] drm/bridge: synopsys: dw-dp: Unregister AUX
 channel on bridge detach
To: Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260310-drm-rk-fixes-v2-0-645ecfb43f49@collabora.com>
 <20260310-drm-rk-fixes-v2-7-645ecfb43f49@collabora.com>
 <2053748.usQuhbGJ8B@phil>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2053748.usQuhbGJ8B@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello Heiko,

On 3/26/26 9:28 PM, Heiko Stuebner wrote:
> Am Montag, 9. März 2026, 23:44:35 Mitteleuropäische Normalzeit schrieb Cristian Ciocaltea:
>> The DisplayPort AUX channel gets initialized and registered during
>> dw_dp_bind(), but it is never unregistered, which may lead to resource
>> leaks and/or use-after-free:
>>
>> [  224.661371] BUG: KASAN: slab-use-after-free in device_is_dependent+0xe0/0x2b0
>> [  224.662015] Read of size 8 at addr ffff00011aee8550 by task modprobe/658
>> ...
>> [  224.662796]  device_is_dependent+0xe0/0x2b0
>> [  224.662802]  device_is_dependent+0x108/0x2b0
>> [  224.662808]  device_link_add+0x1f8/0x10b0
>> [  224.662813]  devm_of_phy_get_by_index+0x120/0x200
>> [  224.662819]  dw_dp_bind+0x34c/0xb10 [dw_dp]
>> [  224.662830]  dw_dp_rockchip_bind+0x194/0x250 [rockchipdrm]
>> [  224.662864]  component_bind_all+0x3a8/0x720
>> [  224.662869]  rockchip_drm_bind+0x120/0x390 [rockchipdrm]
>> [  224.662899]  try_to_bring_up_aggregate_device+0x76c/0x838
>> [  224.662904]  component_master_add_with_match+0x1f4/0x230
>> [  224.662909]  rockchip_drm_platform_probe+0x420/0x538 [rockchipdrm]
>> [  224.662939]  platform_probe+0xe8/0x168
>> [  224.662945]  really_probe+0x340/0x828
>> [  224.662950]  __driver_probe_device+0x2e0/0x350
>> [  224.662954]  driver_probe_device+0x80/0x140
>> [  224.662959]  __driver_attach+0x398/0x460
>> [  224.662964]  bus_for_each_dev+0xe0/0x198
>> [  224.662968]  driver_attach+0x50/0x68
>> [  224.662972]  bus_add_driver+0x2a0/0x4c0
>> [  224.662977]  driver_register+0x294/0x360
>> [  224.662982]  __platform_driver_register+0x7c/0x98
>> [  224.662987]  rockchip_drm_init+0xc4/0xff8 [rockchipdrm]
>> ...
>>
>> Unregister the AUX adapter on bridge detach.
> 
> that sounds sort of asymmetrical though. drm_bridge_funcs has attach and
> detach callbacks and the component-framework also has bind and unbind
> callbacks.
> 
> This might cause confusion later on I guess, especially as I don't know
> if there could be a bridge attach, after the detach that unregisters the
> aux adapter.
> 
> Looking at the AnalogixDP for example, it does the the register and
> unregister in the bind/unbind callbacks of the core driver.
> 
> So I guess the in my eyes cleaner way would be to introduce a
> dw_dp_unbind() function and put the aux unregister there?
> 
> At least that way, everything would be at the same "level".

You are right.  As a matter of fact exporting the *_unbind() in the library was
my first thought, but for some reason I went with the "auto" approach.

I've just handled this in v3 [1].

Thanks for reviewing and picking the rest of the patches!

Regards,
Cristian

[1] https://lore.kernel.org/all/20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com/

