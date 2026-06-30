Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE61BC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0738210E1A9;
	Tue, 30 Jun 2026 08:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IbVN1NX/";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE31610E1A9
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:01:22 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4631679f204so172966f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782806481; x=1783411281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YI/jgLaFSFJaOYv0jGHZTjandLkO9uhSh+X6he+epaA=;
 b=IbVN1NX/JQbkHpWrAwNqoXBPwyeU+6i9IUJolYFsBq8wkZAISa5Iq85QRi8Ly7R0/R
 WGbD2JDlckLBAvjaHI1ogf+46ii6EX0yxvnHnCMjcNP/gZOzcNC4Vuyl11hI/CKpBPcN
 RkDnl4yZZMUrN6k0Nf7odrNwKpMx5gE4rj67KOenNvZCIFDuJVit8GZAPn31Y2kWV8Ou
 h5QmvthCS9AGRC0kn6AJcOXl4rLIVD+uYHeSQq987URTp6s3nJ0NJHMnMH1SdCt2Fs5b
 suucoRvxMP9c47lIxAev7e2EzVmrXRdberxSsrXSzLBRV2sq6SklBSHU025ED+DKsUir
 eW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806481; x=1783411281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YI/jgLaFSFJaOYv0jGHZTjandLkO9uhSh+X6he+epaA=;
 b=iQEsSBRSGYQXOcErsTaiTsC7CzaTxF2fvB6U2bTwMYx/9mteI1RfSh8c1vqxCTDTfo
 KQg4vemS86yDvsKgNqCfdfE2l0aX6x0/EYbAlCRqjxS2OLyb1rfKqFuG12jvqSG/RrAz
 Dvaiz/xzKVA0EpPj6qfiEpwxu5Vp/oU/fuoLm9vzlCX21MptUvWClqIhgk+6wpT3uumr
 nIO2oiDNGC5lfxxEM4Xk7D9w1r3U7zWYG5OCbm5/antqAEtLOuszoW9nR6yNK6/y82kZ
 rPjAPwE5DRb6+9ZYAsSKH/FBv5vb3CbaYRrd1qPvCqv33hfBo+2feMFKiVzXmc7R8ueH
 499A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpahLb1Qmbk7z90R38lOHYg0x0VgqwNWhNU7ashSqNyTRLZVfo6q37sggp4MMVKmLZLZNMk0zAv3gs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywbw0ZZ3UDLpx2lhVmNubmQRIIbkyKnl4b2LEKg43OCK94z1T9K
 zMdR8h22bMn4r2BuljgcHLJtSfjM8NmOmNZ2U8JXaS7jA5tmhtCHZHvz
X-Gm-Gg: AfdE7ckuYdsaAB3OYo5BWAOPPJhSXxXqwBKfN+bIMyEpqPwTrnaOM90eWArlqFM9ZDF
 UKklKEwuo4XMWHx2PcfBjPv9DGYArN7Kj9N1wWy4jPl7ZVN7W0bvVMeAkB5c4LtV9d4UtSxcd+k
 90Thdostyd0b9c2w4Id+qPr+ED+0OuedflqM4YDaOVZfGW+NxbrllDJ+pdDMIWUIt0HYC6hvUFi
 SLddwQK4kA268PQ8UUFlBEF83koUokcgbMzJgCWlX4fCz1HM+Ue3tPo50P52PbhGA2Z59Tx4vQY
 IDV5fxa5MuruoqOjz0CpCcsPw6mdVQTH3PArIpwxTbf28Q1M2MQdCm5DoOEV7MQ9zTUeS68nNGv
 i5BcpBQEAIb3gqfp3t1xvrgdet2mA8XixtOe6RIYR6fwkHsdJykMlvMrkGDw2bz+AVuhHJXQCT5
 73rLDjS/Y0oJOxapEkIxYl9dAmBoucFA0=
X-Received: by 2002:a05:6000:46c7:b0:472:1424:fc7c with SMTP id
 ffacd0b85a97d-475de54e182mr792784f8f.10.1782806480868; 
 Tue, 30 Jun 2026 01:01:20 -0700 (PDT)
Received: from laptop.fritz.box (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475671d0403sm5651837f8f.29.2026.06.30.01.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:01:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sumit.semwal@linaro.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 lizhi.hou@amd.com, Max.Zhen@amd.com, Mario.Limonciello@amd.com,
 airlied@gmail.com, karol.wachowski@linux.intel.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] dma-buf: explicitely forbid exposing pages from
 get_user_pages()
Date: Tue, 30 Jun 2026 10:01:12 +0200
Message-ID: <20260630080112.1117341-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We recently had another incident where two drivers put pages they got from
get_user_pages() into a DMA-buf and cause quite a number of problems.

Explicitely document that this is not something exporters can do.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 71f37544a5c6..aa5af4f439c2 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -685,6 +685,14 @@ static struct file *dma_buf_getfile(size_t size, int flags)
  *
  * For the detailed semantics exporters are expected to implement see
  * &dma_buf_ops.
+ *
+ * It is explicitely forbidden for exporters to expose buffers they don't "own"
+ * as DMA-buf. This includes pages acquired by get_user_pages() or other import
+ * mechanism. Not following this rule can create numerous security problems.
+ *
+ * It is also strongly discouraged to expose the same backing store through
+ * multiple DMA-bufs at the same time. This eventually creates aliasing and
+ * cache coherency problems which are extremely hard to debug and fix.
  */
 
 /**
-- 
2.43.0

