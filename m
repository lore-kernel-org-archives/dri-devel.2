Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A966C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA3610F03A;
	Wed, 15 Jul 2026 13:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="WtBkCRrf";
	dkim-atps=neutral
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00FB210F03A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1784121045; x=1784380245;
 bh=Sgz64eBHHq6rGPJcYzXSIl/9hS6fZrrjKKEshm3RTKM=;
 h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=WtBkCRrflJM4Jx4pxo42/3TKgOzPAt0RWQxfWcTvaR55AkpNSH0nbNQi1Oy9yI1rv
 5wab/prRst/wXdF7Z+y6ewULViP1i1uOiEGBTssSxs7gU+Zt4uyM97hFPQ50v9XSBS
 XTUIlOdoabcIA73SNfdpg0CZda+hiJjhZ8mX/D/ZLcwOe3KMw53kQngbELy1WfCU/p
 3rCNPd4yWSNDuaJnzfoD8LV34AQ8fZkBsO8ZWybW9MIX/btx4+6GPR45X/IA/xEMEO
 to7U3L6oWQazjgqOLhOOCRDJbgUJRtlZs4A4Pp/nkdoDY8+mK0A6kAnQx6dAYH08nj
 pX0KbTsuxSn0Q==
X-Pm-Submission-Id: 4h0c422Z6Hz1DFF5
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v2 0/3] drm/bridge: ti-sn65dsi83: Various fixes
Date: Wed, 15 Jul 2026 15:10:30 +0200
Message-Id: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NTQ6CMBBGr0JmbU1bBKor72FY0HaEMbGQDhIM4
 e4WjDuXL9/PW4AxEjJcsgUiTsTUhwT6kIHrmtCiIJ8YtNSlrJQUIwkOZeGZTC7uNCML5aVB2bi
 ysjmk4RBxD9LuVn+ZX/aBbtyetkZHPPbxvVsntfV+AvVPMCkhhTcF2iI/aXs21xabQPPR9U+o1
 3X9AB6qclzHAAAA
X-Change-ID: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784121041; l=2057;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=WcNy8O4O9bQxkht4n0NcJM/yMIueXNQAgArqQj+MtEE=;
 b=rIIUHcCBuLRWQQHBYe6XMBSX/TUT1nC0qLrhZu/URcwnXOpT8oTmYfZfURb2iPCEAD78nZk0c
 Y2PK6P4Yj1cC4dbazDMXcuY1L/n7F5HAvMchm6o5OiDldNHa4XBlPpn
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
To: Linus Walleij <linusw@kernel.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (3):
      drm/bridge: ti-sn65dsi83: Fix problem with premature PLL locking
      drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()
      drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 68 ++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 28 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3

Best regards,
--  
Esben Haabendal <esben@geanix.com>

