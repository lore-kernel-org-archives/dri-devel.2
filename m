Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CDDCD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6497F10EA73;
	Sun,  7 Jun 2026 14:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BAE4/yGr";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991E910E851
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 19:37:37 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-36ba706ab46so2062157a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780774657; x=1781379457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9sGqKD3Nn4GenGBXPwklz1tPwmdqubX+JSFj+4RqhU=;
 b=BAE4/yGriED6dmNh0ZOQ+7Qvz2Yu+GUYakTRi+SrE0SAF2lNk4vICnkBA7PY4wD73L
 aaE+kEJDk1ymt+hjXw46ReFe6RIygQ0GRd8q+to2iUp6inVKcrA0ex7UNaJvNUJEIeLh
 okH29YPa1dz3/8G2SuleRSenPUEuR/Ca3GxpmXf7md66jf7Nw52KLf+GIOGau+3HwjET
 soH6D+95TCFwxQ8lv+hyXV6WnYEJUctH5oIzgNsD8ffIesXfZMD40ymuEPicrD9F7j87
 ZZ9YWGiesxOPtiZaad6YXJZFBUff/MZPGuStTy/pWPGLVfDC7gT4mXxQzSVPWM0nXCGI
 iU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780774657; x=1781379457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p9sGqKD3Nn4GenGBXPwklz1tPwmdqubX+JSFj+4RqhU=;
 b=jlSq559PbbTi9p+d9NTGGLjalvGtk3uiZhH/WxVymsdIsVsqwf9yubNwIxIXiCaulK
 74qc1yPPGQK+p78L3gjSotcKhT05qJQdtmxL1dFmpSupeD0/Z0JIinATM+mCn8nipr5E
 OytPdR5MZ4G/NZM+NJbSfpfENvR1hFB5c+DTVyuwfdmBEiJfAOik/pnyLX12NM+PoYQa
 BycFZ1AISgiLh26iPzzPJkWrNCM/0nT2dKP1adGCAZBc+3Wo8Wx5IGAxO/M72ywIGvox
 v/pViPkkRxEALkfrEXjw3THV6tmBVBN/8hPRxzDSrHW2qFkQnbslkXlba3cDQUeM8B/6
 rVBg==
X-Gm-Message-State: AOJu0YwHbZHhS9/PWVmxRQKYV/0JmHTU7ucIXMS7ADfOrbMFjrE7VWRP
 RPfKO2crqXLkbIuLs42muiI45aFiIuZJ8+4WnqwmG65kGCBn1tVT5rnz75+f6Q==
X-Gm-Gg: Acq92OFuHNrvUDFrZqpPNC4r2gfctpHtIUCS+eZp38PeIXviR1Z87vgTk6nPcpY/U3M
 FtSSZKLd5odai3jxcjAbC0Rm345hMNSjM5Uc87LkXLplf6+hw6A6hItl8NJveAXv2ZsDlCylO6a
 racG+gB3vK+T/PpaULEihebYAbP1AvCiIbzLom+mk8lc49tPKf0HmoVVqHGcsuw+svWJFXXhu9o
 q/MJ3pAsG/RVnmkJF3QOzQp5Gcpvqf02aihYvF78TJOULHwqmvsP5HVHT6brZCzLHiuTnX0YmCY
 nipdWu3Sp1fAQcqehthsRpB6R4D+vb3Tgf5f9d+hRuFiHeMBndRC6yCIiKIgzlqyZ3HiFhJFcTE
 fTtUOse5L2YzxVBdiDO2FJ6p5NGpRWmiQbMIgKkvkF3pDJ7okMrvzwrAJ4xUaDJ7hacQ5M1xoNW
 3VikWGmTG1wQaksMDLwVQiI3f3lcODlGNF9yUNP0pzjE+SFAHUSU1as9ybSyHmLo9Tv2WckmMaw
 gBKVomg6fR/1pYTiMjJt7XMFaxG4DnpbluoWHsqJiciOzmzBrAMZA==
X-Received: by 2002:a17:90b:4a50:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-370f0c4ecf2mr9805643a91.21.1780774657017; 
 Sat, 06 Jun 2026 12:37:37 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA..
 ([2409:40c1:400d:d07e:31c5:fce9:e168:2f2f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37135861581sm3003643a91.2.2026.06.06.12.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 12:37:36 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, robert.foss@linaro.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/bridge: panel: replace deprecated DRM_ERROR macro
Date: Sun,  7 Jun 2026 01:06:18 +0530
Message-ID: <20260606193625.24465-5-piyushpatle228@gmail.com>
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

Replace DRM_ERROR() with device-aware drm_err() using bridge->dev.

No functional changes.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/gpu/drm/bridge/panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 184a8b7049a7..3f96af335e06 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -76,7 +76,7 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 				 &panel_bridge_connector_funcs,
 				 panel_bridge->connector_type);
 	if (ret) {
-		DRM_ERROR("Failed to initialize connector\n");
+		drm_err(bridge->dev, "Failed to initialize connector\n");
 		return ret;
 	}
 
-- 
2.43.0

