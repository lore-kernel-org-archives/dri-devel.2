Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28F5CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5782C10E75E;
	Mon, 11 May 2026 13:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="agJmQ3hg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F264310E771
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778507090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5HIxXZWET6ZUvg/xyF+wJRy+Khfw5bTC/UU2AdmG+xM=;
 b=agJmQ3hg5S3OM8D9Jh1vWyk3iDqN7edkqlsDMfQrSzAISNyM+X44e/nUlKaBJxp4Q2cgGs
 gyg62SUo3zNLbUGN0ZcFNEQOm/VYsRQW+cYlx4+5JB3tsfDEUydn7tmlJtitRfO6J10mtd
 v9kmwTMP4kWQ+7Kw1ibLBW58q0gMUu8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-5VwPpcDAOf6GETn3wr8tfA-1; Mon, 11 May 2026 09:44:48 -0400
X-MC-Unique: 5VwPpcDAOf6GETn3wr8tfA-1
X-Mimecast-MFC-AGG-ID: 5VwPpcDAOf6GETn3wr8tfA_1778507087
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4470d6d2a4fso4680371f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507087; x=1779111887;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5HIxXZWET6ZUvg/xyF+wJRy+Khfw5bTC/UU2AdmG+xM=;
 b=Puj1UKp/rTfJvBcGdM2okiFUrAyuASFAinytISMyATYoUm4LcfjZ+97Qe+Vq0BFtsa
 Q/R+DAaWub67f8Kslipw9+CrWV1UIcdU8P+kuball4q+gx+yddKfTqbbwpsT9S1+7k0m
 Y5Ly197ia+Xwf75vh9vSuScRcl4//XEZ9nQ+m9txkt8gxWp941GvdQHiZBL28cy1G/i9
 hJK8VK20tHgVeytZPN+Zu61NF1bsfzyNhy3yyVpPGBqBuZQDjB/k6cxd1GFCL042/1Uh
 6ZTfaujfP92HptIVQyRvkh2kjZfNVWmuqyEo/pGKVJfH1qb/aTQCViDAM3wCtPeBA+Dd
 DnvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xZUUY/Zpvh9dtHN3IFS0mJ67qSvSOoidKEXWFgbtW7LdmYqRmUelIwQGnoatkPkEyAK0ykI3QUFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx482nPyPP6uKSVZHugoVj03XJnpJizjZHKe6lu5njD+7ociwXl
 vytI6x+QLCQ5CFuOHS7iFG46dWhzOE/SZBQItDAcAn0i2mOzghlFKt1Ymb2iswLN0AxhFNX2xfY
 AEajC6xpUWZ7ofXkrTceorxwTevn5N5htlZr8JFVCMT+9MBinZzyzWeVgJjigcYQYIhglnw==
X-Gm-Gg: Acq92OFBXwnuZdkvI2YCzF6bqEJQSLhPGGLOP9WrxzJBOGiK06FlAJ4LqQZ27pTqcqH
 tI22MlxZD5XFxmqOYsBwZq1epJqHD18AwrmJDeBbTJj3VoV7gwpLt1J+8ukqaVsh6Sa/9wXpDTw
 fmQTp2qCtjFx4ZxQU0/XMFYbzwPItZGdudmpUp4PBFPFxo6qpINIvQLwAR5MTL6efh5MToGAhTJ
 QVprUX9WWLpszAzfrWe8Pv39+9fA7PoPFc4EHr1DyL4zRTu9kUadkpCyM9QGLNIKPmkizT55851
 GjzJUZYOBcsH7wIdF0HAM5qNcBOh2W86/pN0U8ekiqyI0ceQr9ObmsV4Ra4T/mqW730xZUGtghe
 1ZBxAI9EmGjwa7BwCOVDIjte9Y2Zg5cWKQJBYZHUboWzI0FRe46XJ03QP+WYoo1s=
X-Received: by 2002:a05:600c:8b65:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48e51f4e5fdmr434911165e9.28.1778507087156; 
 Mon, 11 May 2026 06:44:47 -0700 (PDT)
X-Received: by 2002:a05:600c:8b65:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48e51f4e5fdmr434910375e9.28.1778507086673; 
 Mon, 11 May 2026 06:44:46 -0700 (PDT)
Received: from localhost ([195.166.127.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e6d41sm238701695e9.7.2026.05.11.06.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:44:45 -0700 (PDT)
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
Subject: Re: [PATCH 3/3] drm/bridge: it66121: Select HDMI or DVI mode based
 on sink type
In-Reply-To: <20260511-gentle-grouse-of-growth-3ac263@houat>
References: <20260510191459.90769-1-javierm@redhat.com>
 <20260510191459.90769-4-javierm@redhat.com>
 <20260511-spiritual-unique-uakari-5ffce7@houat>
 <877bpayuw7.fsf@ocarina.mail-host-address-is-not-set>
 <20260511-gentle-grouse-of-growth-3ac263@houat>
Date: Mon, 11 May 2026 15:44:43 +0200
Message-ID: <8733zyysac.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 605S3GPD-mH2_bgUGI353bpulBS-7OkjjGOZNpXBkYs_1778507087
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

> Hi,
>
> On Mon, May 11, 2026 at 02:48:24PM +0200, Javier Martinez Canillas wrote:
>> Maxime Ripard <mripard@kernel.org> writes:
>> > On Sun, May 10, 2026 at 09:14:49PM +0200, Javier Martinez Canillas wrote:
>> >> Currently, the driver assumes that the connector sink type is always HDMI
>> >> and configures the IT66121 bridge appropriately. But configuring in this
>> >> mode and enabling the transmission of AVI infoframe packets can cause DVI
>> >> monitors to fail parsing the video signal.
>> >> 
>> >> To prevent this, store the connector display information sink type in the
>> >> bridge atomic state and use it to decide whether the bridge should be set
>> >> in HDMI or DVI mode, and if the AVI infoframes packets should be sent.
>> >> 
>> >> Assisted-by: Cursor:claude-4.6-opus
>> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> >> ---
>> >> 
>> >>  drivers/gpu/drm/bridge/ite-it66121.c | 68 ++++++++++++++++++----------
>> >>  1 file changed, 44 insertions(+), 24 deletions(-)
>> >> 
>> >> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>> >> index a203c94a27e5..99088277d170 100644
>> >> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>> >> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>> >> @@ -322,6 +322,7 @@ static inline struct it66121_ctx *bridge_to_it66121_ctx(struct drm_bridge *bridg
>> >>  
>> >>  struct it66121_bridge_state {
>> >>  	struct drm_bridge_state base;
>> >> +	bool sink_is_hdmi;
>> >>  };
>> >>  
>> >>  static inline struct it66121_bridge_state *
>> >> @@ -790,6 +791,14 @@ static int it66121_bridge_check(struct drm_bridge *bridge,
>> >>  				struct drm_connector_state *conn_state)
>> >>  {
>> >>  	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
>> >> +	struct it66121_bridge_state *state =
>> >> +		to_it66121_bridge_state(bridge_state);
>> >> +
>> >> +	/* Default to HDMI to preserve legacy behavior. */
>> >> +	state->sink_is_hdmi = true;
>> >> +
>> >> +	if (conn_state && conn_state->connector)
>> >> +		state->sink_is_hdmi = conn_state->connector->display_info.is_hdmi;
>> >
>> > It's really not clear to me why you need to have that in the bridge
>> > state. What's wrong with using drm_display_info.is_hdmi directly?
>> >
>> 
>> I wrongly thought that couldn't get that info from it66121_bridge_mode_set()
>> so I thought about making it a property of the bridge atomic state.
>> 
>> But I see now that the connector is already stored in struct it66121_ctx *ctx
>> so the fix indeed becomes even more trivial.
>
> Actually, there's something super fishy there.
>
> ctx->connector is stored only at atomic_enable time, but you'd be using
> ctx->it at modeset time which is kind of decorelated to atomic_enable,
> ctx->can be called multiple times, etc.
>
> It seems to be already used, so it probably works, but I don't think the
> framework provides that guarantee.
>

Yes, I found it strange too but as you said it was already used and I'm
just making the same assumptions that the driver is currently doing. But
that's the reason why I had the condition

if (!connector || connector->display_info.is_hdmi) {

just in case it66121_bridge_mode_set() was called before atomic_enable and
ctx->connector was NULL. Then the driver will continue behaving as before.

[...]

>> @@ -766,41 +767,55 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
>>  {
>>  	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
>>  	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>> +	struct drm_connector *connector = ctx->connector;
>>  	int ret;
>>  
>>  	mutex_lock(&ctx->lock);
>>  
>> -	ret = drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infoframe, ctx->connector,
>> -						       adjusted_mode);
>> -	if (ret) {
>> -		DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
>> -		goto unlock;
>> -	}
>> +	if (!connector || connector->display_info.is_hdmi) {
>> +		ret = drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infoframe,
>> +							       connector,
>> +							       adjusted_mode);
>> +		if (ret) {
>> +			DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
>> +			goto unlock;
>> +		}
>>  
>> -	ret = hdmi_avi_infoframe_pack(&ctx->hdmi_avi_infoframe, buf, sizeof(buf));
>> -	if (ret < 0) {
>> -		DRM_ERROR("Failed to pack infoframe: %d\n", ret);
>> -		goto unlock;
>> -	}
>> +		ret = hdmi_avi_infoframe_pack(&ctx->hdmi_avi_infoframe, buf, sizeof(buf));
>> +		if (ret < 0) {
>> +			DRM_ERROR("Failed to pack infoframe: %d\n", ret);
>> +			goto unlock;
>> +		}
>>  
>> -	/* Write new AVI infoframe packet */
>> -	ret = regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
>> -				&buf[HDMI_INFOFRAME_HEADER_SIZE],
>> -				HDMI_AVI_INFOFRAME_SIZE);
>> -	if (ret)
>> -		goto unlock;
>> +		/* Write new AVI infoframe packet */
>> +		ret = regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
>> +					&buf[HDMI_INFOFRAME_HEADER_SIZE],
>> +					HDMI_AVI_INFOFRAME_SIZE);
>> +		if (ret)
>> +			goto unlock;
>>  
>> -	if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
>> -		goto unlock;
>> +		if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
>> +			goto unlock;
>>  
>> -	/* Enable AVI infoframe */
>> -	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
>> -			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
>> -		goto unlock;
>> +		/* Enable AVI infoframe */
>> +		if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
>> +				 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
>> +			goto unlock;
>>  
>> -	/* Set TX mode to HDMI */
>> -	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
>> -		goto unlock;
>> +		/* Set TX mode to HDMI */
>> +		if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG,
>> +				 IT66121_HDMI_MODE_HDMI))
>> +			goto unlock;
>> +	} else {
>> +		/* Disable AVI infoframe */
>> +		if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG, 0))
>> +			goto unlock;
>> +
>> +		/* Set TX mode to DVI */
>> +		if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG,
>> +				 IT66121_HDMI_MODE_DVI))
>> +			goto unlock;
>> +	}
>
> It looks like an early return if !is_hdmi would be more readable?
>

I'm not sure to follow this comment. The driver needs to take some actions
regardless of the TX mode used, so it66121_bridge_mode_set() can't really
return early for the !is_hdmi case.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

