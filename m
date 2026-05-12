Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1743CCD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 18:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD3510E037;
	Tue, 12 May 2026 18:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AjxVdcy0";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131E210E29A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 18:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778612058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEOPZvdhBJuzwZH+mKw19MN5xnTiK9IYMBeM17pNMak=;
 b=AjxVdcy0DmQiWoM+ivvSlG+l8iYh0Hnti4UD9eQP5ND+VLdt1wyFPinz4UsNHuZry/yGtn
 FfzZSUgNGPTVO10mr1ow1uIjNOryfGWqcSInuo8NL5PKgDigB4Sk0qaob2qUYlTkrS2qjE
 lGh32jOmAJLoPzxGWS+xqXKPHRysmVQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-P8GQSNYdNoK_E8qpNx4JoQ-1; Tue, 12 May 2026 14:54:16 -0400
X-MC-Unique: P8GQSNYdNoK_E8qpNx4JoQ-1
X-Mimecast-MFC-AGG-ID: P8GQSNYdNoK_E8qpNx4JoQ_1778612056
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45aeac88af4so941891f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778612055; x=1779216855;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mEOPZvdhBJuzwZH+mKw19MN5xnTiK9IYMBeM17pNMak=;
 b=f1xCVbUX6mxmVB3d0Hq7OO5Wr3d7r55pUvyqpQlOqoxTKi/vpe0oVuAmzB6B3hWNMm
 0fRikX8T83LKqX6OiYXPonhxx3BYPUQId2zjz+ay3drBsKbJBnLsMcZrTiMxUS0809PC
 9FeFpql3fHFW1DgVLH20j61AELYl7cJUYzYQYeX/3pZRuTYwZSiJV8tBdtaPOcgG4zju
 aj7i3zM85YjgGaINGg9O9wqX2S4/r7J5uSbeh7H/zFKPT4GbGPnry+JKS1bDVktpU7/d
 tbajiLybGbGOlxX3H5h4L/8jLylHRM+JfLh/fyBjUc1+2PfmysPwwqEYEg9uAWR3QsWu
 xRqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KR9po2EHCRVcL2v/6cXGrZzUziWI5quSGHmiBPPrmdnnacYKUIDs3NCuVHCBMze4OU1tUBA5bLoo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2YXZls8gJpTvRwqp6rVVAVanotwgdabRt4UXVaF68f1Hn5XBr
 1t2N4aA0kpCB2XJz7h+hFBrVP2tfA1UfES9dTZuLBCFgoeM59GJi6ccZd9tMubzlqmx7zLM/nRz
 vFD5j/uOlHh905DXYtTqLA8XKEH4JzwL0BKQkmtAvNSXrEq3ey14t2oontIoALJQnJkBWvQ==
X-Gm-Gg: Acq92OGgr1dET1hOX+B9XKykXx9797pHhip92xF8NGNIEux8L73dz0TEt/i07Ostif2
 xcNsJNMXBSAfVk3jkurnmbSJhyyGYJAFjOHm8rDW9rR414U7Gm8KmQQPRGnXbiuJ/jvDxj9je/0
 6XxUIx3AzyQrjrY94V29x7eNabv54LH9EhbNVUiN0tpqVFgMSYS7p3r4oR729wCmQri8kaqqpN/
 Rz0l2s+qlTJyYCf2JV2jmUgV7xGKatbuR1Kwj/xgkomxv52LvSODPE/G2llKfgfoKQqYhKDLync
 xq/pwgMnX+CJ2LqnCI+gfIro5gvkVnwfZRtxnTwbw+2Qud9C4uw/kYRoUmCzFM9qVAR51yiwWz+
 gRnXZbet1KhV7KreyQsQi3bgPoq/FBjbW40KMJ2LKqnCcKxcIoamJ9AvyDBcIKSSac9+3T/X3hs
 vnfULE
X-Received: by 2002:a05:6000:61e:b0:43d:7508:c9c9 with SMTP id
 ffacd0b85a97d-45c59bd6100mr7964f8f.27.1778612055463; 
 Tue, 12 May 2026 11:54:15 -0700 (PDT)
X-Received: by 2002:a05:6000:61e:b0:43d:7508:c9c9 with SMTP id
 ffacd0b85a97d-45c59bd6100mr7924f8f.27.1778612054959; 
 Tue, 12 May 2026 11:54:14 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454916df968sm35967004f8f.25.2026.05.12.11.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:54:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 David Airlie <airlied@gmail.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>, Robert Foss
 <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/2] drm/bridge: ite-it66121: Set TX mode in the
 .atomic_enable callback
In-Reply-To: <20260512-romantic-qualified-hound-b5f9b9@houat>
References: <20260512132232.333654-1-javierm@redhat.com>
 <20260512132232.333654-2-javierm@redhat.com>
 <20260512-romantic-qualified-hound-b5f9b9@houat>
Date: Tue, 12 May 2026 20:54:13 +0200
Message-ID: <87tsscxxuy.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hBUb8-GnKZvypelz1l5ZxaCwn4ox3qk43JzD-5tWpho_1778612056
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Maxime Ripard <mripard@kernel.org> writes:

Thanks again for your feedback!

> Hi,
>
> On Tue, May 12, 2026 at 03:22:15PM +0200, Javier Martinez Canillas wrote:
>> The HDMI transmission mode set and AVI infoframes enable are done in the
>> .mode_set callback, but it is more correct to do this in .atomic_enable.
>> 
>> Because the information about the sink type is in the struct drm_connector
>> display_info.is_hdmi and this might not be available when the .mode_set
>> callback is executed.
>> 
>> Currently the driver is not checking display info to determine whether the
>> mode has to be set to HDMI or DVI, but this is a bug that will be fixed by
>> a follow-up change.
>> 
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>> (no changes since v1)
>> 
>>  drivers/gpu/drm/bridge/ite-it66121.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>> index 19a027d75b61..648ca50712df 100644
>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>> @@ -669,6 +669,22 @@ static int it66121_set_mute(struct it66121_ctx *ctx, bool mute)
>>  			    IT66121_PKT_GEN_CTRL_ON | IT66121_PKT_GEN_CTRL_RPT);
>>  }
>>  
>> +static void it66121_set_tx_mode(struct it66121_ctx *ctx)
>> +{
>> +	mutex_lock(&ctx->lock);
>> +
>> +	/* Enable AVI infoframe */
>> +	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
>> +			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
>> +		goto unlock;
>> +
>> +	/* Set TX mode to HDMI */
>> +	regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI);
>> +
>> +unlock:
>> +	mutex_unlock(&ctx->lock);
>> +}
>> +
>>  #define MAX_OUTPUT_SEL_FORMATS	1
>>  
>>  static u32 *it66121_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>> @@ -729,6 +745,8 @@ static void it66121_bridge_enable(struct drm_bridge *bridge,
>>  	ctx->connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
>>  
>>  	it66121_set_mute(ctx, false);
>> +
>> +	it66121_set_tx_mode(ctx);
>>  }
>
> Having some part of it in mode_set and some part in enable is still kind
> of weird. The best there would be to put everything in enable (and
> pre_enable), and drop mode_set entirely.
>

I agree that this will be the correct approach. I wonder though if could be
acceptable to land the changes in this series as a minimal fix for the DVI
mode issue, and then do further refactoring as a follow-up.

Note that what I'm doing in this version is aligned to what the sii902x
bridge driver also does:

static void sii902x_bridge_atomic_enable(struct drm_bridge *bridge,
					 struct drm_atomic_commit *state)
{
...
	u8 output_mode = SII902X_SYS_CTRL_OUTPUT_DVI;

	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
	if (connector && connector->display_info.is_hdmi)
		output_mode = SII902X_SYS_CTRL_OUTPUT_HDMI;
...
	regmap_update_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA,
			   SII902X_SYS_CTRL_OUTPUT_MODE, output_mode);
...
}

So that driver would also need the cleanup to get rid of the legacy .mode_set.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

