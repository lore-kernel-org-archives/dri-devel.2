Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847D4CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 19:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C6110E1D1;
	Sun, 10 May 2026 19:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DppxifVz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB6D10E1D1
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778440535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2HWKQFo0Wy5+aYZ6lPgr+vjevQgXgZHh6o51C0aBUU=;
 b=DppxifVzoKxRveLoFSxRubXh7XNzdL6J2u7HhT8K/w5Tjf0X9mV/STwBSjU98QlAwZE/YT
 oSEyinS3SrPSnGSsjrgmbIQmL6u/RnW6MAE+oGy+54JcbYzRbR1kOHQI+qLt9blg0d0ZOB
 dO9ZbrACowtnUF2qod73/tpPFyR7Sgw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-70eFJNnaM2CJKvJk4APacA-1; Sun, 10 May 2026 15:15:34 -0400
X-MC-Unique: 70eFJNnaM2CJKvJk4APacA-1
X-Mimecast-MFC-AGG-ID: 70eFJNnaM2CJKvJk4APacA_1778440533
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48e60b55de2so30811535e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 12:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778440533; x=1779045333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D2HWKQFo0Wy5+aYZ6lPgr+vjevQgXgZHh6o51C0aBUU=;
 b=tLvQB1cw0Iev5uJZOrBGX/Dn45wz3PGHJ0r55nssa+G784abewFSFp17ImcsY6WrP1
 FFlq+x9u5GmXZXiHLYbuY1Mv5jCcdUd9lpsdFQ72SCkyuxFzlPH40kfHVWhj2MQxqXL2
 hlr9Jttuxm/49lF9X5fleqdi3Ww7iY707KxjudM42UAc7Rrp5JFqCq6pB+7z6ErbwwV6
 XrXUCboQnHc89kqzGq2MDQ/aVkw78uJPL8Is0jgiTtdWqhEsO8tLxWdSngox2QOZhnQv
 KsnEqIYAltZ/DxaPsd0N0Gwcn6U08Nyb4UoUfKCsdyOZFGEAl77BTe72bgxBNbUpucKa
 ur7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+qGyZ5fYJ1V6CapIrQjamYA0cS28188V8ocRNWLwj9WZqCtHbOswIX38JYCao2HSWWGahrnu2Ews=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQL4uK71zjV28thm59dcg0CHU3Xt/noO3SQgvyEEeEkbtzP8U7
 +cg/mLPOl4jTY1qEtsM5wtQq5i1scizAA0+4hO4WxoOYqBCVWRKhtQCnm/WwFitDj0xqE7ExqUO
 LO9A+iulglUioB/5c5k2smRzLsaI42ZIpsd80mG7ueNbH+B4doVM4EnEMnTO4ODf7U6lOpQ==
X-Gm-Gg: Acq92OELrzGfa6PQpI0RjC7PmJ/wjjzk99MKxdHiNrME72H51+hXXMgPLIKGyQINna5
 nSlU8snDun5ULCKIJ0lnxn008nTTO5aQwRgWAOskeTkGdS04sN7luTAneH2BGy0WQj9PMlP8zAg
 FQ+FmupnTZ4Ai80vQPaj9GLeFFrnKuCiudHUotAbLclDYcA74cWeN8BV2KEPsSB2yIYDoIm40pN
 RMLH0JT0qYHLsOgoVbqUsdpuB+EhlDhZYTqAfi8xa0lq26WU39coTKzemPwHQv5ByXHnxFM77ey
 Haa2PyYfONZCN60HsrnwZ6G6lfClcT/pkFuLYpyOz7Jml5lHva2JCcYR+/JVywZiXAZLj3YT8v8
 geSJw8kQ5EiJNMsRi91Xouu8jXf3DkxdONGx2lTcKqqRvSJY=
X-Received: by 2002:a05:600c:34cd:b0:48e:707f:cdfd with SMTP id
 5b1f17b1804b1-48e707fce07mr120219445e9.2.1778440533108; 
 Sun, 10 May 2026 12:15:33 -0700 (PDT)
X-Received: by 2002:a05:600c:34cd:b0:48e:707f:cdfd with SMTP id
 5b1f17b1804b1-48e707fce07mr120219265e9.2.1778440532660; 
 Sun, 10 May 2026 12:15:32 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6fffb9bdsm124059865e9.1.2026.05.10.12.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 12:15:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/bridge: it66121: Select HDMI or DVI mode based on
 sink type
Date: Sun, 10 May 2026 21:14:49 +0200
Message-ID: <20260510191459.90769-4-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510191459.90769-1-javierm@redhat.com>
References: <20260510191459.90769-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t6CA0-KeaTg-H_NLEkp6AeuV5NTTxD1xxGKpGNFHHiQ_1778440533
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Currently, the driver assumes that the connector sink type is always HDMI
and configures the IT66121 bridge appropriately. But configuring in this
mode and enabling the transmission of AVI infoframe packets can cause DVI
monitors to fail parsing the video signal.

To prevent this, store the connector display information sink type in the
bridge atomic state and use it to decide whether the bridge should be set
in HDMI or DVI mode, and if the AVI infoframes packets should be sent.

Assisted-by: Cursor:claude-4.6-opus
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/bridge/ite-it66121.c | 68 ++++++++++++++++++----------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index a203c94a27e5..99088277d170 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -322,6 +322,7 @@ static inline struct it66121_ctx *bridge_to_it66121_ctx(struct drm_bridge *bridg
 
 struct it66121_bridge_state {
 	struct drm_bridge_state base;
+	bool sink_is_hdmi;
 };
 
 static inline struct it66121_bridge_state *
@@ -790,6 +791,14 @@ static int it66121_bridge_check(struct drm_bridge *bridge,
 				struct drm_connector_state *conn_state)
 {
 	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
+	struct it66121_bridge_state *state =
+		to_it66121_bridge_state(bridge_state);
+
+	/* Default to HDMI to preserve legacy behavior. */
+	state->sink_is_hdmi = true;
+
+	if (conn_state && conn_state->connector)
+		state->sink_is_hdmi = conn_state->connector->display_info.is_hdmi;
 
 	if (ctx->id == ID_IT6610) {
 		/* The IT6610 only supports these settings */
@@ -809,40 +818,51 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
 {
 	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
 	struct it66121_ctx *ctx = bridge_to_it66121_ctx(bridge);
+	struct drm_bridge_state *bridge_state =
+		drm_priv_to_bridge_state(bridge->base.state);
+	struct it66121_bridge_state *state =
+		to_it66121_bridge_state(bridge_state);
+	unsigned int hdmi_mode = state->sink_is_hdmi ?
+		IT66121_HDMI_MODE_HDMI : 0;
+	unsigned int avi_pkt = 0;
 	int ret;
 
 	mutex_lock(&ctx->lock);
 
-	ret = drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infoframe, ctx->connector,
-						       adjusted_mode);
-	if (ret) {
-		DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
-		goto unlock;
-	}
+	if (hdmi_mode) {
+		ret = drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infoframe,
+							       ctx->connector,
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
+
+		avi_pkt = IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT;
+	}
 
-	/* Enable AVI infoframe */
-	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
-			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
+	/* Enable or disable AVI infoframe */
+	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG, avi_pkt))
 		goto unlock;
 
-	/* Set TX mode to HDMI */
-	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
+	/* Set TX mode to HDMI or DVI */
+	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, hdmi_mode))
 		goto unlock;
 
 	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&
-- 
2.54.0

