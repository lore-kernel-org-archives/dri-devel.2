Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224A9CD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507C210E97F;
	Tue,  5 May 2026 07:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LiczH0V1";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A7C10E056
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 03:18:01 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-82fb2d0c5d1so2305740b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 20:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777691881; x=1778296681; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3e6vluYW3fo6JWb+C8AXsi9rzlLtgDWHGIF2Au/3q08=;
 b=LiczH0V1L1Z6eSPxkJDePcgIC1ToXE57ldvqyRR1yhcOBjgEYAYA3OG8LY4fy695Ee
 QrNMbAoUrMqcnd26voybMBNGomAkS6HF2D3trp08b3OCVJo+l1F+/z7ec2BE1NEgWBAC
 V1564nsR1fI4wHc01WYWQ/tEb+rT8HmeFbPwjqoVoQnKwN62tL7bRV209TLBt1H+H8zB
 RNPW0oUbeqlSXkz656pXRuR/9rewO+HaYFUrcspgrYiOEX1S9J1AGixPZQrR5SLlpE8K
 /zVeokB/W9sjjXKmul5pQh3KnDgyq7lcKwZkgHb7/q5zrORZCqUC/vLD6TFdcPYTuy24
 SNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777691881; x=1778296681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3e6vluYW3fo6JWb+C8AXsi9rzlLtgDWHGIF2Au/3q08=;
 b=k1D3x0QLuIVg1lB9U2tO5y7mbmdkuoBg7RLHM4kMMr2Z/tFd8o4Xsgj5lq7V6YRr5g
 b4QINr2mw+1oRNbDsFps6aH/u6++UkBg8gsE1fG4T00RVQQ0wOh/8XTXflzrt+rJ8+6o
 2vDBBkJmBEjQgdRHaQrKU1KFBaCxNBdkLDG7fq1invq5FkDrM26DKhzC1uWwGvB7Duy1
 OeBDatsfK4mQKOXuHRSkHHDJXD+zb6YuhwOV6YzYPK9IbcF/600/MlAok5BMVl0hu90f
 gg/AIkk6IIev2PRG3LYbMeyr2nso177SG0Y6H63xoU6gKZpf1i/sf2GB29PhP6RMdjY3
 GI0g==
X-Gm-Message-State: AOJu0YxU1wbfXt7UL2YtcMIoYDY0K5tebQz38ebse1E6jOUFAn06Sdhr
 TOHcu0AMebhu6xgtPCLfXXe8i0wJhKJywhzKdypsZkCZXNDaLLLtnONEzCHm0nby
X-Gm-Gg: AeBDiesPN/yeng8UuAxpspIwodm47ccwPFrNH+dnaJ/FpWvUAPdezNeVa9KmixQOi/Z
 QJybedU1ILR7oohT/pIL+9WrId/K+8gezsft+yG9ny4O43Pt173+po94R5g+uaaVqMKlBSADbJ3
 RnkJPHkVSs9cGPXpV6kjkrAzYxbEkW058WTwzfsy8tBIPq3SxqdM1zbQMBc96MlrO0pimvmsmEa
 LTeePLoSWkPfiCIHCZj0sfV13SkuHFr8jUg6EyXRlbxeNoJ9XT/9UJiRwoj3EAt+HXYxNHdZ8iq
 lzecd0cXU1vCJsK8xs7gHkIQPo3YG/KzL5qfeSVxvtMFfYNf2pnBvqCvd76R8PgWj7hoggDZI5M
 b05/VzKF8Zls5dzhk/gF3y1zUNZq7TcH7ynFvH/UgfeHtX5nTH6PnTVzgCCDp4Zub1wx7DFLR3p
 SRbN5voSEq5I+xnFmDLFea7MSxeOljJLi1H4+WTsI=
X-Received: by 2002:a05:6a20:734e:b0:3a3:1f78:2025 with SMTP id
 adf61e73a8af0-3a3d214bc9fmr8972254637.27.1777691880874; 
 Fri, 01 May 2026 20:18:00 -0700 (PDT)
Received: from vini ([2401:4900:8fcb:edbd:7155:edb6:dac:107e])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbbaac5bsm3263849a12.6.2026.05.01.20.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 20:18:00 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Vineet Agarwal <agarwal.vineet2006@gmail.com>
Subject: [PATCH] drm/amdxdna: fix pinned_vm accounting and rlimit rollback
Date: Sat,  2 May 2026 08:47:46 +0530
Message-ID: <20260502031746.621606-1-agarwal.vineet2006@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

amdxdna_get_ubuf() incorrectly accounted mm->pinned_vm using the requested
number of pages instead of the actual number of pages successfully pinned
by pin_user_pages_fast().

Since pin_user_pages_fast() can return partial success, this led to incorrect
mm pinned page tracking and potential imbalance between pinned and unpinned
memory state.

Fix this by:
  - tracking the actual number of successfully pinned pages (pinned_total)
  - updating mm->pinned_vm only after successful pinning completes
  - adding proper rollback on rlimit failure path to maintain symmetry

This ensures mm pinned_vm always reflects actual pinned memory usage and
keeps accounting consistent with other kernel subsystems such as RDMA,
vdpa, and iommufd.

Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_ubuf.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index fb999aa25318..ad609846ea30 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -132,7 +132,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 	unsigned long lock_limit, new_pinned;
 	struct amdxdna_drm_va_entry *va_ent;
 	struct amdxdna_ubuf_priv *ubuf;
-	u32 npages, start = 0;
+	u32 npages, start = 0, pinned_total = 0;
 	struct dma_buf *dbuf;
 	int i, ret;
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
@@ -176,13 +176,6 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 
 	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	new_pinned = atomic64_add_return(ubuf->nr_pages, &ubuf->mm->pinned_vm);
-	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
-		XDNA_DBG(xdna, "New pin %ld, limit %ld, cap %d",
-			 new_pinned, lock_limit, capable(CAP_IPC_LOCK));
-		ret = -ENOMEM;
-		goto sub_pin_cnt;
-	}
 
 	ubuf->pages = kvmalloc_objs(*ubuf->pages, ubuf->nr_pages);
 	if (!ubuf->pages) {
@@ -203,6 +196,16 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 		}
 
 		start += ret;
+		pinned_total += ret;
+	}
+
+	new_pinned = atomic64_add_return(pinned_total,
+				&ubuf->mm->pinned_vm);
+
+	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
+		atomic64_sub(pinned_total, &ubuf->mm->pinned_vm);
+		ret = -ENOMEM;
+		goto destroy_pages;
 	}
 
 	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
-- 
2.54.0

