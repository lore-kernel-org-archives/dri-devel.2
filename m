Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B0606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=lrxvTVJR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6EE10E19B;
	Sun, 22 Nov 2026 15:31:40 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D24910E19B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:31:18 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so26242835e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795361477; x=1795966277;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZnhWv3l+dqyN3BQpMNy75OxVQgBrIMMsSz+2s8ZLM8=;
 b=lrxvTVJR5uXfcayyaqCgVVRdxHye/jTW/capvokLkKM4dIEvFeYqCljf4HsDxGFltS
 MONBM2uDjEPXOUhtn9HssG6g3zl1tuFzvw2L6jCguDo4dj4fJmPQkocHR0OwklDzWRXH
 Kql+6IteVtqbqUkiF9w/RI+tZKzoH8G7Gta5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795361477; x=1795966277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eZnhWv3l+dqyN3BQpMNy75OxVQgBrIMMsSz+2s8ZLM8=;
 b=oGsZmWQDQdQXvtsivhF2wptNl/OA/1gJfiaL44qBoAR3zZiYsulPmEzDhkrdOCwCU3
 4Yy4L9GwfNXQb7/zdxUVD0CldlzCYjPLmLb6gMjXsHskzuzJm/kG3tcXruB5pKYGv2oT
 13S06Ofy/t1oG8EVsbIAbvqp9SWQBtp7JKHzX0iCwAPMK9OqipVaIPDo2GXA5O4qyZxm
 xsuLy1mfPsUNe1fZDBgearY8499D6+2JWp3Dwj2aPjT4fYYJsTIpmp1Yj0CJnYO+B/pr
 abKi0jAoBbQUz9punHBG2PUdNX7FB7cd1NDnFOrKAqNzPTWgL7/MARZJwUapJ1Ud0GeN
 PzBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGMlpXbi2Mf2RpvKns5BTjmo6j01g8ifU8xVslG7Lo4yew4e5RlfldUvn07HbmmJ57ToRZTa88sExc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8qAZoI1aHhIKwiVn//jbkhK+7N6mX9mlyLFg0f8eAuQuRHIxyu
 atZAZOKS9hGFabiOdyeyX0uN+Vn2aiu5Q9cmJaryG3zhb1xrb33alcVinQr1Mj4WVXc=
X-Gm-Gg: AZFdTZfBU0VdezczNswt3mYwe2ARIUqQBfiyOhsbvyQLOjcdbpRTLJhHfW4VJf73XDN
 uHUqK4q2c39+XS6x3k4bDIMh3wPeJ+JnRABTAP0YnQ4TPF/WYw4yJCY7xcjGAzRJTMvMSiLkvcC
 ubpChS3NwtLXmX6DvjOIsraP3hNPEA58MaTHaG7dtv4HOQJo+n9416afvW/YAmz3uOsv+kzVepF
 bbR5wUWdqQCCHERfzajgG2dieBmVQZhZ6FDv/VO3/7lUw14njO0NUPqmCPpGaCYx6Bzv0vHWHwu
 wyOzArNHQWs1HurZUzCUiDjQxVJdB+xNFe9g5fYpP2eatIqnoKX3Dy35EX4i+1f86Tavd0570Lc
 xXcwUJsSqFgB8fW2aMLKWVWoi6uzHUyoErPW9bx8XtF8v+rIWE/ZWO5fgpsVKJobA78ZSh8cMdG
 0Woq543WpiHqFoVz7GMspSAptexQMqQHPreC1OSHM/8f4j3lS6KxLyaszhxHXkhGJAbhJe6X7hd
 YjHFyQ9FQrsWuZjc6Ma6we/ok2agqLHv1PMDAr5fZ9dwfOMNP+ACRhZd4ucG1BGkniZTG+58VgP
 Ica7nWoq9F7y/hsRaEsD8SSt/AMijIFocxJgu9hErdofmrhqkf9nZW+6W33s0wPV3mVi07ccw3x
 uT5uDVweptH2Q1j5dT+8vOffmrcMZjnPwiAcGFanMBLcfrCiUn5LR3T8ffwvrsawExLQ6Kxb46h
 zeHwNJyyB0fSGUddx8W4oXBemWGw==
X-Received: by 2002:a05:600d:600b:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4bb887fb6e7mr193017785e9.6.1795361476916; 
 Sun, 22 Nov 2026 07:31:16 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm237833815e9.9.2026.11.22.07.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 07:31:16 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/8] drm/bridge: samsung-dsim: Implement hw state readout
Date: Sun, 22 Nov 2026 16:30:07 +0100
Message-ID: <20261122153032.2782768-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
References: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Read out the state of the bridge from the hardware, so that a video
stream left running by the bootloader is taken over without
initializing the bridge again.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/bridge/samsung-dsim.c | 125 +++++++++++++++++++++++---
 1 file changed, 112 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 480e568dd2c9..2eba8f482d0c 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -20,11 +20,15 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/units.h>
 
 #include <video/mipi_display.h>
 
 #include <drm/bridge/samsung-dsim.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_print.h>
 
 /* returns true iff both arguments logically differs */
@@ -1562,6 +1566,17 @@ static int samsung_dsim_transfer(struct samsung_dsim *dsi,
 	return xfer->result;
 }
 
+static void samsung_dsim_unmask_irqs(struct samsung_dsim *dsi)
+{
+	unsigned long mask = ~(DSIM_INT_RX_DONE |
+			       DSIM_INT_SFR_FIFO_EMPTY |
+			       DSIM_INT_SFR_HDR_FIFO_EMPTY |
+			       DSIM_INT_RX_ECC_ERR |
+			       DSIM_INT_SW_RST_RELEASE);
+
+	samsung_dsim_write(dsi, DSIM_INTMSK_REG, mask);
+}
+
 static irqreturn_t samsung_dsim_irq(int irq, void *dev_id)
 {
 	struct samsung_dsim *dsi = dev_id;
@@ -1578,12 +1593,7 @@ static irqreturn_t samsung_dsim_irq(int irq, void *dev_id)
 	samsung_dsim_write(dsi, DSIM_INTSRC_REG, status);
 
 	if (status & DSIM_INT_SW_RST_RELEASE) {
-		unsigned long mask = ~(DSIM_INT_RX_DONE |
-				       DSIM_INT_SFR_FIFO_EMPTY |
-				       DSIM_INT_SFR_HDR_FIFO_EMPTY |
-				       DSIM_INT_RX_ECC_ERR |
-				       DSIM_INT_SW_RST_RELEASE);
-		samsung_dsim_write(dsi, DSIM_INTMSK_REG, mask);
+		samsung_dsim_unmask_irqs(dsi);
 		complete(&dsi->completed);
 		return IRQ_HANDLED;
 	}
@@ -1758,14 +1768,9 @@ samsung_dsim_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
-static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
-				     struct drm_bridge_state *bridge_state,
-				     struct drm_crtc_state *crtc_state,
-				     struct drm_connector_state *conn_state)
+static void samsung_dsim_fixup_mode(struct samsung_dsim *dsi,
+				    struct drm_display_mode *adjusted_mode)
 {
-	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
-	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
-
 	/*
 	 * The i.MX8M Mini/Nano glue logic between LCDIF and DSIM
 	 * inverts HS/VS/DE sync signals polarity, therefore, while
@@ -1808,6 +1813,16 @@ static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
 			adjusted_mode->htotal      += remainder;
 		}
 	}
+}
+
+static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
+				     struct drm_bridge_state *bridge_state,
+				     struct drm_crtc_state *crtc_state,
+				     struct drm_connector_state *conn_state)
+{
+	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
+
+	samsung_dsim_fixup_mode(dsi, &crtc_state->adjusted_mode);
 
 	return 0;
 }
@@ -1831,6 +1846,87 @@ static int samsung_dsim_attach(struct drm_bridge *bridge,
 				 flags);
 }
 
+static bool samsung_dsim_hw_is_running(struct samsung_dsim *dsi)
+{
+	const struct samsung_dsim_driver_data *driver_data = dsi->driver_data;
+	u32 reg;
+
+	if (!(samsung_dsim_read(dsi, DSIM_PLLCTRL_REG) & DSIM_PLL_EN))
+		return false;
+
+	if (driver_data->has_legacy_status_reg)
+		reg = samsung_dsim_read(dsi, DSIM_STATUS_REG);
+	else
+		reg = samsung_dsim_read(dsi, DSIM_LINK_STATUS_REG);
+
+	if (!(reg & BIT(driver_data->pll_stable_bit)))
+		return false;
+
+	return samsung_dsim_read(dsi, DSIM_MDRESOL_REG) & DSIM_MAIN_STAND_BY;
+}
+
+static int samsung_dsim_readout_state(struct drm_bridge *bridge,
+				      struct drm_atomic_sro_state *state,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
+	struct drm_display_info *info = &conn_state->connector->display_info;
+	u32 format = MEDIA_BUS_FMT_FIXED;
+	bool running;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dsi->dev);
+	if (ret < 0)
+		return ret;
+
+	running = samsung_dsim_hw_is_running(dsi);
+	pm_runtime_put(dsi->dev);
+
+	/* The pipeline is active but the video stream is not */
+	if (!running)
+		return -EINVAL;
+
+	/* Rebuild the bus configuration the atomic helpers negotiate */
+	if (info->num_bus_formats)
+		format = info->bus_formats[0];
+
+	bridge_state->output_bus_cfg.format = format;
+	bridge_state->output_bus_cfg.flags = info->bus_flags;
+
+	if (!samsung_dsim_pixel_output_fmt_supported(format))
+		format = MEDIA_BUS_FMT_RGB888_1X24;
+
+	bridge_state->input_bus_cfg.format = format;
+	bridge_state->input_bus_cfg.flags = info->bus_flags;
+
+	/* The mode fixups done in atomic_check can't be read back */
+	samsung_dsim_fixup_mode(dsi, &crtc_state->adjusted_mode);
+
+	return 0;
+}
+
+static void samsung_dsim_install_state(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state)
+{
+	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
+
+	/* Take the reference samsung_dsim_atomic_pre_enable() would have */
+	if (pm_runtime_resume_and_get(dsi->dev) < 0) {
+		dev_err(dsi->dev, "failed to enable DSI device.\n");
+		return;
+	}
+
+	samsung_dsim_write(dsi, DSIM_INTSRC_REG,
+			   samsung_dsim_read(dsi, DSIM_INTSRC_REG));
+	samsung_dsim_unmask_irqs(dsi);
+	samsung_dsim_enable_irq(dsi);
+
+	dsi->state |= DSIM_STATE_ENABLED | DSIM_STATE_INITIALIZED |
+		      DSIM_STATE_VIDOUT_AVAILABLE;
+}
+
 static const struct drm_bridge_funcs samsung_dsim_bridge_funcs = {
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
@@ -1843,6 +1939,9 @@ static const struct drm_bridge_funcs samsung_dsim_bridge_funcs = {
 	.atomic_post_disable		= samsung_dsim_atomic_post_disable,
 	.mode_set			= samsung_dsim_mode_set,
 	.attach				= samsung_dsim_attach,
+	.atomic_sro_readout_state	= samsung_dsim_readout_state,
+	.atomic_sro_install_state	= samsung_dsim_install_state,
+	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 
 static irqreturn_t samsung_dsim_te_irq_handler(int irq, void *dev_id)
-- 
2.43.0

