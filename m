Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0BECD8C93
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3A910EA6F;
	Sun,  7 Jun 2026 14:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MKS7OUVi";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60D610E876
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 19:53:28 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2bf114b0cf9so26391085ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780775608; x=1781380408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aLuFO9ervNW12wtXreSvxfJ9xeEFmOpfhq9k0XskIhs=;
 b=MKS7OUVibQ1+tm3y0fkhsxkPUZiw5nUbceB5OgzB4ArTCUj/q4r8jwESZe208CoK4o
 gK6L4l/RXsM/G+8kC9E8mTlIghNRWCvju4/rSdF0Is4W2WviaESxRxZnd644Npf0QoiM
 fkf7843cGOVewD+bxV8E4o2VK1H0hJoJKKqEmCsggveJ07a7l44F/2+NqP1FCdUOMdjy
 wtYQrpXAFyhJviB5KkwgJ1fOUmTuwujNf91Xr657B9GFPXEK8rnwyYrNERZXdc30wj0W
 JjbxaCCxP5ySxu3WtxfRmhXcZFj5osmDb32uKRyKCPsGuW0E+HhumKWrAXfguAsIyx4y
 mZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780775608; x=1781380408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLuFO9ervNW12wtXreSvxfJ9xeEFmOpfhq9k0XskIhs=;
 b=gOAcvQq9H9xGZ12GDtZdKT+MUAhqxU4JTLZp6TUfOaAFZE6mufSI1JzFL0+GL1FYRk
 VF4CIlSrwGDao+e2BsArBZGO90tsHdSbFfW/bcDmU2AyN4aXLgllMZrDKGA/OqN1aC1K
 iL5l+Gb++Z7SBL2K/SRoQZKjIG3zttcKpt6QO/tXb0vacifrlF84Kd8Fr2p1ZYEoKFyl
 BHtNhQut0QMuzKxPpKnZkwMIhjXQDVrOe92AKXf2+uwfQ6scXPnSCoqozIqTFVrMP8Cz
 DnAHBULgBnXSezRNR2dhgISMbcZvNvj2RMj+gJXgFpc2yTCK7E1xcMeZIj51ZM8ta8hR
 aCkw==
X-Gm-Message-State: AOJu0YxyuNM3k/HpHrCpbgtmjm6/Tur/WMqnwlFejFCoVvngQ6C5pOBA
 4sg2zkvTUQH2cXCq2NkUw0+3iiBmgnFZvF2FOh5vN4sYiQX5oXLzGglLHAPv8A==
X-Gm-Gg: Acq92OHhWL8LUbBGspZN7Io3J6C/ksLVluW+t1ktYgCvBuQ5O8XwlNGpPCcbZNuldxy
 B2HLiIaShkJ1n3eNxmFLsEMuDf8Hi4ZfhXGj/Q+l0vT4A8klbDWGTZQF/xQCc5sJrQPwazLh4Rg
 RRMUtU/+Ehkjt6UL+nzFcyUjOYZzAq1a7ZVI4ZmNn7lgf+ylsClChCoEjiVGtV1SEaLOsp7gyAm
 SypPqXvFrZ3+FkV5WH84/+TQbuXxav2FQ3si93C5TmT0PjIx+N0TjjmBKJ8OaOEmg3sk7TCAPrD
 WoCU0+ff7H8WrYbtTidU/EGqDHj3Jaso4Fe3bd5avtfdGxdAP3SlYMqa/xUJCaGuBEzSPUiiPpF
 1fPLJ4TujzVkYocDPP8fMfSWvKx6fsAY6lWxrGOchEaJu5NpscdBEyYAwNfrmALAHzXc1TF4Vqq
 sq2xk3ZC8CPq3+GvZsutYAXT+Dv/RzdlLpMaE/DlhYMacf7eLJmANMJIXR4f8jUmu9w4mFEkKi4
 ATXtw/TTfeaVO7zrxnufccyQNUjHt/7jL+3gEawkU1ZleS88CEFQQ==
X-Received: by 2002:a17:902:ce8f:b0:2c0:cb0e:ac42 with SMTP id
 d9443c01a7336-2c1e80f9d2bmr101988635ad.3.1780775608225; 
 Sat, 06 Jun 2026 12:53:28 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA..
 ([2409:40c1:400d:d07e:31c5:fce9:e168:2f2f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649fcdfsm170405075ad.78.2026.06.06.12.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 12:53:27 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: nxp-ptn3460: replace deprecated DRM_ERROR macros
Date: Sun,  7 Jun 2026 01:23:11 +0530
Message-ID: <20260606195316.28048-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jun 2026 14:39:43 +0000
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

Replace DRM_ERROR() with device-aware equivalents throughout:

- In bridge callbacks (pre_enable, edid_read, attach), use
  drm_err(bridge->dev, ...).
- In i2c helpers (read_bytes, write_byte, select_edid), use
  dev_err(&ptn_bridge->client->dev, ...).
- In probe context, use dev_err(dev, ...), consistent with
  existing error paths in the same function.

The kmalloc() failure message in ptn3460_edid_read() is dropped
as the allocator already reports OOM conditions.

No functional changes.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index 7acb11f16dc1..6f09c1247d7d 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -54,13 +54,15 @@ static int ptn3460_read_bytes(struct ptn3460_bridge *ptn_bridge, char addr,
 
 	ret = i2c_master_send(ptn_bridge->client, &addr, 1);
 	if (ret < 0) {
-		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
+		dev_err(&ptn_bridge->client->dev,
+			"Failed to send i2c command, ret=%d\n", ret);
 		return ret;
 	}
 
 	ret = i2c_master_recv(ptn_bridge->client, buf, len);
 	if (ret < 0) {
-		DRM_ERROR("Failed to recv i2c data, ret=%d\n", ret);
+		dev_err(&ptn_bridge->client->dev,
+			"Failed to recv i2c data, ret=%d\n", ret);
 		return ret;
 	}
 
@@ -78,7 +80,8 @@ static int ptn3460_write_byte(struct ptn3460_bridge *ptn_bridge, char addr,
 
 	ret = i2c_master_send(ptn_bridge->client, buf, ARRAY_SIZE(buf));
 	if (ret < 0) {
-		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
+		dev_err(&ptn_bridge->client->dev,
+			"Failed to send i2c command, ret=%d\n", ret);
 		return ret;
 	}
 
@@ -94,7 +97,8 @@ static int ptn3460_select_edid(struct ptn3460_bridge *ptn_bridge)
 	ret = ptn3460_write_byte(ptn_bridge, PTN3460_EDID_SRAM_LOAD_ADDR,
 			ptn_bridge->edid_emulation);
 	if (ret) {
-		DRM_ERROR("Failed to transfer EDID to sram, ret=%d\n", ret);
+		dev_err(&ptn_bridge->client->dev,
+			"Failed to transfer EDID to sram, ret=%d\n", ret);
 		return ret;
 	}
 
@@ -104,7 +108,8 @@ static int ptn3460_select_edid(struct ptn3460_bridge *ptn_bridge)
 
 	ret = ptn3460_write_byte(ptn_bridge, PTN3460_EDID_EMULATION_ADDR, val);
 	if (ret) {
-		DRM_ERROR("Failed to write EDID value, ret=%d\n", ret);
+		dev_err(&ptn_bridge->client->dev,
+			"Failed to write EDID value, ret=%d\n", ret);
 		return ret;
 	}
 
@@ -134,7 +139,7 @@ static void ptn3460_pre_enable(struct drm_bridge *bridge)
 
 	ret = ptn3460_select_edid(ptn_bridge);
 	if (ret)
-		DRM_ERROR("Select EDID failed ret=%d\n", ret);
+		drm_err(bridge->dev, "Select EDID failed ret=%d\n", ret);
 
 	ptn_bridge->enabled = true;
 }
@@ -166,10 +171,8 @@ static const struct drm_edid *ptn3460_edid_read(struct drm_bridge *bridge,
 	ptn3460_pre_enable(&ptn_bridge->bridge);
 
 	edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!edid) {
-		DRM_ERROR("Failed to allocate EDID\n");
+	if (!edid)
 		goto out;
-	}
 
 	ret = ptn3460_read_bytes(ptn_bridge, PTN3460_EDID_ADDR, edid,
 				 EDID_LENGTH);
@@ -233,7 +236,7 @@ static int ptn3460_bridge_attach(struct drm_bridge *bridge,
 	ret = drm_connector_init(bridge->dev, &ptn_bridge->connector,
 			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
 	if (ret) {
-		DRM_ERROR("Failed to initialize connector with drm\n");
+		drm_err(bridge->dev, "Failed to initialize connector with drm\n");
 		return ret;
 	}
 	drm_connector_helper_add(&ptn_bridge->connector,
@@ -289,7 +292,7 @@ static int ptn3460_probe(struct i2c_client *client)
 						GPIOD_OUT_LOW);
 	if (IS_ERR(ptn_bridge->gpio_rst_n)) {
 		ret = PTR_ERR(ptn_bridge->gpio_rst_n);
-		DRM_ERROR("cannot get gpio_rst_n %d\n", ret);
+		dev_err(dev, "cannot get gpio_rst_n %d\n", ret);
 		return ret;
 	}
 
-- 
2.43.0

