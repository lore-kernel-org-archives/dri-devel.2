Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2103AC5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985A510F02B;
	Thu, 30 Jul 2026 18:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="qmuVeh34";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2882910EFAB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:27:04 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-848595b338cso290471b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785436023; x=1786040823; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ah2rwf0hV1PovcGf/j0qIadVcdG1awQwiOMYTwXzGks=;
 b=qmuVeh34iJNKnfb1gjicGMCbc910T6raCmEjM8tVdYbub0l3IGmDtH5JCFNmo9H0Bo
 2WsLkf5T6kK1nR2Dqg1qobpTAk6hXVbE48GdI0ngZ0Y36Rj74act1allTsOdFqowLY1u
 eg27hc9IZZ0MTfwbr2JpRol2p/dZxtkGOVjxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436024; x=1786040824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ah2rwf0hV1PovcGf/j0qIadVcdG1awQwiOMYTwXzGks=;
 b=lguqJRfjEQ1Gs2udofY4ZM9lSWbJfyy6zXVmh6t9aM2jKRgB4QYjzk1VS7bqGDrUrO
 nJbuDRfO9qNdWotKHWvG/bw6jsLFhNg6CPKPESTYsN5SMet3gitElKBKnUUq2MOAhp+Y
 AXuLmXNCTOlJFUlYSOP0UlSxXxDW6eaoNrW42SLtO9PXMcCQeTc9CydcZN8Kj1nsxfBr
 1rg++KpjIeqUw7ulBlIeCSrP5UbfDe0ikYNmRSmi4SmMjqniPb51hceb055fLN8HFFgz
 9UcIsYFzBIc5oz/i4czInPTv2HXm4uxUDn7FxLYG+/9uJ9VcH52ARfGUXCosimO9G8Mk
 u0Jw==
X-Forwarded-Encrypted: i=1;
 AHgh+RowTOtXdyj46xjoa4AkaUW4VCHntw4RpFwRtrdiDpb8UvmMS/zgpFKlK7eNoUYJysilQlu3zrkrtxA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxemzTx93CFUNOHr/PheKygin4tHiVeittDpTY3cqTKAYc9xIQN
 KGlc/vOaQCzpZ9b6FRP/x3e3fYnwfqQm/arxsb8ZCrccx4su8r0q235d/p6Bw0KYKyo=
X-Gm-Gg: AR+sD12A3RayQrNd3zoSCoMT7TKsqwlqjn0+VbZuebgPdC8oZHKg1mvXQMhN0cfHw+c
 bOYiMd3DoFLAJVlmvvLYUkC+CmhxLUrJeRnXN9uATXIqR07Uy7fl9hc0xEjJ855XhXugpukrvd5
 1GfGHL3D5W/aKgzr/5lPKx5Sxn/HoEJr+wzwBn0WTVXPZH8lonryZ4QrYQLefwOaUk14T+2DWFC
 qxndgLNm5MUIGPPzwiel8pNiuixNXCczmkWn1uX+nk4nxCGVq4718DC6VSbAyuvmxpqpcx95fi0
 pLlXVRTvpGHRy6ss/C7fcBEzrF7feMW6l+kr8fNxTkbo3H9lrloRXNLA6TZ0/o0cW/Fm6GxKIdW
 IRwgZfTFOoinZgH6+gqs3wkqW/yR+N3qLxkotKxNpjSyiILT+C4/XYPveqdRiAAx/ByJcw0hSuv
 TppVglz+RXVpFabTLQvyzN9qFBCN5HMCoJ53FchGhWUZW5N2U2pH0=
X-Received: by 2002:a05:6a00:99b:b0:847:7f3c:b5f5 with SMTP id
 d2e1a72fcca58-84ebc1ee58dmr3508630b3a.11.1785436023495; 
 Thu, 30 Jul 2026 11:27:03 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:27:02 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/5] fbdev: tdfxfb: Attempt to detect if the card wasn't booted
Date: Fri, 31 Jul 2026 03:26:37 +0900
Message-ID: <20260730182640.2808572-3-daniel@0x0f.com>
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

Until now a card had to have been booted by its video BIOS
otherwise the driver would probe, create the fb etc but there
would be no output on the display.

There doesn't seem to be a documented way work out if the BIOS
ran or not. Checking if the values in registers match what is
in the config table in the BIOS seems to be the only option.

On my 16MB Voodoo 3 3000 the registers show 4MB of memory when
unbooted. Checking 4MB != 16MB is enough decide if to reject
the card or not for my machine at least.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index fa554b09a0a6..1d8bffe1e9fd 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -410,6 +410,25 @@ static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
 	return false;
 }
 
+/*
+ * Try to work out if the card was booted or not, just checks
+ * if the register reported memory amount matches what the BIOS
+ * reports for now.
+ */
+static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
+{
+	struct tdfx_par *par = info->par;
+	struct tdfx_bios_cfg cfg;
+
+	if (tdfxfb_get_bios_cfg(pdev, &cfg) &&
+	    tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
+		return 0;
+
+	dev_err(&pdev->dev,
+		"Card hasn't booted and is unusable\n");
+	return -ENODEV;
+}
+
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 {
 	struct tdfx_par *par = info->par;
@@ -1505,6 +1524,9 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

