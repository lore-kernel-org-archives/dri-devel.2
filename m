Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937F6C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA92F10E6CD;
	Mon,  3 Aug 2026 14:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="uNzMgbNs";
	dkim-atps=neutral
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9082C10E6E2
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785768996; x=1786028196;
 bh=bm4q2aoJhc6SLCSs6kkxL7x3OeC/21eQOQIMKY2W1FU=;
 h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=uNzMgbNsWtnMXXlgKUi5D9Gtqg80xp1oewvXmpmVqSM1qfjzNHDczjsUFxHejvOhM
 7REzpCGIybaUBTKxgxUFsdNygDYtjYBY7/++3qhplrp1TjSaxi7N++lzUT83hNv35v
 qkN+kM0AMQnbIW5/+PywaZIF8xnjm6bFtaeKuAtFYHZ2Yc6wep3ivkASrhxcfm9CZd
 I/0EyrZ8DSZIC26DI0oKbAVhcLhKUAAmIl4duZIyT4NhHd9MsmXf2DJjBwA5hO1qPj
 8fbY5yZLcH/3gpyvK4e3kxWpD+umWIueXh4pz5RX4tLuJuFYZ2Tj+C9Cxgh3CrPPMb
 Ffldx0ZmaI37w==
X-Pm-Submission-Id: 4hDKWN4CgTz1DDLT
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v2 0/4] drm/bridge: nwl-dsi: Various fixes
Date: Mon, 03 Aug 2026 16:56:18 +0200
Message-Id: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4X07Jq2USie/A/DobQrrNHWdBExh
 H+34Nnjy8ybmQVjImRxKmaRcCSmGDLoXSFcb0OHQD6z0FKXslISwvsOngmuNCGDUwfTSuvb0hx
 Fdp4JtyArl+bH/Gpv6IZ1ZG30xENMn+1wVGvv3/aoQEKtK18rY01p/blDG2jau/gQzbIsX4JZG
 OO9AAAA
X-Change-ID: 20260710-nwl-dsi-fixes-c148b0adb685
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Robert Chiras <robert.chiras@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785768991; l=2012;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=9f+elwfxZa6LosTTskwWLYOnEdaKJa9JfedkQ24JylE=;
 b=bFH6lb21qE3OPDweIp1kGJFsPV3ij09VvG/HrNHnL5k6u83jfKC6i2OjkN8w+PeQsaJO5AMVw
 KOoJQR7CM2CBcmPTbo5cYGaRbGOImG68MTxvsrthQR7eISqzGEVrymM
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

This series brings a few patches fixing horizontal sync timing, EOTP packet
behavior and hsync/vsync polarity selection when using DCSS endpoint, as
well as a small fix to properly handle if/when nwl_dsi_mode_set() fails.

The 2nd commit ("Correct auto-insert EOTP behavior") is taken directly from
NXP vendor tree, so I have kept Author unchanged, although I have modified
the commit message. Let me know if I should change Author for that.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v2:
- Added safeguard against small horizontal sync timings, protecting against
  division by zero and integer underflow.
- Added error handling of nwl_dsi_mode_set() call.
- Link to v1: https://patch.msgid.link/20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (3):
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing
      drm/bridge: nwl-dsi: Add error handling of nwl_dsi_mode_set()

Robert Chiras (1):
      drm/bridge: nwl-dsi: Correct auto-insert EOTP behavior

 drivers/gpu/drm/bridge/nwl-dsi.c | 95 ++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 14 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260710-nwl-dsi-fixes-c148b0adb685

Best regards,
--  
Esben Haabendal <esben@geanix.com>

