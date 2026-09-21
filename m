Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705B6C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C879010E842;
	Mon, 21 Sep 2026 15:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dcH+Et1y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0s3tkMu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D3910E842
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:14:47 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFApGQ884990
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+sC0Yvqh8Q5nitoPDOO2xt
 DXj5k7Je/RXYaZIXdOYtg=; b=dcH+Et1yC92Lu5dw7AEjH/U1yXQ6mEHF6MbfJO
 ePttSzU0pXW3tGBgh0USunt9zJbIWlj3bdB5t0Cn98Ns/BgFdhw+YUAC9/UQ9LtS
 sPzLhE4A3NC8i+VRr9SOmn5wmtolZqWZ64HNcKwQfvt8+3GwTRyecnobNZxqoyTE
 Kq4iYbAHg9N66jlxI6xfRt1lZUWRrJG1kwOTEeC56ZQEhe95yokRMwleVnIpHlzp
 4fwRt16x5LK2thprq9Q0h3V9qAV+3FGNVrBVECSgQHLfNTydcB6UMe/qwSxMPiw2
 sFBI1incax2uGm8Mv68+yAvwhxYxcABM9I7tZSfs0C13IXdQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj1sp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:14:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so44209405ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790003685; x=1790608485;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+sC0Yvqh8Q5nitoPDOO2xtDXj5k7Je/RXYaZIXdOYtg=;
 b=g0s3tkMu+P/ExqDkYXCl5TIKOo58Zv5AuAoKZlHWuKNwSUr6hJZlf8kByjTQ0wVrfT
 ItIOTwhIKF3lUD2TJcI2gCs+9teiOIB0gyRjqJWk/HP8a4RJYrerYrIRSYznelwn3dkz
 NEqXLz9G0d2wTjEjbFLUaHwPQixhz6PlprS9VgOcpD8AckLEPSn4E00uJl8W906Pkzz1
 ju5XepxNy2Y7SPFZ0G8ZIHwjeFqBfD43Om/TjZuUsEZePRjoEMmFl79j87e7zvGozRbC
 70YJi3LxWU59awyUvSH7Dc8CkFSdgPZXeiY4m8UCJoeI7ZgUe8eIdXSL8hrZeaUzp7LR
 BaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790003685; x=1790608485;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+sC0Yvqh8Q5nitoPDOO2xtDXj5k7Je/RXYaZIXdOYtg=;
 b=TNEx8O5Hozvcq3dOCPYnxwUsoTi5xl21TI2TnD3ETiJa+1k7s/vihwjN7qWaMtWIZu
 NWgN+0BfXTQqfY7Ieggnlu1jbF1YL17cZJtAkVvVIRIQUXIqAJq2Hwh7WQ5wiizRt4Ue
 kIunHxqhRAzD45zx9oGw7pM/QBdersSFv3dOQgNL5PnzMJiKwkjUhj7q2bEcthDTUchy
 0i5fuM/YbqDBcD9SW/nIFQlnnb9QrfG3fdv+AHZ8yLtko1oLl2uxGugo8qooiJjnEPFd
 K+jXJ49QoIo1RTz4KWjX2k3EN64QfL7QYTzQx8gw9iVzJbivjnZgEyoqpkqk/5Vhd4pG
 8A5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxD0KUEi86zpLoz8AGMzj9UJo4H9hVGOqkmNlBfajb/GfbvbAwNIEVj1cgsDRWh4eOIo06bi49/QQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++njjAV0ZzVzo2ADe5vCG/Nb3ggIH3xqroYv3oE0bsq1JnMAqKZz
 FTVPtv0qmUUHHj1OM0FySZPInTgLIBH4bIsiEWAwmuupCq1P7QVD6SmD2HN8EdLO7RYnqARqpSS
 65miiiQgj49pOHzEsksNraMnSYubbjY4sO+8iRNKoxU8Xs8tvlWbJojXcCsd/fOwKfW+4f18=
X-Gm-Gg: AYBFou0gIF3Bh8VIvZIDAnJGQuUU7IK/yb9AlQT7CWbgG0BXhAOTpqbt7oGNiPpDtcZ
 iqZsh1mO1ERMm7QngAxkxj6WxkCW0nOb+y5cEHFPR62H7qVWdjh0nMJWueY8UTA+wAsKWiPay3r
 +Fat23rXm8qFygjbZrQBX/bxzpgl7q0HFgw0sXznf6BS9iqIhi42btL6gccVLkgMRDumzSOiAXq
 Jp5KWElbnL1VwoEuRNcYdg/afnqkA71XIUdQrdrOFZ13TTBnn/sJV2FlnsQ0622QbMzU2ZKPh7A
 RFudaCA3/+UzCW6B655k3bw3xyZSW5HcNbe4TXultcxQcrpBvLMtEC1qmlTtHr0xRkRK4BL+ViD
 UVNxaWAMDLYHeWdQW3+uiURGmJHrX7vFslEB00D2RoRVbm4qgrxnG8ceIgy9kY/YbXdSgYp3QWL
 ReSQSiLLBNU2J7+e/7I8k3
X-Received: by 2002:a17:902:e741:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2ddb1aaf260mr174889335ad.2.1790003685024; 
 Mon, 21 Sep 2026 08:14:45 -0700 (PDT)
X-Received: by 2002:a17:902:e741:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2ddb1aaf260mr174888945ad.2.1790003684406; 
 Mon, 21 Sep 2026 08:14:44 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc17ba54dsm35708185ad.54.2026.09.21.08.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:14:43 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 20:43:41 +0530
Subject: [PATCH] dma-buf: system_heap: align allocation orders to ARM64
 hugepage sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dma_buf_improvement-v1-1-23d82e771dec@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKRJsWoC/yXM0QqDIBTG8VeRcz2HFRr1KiPC7LidC7WpSRC9+
 2Rd/j74/ickjIQJRnZCxEKJgq9oHgzMR/s3clqroRWtEkOj+Or0vOx2JrfFUNChz1yLQWqUqkd
 poT63iJaOf/U13Y743Ws83yMsOiE3wTnKIyv9s+PRdDBd1w+O3lTQkQAAAA==
X-Change-ID: 20260916-dma_buf_improvement-a095ae567e5f
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Juan Yescas <jyescas@google.com>,
 Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790003679; l=3701;
 i=pankaj.patil@oss.qualcomm.com; s=20251121; h=from:subject:message-id;
 bh=aYodpMjhjueRZKnta3cynI3TH/uCot98oWss+KQn/3k=;
 b=+fXkiGBUsgSDeAWL8tAR41f8+8vf5VxpHd5B7u4dqwtqgoHWuab3DmhyN+j3ssNg9tGAgFslE
 FlGWAWAqZ27D0cmreba2JmnHXGa9MWxZGkFmQY4Q8A/GxWgPpu+fdk7
X-Developer-Key: i=pankaj.patil@oss.qualcomm.com; a=ed25519;
 pk=pWpEq/tlX6TaKH1UQolvxjRD+Vdib/sEkb8bH8AL6gc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyMiBTYWx0ZWRfX7Xg+l+kfujEs
 oIsuook1kV0iNGdOxjLtKj47gIMZ/S4IARiK38zYso8bSxcIrUQwMBijdCI8rkZX8noLVNUqH+B
 zc+qOSPMPvZnwJv4z68T0wWLiSXClbA=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab149e6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=Y-RT13NjMWaHgGG2EaEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: TSgpRZq6bFvWFfCU4ttYf7E6d_1yAmm5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyMiBTYWx0ZWRfX+2IQANCiB0/m
 bdu5z+sFFSlRSXkMcNUcev4UtUZKkPoOCgoUP9Cb3q+l+rzi4j6H9D+Jeyg+zQHM5fVx15GqELZ
 3ux/WmjQt8W01ub7xfO1UN6Ol+/cQQCbLpxQsKZkdOPkGf7hYP0ukH+8RNdJUv3YepS5OXt70oT
 cNDbXoE1GKm0mQu4WgATJjo3ejyAY6r7c7AZgJlfFDOVexgNSg0Gm9TQu9WOIXZ25cbCA6A53JT
 wUVnxnXNmOfNAQtku0dRByw4CJzzChkMuzkZxnRnpQlyHe/5Y9hMDelgCKsI8X1AZvxwGLBIT79
 6lWoGXliGSJSyS9OQGGVLvynuzr2fQqLgs1btAiBx3cQvMqzoVulCtrQNYUuVPPoiFVYxMbD8rY
 RURJ3eFomlrp5yIEIfd3HmWDfJsGIZAr8tPpI2V0dDBx/e4fId9AtD6W1mnxktDfhw2AyfPg+f4
 pEyi8sFn/ccsKt6HULA==
X-Proofpoint-ORIG-GUID: TSgpRZq6bFvWFfCU4ttYf7E6d_1yAmm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210222
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

From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>

System heap currently uses a fixed allocation order, {8, 4, 0} while
requesting pages from the buddy allocator which correspond to 1 MiB,
64 KiB and 4 KiB only on systems using 4 KiB page size.

Extending on patch from Juan [1] for ARM64 targets with LPAE, a 1 MiB
allocation does not correspond to a PMD block size. For a 4 KiB-granule
IOMMU, a 2 MiB allocation can be mapped using a single PMD block entry,
reducing IOMMU TLB pressure by requiring fewer translation entries.

Use allocation orders corresponding to the ARM64 PMD block and
contiguous-PTE sizes for 4 KiB, 16 KiB and 64 KiB page configurations.
ARM64 applicable orders are selected for ARM64 targets with default
orders being used for rest of the architectures.

[1] https://lore.kernel.org/all/20250417201913.2393655-1-jyescas@google.com/

Co-developed-by: Juan Yescas <jyescas@google.com>
Signed-off-by: Juan Yescas <jyescas@google.com>
Co-developed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
---
 drivers/dma-buf/heaps/system_heap.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index c8959eadc71d..7a3e26c3dd43 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/pgtable.h>
 #include <linux/scatterlist.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -57,12 +58,30 @@ struct dma_heap_attachment {
 				| __GFP_COMP)
 static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
 /*
- * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
- * to match with the sizes often found in IOMMUs. Using order 4 pages instead
- * of order 0 pages can significantly improve the performance of many IOMMUs
- * by reducing TLB pressure and time spent updating page tables.
+ * For ARM64, allocation orders correspond to the PMD block and CONT PTE
+ * hugepage sizes for each CPU page granule, which also align with the
+ * TLB entry sizes of a 4K-granule IOMMU (arm-smmu, arm-smmu-v3).
+ * Each order = (level_shift - PAGE_SHIFT), derived from:
+ *   PMD_SHIFT      = (PAGE_SHIFT - 3) * 2 + 3
+ *   CONT_PTE_SHIFT = CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT
+ *
+ * 4K  CPU (PAGE_SHIFT=12): PMD=2MiB   (21-12=9),  CONT_PTE=64KiB  (16-12=4)
+ * 16K CPU (PAGE_SHIFT=14): PMD=32MiB  (25-14=11), CONT_PTE=2MiB   (21-14=7)
+ * 64K CPU (PAGE_SHIFT=16): PMD=512MiB (29-16=13), CONT_PTE=2MiB   (21-16=5)
+ */
+#if defined(CONFIG_ARM64) && (PAGE_SIZE == SZ_4K)
+static const unsigned int orders[] = {21 - PAGE_SHIFT, 16 - PAGE_SHIFT, 0};
+#elif defined(CONFIG_ARM64) && (PAGE_SIZE == SZ_16K)
+static const unsigned int orders[] = {25 - PAGE_SHIFT, 21 - PAGE_SHIFT, 0};
+#elif defined(CONFIG_ARM64) && (PAGE_SIZE == SZ_64K)
+static const unsigned int orders[] = {29 - PAGE_SHIFT, 21 - PAGE_SHIFT, 0};
+#else
+/* Fallback to default allocation order for non-arm64 architectures
+ * On 4K-page systems, these orders correspond to 1MiB, 64KiB and 4KiB,
+ * matching sizes commonly supported by IOMMUs.
  */
 static const unsigned int orders[] = {8, 4, 0};
+#endif
 #define NUM_ORDERS ARRAY_SIZE(orders)
 
 static int system_heap_set_page_decrypted(struct page *page)

---
base-commit: c2cd463d6ee7d55a3ec0719d93c49ff99022d58f
change-id: 20260916-dma_buf_improvement-a095ae567e5f

Best regards,
-- 
Pankaj Patil <pankaj.patil@oss.qualcomm.com>

