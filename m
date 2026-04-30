Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61409CD13DA
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7179210F43F;
	Thu, 30 Apr 2026 19:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VQYOSrL/";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B4010F43F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 19:57:14 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so863911f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777579033; x=1778183833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xXo4GTKuApdH2855i6VQmTYDmGzNNitfMak3tWGUlss=;
 b=VQYOSrL/VELZUytxpt39hUWXCiZgoNpawVF3yRDgUpnR2NCO1Xo6J3YpZF1eIQx70H
 2k4ecAdkOs1ySlGZfSZ1/1D9QGGzRzoS88mAPWcHZCaVX0YwY3EevuNwWPP4YxI8aZWY
 TmwWnAiS8XWfpMPqQiwvIc99IjwiCP4GkzYL4bU/MTw1hkgBdm6ixlKEQ8RPsi0cAi/K
 AKYw5WcgASA1JGRxoc7Uwjjbtl++G7e5r7sfHuTXElBxm0maJpZeE2+Tdj5O0bT5xw88
 t5x4YNrhlSQiOZJHDjCgbmyEP+G9E44pt2Glees0BSLxYLvBG5pjgt5ly4go+Ol+ytL0
 XMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777579033; x=1778183833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXo4GTKuApdH2855i6VQmTYDmGzNNitfMak3tWGUlss=;
 b=qopfsSzPP3eo0+ruz6eafVOXFDjEsS/ERSnomBNbaUA/vLj0jK+3OqDkWQti308V6K
 r8kr9jL66XduBzvxD9yLp2JtlqOzV1fXLuDA5t74k353gvLJT50LWByrxZcWznu3lx7G
 7VGtgmhEszWgHpWhYeyLAc+bwg1caLGY5a++/ixKrPITztlebb/PEgz8ZnA0Zbu1Pt41
 s/m3fpqW+Qunox/YstoGpznipf7BMr8YDN3YTBLPdcgoW/ZvlTnQcOHiHbm5bKolYFfK
 WgKxI9uHkkVPK5nxZkxf4Hgv9gYdRCuW7d3SWF/RfOWvbMYf2NT4rs+0W13bGNR5a6r8
 NanA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Q92yVdoKkV0DlNrIzXYsaxpBuJdSGF35qxcJ8izLm+Wk7Ff40/poqndEliXr/IYqZFVATo7fy3tk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/cW+3G//kmynIqoJnTvFLuFerpCV7cDsQ0i/HY9Wjfo20tDjy
 acPcl1L2oYmTLHvMO5A+anSjM34pd0fv/7EBvsvi8dphmqZMX3egffH2
X-Gm-Gg: AeBDiest9Fe0qt3qzSOwJowYOVCaCWqpNSFPD6nEJpNMLYgMe/Eb6yN73j9h5CTkCp9
 UfoYVBygQ/6YlVZPpIQiN5W6Qvp48ua1WX/Fjz7VHoPTnMbTJI+9WwNulxDP3vPu4E8BOhf+MV4
 epoFHuK185E0iEkx6Ug3zCAb/I0DXv1NPDQoRosdNtPgK13fLxGiNPFZruDNVqO9hOFbM8x9vJb
 hPVnp0Ri5uNnfdm15+DkCbpYmOf3yFlbQSmANyhTIbG64YW3RtepeqGeQIN7fZUwsS083ACQwLF
 XDKNcrDvcZ+FYrvK+6h2f7jk0w8DaSO6JYOAH48dfu1dge78JD/PyjVLAMgZddA+SGDaTM+l9/B
 20mv8Z5I0962u1wTGBBszo5Om9gR5Zp2rBII5xBcNmWhboGr7dKl74aVB+U2hSqsPXDh+BAlar1
 fwtKRVC0OXSd0+camavnL+4/UaO/2GL9PE3dzaurTpaWrBQ933vYWe/sJp7MFA2/b8z0t2HAA=
X-Received: by 2002:a05:6000:2c11:b0:43d:775b:c9bd with SMTP id
 ffacd0b85a97d-4493cc3f4e1mr7237459f8f.10.1777579032765; 
 Thu, 30 Apr 2026 12:57:12 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5afesm13003924f8f.30.2026.04.30.12.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:57:12 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Peter Senna Tschudin <peter.senna@gmail.com>,
 Ian Ray <ian.ray@ge.com>, Martyn Welch <martyn.welch@collabora.co.uk>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Archit Taneja <architt@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] drm/bridge: megachips: remove bridge when irq request
 fails
Date: Thu, 30 Apr 2026 21:56:59 +0200
Message-ID: <20260430195700.80317-1-osama.abdelkader@gmail.com>
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

If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
bridge before returning.

Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
tied to the STDP4028 device while ge_b850v3_register() may complete from
either I2C probe; devm would not unwind the bridge if the other client's
probe fails.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: fcfa0ddc18ed ("drm/bridge: Drivers for megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)")
Cc: stable@vger.kernel.org
---
v4: update Fixes tag
v3: add Fixes and Cc tags
v2: IRQ failure path only (explicit drm_bridge_remove)
---
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index c9e6505cbd88..2d02cc69f237 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -251,7 +251,6 @@ static void ge_b850v3_lvds_remove(void)
 		goto out;
 
 	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
-
 	ge_b850v3_lvds_ptr = NULL;
 out:
 	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
@@ -261,6 +260,7 @@ static int ge_b850v3_register(void)
 {
 	struct i2c_client *stdp4028_i2c = ge_b850v3_lvds_ptr->stdp4028_i2c;
 	struct device *dev = &stdp4028_i2c->dev;
+	int ret;
 
 	/* drm bridge initialization */
 	ge_b850v3_lvds_ptr->bridge.ops = DRM_BRIDGE_OP_DETECT |
@@ -277,11 +277,15 @@ static int ge_b850v3_register(void)
 	if (!stdp4028_i2c->irq)
 		return 0;
 
-	return devm_request_threaded_irq(&stdp4028_i2c->dev,
-			stdp4028_i2c->irq, NULL,
-			ge_b850v3_lvds_irq_handler,
-			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
+	ret = devm_request_threaded_irq(&stdp4028_i2c->dev,
+					stdp4028_i2c->irq, NULL,
+					ge_b850v3_lvds_irq_handler,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
+	if (ret)
+		drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
+
+	return ret;
 }
 
 static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c)
-- 
2.43.0

