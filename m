Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8951061B1A
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E33F10E656;
	Mon, 30 Mar 2026 17:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VvhuSg7H";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D899810E63A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qM9BVOWk4vVJdawSTtsZ+wYhDmFa2yRQ51/ohB6H1wM=; b=VvhuSg7H2v5ANrJ4OKQYZWwMuo
 sId7KJYtDUdVzSqUeE1LKL0yEFBDbp8HN15UnMEIfrWnMIEAogd4iUdV0J1eKZT6q5ZOFxcNlySUy
 bCytOalMcgXBWrXTqVDr4uTq4PgzJ2qUpoCFx+BElewt5ZFnrRC28yzSAo9Q0wtmmyRXF9RBsifE4
 ox4Xplg5NrOd+fX4MR9gxM0WnHrXZLUOfE5A0Sf/bsJaEGH+BSXG3gNEy1c3Ew9aq33idWlhnjvgs
 TE90YoCHZdB4Zx0OTTisQWSPI3RMyF+FxJvCBHij5uQ1Dwcip2x1q17SrsNdFsK30RZJ8mxxFWpuC
 KMX1WorA==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w7Gme-00961G-Al; Mon, 30 Mar 2026 19:52:16 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 30 Mar 2026 14:51:47 -0300
Subject: [PATCH 5/6] drm/vc4: Use devm_request_irq() for automatic cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-vc4-misc-fixes-v1-5-92defc940a29@igalia.com>
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=AenCZgHdaLofy8WMJLuIV2uZbWAq9LyQbRnX+ptDojE=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpyrg58fI1YTB7Lf9sIPRwpgHuldp+BSYgSHvH6
 cLhNCH2ibaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCacq4OQAKCRA/8w6Kdoj6
 qrIECAC8yqgQST24ZSqU+nBifOnso+qpEAC5H6nIspeIVdkVS16bdEm6ShIRRD1DyjSquZ1Myjd
 fLy012UOAke8po+vIoC2rCkjKgvfpUYJLq0nPHtGHCWUkEiFIIcuAfBHsDlKadKECqCXfQJ97j7
 QVReeLSl1HktI4Sxi2F25LC6t/IX0Evc3kGU4E6AvVCjlM5Vl51KJb0K1WxiNxguSn82gYYwxm/
 YRfPWqAi3pPfuL4oILn2R4s0M6XR8DDsQstZeTvl/ubwe2j5gVnEA3uZTa/+701ei0EpX7dHtJn
 WdOskZoyYaS+jDCPxTSQJ6AWwe+Ue1A9Aa78Ei4fov3X0n1w
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

Switch from request_irq()/free_irq() to the device-managed alternative
devm_request_irq(), letting device-managed resource cleanup handle IRQ
teardown automatically.

While here, inline vc4_irq_prepare() into vc4_irq_install() since it's
the only caller.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 63e88f90eef7c0720e32547f4e8b5ed289b2427b..8e5141bb50759e19e03c911f75b78354b240406f 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -47,7 +47,6 @@
 
 #include <linux/platform_device.h>
 
-#include <drm/drm_drv.h>
 #include <drm/drm_print.h>
 
 #include "vc4_drv.h"
@@ -242,23 +241,6 @@ vc4_irq(int irq, void *arg)
 	return status;
 }
 
-static void
-vc4_irq_prepare(struct drm_device *dev)
-{
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-
-	if (!vc4->v3d)
-		return;
-
-	init_waitqueue_head(&vc4->job_wait_queue);
-	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
-
-	/* Clear any pending interrupts someone might have left around
-	 * for us.
-	 */
-	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
-}
-
 void
 vc4_irq_enable(struct drm_device *dev)
 {
@@ -307,12 +289,22 @@ int vc4_irq_install(struct drm_device *dev, int irq)
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return -ENODEV;
 
+	if (!vc4->v3d)
+		return -ENODEV;
+
 	if (irq == IRQ_NOTCONNECTED)
 		return -ENOTCONN;
 
-	vc4_irq_prepare(dev);
+	init_waitqueue_head(&vc4->job_wait_queue);
+	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
 
-	ret = request_irq(irq, vc4_irq, 0, dev->driver->name, dev);
+	/* Clear any pending interrupts someone might have left around
+	 * for us.
+	 */
+	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
+
+	ret = devm_request_irq(dev->dev, irq, vc4_irq, 0,
+			       dev_name(dev->dev), dev);
 	if (ret)
 		return ret;
 
@@ -329,7 +321,6 @@ void vc4_irq_uninstall(struct drm_device *dev)
 		return;
 
 	vc4_irq_disable(dev);
-	free_irq(vc4->irq, dev);
 }
 
 /** Reinitializes interrupt registers when a GPU reset is performed. */

-- 
2.53.0

