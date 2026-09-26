Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7674C98328
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417E710E013;
	Sat, 26 Sep 2026 07:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cfpt2Llr";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4A910E013
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 07:13:06 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48884b021dbso269226f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406785; x=1791011585; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rY5HCiFtt5IzvJR7OZXNoiF5Qm5UV5uB0Zymmp5HUaY=;
 b=cfpt2LlrTQKQndMPlqCUIfKEi7JaXybRPudR9ePr5XtRJm11zq+/lWI+4Os3Hj/79k
 2eZ8omd9R9Y/9uYM59HAkc5S86Zna2vwFDgaQwMhzl3Q3oEoYU/EVg7YidS+8yRYCmwd
 D0shwBCw6U+TVr6zlAMxq2o8D/nBuy4i+tQRH8FqAt4oEoJv+I9NW0hHlcRWC+jAIIuT
 Smn234Wjqy8+1WLzeug6hlegbBojENOnQwjB8LTFpM/COxhYXwUkB1D51CHAF4WYDeFk
 QcJuMkt198Ik+MPJvMPVkDQQakDLatwRIAL1wHDA2R4ohS0jGVl8g/mcUMV4FjDn+bjl
 DMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406785; x=1791011585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rY5HCiFtt5IzvJR7OZXNoiF5Qm5UV5uB0Zymmp5HUaY=;
 b=EcN2Mc/mo7gsH9XWWEjTWfNlZodAteQb9Rr6f44yIqgMzcwrU8GLDDmBouriX38Pnn
 w3zeANjp5MJe98tHYHT37i9ObRhE7v3HdDPd2B6O+VJODP8/j7okFYy3L1iaWGKyJNDD
 oGu10BE717zDlLJ6sGUiMYsn9j0kO8DLu4FiXSvdl/g3KtbZ0Aqb0qbiMIFIKcoPWVxr
 3DM2fKeqFQt3QLY585dW2+20DQNNX7zGDjr1/FNUCM4xxPuZye1KyBqylU6HJMg7pwYd
 0GrgNANUyuOhGdHXJfMcDBHjj0C/coPficdQQkXjsmVMQbhBbal3tcGWMTwg0JPN70tR
 PAsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0SS0HyTjT3SQTXC+pJx+Kl9RO6ZrWOIsVAgqt1c6ULKjnjXBDmhGJj+TV/l2SC5nybz+yyrX1zZs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m4Hy1GgWxVyZWVKAfgpHmH0SawE05Y7yjOqHUIZ4qVWsU7JFgH
 RUwATNIDqUY1qZ8kVtBzz6dK0xnTsmZFv2gQKugFJEqk0qa9pS/9UWPn
X-Gm-Gg: AYBFou1fJeB2+3xHChlVwmoNA3Ng4G3nclYTBcpGhoE1YJUXzJLd/78l+m60V3N9plq
 6b9j00X+Dlbe4K/GhgA32y+LKWlWIH6IOf5vuuQdhvLD0MPm/211OyTdJBgMmRkTILnOiOmP0iS
 hQ6/ICS44TIBJQNItcck7nAGWaLbUwa5/tNzFdHQgPZq7QjyW9qEiSJuFLdBAYcWsFc5eHdXYvd
 onr/2p/ls+w9Y1hmE0HHeUxVzwdX8gH0uZEtbFhWFGYLcuJkrq8uBX5E8UTB8yVXIUTdlLjoBg0
 TMLaFdbbLPjS4WR2klslL7SspWBYGFnQ12ZosOGnEOCy7buNC9A/nntk2pMmBtbiwakkYDzWrbH
 Y7hLrHZqPzvXKjmeuMKC+gdCJuZ3hH4O2QATfwditM/rz1bM0K3MUZQrc4fPswGLUKcNqBFCZuJ
 /NGLs4b2x2fOFYMdIuhCTkrAYNwxZ4LMG2E9AmOoUnncroBbQemwPYZDaWsO/99F6S4YVcpKiqO
 ymmx7IDLsePP4l6KSCnOZrqCks9f/5NAWkcJHjzktG+seNrEQ9V9PZrofORL2rWq1j9I7Y4JpoK
 g4IjI5jHYdK8s1RYk0kLnz8j06agmjHrCueNSHH3bMPJnuSyxXZKfiSw63k9j+rOHStEJ66my6K
 mngPHDiQzMPaiHSuTAg==
X-Received: by 2002:a05:6000:2583:b0:485:8ee0:dfc8 with SMTP id
 ffacd0b85a97d-4887175a69cmr16191456f8f.41.1790406784608; 
 Sat, 26 Sep 2026 00:13:04 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de.
 [2a02:3100:b162:c701:4960:a998:3de8:2fce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a570sm11592286f8f.13.2026.09.26.00.13.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Sep 2026 00:13:04 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] udmabuf: respect the device's maximum segment size
Date: Sat, 26 Sep 2026 09:12:58 +0200
Message-Id: <20260926071258.77202-1-kmehltretter@gmail.com>
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

get_sg_table() merges physically contiguous pages without accounting
for the mapping device's maximum segment size. This affects both
importer mappings and the udmabuf misc device mapping used for CPU
access.

With DMA_API_DEBUG enabled, DMA_BUF_IOCTL_SYNC on a 64 MiB udmabuf
reports:

  DMA-API: misc udmabuf: mapping sg segment longer than device claims to support [len=65884160] [max=65536]

Use sg_alloc_table_from_pages_segment() with the mapping device's
maximum segment size. Keep a PAGE_SIZE minimum because the allocator
warns and returns -EINVAL for smaller limits.

Before commit 5bf888673e0d ("udmabuf: Do not create malformed
scatterlists"), each entry covered one page.

Fixes: 5bf888673e0d ("udmabuf: Do not create malformed scatterlists")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Tested on v7.3-rc4-70-gfe2ec83746e5 in QEMU (x86_64, TCG) with
    DMA_API_DEBUG (all_errors=1) and DMABUF_DEBUG, A/B against the same
    base:
    
                                            before        after
      DMA_BUF_IOCTL_SYNC, 64 MiB udmabuf    1 report      0
      vivid import, 4 MiB udmabuf           2 reports     0
      vivid import, 2 MiB hugetlb udmabuf   2 reports     0
        frames captured                     5/5           5/5
    
    vb2-dma-contig rejected the non-contiguous import in both runs.

 drivers/dma-buf/udmabuf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index df6dd00462423..09f1eb8432f19 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -139,9 +139,13 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 	if (!sg)
 		return ERR_PTR(-ENOMEM);
 
-	ret = sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount, 0,
-					ubuf->pagecount << PAGE_SHIFT,
-					GFP_KERNEL);
+	/* The SG allocator requires a segment limit of at least PAGE_SIZE. */
+	ret = sg_alloc_table_from_pages_segment(sg, ubuf->pages, ubuf->pagecount,
+						0, ubuf->pagecount << PAGE_SHIFT,
+						max_t(unsigned int,
+						      dma_get_max_seg_size(dev),
+						      PAGE_SIZE),
+						GFP_KERNEL);
 	if (ret < 0)
 		goto err_alloc;
 
-- 
2.53.0

