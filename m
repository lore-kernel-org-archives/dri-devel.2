Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06E5CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAAB10EB7D;
	Thu, 15 Oct 2026 09:49:29 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D5D10EB7D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:49:23 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D097C4E41246;
 Thu, 15 Oct 2026 09:49:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9C05460360;
 Thu, 15 Oct 2026 09:49:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2FD9210328BBA; 
 Thu, 15 Oct 2026 11:49:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792057759; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=FWcYHpK8CdG5em5BjygV1FcmzuhmkAxaHza1OitPJpE=;
 b=s0b1vB3X8OGEInO9qWhWKrGDdPDH+RomF9eS9eCha6LbN7XZmmU7ZSd8PfTAimpAziRBTO
 pumhXgDh52+rDOWBx4bJtSqB3hRjBb/nOW3NCwZUYiYKn3OxlvxXPCGS9TMvWmDZ7uzrOp
 eUz9PihlAHcXJPY+DEZOOT9IA4B968Qjsbuzdj2ezEtSfbE+n+GW/QyopVLKmBKwPJ6K4a
 BliDRPa1gI6STMudISStt27l/b8/jyGQmGp520erto+J1IEi4gT5NueRjkUcG0xGsqWiQj
 JZfALh49dqjzl9j2gxmFtcilLh8BJ58ieVGf7Mw+jmcIrUMWu+tme53E1JvfKA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/3] drm/bridge: ite-it66121: use bulk read, improve probe
 logging
Date: Thu, 15 Oct 2026 11:48:45 +0200
Message-Id: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CQAyF4auQrm1CJ3FAr2JcwNDBGmVIOxgSw
 t0Zdfm9xf82MFZhg2u1gfJHTNJUQKcKwqObRkYZisHVzlNNZxz0jZLLnL0nR/hKI86aekZWTWp
 4CW2IHNuuiQ2UzKwcZf1d3O5/29I/OeRvF/b9AAvraBOEAAAA
X-Change-ID: 20261015-drm-ite-it66121-log-probe-errors-9c8cfef8a7f7
To: Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Julien Chauveau <chauveau.julien@gmail.com>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, Nishanth Menon <nm@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
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

This small series improves it66121_probe() in various ways:

 * use a bulk read for reading the vendor and device ID registers
 * log errors in ID reading and matching instead of failing silently
 * on successful probe be quiet on !DEBUG, more informative on DEBUG

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (3):
      drm/bridge: ite-it66121: improve reading IDs and log on errors
      drm/bridge: ite-it66121: log an error if the IDs do not match
      drm/bridge: ite-it66121: make successful probe quiet

 drivers/gpu/drm/bridge/ite-it66121.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)
---
base-commit: 49477cc277e0a432a8c08766b8ec764ee69622a7
change-id: 20261015-drm-ite-it66121-log-probe-errors-9c8cfef8a7f7

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

