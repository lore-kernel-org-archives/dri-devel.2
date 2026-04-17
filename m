Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6CDF436B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99BB10E029;
	Fri, 17 Apr 2026 15:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZvuU6N9B";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D884910E029
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:55:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8F490C5C3E8;
 Fri, 17 Apr 2026 15:55:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 00AA760497;
 Fri, 17 Apr 2026 15:55:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8EB63104608CF; 
 Fri, 17 Apr 2026 17:55:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776441310; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=GTy9tX8Vw514cPMJIpx3/eyD9ty9G5fF7pNizIfxcbA=;
 b=ZvuU6N9Byz4Noq7oyAQL9DepHFWFaG/0ewv/P/+q/Ro+fyZAUuxxMToRQuLKBH7cX7JK39
 g6NDrzvrwEKW1ClpZdDmWQ+tiRJcsD4bweg9/NisQ0HVLHyhY7tbtvh4Kkhy/mjrgeeryg
 lY36M8qLlDUn8uLJh5eNZzmtPN4/1sWnhj6BbvtiUu5o793FGOOLC2fw9hKAlyM7xBywGX
 PVtWJZx0ibI1AmV1wMYB6ri9dEgzy230XvZTTveIGsLPnJk/LU+fSvAnECN1UMgaGozSyo
 HrOVtKfvX0AxUzAJP/R0oKq+OHpDvC4m0AnzGVJYzD8n8sEyj5zhUx0nXTwo0A==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Jyri Sarha <jsarha@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Bajjuri Praneeth <praneeth@ti.com>, kernel test robot <lkp@intel.com>,
 thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/bridge: tda998x: Return NULL instead of 0 in
 tda998x_edid_read()
Date: Fri, 17 Apr 2026 17:54:45 +0200
Message-ID: <20260417155446.1068893-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>

tda998x_edid_read() returns a const struct drm_edid pointer, but when
tda998x_edid_delay_wait() fails (process killed while waiting for the
HPD timeout), the integer literal 0 is returned instead of NULL,
triggering a sparse warning: "Using plain integer as NULL pointer"

Replace 0 with NULL to fix the sparse warning.

Fixes: c76a8be4feec ("drm/bridge: tda998x: Add support for DRM_BRIDGE_ATTACH_NO_CONNECTOR")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604172257.Imo6GOH9-lkp@intel.com/
Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 779b976f601c1..6c427bc75896b 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1293,7 +1293,7 @@ static const struct drm_edid *tda998x_edid_read(struct tda998x_priv *priv,
 	 * can't handle signals gracefully.
 	 */
 	if (tda998x_edid_delay_wait(priv))
-		return 0;
+		return NULL;
 
 	if (priv->rev == TDA19988)
 		reg_clear(priv, REG_TX4, TX4_PD_RAM);
-- 
2.43.0

