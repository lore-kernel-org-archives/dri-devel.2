Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A830F4213F
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 19:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA6210E735;
	Wed, 15 Apr 2026 19:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SkSMOWkG";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87CA10E735
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 19:07:49 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-35d9c7bf9a1so6362577a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776280069; x=1776884869; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PDtRvz4EVThH1+OkwbQhx5LhEh7Xl5HdhpT/91cyYas=;
 b=SkSMOWkGV0w+FkllQbOLZLLQQ4JIVafswUVDqj/xkZZGR7OArZhp6MlFFu38E9pfbV
 F1N6at0ffJDIt1T4XDSeQ7YwHbpRaOvmqCFGpBfllsvSmNu4gy/1rpuem34xj4SQinQC
 kgycqlCiecDU5Meoo61YC04+mJtfW1yOegGs/Vae+iMKmstxBYYGntqPvADz8Uq0yEeO
 Y8rtBQ9Wyb6w0lDPdtCuFoQoeITSIqlXxD6io1HqXVhZGE42eIjt1whHFARAMiPeGJNl
 3BQ1TPZ1Rdlyhk92IO45L4HVMpG4ZxU1cRtu1jpEvkF/YuzvUTIppuckWaDtRztIkINw
 cwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776280069; x=1776884869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDtRvz4EVThH1+OkwbQhx5LhEh7Xl5HdhpT/91cyYas=;
 b=HkEbtWNQeLC19viKJi52iaehvhdErVhGQ22fU5VR/loy0lEX7tR0CsYHkTIZn5Yt5y
 t6C2tSs0JzoizzbK1gntLdHiy2FxF2uqjjRvtvA94k5s0VlqeuqzVbfm/WYlaGlRE2Rp
 s45+M2pJ1ENtoOtVdocFb5/rLAgpq2djJStOgjJRhtWOULtp6g7r/WRpsikcorXH9SU4
 +7frZHTQK0M7z1Y6oGjQ5VI+eZl+trnmaGkSnZPmv+orsz8OIb4+50nisUBCXkrkk6Mo
 4TpRrSfOSyOexdx/nx4NGdpcKM7lccPE4O8QVBmOpFpd2Tdp2MUrbEBVIxuWYyo69v+7
 tJbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pYTNdicPXTpvqHngX9pDWCJG3+blaRQ0OiSQEVJ5JDsgm7CoEInu/hV5zfSLyvvccrfQeXWLhu+Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyapU0DoEJsLz7bMcQ1tViBaLA7mDItF6L4sQrisk8kaeO9v1jz
 7T3M4PzCjETAgzHuSonoCHEVlkpE5twW1N9FXsv0ciDap6vXFRp8CLAP
X-Gm-Gg: AeBDieux2X9bfGlsX8CCfNNTM84nVfgSH91/s+NnZyCWzyQAm9EN6eJDMYZbhko5nWU
 jGKV16LS9EpL0GSp5k77dO17lxnzfwU/kZq743pnWfvfiHEnat1FVKpFiHVfTgdsNzdySOucIY9
 Z+GQc005v+LICO0DGUWEE6xywKi2YqttqYvFrCVHH5tzPE8bvLnScS7jOp0uQ5Z6unTQZRlQdcO
 ZjN1oR2eQGN9wc2uPTM9Jpmq5TBCqz+VETWUT+U8rtS2AbR8a0oiO6Nu7VqfsXMJu9UK3/A9wmG
 zJQhcYS1dLmXxA2PGcb3ZuPvIjUkOV5MrWV7S5THkuNaarmTvlaphJ7tduiB8SLSAVQS4CsynEE
 wCjHwPWnt4FTvno2jEg3OJJmmjCNCZCEoOrb/ckpFBzy/zuHbyPbaNGcPn4Vzd+ziPdmT1b3Nju
 eezVLPMW/tAK3jVqD4CpfFig2Bh5h4wpXg6MM=
X-Received: by 2002:a17:902:9341:b0:2b0:4fb6:85ce with SMTP id
 d9443c01a7336-2b2d5a45a0bmr183001445ad.21.1776280068622; 
 Wed, 15 Apr 2026 12:07:48 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b53e2sm41305185ad.74.2026.04.15.12.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 12:07:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: dnfb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:07:38 +0800
Message-ID: <20260415190738.3821974-1-lgs201920130244@gmail.com>
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

When platform_device_register() fails in dnfb_init(), the embedded
struct device in dnfb_device has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  dnfb_init()
    -> platform_device_register(&dnfb_device)
       -> device_initialize(&dnfb_device.dev)
       -> setup_pdev_dma_masks(&dnfb_device)
       -> platform_device_add(&dnfb_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/dnfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
index c4d24540d9ef..72a9c47418f8 100644
--- a/drivers/video/fbdev/dnfb.c
+++ b/drivers/video/fbdev/dnfb.c
@@ -296,8 +296,10 @@ static int __init dnfb_init(void)
 
 	if (!ret) {
 		ret = platform_device_register(&dnfb_device);
-		if (ret)
+		if (ret) {
+			platform_device_put(&dnfb_device);
 			platform_driver_unregister(&dnfb_driver);
+		}
 	}
 	return ret;
 }
-- 
2.43.0

