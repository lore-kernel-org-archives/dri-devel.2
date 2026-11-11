Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6F606A33A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=KHYyQKh6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0DC10E903;
	Wed, 11 Nov 2026 15:05:51 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FFE10E428
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=Bo6XdQ7oVIhPnhQU3cx56rYHTA/stBGFt0/eSIFpeRc=; t=1794409540; x=2109769540; 
 b=KHYyQKh6m4adNpsKAjCU4jhssErDMC3P+gLFHzo6Zt4JSZVxHlN6iTJzTPJcd20OGdRPrUYRAQ+
 YijuqSCRREce8awesoSf4rVfFjWWCnhar0eberUdWzJsr5g3JfTQ0clWL7pD0y/2wUM69+1fH7AzC
 ETNdgOmuLXZLmyQ7MO9zThckQG5dJQtjk2httGb7pIB23dQu0t2oyT1rUlsAzr0b37O3MpeEcDtmg
 xJyUB+RzXI9rlsEwJDbiT7Avj1LkWcBEk1aXGlcsrUO6ef3tU+DdtQ/px5LXbAx/M2Ad3ICoUjTii
 AaZUTfHBM0bpu86PwhU0nNZJMuHLTJOhpwCw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xR9tJ-008sMR-03; Wed, 11 Nov 2026 16:05:37 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 11 Nov 2026 12:05:22 -0300
Subject: [PATCH v2 4/4] drm/vc4: Take the IRQ number from vc4_dev in
 vc4_irq_install()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-vc4-irq-cleanup-v2-4-aa757bb742f2@igalia.com>
References: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
In-Reply-To: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=cPqtbHVmD3/dp6yZb8b+FmdPsLM5rWnKG4zgkZ5z2PI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9IQ1EbOaGvxJspApEQMA1apPgTr2Y4cojZhbb
 kIzFUtHzkaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavSENQAKCRA/8w6Kdoj6
 qoRdB/9ZJmNTPDPaYH5SMqB5TqWr3X4Qkgydk9PIFNs65oZ9eLe5Yuw+vo0aXjmZos7QoPLutkF
 AR5THWiovK8jvKvaClW5CD7C9TS0gnf0cFYCYYRUd1ikOeHHORbUh/iT4Prn8qQU8H34gAH3b4P
 JRdlXd6V2BqdlKFcqTBrZOhHfVa2mul1Q0/++Y2v7HX8Ka8YjVtElAg2njp2dFxMXkDuOJQRvKg
 HgjCucSiK+lshANS+0cDPJgNXOYjD60X8xgt5xXWSx+mWhEx2YsUSs4wQcDfT/F5N7WgY5844qD
 dk27RHcDgPq7ZLW99NSYjTYGzNWFMBVhqIQvzTXYJpKKIlHt
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vc4_irq_install() is handed the IRQ number as an argument even though
vc4_v3d_bind() has already stored it in vc4->irq, which is where
vc4_irq_disable() reads it from. Use it in vc4_irq_install() as well.

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
index 09134809bf15..43f26c5e34be 100644
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
index ff405d3c1d4c..eeb1bd3d4079 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -292,7 +292,7 @@ vc4_irq_disable(struct drm_device *dev)
 	cancel_work_sync(&vc4->overflow_mem_work);
 }
 
-int vc4_irq_install(struct drm_device *dev, int irq)
+int vc4_irq_install(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
@@ -302,13 +302,10 @@ int vc4_irq_install(struct drm_device *dev, int irq)
 	if (!vc4->v3d)
 		return -ENODEV;
 
-	if (irq == IRQ_NOTCONNECTED)
-		return -ENOTCONN;
-
 	init_waitqueue_head(&vc4->job_wait_queue);
 	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
 
-	return devm_request_irq(dev->dev, irq, vc4_irq, IRQF_NO_AUTOEN,
+	return devm_request_irq(dev->dev, vc4->irq, vc4_irq, IRQF_NO_AUTOEN,
 				dev_name(dev->dev), dev);
 }
 
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 15a3c49b4f54..3d5cb538b26b 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -449,7 +449,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	vc4->irq = ret;
 
-	ret = vc4_irq_install(drm, vc4->irq);
+	ret = vc4_irq_install(drm);
 	if (ret) {
 		drm_err(drm, "Failed to install IRQ handler\n");
 		return ret;

-- 
2.56.0

