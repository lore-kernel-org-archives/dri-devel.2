Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E4AF4368D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8856610E2A1;
	Fri, 17 Apr 2026 11:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IsPLB2wT";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319AF10E2A1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 11:33:20 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso310238b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776425600; x=1777030400; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EJE1EtDskVc3fllBZ5ebizZXuuApx+bNxnjPDCy6KQM=;
 b=IsPLB2wTwWH9jjt8Y6Id7AhoU8s/mepI8bta5YGrfEKJ9AjqEzWxfAhKDHZzpiYrOZ
 GfjXdwKPMlxlrJVJufWYRqNgaIAY81+QQz3f3nPShbCvtITp/xU7AliBaAgMIoC0C6wZ
 cN55irRUSY8xM+rt4UDl4DJ0V9RUkc/DAvO+G8y0Btu8IQtdAh2HjzqLrVoTaeP/lPkR
 jrtwfB3O3M/bc4152oFsFOa2cpWpsP/EsV29LkncZB0F8GWS3C0nWDePXVuiay/+xcsM
 sm+B9wnO7OPGwXWDHScmFkg/xiDRoq6A8KcxQbHiIWW5wkG+TpGrTt6KqDMPxBMg6oSG
 zTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776425600; x=1777030400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJE1EtDskVc3fllBZ5ebizZXuuApx+bNxnjPDCy6KQM=;
 b=NmJ60b16zwKQzI57HqCu+3btQYtgWj7p3LY/VuHndGM3U7tCtA3k8J1oiX6YvdwRpB
 ng0wTX6CPHLyZIPRHnq+hKrNW9ivBukmOv2MeijLTPxZciNF4njfNVdhvZdLMIXdsiYa
 zvgJI/Fb2mgRuFmduEIyKR1rltvxLANTvHjM/H7xsD6btXMT7yu6sm1zWnbL9hLcEi+N
 dhptgTYL0S56vRaAZxoCUdsIwEWkO/xXZ45FbzmFyCBN0EcTfi1qKWEoLG0Lj8i0sfr2
 D27MxwqLXneOcKhSwzhfwSd0YG9XbBljwxNRVUA4uQwFB7C+dRosKYTb+JfOZ+BRo6z5
 Wtgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9deqWQqsoVRFySRVNqKjn+0wIeN5FiQt+siertyFvoppv977YvPMJgA7SIiCkcqwWhCjWtM8nE8cE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPPGn4NcG/yFI6jjwGCkR3Ah+EYcAHY5O8y9/xymC2YgbR4mYm
 2ACoGpC5Da2gBns2rcuTUNyk1uK7CBfsk78tTzSG1vFGdnW+ttKG3D0d
X-Gm-Gg: AeBDieuzvwDeoL2s2kyl+xXfrb4gHV39aNSXqHN0S0OFLPk14nMnTZXlAe+I7WHMFxm
 zCQ+mpWpOy3BPe/Lfg1fz72wnlsRE017S8MwzJyMK6g7Mj8tS1yTCTvziOmLSOOHwzP4ZXZsZQR
 oIdl4o0UvF/5VgAswsGiWh9M2HKrfvgJl2U03UifsnM/0FmQdh8Ikh3STx/GXs34ubTehkOc1KJ
 YX5sZFfe5iuOE+qOqIyvW4PPeZIjnYezW+nk/nj+kTJ8K1y9kqtKKUg52NvX6eU3rVcjC+g9v9t
 DxLlO2YGySUpWMM6eeToAnnktUrc1gc5H9kvUSWxARKyHKcWdwl0aPkkrEMsGmQn0El1zJrodHv
 hsVqsMSSanfHrayrHceuktiA9AcaNpRRMDPmDnlTsFVZ1t5Aj7POvHc25s5R+qddRq1+qgdonwh
 Enf7bQrQPUsNxPYZXSLVbRelTl3ZsOlCamHgnAjwPPmWUNGFpW7LNMCg==
X-Received: by 2002:a05:6a00:bc10:b0:82a:64c7:8c6d with SMTP id
 d2e1a72fcca58-82f8c8bc5famr2390055b3a.25.1776425599584; 
 Fri, 17 Apr 2026 04:33:19 -0700 (PDT)
Received: from dbc5pt3-os.ban-spse ([165.204.156.251])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb38f2sm1610998b3a.30.2026.04.17.04.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 04:33:19 -0700 (PDT)
From: sai madhu <suryasaimadhu369@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 sai madhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] drm/mediatek: hdmi: Convert DRM_ERROR() to drm_err()
Date: Fri, 17 Apr 2026 11:33:10 +0000
Message-Id: <20260417113310.2903091-1-suryasaimadhu369@gmail.com>
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

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 1ea259854780..f431fc9adca5 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -981,8 +981,9 @@ static int mtk_hdmi_bridge_attach(struct drm_bridge *bridge,
 	int ret;
 
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
-		DRM_ERROR("%s: The flag DRM_BRIDGE_ATTACH_NO_CONNECTOR must be supplied\n",
-			  __func__);
+		drm_err(bridge->dev,
+			"%s: The flag DRM_BRIDGE_ATTACH_NO_CONNECTOR must be supplied\n",
+			__func__);
 		return -EINVAL;
 	}
 
-- 
2.34.1

