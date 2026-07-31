Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCD4C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1662610F242;
	Fri, 31 Jul 2026 12:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="oJnoWik2";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4F010F247
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:19:34 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1163503a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785500374; x=1786105174; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EcvBzuwsOWXd7sSY+ibZHDp7um7F6zB3s/KkWEJX80M=;
 b=oJnoWik2KIp2i9KLqnh0ClKdsanOt4XyXnSNRthKgVBeH1MZXORzOlIzknmmcS3Ozp
 OX9qbuiJm0Y2kqqthz+q/vaecc1qyMiJv3rWBiZA7ZJts9c37zIOt/suku03jVfsDSTL
 7T4pwSCK7pyBaEt0+Vqniq0kJZGj/6gYHPhhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785500374; x=1786105174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EcvBzuwsOWXd7sSY+ibZHDp7um7F6zB3s/KkWEJX80M=;
 b=TF1oo5s/sXblnapz/ltVBc3JRyfAHjS1vPfYv3ds3wRZIR+q+JtJZPSb2YZgtfQQ2w
 +ZWd+Bjlijqs5USw67BHtG0Ipx7VdU2GoYp+mbjWzJDKlCq6N7OmFJqb4RYDcGp1MVCG
 yMRGDvBxZqBabSlWWOhzB1yadDZujYruULemakrz2PCc+77H8+AxDhtwlfz1TDaM4h77
 O94dGqpMOdCBjXLJ3SJ/XMMEWcDuVPI8f7Gv7UDC7NFqKMNDDmCD4Xq7EKvTWfseP6jS
 TWs6ghOUQYEKILCMJV/ptBoXAs8A7jmwaG5Aj/Y6nZTs+RPx5gxPDayOjl8jqxvwy9oQ
 gKjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrjqUipN2QkFkpN+9WG7Hz3Zly1xHclYxZ+uj+jXNklRj8OnmA9uZwEteuvr0YqDY4Nma642PwqfM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzjn9yA2bhaYqr08QujWcG2+QR5prMscz4GtGDP9yZcNQ97MB6z
 Bc1XryZKjfkHr3owhm3Q37+ICiYtGcb46yHB7Cm5I8WaXYSp39qMTmKFxcGzGekQ85g5UsJIK4T
 9N4v9
X-Gm-Gg: AR+sD11V9NzNNvHfE5jT0hsHkls2bCAw2HaO9aVRJzYYOZYPmTP1vY5BcWekcKBFOzS
 Jo75PEOCDP0ZiN94b0vc/Nx/rmF3uEgzklNVIQolKz9WZbTnVh0CuxCrWe+2hZWUQZQuYVFA4iu
 vwk3dhzJ7YzzAvHik02s6Jjvbv69uDDgwXKM5Rrk8v82TE7Q1wN4vYJIc0Llr5JR4npUFyoT7rV
 Im3OO3zAbPMOIZAjg4WKuv0u7Qq3WfXMkx/Z4ZBzcRC67aXFWAJFqqUk3WNlHVKnaqP9piMHd+E
 W4Fn1JktWCuZPDxryJjzLt0nhwwYKICVn0+GejtSM7N5jey5RL4LNdAZJK8Ok/mGxUZfTSQ4H9G
 WPIwUbaxg1Ew3OTIDP0wlxyTXNpz5U5CO3F++/2TfP/UB1BR2pPrhe2oPNj4uoD6bgPBvwHJ87N
 udoSQJwH1cHCJHE3pfeBtJM3Adbr1qzg/DWE0CI6sTWsehQGPN6CoUMtlj32QXiw==
X-Received: by 2002:a17:90b:3bc8:b0:382:5c31:1f8a with SMTP id
 98e67ed59e1d1-38fb13bfd7bmr1819215a91.27.1785500373635; 
 Fri, 31 Jul 2026 05:19:33 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:19:32 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 5/5] fbdev: tdfxfb: Program the initial video mode
Date: Fri, 31 Jul 2026 21:19:14 +0900
Message-ID: <20260731121915.3362232-6-daniel@0x0f.com>
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

If the card does not get bound to by fbcon set_par() never happens
and the initial video mode is not setup and the display detects
no signal.

Program the video mode and also clear the framebuffer memory so
random garbage isn't displayed.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index f2b658a47135..cb1c2e9f37db 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1686,6 +1686,14 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_err_iobase;
 	}
 
+	/*
+	 * Program a video mode and clear the framebuffer now, this
+	 * ensures the display comes up even if fbcon doesn't bind
+	 * when the framebuffer is registered.
+	 */
+	tdfxfb_set_par(info);
+	memset_io(info->screen_base, 0, info->fix.smem_len);
+
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "tdfxfb: can't register framebuffer\n");
 		fb_dealloc_cmap(&info->cmap);
-- 
2.53.0

