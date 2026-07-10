Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7D7C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFBD10F905;
	Fri, 10 Jul 2026 13:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="c8U9HJfP";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBAF10F905
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1783691641; x=1783950841;
 bh=24s13k46rGsxMnf2zAVbuiv4jW+p8YGU/dqz5EtVK1o=;
 h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=c8U9HJfP4ZRTgmIDkfjRStbuEWb2wZx90SrpYMi9LY6cPfrPsysRAhP5H9LHfNufN
 9UCdJQ1CC7f0b6zWXx0WfUTCYWJDHyJX3c5E5ZJuLEpo+pzc4HMPSqPSUnR8BnV3xt
 Ig9nkA52+57QKcpFqiObEsOEFF3GrmtrBv7WczjaqrNt9UXI4D4NkRkB9ZW8BEN163
 M5mXMw2/GOMqTTSdpIXcrnjzbHao2HJEzXIaOiWwInTi7XX922dZrDei1PgAFnGzRU
 BLOyD/9X1YS2VtmLSjgZfYdifO0aNRT92M3lqpdQbf8h0u6YWg+UQl/NfJa7z3Y3PE
 zLVcf4LdIg+9A==
X-Pm-Submission-Id: 4gxYGG2Wy2z1DDLC
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH 0/3] drm/bridge: nwl-dsi: Various fixes
Date: Fri, 10 Jul 2026 15:53:50 +0200
Message-Id: <20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0MD3bzyHN2U4kzdtMyK1GLdZEMTiySDxJQkMwtTJaCegqJUsARQS3Q
 shF9cmpSVmlwCMkSpthYAEprdgnEAAAA=
X-Change-ID: 20260710-nwl-dsi-fixes-c148b0adb685
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Esben Haabendal <esben@geanix.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783691637; l=969;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=PYjcwccAb5n9Ps6jk8ZQoRAgRM1C7aL9+86EKimoJw4=;
 b=ZceoY8CdmBTIh54Cpp71QlHebBRXqyPaNEA52ASPIDb6OjgQz344WTtGm9Y73LwBlMtfWFmyI
 4fL4RGj3qfwDmmipwijgfmsJbPV3RVTl34FWarpL1wipQM6WIVUqwSi
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
behavior and hsync/vsync polarity selection when using DCSS endpoint.

The 2nd commit ("Correct auto-insert EOTP behavior") is taken directly from
NXP vendor tree, so I have kept Author unchanged, although I have modified
the commit message. Let me know if I should change Author for that.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Esben Haabendal (2):
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing

Robert Chiras (1):
      drm/bridge: nwl-dsi: Correct auto-insert EOTP behavior

 drivers/gpu/drm/bridge/nwl-dsi.c | 83 +++++++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 13 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260710-nwl-dsi-fixes-c148b0adb685

Best regards,
--  
Esben Haabendal <esben@geanix.com>

