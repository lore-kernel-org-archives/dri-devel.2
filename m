Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5A3F4613B
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615FC10E14F;
	Mon, 23 Mar 2026 16:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="QF6PfD8A";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1B010E14F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:01:14 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d9b1c57a4cso1247581a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1774281674; x=1774886474;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/13OoieOh2R3fJi1V1DS4OOCrO67vE76aOedsLQcjW8=;
 b=QF6PfD8AYIJ3qXkQRxxn0avocOs3LyUFmzsMgPP3PRaDclz2WF4GQK7ORgJnWTp9Rq
 6Gx1OYJXu599Wok45qB9kiRx7IgmRyorWOh870F+5ltEi700G3SsQGqS34Q0bGxFaPP/
 lup8tMgMF4TrKDm4thwVxq7pS1FXk36ePC65FsQAafybTi0UpwZbXnONIn6jTcKPS6Oq
 6Igo/bT+fbOd4r7QqxADP9fIGQN+bIGRTeVNcWepGgL7R1U0Q2mYdIR0mU8p1XtiWgzV
 Yf5jqwhycFECooYTj3NYTJoPCQsIZErJ51H8Hgih/ZfqqIz8BRdHpoW9pyQU0SoXASfo
 AEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281674; x=1774886474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/13OoieOh2R3fJi1V1DS4OOCrO67vE76aOedsLQcjW8=;
 b=Wv1kZDXjhAuT/AmZAHGzG6aRHFtr22H94RfJG5LmHioT+Rmsuocw1zUpKcCONkJ0QD
 5alHPz//vuSH1YUVwow6oR27HV0HICGfiC6p6ml/bO26Ax0/EBQb/DrE+Kvn0HLrQDfn
 xFbYar2uQUusOSKscIY99FvFgKX3wqNbwstkwSDbimMuHT2AnpyjvAVOPCG7dprxZ4xC
 jwo/o9SWMEzvYko2urHN9ilfMPz+ymOhQl+JOnYJmemHtNbaeHLq0TD31EHFaxYlbqMp
 AIHlDYEuJmZHO8pVPbIaSEsx03Ns6YaSqdH8BMY5qRY0ho91M352O/csCSp/j5aYTiUM
 kTDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGZ2pSI2PjHWNkv+CGKuGjbRb2jlKTeVdIEh8Jy/ebEMO6lu4i5pcpOV9kvFKNJsEOkGIGl7QhAKA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyk06btNwW6/FArqdvZk+t0OPYFBt3ms42gezvvs07AZf61off6
 uMzX2rftJOWGyJ6mQsaMN78amLMzCqw/vJmhlWSKHZLFj/p5P3elVEMz8LjvU/+5748=
X-Gm-Gg: ATEYQzwZlwYtv7Gx6LkJW/tBbD97tqaGA+CP4XIybY8chgry9wTyBinRypU1IT+WYik
 0Fe2jNXIVYI9H+5FjTanqySqc5jxD6u5zT3b33F2nlz2ESfD4gU2Oa0VyvpyOYmPzGbJelawqyX
 7RAapVy9PGfivgSFg8EVGE2xhSC3v4HaYDo4SBwpEIEjGROlDadYI/e4i1Pnfx2Hs2V+UAsgEWf
 oDCQssBQjCoJn0235KShXz1jiOjTiBtAgACi6yMc1yoSjLp4+gu+Rw+RnutXKKcMM9QSxPEZJSf
 tjFTgp4sSOn8x7z5mnMuqo8bReCSLzd4xw8rRG5Na9LayQFSvkdUiFW+RNbE5+K9X+uxp2pvjW8
 ck87EwPExNz6azIbX2cGaMFvW5g5DCG6pcWXv1FVPgdFdUl5hqZrvIPIR9cYHAi9fwb32EZ4wdP
 EK0shcVbZMOkPdjYGGNTwS4U1Kre4S0tv7rWDKUeJwoHJLikaLrWGtJUtygaUW3mk8hw==
X-Received: by 2002:a05:6820:180e:b0:67b:bcd6:94c5 with SMTP id
 006d021491bc7-67c22fbd289mr8856150eaf.35.1774281673547; 
 Mon, 23 Mar 2026 09:01:13 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net.
 [73.143.21.186]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:01:12 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 05/19] accel/habanalabs: Use trace_call__##name() at
 guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:24 -0400
Message-ID: <20260323160052.17528-6-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
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

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/accel/habanalabs/common/device.c  | 12 ++++++------
 drivers/accel/habanalabs/common/mmu/mmu.c |  3 ++-
 drivers/accel/habanalabs/common/pci/pci.c |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 09b27bac3a31d..a9ad1edd0bf41 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -132,8 +132,8 @@ static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t
 	}
 
 	if (trace_habanalabs_dma_alloc_enabled() && !ZERO_OR_NULL_PTR(ptr))
-		trace_habanalabs_dma_alloc(&(hdev)->pdev->dev, (u64) (uintptr_t) ptr, *dma_handle,
-						size, caller);
+		trace_call__habanalabs_dma_alloc(&(hdev)->pdev->dev, (u64) (uintptr_t) ptr,
+						  *dma_handle, size, caller);
 
 	return ptr;
 }
@@ -206,7 +206,7 @@ int hl_dma_map_sgtable_caller(struct hl_device *hdev, struct sg_table *sgt,
 		return 0;
 
 	for_each_sgtable_dma_sg(sgt, sg, i)
-		trace_habanalabs_dma_map_page(&(hdev)->pdev->dev,
+		trace_call__habanalabs_dma_map_page(&(hdev)->pdev->dev,
 					page_to_phys(sg_page(sg)),
 					sg->dma_address - prop->device_dma_offset_for_host_access,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
@@ -249,7 +249,7 @@ void hl_dma_unmap_sgtable_caller(struct hl_device *hdev, struct sg_table *sgt,
 
 	if (trace_habanalabs_dma_unmap_page_enabled()) {
 		for_each_sgtable_dma_sg(sgt, sg, i)
-			trace_habanalabs_dma_unmap_page(&(hdev)->pdev->dev,
+			trace_call__habanalabs_dma_unmap_page(&(hdev)->pdev->dev,
 					page_to_phys(sg_page(sg)),
 					sg->dma_address - prop->device_dma_offset_for_host_access,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
@@ -2656,7 +2656,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 	u32 val = readl(hdev->rmmio + reg);
 
 	if (unlikely(trace_habanalabs_rreg32_enabled()))
-		trace_habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
+		trace_call__habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
 
 	return val;
 }
@@ -2674,7 +2674,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
 {
 	if (unlikely(trace_habanalabs_wreg32_enabled()))
-		trace_habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
+		trace_call__habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
 
 	writel(val, hdev->rmmio + reg);
 }
diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index 6c7c4ff8a8a95..fdeca1fe5fc78 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -263,7 +263,8 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flu
 		mmu_funcs->flush(ctx);
 
 	if (trace_habanalabs_mmu_unmap_enabled() && !rc)
-		trace_habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr, 0, page_size, flush_pte);
+		trace_call__habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr,
+						  0, page_size, flush_pte);
 
 	return rc;
 }
diff --git a/drivers/accel/habanalabs/common/pci/pci.c b/drivers/accel/habanalabs/common/pci/pci.c
index 81cbd8697d4cd..bffbde3c399be 100644
--- a/drivers/accel/habanalabs/common/pci/pci.c
+++ b/drivers/accel/habanalabs/common/pci/pci.c
@@ -123,7 +123,7 @@ int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data)
 		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
 
 		if (unlikely(trace_habanalabs_elbi_read_enabled()))
-			trace_habanalabs_elbi_read(&hdev->pdev->dev, (u32) addr, val);
+			trace_call__habanalabs_elbi_read(&hdev->pdev->dev, (u32) addr, val);
 
 		return 0;
 	}
@@ -186,7 +186,7 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 
 	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE) {
 		if (unlikely(trace_habanalabs_elbi_write_enabled()))
-			trace_habanalabs_elbi_write(&hdev->pdev->dev, (u32) addr, val);
+			trace_call__habanalabs_elbi_write(&hdev->pdev->dev, (u32) addr, val);
 		return 0;
 	}
 
-- 
2.53.0

