Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B25C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3E910F244;
	Fri, 31 Jul 2026 12:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="fU6NfDOa";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B43B10F241
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:19:28 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso1166116a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785500368; x=1786105168; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QGIvsiAITywJ0rNp56g69w0ITDJR/V//o9H2LeZBivE=;
 b=fU6NfDOaaog+azOT+w3C6gDqA2iiDw5/BRoz2lUw8myzd6Fy5eO6FGFE+6u3Ts+xhz
 uzOGCrNEqMivi9OafG/WZeB1fwApFkFscIUf1d1xVKj+hG271HZG/rXJpjBAUdaNIDTp
 5fApgnlwwWpdXZyHUvIqhtVIgO7aVE7xhNquM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785500368; x=1786105168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QGIvsiAITywJ0rNp56g69w0ITDJR/V//o9H2LeZBivE=;
 b=KGoo2tVUo9+LDnMNLTp+wcBGz8ehF/CXdAKmdX8cpiLMz1Ms6tM+XjxJAYfEmnGzA0
 U9gr7/SMhioC+wbUC2/AQR/oFSPeICoXyOkv+nA6XejrJAQQBUJNYNqiYUQRvRBhH7dp
 Ccvd9m698QYauBv5NBQ3tNBN2LwAmFm2QLTU2mcgzctgmW6n51xSrOQ87G2tc3cvceov
 tYPUhp9VcCVtKYXL4lc/HWb3Ib/13KbGUlCAgOC1qDEtNS7yDmbqsOaCvhht00HN9ilO
 +xVfndSFaN0XMnDGpNLeABr6Lf3jAg2OBDBXy8hmnuzc4uKuYt6UdkhsddQ/Y88m1I/J
 /O7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtmKknICpwzbzl+UlHSFM2BPePqnr5EvWfV6f35iWgAMjiaLN0n4mK90rK+t0ztHV9bgRMS2yo3GY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuR+DSWApQlGeg7ICQpAAcjenNg5OlBXWI6aLf/CRMqfh/hsNm
 sRetS4i/bZxnwAiykvlvj+ovDh1zzAZ0iS/KsAH7KFSpJoKzs32jMg8s2YCtVMHOwAc=
X-Gm-Gg: AR+sD13Q0EO4fXsiKwDzMHJnJIxXt8xPhDOXEhpGV/e+l9zbskBfiwUCPLav7yG4R/3
 Pz/Dtw65CwuM0NZBcWk/52IPi3xQnDbiqv0XBVyzFj7Bto2pXcg7s7OO3L32xOy57ELf/2V5rLv
 zgc4vbh6bdanPVsNyIjjfPNnPud2hbU3BazWW826ZodZCzR98Awp9UIDZE3pajMKSWQa0+MM+Bg
 6phDQdW+FG7Vk0AfZESp0THe20WzvhJH+3ZGLcHTmsLBI6jMHplioYbbKpiIGC7S8l4QvMlcPID
 nwb+AvyqDULyBv9rxi4wmkDTySj0uKEj6VBJGi+NsnXRYFaYdqhIYvkAsXhQWDMYFYohOe4y05y
 uvxKltaKzYnz4cBu6rH/Gb+7ouoxlw0MPzeWhEC6L7J3BNSh9e8NEEihh/ZvC5612NnXJNoRA6R
 tdAhZNlKIHmGBP5GHzuRPBdUt+qhgVyaJGw/6p4KvB6CdXeSi4VjU=
X-Received: by 2002:a17:90b:1b03:b0:387:e0db:3faa with SMTP id
 98e67ed59e1d1-38fb13e34bdmr1636318a91.35.1785500367635; 
 Fri, 31 Jul 2026 05:19:27 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:19:26 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 2/5] fbdev: tdfxfb: Attempt to detect if the card wasn't
 booted
Date: Fri, 31 Jul 2026 21:19:11 +0900
Message-ID: <20260731121915.3362232-3-daniel@0x0f.com>
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

Until now a card had to have been booted by its video BIOS
otherwise the driver would probe, create the fb etc but there
would be no output on the display.

There doesn't seem to be a documented way work out if the BIOS
ran or not. Checking if the values in registers match what is
in the config table in the BIOS seems to be the only option.

On my 16MB Voodoo 3 3000 checking the contents of the draminit0
register versus what is in the config table seems to be enough.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index e92658274411..465c46edf6e7 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -414,6 +414,34 @@ static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
 	return false;
 }
 
+/*
+ * Try to work out if the card was booted or not, just checks if
+ * one of the dram config registers matches what is in the config
+ * table if there is one.
+ */
+static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
+{
+	struct tdfx_par *par = info->par;
+	struct tdfx_bios_cfg cfg;
+	bool have_cfg = tdfxfb_get_bios_cfg(pdev, &cfg);
+
+	/*
+	 * Can't tell if the card is booted or not,
+	 * also cannot boot it. Card might not function.
+	 */
+	if (!have_cfg)
+		return 0;
+
+	/* Card is, probably, already configured. */
+	if (tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
+		return 0;
+
+	dev_err(&pdev->dev,
+		"Card hasn't booted and is unusable\n");
+
+	return -ENODEV;
+}
+
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 {
 	struct tdfx_par *par = info->par;
@@ -1509,6 +1537,9 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_err_regbase;
 	}
 
+	if (tdfxfb_hw_init(info, pdev))
+		goto out_err_regbase;
+
 	info->fix.smem_start = pci_resource_start(pdev, 1);
 	info->fix.smem_len = do_lfb_size(default_par, pdev->device);
 	if (!info->fix.smem_len) {
-- 
2.53.0

