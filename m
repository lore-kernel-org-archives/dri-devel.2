Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A98C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB0B10F021;
	Thu, 30 Jul 2026 18:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="Z/WNGePu";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A3D10EFAB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:27:07 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-848595b338cso290576b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785436027; x=1786040827; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gtXncMJulG5/IdvNqALd27aEfY4Cg64b+rocTENNNEg=;
 b=Z/WNGePu9m2O5XsNtwyHlsduECY5sdqyHQnYLdFFt64geD2Q91S2nXANX5RoLpIBfG
 mKc6xmgm4yEa2AujIN1A+ZnFYoWh7mxJg8E7mbj58bVDrpbCjK/NOkDp2i+sUIlpLSWk
 jB3KVSf+kGc1QYkomZ9n80Az3R8CUDSs3YIGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436027; x=1786040827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gtXncMJulG5/IdvNqALd27aEfY4Cg64b+rocTENNNEg=;
 b=QKxNafrBP6SAtbU7OzjoT/8BbsOpdvlSEW4rWOflNhepkOjDSTdw9szOho42J0hMm+
 Hvg0IFBf9ZD4Sj281VrseyJXYn4QNKoOgrDCEmN4dF3KY8WjX1TrgyM7eoWx1Qnb6Vll
 CnbZAeFRzRzAaNnw9bLqRSOdI4BrwRDXS7GOpRhKPfRadTJGXisfky4Bzjg3ZxFOB5Us
 c/vwxu3SHAQDEQuuhmyUdHFVC5L4k56HjIZ975rz1N5nBXDs6CWIf6Lc4u0q2ZDtEcZG
 GFp0ewvzd7LwZGbvdc2/K0uq55xU9qDYxmoT9s175FhmQiJACz6FCqjLck8X0Axss5QD
 t72Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwLgQejgOwMMD6blIGK917bh3Zg7sPZVZe3K0sIy/PLYcYIG1dQ/w0Q6LUAKNgr3YqssVnqeIx6Bo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgD3QIjDZK74hzklqc1OcO54+2ZFG79V+mUWZZdnWVIQHI80Ft
 QeqYxVSYP7TcGnpbL1thPfdeTXctqCjUQ1NVm2oQ3bpVKxanpv1UnHb6Ke+1pguREK0=
X-Gm-Gg: AR+sD105LwV8sovthjHm1quH06BhVBR4eTxBTWJYavgJjqI7OlURsCWxoGKka/u53e2
 nmF0gNUVrKIIVffzSXMnGIJlQ3NR2zMXdM2T+J4UylrYD2/6cPGC2kgbc4rcQaILoLObqns1Ci6
 3DrYSPzWrSVvEK6qCoLAQ7GuCh3LSokXhk1JPhKT2wSSVf80NjVRoqnsg+QesKtmYRSZxDQdmOp
 4NK+n8Av5UtT92E4yVLMQtd4SBalypP6AoYM6RuDTzEDQeSixcxJOvUy+tiMMsFUsxIwKeVbawd
 loS0ZmhxBMQRNIMQ6Ntt7pohXKrxMqfs74s8DaOQzGcS2vSgO2Nn78pvqlGv4kCOrXFIMTzzAPr
 iwixudCuFIxgr1IfFfAswyCbX0eNwOFAhzF0JhVkYJvftMkUDnTfGAcOIt+vUU2GUMJR0uRq9+N
 l/80kOlXoKNlCWPMVH2v6OIP5sTkJ378jUQ0pu5PgQQtOIAiMd8NA=
X-Received: by 2002:a05:6a00:b8d:b0:845:363e:12d9 with SMTP id
 d2e1a72fcca58-84ebc1f01c3mr3502734b3a.3.1785436026696; 
 Thu, 30 Jul 2026 11:27:06 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:27:04 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/5] fbdev: tdfxfb: Manually boot unbooted cards
Date: Fri, 31 Jul 2026 03:26:38 +0900
Message-ID: <20260730182640.2808572-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
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
 drivers/video/fbdev/tdfxfb.c | 56 ++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 1d8bffe1e9fd..4c1d847c89c9 100644
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
@@ -414,19 +415,62 @@ static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
  * Try to work out if the card was booted or not, just checks
  * if the register reported memory amount matches what the BIOS
  * reports for now.
+ *
+ * If we have a BIOS config table attempt to manually boot the
+ * card if needed.
  */
 static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
 {
-	struct tdfx_par *par = info->par;
+	u32 mempll, gfxpll, draminit0, draminit1, miscinit1, dram_mode;
 	struct tdfx_bios_cfg cfg;
+	bool have_cfg = tdfxfb_get_bios_cfg(pdev, &cfg);
+	struct tdfx_par *par = info->par;
 
-	if (tdfxfb_get_bios_cfg(pdev, &cfg) &&
-	    tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
+	if (have_cfg && tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
 		return 0;
 
-	dev_err(&pdev->dev,
-		"Card hasn't booted and is unusable\n");
-	return -ENODEV;
+	if (have_cfg) {
+		dev_info(&pdev->dev,
+			 "Manually booting card using config table\n");
+		mempll = le32_to_cpu(cfg.pllctrl1);
+		gfxpll = le32_to_cpu(cfg.pllctrl2);
+		draminit0 = le32_to_cpu(cfg.draminit0);
+		draminit1 = le32_to_cpu(cfg.draminit1);
+		miscinit1 = le32_to_cpu(cfg.miscinit1);
+		dram_mode = le32_to_cpu(cfg.sgrammode);
+		tdfx_outl(par, PCIINIT0, le32_to_cpu(cfg.pciinit0));
+		tdfx_outl(par, AGPINIT, le32_to_cpu(cfg.agpinit0));
+	} else {
+		dev_err(&pdev->dev,
+			"Card hasn't booted and is unusable\n");
+		return -ENODEV;
+	}
+
+	/* memory clock, and the graphics clock if the card wants one */
+	tdfx_outl(par, PLLCTRL1, mempll);
+	if (gfxpll)
+		tdfx_outl(par, PLLCTRL2, gfxpll);
+	/* PLL lock */
+	udelay(100);
+
+	tdfx_outl(par, MISCINIT1, miscinit1);
+	tdfx_outl(par, DRAMINIT0, draminit0);
+	tdfx_outl(par, DRAMINIT1, draminit1);
+
+	/* Make sure the DRAM config is applied before continuing */
+	wmb();
+
+	/* SDRAM/SGRAM wake up: load the mode register */
+	tdfx_outl(par, DRAMDATA, dram_mode);
+	tdfx_outl(par, DRAMCOMMAND, 0x10d);
+
+	tdfx_outl(par, LFBMEMORYCONFIG, 0x00001fff);
+	tdfx_outl(par, MISCINIT0, 0);
+
+	/* Make sure the remaining config is applied */
+	wmb();
+
+	return 0;
 }
 
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
-- 
2.53.0

