Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6D606D812
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DqjOKxOI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E0310E386;
	Wed,  4 Nov 2026 08:58:02 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A4C510F590
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:15:56 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so4337965e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793711754; x=1794316554;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BWdEPnHy9dZO7NwE6/7/FedykeHo/CmP2F0AQ+vkyQM=;
 b=DqjOKxOIcRMNWZQ2oq5N+/A5kl/I7yHBTnH7bh7J3tQv9ROpdsR0DItCLPuGPmSqMF
 C0/GkzApV6GNZs2dryGZW4w03DMvhyyFX/54i4IODt9RtUcLeInpHO6pbR1vWF5PzVwf
 mQ8TFROJDRm8d1UiVmrkJ3DR+Of1FgN6RlpM6Vsdwybr4rDndzPn72J+BXUJeT5RHQks
 dUOBezWi62PC/95OWcRd8Ft1ct6guioSSqY+pToJ1xpMyHKYKFUG8IvQSiyARfNfdm0I
 wQJSB//Vfnzb8NyHO0seL7Ui8+4ID04s+aBDBgtqfOtHmHPiLU+pZ5PiUSIq2Ja8cT6q
 vp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793711754; x=1794316554;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BWdEPnHy9dZO7NwE6/7/FedykeHo/CmP2F0AQ+vkyQM=;
 b=v3lYTXk15zKAGIHtSpKrR4HGMSIrMTKoz6fvn/oY+Ntoqr+pPV/OIskg2qRxs+k08x
 txv/njVFnAhD/FW/+1c7CNEGmARc1pGxYt2bt0UqQpqCD7fZuchnAzjnkw/wilWf+Tu5
 0Cfmn9OCxLRGijls82Ydl3l81QTKSXsN2i5GCJWIdlOFLJtlsN2Qb/hwBZGpCM0C+tnW
 QJ+K6hPrWXinDrhXh8aQUrhg08rOSGAgxdFqGbhRIdHIzlImsBKSgj6PNjvkKyh9IupI
 aiAqzwp5m0hHDUIy8SAtcLL8XJP1ldIiKW0i90hPG8b7iFGfFyVCiIIIIhgGC/Qid0rf
 QMcw==
X-Gm-Message-State: APuU4Z/yBx4Evl8sdmQiBSC2UhvDDvpXRgPv9zhietxh2RiH6Tecps9N
 Ud/iGhHSD8ruEbl94hlvMliOrjO73E3cQUgzltj0Y2a9eqYMGTeY4HXAJ5iy8nKLmBk=
X-Gm-Gg: AYBFou2bp/0RniYB97AxB6MlQnZ0SJ38ekbAUvsf/c1RLnLA1mNHoE+ve0Z402MUL1w
 0T2TUSoSyLbI+eWjfuX+ALi4hx2Fj68jvuA3EYJn3zMZbbz5JMuZCP5lztCDtwycZgAO9u3IJ2+
 2O1Dfq1x1sD3L2/pzbBAPPE/p/JihSDCUNZhCjIBPghVOQBnF3lXLadYULjCBLhGs4Ovy+PYNMJ
 E+5mO0IL9ida7ebHg5vGEZjL7UqwsEWEgNa8PMHrVg9N9KWUevO1S1WEuCA1RsiDaw8we3oY1Zs
 MrFWYexjOH+CCDv1F/aBRf/hNKahUPIQqoCIR0WGUH8dsveXSp/4ldbkyDYCn2Lwu5vFyxXyRlC
 pr/1QnHoNF96alXYDxtiO30uQEhCGJk4kvRILBWQr+Gpu6zpv+D960I5dNmBkns/sj7C/gzIG/U
 xVg9Yjua6/hQ5XTif8bbOCFoAwjFjGIBsTLcbwvBpIRkUkUNVY82Cs4+Ng5AkCVk9XXB1gnzR4C
 Mx0vGQKNGbkytZ9REFHLqL6Rksrr/k4jtrvPcDAkbQOZu4cGSBWqkv9cON6SwInfpXxiwyDnluv
 QQKj39lEKDMU70ZgKzep/bDtQA==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4ac17a3628emr300804355e9.14.1793711754256; 
 Tue, 03 Nov 2026 05:15:54 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7700c3bsm302570825e9.0.2026.11.03.05.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:15:53 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 14:15:33 +0100
Subject: [PATCH] drm/tilcdc: Fix suspend/resume drvdata
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHTe6WoC/yXMSw6CMBAA0KuQWTtJhwokXMW4aIdRhvBp2kpMC
 He36vJt3gFJokqCvjogyq5Jt7WALhXw6NanoA7FUJu6JTIW9w6vmLegjG6xtpnDgllnHhgtGSf
 cNcaThxKEKA99//Lb/e/08pNw/o5wnh/uGgtCfgAAAA==
X-Change-ID: 20261103-v7-4-topic-am335lpm-tilcdc-310aec750b1b
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=msp@baylibre.com;
 h=from:subject:message-id; bh=83Ua03s8JK3zkD/3szPivy67tq5SBAM04PktMYX0mbY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX9xqFJ7iX3VgVUBV8RdD3RAGDhS5/5rsnW2t//K2za
 Q8N063uKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIlYbmP4H/GoRuDCwnfbfqx/
 qN1ovHxFEM+kH94x39Jtfef67WDat5jhf9D5o9odOyWnav9+navh7sz4MelE8d/K6Zq3qlrvVtn
 EMAMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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

drvdata contains a pointer to a struct tilcdc_drm_private and not a
pointer to a struct drm_device anymore.

Note that this breaks suspend/resume at the moment, it hangs on
acquiring a mutex.

Interpret drvdata correctly as struct tilcdc_drm_private as is done in
the rest of the driver.

Fixes: 3301302060da ("drm/tilcdc: Modernize driver initialization and cleanup paths")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1d6c9a423a41..e82cb2686c5f 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -235,7 +235,8 @@ static const struct drm_driver tilcdc_driver = {
 
 static int tilcdc_pm_suspend(struct device *dev)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct tilcdc_drm_private *priv = dev_get_drvdata(dev);
+	struct drm_device *ddev = &priv->ddev;
 	int ret = 0;
 
 	ret = drm_mode_config_helper_suspend(ddev);
@@ -248,7 +249,8 @@ static int tilcdc_pm_suspend(struct device *dev)
 
 static int tilcdc_pm_resume(struct device *dev)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct tilcdc_drm_private *priv = dev_get_drvdata(dev);
+	struct drm_device *ddev = &priv->ddev;
 
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(dev);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-v7-4-topic-am335lpm-tilcdc-310aec750b1b

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

