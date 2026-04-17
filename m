Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03288F43699
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE5F10E2AC;
	Fri, 17 Apr 2026 12:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q06A8yiT";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A0410E2AC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:27:38 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-35fc258aaa4so407847a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776428858; x=1777033658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7B1zAJzyc2aJm8FtQJrwknWWRUXny98vqjyGldOGID0=;
 b=Q06A8yiTes/eOpGlKOZxtoujbTrGpzE+EPmk2j+t3XOKHGBLPQoz4KMpxtruc4h2pA
 FxRmoNN/xR7YgLHbg3H5vuA7MnWS3o49m3V7WwPQy0OD7WTSiJ0XAoeeyC43N5eSfgQ7
 VGv05wlzebGPOxaeP/TCmUVtxysC1RJzHiMlAhinx6LSp0Cj1PniGeZbjKzCZzVFAIUR
 aibiNZiXB4zrAsKEST7QsZXmsQN1nY7Iz1dxpfiTq/q7Lb8GGzRARlPR6di6ATyrjeye
 1GAyuRdF4T4i39HbXFHerdESdoOqEYuDXj3jxx95vSFHF5PaRdMH+TLPfuiND4y6eADC
 57fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776428858; x=1777033658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7B1zAJzyc2aJm8FtQJrwknWWRUXny98vqjyGldOGID0=;
 b=TwesPr59uiCSgaNriAEwaDuk4TguQQEovwuOHDogbjWzoZC9v04dkfFOKH08c2qUF7
 kV73YhnYg9SgVW1Hh+0T7zxf4hrUmGmEPXzM9KSIhslFzVgcvjzP9UlhFTZVXSCBHLAA
 3bD390DFeLMYEWp3VUQ2an0axwYA91NWVXjlPYqs5i6dD2qYZwC6eX/8lyj0HNpHeEs8
 KSJ2y+1lrsdapq3kqXP6I+jwrtYfrL1RFPtdYJRAecmt6F4FnJLW3WDhASAzSog8lK/5
 MY/J+qhVidQZte52D7YkhgprkuQaJ2YlrBjo0SqltQVtj2NAdF8sELDhAxLFrMiWr3zL
 PuAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sHLG8hVdj3HTipxffd4W0xwXrqtXNCRWNZ7vf9W9aPrhK49sWeCMY+2I1HUa8q+ao3NDLhPj4FdY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2Dw4V3LoogjkMKGZjUPFkDjJWEmvLQf3J25UiTZu6xwfgQeNP
 9cr8pT5mAZ7Lm1I74SW7Oi9ZiKg6u/qYUJoRQMmGpUHDyRDTLEPY5HEfejaeMSCC
X-Gm-Gg: AeBDievoLHveJ7x28tKaCCgru/tJ0EczYHS0MNl3EDNI5dmGGXVp1gN8tOs9a7Yd2w5
 Owd6WV6sGARfX8KR20ngVB0DCrpoCHvUY0vXCI4HeIP7/64WmhqthQH7sya5WPRwasgyqoVN6eI
 wQls89pQ1E3KnBCquqs59MMfXvDI6XvU/IjDFuDDHgl/4w7W4c/PgcHkNLf99b9xmbol701uU9w
 3Tq1sbi5B1k/QgCYs1ItAerwt1shW9fKtpBxux3zvQFhjQvESrTWKlYLldo8OIf0NdGXTqEaj+d
 Z7DKdbhCujpZq6lKaCVfCAiD7VVvtM/XUfe/btipZ8BhfpjCZv9y3vDnQVVGlvarMsO+QYoUbL/
 jC9Awq3elJeZxzMhB6H/cM1PhXsXvq/eIKgRE1rOmMrAHWVGas3A7fZOKq25Wye6vQQSDpanLuw
 I/rqeuAhvxd5HBcM1ZifUbpkMHxTu9T2b9DJEy/Y39g1qhnZLn8mrOQw==
X-Received: by 2002:a17:90b:1e0b:b0:35d:a542:2dcb with SMTP id
 98e67ed59e1d1-3614048a731mr2630632a91.16.1776428858176; 
 Fri, 17 Apr 2026 05:27:38 -0700 (PDT)
Received: from dbc5pt3-os.ban-spse ([165.204.156.251])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410cc196sm2074491a91.17.2026.04.17.05.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:27:37 -0700 (PDT)
From: sai madhu <suryasaimadhu369@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 sai madhu <suryasaimadhu369@gmail.com>
Subject: [PATCH v2] drm/mediatek: hdmi: Convert DRM_ERROR() to drm_err()
Date: Fri, 17 Apr 2026 12:27:26 +0000
Message-Id: <20260417122726.2948518-1-suryasaimadhu369@gmail.com>
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

