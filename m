Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A7606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=WdApNlaR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F209510E859;
	Thu, 19 Nov 2026 11:40:30 +0000 (UTC)
X-Greylist: delayed 588 seconds by postgrey-1.36 at gabe;
 Thu, 19 Nov 2026 11:40:24 UTC
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA90C10E859
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:40:24 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1795087831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YLq833Da6iVYeGdT+KadJJm72vxSoeHnYAbiFsDpxsQ=;
 b=WdApNlaReVWiFHY24zJ4gDKi+BvJ5U13eP9wS2Du8AQcs3H+OddwFwSO2ekqbiQy/Ou4et
 ikzVVHXbdXOsBpTAv2AM3zczklWZTEgROPYgxJOmfPW1fJbItOakXQrGaaNSOZEL/fCCxs
 8/XDogI/TrR4ycseRX0I6sHyW+g8EMU=
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: [PATCH] drm: imx-dcss: Check return value of
 drm_mode_config_helper_suspend()
Date: Thu, 19 Nov 2026 14:30:29 +0300
Message-ID: <20261119113031.36945-1-arefev@swemel.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dcss_dev_suspend() ignores the return value of 
drm_mode_config_helper_suspend(). On failure that helper rolls back its
partial work (re-enables fbdev and polling) and leaves
mode_config.suspend_state unset, i.e. the DRM side is not suspended.
Continuing to suspend the context loader and disable the clocks then
leaves the device in an inconsistent state.

Check the return value and propagate the error to the PM core, as the
other DRM drivers calling this helper do.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 45a91e43bab1..0b12ce2498f0 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -253,7 +253,9 @@ static int dcss_dev_suspend(struct device *dev)
 	struct drm_device *ddev = dcss_drv_dev_to_drm(dev);
 	int ret;
 
-	drm_mode_config_helper_suspend(ddev);
+	ret = drm_mode_config_helper_suspend(ddev);
+	if (ret)
+		return ret;
 
 	if (pm_runtime_suspended(dev))
 		return 0;
-- 
2.43.0

