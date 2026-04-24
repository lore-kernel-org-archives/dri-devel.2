Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19607FED3F5
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0780C10F672;
	Fri, 24 Apr 2026 17:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pu93MfAb";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71F610F58A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:41:25 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c7961d7bc09so3021180a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777034485; x=1777639285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tw+sV1MN9XAqodteHf/ZuOTHc06u4X1pLw8kExk0mZQ=;
 b=Pu93MfAbDUPVwQbHYnRLNBSkmAdQqI4KRUUfe0TntSmb/HlxCrQey8MOgkcZW1bQ2w
 nfb0GHAob+ReU+ikllEzo9KjL9mAqfatE4S1mmAT14zD04c5eRpYE12iODNECk3zdzRF
 kFpQTZqOU2YHo+bPmohDcrnkgaCqJk37pMJqGoBIDnJpDPem8kMJjMuKER6RSvxTAfZK
 R2qt9/FYuWFH9eCjuMts3jp48JwpPP9eV+JP0toym1ppmh8qZTEV1fnd10cpWZFNvWTd
 jUFAUF6Qs5RoaSpmhRa7myaXPComUAhF4ckNBOxfahdgf1uPykFrbT/LW00YQOmVt8Bk
 9d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777034485; x=1777639285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tw+sV1MN9XAqodteHf/ZuOTHc06u4X1pLw8kExk0mZQ=;
 b=SidMP720sZHUum4+TnvNyJyfrn/uRCHk9NsLHBjGXScLVYxnEBI+lGeqKIO/Q+hb5l
 9gjtZ/OzGOjUKQo41nU14ajCITlleZToGwxSSwp7rZ3kjfSls1gEXaNnXukh/KtGCYJE
 1MW6oM5UcHhjLbpLgh0m/3WY4jom1GCUewdEewIv/eink28E5ICrWGJXyXbqB1PBB2ib
 +33LcGD6AJYQ24iTdgqXSJQECuKh90YkqS2lQe9duFaZr8wbpvLAZalRdMQfsQun1ECx
 ZJeYXGlxYKRiTKWHitK+mdiDJVNUcmNK/CDyU38efmSysu9sfEp9MMcam2dODrNv2Ibu
 Dr8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bmOe7dTTjiqTjp/vxqGbx9Cw4RBZkISSduYViqzwi21pUsC80XFWuX7JXABRS4B+UKVWAoX40vDc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDHs8MAZzhRMryNk92LUrD3xiN8FvY6JJWpJDKe7scFdIKHxi/
 DWEg+1UjUbS4dkkrgyH0JhQQgTfzcYUzLjSZ5Ap+HLztJm83NvqcvaE=
X-Gm-Gg: AeBDiev1q3Bt/P6XhQpNWuMYtmd7kIp1Cdg7+XKcapoXAZ3Vqhe1ka0g4pNsPdq3e2M
 SWb5Zoxc0OmKwyE+xJG4e8XIJYEiN2IDDlMkW1fxfjXR/RTt2sXpJnv51h9VJSod4RNgNia1Fp8
 pH8PY1ITxCddAlekHrB/MWl0h+emb4Ic/lBkVFCeKj5P6xLY8tIBFBzPUh9ScAlhDm71E3o28Vr
 LUZ+8gIMfo8aVv7uH6itgbseADwwQFPF+kzRfzJq+DLGhOzJl6ITG8hSPGlK9DP7ZBUUb/Fe5Ag
 AVNtbZ3zbK3N2Ih2nrHQhIfd26/BHkjh1Kh7quNyphxXwo/Ip0NLGGRUnvl/RJ32PouAMQ44yXW
 gMnja6/oguhZqpHohJiFc2I1ohzYPhxytH4N7av/c1dU14EfX4bA47v9N8zkud+QkegrlrGFDwM
 ZtK2o/mzkDJDiH+uqnoJrAVa6DcB/2acvpk2UdmM2RBGe44uyTgalxVsMJsR6jW5k+Hm2gcYu4E
 jl18Gd9Ig==
X-Received: by 2002:a05:6a20:12d0:b0:38d:fad1:cf2a with SMTP id
 adf61e73a8af0-3a08d703690mr37610650637.13.1777034485284; 
 Fri, 24 Apr 2026 05:41:25 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f8f4e8sm17821901a12.1.2026.04.24.05.41.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 05:41:24 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tve200: Fix probe cleanup after register failure
Date: Fri, 24 Apr 2026 21:40:39 +0900
Message-ID: <20260424124118.38649-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

tve200_modeset_init() creates a panel bridge and initializes the DRM
mode config before tve200_probe() registers the DRM device. If
drm_dev_register() fails, probe returns an error and the driver's remove
callback is not called, so those modeset resources are left behind.

Unwind the panel bridge and mode config on that failure path before
disabling the clock and dropping the DRM device reference.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/tve200/tve200_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index a048e37f1c..562f3f1181 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -221,12 +221,16 @@ static int tve200_probe(struct platform_device *pdev)
 
 	ret = drm_dev_register(drm, 0);
 	if (ret < 0)
-		goto clk_disable;
+		goto mode_config_cleanup;
 
 	drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB565);
 
 	return 0;
 
+mode_config_cleanup:
+	if (priv->panel)
+		drm_panel_bridge_remove(priv->bridge);
+	drm_mode_config_cleanup(drm);
 clk_disable:
 	clk_disable_unprepare(priv->pclk);
 dev_unref:
-- 
2.50.1
