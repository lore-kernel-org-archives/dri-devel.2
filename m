Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D379CD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA7211A0D0;
	Thu,  4 Jun 2026 13:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eZkH+Qqd";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20E711A0D1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:53:03 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso457968f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581182; x=1781185982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zTkYHigKQy3WkeWXyJsWd48o8A6LM0P0gm1ZhPIld0=;
 b=eZkH+Qqdg0PwHwf1tBVgx8Q581rgKZkMeGdIbwEOCSm7j3PAgsEO2lemOiajDWuPui
 NnHWoqlohRIkF75DF2Y6TinxV2k/VVw1Ng/0HyQLYzGR0yYmdgVH2uPqj9GBFBOrj4cl
 HrhtdS7LAHZFbjFzFG0Rrnnxh6Qq21BQYNLRBu2MlOWWBk9bwNQMNVeKOlAo/2reJKoX
 YoB4lB0eg0LXxWoPFaNbYc664U3ur6bAyOUWcz1YNSDUl0NmTEjbYHyOpvnMXQnRIcf5
 oVOua6rlRp8asyCdLlVI9iQ+IpxNbEt1enmC6Vj3O0/3wL52uL1d8D8XH8DJjPegJlYF
 EwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581182; x=1781185982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7zTkYHigKQy3WkeWXyJsWd48o8A6LM0P0gm1ZhPIld0=;
 b=ABmSiOzoQYjsPemg7B4TJQ+7aRsGH1WWlDZjXeGEIGyY4saa7o12E+3WJpVSHpbA1f
 icGGSBG+TpRewWA+549fkxP/33UDPl536EPWNMQ+hvAzDI2r0FIaTurXhT5A5EvG2xVD
 GUcEIH1e8LgaPR9p7E9Ri7R60a3JL2Rd13dxPv0JgFO5sGZHgI5LOkxB0y9xIJ0zpKHe
 XaTz3Y4LRa5BO2lTIAt4aPRUxG4LO3yoArFsvE+wpbMfo2k1UsuiRLJx185A7L9Owhav
 Z/hiQFp97pO/bz97O7oczPcP+BYmLK+D2KFtujkThBKuqd4jWBagLX3NcXUCH0d17tf3
 KCrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LOIrLxtm1nSc2b3N5uAq3S5nz/XZtkLpPW5WVtNdtCzs4N6VqT6UMFlb3YEPSqisrQYxn3ZGDkjU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRjv20xGr2Qxm58UYl5BzkONUVilRORk1oe6n3NXj9AWlnCYHw
 /LPFcgwG1pisLXMzKZxgTe0FJsoLPsywN0C5xX983emIsQXdBo368mr+
X-Gm-Gg: Acq92OHEbqi6WRc+lsqc/ec2ApACo5KnlTRz+oo5y0ksIyJ9/wXR9MazSYvudXUfc8H
 VrTFO9lu6rTYoXRisOpK6Q+PqCXehJUN7uUVqSG40vPzdj3x0f4w5vxsu/tA1XEd9tfQnNjWJmI
 uomBeiezzlJt6PGC/zrzE9ixFnQmcdqm1vevTKhpl0kr16IP4VcHQq+3K24R29FdTMUTFW2xBjH
 VH0r8KHbB34J6sOThdjYwpu35lAMT+2ZL79rawrZLlEvNwxVVHlb0eJljsXuCN5KUn/6LoOhw2Z
 IT3JVQO5Hi5pODotzoeWnfuaYO/ZTxj3OJ+MaktoRBZBhcUeQlpoZr9cPi8zp+0a3OzXf+Fi+1v
 mmZobIMijbJJ2g5nNlnwBuPArluQpIzcLdvvhc0n7uCwLUKDE78iM0a3zb6MkdJyN9YtIIhGv/e
 Ywk23+ndaDQ1Qr6eQ6g85jL8Nn1h8fV5WupnN+kFLydSUkpcHH6a4wOaNNmm07Li8=
X-Received: by 2002:adf:e00c:0:10b0:45e:f381:cd7f with SMTP id
 ffacd0b85a97d-460217831bamr9227520f8f.5.1780581182173; 
 Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:53:01 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
Date: Thu,  4 Jun 2026 13:52:52 +0000
Message-Id: <20260604135255.62682-7-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
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

On the RK356x v1 IOMMU, RK_MMU_AUTO_GATING resets to 0x3. Bit 1 enables
auto clock-gating of the page-table walker, so the walker's AXI master
loses its clock between transactions; a TLB-miss page walk then never
completes and the IOMMU is left stuck (PAGING_ENABLED, never IDLE).

Clear bit 1 (keeping bit 0, the slave-port gate) once paging is enabled
so the walker keeps its clock. This is required for the RK3568 NPU MMU.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4da80136933c4..e3d8b6e9ca12b 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -953,6 +953,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 
 	ret = rk_iommu_enable_paging(iommu);
 
+	if (!ret) {
+		/*
+		 * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page-walker
+		 * auto clock-gating; the walker's AXI master then loses its clock
+		 * between transactions and a TLB-miss page walk never completes,
+		 * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE).  Clear
+		 * bit 1 (keep bit 0, the slave-port gate) once paging is enabled.
+		 */
+		for (i = 0; i < iommu->num_mmu; i++)
+			rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, 0x2);
+	}
+
 out_disable_stall:
 	rk_iommu_disable_stall(iommu);
 out_disable_clocks:
-- 
2.39.5

