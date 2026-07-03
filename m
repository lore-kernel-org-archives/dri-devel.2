Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620C2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAFD10F8DA;
	Fri,  3 Jul 2026 19:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="eO2SeGoj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A828C10F8DA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783108511;
 bh=dqOHIAGMWhCgRowmL1u07fCxLEb4Pr3jh8BO4JUIoiI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eO2SeGojJ+r0vQNNXHIuPbEdgQ79bOPQ+EDjyOcfr/k15Tqldg9z173ziGZ8AFx57
 0GF75+tgDQbkTObZz/WHIqP008Ea9t8kYQD1e50bf00+Lo9/PEVdA1t/YeMacSj0tE
 vJOV3HDESBw7kxAdkUhupmzopq8Ecj/QwhEUQWheeZnTIv8Qv5skakKOAa1cZH5+rV
 Vu9dA3ebE2l5IpmG9v+a8ev1VttaF8E/Ddn0uqjCH4T7Dwxj48gUNAsOC7dI+TMzOF
 8TWdt4wA936pZ/7z2l5Apw2j+u/++L/hyB0f8jvnYEHP+zdK7iz2Fds5cEIXKbPtT+
 GerjIbsFkYB5A==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 650DA17E063B;
 Fri,  3 Jul 2026 21:55:10 +0200 (CEST)
Message-ID: <f74ffd53-5776-4fae-a6fe-eeace5c3fc5f@collabora.com>
Date: Fri, 3 Jul 2026 22:55:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/39] drm/display: bridge_connector: Pass HDMI
 capabilities through caps struct
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
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
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <eqnr2hfclbdkry2jqe2kuufss5kus6qpjblewq35upnjwlhxhl@4awqxpwrnxk2>
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

On 7/3/26 5:19 PM, Dmitry Baryshkov wrote:
> On Thu, Jul 02, 2026 at 05:46:16PM +0300, Cristian Ciocaltea wrote:
>> Switch drm_bridge_connector_init() to
>> drmm_connector_hdmi_init_with_caps(), collecting the bridge's HDMI
>> properties into a stack drm_connector_hdmi_caps so future HDMI 2.x
>> capabilities can be plumbed without growing the argument list.
>>
>> Introduce struct drm_bridge::supported_hdmi_ver to let bridges declare
>> the HDMI specification version they are conformant with, and forward it
>> to the connector layer through the new caps struct so HDMI 2.x features
>> can be gated on real source capability rather than guesswork.
> 
> And it's left uninitialized by the bridges, which doesn't mean anything.
> If you don't want to touch all bridge drivers in one commit, please
> provide some migration path and hopefully get rid of it by the end of
> the series. 

Sure, one question though: at the end of the migration, would it be fine to
stick with drmm_connector_hdmi_init_with_caps() and just drop
drmm_connector_hdmi_init()?  Otherwise I'll rename it back.

> At least, there should be a drm_warn() if the version in
> unsspecified.

I’ll double-check if any use cases remain that can't be covered by this series.

>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_bridge_connector.c | 29 ++++++++++++++------------
>>  include/drm/drm_bridge.h                       |  6 ++++++
>>  2 files changed, 22 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
>> index 92f8a2d7aab4..796069dbf1a1 100644
>> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
>> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
>> @@ -823,8 +823,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>>  	struct drm_connector *connector;
>>  	struct i2c_adapter *ddc = NULL;
>>  	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
>> -	unsigned int supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
>> -	unsigned int max_bpc = 8;
>> +	struct drm_connector_hdmi_caps caps = {
>> +		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
>> +		.max_bpc = 8,
>> +	};
> 
> I'm really not sure that we need separate caps. But if we do, it would
> make sense to embed it as is in the drm_bridge instead of having the
> scattered fields.

Ack.

> 
>>  	bool support_hdcp = false;
>>  	int connector_type;
>>  	int ret;
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 18f3db367dc1..2d8b5e4c64ba 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -1176,6 +1176,12 @@ struct drm_bridge {
>>  	 */
>>  	const char *product;
>>  
>> +	/**
>> +	 * @supported_hdmi_ver: HDMI version the bridge is conformant with.
>> +	 * This is only relevant if @DRM_BRIDGE_OP_HDMI is set.
>> +	 */
>> +	enum hdmi_version supported_hdmi_ver;
>> +
>>  	/**
>>  	 * @supported_formats: Bitmask of @drm_output_color_format listing
>>  	 * supported output formats. This is only relevant if
>>
>> -- 
>> 2.54.0
>>
> 
