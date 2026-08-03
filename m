Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC35CC55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F070E10E56F;
	Mon,  3 Aug 2026 09:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jZvLtmYs";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9DAB10E56F
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:47:23 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cea3004256so33666755ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785750443; x=1786355243;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+uaSlkxw7D25A2k1gsmS8bB5Do1RfHAQ7p/SppP4f5w=;
 b=jZvLtmYsU1c60isSqRWsNkKQoSw7HVb6G5zR3PUL2/laIZxG8chFNruE1ReymDfDxJ
 3Fapz4snDdd852AUDeuqqTd82t87vwCvA3wJ/GhUUB75Jn89KdPqtwv1oRhFsna6tygr
 FQJ2YTxsnnobaGhosw4H45vWPDgke887nueDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785750443; x=1786355243;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+uaSlkxw7D25A2k1gsmS8bB5Do1RfHAQ7p/SppP4f5w=;
 b=Zz5tFn3NxosgZxIUtoy4fqMvO+juNn1njzQKMWZgqkKibUiNWxgh/iY3KkC9WAIDlt
 gvntz0qqDmcmv+1O9SGTVhmF4ZhtiLRAoFy0rXA1ukkrT9GGJmG1G/UMp+ZNqeCq0Bfm
 gzHbMKBFtmzDgUYtKV4qhmKzMR2yhR3qeVZx3+mswJLaOxWYieVKiqGrfaq7oQ3dKM1m
 u9N5W/MIrTKo8CKuHbV9HUNNhjcp0164IvRzvxQaetdySlf47d/FfGbo2Pwpej6zRYqr
 Ei7jnqMjtfcYSOFCNuA3bVs0OV8cQmT78FYh7c8NoQcHMubp6MqhYNZGcprOi/6rTnBM
 tXTg==
X-Gm-Message-State: AOJu0YxPY3cSzikfbntCBzPi2+W1bOgKZLtecVXKRXl+F+W7U4HmDLZp
 YP4O66beodX20v2TGET+BLpLLGaT6DYkWnwl8JEqKu/k/l1WeShQcHeyBOnCupzQgg==
X-Gm-Gg: AR+sD12Wum4mpi4jszUHU2YWCV+fNDL1JtR/HOm3aoD4tO/ro1nTPYelXGefbIyI+dm
 2916SpQy9QLCVu5YSEKOw1WfUWWfxqhjq7udUmt6qupX0cWVK5d7fhespxl9D35F4n2MrWoyTuq
 dtb9L2lmkTQTaWJvZU6kOIgvXc08sihD5BK+qsXZvLfgrj7i/ZHchcut3pPwnwIXZAeFx5bbIwX
 v/vPclP74xkhBlthLLlWxKCCp6iPdJboppcc8Y/cTqbfbABm7i7X25K0AJMFOxiIbodXNybxw+c
 MgA5HXJloSaihv21h5pqee/3jnO84s6ulquQGsSzQdx4BhqbWQTcpToP1oqiayHJr7jNM3INFTP
 SACDgPWxWUAhWZi/891df/0OlAOprJq3NAhByTwKy6drse/xtupH42mi2nf1jqEKe1no9/d2qD0
 HZlriyO+hhRBZUOn/MGUjW7H5B+CEUb7Xf2iC0xzYTtYKoa6VavTk4XvpTRfS1hQ1tQA1apdp3r
 LUnMEu9tjLWOsfX3IvYzVZvJGipZlKB1uQ7Rg/vG2MMgrS2g7qfO7fe25veY8o=
X-Received: by 2002:a17:902:ce8b:b0:2ce:9b49:d4a0 with SMTP id
 d9443c01a7336-2d0524939c7mr94361625ad.35.1785750443164; 
 Mon, 03 Aug 2026 02:47:23 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com
 ([2a00:79e0:201d:8:2f3d:2ef6:d653:f82c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b0eb598sm35102885ad.51.2026.08.03.02.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 02:47:22 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 03 Aug 2026 17:47:19 +0800
Subject: [PATCH] drm/panel-edp: Add pre_unprepare delay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-edp-v1-1-3e92dec1d56c@chromium.org>
X-B4-Tracking: v=1; b=H4sIAKZjcGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwNj3dSUAl3TRAsDkzQLS/MUAyMloMqCotS0zAqwKdGxtbUAPi+QvFU
 AAAA=
X-Change-ID: 20260803-edp-5a804f897d02
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.14.3
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

In eDP power-off timing specifications, T10 defines the minimum delay
required between the end of valid video data from the source and panel
power-down (main VDD off).

Currently, panel-edp only supports the 'disable' delay, which corresponds
to T9 (backlight off to end of video data) and runs in panel_edp_disable()
while video data is still active. For panels that require a delay after
video data has stopped before cutting power, this delay must occur in
panel_edp_unprepare() before turning off power rails.

Add a 'pre_unprepare' field to struct panel_delay to model T10-min, and
delay for this duration in panel_edp_unprepare() before calling
pm_runtime_put_sync_suspend().

Additionally, adjust the timing entry for TM156VDXP25 to use
delay_200_500_e80_pu100 (enable = 80ms, pre_unprepare = 100ms) to match
its panel specification, replacing the previous delay_200_500_e50_d100.

Fixes: b9e2d5cdaab0 ("drm/panel-edp: Support NV140FHM-N5B and TM156VDXP25")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Change-Id: I3361bdf4d3289c773f0c2b77163e427b774797d5
---
 drivers/gpu/drm/panel/panel-edp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 98bdcf352701..f6624191f97c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -144,6 +144,16 @@ struct panel_delay {
 	 */
 	unsigned int disable;
 
+	/**
+	 * @pre_unprepare: Time for the end of video data to power off.
+	 *
+	 * The time (in milliseconds) that it needs to have passed between
+	 * the end of valid video data from source and start powering off.
+	 *
+	 * This is T10-min on eDP timing diagrams. It is not common to set.
+	 */
+	unsigned int pre_unprepare;
+
 	/**
 	 * @unprepare: Time to power down completely.
 	 *
@@ -413,8 +423,12 @@ static int panel_edp_suspend(struct device *dev)
 
 static int panel_edp_unprepare(struct drm_panel *panel)
 {
+	struct panel_edp *p = to_panel_edp(panel);
 	int ret;
 
+	if (p->desc->delay.pre_unprepare)
+		msleep(p->desc->delay.pre_unprepare);
+
 	ret = pm_runtime_put_sync_suspend(panel->dev);
 	if (ret < 0)
 		return ret;
@@ -1810,6 +1824,13 @@ static const struct panel_delay delay_80_500_e80_p2e200 = {
 	.prepare_to_enable = 200,
 };
 
+static const struct panel_delay delay_200_500_e80_pu100 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 80,
+	.pre_unprepare = 100,
+};
+
 static const struct panel_delay delay_100_500_e200 = {
 	.hpd_absent = 100,
 	.unprepare = 500,
@@ -2181,7 +2202,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "TM140VDXP01-04"),
 	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "TL140VDMS03-01"),
-	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e50_d100, "TM156VDXP25"),
+	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e80_pu100, "TM156VDXP25"),
 
 	{ /* sentinal */ }
 };

---
base-commit: bc47d5937f21c5fc94504f03e18f1adb56d97634
change-id: 20260803-edp-5a804f897d02

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>

