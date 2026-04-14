Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC06F9D0C9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E4510E5E2;
	Tue, 14 Apr 2026 12:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DtrQnCWc";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D002410E5E2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 12:10:42 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c742723c863so3528115a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776168642; x=1776773442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UWUp3g+LxoslnPkybujRtv0aSTtZxDvWQnt9LN6HDso=;
 b=DtrQnCWcRcsJxxpskT5Y+/iT7WfpCDvfYVprxOPWbPgRM/IDXCCPagrUR7DXXA1Cmi
 PxtB+wx94s6jn7P2pC8u8zhrtfGV0N0l8vjIzaqPDNlH49Be9PMOqx/vqUCILw+GaYbu
 nb2cBmEQgFbCr68yoUbtSwRNlyv9OkJWGDO9uD0aA2w6Aopsig3WbzCvpKhDhfC48Tpt
 PoMXRkzOzMIz+dPYaL6Pc1WoVqVedJC+Ib5wc4ZHmDWMzHoByPL/G+Iut2nkCQ9IEZys
 o042PWXubea/55Sqv5Oq+JOW9w6c7KqgdZ9aeyFO4NuVe2hS5b8ZnAo0pE/z40zqA80D
 9NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776168642; x=1776773442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWUp3g+LxoslnPkybujRtv0aSTtZxDvWQnt9LN6HDso=;
 b=Jh4qV/lM8T2XOJi55iImc1Vzx89cHH+PiE+WPd66pbWncA/HciBwUXwW6o8bWObNHB
 bsqMCk2bsOUkWw+XGBzRvnPSeB/G3kEWvIBgcOqlxECJ2d5uvGqv0Md1y7s/ijbQ1N5T
 36rAaAsTjM9g4K+R16OdvhCVJywdxKp7NojSmUIcImY0zzPN6FnecwF48o28gnezIc1E
 MwCnevkmmHQeoiy+ncaFfzVK9sys7JClbHUZb5rLNIO4BORH+LxCckEZetMDNHtj7l9K
 aWUxMPiewqep/0YHvwlmwlTvU2b6m3YXrPH28NnxcuUDbd76kMnLvyANgNL164Z1o6Wp
 tDEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GR8p2QQ2MyoPUV5ooR8xO3QsXQ9vTNoS+SxO3WDV1EpRln5fumfy4hsbAoDEogfmt1RqETxZYA2Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyCWXBRrUhWpz+KnWhwPCVcECfNJodOnDUxluTVT0PJLqvZEWc
 yra4+s1XN63odNq91nKFF24/++IAlXUytFm1ICOOieU0wixy2omr94qi
X-Gm-Gg: AeBDietLckB6Av7L8OMQbOrOZHPQba67ncVVxbSTPDTqxp6u5b9nHo5EawzAvsSdewm
 HsBv8813pxtkmDvpKk1Klpaamzp5tTth5gnK182ADlgGUq7S2nwca1NXuxY69/KHTYz6/O0cX2L
 9HoDgtVaOJTTZL0mb9Nbm5nmi42X1l+pYjwX18V315Tv4iW8WlK4r1zfzZdxt27/C+XvETnA8M+
 QDwOcTIPW2X95nNlFO+PQGw7z/PpNxykDZjWnrO67OZebE7QkRYaDDQD9vwlrb/dFolUWcZOCUz
 fK+BaqOJRWq8C1yEnG57XHv7cSW44XNZjZWAWiem4+yhon3rF+fWXxrTwBvxCNeMKE7QDU3mdyT
 U7+i53aALedUqYs8JpZiRkZv2cerQAzmhC8j0xIUGzZRK8vCnxq4Y6nCig2JMDdD0O0kxTlgxQ/
 mFf9DMsLcnF4kcCQ==
X-Received: by 2002:a05:6a21:9983:b0:39c:4cc9:9d75 with SMTP id
 adf61e73a8af0-39fe409bcf7mr18846083637.56.1776168637484; 
 Tue, 14 Apr 2026 05:10:37 -0700 (PDT)
Received: from lgs.. ([101.32.189.54]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c794d8f3984sm1241349a12.12.2026.04.14.05.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 05:10:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 George Yang <George.Yang@amd.com>,
 Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/amdxdna: fix IRQ vector leak in aie2_init()
Date: Tue, 14 Apr 2026 20:10:24 +0800
Message-ID: <20260414121024.3142118-1-lgs201920130244@gmail.com>
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

aie2_init() allocates MSI-X vectors with pci_alloc_irq_vectors() before
creating the PSP handle, starting the hardware and initializing the
resolver.

When aie2m_psp_create(), aie2_hw_start() or xrsm_init() fails after IRQ
vectors have been allocated successfully, the function releases the
firmware and unwinds hardware state, but fails to free the allocated
IRQ vectors.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Add a dedicated error path to free the IRQ
vectors after pci_alloc_irq_vectors() succeeds.

Fixes: 8c9ff1b181ba ("accel/amdxdna: Add a new driver for AMD AI Engine")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/accel/amdxdna/aie2_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 4924a9da55b6..f05f49f691b5 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -591,14 +591,14 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	if (!ndev->psp_hdl) {
 		XDNA_ERR(xdna, "failed to create psp");
 		ret = -ENOMEM;
-		goto release_fw;
+		goto free_irq_vectors;
 	}
 	xdna->dev_handle = ndev;
 
 	ret = aie2_hw_start(xdna);
 	if (ret) {
 		XDNA_ERR(xdna, "start npu failed, ret %d", ret);
-		goto release_fw;
+		goto free_irq_vectors;
 	}
 
 	xrs_cfg.clk_list.num_levels = ndev->max_dpm_level + 1;
@@ -623,6 +623,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
 
 stop_hw:
 	aie2_hw_stop(xdna);
+free_irq_vectors:
+	pci_free_irq_vectors(pdev);
 release_fw:
 	release_firmware(fw);
 
-- 
2.43.0

