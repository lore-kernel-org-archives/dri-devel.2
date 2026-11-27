Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85392606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PzxejwKi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76E610E37F;
	Fri, 27 Nov 2026 11:21:13 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D7AF10E5B8
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:21:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4706D1A1832;
 Fri, 27 Nov 2026 11:21:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 114256049C;
 Fri, 27 Nov 2026 11:21:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4ED6711E6930D; Fri, 27 Nov 2026 12:20:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795778463; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=LLm6hMsQBQFbf768oUzPJc/Sb15c553IoVLWEezd7kY=;
 b=PzxejwKiRCMoTKGMyTjO+0pLn54hlw4x4yMaiYyygReKdsMd55G5nr8oy4hlOhrxSBd8Yr
 8G8b1k4s4qiLbuP1QROoliOrpSCNcd5X6AfQIgTu7v6MA3bsXy/3dfA6IKzH/dFA4JH6Gi
 jHT1w88GEFIVsJIDqNRcoH7jHapai0d1vfQ6JPhs0ll1U6zZJ1MS7xjr8wrJXo1OrF1iyX
 oIJVsVGohx40gLuxmfxffEuPcRCG7gQN9vVH1tZA5/8MI1Wbskdy8sxYxPreJUFLJHlCWh
 +/iz9hVImkb9zVJHV8arqTE3qDXZiLqqgnodvrlORCo54yD7WOFQWtaPr026rA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/4] drm/bridge: ite-it66121: use bulk read, improve
 probe logging
Date: Fri, 27 Nov 2026 12:20:35 +0100
Message-Id: <20261127-drm-ite-it66121-log-probe-errors-v2-0-dbe9b5a3c5df@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQ6CMBBFr0K6dkzbaAFX3sOwgDKFGmDItBIN4
 e4WPIHL9/Pz/l9FQPYYxC1bBePig6cpgT5lwvb11CH4NrHQUhsl1RVaHsHHFEdjlFYwUAczU4O
 AzMQBSltYh66oc5eLpJkZnX8fE4/qx+HVPNHG3bs3eh8i8ef4sKi998fcokBC7lpTlheUDcp7Q
 xQHP50tjaLatu0LDyzv7uQAAAA=
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This small series improves it66121_probe() in various ways:

 * use a bulk read for reading the vendor and device ID registers
 * log errors in ID reading and matching instead of failing silently
 * on successful probe be quiet on !DEBUG, more informative on DEBUG

Note there is a separate series fixing probing on the BeagleBone Black
rev.D [0]. That is orthogonal and they overall improve probing of this
chip.

[0] https://lore.kernel.org/lkml/20261105-drm-ite-it66121-fix-reset-v2-1-02039d66af29@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Split patch 1 in two parts
- Use just a u8[4] array for the bulk read
- Link to v1: https://patch.msgid.link/20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com

---
Luca Ceresoli (4):
      drm/bridge: ite-it66121: check for read errors reading IDs
      drm/bridge: ite-it66121: simplify getting the chip IDs
      drm/bridge: ite-it66121: log an error if the IDs do not match
      drm/bridge: ite-it66121: make successful probe quiet

 drivers/gpu/drm/bridge/ite-it66121.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)
---
base-commit: f210da5b4aace6919f2723586d22126b73c0e31a
change-id: 20261015-drm-ite-it66121-log-probe-errors-9c8cfef8a7f7

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

