Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55286CD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 13:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8140510E533;
	Fri, 15 May 2026 13:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="nRe3DZk2";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B0410E533
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:59:21 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-912278ed3b5so71361685a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1778853560; x=1779458360;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dp4Zt+WRyNVWYkPTWbK1zyHgPgu0+OlgZHWnBbbboaY=;
 b=nRe3DZk2gmAUVznerlEZGtT4k+xcOGs5nDrkGHS5w++5pEC25kbep3TogCTdIowNKW
 s3MA1q9vHwjO23DBsQ+9tVnYHmVt+yWpNlmA2HtUhGPaGqknre4ypAmld7WF4Od3UOb5
 dlcOngQVxpp1vjwkDm2YVSZqwh8U/4R0+wMk7v5VD/jiy5gs5AOUmYyeHsQYj36yIijU
 kbB1GKZi1jyTIrrkXDtblqpg5CpgAgK8Ul4FvVYaXR0wf7XI2iluKG+oKLKxhbhqMVSf
 3MrVaayra1piOKNH5XEso6yVs4lFDVJZsdUiTpXtbCnRF7W9mMLvMBlhFAu9BRSktzVh
 1uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853560; x=1779458360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dp4Zt+WRyNVWYkPTWbK1zyHgPgu0+OlgZHWnBbbboaY=;
 b=Wwy/GgzQbSFfX59LaxIVrHFVR0q5+ZTf9BvqzeDI1zOC0pHqa39lhTIulp/YBFN31P
 lHxszIroX2tfWgi77N2TG+QJh9pt1CiMau8A7nTmX1rwiZNwomd5XfxItseYzPL47ALB
 iLB+yZDInd7qtQdyOXAVkYsmyCmqoJykhdbYo2q5/XrKGhW4OEopo/l7dvkgKgniQ5w3
 +h593aQ5FUZ/qVt1q+D7YRlmHEuR+9bdvGwU74TFbUZ0+Ww0irgAV3XrQ7+5ZAe4gAel
 vfWO8Zv5KM8Z9XBueG9t9s1Q3PCZp9GXl/Zkj0aXH8L5LDTg7NdRHzlxnWM6Ul2io1ii
 +dUQ==
X-Gm-Message-State: AOJu0YwYb45ip25jAo3UeLmCOFcz75kfmoMrEfv++Ftyu7VnBrzIO/72
 O+3ta2m+pX77FjbVg7/iw/cTKvfsXWw5QWl2b52+CifxEWp4n1P3gSy02tHW+RGIyc4=
X-Gm-Gg: Acq92OFZwgSE1O23/xoglNWydkY76agK4drZn+yraW5LNmo7bGGWJUPMgDCZObl5z33
 tf+e+MuShzlFUjZeSiCPQbZCbB8qgxmNUdXN/nfNYn6GdPhEYFxZCB41vugPUclM+CysDqPHhoU
 o2WYz+uPbd33htc/DY4GTXVSJ3+X/Q9NEo0Ol5YNNJ1YuV25IKp9/LfzIQVKNK+eOdOy5HGyHf9
 ZrhZkSmVxuNIzyhPnMYIkv80/igsuEL8ZvXR4Y/z6TTAx4BV9RjRWNYL1TxFBDd2zvvgefIvjlX
 FffBRkZJKPFoD72AGSMEidCPM2w+dSE7YCax/68lQP1XzrMEK7ERKmkKSLyciFyf3Yt3BE813fW
 5xXofE7imh0MNMDwwXVi/zxAbyouw2T2r/d9h4mpWo/BxhCJcYEqS1hCA2vqO7FFHH+2N9F25t4
 2od7wt2I4ptAuYW9sETG1xCPZKsVQk
X-Received: by 2002:a05:620a:4105:b0:90a:708c:e6e1 with SMTP id
 af79cd13be357-911cfdd1709mr639152785a.44.1778853560255; 
 Fri, 15 May 2026 06:59:20 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba9454basm555644885a.12.2026.05.15.06.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:59:19 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 03/11] accel/habanalabs: Use trace_call__##name() at
 guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:14 -0400
Message-ID: <20260515135914.2238789-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
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

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/accel/habanalabs/common/device.c  | 9 +++++----
 drivers/accel/habanalabs/common/mmu/mmu.c | 3 ++-
 drivers/accel/habanalabs/common/pci/pci.c | 6 ++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 09b27bac3a31..68c6f973d53f 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -132,8 +132,9 @@ static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t
 	}
 
 	if (trace_habanalabs_dma_alloc_enabled() && !ZERO_OR_NULL_PTR(ptr))
-		trace_habanalabs_dma_alloc(&(hdev)->pdev->dev, (u64) (uintptr_t) ptr, *dma_handle,
-						size, caller);
+		trace_call__habanalabs_dma_alloc(&(hdev)->pdev->dev,
+						 (u64) (uintptr_t) ptr,
+						 *dma_handle, size, caller);
 
 	return ptr;
 }
@@ -2656,7 +2657,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 	u32 val = readl(hdev->rmmio + reg);
 
 	if (unlikely(trace_habanalabs_rreg32_enabled()))
-		trace_habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
+		trace_call__habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
 
 	return val;
 }
@@ -2674,7 +2675,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
 {
 	if (unlikely(trace_habanalabs_wreg32_enabled()))
-		trace_habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
+		trace_call__habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
 
 	writel(val, hdev->rmmio + reg);
 }
diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index 6c7c4ff8a8a9..dd8b6fb3aa1f 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -263,7 +263,8 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flu
 		mmu_funcs->flush(ctx);
 
 	if (trace_habanalabs_mmu_unmap_enabled() && !rc)
-		trace_habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr, 0, page_size, flush_pte);
+		trace_call__habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr, 0,
+						 page_size, flush_pte);
 
 	return rc;
 }
diff --git a/drivers/accel/habanalabs/common/pci/pci.c b/drivers/accel/habanalabs/common/pci/pci.c
index 81cbd8697d4c..12663e8e12e0 100644
--- a/drivers/accel/habanalabs/common/pci/pci.c
+++ b/drivers/accel/habanalabs/common/pci/pci.c
@@ -123,7 +123,8 @@ int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data)
 		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
 
 		if (unlikely(trace_habanalabs_elbi_read_enabled()))
-			trace_habanalabs_elbi_read(&hdev->pdev->dev, (u32) addr, val);
+			trace_call__habanalabs_elbi_read(&hdev->pdev->dev,
+							 (u32) addr, val);
 
 		return 0;
 	}
@@ -186,7 +187,8 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 
 	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE) {
 		if (unlikely(trace_habanalabs_elbi_write_enabled()))
-			trace_habanalabs_elbi_write(&hdev->pdev->dev, (u32) addr, val);
+			trace_call__habanalabs_elbi_write(&hdev->pdev->dev,
+							  (u32) addr, val);
 		return 0;
 	}
 
-- 
2.54.0

