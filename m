Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21046C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F68910E2BB;
	Wed, 22 Jul 2026 12:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PprzGMQa";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E82010E2BB
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784721841;
 bh=nT5fhfe0RjpKLPARR0Tl+dL4OT3X73lgOHZYHu6f+mw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PprzGMQaFXJUVMwPQkPXQHAiPVbKz3LOn4qKLnJmY8OrCbRFd42vtdjk/B9vyLvWA
 myCJDoKBYamluY6wyoPRQ/tl3ZP2nhdNbe5sevWvL/1FNj4LNsjsAFeehejfZ017EW
 gi10rCB68SWwhRspltcFpYZKKekEJidrd8fha57hN7gAiEU3yAG+J1zcfAf7Tsrnh1
 5MspXjEIQnEtbFQvIG+99ypL5mNRHEXLKWh2cVYW7Jcgkgq3suTrtLA5dZKmDtIHG6
 rubOsesOTnpSC/0E5YUHRMkOVCQ5ILp8G+oUPcZxZHbI6V8dG/mDpcCn7b5qtSJ5yR
 Uq/jSCW4cuTQQ==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D238717E062C;
 Wed, 22 Jul 2026 14:04:00 +0200 (CEST)
Message-ID: <e9a1ef2c-8e3b-44ef-905e-0b0bad27e745@collabora.com>
Date: Wed, 22 Jul 2026 15:04:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/39] drm/display: bridge_connector: Pass HDMI
 capabilities through caps struct
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-3-d79890d00b6a@collabora.com>
 <eqnr2hfclbdkry2jqe2kuufss5kus6qpjblewq35upnjwlhxhl@4awqxpwrnxk2>
 <f74ffd53-5776-4fae-a6fe-eeace5c3fc5f@collabora.com>
 <20260708-bold-ruby-potoo-c6c949@houat>
 <dfe104fb-a132-4871-9dc0-52c157a2f08c@collabora.com>
 <zp7qqyaiir2npq3kzf23kqu26y3cr2fa7bdqtqnca2xggd3fvw@f4plbn6lzqng>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <zp7qqyaiir2npq3kzf23kqu26y3cr2fa7bdqtqnca2xggd3fvw@f4plbn6lzqng>
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

On 7/22/26 9:47 AM, Dmitry Baryshkov wrote:
> On Wed, Jul 08, 2026 at 01:19:23PM +0300, Cristian Ciocaltea wrote:
>> On 7/8/26 9:46 AM, Maxime Ripard wrote:
>>> On Fri, Jul 03, 2026 at 10:55:09PM +0300, Cristian Ciocaltea wrote:
>>>> On 7/3/26 5:19 PM, Dmitry Baryshkov wrote:
>>>>> On Thu, Jul 02, 2026 at 05:46:16PM +0300, Cristian Ciocaltea wrote:
>>>>>> Switch drm_bridge_connector_init() to
>>>>>> drmm_connector_hdmi_init_with_caps(), collecting the bridge's HDMI
>>>>>> properties into a stack drm_connector_hdmi_caps so future HDMI 2.x
>>>>>> capabilities can be plumbed without growing the argument list.
>>>>>>
>>>>>> Introduce struct drm_bridge::supported_hdmi_ver to let bridges declare
>>>>>> the HDMI specification version they are conformant with, and forward it
>>>>>> to the connector layer through the new caps struct so HDMI 2.x features
>>>>>> can be gated on real source capability rather than guesswork.
>>>>>
>>>>> And it's left uninitialized by the bridges, which doesn't mean anything.
>>>>> If you don't want to touch all bridge drivers in one commit, please
>>>>> provide some migration path and hopefully get rid of it by the end of
>>>>> the series. 
>>>>
>>>> Sure, one question though: at the end of the migration, would it be fine to
>>>> stick with drmm_connector_hdmi_init_with_caps() and just drop
>>>> drmm_connector_hdmi_init()?  Otherwise I'll rename it back.
>>>
>>> Absolutely, it doesn't make any sense to keep both variants.
>>
>> I was referring to whether option 3 might be the preferred choice in the context
>> of the earlier patch discussion.
> 
> Plesae exuse my ignorance, what is option 3?

The options discussed were:

1. Continue with drmm_connector_hdmi_init_with_caps() after removing the caps
   parameter, and then drop drmm_connector_hdmi_init() after the migration.
...
3. A variation of option 1: additionally rename
   drmm_connector_hdmi_init_with_caps() to drmm_connector_hdmi_init() after the
   migration.

In the end I went with a slightly different approach: temporarily renamed the
original helper to drmm_connector_hdmi_ini2(), to let the new signature be
introduced under the original name while callers were converted incrementally.
Finally added a patch to remove *_ini2().

Note the transitional name had the same length, to avoid re-alignment churn and
keep the diffs to a minimum.

Cristian
