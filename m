Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A996C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A670E10F0B6;
	Wed,  8 Jul 2026 10:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="c7219e4r";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B131810F0C2
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 10:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783507148;
 bh=iwFN7k1l7x6sZkU0ZQcIM16C6PmtP6fEROcDVf8SnW8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=c7219e4rWLH+NttiNekbwSuQ/urAUx9f7qHZWqWQ7lsm7kC/ZXj54eakGLwu6gPbB
 VIUX2fhwzzbK3xtqcH+hlfX4q+HYzLwZGYsFSQA6J+tcvYAedUDIzPr4q6N3O5OTTk
 ZEyuHF2rg7PKwJ/PLY2m1gvjg3vruEOHX7lpta7MIqqn9XIa58zeob2rv+6lh7dSgr
 SnZQQqyo9iHjNupsSDLsZfQGgIry09xpJ79KehJI9WoaaWGJqQQP+/k4HkYU2Bzb6r
 3ySGC0lMVr5rX0iZnZAy1TxVbbOmzsmZIsxItdx147A+51rDaG7SkGMFujqsHxUtzw
 sRhpSAH+k7hJw==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9200417E00F6;
 Wed, 08 Jul 2026 12:39:07 +0200 (CEST)
Message-ID: <31117c25-5410-429a-887b-87c767387c58@collabora.com>
Date: Wed, 8 Jul 2026 13:39:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/39] drm/display: hdmi-state-helper: Add fallback
 TMDS rate validation
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
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-9-d79890d00b6a@collabora.com>
 <20260707-venomous-helpful-magpie-b2962b@penduick>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260707-venomous-helpful-magpie-b2962b@penduick>
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

On 7/7/26 2:23 PM, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Jul 02, 2026 at 05:46:22PM +0300, Cristian Ciocaltea wrote:
>> Validate the computed TMDS character rate against
>> connector->hdmi.max_tmds_char_rate when no driver-specific
>> tmds_char_rate_valid() hook is provided.
>>
>> This gives HDMI connectors a common fallback for rejecting modes whose
>> TMDS character rate exceeds the connector limit, while still allowing
>> drivers with custom validation requirements to implement their own
>> tmds_char_rate_valid() callback.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> index ce17eeefc2da..db76699093e8 100644
>> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> @@ -566,6 +566,9 @@ hdmi_clock_valid(const struct drm_connector *connector,
>>  		status = funcs->tmds_char_rate_valid(connector, mode, clock);
>>  		if (status != MODE_OK)
>>  			return status;
>> +	} else if (connector->hdmi.max_tmds_char_rate) {
>> +		if (clock > connector->hdmi.max_tmds_char_rate)
>> +			return MODE_CLOCK_HIGH;
> 
> I think we should handle this the same way we do for
> info->max_tmds_clock: if it's set, we always check that before calling
> the driver.
> 
> It reduces the boilerplate in drivers, and it's always a relevant check
> anyway.
Ack.

Thanks,
Cristian
