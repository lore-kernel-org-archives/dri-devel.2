Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA594C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A5F10E0F8;
	Thu, 16 Jul 2026 13:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d/2myiJt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE69010E0F8
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:24:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 75D38423E1;
 Thu, 16 Jul 2026 13:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594041F00A3A;
 Thu, 16 Jul 2026 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208295;
 bh=O14nmzpyT+kgOPJ/j+KRDg5lua+Kxewcv3LY7YEy5No=;
 h=From:To:Cc:Subject:Date;
 b=d/2myiJtvnkt1Y2wt5IIG6TAx2uO7eev65Y7qHq4w6MaYDyg/X2Gei1rsdNZ0hq8X
 AvKhekXrYYGMMokuFZbSmcIO4Qwhmd8vi216yoYW4d390t1EknmpJxb9bO9eUmAeE8
 MtQP7q3dhl5vNB6WKj5dBKqZao041vrXW8buundN/6d/MhKY8rl+n6PR1xgKEHjt3x
 3bWCXjrpHnPIGb0EAqRyoafvG5OTxkJ+p3F1l0CfpKgrO6P5B7f/7gY8qTXFTKSUbN
 +IilV1OYnD5ixtGYyP+F2RWqaWxiKU+6W2rpCWmizgZmtVrb0uD+1Fm9iifdwQcPI+
 SfWi4ZdzhwhFw==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkM57-00000006ZCc-0pfY;
 Thu, 16 Jul 2026 15:24:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] drm/vc4: hdmi: take i2c adapter module reference
Date: Thu, 16 Jul 2026 15:24:48 +0200
Message-ID: <20260716132448.1565278-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
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

The i2c subsystem currently blocks during adapter deregistration
whenever there are consumers holding a reference.

Switch to using of_get_i2c_adapter_by_node() which also takes a
reference to the adapter module so that an attempt to unload the module
while in use fails gracefully instead of blocking uninterruptibly.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a161d3b00a25..40c28e23ea46 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -3208,11 +3208,11 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static void vc4_hdmi_put_ddc_device(void *ptr)
+static void vc4_hdmi_put_ddc(void *ptr)
 {
 	struct vc4_hdmi *vc4_hdmi = ptr;
 
-	put_device(&vc4_hdmi->ddc->dev);
+	i2c_put_adapter(vc4_hdmi->ddc);
 }
 
 static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
@@ -3266,14 +3266,14 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 		return -ENODEV;
 	}
 
-	vc4_hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
+	vc4_hdmi->ddc = of_get_i2c_adapter_by_node(ddc_node);
 	of_node_put(ddc_node);
 	if (!vc4_hdmi->ddc) {
 		drm_err(drm, "Failed to get ddc i2c adapter by node\n");
 		return -EPROBE_DEFER;
 	}
 
-	ret = devm_add_action_or_reset(dev, vc4_hdmi_put_ddc_device, vc4_hdmi);
+	ret = devm_add_action_or_reset(dev, vc4_hdmi_put_ddc, vc4_hdmi);
 	if (ret)
 		return ret;
 
-- 
2.54.0

