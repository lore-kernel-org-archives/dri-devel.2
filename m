Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FA0C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1462D10F245;
	Fri, 31 Jul 2026 12:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="iTlAKDY3";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFF010F241
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:19:30 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so969042a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785500370; x=1786105170; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h1Ta837wxPAUZQOdiOlroOxLsJQaIrBUrobqEoKBc/U=;
 b=iTlAKDY36q434hAmug2ljyennGCPIi4rWM84Qld4WyzuSzW9McRveoiwV3ZdGIrlKy
 gdENeH+1VP0uxH+mFbWncOXqzB/yi9EJdPDm0GrwbgESrtKG3UTb/ussL+CkrMCVq1PC
 nNqtzcv2+tsWiY7VdoWTfHQWb+fDn1F53XmcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785500370; x=1786105170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h1Ta837wxPAUZQOdiOlroOxLsJQaIrBUrobqEoKBc/U=;
 b=KcWXc+FfoGRTj8uis+tq70/u43c3lkwh89ckMWK3vjZq3IuZ0mi5MlIRG/hiSDcIIj
 dNPnRRUZCqcVBJZaTw/LF60lReKMKUNO41uWQCKSg/Y2tCPFaez/J3+Xi+j3Tedg8/os
 X1lDihwPBncOtz9x2S9m9OY+WzYFHizsfSXWw31KtNeXcMvkeAMQWqubLeV0vDZD2mUw
 HFt1AMvoqRj0OiQ4u7C0FJY6pcxf7vZETGBm/8VQsWrfUquArj4fxHzfuVNdf9wjF9y8
 S3HehOxTCYpD4snw3ZPKPqWnx9HyxENPeJbmzGrm3h+zvDTKuEKhTWeNcXkzJVSJy1rc
 8S0A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8kE2q6dG/VDvF6lqe77fRADmy62Fs7+hvt+WDzoP6oQX6KLyUB5/AoSTGY4D/5Fv71YHPH6afSik=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFVGaDoVp+OEU5DWqVWxoIXFelAIjDyMCiQnfhxmZYCTzF8uvL
 t/v3f6XYuttovmg3e/h+iwu6F2UT0ejMkRNrjLYIcOSqpef6O0dPTfuJcoM7woJW99Q=
X-Gm-Gg: AR+sD135u4yXp1u+8xH2iQ4gxS3aMvPKgZ5wU7HHW6ArpBAqHhRsuDQrzOHeddHfki6
 dCtreJzQmf2B4ZdrXWWuxsxnCjq46sPWaWZzjfIPj184as5hU7aOyP/+mshrNWujH8ampQkq/5u
 RtlXASd8AgAynZ0ZKVjEFel5rBxms0oHMAbTMbdI/AwGK/SOZr5xdq+dPHs1LsZZnRT6J7nobZz
 dWAj8LNre/K/Ir+FQHDHhXa+wwyphnW+9esDguqDbA79Z6OzmORCsRxiYO0H+PddeJ28ryP1tps
 LqhjEoRNbLHmoadULmTrlupv6xQZ8ZERXIKSwmLEl9H/eni3gkNz/9yloM/LliYnz33WPCJeBkf
 2qWey8+bnvIcjrhNIcZfUwgHlj2HhD0K6Qq06N+zA7eJVFbpsLHFp9WuezFGepMt+k7hJsdcIvk
 v2GmQVUT4aDnRUXjApEMLUDk0upEpB4hQxxk4vcQYima8hWkAGxoQ=
X-Received: by 2002:a17:90b:1e41:b0:381:50ab:1594 with SMTP id
 98e67ed59e1d1-38fb13ecd0bmr1608483a91.27.1785500369713; 
 Fri, 31 Jul 2026 05:19:29 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:19:28 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 3/5] fbdev: tdfxfb: Manually boot unbooted cards
Date: Fri, 31 Jul 2026 21:19:12 +0900
Message-ID: <20260731121915.3362232-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731121915.3362232-1-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
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

If the card is detected as being unbooted it isn't too difficult
to use the config table in its BIOS to fire it up so do it.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 40 +++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 465c46edf6e7..4d92ab5b5430 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -67,6 +67,7 @@
 #include <linux/aperture.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
@@ -418,9 +419,13 @@ static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
  * Try to work out if the card was booted or not, just checks if
  * one of the dram config registers matches what is in the config
  * table if there is one.
+ *
+ * If we have a BIOS config table attempt to manually boot the
+ * card if needed.
  */
 static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
 {
+	u32 mempll, gfxpll, draminit0, draminit1, miscinit1, dram_mode;
 	struct tdfx_par *par = info->par;
 	struct tdfx_bios_cfg cfg;
 	bool have_cfg = tdfxfb_get_bios_cfg(pdev, &cfg);
@@ -436,10 +441,39 @@ static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
 	if (tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
 		return 0;
 
-	dev_err(&pdev->dev,
-		"Card hasn't booted and is unusable\n");
+	dev_info(&pdev->dev,
+		 "Manually booting card using config table\n");
+
+	mempll = le32_to_cpu(cfg.pllctrl1);
+	gfxpll = le32_to_cpu(cfg.pllctrl2);
+	draminit0 = le32_to_cpu(cfg.draminit0);
+	draminit1 = le32_to_cpu(cfg.draminit1);
+	miscinit1 = le32_to_cpu(cfg.miscinit1);
+	dram_mode = le32_to_cpu(cfg.sgrammode);
+	tdfx_outl(par, PCIINIT0, le32_to_cpu(cfg.pciinit0));
+	tdfx_outl(par, AGPINIT, le32_to_cpu(cfg.agpinit0));
+
+	/* memory clock, and the graphics clock if the card wants one */
+	tdfx_outl(par, PLLCTRL1, mempll);
+	if (gfxpll)
+		tdfx_outl(par, PLLCTRL2, gfxpll);
+	/* flush posted writes */
+	tdfx_inl(par, PLLCTRL1);
+	/* PLL lock */
+	udelay(100);
+
+	tdfx_outl(par, MISCINIT1, miscinit1);
+	tdfx_outl(par, DRAMINIT0, draminit0);
+	tdfx_outl(par, DRAMINIT1, draminit1);
+
+	/* SDRAM/SGRAM wake up: load the mode register */
+	tdfx_outl(par, DRAMDATA, dram_mode);
+	tdfx_outl(par, DRAMCOMMAND, 0x10d);
+
+	tdfx_outl(par, LFBMEMORYCONFIG, 0x00001fff);
+	tdfx_outl(par, MISCINIT0, le32_to_cpu(cfg.miscinit0));
 
-	return -ENODEV;
+	return 0;
 }
 
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
-- 
2.53.0

