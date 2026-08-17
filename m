Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10B7C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1B110E843;
	Mon, 17 Aug 2026 15:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pPhIBBC+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CEF310E843
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=RvK6Otfafy1LH6PNbbOZNeHGRqNiTB4mNqoQu9l2hLg=; b=pPhIBBC+QnfxqJyISd7RTm3wSm
 Jupu4CSxj0b9Njo3o40Pza4uwTM1h6Zk438iNUwt0Y3qWvt3fk8ocAo65QcpPgtN+ErrR+ayNst2e
 nq3tbb4ZNY19nBNXaj8YGnOL4ShCZmNmNx6LH3dAJ2Bpe0ymC6BIq2jrKS28NPTNuid46T4BuMQLo
 HgXXsZxEjW/ORM4+fP8E3wT/AxOD8SfKPI2vU9YZo7UeHoVX2bs0lFFDcBigHEbu/fURFvSHcg/td
 ANj33Qth4N1TGI26l0FzuVYv15QEd4dNmcSv2+eu1PRFCfzlolYbO8etu3igWjpMdHrLU0mb8ArVQ
 0vmJLgdg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvz4B-004eWD-K9; Mon, 17 Aug 2026 17:15:59 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 12:15:36 -0300
Subject: [PATCH 6/6] drm/vc4: Let runtime PM tear the V3D down at unbind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-vc4-irq-cleanup-v1-6-ee6c592b3836@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4078; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=7rFLwIhcpyEeewn66/Iw4CDnRv5DRTTTm7cyoPe8axk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqgyWd8Q50gAvJwXmN3TWnaW5v/5NCdYT7aumGZ
 xDtilzH2k2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoMlnQAKCRA/8w6Kdoj6
 qrk5B/9mq41JuGJV4rha7d+qW0G8LBCosVehpqUJar30vFHZOF3SiKss3Sqx8gBwEsbiQjaU615
 waMEW3qH6OC77WZn5pMUk0XSvkTN2gnR7WmMw/IgUFO2XRqiiGR+6/jXspPQOu1EiIsl63PkyZ7
 TvvtF3AHR9INz40Qz0eYQEXjNE6K9Xhl/kne6IQSFffp/o11oPB9X0LFUcP5A2zVeVsdyEwRpg4
 A65Hk92MBGFiSGJqomiIcnx1FP0RJn6gFny0kf84Ln4//8UtMBYl6NFL1VYFN5Fsj+9Y0a3kZVv
 EOFXWUZoi2ubjdzeoMGCEoE/L/bdnxyPtSkCAF6OlsvjQSRM
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

vc4_v3d_unbind() clears the binner overflow address and size and calls
vc4_irq_uninstall() to mask the interrupts. Both access V3D registers
without a runtime PM reference, and the block has usually autosuspended
before unbind runs.

Neither is needed: vc4_v3d_bind() already clears the overflow pair and
vc4_v3d_runtime_suspend() already masks the interrupts. Suspend the block
instead, before vc4->v3d is cleared, and drop vc4_irq_uninstall() with it.

In the bind path, arming the interrupts already happens during PM resume,
so vc4_irq_install() has nothing left to do but register the handler. It
no longer needs the block to be powered, so move it ahead of the runtime PM
enable in vc4_v3d_bind().

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  1 -
 drivers/gpu/drm/vc4/vc4_irq.c | 21 ++-------------------
 drivers/gpu/drm/vc4/vc4_v3d.c | 21 +++++++--------------
 3 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 38f539cb49f4..128358f27a2d 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -1016,7 +1016,6 @@ extern struct platform_driver vc4_txp_driver;
 void vc4_irq_enable(struct drm_device *dev);
 void vc4_irq_disable(struct drm_device *dev);
 int vc4_irq_install(struct drm_device *dev);
-void vc4_irq_uninstall(struct drm_device *dev);
 void vc4_irq_reset(struct drm_device *dev);
 
 /* vc4_hvs.c */
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 999010381da1..7ffd6a1c2fc6 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -296,7 +296,6 @@ vc4_irq_disable(struct drm_device *dev)
 int vc4_irq_install(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int ret;
 
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return -ENODEV;
@@ -307,24 +306,8 @@ int vc4_irq_install(struct drm_device *dev)
 	init_waitqueue_head(&vc4->job_wait_queue);
 	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
 
-	ret = devm_request_irq(dev->dev, vc4->irq, vc4_irq, 0,
-			       dev_name(dev->dev), dev);
-	if (ret)
-		return ret;
-
-	vc4_irq_enable(dev);
-
-	return 0;
-}
-
-void vc4_irq_uninstall(struct drm_device *dev)
-{
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-
-	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
-		return;
-
-	vc4_irq_disable(dev);
+	return devm_request_irq(dev->dev, vc4->irq, vc4_irq, 0,
+				dev_name(dev->dev), dev);
 }
 
 /** Reinitializes interrupt registers when a GPU reset is performed. */
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 818997ded33a..890225ae485d 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -445,6 +445,12 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	vc4->irq = ret;
 
+	ret = vc4_irq_install(drm);
+	if (ret) {
+		drm_err(drm, "Failed to install IRQ handler\n");
+		return ret;
+	}
+
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
@@ -466,12 +472,6 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	V3D_WRITE(V3D_BPOA, 0);
 	V3D_WRITE(V3D_BPOS, 0);
 
-	ret = vc4_irq_install(drm);
-	if (ret) {
-		drm_err(drm, "Failed to install IRQ handler\n");
-		goto err_put_runtime_pm;
-	}
-
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 40); /* a little over 2 frames. */
 	pm_runtime_put_autosuspend(dev);
@@ -490,14 +490,7 @@ static void vc4_v3d_unbind(struct device *dev, struct device *master,
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
 
-	vc4_irq_uninstall(drm);
-
-	/* Disable the binner's overflow memory address, so the next
-	 * driver probe (if any) doesn't try to reuse our old
-	 * allocation.
-	 */
-	V3D_WRITE(V3D_BPOA, 0);
-	V3D_WRITE(V3D_BPOS, 0);
+	pm_runtime_suspend(dev);
 
 	vc4->v3d = NULL;
 }

-- 
2.55.0

