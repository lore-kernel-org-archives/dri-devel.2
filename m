Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7F5CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B17910F1A0;
	Thu, 18 Jun 2026 07:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rebhu.com header.i=shubham@rebhu.com header.b="aFKrir2v";
	dkim-atps=neutral
X-Greylist: delayed 910 seconds by postgrey-1.36 at gabe;
 Wed, 17 Jun 2026 08:13:08 UTC
Received: from sender-op-o11.zoho.in (sender-op-o11.zoho.in [103.117.158.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE9C10EEA2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781683072; cv=none; d=zohomail.in; s=zohoarc; 
 b=a4knJZIohgWs7l9AAquSJpSA8iTTuT4j+txikLUmacjAq0+cr5L3OPqoU5gTnzwVCmrbb8md0OWXrrFHy1B+Bjlf0mpZp/bFo8yAcBhRrW1PcaGZPXMWmDNorCVHXgyMhdRdM1l5hCd+mLbA7NNCMXeHuOXuyjo2U9UAEQIWtxw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1781683072;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=owJHIPigLTJg5NpDzWs2WWECxQ51TJud4b7x1ySqR1g=; 
 b=FsGQH1oWUK88d9fiymjKCqr3gkAqQ6+gg6hc3xlr7NSPGAdiY0kCEMV2lGPQOpCpBWVkRQb1XwP/hwf0sBycKifrl/57+RJJvzwYCwFYQpurT3LcCQCXJXjeIV1Ip3ur/Pp2rhZtYpSlvqlqgmi8J1+mGW0p6+CcovcPyE9KUp8=
ARC-Authentication-Results: i=1; mx.zohomail.in; dkim=pass  header.i=rebhu.com;
 spf=pass  smtp.mailfrom=shubham@rebhu.com;
 dmarc=pass header.from=<shubham@rebhu.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781683072; 
 s=zmail; d=rebhu.com; i=shubham@rebhu.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=owJHIPigLTJg5NpDzWs2WWECxQ51TJud4b7x1ySqR1g=;
 b=aFKrir2v0plhtulFPkljXIRAYVRCEbHHC8x+QUCnj7YEdq3T/vQQ6K5Hnm1Px2JS
 HK1QAlORi3u9IFpaiBS2JwEac9mrOIna8tf6qxHmydSeABHFHbubClHQQ3jGAWGHLcY
 U23ZsS8MN8tVD/QGAOYGwvDE++VzDcCQ1I9pmJtA=
Received: by mx.zoho.in with SMTPS id 1781683069725589.2124138024176;
 Wed, 17 Jun 2026 13:27:49 +0530 (IST)
From: Shubham <shubham@rebhu.com>
To: tomi.valkeinen@ideasonboard.com
Cc: robertcnelson@gmail.com, dri-devel@lists.freedesktop.org, nm@ti.com,
 vigneshr@ti.com
Subject: Re: [PATCH v3 00/15] drm/tidss: Add BeagleY-AI display support (and
 some more)
Date: Wed, 17 Jun 2026 13:27:38 +0530
Message-ID: <20260617075738.3065624-1-shubham@rebhu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 18 Jun 2026 07:12:07 +0000
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

Hi Tomi,

Robert Nelson pointed me here. I'm bringing up the Raspberry Pi Touch
Display 2 (5-inch) on a BeagleY-AI (AM67A/J722S) using your DSI work as
backported in Robert's v7.0.x-arm64-k3 tree (7.0.11-arm64-k3-r20). The
panel is a native ILI9881C MIPI-DSI panel (720x1280, 2 lanes); a Goodix
GT911 touch and the RPi "v2" control MCU both sit on the DSI-connector
i2c bus (i2c-3), and the MCU supplies the panel reset and the touch
regulator over i2c.

Relevant config: CONFIG_DRM_TIDSS=y, CONFIG_DRM_CDNS_DSI=y,
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y,
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2=y.

HDMI works. You mention testing the DSI output with the RPi 7" display
(via the TC358762 DSI->DPI bridge) using extra overlays -- would you be
able to share that 7" DSI test overlay? It would be an invaluable
reference for the DSS/DSI videoport wiring. I suspect the crux of my
problem is that the TD2 5" is a native DSI panel whose reset/power come
from an i2c MCU, so the panel has a deferred dependency that the
bridge-based 7" panel does not.

Setup
-----

The DSI-connector i2c and the MIPI mux are not enabled in the
BeagleY-AI base dtb of this image, so my overlay supplies:
  - the MIPI mux routing (gpio-hog on main_gpio0: MIPI_SWITCH_OE=high,
    MIPI_SWITCH_SEL=low, with the two pads muxed to GPIO);
  - pinctrl-0 = <&main_i2c0_pins_default>, status = "okay" and
    clock-frequency on the i2c node;
  - display_mcu@45 (raspberrypi,touchscreen-panel-regulator-v2),
    gt911@5d, the ili9881c panel@0 on dsi0 (reset-gpio via the MCU,
    power-supply), the DSS (dss1) / DSI port endpoints, and touch_reg.

With that, every device binds:

  /sys/bus/mipi-dsi/devices/30500000.dsi.0 -> ili9881c-dsi   (panel)
  /sys/bus/i2c/devices/3-0045/driver       -> rpi_touchscreen_v2 (MCU)
  Goodix-TS 3-005d: ID 911, version: 1060                    (touch)
  /sys/kernel/debug/devices_deferred       -> (empty)

Problem: tidss assembles before the DSI bridge is added
-------------------------------------------------------

  [    2.000378] [drm] Missing drm_bridge_add() before attach
  [    2.059239] tidss 30220000.dss: [drm] Registered 1 planes with drm panic
  [    2.061629] [drm] Initialized tidss 1.0.0 for 30220000.dss on minor 0
  [    2.062051] tidss 30220000.dss: [drm] Cannot find any crtc or sizes
  [    2.062628] tidss 30220000.dss: [drm] Cannot find any crtc or sizes

tidss initializes at ~2.0s with only HDMI-A-1 (the sole DRM
connector). But the DSI panel chain finishes binding only ~10s later:
the panel depends on the MCU regulator reached over i2c-3, and the MCU
and GT911 bind at the deferred-probe timeout. So at 2.0s the
cdns-dsi/panel bridge is not added yet ("Missing drm_bridge_add()
before attach"); tidss reports "Cannot find any crtc" for the DSI
videoport, comes up HDMI-only, and does not defer or re-scan when the
panel binds later. Net result: no DSI connector/crtc and the panel is
never enabled.

Questions:
  1. Should tidss -EPROBE_DEFER until the DSI output's downstream
     bridge (cdns-dsi + panel) is added, rather than succeeding with
     HDMI only?
  2. Is "Missing drm_bridge_add() before attach" the cdns-dsi bridge
     or the panel bridge, and is it expected when the panel attaches
     after tidss has initialized?
  3. Is there a recommended way to ensure the DSI panel chain is ready
     before tidss probes, or for tidss to pick up the DSI output once
     the panel binds?

I'm happy to share the full overlay, dmesg and /sys state, and to test
patches.

Separately (I'll send a proper patch to the bridge maintainers): a
cdns-dsi data-lane off-by-one. In cdns_dsi_init_link(),

  for (i = 1; i < output->dev->lanes; i++)
      val |= DATA_LANE_EN(i);

enables only lanes 1..N-1 because DATA_LANE_EN(x) is BIT(x - 1), so a
2-lane panel ends up with MCTL_MAIN_PHY_CTL = 0x11 instead of 0x13
(lane 1 stuck in START). "<" should be "<=". On 6.1 the TD2 panel comes
up but the image is black for this reason.

Thanks,
Shubham
