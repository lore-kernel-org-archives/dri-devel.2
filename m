Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82697CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF22110EAF6;
	Fri, 12 Jun 2026 19:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Gm3y3rLl";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4814F10EAF6
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 19:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781292201;
 bh=0gYiI0nuF3TbeK77gJZHu37hGbu8poCEiD0ZSHVH6BI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Gm3y3rLlS68dIE9jBDPmevDg42WfdulXApUp3vAv7VyBiVDX5lBLsVz4Ooo6x8oiQ
 fVzGhxPc15D3LNsmcxF3UzV/dX+t5U3yv66pQR7P6saOQI7//NVDOgS1YT7jq2v6mp
 XrVqT3wv2DbKwu3I691jheVivA51j13/bTKpUU3udFEyHqbvv33cDmhSi5CsfiEJo1
 sLuG0ZWupmhJBmyeVBs2hceJeHsPa2ciUBo3fHa/LXSE55Wvsn4SzScBoYeEKbDCNg
 yXVwsudNWFnlsrDmQsR5WVP11ouXRXzoT8w0+dhe22v2tqkinnK5WM7JZdmcNl9iIL
 wkeyr6clHNf+w==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DA53517E040C;
 Fri, 12 Jun 2026 21:23:20 +0200 (CEST)
Message-ID: <e81b477a-ff61-4fdf-9622-b980f8ac453c@collabora.com>
Date: Fri, 12 Jun 2026 22:23:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/30] drm/display: hdmi_state_helper: Add ctx-aware
 hotplug helper for SCDC sync
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-5-445eb54ee1ed@collabora.com>
 <20260611-refined-idealistic-sunfish-3df3a4@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260611-refined-idealistic-sunfish-3df3a4@houat>
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

On 6/11/26 6:25 PM, Maxime Ripard wrote:
> On Tue, Jun 02, 2026 at 01:44:05AM +0300, Cristian Ciocaltea wrote:
>> Introduce drm_atomic_helper_connector_hdmi_hotplug_ctx(), a variant of
>> drm_atomic_helper_connector_hdmi_hotplug() that accepts a
>> drm_modeset_acquire_ctx.
>>
>> This enables SCDC status synchronization on hotplug events, which
>> requires lock acquisition context for performing the CRTC reset
>> triggered by drm_scdc_sync_status().

[...]

>> diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
>> index 13375bd0f4ae..75fedd4a3ba8 100644
>> --- a/include/drm/display/drm_hdmi_state_helper.h
>> +++ b/include/drm/display/drm_hdmi_state_helper.h
>> @@ -7,6 +7,7 @@ struct drm_atomic_commit;
>>  struct drm_connector;
>>  struct drm_connector_state;
>>  struct drm_display_mode;
>> +struct drm_modeset_acquire_ctx;
>>  struct hdmi_audio_infoframe;
>>  
>>  enum drm_connector_status;
>> @@ -24,6 +25,9 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
>>  						       struct drm_atomic_commit *state);
>>  void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
>>  					      enum drm_connector_status status);
>> +int drm_atomic_helper_connector_hdmi_hotplug_ctx(struct drm_connector *connector,
>> +						 enum drm_connector_status status,
>> +						 struct drm_modeset_acquire_ctx *ctx);
> 
> There's not a lot of users, so I'd prefer if we were just changing the
> prototype of drm_atomic_helper_connector_hdmi_hotplug()

Ack - that was actually my first attempt, but I later thought it would be more
desirable to handle it incrementally.

Cristian
