Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C319BC88E4A
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C6A10F2BA;
	Fri, 11 Sep 2026 00:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nBLIvLtp";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117A810E34A
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 00:08:47 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 af79cd13be357-939695b5741so32685885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 17:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789085326; x=1789690126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bSaMAuaPgc7+sGFbHWGL+A5HmSLpypXBziPyfL/qmaQ=;
 b=nBLIvLtp9FyeLXKy/Ks1DCx1Cn2X6h+Pgce+OHjznGDRbY79DFPxzI200bcvqUM7jl
 ybNa2dD763E2HkY8IJ/FxEiUopYow2M4IYHn3+egomFCKF2GRrvZiGIwy6iwHouVsnDY
 go2Am3eDPnPd5yBn+z34AG2rALnQn5P7haCJ6k1eWfFh679qQcq9i/tuEAnXikxLd9DH
 QgI+lJ93asezRdeHEez+wCpOccuAAUxMfBMiBP2Bz1qk4LQhSiK453kEeyDMpTrohYI9
 6/ayc4QTwiUPmrIUlDXUp61Tcy5FUk1YSkXEHJllW8KpwaBKtgYknUrlnNCJuDnGklaa
 0ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789085326; x=1789690126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bSaMAuaPgc7+sGFbHWGL+A5HmSLpypXBziPyfL/qmaQ=;
 b=HtFigJ5PenRL4Vtqz9CrGSaMpWCt6+jYs4A9q/tvAfXqr/O/ZUlt5RNUyPb9TCPi73
 cGuielLHTtCYfrtXYAE2eGYm9MPNJJjnP71C74jZu83ULTSJUmkSSWA/1MVNyOFxCnpO
 8m5DFtFsw3VGroc2oER8Rh5D1+Ah3toE+ZSIsk0DRbBh4xzmCUJXMDc8la8E3cBA47YB
 orb0y4uYfClPzRkc4VwY/V+6JER434cPnJN/NBgmAKZZAmCJxaplAuOkujGbvr89r4U7
 PFaBDozEIqzIfT2Jnwh9z4iVkvfkRhgho/K1Ro6Kkv9Exq2XhHApFt9bTdgF7+PWmyHR
 1y4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQU/9gXhZkRYTG78JRAG4GvWfkApi4ZZtF8zF0ZYj4odB1YgISxDnbij0dwiBQGy4wGrTshtcbbr8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lOS6cA6eYOgQMurJPPBeMVXj61FokGcWxQaGcYutT7+v0vFoFf
 gV6Ie9BUPGo2E7lh+inoTQ5LYEXwsjw7aMxBFRyETnVZMom1mfn1Pb8=
X-Gm-Gg: AYBFou369I52Tjm7z4yoPQrAWSGgRa+1lOBGoqYCbCWv8ywTkzTdScSoDyiCFu48luP
 VZpJDcv7wz0jufGhSw9ytW3sBcgIKawzbJcwokQzLGpplxgajDNuD3Off15Z5vC1iKFC/xoP/2E
 zXKO9fRhQz9ROOP7/2avsKlv/rDz16M6R4IXJt960Cu+BvtJR2Gnif1v+Y8oSOwR9ZYoBRNb1qE
 QsxiiQDaL4hBBWsz1XMncwDjdhSnKdZgQiAu5QLnHfp4Frj/CDPaMSfP92U5oq5ae2g9FFpUj4z
 zoxAV6x0Hbh65YvbrSoqF0SaTXjKucLL85MQWnKzmRioi/J1V1lfhLcgy/dn6Avd1RFhGlPxz2c
 TD+ArEsT/jc2JyOrxTtw+jtArW1tVbTmYKrZLG1RcNYy1DaVzyYDF48bpbKGWh067EzB8D3bUSt
 SKDQuDguK1CjGGRntc33FdxsWaymSMYUw1d9YZs/1eHcgPD8AzAYnGWVrXceavOfJuIgLjLMp2q
 7Wrodm48M0BsOFp5+sz3SlDhQaRbxfPnhwI1RXCo41gFckPf1RZy5JohpFHSHJjlFjxnG9K5l34
 DtEsSv1asoTa2mwmY3W+aOAPQmUtcQhB1B4=
X-Received: by 2002:a05:620a:4409:b0:939:191c:cac7 with SMTP id
 af79cd13be357-939ea0850abmr180782885a.13.1789085325637; 
 Thu, 10 Sep 2026 17:08:45 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e811cffdsm106263285a.46.2026.09.10.17.08.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Sep 2026 17:08:45 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] fbdev: sstfb: use managed PCI device enable
Date: Thu, 10 Sep 2026 20:08:35 -0400
Message-ID: <20260911000835.88909-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

sstfb_probe() enables the PCI device with pci_enable_device(), but
failure paths after that point return without disabling it. The successful
probe path has the same imbalance because sstfb_remove() releases the
framebuffer, mappings and memory regions, but never calls
pci_disable_device().

Use pcim_enable_device() so the PCI core disables the device automatically
after probe failure or driver removal. The driver still releases its
framebuffer, mappings and memory regions explicitly.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/sstfb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index 2ea947f57efb..0496b9d5ecc4 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -1332,7 +1332,8 @@ static int sstfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return err;
 
 	/* Enable device in PCI config. */
-	if ((err=pci_enable_device(pdev))) {
+	err = pcim_enable_device(pdev);
+	if (err) {
 		printk(KERN_ERR "cannot enable device\n");
 		return err;
 	}
-- 
2.47.1
