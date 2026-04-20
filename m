Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C26F588E1
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD96210E697;
	Mon, 20 Apr 2026 15:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ssd9QID3";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A585A10E697
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:07:06 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso1797076f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776697625; x=1777302425; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FTFWPLNElobcmFdIFsbIqWVDEXlAblTj1AkrYjafumU=;
 b=ssd9QID3bZxp/phhHCj65v9HxPea8Yt6VcUT1AX5WQaRruX92GCTKFtndC88eizVb8
 xuCa7kvMAtyQ48NY9k/wfCZMvhZpSJ8v27m3mfPMyo88MklSN9AgGjxSdsEw3+kuqQ6v
 BizvHkCTFwPC92lJi4SMSHFLf55ZtV3ysgD75c5wIvM6yBb7dl7y3t/CsDOzSewXpvFr
 QjfMTacUQPR3vxUpwwZZ0YrdnrYYyXGx2MZ5e/hrzuNLGc5dKJ6xsqdkiazRoEXpgpGq
 GCQGK0AUS1cS4YnWTs1h4Rnzk4JWBU5KTZZGDixJnj8XB6cqDaKCXWjlD6vOzNBGojMZ
 xvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776697625; x=1777302425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTFWPLNElobcmFdIFsbIqWVDEXlAblTj1AkrYjafumU=;
 b=q+GAFas6XRmpvADtX5LLXWIutLiqSflxat1v8MKpL4wTOB+EFlPc1BbOKDV3duV1hR
 MOvQqJvdb5T1P6obVfos2dYJwkRSnRLrxOjlviQGKJNTKoH7hcxZxWom3MaZjLYBEgr7
 OP8mMaXyVCbJtXZ+fd1w9gEuUhSEzVUx5+cFzWoOdrM9KCk8kMRRaTs7348/yzSGS1yJ
 h55nQzwySsP0LJKzNWxsWwOt/ZQo3N9gdMgKZwdf3jtu7ErAQXg26iInk9j8WST+XEUT
 xI9xJCqk3DVr93KafzdBT5SVIe8QJoaPp+mOoQt24IyAo4jAfNiueRTe7rH3dkqAW/hW
 7Dkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YplqCI3YaS6QHJSPb/acZA4Dm82H8dYQpZx7pfe3PamYYEB6M8U3Iul1SpCJ8XA8O7ioFiuro5Tw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwERcy0DIowoYkWAwjO5inBbSDoTG5RgelytoHz7Bq5idAzBObE
 AoQ7I9jtCdSeUJAwD+I/c0o1sTNa4ygdmSuIxeiBp86HfvL2u77ra2yW
X-Gm-Gg: AeBDieta11J8yg3/VzUIY6egsCyo5Fkxswba80wIYxH9gDpkUfMXo3cfW6x4dEGMiPl
 DjMqBOqkXrtILvVNezd/MbMhYPwKSbk15Yi7T+ABui986MjyfuuWfrqhKjHaZarLiJ2CjGarm8R
 v+Wqb7TH+hMSfaXXRBqFlnvY0/pjfPF5zxAQ2bYnDB4/iu7Qp0+1JXmAgSdczUBGI9MqdAU4Drn
 jWJa8retO1b9bls3KpoJu62DjQ5YFcNeDDZ4zFfKomr47bNHIbHtjJrwrfqewNFnnJwgz41RxJA
 BWDJBbZOKXfEqeLKCHtdonN196QHOEH546BPDo+Q7RWFmwREiiKLam3jbWbLfg149v9ftA9sc4n
 HDRFRXgNV762NgnTFwXsYtc3hJYpn8A6RJvqE56oFjddMiA5BeziR9goo+nbDAxkHy2MVtClxgH
 ev1rgTEBFGkRbjYMHnZG0jMlEuTvR+SgNUDnJWbyGa4WGwi+pUq9O8nzKRulItNcC2AuM3ooU=
X-Received: by 2002:a05:6000:2906:b0:43b:8f38:3b88 with SMTP id
 ffacd0b85a97d-43fe3df22bdmr21948856f8f.25.1776697624889; 
 Mon, 20 Apr 2026 08:07:04 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:1552:6880:e516:62d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a79esm31927136f8f.17.2026.04.20.08.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 08:07:04 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Edmund Dea <edmund.j.dea@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 1/2] drm/kmb: reset DSI host singleton state on teardown
Date: Mon, 20 Apr 2026 17:06:57 +0200
Message-ID: <20260420150658.165734-1-osama.abdelkader@gmail.com>
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

Tear down and clear the global DSI host/device/bridge singleton state
when unregistering the host so probe retries and remove/reprobe cycles
start from a clean state.

Guard the clock-disable path in kmb_dsi_host_unregister() to avoid
dereferencing error pointers from early probe failure paths.
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_dsi.c | 44 ++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index aeb2f9f98f23..500dc00ba6ae 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/mfd/syscon.h>
@@ -182,8 +183,18 @@ static void kmb_dsi_clk_disable(struct kmb_dsi *kmb_dsi)
 
 void kmb_dsi_host_unregister(struct kmb_dsi *kmb_dsi)
 {
-	kmb_dsi_clk_disable(kmb_dsi);
-	mipi_dsi_host_unregister(kmb_dsi->host);
+	if (!IS_ERR_OR_NULL(kmb_dsi))
+		kmb_dsi_clk_disable(kmb_dsi);
+
+	if (dsi_host) {
+		mipi_dsi_host_unregister(dsi_host);
+		kfree(dsi_host);
+		dsi_host = NULL;
+	}
+
+	kfree(dsi_device);
+	dsi_device = NULL;
+	adv_bridge = NULL;
 }
 
 /*
@@ -217,6 +228,8 @@ static const struct mipi_dsi_host_ops kmb_dsi_host_ops = {
 int kmb_dsi_host_bridge_init(struct device *dev)
 {
 	struct device_node *encoder_node, *dsi_out;
+	bool host_registered = false;
+	int ret;
 
 	/* Create and register MIPI DSI host */
 	if (!dsi_host) {
@@ -230,25 +243,38 @@ int kmb_dsi_host_bridge_init(struct device *dev)
 			dsi_device = kzalloc_obj(*dsi_device);
 			if (!dsi_device) {
 				kfree(dsi_host);
+				dsi_host = NULL;
 				return -ENOMEM;
 			}
 		}
 
 		dsi_host->dev = dev;
-		mipi_dsi_host_register(dsi_host);
+		ret = mipi_dsi_host_register(dsi_host);
+		if (ret) {
+			DRM_ERROR("failed to register dsi host\n");
+			kfree(dsi_device);
+			dsi_device = NULL;
+			kfree(dsi_host);
+			dsi_host = NULL;
+			return ret;
+		}
+
+		host_registered = true;
 	}
 
 	/* Find ADV7535 node and initialize it */
 	dsi_out = of_graph_get_endpoint_by_regs(dev->of_node, 0, 1);
 	if (!dsi_out) {
 		DRM_ERROR("Failed to get dsi_out node info from DT\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unregister_host;
 	}
 	encoder_node = of_graph_get_remote_port_parent(dsi_out);
 	if (!encoder_node) {
 		of_node_put(dsi_out);
 		DRM_ERROR("Failed to get bridge info from DT\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unregister_host;
 	}
 	/* Locate drm bridge from the hdmi encoder DT node */
 	adv_bridge = of_drm_find_bridge(encoder_node);
@@ -256,10 +282,16 @@ int kmb_dsi_host_bridge_init(struct device *dev)
 	of_node_put(encoder_node);
 	if (!adv_bridge) {
 		DRM_DEBUG("Wait for external bridge driver DT\n");
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto err_unregister_host;
 	}
 
 	return 0;
+
+err_unregister_host:
+	if (host_registered)
+		kmb_dsi_host_unregister(NULL);
+	return ret;
 }
 
 static u32 mipi_get_datatype_params(u32 data_type, u32 data_mode,
-- 
2.43.0

