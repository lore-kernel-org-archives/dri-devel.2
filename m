Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0B2C61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD6AB10FAC1;
	Fri,  4 Sep 2026 12:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="jcrpyKqc";
	dkim-atps=neutral
Received: from smtpout1.mo537.mail-out.ovh.net
 (smtpout1.mo537.mail-out.ovh.net [51.210.91.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2196D10FAD7
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:32:40 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4hbwpV37GTz3wsS;
 Fri,  4 Sep 2026 12:32:34 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jagan@amarulasolutions.com>; Fri,  4 Sep 2026 12:32:34 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.41])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hbwpV1KR3z1xrT;
 Fri,  4 Sep 2026 12:32:34 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.8])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 4B2A6B81BAB; 
 Fri,  4 Sep 2026 12:32:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S0071d6b9e02-16db-4ca9-b72a-504493c0eed8,
 CD084BC5FAE4C285338CA88E85805D4DC0D096A2) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <096f0b17-c3b1-4e21-9c4c-19d4d54ed5c4@pixelcluster.dev>
Date: Fri, 4 Sep 2026 14:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jianmin Lv <lvjianmin@loongson.cn>,
 Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Dave Airlie <airlied@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Michal Simek
 <michal.simek@amd.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, cgroups@vger.kernel.org
References: <20260904120430.17224-1-hemanth.selam@gmail.com>
 <20260904120430.17224-2-hemanth.selam@gmail.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <20260904120430.17224-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13430297039058067890
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEo1Mxxc6wTYsnI0klGcwC+H/DPWRHPSf9f9b6K3OZlDpX19qDLJiuRxK2V/KqeAPperM+7WiwQwbaIKxTe8iMm1BxGGvhglGWdjGxS2QjiDyGBehD0sOzbMj+X91Gd4KzJpP0znlAhHZE9EPTrcGykp7j/6emdHjCZm5a1eCiUl0w0aWS+OSCNgaawYOTytzOsQgXAbIwquPFuCAd2NXdTbo1lg1FnVD+tDqXkJsCWJjQZFR5tjCG14u6hmRWyu6PvhxSGOjRNVIEHOOoUCeSsKqcqi990sFfPVEbi3Hs2sA6hcwjUA27iUy6ttdXjsf9d3HgzPcXGVnBStKiKBO3/mWkgK7EDTYYcKm/axJ8bj31eu8/t8HisJSy7DVydr79Gtkau7QCKsaQEcBYlLpe1KP/h+VJMl6RvrB0Cw/kuVLR3aBQ4Dvc/+sDU8n7t0HLD72FTKc8sxtua0Ss/7Spu6Hv5Tn86rvNTrRnbfcnEenCChx+0y7LbIcMqEUwnmH4GVXSxvBO6rY1OZ37a3tL+Cgkxaq6SDPh/mKSRiDLV1ARuYnV+/ijuomX3jHx50tNq0l/FrpNjitxt217tCdRWAnVbPnvXa4kROUW/v/iqhZ/vhXxDE0XCW9kJjEEWBqUl7irbE9cT6vlRuXFq9haVhr0eEHv16RP6R4AfAMc7/A
DKIM-Signature: a=rsa-sha256; bh=KQWwePkaHLWrGVdQ/nUAn7Kxj2ie0pdYpRD+7um6kDk=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1788525158; v=1;
 b=jcrpyKqc1KCtdKc88OPvttWti7uBofdSoIupHlBZqcFsRoRM+IxLYOhUiQmdbTetnFN7C6hm
 igT2wF4IQwjTUbf2dtjtTOO6Wz5UTu1K8iq153U1RA5cLrlxAXKKHSlkZtAO3GYEjzKe3PThrJz
 t0dkpdmnuiiyDtrSDYA0dZ2OwXJ9owwV/5IohNcbzv4j+B/4W8vV7ouI+wShFQUyP7g6dpZCBb4
 latswFxiEJczPZ/vZPk2PbJ6MzeK0J/5bD2tYBu4sggzfvOQy4q78NJJljYT90RpR1swcXEjezt
 yFFawgIikicM1hkusP+P0cgnY3j+xvI7jA6v3H62Wg06Q==
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

On 9/4/26 14:04, Hemanth Selam wrote:
[snip]
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 4683f3d68022..efbbf3100052 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -28,7 +28,7 @@ DEFINE_STATIC_SRCU(dmemcg_srcu);
>   struct dmem_cgroup_region {
>   	/**
>   	 * @ref: References keeping the region alive.
> -	 * Keeps the region reference alive after a succesful RCU lookup.
> +	 * Keeps the region reference alive after a successful RCU lookup.
>   	 */
>   	struct kref ref;
>   

This is already fixed by commit 23df2e995df85 ("cgroup/dmem: fix comment 
typos in dmem.c") in drm-misc-next.

Regards,
Natalie

