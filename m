Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E03CF8D746
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758B410E8BD;
	Thu, 16 Apr 2026 14:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WLWo/XQi";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F46B10E8BD
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:00:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0485AC5C3C9;
 Thu, 16 Apr 2026 14:00:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D07F460495;
 Thu, 16 Apr 2026 14:00:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 34560104608A0; 
 Thu, 16 Apr 2026 15:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776348004; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=N4xB/wfiI1XVOzZXHjuCwYPWe2tmB3yiKHhB6+laMIs=;
 b=WLWo/XQiqijIAf2C1VZSC4FcwS3D53eIxcwGo1V/M447f00NTfe+jvKCYNcYc5QwzgmG2M
 HFHn7Ao1yd34YAYaCPU+LFwPN1gCWWAk6d2wabWSIegq9ELspW0zSIOxhFapI0217y2ZjE
 eqVX2nO9zvWpGYBQlyZxko+QG0RLxVEGrASk8TlQ20br1oLD/opmCGe7RJR8dRmMOrLOBH
 kDBGbhM620S5//UyPY4O+pqfFaGH54P2tBZbqdUCT8u0f+AjTzGtovXGuhi7kJa2weVH0y
 hGA0xhHz2dTJykyIZHWpEs6PaKKF2r6gg6Ii3kG665aiPhzRu8mA+dJxm7DiOQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3] drm/bridge: ti-sn65dsi83: two fixes + add test pattern
Date: Thu, 16 Apr 2026 15:59:54 +0200
Message-Id: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-0-143886aebc6b@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvr4GkC/52PQWrDMBBFr2K0zgRJxqqdVe9RuphYo3rAlYJGF
 S3Bd4/iTcgyXb7P8B5zVUKZSdSpu6pMlYVTbNAfOjUvGL8I2DdWVlunrXVQGCS6wQuPPfgfXGG
 tXiDwLwlg9FBIClywFMoRwhCCeyMzaT2r5rxk2i+b8uOz8cJSUv7b89Xc1/+WqgENlswQBpzQo
 X4/p1RWjsc5fat7q9qHv9fTq37b/OQQsb3jzWie/du23QBY7HQMTAEAAA==
X-Change-ID: 20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-f5ff67e1900c
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Linus Walleij <linusw@kernel.org>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

This series used to have two bug fixes, now applied to drm-misc-fixes, and
a patch adding support for enabling the test pattern output from userspace,
which is now at v3.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v3:
- Fix incorrect halving in single-link mode
- Link to v2: https://patch.msgid.link/20260309-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v2-0-e6aaa7e1d181@bootlin.com

Changes in v2:
- Removed patches now on drm-misc-fixes
- Fixes potential inconsistend values in the test_pattern patch
- Link to v1: https://lore.kernel.org/r/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com

---
Luca Ceresoli (1):
      drm/bridge: ti-sn65dsi83: add test pattern generation support

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
---
base-commit: 126c50bc2fb6ddfe5b7718de67bbd7592a1062bb
change-id: 20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-f5ff67e1900c

Best regards,
--  
Luca Ceresoli <luca.ceresoli@bootlin.com>

