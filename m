Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C627DC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3B010E57F;
	Thu, 23 Jul 2026 09:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="h3U2hpK6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC81510E57D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784797972;
 bh=NEmV2fqvR/cLJUCeISN7mSdpl+4odir3BIdW8hvoBrI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h3U2hpK6Vq/y18j2Z7pwLk5QmUsUccohgcjBkxw/kU/h0qX1QPgLGv4oZSIQqFZ1D
 Y//0Qz4e3IkZYS/7JZLaitvt8JBEpCPVK0icmtYBCGjr4x8SrsN9BCmefDN4p8vRC4
 Mkr+mafYgJv9P/+vc1qLayZ56jFRW7P+KYiA4eozVIVj7B6R8UzOiOOqnMhbQIYAOv
 WNQNPt/DQE/CA6dXVk3uFtC67UhwsOixY9QhfNdKLxLsHfiwyqqQeRztlfqU7IpbZi
 LF6US/IlmDwrfR0Hfy8S3kwoRwH2yFmHyvNb7RBm3/XsBc03DO+SWacrCeoZrxNT8Y
 LiWeMlPEJRLVg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6E5CE17E0018;
 Thu, 23 Jul 2026 11:12:51 +0200 (CEST)
Message-ID: <297c6368-5ca3-456b-8e6c-bc8cd5cf48cb@collabora.com>
Date: Thu, 23 Jul 2026 12:12:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 46/61] drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4
 capabilities
To: Diederik de Haas <diederik@cknow-tech.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Algea Cao <algea.cao@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Liu Ying <victor.liu@nxp.com>, Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-46-4fb12ea22ac9@collabora.com>
 <DK5TUJBKSK19.ZXEOSCVMTN6T@cknow-tech.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <DK5TUJBKSK19.ZXEOSCVMTN6T@cknow-tech.com>
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

Hi Diederik,

On 7/23/26 12:02 PM, Diederik de Haas wrote:
> Hi Cristian,
> 
> On Thu Jul 23, 2026 at 3:35 AM CEST, Cristian Ciocaltea wrote:
>> Bridges using DRM_BRIDGE_OP_HDMI are now expected to also provide a
>> supported HDMI version.  This is not yet enforced, but will become
>> mandatory once the migration to the new caps-based HDMI connector
>> initialization API is completed.
>>
>> The RK3066 HDMI TX supports HDMI 1.4a, as described in commit
>> f84d3d37b7fb ("drm: rockchip: introduce rk3066 hdmi").  However, the
>> driver does not currently enforce a maximum TMDS character rate, it only
>> filters non-CEA modes and excludes VIC 1 (640x480) via the .mode_valid
>> callback.
>>
>> Advertise HDMI 1.4 support for now so that modes exceeding the 340 MHz
>> TMDS limit are rejected by the core.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/rockchip/rk3066_hdmi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
>> index f28d6a883e09..c080abe676c4 100644
>> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
>> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
>> @@ -14,6 +14,7 @@
>>  #include <drm/drm_probe_helper.h>
>>  
>>  #include <linux/clk.h>
>> +#include <linux/hdmi.h>
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/regmap.h>
>> @@ -712,6 +713,7 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
>>  	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>>  	hdmi->bridge.vendor = "Rockchip";
>>  	hdmi->bridge.product = "RK3066 HDMI";
>> +	hdmi->bridge.supported_hdmi_ver = HDMI_VERSION_1_3;
> 
> Is this correct or should this be HDMI_VERSION_1_4 ?
> In the other 'Advertise HDMI N.M capabilities' patches, there is a (direct)
> match between the version mention in the commit summary and the
> supported_hdmi_ver property, but not here.

This is indeed a mismatch between the commit description and the actual code
changes.  It has no functional impact, as HDMI 1.3 and HDMI 1.4 are equivalent
in terms of the maximum supported TMDS character rate, which is what we
currently infer.

I'll set it to HDMI_VERSION_1_4 in the next revision.

Thanks,
Cristian
