Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E1CCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1929110EAE8;
	Fri, 12 Jun 2026 17:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Prx1/PYH";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 883F010EAE8
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781286003;
 bh=XnsAVp/N05Bd286sY4AZGdYjANXS96ZvH0it40jhlpc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Prx1/PYH35axjUWlaKAj58+qPlDJxPz2Syb01q+23nOylMbl0JoWQ++KWFCER7kwo
 ik5tWwOsAC5+rfZHlxGz/mEH2oWDA+PcrHt7KoThJi5kTFbpvYoMgsw3odq4EgvVyM
 TYv0FqL3CDgdAmNfvYg9wC4Gl9OX3rkVx46iZU9cGOSrrIKOvonymjRw2j83SD+M19
 TsLtWxxc68vkuJEdTUR48BdNWOBDKwFfYWO/oZienr1yTbop/+IprMYIVbXVZ+Ovuv
 DcWClwpEU9sZlXLNSiPVN4NK1s+eMZ1PjFtp3by4xi/wTjAzfwnVaZM5UG/xvLHWT7
 2zsMYU5CkrAIQ==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 41E7017E040C;
 Fri, 12 Jun 2026 19:40:02 +0200 (CEST)
Message-ID: <be231e53-3c4c-424d-bc62-4d3a0007af64@collabora.com>
Date: Fri, 12 Jun 2026 20:40:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/30] drm/fb-helper: Remove unused local variable in
 hotplug_event()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-1-445eb54ee1ed@collabora.com>
 <c7866bc4-bf37-4f8c-ae64-2d1d3a23f1ef@suse.de>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <c7866bc4-bf37-4f8c-ae64-2d1d3a23f1ef@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Thomas,

On 6/12/26 4:46 PM, Thomas Zimmermann wrote:
> 
> 
> Am 02.06.26 um 00:44 schrieb Cristian Ciocaltea:
>> Remove the 'err' local variable in drm_fb_helper_hotplug_event() which
>> only stores a return value that is never used beyond the immediate
>> return statement.  This simplifies the code without behavior changes.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> But why is this patch hidden in this series? It has nothing to do with HDMI support.

I came across this while investigating some issues with the HPD-related changes
in the series (was part of the call path). 

Should I send the patch separately, or can it be picked up directly?

Thanks for reviewing,
Cristian
