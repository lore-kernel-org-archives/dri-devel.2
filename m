Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B79C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C2110E49F;
	Mon,  7 Sep 2026 11:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qOkw5LIz";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC9010E49F
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:28:24 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 059C52E9;
 Mon,  7 Sep 2026 13:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788780408;
 bh=EsVKsvATbJo/Lp+esOjfsBzagnhC36AfAyUQNVT8glw=;
 h=From:Subject:Date:To:Cc:From;
 b=qOkw5LIzoiP5T6sPV7PMwTVR4W9UUsOw9VTIX2wScjJxwP+o8fVUZ6mg2AhEs+qOl
 zfaYx3ey7rHVM6YyR1j9ezL92kjOxF9GFxZAo8bAVVNHHyTDazI+vJSCxw0EF/hkun
 NGnQ7tNg0JqDBpau8jzRdHC+5or/JVk+AjLIAAr4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 00/13] drm/bridge: tc358762: Various small fixes
Date: Mon, 07 Sep 2026 14:27:55 +0300
Message-Id: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALyfnmoC/3XPTQ7CIBAF4KsY1mIolGlx5T2MC8qPZWEx0BBN0
 7s77UaT2uWbyfsyM5HsUnCZnA8TSa6EHOKAoT4eiOn1cHc0WMyEMw5McKCjEbJtgFMfXi5T8AA
 gGbNaOYKlZ3LrAjvXG+Y+5DGm9+qXapnuUqWijIL0daM4b7SXl2CdznHook72ZOKDLGLhv0qzU
 TgqOFFWmBoxvaOIryIrsVHEcguotpP4XNupP8o8zx/9zIxrPwEAAA==
X-Change-ID: 20260326-tc358762-fixes-6f666500da9e
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2326;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=EsVKsvATbJo/Lp+esOjfsBzagnhC36AfAyUQNVT8glw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnp/R52GbNblQzPqFhbAr5jHEU+kVjZc1IdE2k
 1eypZZPSIuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6f0QAKCRD6PaqMvJYe
 9VJDEACNddKq7soVBb5ZYOKPMXTIs1enkatUE48N3u912UtmxvG7qKEwBI37BZv6K+WRiVrKNj2
 SQFuLJWKQSlzBea9pkKz4WXUMm5CfzQ6cX1yFp3w9EBioZJmExqOcsZZ9QqsyXa7aihGcWip4Lt
 g5rTeCo3I16HLZpWjB6MH6QyS0+qlzK1dFr/Bo/pH9MM8cv35bRwzr6a2+B5Oy4WZffcFVfoRaP
 OWuq4EfYVye+6oOskccXxunVt4mgNxIMpFIuSFb+/LqKzcvOjjGg1myekavxVIZrjJstuYV5QT9
 erYGa/gfYJ3+D2WOnuFek12UaflTa56uZmtRwH5senB0Up90tQRBJa+AinlLGSWBEp6UjR5s0+c
 PIElQLBSOcwT83iE8Aut7zZ6TL18fu/KVCXjQgANJVSJX7T6Ohrkp+83ARK8Fs/I808fc/OJoEU
 P81YlQwXQp6mbLI8d/d/2rEP1DHA2aQFYm1Yd6v0E+m6x5afzKqnAdvs5XwJlRqe8kukIXxOZh/
 uEULUO7fnhnEypLvylieATY98DSqT45lg/j7u2J/OQ/OEIrxg4oJBtqgwdep7TznMl1blH1wBhA
 Et1DkhE8hhQVZyv5VJ/vXJuODvaquiEOl3Iky80VfaMKdcwmhgIcc2Hc6ZQdOEVBR/fpxxMLDQd
 8Ae7mr+wpeSwUMQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

While trying to get Raspberry Pi display v1.1 working on Beagleboard
platforms, I noticed various small issues with the tc358762 driver.

The series also contains a patch to fix the timings in the
powertip,ph800480t013-idf02 panel. The combination of tc358762 +
ph800480t013 is used in the Raspberry Pi display module, so it makes
sense to fix them together.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v4:
- Rebased on latest upstream, fixing the minor compilation issues that it
  brought
- Added R-b tags
- Link to v3: https://lore.kernel.org/r/20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com

Changes in v3:
- Add missing #include <linux/bitfield.h>
- New patch: "drm/panel-simple: Fix powertip,ph800480t013-idf02 timings"
- Link to v2: https://lore.kernel.org/r/20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com

Changes in v2:
- Always enable VTG. There should be no downside, and it fixes unstable
  hsync
- Add four new patches at the end
- Extend the patch desc in "Drop SPICMR write" a bit
- Link to v1: https://lore.kernel.org/r/20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com

---
Tomi Valkeinen (13):
      drm/bridge: tc358762: Clean up register defines
      drm/bridge: tc358762: Improve SYSCTRL register defines
      drm/bridge: tc358762: Improve LCDCTRL defines
      drm/bridge: tc358762: Configure SYSCTRL first
      drm/bridge: tc358762: Drop SPICMR write
      drm/bridge: tc358762: Improve DPI enable handling
      drm/bridge: tc358762: Update comment about the number of lanes
      drm/bridge: tc358762: Support VTG
      drm/bridge: tc358762: Fix sync polarities
      drm/bridge: tc358762: Move tc358762_init() into tc358762_enable()
      drm/bridge: tc358762: Drop drm_bridge_funcs.mode_set
      drm/bridge: tc358762: Set DE_POL and DCLK_POL properly
      drm/panel-simple: Fix powertip,ph800480t013-idf02 timings

 drivers/gpu/drm/bridge/tc358762.c    | 203 +++++++++++++++++++++++------------
 drivers/gpu/drm/panel/panel-simple.c |  14 +--
 2 files changed, 144 insertions(+), 73 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260326-tc358762-fixes-6f666500da9e

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

