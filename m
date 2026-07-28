Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A3DC54F51
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD9D10E56F;
	Tue, 28 Jul 2026 13:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="esidB9zT";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Tue, 28 Jul 2026 13:57:13 UTC
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A7D10E56F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:57:13 +0000 (UTC)
Received: from LAPTOP-99KJFSET (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 47e2b3612;
 Tue, 28 Jul 2026 21:52:06 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, zyytlz.wz@163.com, jianhao.xu@seu.edu.cn,
 Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] drm/bridge: adv7511: cancel HPD work during teardown
Date: Tue, 28 Jul 2026 21:52:05 +0800
Message-ID: <20260728135205.859-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa8ff381003a1kunme3223698f13fe
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUweVhgdQksfHxhNHUxNHlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
 5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
 b=esidB9zTszYZx6Wx3u3CKERzKHwofidxdzK78FZ96IJ7rlKZ97kIn9IbWlLR9yBUHOxdmOktmWLeeSEqNS91I85iwj5+9MVtomXO081Eovxhk4o4SJsCRqIDRz3DcNwA40sOG0AFHrvxOQnlAB/CvfIy8x+WFPvwvAcQ13BH34E=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=xtROo/A43OhfIAyUZ9GmB4Q2D+1MSaS+bas4iB3g3yQ=;
 h=date:mime-version:subject:message-id:from;
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

The threaded IRQ handler queues hpd_work. The work accesses the regmap
and calls drm_bridge_hpd_notify(), so it must not run after the bridge or
the devm-allocated driver data has been released.

Free the IRQ before cancelling hpd_work so the handler cannot queue the
work again. Do this in remove and when adv7533_attach_dsi() fails after
the IRQ has been registered.

The remove-side race was reported previously, but the proposed fix did
not cover the late probe failure path.

This issue was found by a static analysis tool.

Fixes: 518cb7057a59 ("drm/bridge: adv7511: Use work_struct to defer hotplug handing to out of irq context")
Reported-by: Zheng Wang <zyytlz.wz@163.com>
Link: https://lore.kernel.org/r/20230413065943.198088-1-zyytlz.wz@163.com
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 02f8f7e78..132ec4793 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1400,11 +1400,15 @@ static int adv7511_probe(struct i2c_client *i2c)
 	if (adv7511->info->has_dsi) {
 		ret = adv7533_attach_dsi(adv7511);
 		if (ret)
-			goto err_unregister_audio;
+			goto err_free_irq;
 	}
 
 	return 0;
 
+err_free_irq:
+	if (i2c->irq)
+		devm_free_irq(dev, i2c->irq, adv7511);
+	cancel_work_sync(&adv7511->hpd_work);
 err_unregister_audio:
 	drm_bridge_remove(&adv7511->bridge);
 	i2c_unregister_device(adv7511->i2c_cec);
@@ -1425,6 +1429,10 @@ static void adv7511_remove(struct i2c_client *i2c)
 {
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
+	if (i2c->irq)
+		devm_free_irq(&i2c->dev, i2c->irq, adv7511);
+	cancel_work_sync(&adv7511->hpd_work);
+
 	of_node_put(adv7511->host_node);
 
 	adv7511_uninit_regulators(adv7511);
-- 
2.50.1.windows.1

