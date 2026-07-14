Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4175EC44507
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3E010ECB7;
	Tue, 14 Jul 2026 10:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOioy2xv";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2497A10ECC0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 10:13:23 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso31965725e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784024001; x=1784628801; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qzgCndSI4VOkYsn1Kv2muPUKgfIbX1eQd1xKFGHexkU=;
 b=kOioy2xvZYNG4XIi0P8PqqAM78+AFfLzM7OP15tHiwHxz9rEPNAIrTSASidfBsojKJ
 3r4MF37zY5O2S6SROAoHkxHyJE9VVy1jhKS5hrXl4G3AjJmi7J8NggyvD967Y/KsVCd/
 +sWu/9Tid3z0oW/Rk8AY1aNgLr0sq59mpD79AZbXGzkVgjg81MQdmHZ9UtqvC31kMlGI
 gIaZxb/sBrp8gxIpiWaxKJoLmPEdRR45LjCnP2Z2I4SSNKRLbURWXiRt1AYhfw58URvf
 2BDPIjTS5ZD6YBy8kLybTzstaaNKfpLAsEvvAoJyRNh/ivvA/4zwY9+WPhbg6V2p2Lqq
 m9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784024001; x=1784628801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qzgCndSI4VOkYsn1Kv2muPUKgfIbX1eQd1xKFGHexkU=;
 b=P+4uupzP2A1t0tOrB4+2eUqKDlvAmOqvjOKhufYMu+Pnzx0pP4hU6oU+D88MJgV/kO
 KPFw2LTiV9BDATvItkfCH5ECvTNqYvABlEwV0KvKqzzgM9BJdjhr6tNa6hAlHhtj1qTU
 4YHDJEArTUcLSss8HdSmB8nKHqdmBXMp8LzclKTxqHU75gSrvLhCQz9NjAHO/9To0qx7
 xE8173n5QAoqRBAGMVOQpchumxzfYUdH1ZNbUn8ztBd/SCo2qEG8NFAYVTSrWW/nvAuf
 r9uhTEEwo0LsaPAGSUh0kpuCbAozRY944o6NLm91Y2AHKW8KUo4tdDT7+NerbMTS+r2n
 TVWw==
X-Gm-Message-State: AOJu0YwnJTWiOqOHBZxY8prkY6OEd04rwe0qZ6FdeP1dirsfE/U6hVb8
 rltLS1FM8Hl/plAyVWVHxoe/1I2JrAwh4nxT5jRhJ8WQqAGz/7jXXjHaZ2UeU/Ny4T4=
X-Gm-Gg: AfdE7cnJrHrV+HYdMzbe2Ipq+7Q/Yi4ANpkRxgHHA8++W15jRi5iUrqZpZdxAp0kSek
 bGVcUlEcRJfe33PxYQhcdzSJsS+h8yv8nBYRhozIj3N9OKb13I4HMvQuLSI41vfjWBzIbafcQGm
 IJ4x8btxomxStrG6Lw/RTI9DKxE16t80EtBX1ZGLXUkAeN73BNokEUaT24M/HIvOZGbMKcpls+O
 +w+ZAZRtiRPjUZJ3umPGi6KYsWD32vdLh5Lay2S6sX+p7c18+uVLaf7wAeUDwy1fRSiIo+FCQdH
 8PbAI8TerM0Db02yvutFQgSu9xBGOgNygYquLFUGszKGEe7mhUdaF+6Y/fk+KTXMXBJGF1JqzMw
 JmbLbC2YcR5cQPkRu5Y+qBEyT0rRMKxLAsr7eaq1b+0ydLGNLGvs62T0evXaa6mEkIt9HT+VSBD
 ySKfT3ZEQ95bTY8xLTRBoA+/K1v2hQOBwN0Ti1OaxhRhCZE1CkZv5DSlAlawMWtTgfzzUOlz39A
 SHbq/NEau+za44mSPO++7v0miuwn3K2Y1T5HeQkfxwxEgO3FrVlW8y49r0aLQemZw==
X-Received: by 2002:a05:600c:310f:b0:493:bacb:1341 with SMTP id
 5b1f17b1804b1-493f87dc3e8mr124581685e9.4.1784024001316; 
 Tue, 14 Jul 2026 03:13:21 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a9879sm7788927f8f.22.2026.07.14.03.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:13:20 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [RFC PATCH 3/3] NOT FOR MERGE: drm/glanda: Add x86 platform test
 device
Date: Tue, 14 Jul 2026 12:11:45 +0200
Message-ID: <20260714101146.200416-4-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714101146.200416-1-kieweg.leander@gmail.com>
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
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

Register a mock platform device on x86 architectures to allow
testing the GlandaGPU driver inside QEMU without cross-compiling.

Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
---
 drivers/gpu/drm/tiny/Kconfig     | 14 ++++++++++++
 drivers/gpu/drm/tiny/glandagpu.c | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 7a15bf95a..156713746 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -67,6 +67,20 @@ config DRM_GLANDA
 	  basic modesetting, dumb buffers, and simple 2D drawing
 	  acceleration via custom hardware IOCTLs.
 
+config DRM_GLANDA_X86_TEST
+    bool "Register a fixed-address test device on x86 (QEMU only)"
+    depends on DRM_GLANDA && X86
+    default n
+    help
+      Registers a platform device at a hardcoded physical address
+      (0xC0000000) for testing GlandaGPU against a QEMU-based digital
+      twin without needing a devicetree.
+
+      WARNING: this blindly ioremaps a fixed physical address range.
+      Do NOT enable this on real x86 hardware. This exists solely to
+      let reviewers test the driver in QEMU without cross-compiling
+      an ARM kernel/rootfs. Leave disabled otherwise.
+
 config DRM_GM12U320
 	tristate "GM12U320 driver for USB projectors"
 	depends on DRM && USB && MMU
diff --git a/drivers/gpu/drm/tiny/glandagpu.c b/drivers/gpu/drm/tiny/glandagpu.c
index 8f87ae096..c1e9370f2 100644
--- a/drivers/gpu/drm/tiny/glandagpu.c
+++ b/drivers/gpu/drm/tiny/glandagpu.c
@@ -741,6 +741,34 @@ static struct platform_driver glandagpu_driver = {
 	.remove = glandagpu_remove,
 };
 
+#ifdef CONFIG_DRM_GLANDA_X86_TEST
+static struct platform_device *pdev_x86;
+
+static struct resource glandagpu_resources[] = {
+	[0] = {			/* Single resource covering VRAM and MMIO. */
+	       .start = BRIDGE_BASE,
+	       .end = GLANDA_BASE_SIZE,
+	       .flags = IORESOURCE_MEM,},
+	[1] = {			/* IRQ */
+	       .start = 11,
+	       .end = 11,
+	       .flags = IORESOURCE_IRQ,},
+};
+
+static int glandagpu_register_x86_test_device(void)
+{
+	pdev_x86 = platform_device_register_simple("glandagpu", -1,
+						   glandagpu_resources,
+						   ARRAY_SIZE(glandagpu_resources));
+	if (IS_ERR(pdev_x86)) {
+		pr_err("GlandaGPU: Failed to register platform device\n");
+		return PTR_ERR(pdev_x86);
+	}
+
+	return 0;
+}
+#endif
+
 static int __init glandagpu_init(void)
 {
 	int ret;
@@ -750,6 +778,13 @@ static int __init glandagpu_init(void)
 		pr_err("GlandaGPU: Failed to register platform driver\n");
 		return ret;
 	}
+#ifdef CONFIG_DRM_GLANDA_X86_TEST
+	ret = glandagpu_register_x86_test_device();
+	if (ret) {
+		platform_driver_unregister(&glandagpu_driver);
+		return ret;
+	}
+#endif
 
 	pr_info("GlandaGPU: Module loaded successfully\n");
 	return 0;
@@ -757,6 +792,10 @@ static int __init glandagpu_init(void)
 
 static void __exit glandagpu_exit(void)
 {
+#ifdef CONFIG_DRM_GLANDA_X86_TEST
+	if (pdev_x86)
+		platform_device_unregister(pdev_x86);
+#endif
 	platform_driver_unregister(&glandagpu_driver);
 	pr_info("GlandaGPU: Module unloaded\n");
 }
-- 
2.43.0

