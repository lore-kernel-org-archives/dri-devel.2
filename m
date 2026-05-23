Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387FDCD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 10:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FEA10E2D7;
	Sat, 23 May 2026 10:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dECT3WYy";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A350810E2D7
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779532897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1jgoVOyXWjGHzsv5K/BVa074MnLk4iyZS4E4IEHpwE=;
 b=dECT3WYyUZR2EqAikeiOIu85ALkQRVvS9x/OsSORgWdGMqjrHRp/SnxAH7I/mU86W2A2ct
 eExcOMpH+/TTvDCAnyvCTJZjOhqqGNTnzyxSOddSpr+EgDvSf1aTnZl9lsBsJ/rormkLeW
 lfSw5J8MT/zSwUfY/vymjorcN66kh1U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-2N7bbq_TNe-QPKabcCcgwQ-1; Sat, 23 May 2026 06:41:35 -0400
X-MC-Unique: 2N7bbq_TNe-QPKabcCcgwQ-1
X-Mimecast-MFC-AGG-ID: 2N7bbq_TNe-QPKabcCcgwQ_1779532894
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44a71109b94so5804881f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779532894; x=1780137694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y1jgoVOyXWjGHzsv5K/BVa074MnLk4iyZS4E4IEHpwE=;
 b=aeV7pwWqEc9+pod+YdjLQ+daeKBdIv4nLxOLVdD2jKTR1Djb5ALrjNIF49HpUyKYW7
 cxJJskOY0MrNQttvlWaW3hySv6LUUJJSeEGhKDId+nnHcnspMfQAlvJZNy4USPRLoH1b
 c+4EbIOyPBuFyJYhMWqofqsAgVbsAMr2OICWKap+ybEobzCIVlLhsiqCYZnb10VYKhE6
 IyCN7qcwiTPLrvv+za2OpR5wGea7G6gKLJ4NTaifRWHMuZvQDYOpjwcZy/aK10yUCcKC
 bZRF3Uhd9TiaJIbXS6taCpwDZLFORy61sAEPpZK2LGmNoTW/r8My2sDqznLNvnKohtvM
 M8Wg==
X-Gm-Message-State: AOJu0Yx1ugw4NXKGPb5hzm+e68u6POPmlF8DCGS/PWnelFbAZExLKnZS
 L5eKh4yAjY7/yrjtKFD0XponDu5K2yjiX5b4rdqPx35TkcXR1oaL/1L636MFt0uau1RESMEPSsm
 8T6A8BgMKi295Zjwxiw4SUTgGGuHqwPErNUdckBGzZ3LzJHGibM23j0aiVcEfoolEnqyEdg==
X-Gm-Gg: Acq92OHLdHOgtsxshue4nMuHOZYvsslnQOpiU7HivBuY1GWl47Pigd12KJzeGA0l6kf
 lYTo7dqM7N11qPV/gVCpp6fCytgGaMeVoEOHTgLhonysjH5lCLkDsQq7HPT/9lL01U0fTQkFenh
 TWiWlCYWvHqZu0Ca4A5LTCZp0eI81S6Hwnt9RqXl5UEjuPY4oO0jNwwum7PkuBT1JXZzUqHUIQ1
 Z1IWmpXhxNd/rd7IMjAQsmuDRhIhqasr9m8e96oQDG/VmtetDahXIbtcCM1VPQqhWJUdqp9VN4A
 4w/tIdmd9esaOaE/cCNYAyIsaoxOa1hRyXIG3OFnh8FoV/izEq9R1GmRW1wEXn6RhVlEpKdvSDl
 B3zYpCVjm1PMhG1Y=
X-Received: by 2002:a05:6000:1848:b0:45e:73eb:2a75 with SMTP id
 ffacd0b85a97d-45eb367fb1amr11734533f8f.16.1779532894376; 
 Sat, 23 May 2026 03:41:34 -0700 (PDT)
X-Received: by 2002:a05:6000:1848:b0:45e:73eb:2a75 with SMTP id
 ffacd0b85a97d-45eb367fb1amr11734484f8f.16.1779532893896; 
 Sat, 23 May 2026 03:41:33 -0700 (PDT)
Received: from localhost ([90.167.87.79]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4850dsm10599026f8f.17.2026.05.23.03.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 03:41:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Sat, 23 May 2026 12:40:59 +0200
Subject: [PATCH v5 2/3] drm/bridge: ite-it66121: Move .mode_set logic to
 .atomic_enable
MIME-Version: 1.0
Message-Id: <20260523-it66121-fix-dvi-mode-v5-v5-2-33b4468162f9@redhat.com>
References: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
In-Reply-To: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Phong LE <ple@baylibre.com>, Sen Wang <sen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5239; i=javierm@redhat.com;
 h=from:subject:message-id; bh=XyrKmaSXTZhXeDUIJhAtHdxc6vXOmzSmWs6u5h9cwSs=;
 b=owEBbQKS/ZANAwAKAcdR5ZDWPz1pAcsmYgBqEYRSrEvCEBSa0/3iFf2TDdS7fRsgrNzgGQX0z
 McqwJYDFZGJAjMEAAEKAB0WIQTXXteqJOUM1kXG9FfHUeWQ1j89aQUCahGEUgAKCRDHUeWQ1j89
 aeTKEACltpfqio3QIDCwv34mRASuoQdj7LrGdOcwxGzGA3xt5eoOx+Nuz9iFW7EBsIJh8vyLRFc
 8DwGK+mVYhxjENeHmgSWOvWayRPESLDTidqkyrQ0/b8LqmRnrTYYjXNeoKlFYUCXzw4tFCIiu+Z
 hPh8quQ5TuWCQ4kIBu2GhcnFG6n9SEAqUi3aJ/SeTzFREsc8WBf3wsVa5T9w0f7fiYXyeXiJGl8
 CIXKJ8KCHETm26iZAHcT6l70OCH4lpwVTjGd9uE5EVvsj4qHa4EfhMh4AlHiop/snrwEwaRolOi
 mFdtLo7wbnr/8PKBa4eSi1qgQJdFG/ci+hGkCr2/PFnpqbXakD9mDYGolZlOauvLR0ImMY93Tiy
 SFlPlzy9r8JdPz2ECcs9QIgvS4DVNrwae9hJoU09Peltf6s7TOE9knXzRFcQjWbPsrP8TT26VMO
 78WL79yJiqX8sg+pf1/yRWQvnPX+cmlBSOTt+4NkHfErdytRg6zoqe7632DMiRkb+O/qiRBzLiq
 XZqXaKGd1JwXBf7YhA3yFWuRrlrYWex0806snm2PhuRN+ZmImeIcs+P0O2Yb1ptW6QbtqGMPttm
 FlG9Nvh8DPeLNtHRT+E9ZuROS4kaNmWM8YKRggi3ISRCOh1eAZIeqSO8SnnZmAcc98gayWBhEx3
 wf1VDXyTJoQQ2RA==
X-Developer-Key: i=javierm@redhat.com; a=openpgp;
 fpr=D75ED7AA24E50CD645C6F457C751E590D63F3D69
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g0yW2xYl6TRjMgI7GlOYtonZYEzjpC2iWpiAkkIdo_s_1779532894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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

Move the existing .mode_set logic to the .atomic_enable callback. The
former is deprecated and drivers are supposed to use the latter instead.

Also, drop the struct it66121_ctx.connector field because the connector
can be accessed through the atomic state and there is no need to store
it anymore.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 100 ++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index f41f51f300c9..9725e5db5db3 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -315,7 +315,6 @@ struct it66121_chip_info {
 struct it66121_ctx {
 	struct regmap *regmap;
 	struct drm_bridge bridge;
-	struct drm_connector *connector;
 	struct device *dev;
 	struct gpio_desc *gpio_reset;
 	struct i2c_client *client;
@@ -668,6 +667,58 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
 	return 0;
 }
 
+static void it66121_set_mode(struct it66121_ctx *ctx,
+			     struct drm_connector *connector,
+			     struct drm_atomic_commit *state)
+{
+	const struct drm_connector_state *conn_state;
+	const struct drm_crtc_state *crtc_state;
+	const struct drm_display_mode *mode;
+	struct drm_crtc *crtc;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (WARN_ON(!conn_state))
+		return;
+
+	crtc = conn_state->crtc;
+	if (WARN_ON(!crtc))
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	if (WARN_ON(!crtc_state))
+		return;
+
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
@@ -740,13 +791,15 @@ static void it66121_bridge_enable(struct drm_bridge *bridge,
 				  struct drm_atomic_commit *state)
 {
 	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct drm_connector *connector;
 
-	ctx->connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
-	if (WARN_ON(!ctx->connector))
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	if (WARN_ON(!connector))
 		return;
 
-	drm_atomic_helper_connector_hdmi_update_infoframes(ctx->connector, state);
+	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
 
+	it66121_set_mode(ctx, connector, state);
 	it66121_set_mute(ctx, false);
 }
 
@@ -756,8 +809,6 @@ static void it66121_bridge_disable(struct drm_bridge *bridge,
 	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
 
 	it66121_set_mute(ctx, true);
-
-	ctx->connector = NULL;
 }
 
 static int it66121_bridge_check(struct drm_bridge *bridge,
@@ -778,42 +829,6 @@ static int it66121_bridge_check(struct drm_bridge *bridge,
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
@@ -1532,7 +1547,6 @@ static const struct drm_bridge_funcs it66121_bridge_funcs = {
 	.atomic_enable = it66121_bridge_enable,
 	.atomic_disable = it66121_bridge_disable,
 	.atomic_check = it66121_bridge_check,
-	.mode_set = it66121_bridge_mode_set,
 	.detect = it66121_bridge_detect,
 	.edid_read = it66121_bridge_edid_read,
 	.hpd_enable = it66121_bridge_hpd_enable,

-- 
2.54.0

