Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF701C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96D910E501;
	Tue, 22 Sep 2026 21:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="o5zlNzoT";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1002410E501
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790112277;
 bh=YdbB4HHFr5RiQMEKS7IZDCgTEt//MSoaU0ovnWKgFaY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=o5zlNzoTZhj10MvLCN9RERRNk12QLtK1kfvAIFY9TWvY/x0Vx7xXCU4Qz27NEc4Ao
 j/ScP5/FJpyAOQuM47UzkcQnjLTVwkbYLodGxtqPQ7VTjmpUvi/L3VDRLToQiAjhfm
 VweugPVCerh94lN8/qmLvIRTKDymIrI+NIQL+s738bw7ANjnj9lSQ1qKJHwwrlXJl/
 z01fNYmGCkIVtIHgICRqShsBygE0Y7GXKbVYsy59CEygo3B1nk1KZfm6s2feoq9fAi
 oKFau036K6gwAaZWkMVz62G1H+DjbV2h3FkOE7erBDjSnwEPf/bNIG03yhO+LqGzrU
 6sp7bDQ5Lgqhg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B185817E006F;
 Tue, 22 Sep 2026 23:24:30 +0200 (CEST)
Message-ID: <743283af-753a-40bb-96f3-d05b1e38e186@collabora.com>
Date: Wed, 23 Sep 2026 00:24:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 13/74] drm/bridge: Fix NULL deref in drm_bridge_add()
 for legacy bridges
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>, Sandy Huang
 <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>,
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>,
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-fbdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-13-bc12954a0688@collabora.com>
 <ap_Tr_Viqy29f515@houat> <DLKSY3W6CGW1.3C0J6DHKV8P2Z@bootlin.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <DLKSY3W6CGW1.3C0J6DHKV8P2Z@bootlin.com>
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

Hi Luca,

On 9/21/26 10:05 AM, Luca Ceresoli wrote:
> On Tue Sep 8, 2026 at 11:24 AM CEST, Maxime Ripard wrote:
>> On Tue, Sep 01, 2026 at 09:50:37PM +0300, Cristian Ciocaltea wrote:
>>> Legacy bridge drivers that embed struct drm_bridge in a zero-initialized
>>> allocation, rather than obtaining it from devm_drm_bridge_alloc(), never
>>> run INIT_LIST_HEAD() on bridge->list, leaving next and prev NULL.
>>> list_empty() compares next against &bridge->list, so it reports such a
>>> list head as non-empty.  list_del_init() therefore runs and dereferences
>>> the NULL pointers, panicking the kernel during probe.  Only builds with
>>> CONFIG_DEBUG_LIST survive, with a list corruption report.
>>>
>>> This affects rk3066_hdmi and the i.MX8 LDB bridges, which still embed a
>>> bridge in a devm_kzalloc()'d struct.
>>>
>>> Initialize the list head when it is found to be NULL, so that the bridge
>>> ends up with a valid empty list head and list_del_init() is only reached
>>> for bridges that can actually be linked.
>>>
>>> Fixes: 17805a15d175 ("drm/bridge: add list of removed refcounted bridges")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Closes: https://lore.kernel.org/all/20260731175016.C5D591F00AC4@smtp.kernel.org/
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>  drivers/gpu/drm/drm_bridge.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>>> index 2c457ad74f3b..a8b6df5c13ea 100644
>>> --- a/drivers/gpu/drm/drm_bridge.c
>>> +++ b/drivers/gpu/drm/drm_bridge.c
>>> @@ -453,9 +453,16 @@ void drm_bridge_add(struct drm_bridge *bridge)
>>>  	 * If the bridge was previously added and then removed, it is now
>>>  	 * in bridge_lingering_list. Remove it or bridge_lingering_list will be
>>>  	 * corrupted when adding this bridge to bridge_list below.
>>> +	 *
>>> +	 * Legacy drivers that allocate the bridge with kzalloc() rather than
>>> +	 * devm_drm_bridge_alloc() leave list.next NULL. Such a bridge cannot
>>> +	 * be on any list, and list_del_init() would dereference NULL, so
>>> +	 * initialize the list head first.
>>
>> "legacy" bridges are ambigous and was also used for non-atomic bridges.
>> That being said, it's now *required* that bridges use
>> devm_drm_bridge_alloc() instead of kzalloc, and we warn in
>> drm_bridge_add if it hasn't.
>>
>> So I don't think we should merge this patch.
> 
> I agree.
> 
> I theory all drivers are be already using devm_drm_bridge_alloc() by now.
> 
> In practice rk3066_hdmi is actually still using kzalloc, it should be fixed
> to use devm_drm_bridge_alloc(). Are you OK with doing it in v12?

Yes, I'll send this a separate series, together with the other bridge fixes. 

> By "i.MX8 LDB" I guess you mean fsl-ldb.c, which was converted in
> 9c399719cfb9 ("drm: convert many bridge drivers from devm_kzalloc() to
> devm_drm_bridge_alloc() API").

I was actually referring to imx8q*-ldb.c, but it turns out those were converted
as well - I incorrectly flagged them because the probe functions still contain

  imx8qm_ldb = devm_kzalloc(dev, sizeof(*imx8qm_ldb), GFP_KERNEL);

I've just realized the struct drm_bridge is not embedded in struct
imx8qm_ldb,but it's part of struct ldb_channel.  Sorry for the confusion.

Thanks for the reviews & tests!

Regards,
Cristian
