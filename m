Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C8ACDE004
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021A810EDBA;
	Wed, 24 Jun 2026 07:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kRME59Qb";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716A810E36C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:57:00 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso2582345e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782244619; x=1782849419; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4SE983frRONKkL2Y26EQuPfdn0q+Vah4vb8+iLKxBmw=;
 b=kRME59QbfLluDAeh84ls12yDnoViqeJCDH5tcOkQzSD6VBIkYd8CwIkezWUi9BxbM2
 eNX/Oue39VuhD2kiSopJusla4qjX9As2DSvWfyoN1j/HNqikiyTXyq0gZEMkqDTgDdim
 PhJZH5clvm7NHWlph9Y8I/R4KCfaBfOiahGoQZkOz+9ollgi+ycYQbbXR/slN3+j6Mtd
 T9g286ln62q3kVrZ0p7lIy3yPXFA8WR2CDDPxvqP7LPF+uH+x2xJZDm64kzMEZBb5uHD
 1fR+nfeHTDJLtO9KCr30yRVLWJP/zzr8sOTid+LHW6GdP85QcsP3Eyk+OQM1ncC2fSBA
 4y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782244619; x=1782849419;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4SE983frRONKkL2Y26EQuPfdn0q+Vah4vb8+iLKxBmw=;
 b=RgfUzAoGbZYWMuzrWmt1av0r0TTNZwKuqgTVIcMLf++ShMsLpYYHpwTrAyKL2xuMYY
 ZBeeEx8mEiE1hWd7k2gDJg2PjNbTN7hsSclgvlkVqbtlMjgcZQOxnoP/zqyukQk6uDrX
 EfH6zZz9XQCkaFdRaejMJWJb9itIrhfwP2FqasCdjhkPkxpseGIJr108qOe6dEqw7InI
 wcA3Q1JIWkvURrm7rY8wwgnPuom+Hqx6LYEcwgOTrsBhdU4k9eMmPTFAt/275StxHZ/z
 KY1nd6kLB7Ri4cFaIekcp9SibwFLrUZHfh9PognDTnrSAid3dCw1s+MJlBfs7eqsMWTw
 k66A==
X-Gm-Message-State: AOJu0Yyae4EthFie6tba97VcVw7MORSvwuFsshBSkXSl/DYzSnxly5pK
 F89saZGEXPaovVXDDx/ViQyB1W+F27ujyDTSHT3eRpQNkeRTehExX/tz
X-Gm-Gg: AfdE7cnuJvlzpmLnW2EP0AGiEdRre1sszCSyvsalec2Q0CNjoZY7CZpWOfdIowVjlw7
 rmDwf0w2TUlNYqOUr6oxT8yBJDAd+ALCJEb3/1QCHWd9RlT/fEb+BUkulXKHyCvya/Pgf7LbVyF
 THAsZGmq5MmHVSLZae9xAvYWYQX4g/8QugBIw2NvMoPOlryjuLR31Ljq/7fMYhTKQzQhT/A+NbE
 IxriZv+9SRG3hqgmaUrEUQsuu5OsltbV4kpiY3E4ROEOYadkDIFnt8OIZmELGsgqfOd0KtCbqh5
 GSACVNK07Akz9zjmvekMi/hVKu5UGtJbKiWjFvmAuf065tb469PlfoanmmNabUrKK+dDaHhUjB3
 TIP0ZkYi7OB37GsftT0IRKseyW+jCiy1AYWfg5eXtqndRV23dAfmAzr6M3nzZtfTJ1GFEPGgB/t
 Oub03Ee0YAdmFDZ2NuN0Xi
X-Received: by 2002:a05:600c:3113:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-492490a790cmr228856425e9.22.1782244618723; 
 Tue, 23 Jun 2026 12:56:58 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd154fdsm372903405e9.1.2026.06.23.12.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:56:58 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 23 Jun 2026 21:56:48 +0200
Subject: [PATCH] drm/gma500: cdv_intel_dp: fix indentation to use tabs
 instead of spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-cdv_intel_dp_indentation-v1-1-bcb61da38f17@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP/kOmoC/x2MQQqAIBAAvxJ7TigrD30lItTdaiEsVCKQ/t7Sb
 eYwUyBRZEowVgUi3Zz4DCJtXYHfbdhIMYqDbrRpjO6Ux3vhkOlY8BJACtlmiZSzvh+w76zzDiS
 /Iq38/Otpft8Pv8OFTGoAAAA=
X-Change-ID: 20260623-cdv_intel_dp_indentation-bac45d43abcb
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

The kernel coding style specifies that tabs should be used instead of
spaces, which the cdv_intel_dp driver was not using in some places.
This patch replaces the space indentations with tabs.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 111 +++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index fbed35cf7603..7d08011d9663 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -232,16 +232,17 @@ i2c_dp_aux_add_bus(struct i2c_adapter *adapter)
 }
 
 #define _wait_for(COND, MS, W) ({ \
-        unsigned long timeout__ = jiffies + msecs_to_jiffies(MS);       \
-        int ret__ = 0;                                                  \
-        while (! (COND)) {                                              \
-                if (time_after(jiffies, timeout__)) {                   \
-                        ret__ = -ETIMEDOUT;                             \
-                        break;                                          \
-                }                                                       \
-                if (W && !in_dbg_master()) msleep(W);                   \
-        }                                                               \
-        ret__;                                                          \
+	unsigned long timeout__ = jiffies + msecs_to_jiffies(MS);       \
+	int ret__ = 0;                                                  \
+	while (!(COND)) {                                               \
+		if (time_after(jiffies, timeout__)) {                   \
+			ret__ = -ETIMEDOUT;                             \
+			break;                                          \
+		}                                                       \
+		if (W && !in_dbg_master())                              \
+			msleep(W);                                      \
+	}                                                               \
+	ret__;                                                          \
 })
 
 #define wait_for(COND, MS) _wait_for(COND, MS, 1)
@@ -296,10 +297,10 @@ static struct ddi_regoff ddi_DP_train_table[] = {
 };
 
 static uint32_t dp_vswing_premph_table[] = {
-        0x55338954,	0x4000,
-        0x554d8954,	0x2000,
-        0x55668954,	0,
-        0x559ac0d4,	0x6000,
+	0x55338954,	0x4000,
+	0x554d8954,	0x2000,
+	0x55668954,	0,
+	0x559ac0d4,	0x6000,
 };
 /**
  * is_edp - is the given port attached to an eDP panel (either CPU or PCH)
@@ -1141,7 +1142,7 @@ static void cdv_intel_dp_prepare(struct drm_encoder *encoder)
 		cdv_intel_edp_backlight_off(intel_encoder);
 		cdv_intel_edp_panel_off(intel_encoder);
 		cdv_intel_edp_panel_vdd_on(intel_encoder);
-        }
+	}
 	/* Wake up the sink first */
 	cdv_intel_dp_sink_dpms(intel_encoder, DRM_MODE_DPMS_ON);
 	cdv_intel_dp_link_down(intel_encoder);
@@ -1183,7 +1184,7 @@ cdv_intel_dp_dpms(struct drm_encoder *encoder, int mode)
 			cdv_intel_edp_panel_off(intel_encoder);
 		}
 	} else {
-        	if (edp)
+		if (edp)
 			cdv_intel_edp_panel_on(intel_encoder);
 		cdv_intel_dp_sink_dpms(intel_encoder, mode);
 		if (!(dp_reg & DP_PORT_EN)) {
@@ -1191,7 +1192,7 @@ cdv_intel_dp_dpms(struct drm_encoder *encoder, int mode)
 			cdv_intel_dp_complete_link_train(intel_encoder);
 		}
 		if (edp)
-        		cdv_intel_edp_backlight_on(intel_encoder);
+			cdv_intel_edp_backlight_on(intel_encoder);
 	}
 }
 
@@ -1419,8 +1420,8 @@ cdv_intel_dp_set_vswing_premph(struct gma_encoder *encoder, uint8_t signal_level
 	DRM_DEBUG_KMS("Test2\n");
 	//return ;
 	cdv_sb_reset(dev);
-	/* ;Swing voltage programming
-        ;gfx_dpio_set_reg(0xc058, 0x0505313A) */
+	/* ;Swing voltage programming */
+	/* ;gfx_dpio_set_reg(0xc058, 0x0505313A) */
 	cdv_sb_write(dev, ddi_reg->VSwing5, 0x0505313A);
 
 	/* ;gfx_dpio_set_reg(0x8154, 0x43406055) */
@@ -1575,7 +1576,7 @@ cdv_intel_dp_complete_link_train(struct gma_encoder *encoder)
 				intel_dp->train_set[0],
 				intel_dp->link_configuration[0],
 				intel_dp->link_configuration[1]);
-        	/* channel eq pattern */
+		/* channel eq pattern */
 
 		if (!cdv_intel_dp_set_link_train(encoder, reg,
 					     DP_TRAINING_PATTERN_2)) {
@@ -1704,7 +1705,7 @@ cdv_intel_dp_detect(struct drm_connector *connector, bool force)
 		if (edp)
 			cdv_intel_edp_panel_vdd_off(encoder);
 		return status;
-        }
+	}
 
 	if (intel_dp->force_audio) {
 		intel_dp->has_audio = intel_dp->force_audio > 0;
@@ -1956,12 +1957,12 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 	gma_encoder = kzalloc_obj(struct gma_encoder);
 	if (!gma_encoder)
 		return;
-        gma_connector = kzalloc_obj(struct gma_connector);
-        if (!gma_connector)
-                goto err_connector;
+	gma_connector = kzalloc_obj(struct gma_connector);
+	if (!gma_connector)
+		goto err_connector;
 	intel_dp = kzalloc_obj(struct cdv_intel_dp);
 	if (!intel_dp)
-	        goto err_priv;
+		goto err_priv;
 
 	if ((output_reg == DP_C) && cdv_intel_dpc_is_edp(dev))
 		type = DRM_MODE_CONNECTOR_eDP;
@@ -1976,7 +1977,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 
 	if (type == DRM_MODE_CONNECTOR_DisplayPort)
 		gma_encoder->type = INTEL_OUTPUT_DISPLAYPORT;
-        else
+	else
 		gma_encoder->type = INTEL_OUTPUT_EDP;
 
 
@@ -2006,18 +2007,18 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 	cdv_disable_intel_clock_gating(dev);
 
 	cdv_intel_dp_i2c_init(gma_connector, gma_encoder, name);
-        /* FIXME:fail check */
+	/* FIXME:fail check */
 	cdv_intel_dp_add_properties(connector);
 
 	if (is_edp(gma_encoder)) {
 		int ret;
 		struct edp_power_seq cur;
-                u32 pp_on, pp_off, pp_div;
+		u32 pp_on, pp_off, pp_div;
 		u32 pwm_ctrl;
 
 		pp_on = REG_READ(PP_CONTROL);
 		pp_on &= ~PANEL_UNLOCK_MASK;
-	        pp_on |= PANEL_UNLOCK_REGS;
+		pp_on |= PANEL_UNLOCK_REGS;
 
 		REG_WRITE(PP_CONTROL, pp_on);
 
@@ -2025,42 +2026,42 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 		pwm_ctrl |= PWM_PIPE_B;
 		REG_WRITE(BLC_PWM_CTL2, pwm_ctrl);
 
-                pp_on = REG_READ(PP_ON_DELAYS);
-                pp_off = REG_READ(PP_OFF_DELAYS);
-                pp_div = REG_READ(PP_DIVISOR);
+		pp_on = REG_READ(PP_ON_DELAYS);
+		pp_off = REG_READ(PP_OFF_DELAYS);
+		pp_div = REG_READ(PP_DIVISOR);
 
 		/* Pull timing values out of registers */
-                cur.t1_t3 = (pp_on & PANEL_POWER_UP_DELAY_MASK) >>
-                        PANEL_POWER_UP_DELAY_SHIFT;
+		cur.t1_t3 = (pp_on & PANEL_POWER_UP_DELAY_MASK) >>
+			    PANEL_POWER_UP_DELAY_SHIFT;
 
-                cur.t8 = (pp_on & PANEL_LIGHT_ON_DELAY_MASK) >>
-                        PANEL_LIGHT_ON_DELAY_SHIFT;
+		cur.t8 = (pp_on & PANEL_LIGHT_ON_DELAY_MASK) >>
+			 PANEL_LIGHT_ON_DELAY_SHIFT;
 
-                cur.t9 = (pp_off & PANEL_LIGHT_OFF_DELAY_MASK) >>
-                        PANEL_LIGHT_OFF_DELAY_SHIFT;
+		cur.t9 = (pp_off & PANEL_LIGHT_OFF_DELAY_MASK) >>
+			 PANEL_LIGHT_OFF_DELAY_SHIFT;
 
-                cur.t10 = (pp_off & PANEL_POWER_DOWN_DELAY_MASK) >>
-                        PANEL_POWER_DOWN_DELAY_SHIFT;
+		cur.t10 = (pp_off & PANEL_POWER_DOWN_DELAY_MASK) >>
+			  PANEL_POWER_DOWN_DELAY_SHIFT;
 
-                cur.t11_t12 = ((pp_div & PANEL_POWER_CYCLE_DELAY_MASK) >>
-                               PANEL_POWER_CYCLE_DELAY_SHIFT);
+		cur.t11_t12 = ((pp_div & PANEL_POWER_CYCLE_DELAY_MASK) >>
+			      PANEL_POWER_CYCLE_DELAY_SHIFT);
 
-                DRM_DEBUG_KMS("cur t1_t3 %d t8 %d t9 %d t10 %d t11_t12 %d\n",
-                              cur.t1_t3, cur.t8, cur.t9, cur.t10, cur.t11_t12);
+		DRM_DEBUG_KMS("cur t1_t3 %d t8 %d t9 %d t10 %d t11_t12 %d\n",
+			      cur.t1_t3, cur.t8, cur.t9, cur.t10, cur.t11_t12);
 
 
 		intel_dp->panel_power_up_delay = cur.t1_t3 / 10;
-                intel_dp->backlight_on_delay = cur.t8 / 10;
-                intel_dp->backlight_off_delay = cur.t9 / 10;
-                intel_dp->panel_power_down_delay = cur.t10 / 10;
-                intel_dp->panel_power_cycle_delay = (cur.t11_t12 - 1) * 100;
+		intel_dp->backlight_on_delay = cur.t8 / 10;
+		intel_dp->backlight_off_delay = cur.t9 / 10;
+		intel_dp->panel_power_down_delay = cur.t10 / 10;
+		intel_dp->panel_power_cycle_delay = (cur.t11_t12 - 1) * 100;
 
-                DRM_DEBUG_KMS("panel power up delay %d, power down delay %d, power cycle delay %d\n",
-                              intel_dp->panel_power_up_delay, intel_dp->panel_power_down_delay,
-                              intel_dp->panel_power_cycle_delay);
+		DRM_DEBUG_KMS("panel power up delay %d, power down delay %d, power cycle delay %d\n",
+			      intel_dp->panel_power_up_delay, intel_dp->panel_power_down_delay,
+			      intel_dp->panel_power_cycle_delay);
 
-                DRM_DEBUG_KMS("backlight on delay %d, off delay %d\n",
-                              intel_dp->backlight_on_delay, intel_dp->backlight_off_delay);
+		DRM_DEBUG_KMS("backlight on delay %d, off delay %d\n",
+			      intel_dp->backlight_on_delay, intel_dp->backlight_off_delay);
 
 
 		cdv_intel_edp_panel_vdd_on(gma_encoder);
@@ -2075,7 +2076,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 			cdv_intel_dp_destroy(connector);
 			goto err_connector;
 		} else {
-        		DRM_DEBUG_KMS("DPCD: Rev=%x LN_Rate=%x LN_CNT=%x LN_DOWNSP=%x\n",
+			DRM_DEBUG_KMS("DPCD: Rev=%x LN_Rate=%x LN_CNT=%x LN_DOWNSP=%x\n",
 				intel_dp->dpcd[0], intel_dp->dpcd[1],
 				intel_dp->dpcd[2], intel_dp->dpcd[3]);
 
@@ -2083,7 +2084,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 		/* The CDV reference driver moves pnale backlight setup into the displays that
 		   have a backlight: this is a good idea and one we should probably adopt, however
 		   we need to migrate all the drivers before we can do that */
-                /*cdv_intel_panel_setup_backlight(dev); */
+		/*cdv_intel_panel_setup_backlight(dev); */
 	}
 	return;
 

---
base-commit: e2a6e04d045a56c6dc61e1eb9e2a6d7cf86512cd
change-id: 20260623-cdv_intel_dp_indentation-bac45d43abcb

Best regards,
-- 
Diogo Silva <diogompaissilva@gmail.com>

