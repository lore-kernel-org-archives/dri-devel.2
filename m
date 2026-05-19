Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119DACD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7178A10EB0A;
	Tue, 19 May 2026 08:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="erUm8dFX";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1542110EB05
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:01:22 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-367c26471f5so1956543a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779177681; x=1779782481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=07d/k8eN4Hdpw9AEiZl/+4+x3cCvfjw/+oxM3VP8ero=;
 b=erUm8dFXDqwmKtLOkfqJW/kaogFRrrUahpKS25F1EfX7riCWIMsf2BiIYwAJPFALJp
 lc7YkqEZR+pmBbF+zUrA2tIxLmdhdjMzQ9A3v05x9JtNqqknX9E6vWYY21ZX8K9ZmjVT
 Ql3tmcI8+2gr0V78RQzLrSnykUIvDQdyyaiYVkFi/gyR1Ybv0ul/qk27MNRh4gcXQZbr
 TX6MD8TukNdcgevXXbwCbhyJpWGjTjmDnQtp5xmq6lo7Y7ZZhyPuMCSDPY1rNumvMVa6
 bx8rsb6RnKqgVlWEhCBtUsdd53KvC8cE2PshK7f4TqlryjLg4sjn4btS5FZ8bLSdJNXA
 VM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779177681; x=1779782481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07d/k8eN4Hdpw9AEiZl/+4+x3cCvfjw/+oxM3VP8ero=;
 b=i/5JZ1peZ364M9Qj3gOpD0LCJjVmVUmfCi2LdjEK9tJxZIgAiA2kTzqwcr+KGsa5hn
 ubU6W7ghEo1wT3JKY/4ArEiIfTkg4z/PStp/fZqGNCw0ql+Qt+Nxgf1U+o5XqMP9DD9a
 d8DiFIG0EcHkx1/huWBdjF5Z8603iRsSVuvkBe9gke/SrRYSCvF9pRF9QyM4VFH71hiO
 AGtb7bVoyeyv0a0fd/q5V6mVrO30HF9Mr1tAKq5xqDUsa47kmtCNCpgc/591a8Eoss4f
 Mb5EL18ghKpLEud3nrZ6YunPstlqF0Z+308rXyK+dZ9tOMb64FzmJ6WPt/M/m5CT/DrU
 UQVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Og85D3IBju6RO3O+aM1J+pOteEGsrleFIZrVei5mketAVVlLg5x0m+J6cHtbXUSZotAdqR/jQ3yk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdRedPe8NNdAr7FYQqC30KF5ViacXSE/mc84NsjN4GFUZ/aOB6
 WrM2h9BldNYiy7EXqnaVotHdx9Yl+b8RXa31G3WgqRk2W0NTWVEr+dhK
X-Gm-Gg: Acq92OGKv0HcyTlcBnJp4kzroxdIe9n5L62rms3IBMqHgo3qLN4RXzXLRR8s/lJX/ed
 hgf2SDyvc8bftTmUICzY7kPdd1Sv8Ny2yT3CHxPiMO6VB0yAO/r2EyGZE+n5zYe3U1uFPAfIeQA
 8aYQ6XcEKK3RSWM0LXn+H9tRlvONI/DyacV8bra9r81rGNCdITJtcGrY1WvCHCK8EZK8CMYayTy
 R5B0MFRg6pC5+X4bt1PtRyodnceFkiXh4kW/YRaF++brWwt69rpLMdCNfizmd8f7aapZNUIuGfs
 W7AVOxntc0MSqNGRzWFMwyDHqtSgv0yoQX5zcluqpP/yKQE4ULp23hGImS/Xez7PDLhrWP5OPoy
 ztM80icfsock6h/4Zv/lvsCWrLyUWjONXg18Rip2ZLBcoLsYSaHGPKQZXKeauBzAm9GnSKjv5Dt
 jpyTT0+g==
X-Received: by 2002:a17:90a:2ce6:b0:369:b957:1d8a with SMTP id
 98e67ed59e1d1-369b9571fb4mr4786555a91.24.1779177681543; 
 Tue, 19 May 2026 01:01:21 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369c5f0eb2bsm5612001a91.7.2026.05.19.01.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:01:20 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kyungmin Park <kyungmin.park@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/mipi-dsi: Fix reference count leak in
 mipi_dsi_device_register_full
Date: Tue, 19 May 2026 15:59:05 +0800
Message-ID: <20260519075905.1038684-1-lgs201920130244@gmail.com>
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

mipi_dsi_device_alloc() initializes the embedded device. If
mipi_dsi_device_add() fails, put_device() should be called to properly
drop the device reference and release the memory associated with the
object.

The current error path directly frees the mipi_dsi_device with kfree(),
bypassing the device release callback.

This issue was found by a static analysis tool I am developing.

Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 0390e14d3157..862d56eaf934 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -233,7 +233,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 	ret = mipi_dsi_device_add(dsi);
 	if (ret) {
 		dev_err(host->dev, "failed to add DSI device %d\n", ret);
-		kfree(dsi);
+		put_device(&dsi->dev);
 		return ERR_PTR(ret);
 	}
 
-- 
2.43.0

