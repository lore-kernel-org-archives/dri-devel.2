Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED00C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF1E10EEF5;
	Wed,  1 Jul 2026 11:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OseNEJlb";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A2310EEF5
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:21:54 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-37de8008910so291574a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782904914; x=1783509714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OS0LsnXAxJQ3vwP/NL/yX7kz0UHQjnYhTFVyVOyFmPo=;
 b=OseNEJlbZWui5jqYj+H+BSlIMLfQDaxmMgX2O2aLfe9mwl96bk+n96YHj/dTseNU8G
 32JigcC98AgaPrw1i77IbNIvneV10CW2RfYUG9EQF8hVBlOk5tQjF1UPqwH5YAHtOtsy
 gjvRT4vkWYxihf4tVZJwvm5T5oRFGPmo3cyjVQbYI9ySuCE4Xz8c33pscq0wrWuO+oOt
 l3Mlvdg1Tw9RoVhT2PNXQIA9zM8a1qi3BZfTIE+EkuKwzNhsoy27FWXm3kbmOL9ZlF5Y
 UpwI2HONdC+LL8QG05fiFXeTWABPyW4GgS0E4E9qoV4PbFsEHFJl4a8/7WovotGyy+1Y
 +chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782904914; x=1783509714;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OS0LsnXAxJQ3vwP/NL/yX7kz0UHQjnYhTFVyVOyFmPo=;
 b=jSZQAiIoaifJHy7FAxUyFryjGrVqTwmIsXv/5iuPD95laVqY3jyjCbJxQdcBCmNfxo
 PjClCSnpxGiC2c6JEuN0Dnwe5cHJ+JOjGMqD26rVv9Z44d9lR+TimlAlhUpwB2dc64YK
 5WlQSYDfN+ImKUpxiMuJ5ikqDDkwYrVCAA9d1srY/EZNY2t4/XHGdXue/F65HxpkNPve
 jWewWT2NoYAgh6laN6s0DO8Nhvs+9BK4JBwIjTWiOzdomvOfjlPVvGpExy1Y8YV2NR24
 Z4+nopbAfuxc6vNn9XaVLrR3AbyD7zcPUHZ4SVWExzdgptfEdp0P2CB+3evO1gWyUWVu
 B8Yg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roh9BhwzKP6egpQjsp2+3ZHQdBWSaq5uFVICRLJiFNaAEL+iqxvMsYLnQfhFBLcaupOEhHBMkQzmnA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywj8orTCcfHGJJ4ODZw4RIKaY5/jS7kweM6OgyJIXVGopuypFPn
 PmozejFDJ39LsLCexaTFVFfhYeHbqlvm0YTSS1JdXv031WyrSGTkIQE=
X-Gm-Gg: AfdE7clno88nf06Rq+IbKeodHiTvmkntNUD60GZLg9QNDuWvfA8z8oChLEOPpubsksg
 z1qlNqWMiO6tnJUteaWa6EH6Bdh+O3XobauliTKWkQp/p5LeTbnUnmubbdEaEAmNE90b8EoFCpr
 Y9292GQaRxXJXUTxmE8fuJKkZ2PV6pivVo8L3iJ+5VBxPxGSKN2eo1FCMJ8RWKUY4RRB+fsu5/P
 gcNq1kmUUwxfZLQNiARGZwCVaXl6aOaJha2bSS+O9YgMwgB7FYQqOZXIOLrscfyzKGY0YNBXKjc
 lf8KXP7+8CbQmaz+38YU0q39rpKiHRW/gadpg2K9073G2CsY7+H2ZsSs6L6+t18fiK60LlfHih0
 7XMDQu/We39BwWcTZ68omibuiJL3Bx+Qi/PgSzDQVbhRhS/rvk8+7cVQPvR5Kpr4NJA95xnntRc
 d7Tm1xPSshGYe1d7xGxmvU77vLEi/F7SY6qJ5pk2N5GfNY0UB1kZ2CCMtepkIXPtIljfZedGQRY
 //FM3lCjaN0H38aLu/RlR7sUShgyoaI5tXgIeBL+H3ZEuyHaQ==
X-Received: by 2002:a17:902:e811:b0:2c9:fec5:ae82 with SMTP id
 d9443c01a7336-2ca7e8b3a8cmr13662355ad.44.1782904914264; 
 Wed, 01 Jul 2026 04:21:54 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c738easm30622375ad.20.2026.07.01.04.21.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Jul 2026 04:21:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] fbdev: tdfxfb: fix PCI enable cleanup with
 pcim_enable_device()
Date: Wed,  1 Jul 2026 20:21:47 +0900
Message-Id: <20260701112147.55048-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

tdfxfb_probe() enables the PCI device with pci_enable_device(), but
several failure paths after that point return without disabling it. The
framebuffer_alloc() failure path returns -ENOMEM directly, and the later
shared out_err path releases the framebuffer and returns -ENXIO without
balancing the PCI enable state.

The successful probe path has the same imbalance because tdfxfb_remove()
releases the framebuffer, mappings and regions, but never calls
pci_disable_device().

Use pcim_enable_device() so the PCI device is disabled automatically on
probe failure and driver detach.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/tdfxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index cc6a074f3165..7f7c268c3b0d 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1385,7 +1385,7 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		return err;
 
-	err = pci_enable_device(pdev);
+	err = pcim_enable_device(pdev);
 	if (err) {
 		printk(KERN_ERR "tdfxfb: Can't enable pdev: %d\n", err);
 		return err;
-- 
2.47.1

