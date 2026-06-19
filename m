Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4476CCD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0E310E06F;
	Fri, 19 Jun 2026 07:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dCwaUDkr";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CC810E03F
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 07:02:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 91551C06CD4;
 Fri, 19 Jun 2026 07:03:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BC442601AD;
 Fri, 19 Jun 2026 07:02:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6D28A106C81C6; 
 Fri, 19 Jun 2026 09:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781852573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=b8jFrKfRx4ipfCPfX5aq84hRP0+B67EcAHf3pzQ4YTw=;
 b=dCwaUDkrLLIcRV9ZmJaM9t/39llO++sqZWMDkYbTebHJLvAiHWAwxTRbNOA3ozF8fjpduT
 sPwIxiNXrxztG8vW3HxN79sBPJUp2HUWJNfe7fF0uZ07Y5RIj+TmORxGI8GiBVYANoHqSS
 P7p4TR+V66s2VWZWiLQfGMS4h45NrkY/Z6+DcEYYOh8cE97qZ9pQn6SwLvy5BwLZA4/fKw
 ALR8pRpQFMaFAgyuYUoUf9ZpIdbJbUcmxLCp9V7mn8gOoKgZQC1tXtckx7+uQuEqlU3N0i
 l1fJp+0eWnCfiMr3KOkZiXuYahPtSiTDLc75nuiUT0Ty84SzYaHU3IEkNMKogg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 19 Jun 2026 09:02:13 +0200
Subject: [PATCH] drm/mxsfb/lcdif: don't hide lcdif_attach_bridge() deferral
 messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-lcdif-deferral-msg-v1-1-ce2392dca985@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAyA4VchPdtkgziCr2I8sLWDEkDTojEhv
 LtTj9/h/3cwVmGDS7WD8ktM7muBP1WQxn4dGIWKoXZ1cMF3SLrgnEgyEmdW7WdcbEBum0DnHBv
 nI5T4oZzl/Rtfb3/bM06ctu8NjuMDqM9MLnoAAAA=
X-Change-ID: 20260619-drm-lcdif-deferral-msg-e736d5fb301b
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
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

lcdif_attach_bridge() uses dev_err_probe() on all its error returns to
store a specific deferral message.

However its caller lcdif_load() calls dev_err_probe() again on error,
overwriting the specific deferral messages with a unique, unavoidably
generic, message.

Make the specific deferral message visible by using a plain 'return ret' on
the caller.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/mxsfb/lcdif_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index f5bb59cd5028..e2173c4d6fc2 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -186,7 +186,7 @@ static int lcdif_load(struct drm_device *drm)
 
 	ret = lcdif_attach_bridge(lcdif);
 	if (ret)
-		return dev_err_probe(drm->dev, ret, "Cannot connect bridge\n");
+		return ret;
 
 	drm->mode_config.min_width	= LCDIF_MIN_XRES;
 	drm->mode_config.min_height	= LCDIF_MIN_YRES;

---
base-commit: 98b46e693b912eef0e6d497327489113845cbd15
change-id: 20260619-drm-lcdif-deferral-msg-e736d5fb301b

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

