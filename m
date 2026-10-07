Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB275CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 286E010E456;
	Wed,  7 Oct 2026 12:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CKh025rS";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D421310E456
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:12:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E012E1A1154;
 Wed,  7 Oct 2026 12:12:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B0B8C6074B;
 Wed,  7 Oct 2026 12:12:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E4F7811D5125C; 
 Wed,  7 Oct 2026 14:11:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791375124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=GUtOegaKaEuoYIe2gUZnPLzIbi1AdAO1i885UCYWnOw=;
 b=CKh025rStRMBgZIVwBBXXj0sJ15EK70JxNCCPgLoxkdy2JWTZb0xNXJF432x3eRKRxezBx
 pu9f+f3RpPSPCxIlAifyuScZNFYWv4XpEAzOXBt8b+YR6coMz9qBpAmqYKPlyWWye8LCRh
 uFycpdgAKtcSHfqntQt5C8ShN1FXT7GwuV6dC0P/Lw1aQyNebkHFwIAU5UH7bv0eTa8cVT
 omepT2dvoc17fz/FRRRvBWgB3pJjKvF+ZkV1Cty9APpqkNbY3yd1SQ7jBQrCCc3yycqUGe
 S47LnapQECD9rebkrfAqEtAa3J9YgJ3ls2imv7nrA+P6/kFWl4WKGMJhB72naA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 07 Oct 2026 14:11:53 +0200
Subject: [PATCH] drm/imx/lcdc: fix inconsistent indenting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-drm-bridge-imx-lcdc-indentation-v1-1-3bcf98f3951e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0Q6CMBAEf4Xcs5eUihD9FcNDaVc9I9VcKyEh/
 DtFHyeTnV0oQQWJLtVCikmSvGOB+lCRf7h4B0soTNbYtjam46AjDyphN+PMLx88SwyI2eWyZXv
 uTmgauBZHKpWP4ibz7+Ha/zl9hyd83rO0rhssPO7ogwAAAA==
X-Change-ID: 20261007-drm-bridge-imx-lcdc-indentation-2975e44ea6e3
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, 
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

Fix incorrect indentation introduced by mistake while fixing patch
conflict.

Fixes: 4136a58ced8e ("drm/imx/lcdc: stop using deprecated devm_drm_of_get_bridge()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610060513.s5yUX86m-lkp@intel.com/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
index 0f95b5592980..30469f98acd1 100644
--- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
+++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
@@ -542,7 +542,7 @@ static int imx_lcdc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(drm->dev, ret, "Cannot attach bridge\n");
 
-lcdc->connector = drm_bridge_connector_init(drm, encoder);
+	lcdc->connector = drm_bridge_connector_init(drm, encoder);
 	if (IS_ERR(lcdc->connector))
 		return dev_err_probe(drm->dev, PTR_ERR(lcdc->connector), "Cannot init bridge connector\n");
 

---
base-commit: 5d7b464a4f517d1db533b1b231f42ddcf4e1dff4
change-id: 20261007-drm-bridge-imx-lcdc-indentation-2975e44ea6e3

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

