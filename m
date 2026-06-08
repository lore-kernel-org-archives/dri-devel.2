Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDD2CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9401410F2DA;
	Mon,  8 Jun 2026 12:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvKufBrH";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3167B10F2DA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 12:20:10 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso35205295e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780921208; x=1781526008; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ohRW9gG8lyl3LlFf2CuuLurz89yotsvIxB/I8LMv+rA=;
 b=IvKufBrHl3//4c5ixdM22l09Pl41WtL0v1AoGDJJAdi/v+eSwEvPGd+aJ9JBz7S7Ux
 7mhUY5XBchWoUI24LDongzovQRBTBf5d1/TVrOnA+5rnMB0zxCfneT8yfxRw9NG+rINl
 OyLIxRI0VNjSY0hAmy8ib3vZRiByoas/1fiQpurhSCiYyXhPuxxx9iscxv9zyXA2PfA+
 pee7EN+5O7fZmPkMIQr35jQ3OJZVlD8dyRTt5O+mdm3Z+AxApd4h8ckxi9p1I0l6cYd5
 5Jl/ntIyEHplwak6ULwUO2Qm/NF3s7ajVZdVj4hbzW3xpHF053LtJqGlvveANi26B4hq
 uN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780921208; x=1781526008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohRW9gG8lyl3LlFf2CuuLurz89yotsvIxB/I8LMv+rA=;
 b=FHv149vFApELhl1PrLTPZ3IpLdvGKz4w02i1rxnVQ4QrZXGsYISfpYALTIeEsApXTo
 R15YI+x8ZsIQSkPUGxUAnYTFRlpNOdqe/B4nim5ur0KLbzGmt7b0vCFKEhY6xNmXYFd6
 qxQzY3RmZXg4m6o9MhWt88yHNcKTK/daC0qdFos17eWCOwq4A+vMHnCqKuM0fGxmzdoM
 mbxrLRRiFcPnfcyWBiob5jB81zy8+4JCbct2GCtZ1FzEwCssWSsBqynH/IAGfg1YMBH5
 Fl5M0SnM8XgvQDw9WfmVjnyUdChIQvG2LLj0T1SUkCIslz8l6zFSX8IXB0Vh8PtrimcR
 xq5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wJ4QQGjEUNtohHiqYzTvflwENVIDx9qbCJQnRDV6rugaTEl11Q8xiPiMu+LQSh+17mou8AVdU4Vo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5GuOC0l/g9kagQsNO1sU05l7pg152sn/P/N+GF3SCMIA9QLWP
 gVeu3mM+BJlioBy1jr/+bYgTZJHhLhpNGIEKfRvNKsYS4BZtPmvIO3mr
X-Gm-Gg: Acq92OE+9rQ7I34UJOEydzWpfKFPpljiSIZsYylQY9tVU/2skbfFgRm8Mx2bv2h2Ei0
 UTw4qKVEdLMZe4oJehtDD/+/Km6Qg8fqs/vyCPIC3pLWY6BV/q3J0PG163YANXsvDOpTx38UTmD
 3mC4C/nbgn9cY/PuYxysHF5crMdLhgY1BKOm8i+Yfh49ORMAyRvoWb/3dZZSgCoRfWQaO84R+z9
 0tlMZWMkHRyAkA5w7EPWt7zSoXZ53Rv9qIfGBhrwOXkx0kLveWzrlu2u2TwDdu1+sjAPsninAiE
 dKNQmCM6UA0+T7kEyHvCih0zhNsr/y0ngzUNKuX6e77mxnIUW9dy0i2Po/zHOfJuPt2LwGwHbQG
 BUH2d+oFt+J+3aS5tVQ38JoIh8HVHNQqW/frYodrA5JSlBoRwDcTOnqaRFtqO8kO/1T1/wGzNx2
 FM8M/n8lMjYO6Bh0vUv5u5MMXD6548Sih9
X-Received: by 2002:a05:600c:5248:b0:490:c024:2ec8 with SMTP id
 5b1f17b1804b1-490c2522657mr251577045e9.0.1780921208481; 
 Mon, 08 Jun 2026 05:20:08 -0700 (PDT)
Received: from localhost ([87.254.0.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc23394asm386889605e9.0.2026.06.08.05.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 05:20:08 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Koby Elbaz <koby.elbaz@intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 Ariel Suller <ariel.suller@intel.com>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] accel/habanalabs: make read-only array edma_queues_id
 static const
Date: Mon,  8 Jun 2026 13:18:37 +0100
Message-ID: <20260608121838.48011-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array edma_queues_id on the stack at run
time, instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 5d9c6f0698b7..1d4154cebcff 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -10668,10 +10668,12 @@ static int gaudi2_memset_memory_chunk_using_edma_qm(struct hl_device *hdev,
 
 static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size, u64 val)
 {
-	u32 edma_queues_id[] = {GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0,
-					GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0,
-					GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0,
-					GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0};
+	static const u32 edma_queues_id[] = {
+		GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0,
+		GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0,
+		GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0,
+		GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0
+	};
 	u32 chunk_size, dcore, edma_idx, sob_offset, sob_addr, comp_val,
 		old_mmubp, mmubp, num_of_pkts, busy, pkt_size, cb_len;
 	u64 comp_addr, cur_addr = addr, end_addr = addr + size;
-- 
2.53.0

