Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8E8C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F0810EE64;
	Tue, 14 Jul 2026 21:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pwW33CHP";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1F010EE64
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:16:08 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so2669501f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784063767; x=1784668567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bz9kHIGdnWOPLJJAKqHaqyiFFf2vvIYbS2hXbNMvzaM=;
 b=pwW33CHPJE1+Vg+MvchuEpxsZbgdNwn7UP+AJutBB+EgqljZFB/46l30o/+tymWbv6
 jWNf0mfQpEvl6czjw+hXlBYc2Kvmcu0xa+Tce2NtmVtajQaYcWH9G+KqbRIWnqBQn6uT
 uS8XyYsRDqjSfuRIwY+JQKmPtbtabrDT/gpHrdxLrSMukS8hnkXXTBMGFJcf55fcBBQn
 qVexHrdtTe6kSxT/ThSPGU6RrIGUVDxXv9hT1b2NOUDqK3j6dtiAVsFp1NCjF1c+bNo5
 g42DXEM7LXqdR7pl5aRdJtKJvEPtFxEvT9GYBuj/VBzC18/RaWY0+2/dnc6JtWgrM73Y
 I2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784063767; x=1784668567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bz9kHIGdnWOPLJJAKqHaqyiFFf2vvIYbS2hXbNMvzaM=;
 b=MlcIvEM46tJEoIT1VCfOzuVYiJBuZ8zOiEBjWrONVkkXIoWOXDeJ/Aj7jQ7ieh4Fvh
 MQtWohQ7voUZG2QI2t9yHVZ63x8Db2GzCoBkHcTm2omAVVTtNnEjOt3tnDBubp7FYC9S
 ftmOS1nK4PlzQ2Q+vAW4WqfBKGdIaPWSEw8e1WAFl1K1Y3L8tvavoq/byTuUhKMtXkPi
 yQ1fDl/gqWH9VVsq+CInU8n1LDqp0+m/kUW3IHhhkLMSxsTwsn7cGZyanHteZfPGV+Cr
 FR73o/dsy/KfF2kd4B1pQXABwo0FAKGr3/3RIfU6vi+B/7R2DqmcWw9UWwwHp/0q/tt3
 Mfdw==
X-Gm-Message-State: AOJu0Yxd69BE61SE0w81DxprS1wDmFtcyg12YKElnooRvtKJo+UGkYDk
 /aS8wIq0guhzSzIIQWO67sFAALk8zO8KCOcWEf8XkgEDjtxH20k4pcGB
X-Gm-Gg: AfdE7cmGX8gQNjKY5GxFb7QxnKqM+HvIIdFeIAR4k3W4rT+dH4XdMtXp/iRjOCaTQ2C
 D0HT+e6SrPy+aVZtViOdp41puSutxlGW05nHZZiKOoDUanSUbvK51VBf3qVLXxP5NgTr3zDuo5z
 /zE4rtu9fL2wRQ9CxIdGXLam1Fa3aPK9JsW+hTP8QlKWwl3N2jh1bSQX/3Qz7B6WvIWy/RPrk7a
 ll4M7TQ1VwneWYjWtdZA6PROqTkSCzVbWXoaR+2nszaB820no26jrO/7p/nckNvP4IuZoo5WJIj
 YZepPvnb5dT10xvI3jq/tlqrQ+70VyQHtirC+8bQgR7qUBGq56lpywirk/30n7mlL53yIhAcptc
 H3mSFeD0LY9FQIRCwBNahkDOYzuAlhE3Qv5+5Ahkc8PW8E4Ocv0A4EJt9a1H6rFg32PjyHYa+ua
 ssiPxaXOk781MfKv7xVdzf
X-Received: by 2002:a05:600d:6454:10b0:493:f764:1f69 with SMTP id
 5b1f17b1804b1-49538992d06mr33976505e9.8.1784063766675; 
 Tue, 14 Jul 2026 14:16:06 -0700 (PDT)
Received: from fedora ([94.205.182.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32a2casm149843875e9.12.2026.07.14.14.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:16:05 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 Milos Tijanic <mtijanic@nvidia.com>, nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH 3/6] drm/nouveau: add GSP hwmon support
Date: Wed, 15 Jul 2026 01:14:26 +0400
Message-ID: <20260714211429.238355-4-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
MIME-Version: 1.0
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

GSP boards currently register no hwmon device at all, so every Turing
through Blackwell user has been running without any temperature or power
readout. Wire the RUSD telemetry up as the first one:

  temp1_input/_label   "gpu"    temperatures[GPU]
  temp2_input/_label   "vram"   temperatures[HBM], HBM boards only
  power1_input/average "gpu"    inst/avg GPU power
  power1_cap                    enforced power limit (read-only)
  power2_input/average "board"  module power, where supported
  power3_average       "vram"   memory rail average, where supported
  update_interval               the programmed RUSD poll interval

All channels are standard hwmon ABI, per-channel visibility is decided
at registration time from live section validity, since support varies
per SKU at runtime. If nothing becomes valid, no hwmon device is
registered, matching today's behaviour on GSP boards.

The legacy therm/volt/iccsense paths are untouched and the new
channels and attributes are gated on RUSD, so pre-GSP boards see no
change.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_hwmon.c | 375 +++++++++++++++++++-----
 1 file changed, 294 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index 726397ab035d..d449431d4a40 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -25,6 +25,8 @@
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #endif
+#include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/power_supply.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -32,6 +34,7 @@
 #include "nouveau_drv.h"
 #include "nouveau_hwmon.h"
 
+#include <nvkm/subdev/gsp.h>
 #include <nvkm/subdev/iccsense.h>
 #include <nvkm/subdev/volt.h>
 
@@ -215,10 +218,11 @@ static const struct hwmon_channel_info * const nouveau_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT |
+			   HWMON_T_INPUT | HWMON_T_LABEL |
 			   HWMON_T_MAX | HWMON_T_MAX_HYST |
 			   HWMON_T_CRIT | HWMON_T_CRIT_HYST |
-			   HWMON_T_EMERGENCY | HWMON_T_EMERGENCY_HYST),
+			   HWMON_T_EMERGENCY | HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT),
 	HWMON_CHANNEL_INFO(in,
@@ -228,7 +232,10 @@ static const struct hwmon_channel_info * const nouveau_info[] = {
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
 	HWMON_CHANNEL_INFO(power,
-			   HWMON_P_INPUT | HWMON_P_CAP_MAX | HWMON_P_CRIT),
+			   HWMON_P_INPUT | HWMON_P_MAX | HWMON_P_CRIT |
+			   HWMON_P_AVERAGE | HWMON_P_CAP | HWMON_P_LABEL,
+			   HWMON_P_INPUT | HWMON_P_AVERAGE | HWMON_P_LABEL,
+			   HWMON_P_AVERAGE | HWMON_P_LABEL),
 	NULL
 };
 
@@ -243,52 +250,144 @@ nouveau_chip_is_visible(const void *data, u32 attr, int channel)
 	}
 }
 
-static umode_t
-nouveau_power_is_visible(const void *data, u32 attr, int channel)
+static bool
+nouveau_rusd_ok(struct nvkm_gsp *gsp, enum nvkm_gsp_rusd_item item)
 {
-	struct nouveau_drm *drm = nouveau_drm((struct drm_device *)data);
-	struct nvkm_iccsense *iccsense = nvxx_iccsense(drm);
+	int retries = 3;
+	s64 val;
+	int ret;
 
-	if (!iccsense || !iccsense->data_valid || list_empty(&iccsense->rails))
-		return 0;
+	/* Visibility decisions are made only once at registration. So retry
+	 * to avoid letting racing a GSP write window (-EAGAIN) hide a channel
+	 * for good.
+	 */
+	do {
+		ret = nvkm_gsp_rusd_read(gsp, item, &val);
+		if (ret != -EAGAIN)
+			break;
+		usleep_range(100, 200);
+	} while (--retries);
+
+	return ret == 0;
+}
 
+static umode_t
+nouveau_rusd_power_is_visible(struct nvkm_gsp *gsp, u32 attr, int channel)
+{
 	switch (attr) {
 	case hwmon_power_input:
-		return 0444;
-	case hwmon_power_max:
-		if (iccsense->power_w_max)
+		if (channel == 0 && nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_GPU))
+			return 0444;
+		if (channel == 1 && nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_BOARD))
+			return 0444;
+		return 0;
+	case hwmon_power_average:
+		if (channel == 0 && nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_GPU_AVG))
+			return 0444;
+		if (channel == 1 && nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_BOARD_AVG))
+			return 0444;
+		if (channel == 2 && nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_VRAM_AVG))
 			return 0444;
 		return 0;
-	case hwmon_power_crit:
-		if (iccsense->power_w_crit)
+	case hwmon_power_cap:
+		/* The enforced limit is only telemetry here. Setting it needs ctrls nouveau
+		 * doesn't implement.
+		 */
+		if (channel == 0 && nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_CAP))
 			return 0444;
 		return 0;
+	case hwmon_power_label:
+		switch (channel) {
+		case 0:
+			if (nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_GPU) ||
+			    nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_GPU_AVG) ||
+			    nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_CAP))
+				return 0444;
+			break;
+		case 1:
+			if (nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_BOARD) ||
+			    nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_BOARD_AVG))
+				return 0444;
+			break;
+		case 2:
+			if (nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_VRAM_AVG))
+				return 0444;
+			break;
+		}
+		return 0;
 	default:
 		return 0;
 	}
 }
 
 static umode_t
-nouveau_temp_is_visible(const void *data, u32 attr, int channel)
+nouveau_power_is_visible(const void *data, u32 attr, int channel)
 {
 	struct nouveau_drm *drm = nouveau_drm((struct drm_device *)data);
-	struct nvkm_therm *therm = nvxx_therm(drm);
+	struct nvkm_iccsense *iccsense = nvxx_iccsense(drm);
+	struct nvkm_device *device = drm->nvkm;
+	struct nvkm_gsp *gsp = device->gsp;
 
-	if (!therm || !therm->attr_get || nvkm_therm_temp_get(therm) < 0)
-		return 0;
+	if (nvkm_gsp_rusd(gsp))
+		return nouveau_rusd_power_is_visible(gsp, attr, channel);
+	else {
+		if (!iccsense || !iccsense->data_valid || list_empty(&iccsense->rails))
+			return 0;
 
-	switch (attr) {
-	case hwmon_temp_input:
-		return 0444;
-	case hwmon_temp_max:
-	case hwmon_temp_max_hyst:
-	case hwmon_temp_crit:
-	case hwmon_temp_crit_hyst:
-	case hwmon_temp_emergency:
-	case hwmon_temp_emergency_hyst:
-		return 0644;
-	default:
-		return 0;
+		switch (attr) {
+		case hwmon_power_input:
+			return 0444;
+		case hwmon_power_max:
+			if (iccsense->power_w_max)
+				return 0444;
+			return 0;
+		case hwmon_power_crit:
+			if (iccsense->power_w_crit)
+				return 0444;
+			return 0;
+		default:
+			return 0;
+		}
+	}
+}
+
+static umode_t
+nouveau_temp_is_visible(const void *data, u32 attr, int channel)
+{
+	struct nouveau_drm *drm = nouveau_drm((struct drm_device *)data);
+	struct nvkm_therm *therm = nvxx_therm(drm);
+	struct nvkm_device *device = drm->nvkm;
+	struct nvkm_gsp *gsp = device->gsp;
+
+	if (nvkm_gsp_rusd(gsp)) {
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_label:
+			if (nouveau_rusd_ok(gsp, channel ? NVKM_GSP_RUSD_TEMP_HBM :
+							   NVKM_GSP_RUSD_TEMP_GPU))
+				return 0444;
+			return 0;
+		default:
+			/* No threshold data in the RUSD buffer. */
+			return 0;
+		}
+	} else {
+		if (!therm || !therm->attr_get || nvkm_therm_temp_get(therm) < 0)
+			return 0;
+
+		switch (attr) {
+		case hwmon_temp_input:
+			return 0444;
+		case hwmon_temp_max:
+		case hwmon_temp_max_hyst:
+		case hwmon_temp_crit:
+		case hwmon_temp_crit_hyst:
+		case hwmon_temp_emergency:
+		case hwmon_temp_emergency_hyst:
+			return 0644;
+		default:
+			return 0;
+		}
 	}
 }
 
@@ -351,9 +450,13 @@ nouveau_fan_is_visible(const void *data, u32 attr, int channel)
 static int
 nouveau_chip_read(struct device *dev, u32 attr, int channel, long *val)
 {
+	struct nouveau_drm *drm = nouveau_drm(dev_get_drvdata(dev));
+	struct nvkm_device *device = drm->nvkm;
+	struct nvkm_gsp *gsp = device->gsp;
+
 	switch (attr) {
 	case hwmon_chip_update_interval:
-		*val = 1000;
+		*val = nvkm_gsp_rusd(gsp) ? gsp->rusd.poll_ms : 1000;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -368,47 +471,67 @@ nouveau_temp_read(struct device *dev, u32 attr, int channel, long *val)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct nouveau_drm *drm = nouveau_drm(drm_dev);
 	struct nvkm_therm *therm = nvxx_therm(drm);
+	struct nvkm_device *device = drm->nvkm;
+	struct nvkm_gsp *gsp = device->gsp;
 	int ret;
 
-	if (!therm || !therm->attr_get)
-		return -EOPNOTSUPP;
+	if (nvkm_gsp_rusd(gsp)) {
+		s64 value;
+
+		if (attr != hwmon_temp_input)
+			return -EOPNOTSUPP;
 
-	switch (attr) {
-	case hwmon_temp_input:
 		if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
 			return -EINVAL;
-		ret = nvkm_therm_temp_get(therm);
-		*val = ret < 0 ? ret : (ret * 1000);
-		break;
-	case hwmon_temp_max:
-		*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK)
-					* 1000;
-		break;
-	case hwmon_temp_max_hyst:
-		*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK_HYST)
-					* 1000;
-		break;
-	case hwmon_temp_crit:
-		*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_CRITICAL)
-					* 1000;
-		break;
-	case hwmon_temp_crit_hyst:
-		*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_CRITICAL_HYST)
-					* 1000;
-		break;
-	case hwmon_temp_emergency:
-		*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_SHUTDOWN)
-					* 1000;
-		break;
-	case hwmon_temp_emergency_hyst:
-		*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_SHUTDOWN_HYST)
-					* 1000;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
 
-	return 0;
+		ret = nvkm_gsp_rusd_read(gsp, channel ? NVKM_GSP_RUSD_TEMP_HBM :
+							NVKM_GSP_RUSD_TEMP_GPU, &value);
+		if (ret)
+			return ret;
+
+		*val = value;
+		return 0;
+	} else {
+		if (!therm || !therm->attr_get)
+			return -EOPNOTSUPP;
+
+		switch (attr) {
+		case hwmon_temp_input:
+			if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
+				return -EINVAL;
+			ret = nvkm_therm_temp_get(therm);
+			*val = ret < 0 ? ret : (ret * 1000);
+			break;
+		case hwmon_temp_max:
+			*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK)
+						* 1000;
+			break;
+		case hwmon_temp_max_hyst:
+			*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK_HYST)
+						* 1000;
+			break;
+		case hwmon_temp_crit:
+			*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_CRITICAL)
+						* 1000;
+			break;
+		case hwmon_temp_crit_hyst:
+			*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_CRITICAL_HYST)
+						* 1000;
+			break;
+		case hwmon_temp_emergency:
+			*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_SHUTDOWN)
+						* 1000;
+			break;
+		case hwmon_temp_emergency_hyst:
+			*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_SHUTDOWN_HYST)
+						* 1000;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+		return 0;
+	}
 }
 
 static int
@@ -492,34 +615,84 @@ nouveau_pwm_read(struct device *dev, u32 attr, int channel, long *val)
 }
 
 static int
-nouveau_power_read(struct device *dev, u32 attr, int channel, long *val)
+nouveau_rusd_power_read(struct drm_device *drm_dev, struct nvkm_gsp *gsp,
+			u32 attr, int channel, long *val)
 {
-	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct nouveau_drm *drm = nouveau_drm(drm_dev);
-	struct nvkm_iccsense *iccsense = nvxx_iccsense(drm);
-
-	if (!iccsense)
-		return -EOPNOTSUPP;
+	enum nvkm_gsp_rusd_item item;
+	s64 value;
+	int ret;
 
 	switch (attr) {
 	case hwmon_power_input:
-		if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
-			return -EINVAL;
-		*val = nvkm_iccsense_read_all(iccsense);
+		if (channel == 2)
+			return -EOPNOTSUPP;
+		item = channel ? NVKM_GSP_RUSD_POWER_BOARD :
+				 NVKM_GSP_RUSD_POWER_GPU;
 		break;
-	case hwmon_power_max:
-		*val = iccsense->power_w_max;
+	case hwmon_power_average:
+		if (channel == 0)
+			item = NVKM_GSP_RUSD_POWER_GPU_AVG;
+		else if (channel == 1)
+			item = NVKM_GSP_RUSD_POWER_BOARD_AVG;
+		else
+			item = NVKM_GSP_RUSD_POWER_VRAM_AVG;
 		break;
-	case hwmon_power_crit:
-		*val = iccsense->power_w_crit;
+	case hwmon_power_cap:
+		if (channel)
+			return -EOPNOTSUPP;
+		item = NVKM_GSP_RUSD_POWER_CAP;
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
+	if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
+		return -EINVAL;
+
+	ret = nvkm_gsp_rusd_read(gsp, item, &value);
+	if (ret)
+		return ret;
+
+	*val = value;
+
 	return 0;
 }
 
+static int
+nouveau_power_read(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct nouveau_drm *drm = nouveau_drm(drm_dev);
+	struct nvkm_iccsense *iccsense = nvxx_iccsense(drm);
+	struct nvkm_device *device = drm->nvkm;
+	struct nvkm_gsp *gsp = device->gsp;
+
+	if (nvkm_gsp_rusd(gsp))
+		return nouveau_rusd_power_read(drm_dev, gsp, attr, channel, val);
+	else {
+		if (!iccsense)
+			return -EOPNOTSUPP;
+
+		switch (attr) {
+		case hwmon_power_input:
+			if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
+				return -EINVAL;
+			*val = nvkm_iccsense_read_all(iccsense);
+			break;
+		case hwmon_power_max:
+			*val = iccsense->power_w_max;
+			break;
+		case hwmon_power_crit:
+			*val = iccsense->power_w_crit;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+		return 0;
+	}
+}
+
 static int
 nouveau_temp_write(struct device *dev, u32 attr, int channel, long val)
 {
@@ -597,6 +770,8 @@ nouveau_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
 }
 
 static const char input_label[] = "GPU core";
+static const char * const nouveau_temp_labels[] = { "gpu", "vram" };
+static const char * const nouveau_power_labels[] = { "gpu", "board", "vram" };
 
 static int
 nouveau_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
@@ -607,6 +782,18 @@ nouveau_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		return 0;
 	}
 
+	if (type == hwmon_temp && attr == hwmon_temp_label &&
+	    channel < ARRAY_SIZE(nouveau_temp_labels)) {
+		*buf = nouveau_temp_labels[channel];
+		return 0;
+	}
+
+	if (type == hwmon_power && attr == hwmon_power_label &&
+	    channel < ARRAY_SIZE(nouveau_power_labels)) {
+		*buf = nouveau_power_labels[channel];
+		return 0;
+	}
+
 	return -EOPNOTSUPP;
 }
 
@@ -667,13 +854,39 @@ nouveau_hwmon_init(struct drm_device *dev)
 	struct nvkm_iccsense *iccsense = nvxx_iccsense(drm);
 	struct nvkm_therm *therm = nvxx_therm(drm);
 	struct nvkm_volt *volt = nvxx_volt(drm);
+	struct nvkm_device *device = drm->nvkm;
+	struct nvkm_gsp *gsp = device->gsp;
 	const struct attribute_group *special_groups[N_ATTR_GROUPS];
 	struct nouveau_hwmon *hwmon;
 	struct device *hwmon_dev;
+	bool rusd_active = false;
 	int ret = 0;
 	int i = 0;
 
-	if (!iccsense && !therm && !volt) {
+	if (nvkm_gsp_rusd(gsp)) {
+		/* Per-channel visibility is latched below from live RUSD
+		 * section validity, so wait for GSP-RM's first poll of both
+		 * requested groups (thermal, power). It is normally completed
+		 * long before we get here and this is a last resort.
+		 */
+		unsigned long timeout = jiffies +
+			msecs_to_jiffies(2 * gsp->rusd.poll_ms);
+		bool thermal, power;
+
+		for (;;) {
+			thermal = nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_TEMP_GPU);
+			power = nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_GPU) ||
+				nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_GPU_AVG) ||
+				nouveau_rusd_ok(gsp, NVKM_GSP_RUSD_POWER_CAP);
+			if ((thermal && power) || !time_before(jiffies, timeout))
+				break;
+			msleep(20);
+		}
+
+		rusd_active = thermal || power;
+	}
+
+	if (!iccsense && !therm && !volt && !rusd_active) {
 		NV_DEBUG(drm, "Skipping hwmon registration\n");
 		return 0;
 	}
-- 
2.55.0

