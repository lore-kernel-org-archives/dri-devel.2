Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC516CD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0076910F49F;
	Fri, 15 May 2026 09:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aAylhUWL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8535D10F49F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778835810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MCG+fM5A/Si4GdqqrKoi0Lqzyly0wOM9ZpNecCUS1U=;
 b=aAylhUWLLuPJnxVmnyQDf55eLIkNBey+oDdo702Qoa3sPZO0xrNC8TAMCUn1iupj4a1vVh
 IsRrWhORxnZ0whEXsETo9er1hI2ZGJoEd0Ar43z4qkrDUotHor9Gmcc4nLYBoH3os1dqAR
 QDSDyaFLxsln5saJuZ+iGaz3v8U9LSk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-OpPHEICAN9-x1lEL9VfxfQ-1; Fri, 15 May 2026 05:03:27 -0400
X-MC-Unique: OpPHEICAN9-x1lEL9VfxfQ-1
X-Mimecast-MFC-AGG-ID: OpPHEICAN9-x1lEL9VfxfQ_1778835806
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45b7ff2140eso3383389f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778835806; x=1779440606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5MCG+fM5A/Si4GdqqrKoi0Lqzyly0wOM9ZpNecCUS1U=;
 b=RGbf1susVGCMe3f4/0jfkQO+/XwlKKYBTHd6kMVRmWAOnAxSR+NWkpGciWzj9otCAl
 N33+ndOlrrKwd3VQDPZOaAduD9qjtrccpCZg5T64r0Xhy6FQ2ab3cGWIflOKYRWu4g7j
 oB+N18nvOiK4GHDQJFDvjk2euijYlkP4yoGaZA2jgZK/QDkvTPf38lUii2kpNRl8DWPA
 LPKkqh8zJ2cGcTUzNb+7/u2T0dIsZImTAXOGFyiCnbhT5c4xBkXD39mYGnVi9uks3lEX
 l1WBbnbJkisHEmri0mFYCFyFSTCp3eg1yK9x7UM1wRMAPAFwnXJdHdakV64WhUf3KPsy
 TSlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PpgFE/jWV7YdHntP2sRhKrUrFVaolY/0IhK68hKWJeuUpYNAsMetGsA/VmyDFUsw7reodqyQwQ8s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7tO+a4lTzSJsBeHUffjW5LgJyS9NK+ydsR0bz1OHN+jQfOD63
 jYpZdGO0fcBOf/MDwXstvSGolPM3SvDQyZww96ynKFohC+rOp1qDU8l7y8zVEzvBGzMW6om5v7D
 Ipj0oZj8ITvCeA62yfqFNJM0jUgZuMoDhJVFMpfl1KTIPYlcz2efss+DDPuCHxEwiENwlcg==
X-Gm-Gg: Acq92OEMUdgErDzPx+WiWg7Ib5Yn0BWx7YO1A1uNZxWAX1aXkqZPX6NhPPvAiA+mrU7
 7XzOnCiOpIDcv/kSGR7MWbSPuo6vicMtawFmhNRj23o7Y/qleL99wujITmL2OD6O6/IMFkOZXT8
 o2zy8mNBh3wK13Eqav84D3QDQCdufykIz0QD/XT0gbqLN+/zPVth5rq6SyveHzRkAleeCYxoTqQ
 smcdzZVj14zYEDMxF0uB7LVcmEDtN2t+86WEGKVcoKE0Yc1Y8YMpzb424di6u4g6R2ZIA9lK4S8
 q1e4LR/5G3waoF5xMB5Ozdm20HUhtWoGSSFXjD3j4l5BCVsznu/2ovgXxdwJg4uMQDpmM2nRbPT
 AST/o7uURggVQXe5MHbjMSo9M+1xNyO2jA9dNs1kfsSgz2ts=
X-Received: by 2002:a05:600c:c096:b0:48f:d1b8:9aad with SMTP id
 5b1f17b1804b1-48fe5fd5357mr29232965e9.2.1778835805753; 
 Fri, 15 May 2026 02:03:25 -0700 (PDT)
X-Received: by 2002:a05:600c:c096:b0:48f:d1b8:9aad with SMTP id
 5b1f17b1804b1-48fe5fd5357mr29232435e9.2.1778835805183; 
 Fri, 15 May 2026 02:03:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fead18659sm10952375e9.7.2026.05.15.02.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 02:03:24 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v4 2/3] drm/bridge: ite-it66121: Move logic .mode_set setup to
 .atomic_enable
Date: Fri, 15 May 2026 11:02:10 +0200
Message-ID: <20260515090220.809830-3-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515090220.809830-1-javierm@redhat.com>
References: <20260515090220.809830-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IvdZYt_aXmr_s8qHLegQJBugbdbGIl8xDOAU0oaMd_A_1778835806
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

Move the existing .mode_set logic to the .atomic_enable callback. The
former is deprecated and drivers are supposed to use the latter instead.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v4:
- New patch for v4

 drivers/gpu/drm/bridge/ite-it66121.c | 79 +++++++++++++++-------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 947b7a0f0a45..c8795247cfa8 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -654,6 +654,47 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
 	return 0;
 }
 
+static void it66121_set_mode(struct it66121_ctx *ctx,
+			     struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector = ctx->connector;
+	const struct drm_crtc_state *crtc_state;
+	const struct drm_display_mode *mode;
+	struct drm_crtc *crtc;
+
+	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	mode = &crtc_state->adjusted_mode;
+
+	mutex_lock(&ctx->lock);
+
+	/* Set TX mode to HDMI */
+	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
+		goto unlock;
+
+	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&
+	    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
+			      IT66121_CLK_BANK_PWROFF_TXCLK,
+			      IT66121_CLK_BANK_PWROFF_TXCLK)) {
+		goto unlock;
+	}
+
+	if (it66121_configure_input(ctx))
+		goto unlock;
+
+	if (it66121_configure_afe(ctx, mode))
+		goto unlock;
+
+	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&
+	    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
+			      IT66121_CLK_BANK_PWROFF_TXCLK, 0)) {
+		goto unlock;
+	}
+
+unlock:
+	mutex_unlock(&ctx->lock);
+}
+
 static int it66121_set_mute(struct it66121_ctx *ctx, bool mute)
 {
 	int ret;
@@ -733,6 +774,7 @@ static void it66121_bridge_enable(struct drm_bridge *bridge,
 
 	drm_atomic_helper_connector_hdmi_update_infoframes(ctx->connector, state);
 
+	it66121_set_mode(ctx, state);
 	it66121_set_mute(ctx, false);
 }
 
@@ -764,42 +806,6 @@ static int it66121_bridge_check(struct drm_bridge *bridge,
 	return 0;
 }
 
-static
-void it66121_bridge_mode_set(struct drm_bridge *bridge,
-			     const struct drm_display_mode *mode,
-			     const struct drm_display_mode *adjusted_mode)
-{
-	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
-
-	mutex_lock(&ctx->lock);
-
-	/* Set TX mode to HDMI */
-	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
-		goto unlock;
-
-	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&
-	    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
-			      IT66121_CLK_BANK_PWROFF_TXCLK,
-			      IT66121_CLK_BANK_PWROFF_TXCLK)) {
-		goto unlock;
-	}
-
-	if (it66121_configure_input(ctx))
-		goto unlock;
-
-	if (it66121_configure_afe(ctx, adjusted_mode))
-		goto unlock;
-
-	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&
-	    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
-			      IT66121_CLK_BANK_PWROFF_TXCLK, 0)) {
-		goto unlock;
-	}
-
-unlock:
-	mutex_unlock(&ctx->lock);
-}
-
 static enum drm_connector_status
 it66121_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
 {
@@ -935,7 +941,6 @@ static const struct drm_bridge_funcs it66121_bridge_funcs = {
 	.atomic_enable = it66121_bridge_enable,
 	.atomic_disable = it66121_bridge_disable,
 	.atomic_check = it66121_bridge_check,
-	.mode_set = it66121_bridge_mode_set,
 	.detect = it66121_bridge_detect,
 	.edid_read = it66121_bridge_edid_read,
 	.hpd_enable = it66121_bridge_hpd_enable,
-- 
2.54.0

