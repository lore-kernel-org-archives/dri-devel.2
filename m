Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4467210AB807
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CA510E034;
	Thu, 26 Mar 2026 19:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="NmXGA9yd";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E18F10E034
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 19:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=P8q1b7BVCr0bxZwKjgU8Z7Ivc8vxFh7zx0HI/IRg014=; b=NmXGA9ydxp031MJXvgcF0ptzp7
 XnxCZcHUteZX1hWuh3E/f7+WPpkpdHYHTGAs0t3XHOIesKna/h1MQCEtpDxqq5Aeu64B6rF4zPCHe
 3Jief1YqMvdmf1FSJR7SQZO4vnkflxKLX7b01HSqpmpZXuLZoaT94whOqHimtZQVK0MBKyr/I4ihV
 ed39NYWtlj7ywDMsyZPY58FuQ30fqgI+tCaujN3rw6lCsPbaKVpYzAFIbLxGbY6A8H0U/y9Z5fkpj
 zsHWtwTIhTh2pXZZKcSLlS1xp3b6/DVvcNUfYfxAzMuD7QTCOxCrTUDiaXoco6w/oEPu6I2EghD0D
 4cpvgQ4A==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] drm/bridge: synopsys: dw-dp: Unregister AUX
 channel on bridge detach
Date: Thu, 26 Mar 2026 20:28:02 +0100
Message-ID: <2053748.usQuhbGJ8B@phil>
In-Reply-To: <20260310-drm-rk-fixes-v2-7-645ecfb43f49@collabora.com>
References: <20260310-drm-rk-fixes-v2-0-645ecfb43f49@collabora.com>
 <20260310-drm-rk-fixes-v2-7-645ecfb43f49@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Montag, 9. M=C3=A4rz 2026, 23:44:35 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Cristian Ciocaltea:
> The DisplayPort AUX channel gets initialized and registered during
> dw_dp_bind(), but it is never unregistered, which may lead to resource
> leaks and/or use-after-free:
>=20
> [  224.661371] BUG: KASAN: slab-use-after-free in device_is_dependent+0xe=
0/0x2b0
> [  224.662015] Read of size 8 at addr ffff00011aee8550 by task modprobe/6=
58
> ...
> [  224.662796]  device_is_dependent+0xe0/0x2b0
> [  224.662802]  device_is_dependent+0x108/0x2b0
> [  224.662808]  device_link_add+0x1f8/0x10b0
> [  224.662813]  devm_of_phy_get_by_index+0x120/0x200
> [  224.662819]  dw_dp_bind+0x34c/0xb10 [dw_dp]
> [  224.662830]  dw_dp_rockchip_bind+0x194/0x250 [rockchipdrm]
> [  224.662864]  component_bind_all+0x3a8/0x720
> [  224.662869]  rockchip_drm_bind+0x120/0x390 [rockchipdrm]
> [  224.662899]  try_to_bring_up_aggregate_device+0x76c/0x838
> [  224.662904]  component_master_add_with_match+0x1f4/0x230
> [  224.662909]  rockchip_drm_platform_probe+0x420/0x538 [rockchipdrm]
> [  224.662939]  platform_probe+0xe8/0x168
> [  224.662945]  really_probe+0x340/0x828
> [  224.662950]  __driver_probe_device+0x2e0/0x350
> [  224.662954]  driver_probe_device+0x80/0x140
> [  224.662959]  __driver_attach+0x398/0x460
> [  224.662964]  bus_for_each_dev+0xe0/0x198
> [  224.662968]  driver_attach+0x50/0x68
> [  224.662972]  bus_add_driver+0x2a0/0x4c0
> [  224.662977]  driver_register+0x294/0x360
> [  224.662982]  __platform_driver_register+0x7c/0x98
> [  224.662987]  rockchip_drm_init+0xc4/0xff8 [rockchipdrm]
> ...
>=20
> Unregister the AUX adapter on bridge detach.

that sounds sort of asymmetrical though. drm_bridge_funcs has attach and
detach callbacks and the component-framework also has bind and unbind
callbacks.

This might cause confusion later on I guess, especially as I don't know
if there could be a bridge attach, after the detach that unregisters the
aux adapter.

Looking at the AnalogixDP for example, it does the the register and
unregister in the bind/unbind callbacks of the core driver.

So I guess the in my eyes cleaner way would be to introduce a
dw_dp_unbind() function and put the aux unregister there?

At least that way, everything would be at the same "level".


Heiko


