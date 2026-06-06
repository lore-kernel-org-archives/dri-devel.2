Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584CACD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2507A10EA6E;
	Sun,  7 Jun 2026 14:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e58AHwZa";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E27F10E851
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 19:37:15 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-36dd65b95f2so2151039a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780774635; x=1781379435; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+43EY84zwzHSvE3hWC7Aijln7VxPvpBd5QgvDEGIk7A=;
 b=e58AHwZaCI8onGyclf0s/lUji6FyycUx0tEy7LKqpS8Xm8FpdhOAZ3A/wL4GHVjmLc
 EoR3PpI/34o9l5q1GAiZB2h0kO06KZGaS7Jcb7g4OpZZfq7Ii3IGjItdeLOk4sUJ+XcD
 qB+sgmat8pmcvyuu8jVJahxvPTmJ19d0vlwNpkUCSZqeTt1dKO1oEidk2NYa+vnQyqM2
 J/Agt3QLBkt7EAsugTcm9921XlDhFl9oWjW3VKSUgkl3u+RI2u/OYryyZO/SKEbd/QKc
 d9sTfTqexuEt41ZyUZcIfh9N175/a5WXbzKNo64+JqhUdVsLYKeI2ZsXfUwv8FbZXxez
 zdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780774635; x=1781379435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+43EY84zwzHSvE3hWC7Aijln7VxPvpBd5QgvDEGIk7A=;
 b=SFcBtUPIlHaV75xVvIOyw2tIcTIQ2kk1IYygJooFGqItsFUzKeQJ42/2z4krVHj5oc
 kdGKKtVfbk9ljknwVQAXSNvzkM+bhDxnLkkjKD6gS3iklr4q4OzHUKtmQaNRzuwU835X
 CDFK4lqTQ8r0Cv/EUNgHow+EP4GGwOwBRVQga0+p3Ou1KeYOB0p52y4sOaA4LPuKDFiF
 SOUwNoJMHA8bQiTqQ0B0a2kYX9kJctzj8bCfcLg2ydczuuq9LpXb2ya1PVFO91pWm4HB
 CX5dfQqKtDjcpTAnX2QEWK0CHlNkwQeIgudNqJpiUhyLzr4fW7oUrpzVDOlUSjCFAejW
 lXTQ==
X-Gm-Message-State: AOJu0YxHOBBJ8Y//u/ZzuDcvBB0ivEdOTweofoh+/HLJuF6Ved2caf0/
 PJHsy7G5QY8olNsVgh0Ntk1D+Q3qfXGOLhu3ufB30Xanr/1V8R+zOqUrBX5jew==
X-Gm-Gg: Acq92OGppElACAh56/DaLeVYFgUaYMEESGI1znLtKNLsnRywr/boCc6/rOr/ELrxX2J
 8KxzHyiLuokHhuQzwk/XbzAgxG+aN6C8m39PbUtdC6Fz78cjEQO2rhdgvRcHnIB8/uLFwxFX5kB
 JgN/kuLPEsCZZnzkZWukT5IG2zDARwlMOUaIgwbHSjNEufDUoOwAJ1Rj2B+DTVIwjvgCuICeGD7
 uQWLRbYwK8V6L1KhlJczSHT8D9A/T5vxtt/QgvVIQLVlGuoOPu0rg1ehynxRB91pC/kEYa1+ggK
 peo3/PCFkNgqLBrZ+XNYBW2HYVXXM0UOniOVCZG6+4E7hjaZT+Ve8XC7tg8sQ4CJYbe/vt0HzjA
 wLP+8ILmFVhrpLAW/PBnMlChkKs1z7G34W1zaC0iU6dr+1fl8WMJNc842UfeBKvlgWuZYTCAbrK
 rd3xsGc0EQC6h7j8Jh/SFRt1TfbbxYs8B3UGzNPd1Hx4WbqhaDLP9/2iBKYcutaLo+VC0rXyQw/
 HhGCVLaUicBrxPdN2TbLuaxLPE3Ke6vZMRULRzt6bTW/5NmbrsS/A==
X-Received: by 2002:a17:90b:5106:b0:369:9469:aeba with SMTP id
 98e67ed59e1d1-3712ffaa5bcmr6507175a91.1.1780774635302; 
 Sat, 06 Jun 2026 12:37:15 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA..
 ([2409:40c1:400d:d07e:31c5:fce9:e168:2f2f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37135861581sm3003643a91.2.2026.06.06.12.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 12:37:14 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, robert.foss@linaro.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/bridge: simple-bridge: replace deprecated DRM logging
 macros
Date: Sun,  7 Jun 2026 01:06:15 +0530
Message-ID: <20260606193625.24465-2-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606193625.24465-1-piyushpatle228@gmail.com>
References: <20260606193625.24465-1-piyushpatle228@gmail.com>
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

Replace deprecated DRM_ERROR() and DRM_INFO() with device-aware
drm_err() and drm_info(), passing bridge->dev or connector->dev.

This is preferred over the plain pr_err()/pr_info() suggested by
the deprecation note as it associates log output with the DRM device.

No functional changes.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 8aa31ca3c72d..d8457e68c342 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -56,7 +56,7 @@ static int simple_bridge_get_modes(struct drm_connector *connector)
 	if (sbridge->bridge.next_bridge->ops & DRM_BRIDGE_OP_EDID) {
 		drm_edid = drm_bridge_edid_read(sbridge->bridge.next_bridge, connector);
 		if (!drm_edid)
-			DRM_INFO("EDID read failed. Fallback to standard modes\n");
+			drm_info(connector->dev, "EDID read failed. Fallback to standard modes\n");
 	} else {
 		drm_edid = NULL;
 	}
@@ -123,7 +123,7 @@ static int simple_bridge_attach(struct drm_bridge *bridge,
 					  sbridge->info->connector_type,
 					  sbridge->bridge.next_bridge->ddc);
 	if (ret) {
-		DRM_ERROR("Failed to initialize connector\n");
+		drm_err(bridge->dev, "Failed to initialize connector\n");
 		return ret;
 	}
 
@@ -140,7 +140,7 @@ static void simple_bridge_enable(struct drm_bridge *bridge)
 	if (sbridge->vdd) {
 		ret = regulator_enable(sbridge->vdd);
 		if (ret)
-			DRM_ERROR("Failed to enable vdd regulator: %d\n", ret);
+			drm_err(bridge->dev, "Failed to enable vdd regulator: %d\n", ret);
 	}
 
 	gpiod_set_value_cansleep(sbridge->enable, 1);
-- 
2.43.0

