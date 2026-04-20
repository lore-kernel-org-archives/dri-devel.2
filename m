Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F95F36C2A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 06:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B842410E42B;
	Mon, 20 Apr 2026 06:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fxFEhKXK";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681CB10E42B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:45:54 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c7980c060cfso446843a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 23:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776667554; x=1777272354; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7B1zAJzyc2aJm8FtQJrwknWWRUXny98vqjyGldOGID0=;
 b=fxFEhKXKIJTxHNlwEhM3ZbPffc2YXHkpbXLe6SCnDbv9hs07tVglDLo6E86NTHXrV+
 ofxcw3iPUqUXlquUTxeJ1CtoPuB8RT6Y6uE/V8Fvzht53S+Zc3lK66rBOkTvqHQf3Cyq
 zL3fcvyHk1oJwiFC3VdsYNuHg/D3EjvXc3nNKgU3tBCfgr6MM+G4JTJuTONrptMlvr9m
 yqkk5xsorqq7ULRcVY1kmP6j8EVHbyPF4EolfxkE7iWjmGzLJKuUHwe8C7+KBZxFxljO
 +R5uj/U+AuOwJPwNVe0KSi8gOVAyAu2C9V1X1Xvq6l+4i4j5DWZ+UYPMGzR/YEQ4PKIm
 ctzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776667554; x=1777272354;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7B1zAJzyc2aJm8FtQJrwknWWRUXny98vqjyGldOGID0=;
 b=S60sKPAj7k4Dagi47gLgXn4crUd9SInBsO7XsHxwJ44ewwJDyx/CvmN19LNgYJDvFN
 2UNnCN8DsLBTziiuFQojPwyAzaFKEBNbVDnBrJfQU0l37y0otIMGoRejZV7v7OnU26Cc
 YaI8rr+ub2dOFQVadV3SvF+ndds8PraIVV5lakBGqKHt+IXjAH0S7LApJZRJ4BQKkINL
 wMefCVRVSO0jd2W1T1qI95yUwDSD3ihCbXaLWGFXNnIXPRZAOJvPHW5tPl9JBmaAHtp9
 4jKl7mEn8379EWHBnkD8xm8YZt7ycncSdcH01iX+KjwfcQchHZ6K6kskltpYV81Q2wYb
 bS4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Pc3A9dmEdGMm9kv7lmPmniNBA+muYXctT2EQmwv6E6OTH16srOotBGCkrX5DFH4q4FbHD5Kw0smI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz82H91CQotsYHRkmLQCqTYZksV2yXoSa3KkD7DpJ/DnYW8FCE
 UCxPzhiWff+lfZTSpesGyey4v/eE2sanyUYytzMfqdjHOzwUqtDZTEJ3l5zj+OF9
X-Gm-Gg: AeBDiesuPcO33ry6hx/3iy/nIJbGpswbUczzhHQF3v0FqEQJ9pECJ4WURq0aefC6f+R
 /RF7jPg7e4SINEPBgRvp/lU+DuWisqmb/7okLATXNIf5mBvmFPHKZqJxn+6DSgVtP2MnS/rildt
 jst4kNqIsODah/PNJvyrX7AhXAf4dE5R8iSD3hTodoerYcENbwDoP9QihsGUOhJVt+EBiSmqy+p
 thh24d56hjC0irc7xLXxbuGWCxBGnIUEL+b2utHIydnxWiWE2EfgQLyk76Sm6GT1LtudPaxlb9c
 qI7jUdxdyycuQw1cb1oxmu6tb8lVbH4Bw4qqxek7mdbQfs60n/uObFh0Eo2DNbyqRAyTt3FxR2+
 AUsG7zg980GHNAEyq8yFS5ouv4qcD1nVM8e/hTi91iCTJZF0YI2EtvQISBD6QTdC1fB9KUy+HYX
 8ZZ4037LgrLGWutoqInrTZRgKHlDhwm2wSvpf7aZUHhCaB9DvJ8xasoA==
X-Received: by 2002:a05:6a00:1891:b0:82a:f02:7355 with SMTP id
 d2e1a72fcca58-82f8c97a4admr12481591b3a.32.1776667553827; 
 Sun, 19 Apr 2026 23:45:53 -0700 (PDT)
Received: from dbc5pt3-os.ban-spse ([165.204.156.251])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe68ebsm10509177b3a.47.2026.04.19.23.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 23:45:53 -0700 (PDT)
From: sai madhu <suryasaimadhu369@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 sai madhu <suryasaimadhu369@gmail.com>
Subject: [PATCH v2] drm/mediatek: hdmi: Convert DRM_ERROR() to drm_err()
Date: Mon, 20 Apr 2026 06:45:44 +0000
Message-Id: <20260420064544.266478-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The DRM_ERROR() macro is deprecated in favor of drm_err() which
provides device-specific logging.

Replace DRM_ERROR() with drm_err() in the Mediatek HDMI bridge
driver and pass the drm_device pointer via bridge->dev.

No functional change intended.

Signed-off-by: sai madhu <suryasaimadhu369@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 1ea259854780..4ddcdbf7bc8c 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -981,8 +981,8 @@ static int mtk_hdmi_bridge_attach(struct drm_bridge *bridge,
 	int ret;
 
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
-		DRM_ERROR("%s: The flag DRM_BRIDGE_ATTACH_NO_CONNECTOR must be supplied\n",
-			  __func__);
+		drm_err(bridge->dev,
+			"DRM_BRIDGE_ATTACH_NO_CONNECTOR must be supplied\n");
 		return -EINVAL;
 	}
 
-- 
2.34.1

