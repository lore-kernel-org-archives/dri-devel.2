Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045C9C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50CB710E6BC;
	Mon,  3 Aug 2026 14:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="xMcvLZ4T";
	dkim-atps=neutral
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2805C10E6BC
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785769031; x=1786028231;
 bh=MRuZBZYOmb7+F96P/Nqj6n9WgyHe8h0snVBEQIZBH2Y=;
 h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=xMcvLZ4Ta8CwmX0JbUmrXgN8IFk2aN18jVBJ3ZPh5DJh82EnmDDZhKE4WXjM2/1bU
 2+A+gllIiBAVv3seDjZXkXqznndxSO1j6dODP7h3nw3K9teyscPekVf6B3QBgDM/gx
 GmVkj/b/gEBfhUK7y8gFKhGGq8Cw9WxtmwrEP87Mr9OVX7hIedEZMw7KWGm6V/3WV1
 0s2uDg0CnFkdnYtJpc9vaKDDsc/YDhax1+fHSJ18O9PWMciAjNc7/TQ79v0U+gHVr/
 8GW+VD2RSKKbXnoTFhbhH0z+dSfIH3YmjqlwgvGC+pZLpdnDHVnvAfoph5St0Roa3q
 iLsbVbZlJ0p/w==
X-Pm-Submission-Id: 4hDKX55jDdz1DFF2
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v3 0/3] drm/bridge: ti-sn65dsi83: Various fixes
Date: Mon, 03 Aug 2026 16:57:02 +0200
Message-Id: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBREf4V0bU0fFIor/8O4oOUC18RiuEgwh
 H+3YEw0YTmZmXNmRtAjEDslM+thRMIuxKAPCfNtGRrgWMXMlFCZyKXgA3IKmakIreY1TkBcVsK
 CKH2WO83i8dHDVsTf5frJ9HQ38MNKWhct0tD1r806ynX3Fcg9wSi54JU14IxOlSvsuYEy4HT03
 Z2thlH9MswuQ0UGOJ96XYMqXPbHWJblDUnYHb8LAQAA
X-Change-ID: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769029; l=2559;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=8WNjm3GANp+5zTz1RkKwjR1O6RbsHW3GmvX0m75Y0TE=;
 b=/O/SVH8yZvmXD6bSfXdtJ6EmEUBiR1emuiFnICS5BlJR0VgplA/6+fJC3KzKGXVpepeU3WZ9Q
 Vibnx6FNL7FD9fHs3hGxfJXRmtv0YdFOd/ZaPHR1lGxIdt1K6n2to6f
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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

This small series adds support for using SN65DSI84 in single-link mode with
output to LVDS channel B, and provides a fix for a PLL locking issue.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v3:
- Rename panel_port variable to output_port.
- Propagate error code from drm_bridge_helper_reset_crtc() in
  sn65dsi83_reset_pipe().
- Drop with fix for premature PLL locking. Should be fixed in DSI host
  driver (or upstream bridge driver) instead.
  See https://lore.kernel.org/all/48f6f55f-43fd-4355-88b9-d2e2d0e26d07@kontron.de/
- Link to v2: https://patch.msgid.link/20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com

Changes in v2:
- Fix error handling in sn65dsi83_atomic_enable() to ensure
  drm_brige_exit() is always called on exit.
- Change logging level from warn to dbg for two messages in
  sn65dsi83_parse_dt().
- Removed trailing dot in comment lines.
- Added patch with fix so that DRM bridge critical section is exited on
  error in sn65dsi83_reset_work().
- Added Fixes and Cc: stable tags to the premature PLL patch.
- Re-ordered patch so fixes comes first.
- Link to v1: https://patch.msgid.link/20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com

To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Linus Walleij <linusw@kernel.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (3):
      drm/bridge: ti-sn65dsi83: Propagate error in sn65dsi83_reset_pipe()
      drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()
      drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 39 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 13 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3

Best regards,
--  
Esben Haabendal <esben@geanix.com>

