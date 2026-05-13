Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD06CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53B810EE6E;
	Wed, 13 May 2026 13:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vQOnuSbN";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC5E10EE66
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:54 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75B2C27F4;
 Wed, 13 May 2026 15:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677845;
 bh=jmXoyPEbgAisYIV+cnPtuGms7tbG8ueIAFTxegPxg2A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=vQOnuSbNRunWItBFOzoJKihJ6AIUAXgJ+Z82Mkl0vJ4iAJrZpE0iUhtGp/gZmdfeM
 q/B5jyM+oLeb+FsZwBHgdsnoK90u7zTcGIsh4tTerrMVkQT9jMDOp+FSPJ1ts20410
 iUnufsmAVawxVDVVivzNCsINUXPvPyWXr1bZbzpY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:10:22 +0300
Subject: [PATCH v3 13/13] drm/panel-simple: Fix powertip,ph800480t013-idf02
 timings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tc358762-fixes-v3-13-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
In-Reply-To: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=jmXoyPEbgAisYIV+cnPtuGms7tbG8ueIAFTxegPxg2A=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhPV38EE/za2MWb8qjFsk7stg7X46kMA737+
 d9l5FACeZ2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4TwAKCRD6PaqMvJYe
 9aVaD/9qjZV+sN7i12c5ha1S1EXKl/EAz1ASYiDjOw8rdYGgxkuqpJJtf0t1b+zWZCb0vGpA9sa
 H9Bw224J/WiTIqDriFtFoCztIImxp7+eNUqIhUCZja3bke3z5xgM5YwwT8rWLGORIJMfw6xMu7k
 foKVzXAeiYvBNid9Uyr26dz8cEpwRCxD7kqdGYqSRez8EUJkSShN9hzRguepHTE89f5dewO05mH
 2NyMB32wA8klKXz6ultlH6ogxnAHUpQNhBRTJyKgkTRWJqz2sWeIR0isoQxOWuDJUadSFE9hzm+
 oDDIRCVeM5vT/AkrwfMxX7k35gkBKDVK/zozddsYcOZjhInQUSgyBNDBbJYK3Zq6hAnbLn0kKep
 1KEm8utmedWElJGp1egZ3bEyrHTOnMSVLK7u4CKLCs/cuhk2YgJvF+vFQU0+lqc1aQizAudcDuW
 V9sTS16rq3lS9zSI6OIsOaiCeLpSYOhVoXJat3Nce5oTKCBKTEBKPnl0aDVYz5+s/z3+45ZR7P0
 sJO1gTFpDTs22TPuGo+sGImN7xoUEJR9H1meleHGjx2vo3WRxhfKDMFyuk/S5uBLYgBxM5C6G+j
 wzcWWjeUGATjVbfhQzCumzh6muxPxW0ix/ERLJpqiy7A6S+MaeQe2r//uVFn9z86rN3+KcY45i5
 E/gxMzjpH4XybEg==
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

The powertip,ph800480t013-idf02 panel was added to panel-simple, and
with the tc358762 driver, enabled the use of RaspberryPi 7" DSI display.

I have been testing the RaspberryPi 7" DSI display module with TI's
BeagleY-AI, and I can't get a good image with the current panel timings.

It's been quite difficult to figure out exactly what are the issues.
Possibly RPi DSI TX and TI DSI TX have their own quirks which affect
this also. However, now that the tc358762 driver has been fixed wrt. the
signal timings it sends, this patch makes the panel work fine on
BeagleY-AI.

Fix the timings according to the datasheet:

- hsw + hbp must equal to 46. This was correct in the timings, but the
  hsw was very tight, and at least Cadence DSI has trouble with such
  short hsync. Increase hsw to the middle of the hsw range from the
  datasheet, and decrease hbp accordingly.
- vsw + vbp must equal to 23. This was 24, resulting in slight shift in
  the image.
- The upstream timings seemed to aim for 50 fps, but this is a normal 60
  fps panel, so adjust the timings to get 60 fps. As there's no strict
  rule what numbers to pick here, I used the "typical" values from panel
  datasheet for pclk, hfp and vfp. However, vfp of 23 instead of the
  datasheet's 22 give us a closer match to 60 fps, so I used that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 91ab280869ba..16aeafd2b02e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4041,15 +4041,15 @@ static const struct panel_desc powertip_ph128800t006_zhc01 = {
 };
 
 static const struct drm_display_mode powertip_ph800480t013_idf02_mode = {
-	.clock = 24750,
+	.clock = 33333,
 	.hdisplay = 800,
-	.hsync_start = 800 + 54,
-	.hsync_end = 800 + 54 + 2,
-	.htotal = 800 + 54 + 2 + 44,
+	.hsync_start = 800 + 210,
+	.hsync_end = 800 + 210 + 20,
+	.htotal = 800 + 210 + 20 + 26,
 	.vdisplay = 480,
-	.vsync_start = 480 + 49,
-	.vsync_end = 480 + 49 + 2,
-	.vtotal = 480 + 49 + 2 + 22,
+	.vsync_start = 480 + 23,
+	.vsync_end = 480 + 23 + 2,
+	.vtotal = 480 + 23 + 2 + 21,
 	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
 };
 

-- 
2.43.0

