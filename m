Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A3AC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB4410E02F;
	Mon,  6 Jul 2026 14:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aiuCwKoo";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6648810E02F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 14:27:37 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so14207685e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783348056; x=1783952856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ThmdWFoUi9SJhoiWKeVyJUwaJ8zMIfm7djT8Y8A3Rq8=;
 b=aiuCwKooMu116fW7REI2L2iodaoN6JSkVLOhbIvu0PnNh701eiSgqK/JYz/Dq7kDk/
 WTwHEllvC+YrYWdeNNHCsGynboQwv5VnmSf43Sa0o0yv+SpwNOHqdjveggU8qH4gsKzR
 Slzn3l/y1BSmUJrXR+Wl0vBTe2la3dZ1zXclhakZyrdXjP5e1dy3AuHCxmu7R266tBr0
 5epFA2TVuELrs1fhERGftUXSsv2nOqxToOZHx9QFojj9s5g3ayLXeZzmjUVO6d6P3kYB
 1JmBzQ9Y/6IUSrpoQHsKHZ8BVqtolQYWRVwgpu4ieaRJyRQFTNu9fd5lBaPbjIniBh0B
 k2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783348056; x=1783952856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThmdWFoUi9SJhoiWKeVyJUwaJ8zMIfm7djT8Y8A3Rq8=;
 b=N6PkmQv2U1FhhEEo/YyrIDcbddAjsdJmt+WayU78DAAAO3/PqHrr8RLGH849uXIIg4
 ql2CunaELThDadSHq+8fhTOw+YDzKjhh7g87NLU4CFyHE97ZMs8BUS/v+ZdDO97uei0R
 20I66oGvZndpQAJbZFGIwTRgksjujCDUwVWbV4ACDQ+Hw2O+9YY5PobKKsl/sUgmpmu9
 gCPyThReNKb0QZ8muqFjhZknslAjcad3CXYLdiMD3Ro/pf/+eET2EAikAS8JY2yqjiTr
 gDkrRNcfLuEylS656xzgoYMalkK7X8htfyE0FOqqNdyvspbTXab/hvWMs2JzlSXf2BfN
 DwEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeNGtjHITTvnCOGM2WEC0206BiErpGH40bZypVU4XIDd0VD7ZGwy72kJwsQHuFOF7ZT+ct+BZ/DyA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzckb3SRdCfirkMDtnjLxgK+vcYNpx0nCGlRzjYsrnl9hSs5w+W
 zPWg2LrMOFLwI5JiO14tVlnvNXgpjPC5b7Ud5QwRsxcxUURMIG87yMcO0thUetTsEpk=
X-Gm-Gg: AfdE7ckk4KMFgR+1wjm8WMyXK72lJVvyFaDSNiK9gD6OunHiWGutXfxkIvqQ48OBSPU
 WTQFek4aL4UD0LmrUEtM0g5jIkEOxMtVDVvIDe8otCkZ9765ibvr++7cCf4Kd9OovmUuQ7Tp1dL
 UK09DPcohbKufjGeS6zFT9MRSebV4tGtuGk6YWtLchIqGfJhsO9CX1nuNR1fL7VSLDXATiZV093
 h1fX2+qD99OixXJYSe4TUfByuP9Z4zwj0MF4U0Wnx+ZCg40yFOjQhodjPbZWsO0GQleRwSyiYpd
 WgfMJFZz1u2Hg9YBWgkZ2A0GGXYTWSe0PiolOwGw576bx4V6lnjGk965bKTzrbhjN0P3LouPuFw
 imxl2DzaeqvXabFafYoqgI+YqsNEPnaA3Kdlmf1mAShE94rfvoxfPLPrD0YJ1ZV4d8TJRIVzcBo
 Ya15iLzatFS8rRX82qeSwWF6YbyfxBnLTZXrWUvPTfOvfjOOyHliWFYyuZUZQ=
X-Received: by 2002:a05:600c:8b6f:b0:493:a7bc:5bcf with SMTP id
 5b1f17b1804b1-493df08cf98mr8234245e9.24.1783348055423; 
 Mon, 06 Jul 2026 07:27:35 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:bfda:c630:e88a:7a7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm268422715e9.4.2026.07.06.07.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 07:27:34 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] drm/imx: check parallel-display drm_bridge_attach
Date: Mon,  6 Jul 2026 16:27:32 +0200
Message-ID: <20260706142732.49397-1-osama.abdelkader@gmail.com>
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

check drm_bridge_attach() in parallel-display.c, aligns with ldb/hdmi.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index eb75827394f8..fd48845877cc 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -210,7 +210,9 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret)
+		return ret;
 
 	connector = drm_bridge_connector_init(drm, encoder);
 	if (IS_ERR(connector))
-- 
2.43.0

