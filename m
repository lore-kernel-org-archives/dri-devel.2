Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEB9606A33A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xgQpdWAl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938F710E4D4;
	Thu,  5 Nov 2026 08:53:24 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158F410E4D4
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:53:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6EFE7C69155;
 Thu,  5 Nov 2026 08:53:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3D4FF5FF85;
 Thu,  5 Nov 2026 08:53:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2C220103291D2; Thu,  5 Nov 2026 09:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793868794; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=QC5j2xRESRmSD7obottAudidFpaX/mHq2OWq+o7sIlY=;
 b=xgQpdWAldL0yJrgVGT1AnGzu1XNvzgdid4qdl7D9S3poXSwZ+1xXuvxVEJDKHf+30d4gi1
 jfIEKILjzdFPA1DkuZMvQdeZI2TLkw5w99flejhGSpT9PHWna1nwLpFhUFy5Z/NcvK5Wma
 891zzHR+JkOvKtWirxgpOnQwdkkv3CpRDOTmHl1E8EDvTjQIUlbqZwuL49B0Pjp5FNasCd
 +u9DXnZ9VoKPzeMLgu447oUgwyq0RoSui0BxNQb7+bKAh2yPSYr+qYCVYDg8cbxowRlD9D
 Pf1RY+KNEgpz758Q/l8DzyjAyUtRDowJ2DbDMGDT+wPyaxb5FyvC8vVZtg2QMg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 05 Nov 2026 09:52:46 +0100
Subject: [PATCH v2] drm/bridge: ite-it66121: fix silent probe regression
 due to reset timing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-ite-it66121-fix-reset-v2-1-02039d66af29@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NSw6CMBCGr0Jm7ZhOkUJceQ/DAsogY4SathIN4
 e4WvIDL738uENgLBzhnC3ieJYibEuhDBnZophujdIlBK21IUYGdH1FikqMxpAl7eaPnwBF7Kk2
 RF1VTGQOp//SczH37Wv84vNo727gNbolBQnT+s5/PtOX++ZkJCU9lrvKKlWlae2mdiw+ZjtaNU
 K/r+gVqH0dd1gAAAA==
X-Change-ID: 20261015-drm-ite-it66121-fix-reset-f1765358a866
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
 stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
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

Commit e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
rightfully added code to make the reset pin really work instead of being a
no-op, but that change introduced a regression making probe fail most of
the times, at least on some hardware.

On a BeagleBone Black rev.D the IT66122 silently fails probing >90% of the
times. This is because:

 1. the regmap_read() calls just after it66121_hw_reset() to read the ID
    registers fail
 2. there is no error checking for these regmap_read(), execution
    continues silently
 3. this results in not matching any of the IDs from it66xx_chip_info
 4. and this results in silently returning -ENODEV

Empirical tests showed a small delay after de-asserting reset fixes
probing. Likely the device needs some ramp-up time after reset. No such
requirement is mentioned in the docs I could find, so the amount of delay
was chosen by testing: 10 ms worked in 100% of 25 test runs, so setting a
20 ms delay should provide a safe margin.

Fixes: e02b5262fd28 ("drm/bridge: it66121: acquire reset GPIO in probe")
Cc: stable@vger.kernel.org
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Add comment
- Link to v1: https://patch.msgid.link/20261015-drm-ite-it66121-fix-reset-v1-1-473038e06abc@bootlin.com
---
Changes in v2:
- add comment (Javier)

FYI For items 2 and 4 above, I'm sending separate patches to make those
errors not silent [0]. Those aren't fixes, so they would be for
drm-misc-next, while this patch is for drm-misc-fixes.

[0] https://lore.kernel.org/r/20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index c8d0a26e8e90..f00cbe477a78 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -357,6 +357,8 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
 	gpiod_set_value(ctx->gpio_reset, 1);
 	msleep(20);
 	gpiod_set_value(ctx->gpio_reset, 0);
+	/* Post-reset delay not specified, value found by testing */
+	msleep(20);
 }
 
 static inline int it66121_preamble_ddc(struct it66121_ctx *ctx)

---
base-commit: 0720532355207f2014a98b650d19497cbe3b22f5
change-id: 20261015-drm-ite-it66121-fix-reset-f1765358a866

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

