Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A62BC55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C43710F17F;
	Fri, 31 Jul 2026 06:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eD0XHA8X";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C7110E139
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 00:11:40 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-81e9f7491ffso6539347b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785456699; x=1786061499; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0X7N1rP90nQg4clD2xUsUJGcghWiLSs6t/EHWysAEeA=;
 b=eD0XHA8X8mZiD0KDlbIglxZn2DMsug3F+IxJDu3NA+n3XfWDgB635K+UFyCpKrKOe7
 q3ZnfgNgG4kpD4s//054tXjjM9yosyXmW4VJ41bIehWP/U6tJyPqf0lpGnRF5PTfStiP
 B/CYhEKs14mRrmQUpuJ+jOHdynarMIwBxtw+TYP1J9v/Jn9HzsKyeETeM0iJjYnYe/EE
 z1cvi6Loy6ahGFYIokkQ4n2rCpwcNLumUULd2G4/NdbsVeAhpBFKsfDSAT7jFOW2S5GP
 zjvONJOBT6V/n97Cc2jXGYCPvtt5P4x3tnWCU+fHAR+CHzhqzRoi8nnyulHoq/iU9u+a
 NtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456699; x=1786061499;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0X7N1rP90nQg4clD2xUsUJGcghWiLSs6t/EHWysAEeA=;
 b=s16EvpOMg8kpD91IUkXnU+aWeYZwXPo2mBFkoPba8LbBANA4hxuve6261BuSx9nf87
 Iuru4ZWEmtV+PTDrkpfmgkU0YOm5gwCfuZBsSGZuzp3fqi1ECIZkIVC5IhE2mIPhpC52
 hhZ0QXLXxzhHaXbVjEjiPBaeDOtAemIEHUHpEl4usCumROYbcD54RlWs2IsqtCxU+aEn
 TV+ESTog9TGajxJ60lD/i7gjTDDdBYcMFidCHmt5YUOP8h4YZKPLG0UMJx/E1QgOyLYb
 r8Ig2N3PaXTbM+E5GnCTDVZgc0+4yjILUleyrrlPlTPDwlGKIQdh9YwznfHuy1HjGNuX
 cVDw==
X-Gm-Message-State: AOJu0Yx7s3XgBFGnhvMFCHPeXJ6wjBBhOgxAFgR2Xm5wtpY9zj7kE0gv
 gG1CnneqO7+I+IUuHSEpxKbSjv0d0+nsehBOQe+iigzo+I+fKWVdbJnaicSSLDNI
X-Gm-Gg: AR+sD11fDNlhxVzIxEPUhKzf779B7oGRcNA9iAUsewoXZGpXWCozw8OJnxDK/in/+2S
 thMET57eug2vE1mqlIlYlzyUCknonOsT+iz40q132+UgUiBr7fXDxV5nDh4IA0Kpx3TEFyy//8/
 NuZkfr1OXVFLp7kA9VjzTEEBQIuaDVweqdqqbDlDoAWehB+lIq3SA8qApysHqNWAiCGhlKKoC5i
 HUwM0It4MWGFzv9k4sWpfdML7nDJwX5xiE8rqeFxs0svTjs2HiMos/OsmTSQd0QWo4uGu1LEEbI
 rzAGngqUttINUcRdaMgIupHG7G70VOs7b9sQR74+2px3HuuE8oXUQoOLmu8ukVbztPOrHWM+j7H
 YKcnZxLRE7cp+3di1ExgUMGrdhFVVlUEtErtYV7iYOISCsQSb0t6WSbMMdBbA1NVws7Pxbe7xmy
 Q2lGymkQap32RnfeaEuDpaxCV07SN1uwylcciEpDueuXY+ieurxlF/4o3bz5LWUs81mYAB251Zm
 FDy
X-Received: by 2002:a05:690c:4d84:b0:81e:97c9:bcf7 with SMTP id
 00721157ae682-81fb8b06e85mr36813767b3.71.1785456699054; 
 Thu, 30 Jul 2026 17:11:39 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fb88c4a92sm19292357b3.7.2026.07.30.17.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:11:38 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Thu, 30 Jul 2026 19:11:31 -0500
Subject: [PATCH v3] drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi(); fix
 minor bugs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-mipi-dsi-tl070wsh30-multi-v3-1-60592caef4f4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6DIBCF4asY1qWBoYJ01Xs0XaigTiLVgKVtj
 HcvmjRx5fJ/yXwzk2A92kCu2Uy8jRhweKYQp4zUXflsLUWTmgADyRQAdTgiNQHp1DPF3qETjLp
 XPyEFpnPQ2uQVB5LuR28b/Gz2/ZG6wzAN/ru9inxd/2p+oEZOOZWaS1YVQhdgb60rsT/XgyOrG
 mEvqSMJktRcVKWFkoIbsZeWZfkBR+EHmgwBAAA=
X-Change-ID: 20260722-mipi-dsi-tl070wsh30-multi-2095299d5b12
To: Doug Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Akash Sukhavasi <akash.sukhavasi@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:54:16 +0000
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

The mipi_dsi_dcs_*() functions used by this driver are deprecated in
favor of their _multi() counterparts, as noted in
Documentation/gpu/todo.rst. The _multi() variants record the first
error in a context structure and skip every later call once an error
is set, so the return value no longer has to be checked after each
command. They also log their own failures, which makes the per-call
dev_err() calls redundant.

Convert prepare() and unprepare(). prepare() uses mipi_dsi_msleep()
for the delays between DSI commands. unprepare() uses plain
usleep_range() so the delays run unconditionally after the
accumulated error is cleared. The delays in the GPIO reset sequence
stay as plain msleep() and usleep_range(), since they run before any
DSI transaction.

unprepare() now disables the regulator unconditionally and returns 0.
Previously a failure of set_display_off() was logged and the sequence
continued, while a failure of enter_sleep_mode() returned early,
leaving the regulator enabled and the panel unable to be brought back
up, since drm_panel_unprepare() skips panel->prepared = false on
error. The accumulated error from set_display_off() is cleared so
that the delay and enter_sleep_mode() are still attempted, preserving
the original fall-through behavior. Both drm_panel_prepare() and
drm_panel_unprepare() return void, so the error was never propagated
to a caller in any case.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Changes in v3:
- Update subject line to reflect the minor bugfixes, per Doug's review.
- Pack blank lines in both functions per Doug's review.
- Preserve the original fall-through behavior in unprepare(): clear
  accum_err after set_display_off() so the delay and enter_sleep_mode()
  are still attempted even if display off fails.
- Link to v2: https://lore.kernel.org/r/20260727-mipi-dsi-tl070wsh30-multi-v2-1-f47b937631d3@gmail.com

Compile tested only, no hardware available. checkpatch and a W=1 build
are clean.

Changes in v2:
- unprepare() disables the regulator unconditionally and returns 0,
  per Sashiko's review on v1. Returning an error left panel->prepared
  set, so the panel could not be prepared again.
- Link to v1: https://lore.kernel.org/r/20260725-mipi-dsi-tl070wsh30-multi-v1-1-69160b83982e@gmail.com
---
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 40 +++++++++-------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 13cfe252a838..fa961abdd2d7 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -35,6 +35,7 @@ struct tdo_tl070wsh30_panel *to_tdo_tl070wsh30_panel(struct drm_panel *panel)
 static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 {
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = tdo_tl070wsh30->link };
 	int err;
 
 	err = regulator_enable(tdo_tl070wsh30->supply);
@@ -51,44 +52,27 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 
 	msleep(200);
 
-	err = mipi_dsi_dcs_exit_sleep_mode(tdo_tl070wsh30->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		regulator_disable(tdo_tl070wsh30->supply);
-		return err;
-	}
-
-	msleep(200);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 200);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
 
-	err = mipi_dsi_dcs_set_display_on(tdo_tl070wsh30->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
+	if (dsi_ctx.accum_err)
 		regulator_disable(tdo_tl070wsh30->supply);
-		return err;
-	}
-
-	msleep(20);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
 {
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
-	int err;
-
-	err = mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
-	if (err < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", err);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = tdo_tl070wsh30->link };
 
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	/* Reset error to continue power-down sequence even if display off failed */
+	dsi_ctx.accum_err = 0;
 	usleep_range(10000, 11000);
-
-	err = mipi_dsi_dcs_enter_sleep_mode(tdo_tl070wsh30->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
-		return err;
-	}
-
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 	usleep_range(10000, 11000);
 
 	regulator_disable(tdo_tl070wsh30->supply);

---
base-commit: e05b559f9cda350d0ab33c44a8c1151ca62d2875
change-id: 20260722-mipi-dsi-tl070wsh30-multi-2095299d5b12

Best regards,
-- 
Akash Sukhavasi <akash.sukhavasi@gmail.com>

