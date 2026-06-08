Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3542CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 21:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A0410E38B;
	Mon,  8 Jun 2026 21:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kEs20WeD";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE6610E38B
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 21:13:50 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8ccdf8d4ac5so52775946d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780953229; x=1781558029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cEF2ayBmzEO4/dop93e1RwK+zC/PoDn/nTSxzR+E0U4=;
 b=kEs20WeD1NtbkrMOmJQbWlcBcN/YQgW1HkmjzlF5ihnro4nvPr+LcNPwRuZN296i2f
 868RpPmVZElg1QH5OuMh0bKWsxmT1GkKvDJ264Z4peX7yAwLRw2X6fRsd2v8Lz4Lf5pO
 +BFbmVZDO3eSllsizDeMxv/3jYrRoAMKPwurwJI637fHH6a0hDS3vNtscWI9TDOVk8Ss
 XUq4jNNRZWhn5Uishs0Csfkgxymvt6U5tf2B8wEykvRlvULMMXbgJIzV/uZPNwKSa4iN
 Q/hwjtDVw+PyYtKRcUFJ7ZMqd0IqM3BKy1bB9kPSSUpozdUQ0lCbogYmRFZ+Sb11kVqK
 T96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780953229; x=1781558029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEF2ayBmzEO4/dop93e1RwK+zC/PoDn/nTSxzR+E0U4=;
 b=b2dx7ZqUGGBYXtCk8EfBUL8EdnTw4+of6kJ/7tZTBbEZXcg0lo2fuMjVeDqywov/ti
 FhyRLGRryNRYKE5VNzi1hOOMH9+NqZzYETocx593u04omD/4ihRHFvcWyUL9pWWiXewu
 ywfT/Czq5KB+TLZXBccOp1Y1aYjVKfLl6JNjGK3tyG1iJT9Ki+iU/Z/4Qy4qvBGpL1a6
 42Olbu/aezDNhCSEVjfWCUrmWp9f7e2sjTrUwBBq5WjGxhe9DvPEJy14KrD+vwUr9NsW
 dFK6Hi5GX5yPNMYBT5ETlnQLcdJJvxWwX+C4GOnZZ5v/yGJeSNt2nWcInpgXE4uKLJWp
 ApHA==
X-Gm-Message-State: AOJu0Yxc2u3HRyDEibni5urXHFA4iULSJGdlKrP0y59oKwSeP7b0C4DU
 o1QyIXoPSeAnZoZR2vXdMG0G9vDwfz1yD13tW+cAB4isrFTVuv6Y9LWt
X-Gm-Gg: Acq92OEdXfGhzpxa+uRR54LtvJV7MAFU+IOGbAO1CPe1IfMpeRHbCtnZY8SqAegwnfT
 uukmbl/XmHjGsSYUHRRgO7mVoNmdkLgxjL7czo0IkDP4iuTYPJ0tzQexu4d3XHiqRNsMZinrgQz
 mQdUV7GLzsl5xMEJhLk+Jy6HkySrjtzrTcQD5Bf4AgNLTWJmPWjx7jOE2eJ+/nU0DOPQMd3WJO1
 68gEsCXpgEciN5btngQRW3JRMIRWgIt1t96tjVsXObyEVRycKPlWha1/UrGpmFC1nkjMe+SqBoJ
 DDS4MvFVS1zWa+Nod+8d/4+2RTPwu0oVqY5ktmZHJxNy3Pj5I4piC/PEpquwUNq45sQOqgVG6Jk
 6FTiFvfYq7AXbXL48+75jili6TfIRLZpAtTrJqmtAqy0452LxuVa+tMF44p/nTlEfwLYlMy2vfP
 gtoyBEfYxHa6BvAfshWLIIXRTN19r7uNiydw7FVVkOy7E56Ww/pq4=
X-Received: by 2002:a0c:f9d1:0:b0:8ce:a005:3ea6 with SMTP id
 6a1803df08f44-8cee6023642mr205113226d6.22.1780953229512; 
 Mon, 08 Jun 2026 14:13:49 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd26b3b9sm179547456d6.45.2026.06.08.14.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 14:13:48 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] drm/kmb: Fix device reference leaks in probe
Date: Mon,  8 Jun 2026 17:13:41 -0400
Message-ID: <20260608211341.123939-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

kmb_probe() takes a reference to its own platform device only to keep a
local dev pointer, and passes an extra reference to the DSI platform
device into kmb_dsi_host_bridge_init(). Neither reference is released.

The DSI platform device returned by of_find_device_by_node() also carries
a reference that is not put on probe failure or after successful setup.

Use borrowed device pointers where no ownership is needed. Keep an owned
reference only for the registered DSI host device, and drop it when the
host is unregistered. Release the temporary of_find_device_by_node()
reference on all probe exits.

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 32 ++++++++++++++++++++------------
 drivers/gpu/drm/kmb/kmb_dsi.c | 31 ++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..f8ef618e3a81 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -479,7 +479,7 @@ static void kmb_remove(struct platform_device *pdev)
 
 static int kmb_probe(struct platform_device *pdev)
 {
-	struct device *dev = get_device(&pdev->dev);
+	struct device *dev = &pdev->dev;
 	struct kmb_drm_private *kmb;
 	int ret = 0;
 	struct device_node *dsi_in;
@@ -515,20 +515,24 @@ static int kmb_probe(struct platform_device *pdev)
 
 	of_node_put(dsi_in);
 	of_node_put(dsi_node);
-	ret = kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));
+	ret = kmb_dsi_host_bridge_init(&dsi_pdev->dev);
 
-	if (ret == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (ret) {
-		DRM_ERROR("probe failed to initialize DSI host bridge\n");
-		return ret;
+	if (ret) {
+		if (ret != -EPROBE_DEFER) {
+			DRM_ERROR("probe failed to initialize DSI host bridge\n");
+			kmb_dsi_host_unregister(NULL);
+		}
+		goto err_put_dsi_pdev;
 	}
 
 	/* Create DRM device */
 	kmb = devm_drm_dev_alloc(dev, &kmb_driver,
 				 struct kmb_drm_private, drm);
-	if (IS_ERR(kmb))
-		return PTR_ERR(kmb);
+	if (IS_ERR(kmb)) {
+		ret = PTR_ERR(kmb);
+		kmb_dsi_host_unregister(NULL);
+		goto err_put_dsi_pdev;
+	}
 
 	dev_set_drvdata(dev, &kmb->drm);
 
@@ -537,11 +541,11 @@ static int kmb_probe(struct platform_device *pdev)
 	if (IS_ERR(kmb->kmb_dsi)) {
 		drm_err(&kmb->drm, "failed to initialize DSI\n");
 		ret = PTR_ERR(kmb->kmb_dsi);
-		goto err_free1;
+		dev_set_drvdata(dev, NULL);
+		kmb_dsi_host_unregister(NULL);
+		goto err_put_dsi_pdev;
 	}
 
-	kmb->kmb_dsi->dev = &dsi_pdev->dev;
-	kmb->kmb_dsi->pdev = dsi_pdev;
 	ret = kmb_hw_init(&kmb->drm, 0);
 	if (ret)
 		goto err_free1;
@@ -565,6 +569,7 @@ static int kmb_probe(struct platform_device *pdev)
 
 	drm_client_setup(&kmb->drm, NULL);
 
+	put_device(&dsi_pdev->dev);
 	return 0;
 
  err_register:
@@ -578,6 +583,9 @@ static int kmb_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, NULL);
 	kmb_dsi_host_unregister(kmb->kmb_dsi);
 
+ err_put_dsi_pdev:
+	put_device(&dsi_pdev->dev);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index aeb2f9f98f23..025384a6fb69 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -182,8 +182,19 @@ static void kmb_dsi_clk_disable(struct kmb_dsi *kmb_dsi)
 
 void kmb_dsi_host_unregister(struct kmb_dsi *kmb_dsi)
 {
-	kmb_dsi_clk_disable(kmb_dsi);
-	mipi_dsi_host_unregister(kmb_dsi->host);
+	struct device *dev;
+
+	if (kmb_dsi)
+		kmb_dsi_clk_disable(kmb_dsi);
+
+	if (!dsi_host || !dsi_host->dev)
+		return;
+
+	mipi_dsi_host_unregister(dsi_host);
+
+	dev = dsi_host->dev;
+	dsi_host->dev = NULL;
+	put_device(dev);
 }
 
 /*
@@ -217,6 +228,7 @@ static const struct mipi_dsi_host_ops kmb_dsi_host_ops = {
 int kmb_dsi_host_bridge_init(struct device *dev)
 {
 	struct device_node *encoder_node, *dsi_out;
+	int ret;
 
 	/* Create and register MIPI DSI host */
 	if (!dsi_host) {
@@ -230,12 +242,20 @@ int kmb_dsi_host_bridge_init(struct device *dev)
 			dsi_device = kzalloc_obj(*dsi_device);
 			if (!dsi_device) {
 				kfree(dsi_host);
+				dsi_host = NULL;
 				return -ENOMEM;
 			}
 		}
+	}
 
-		dsi_host->dev = dev;
-		mipi_dsi_host_register(dsi_host);
+	if (!dsi_host->dev) {
+		dsi_host->dev = get_device(dev);
+		ret = mipi_dsi_host_register(dsi_host);
+		if (ret) {
+			put_device(dsi_host->dev);
+			dsi_host->dev = NULL;
+			return ret;
+		}
 	}
 
 	/* Find ADV7535 node and initialize it */
@@ -1410,7 +1430,6 @@ int kmb_dsi_mode_set(struct kmb_dsi *kmb_dsi, struct drm_display_mode *mode,
 struct kmb_dsi *kmb_dsi_init(struct platform_device *pdev)
 {
 	struct kmb_dsi *kmb_dsi;
-	struct device *dev = get_device(&pdev->dev);
 
 	kmb_dsi = devm_kzalloc(dev, sizeof(*kmb_dsi), GFP_KERNEL);
 	if (!kmb_dsi) {
@@ -1420,6 +1439,8 @@ struct kmb_dsi *kmb_dsi_init(struct platform_device *pdev)
 
 	kmb_dsi->host = dsi_host;
 	kmb_dsi->host->ops = &kmb_dsi_host_ops;
+	kmb_dsi->dev = &pdev->dev;
+	kmb_dsi->pdev = pdev;
 
 	dsi_device->host = kmb_dsi->host;
 	kmb_dsi->device = dsi_device;
-- 
2.43.0

