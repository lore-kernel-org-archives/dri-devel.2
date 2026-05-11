Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463B1CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 12:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A704410E705;
	Mon, 11 May 2026 12:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Rr9XcSgA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7681610E705
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778503710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JjDZUYmpDlHK2sR+IRwfTQR+l1l8e3DSAuVEYL5/TPk=;
 b=Rr9XcSgAl4UdTb+2fKAuBEVvBlkPuBQGUpexKw1NO2HtTdMCexFROcG9tJLZLUQQ3A65zQ
 W0+LgliCA1sachptyb6aHfQW+76iwk95HpMFf+usyL3F501pAL2iBJbh149J40OBpep0WF
 /IRybY15kN/HeIiX4ruZk+vsSmCU2AY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-G99uA1w-OGurp7Q42zBekA-1; Mon, 11 May 2026 08:48:29 -0400
X-MC-Unique: G99uA1w-OGurp7Q42zBekA-1
X-Mimecast-MFC-AGG-ID: G99uA1w-OGurp7Q42zBekA_1778503708
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48e6af7a9cdso18605195e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 05:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778503708; x=1779108508;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JjDZUYmpDlHK2sR+IRwfTQR+l1l8e3DSAuVEYL5/TPk=;
 b=X2lutMX/eqi8GaPOB7fQrj0h6a1DKOEN2Kt3ke49wMOsIWbLyrgJkLIk/rj88oBrRa
 ORgvXMCfhhiPMofJIpoze9bCnqd/d3JWwuEn13qlP/DV96CwW8ry0y1qGKzDRuEirE32
 oCsl85g2b3wM5MYPSQ9f6tbsM1AAq1666Y+X3KbwuL1fnUsjwsSXZbPNUwAa7Eelo15S
 eOSH1CJyc1Sl6bxTkI8nLaqH99F54QMB+gXnN0A3DPADtRpEIi6PUFwxmkuGZN/w8Fsv
 ik0UVd/JwLoEoknLrmn/NJ2rWzdIvPqbfeBI55Qz+ed845mPd9pACTai8RLlK9x9ugJf
 3FPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0OXGnUqXitUT10BfwudHEDmBJsR4xNDXX0BQ7oW/ltXoD3p493e4X2bts3tllrLsl+5vMkJlRg3g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhWqyS1so/yL5z8mBqDUNDIWDz3ZkJ7xxBF+gSfUhbdZ3/Jn/k
 EAAxVZnZbrZKePVaQoi6I2DYT7crNl7g2Ys6apLJmKeCgd+Q3oDxsZ6UkgWM/DIpF3DG4TbXvSf
 CKtZedr7ikFxb54Pl3qRFUwwHJNr1qMaCS4u06oP1igyCHb3tLpExcsum7WVLhHXw9ncfuQ==
X-Gm-Gg: Acq92OH7eLymEanbEqryHzHbhdMgpmde3pFPBLdFDBLa2DKLDnBegMps1eboMcq2ycp
 Re4NnDb5WP3QZaDG4ikPrqH9BVMspZ5vZX+iVDtcmgw3k6BF8lEKFeJOO6Cx3eCdcDUTv+VNmWT
 vIQFWZwP03fn1rE822Siighclgl5BoDladXrXNXhS23gS1ZvX3LypRToNg41OMVXmTXyTPpRtUQ
 gito7Hh+YYQ9RrBO95gZmhkgGXng4DQYoa0d4KUZhhwa2A5pKv3oFLFY39S3mJGUtSFH1zfrUtH
 CAAUDxpSL6Lx5uE2VljrRA2umAkTcYlCDvnF/chR5Rwu8mKMp4/rodyJTIUj4FWBmbKXkcDvTGf
 ks9pVVwXJ8Zg3u1O2RK70ZfWPO3SwMDP8m6OXyFXVt4f9gjmUe+3A
X-Received: by 2002:a05:600c:15d3:b0:488:c80c:c236 with SMTP id
 5b1f17b1804b1-48e51e0977fmr221128665e9.5.1778503707565; 
 Mon, 11 May 2026 05:48:27 -0700 (PDT)
X-Received: by 2002:a05:600c:15d3:b0:488:c80c:c236 with SMTP id
 5b1f17b1804b1-48e51e0977fmr221128315e9.5.1778503706900; 
 Mon, 11 May 2026 05:48:26 -0700 (PDT)
Received: from localhost ([195.166.127.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6fffba5fsm176619115e9.2.2026.05.11.05.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 05:48:26 -0700 (PDT)
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
In-Reply-To: <20260511-spiritual-unique-uakari-5ffce7@houat>
References: <20260510191459.90769-1-javierm@redhat.com>
 <20260510191459.90769-4-javierm@redhat.com>
 <20260511-spiritual-unique-uakari-5ffce7@houat>
Date: Mon, 11 May 2026 14:48:24 +0200
Message-ID: <877bpayuw7.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0oqyGXqI1evJ6jsvfLWuPiyc2Vv0_Unw02KHzHLpv-A_1778503708
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

Hello Maxime!

> Hi,
>
> On Sun, May 10, 2026 at 09:14:49PM +0200, Javier Martinez Canillas wrote:
>> Currently, the driver assumes that the connector sink type is always HDMI
>> and configures the IT66121 bridge appropriately. But configuring in this
>> mode and enabling the transmission of AVI infoframe packets can cause DVI
>> monitors to fail parsing the video signal.
>> 
>> To prevent this, store the connector display information sink type in the
>> bridge atomic state and use it to decide whether the bridge should be set
>> in HDMI or DVI mode, and if the AVI infoframes packets should be sent.
>> 
>> Assisted-by: Cursor:claude-4.6-opus
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>>  drivers/gpu/drm/bridge/ite-it66121.c | 68 ++++++++++++++++++----------
>>  1 file changed, 44 insertions(+), 24 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>> index a203c94a27e5..99088277d170 100644
>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>> @@ -322,6 +322,7 @@ static inline struct it66121_ctx *bridge_to_it66121_ctx(struct drm_bridge *bridg
>>  
>>  struct it66121_bridge_state {
>>  	struct drm_bridge_state base;
>> +	bool sink_is_hdmi;
>>  };
>>  
>>  static inline struct it66121_bridge_state *
>> @@ -790,6 +791,14 @@ static int it66121_bridge_check(struct drm_bridge *bridge,
>>  				struct drm_connector_state *conn_state)
>>  {
>>  	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
>> +	struct it66121_bridge_state *state =
>> +		to_it66121_bridge_state(bridge_state);
>> +
>> +	/* Default to HDMI to preserve legacy behavior. */
>> +	state->sink_is_hdmi = true;
>> +
>> +	if (conn_state && conn_state->connector)
>> +		state->sink_is_hdmi = conn_state->connector->display_info.is_hdmi;
>
> It's really not clear to me why you need to have that in the bridge
> state. What's wrong with using drm_display_info.is_hdmi directly?
>

I wrongly thought that couldn't get that info from it66121_bridge_mode_set()
so I thought about making it a property of the bridge atomic state.

But I see now that the connector is already stored in struct it66121_ctx *ctx
so the fix indeed becomes even more trivial.

> If you really want to rework the driver though, switch to HDMI state
> helpers would fix all of it :)
>

Sure, I will do. But I think that is still worth to land a minimal fix and
then do the switch to the HDMI state helpers as a follow up. So what do you
think of the following patch?

(Note that I dropped the Assisted-by tag this time since v2 has been manually
written by me, with no assistance from an LLM).

From 02d4e9d306c22375445f062cb4476395aa68df5f Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Mon, 11 May 2026 14:43:17 +0200
Subject: [PATCH v2] drm/bridge: it66121: Select HDMI or DVI mode based on sink
 type

Currently, the driver assumes that the connector sink type is always HDMI,
so it configures the bridge in this mode and enables the transmission of
AVI infoframe packets.

But this can cause problems on DVI monitors that can fail to interpret the
video signal and lead to not having display output.

Check the connector display information sink type to decide whether DVI or
HDMI mode should be set and if the AVI infoframes packets should be sent.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Don't store the sink type in a per-commit bridge state (Maxime).

 drivers/gpu/drm/bridge/ite-it66121.c | 67 +++++++++++++++++-----------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 19a027d75b61..a9c5bab665af 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -182,6 +182,7 @@
 
 #define IT66121_HDMI_MODE_REG			0xC0
 #define IT66121_HDMI_MODE_HDMI			BIT(0)
+#define IT66121_HDMI_MODE_DVI			0
 
 #define IT66121_SYS_STATUS_REG			0x0E
 #define IT66121_SYS_STATUS_ACTIVE_IRQ		BIT(7)
@@ -766,41 +767,55 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 {
 	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
 	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct drm_connector *connector = ctx->connector;
 	int ret;
 
 	mutex_lock(&ctx->lock);
 
-	ret = drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infoframe, ctx->connector,
-						       adjusted_mode);
-	if (ret) {
-		DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
-		goto unlock;
-	}
+	if (!connector || connector->display_info.is_hdmi) {
+		ret = drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infoframe,
+							       connector,
+							       adjusted_mode);
+		if (ret) {
+			DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
+			goto unlock;
+		}
 
-	ret = hdmi_avi_infoframe_pack(&ctx->hdmi_avi_infoframe, buf, sizeof(buf));
-	if (ret < 0) {
-		DRM_ERROR("Failed to pack infoframe: %d\n", ret);
-		goto unlock;
-	}
+		ret = hdmi_avi_infoframe_pack(&ctx->hdmi_avi_infoframe, buf, sizeof(buf));
+		if (ret < 0) {
+			DRM_ERROR("Failed to pack infoframe: %d\n", ret);
+			goto unlock;
+		}
 
-	/* Write new AVI infoframe packet */
-	ret = regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
-				&buf[HDMI_INFOFRAME_HEADER_SIZE],
-				HDMI_AVI_INFOFRAME_SIZE);
-	if (ret)
-		goto unlock;
+		/* Write new AVI infoframe packet */
+		ret = regmap_bulk_write(ctx->regmap, IT66121_AVIINFO_DB1_REG,
+					&buf[HDMI_INFOFRAME_HEADER_SIZE],
+					HDMI_AVI_INFOFRAME_SIZE);
+		if (ret)
+			goto unlock;
 
-	if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
-		goto unlock;
+		if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
+			goto unlock;
 
-	/* Enable AVI infoframe */
-	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
-			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
-		goto unlock;
+		/* Enable AVI infoframe */
+		if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
+				 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
+			goto unlock;
 
-	/* Set TX mode to HDMI */
-	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
-		goto unlock;
+		/* Set TX mode to HDMI */
+		if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG,
+				 IT66121_HDMI_MODE_HDMI))
+			goto unlock;
+	} else {
+		/* Disable AVI infoframe */
+		if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG, 0))
+			goto unlock;
+
+		/* Set TX mode to DVI */
+		if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG,
+				 IT66121_HDMI_MODE_DVI))
+			goto unlock;
+	}
 
 	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&
 	    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
-- 
2.54.0

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

