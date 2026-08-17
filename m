Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD6AC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78F410E84E;
	Mon, 17 Aug 2026 15:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hqrVE6E8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC3A10E846
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=yj4XDHrAlJF54jfNom0YlFmcgNf+0mlPHFbByQZY/+Y=; b=hqrVE6E8Whgrj8AIWsPH3g8bkw
 OtuLTXHFQTbQJcICug56W5H6VC9HAz4aqWE10PfPOtKYosRt0i5C2mg5DehV2zr7VTfLn/PU1uVAr
 3sKZEuR89YyU3C2CrVTVBUV2lkUwKNv2DRDHtns9ycD0ykbi5QGWSHT3mrb4y3cwFzp7wxZk6QTOO
 sjRs+DT1IUj6eGTlugh6XePd1cdYIs7DQg5R/Dycy5N7nk1hBZ8yQgnfFIbvngWaBZwqXRB1qbOSz
 CVjx9yFLRtDJ8hyEmwlnPDK0b0MK6XAAkMmvlhYpX+auKyqJxNt9GMEKC4g54XCCoVKCnSmajaxXm
 iNjAsmVg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvz43-004eWD-SK; Mon, 17 Aug 2026 17:15:52 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 12:15:33 -0300
Subject: [PATCH 3/6] drm/vc4: Take the IRQ number from vc4_dev in
 vc4_irq_install()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-vc4-irq-cleanup-v1-3-ee6c592b3836@igalia.com>
References: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
In-Reply-To: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2855; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=ekGfFzDIKtMRdizKaqclHsa2HF3ZvbOuMh8QxRy0TXc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqgyWdxj3j4QHm98LkND4422TXq4YLT5jNGP1F3
 i/d9n8X9ySJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoMlnQAKCRA/8w6Kdoj6
 qqo2CAC/rouMEFaUM0Vu9pqNKCqPn2tshc/qYdOrALgUXX6hCH8aAdTrW183mBqoVPCstgkW31u
 cfe362PLNONqDu0hQbJ9T+oYUrHxZOtSJNJ35PVqA5lezgn3J4KR8xHWdZDujDruUidHyinmTdm
 LXiiM/FHIdtDdNXfoZ2JB1LpVQJbis6KyLgxLiRuw/1tVhnxbmrZdjMI7epP/Vt56eSTdwselgo
 7KB7N/8UHbijewdYjXZ9Td8K+LNy+VPkOY3cTqha+aZhfNsGxvyg9r1ESQ3tguHpcafTRJdT+DJ
 uEX93tdUyi57FPuR/E/BeDWbYkm4+CD7Ys/KM6nRTqrZnyPh
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

vc4_irq_install() is handed the IRQ number as an argument even though
vc4_v3d_bind() has already stored it in vc4->irq, which is where
vc4_irq_disable() reads it from. Having a single source for it makes the
two paths agree by construction.

While at it, drop the IRQ_NOTCONNECTED check. platform_get_irq() doesn't
return that value, and vc4_v3d_bind() already refuses to continue on a
negative return, so the test can never be true.

No functional change.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 2 +-
 drivers/gpu/drm/vc4/vc4_irq.c | 7 ++-----
 drivers/gpu/drm/vc4/vc4_v3d.c | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 35b9b574671b..38f539cb49f4 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -1015,7 +1015,7 @@ extern struct platform_driver vc4_txp_driver;
 /* vc4_irq.c */
 void vc4_irq_enable(struct drm_device *dev);
 void vc4_irq_disable(struct drm_device *dev);
-int vc4_irq_install(struct drm_device *dev, int irq);
+int vc4_irq_install(struct drm_device *dev);
 void vc4_irq_uninstall(struct drm_device *dev);
 void vc4_irq_reset(struct drm_device *dev);
 
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 95b1a8ad848b..a1004c64e71b 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -283,7 +283,7 @@ vc4_irq_disable(struct drm_device *dev)
 	cancel_work_sync(&vc4->overflow_mem_work);
 }
 
-int vc4_irq_install(struct drm_device *dev, int irq)
+int vc4_irq_install(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	int ret;
@@ -294,9 +294,6 @@ int vc4_irq_install(struct drm_device *dev, int irq)
 	if (!vc4->v3d)
 		return -ENODEV;
 
-	if (irq == IRQ_NOTCONNECTED)
-		return -ENOTCONN;
-
 	init_waitqueue_head(&vc4->job_wait_queue);
 	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
 
@@ -305,7 +302,7 @@ int vc4_irq_install(struct drm_device *dev, int irq)
 	 */
 	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
 
-	ret = devm_request_irq(dev->dev, irq, vc4_irq, 0,
+	ret = devm_request_irq(dev->dev, vc4->irq, vc4_irq, 0,
 			       dev_name(dev->dev), dev);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 9aa8985e0428..818997ded33a 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -466,7 +466,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	V3D_WRITE(V3D_BPOA, 0);
 	V3D_WRITE(V3D_BPOS, 0);
 
-	ret = vc4_irq_install(drm, vc4->irq);
+	ret = vc4_irq_install(drm);
 	if (ret) {
 		drm_err(drm, "Failed to install IRQ handler\n");
 		goto err_put_runtime_pm;

-- 
2.55.0

