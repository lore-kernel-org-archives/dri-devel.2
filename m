Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B0DC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5BA10ECE6;
	Tue, 29 Sep 2026 05:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="flMYbRV7";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D5F610ECE6
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 05:48:50 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so23198255e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 22:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790660928; x=1791265728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9WcZ52LtgxmvNFnY7nqHOBLnLq9Jyv8OCVXDEjqGBY8=;
 b=flMYbRV719saamW0FJmwqANxzcjFzc0hTf7T6t0LvPJY+x+5/jnDP9axpWaphJeqV5
 zdloxMdaFJT+UAYz7ja1HmPnXibLZhYRjTD7ZYwT2LOz413FKZPsncph9tSrgDtA6P6R
 wOVZjfavcpP+dNXDTg2OmeDEITzwZqfmMZZURVULpsCrRtvnysUI5gbx3o/xEa6lpWUk
 ZJ6TGfoo6w53Ead98fBeGYnR0c8gpP0NPPBOuTkZyWhRWi9QeANG9comATdMw3EuhlNk
 A6/8By5TrWHQtwxAUUAwWhZJ+2AzM1q8tfB1yL+K8Q6uVJx0GoKwm39WJC6xWwKUwVTh
 fkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790660928; x=1791265728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9WcZ52LtgxmvNFnY7nqHOBLnLq9Jyv8OCVXDEjqGBY8=;
 b=L0Uov9kviVtNeqGQnkrpqRWYCJoe03NJLqIM8c3IEFr6drrNOk4TDZZRK7U1fRFxE+
 OUQ16MNM/48IJIt2zZvBGjkP4zeoF9k4wL5le2mKXnxBxwGYJ9gHM5wSgb7QMBkhiHvW
 fvogDJSACazPQLRlIXljsbjiX1Mh4sAwjRrGK2ikkskedKWH+8B7vRJxbyjK7JhvntjR
 1AYVZXqy1HV2bLk+hqt5SYUaFMgmdeqgrCLnDb3XfoCIrkEevIV9yCmiADN5lNEQAawy
 0MOs6v4QzkQh1L24LOhLOZ7+j1wOz6nq4F8AO4meVseaGMHmuuHmJ1J4/VTSeznTYpKi
 Bnsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkGuknTvqigA0VjkzqFal+ql0Oih+e38KGClWdR0eklJf7XFnoTbwdFYL9LUkUgsqh0g/VyQd0bKE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k9aiwOMMsNI9pWZkBuvnDqS32Dwdtf8U9ATfHBQ79ooFpBSHyf
 Lgpj8dT1GW9tYVwhgTTaip0ItIH/ii5cjJTiqn0UGsO0Eiqgu4BmskXl
X-Gm-Gg: AYBFou1VaWj1wT/J1TBmYuVEReB7z2leJ8HvFQikbaBr9UdnTMf6AJ4Aula4raVUKiI
 g/ctPaDtM7goqIXOzIlq37HCdajwqxgZOITFLywZSjVICN+3lWTDuBc4BwF8lxx4pigOE2Kdq9b
 6nv+nUz8LZLBGw2oOSyM/p+EdC8IW8WWhuqxYhBiLFRr/9U7WXBCOCiW5qQCRr15Y2E2wzIX5oQ
 8t0umINxTvVdpxxBxZ0HEpOZvmjNXIn5Z+k1NCVTzrKldMLeQOvYOZsgasg0MC0jyxrhDa7AGdL
 HeL0Fp8yrst/3MMb2ul+1lOmzp7Qv1ug0VFBgcEwDDFv6z/JLFojyhfQ0qWDOyiK/HY/zAlJevm
 7VwREwG1q1yR4RnVVkAAxm4MDqRBo1To6yvWEyXMkdnFnBDP5gcTLqzojOsonpYBzjzoFKl9lzT
 LiNj6UmD+xfflKLzqf+aSeAgI/MWVPfZW2yq/0z9kVAgGLkdcknVYQmXNFikub6cdoMGgvuaQbx
 r/lnVapRHCPRlXQBdUHrR7JIaNkxYJESb4Z3S4zGqY2PqQf6DdTMKz9BhKu5MnoYbMB2UsHVRei
 k+DYPhYgoMjUEsYp5vaefs8AmI2A/zG7BfxbzKEx6neK07qm+gooiHIahB9VP4hsSm02ABbyLs1
 k
X-Received: by 2002:a05:600c:530f:b0:49f:ffdc:939d with SMTP id
 5b1f17b1804b1-49fffdc9a4amr93691455e9.9.1790660928275; 
 Mon, 28 Sep 2026 22:48:48 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9c32-f801-0451-cc94-d3ca-f56b.310.pool.telefonica.de.
 [2a02:3100:9c32:f801:451:cc94:d3ca:f56b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf8fa5bsm58477615e9.6.2026.09.28.22.48.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 22:48:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] udmabuf: respect the device's maximum segment size
Date: Tue, 29 Sep 2026 07:48:35 +0200
Message-Id: <20260929054835.94118-1-kmehltretter@gmail.com>
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

  DMA-API: misc udmabuf: mapping sg segment longer than device claims to
  support [len=65884160] [max=65536]

Use sg_alloc_table_from_pages_segment() with the mapping device's
maximum segment size. Return -EINVAL if the limit is smaller than
PAGE_SIZE because the page-based allocator cannot honor it.

Before commit 5bf888673e0d ("udmabuf: Do not create malformed
scatterlists"), each entry covered one page.

Fixes: 5bf888673e0d ("udmabuf: Do not create malformed scatterlists")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Changes in v2:
    - Return -EINVAL when the maximum segment size reported by the device is
      smaller than PAGE_SIZE instead of clamping it. (Christian)
    - Add Jason Gunthorpe's Reviewed-by tag.
    
    Tested on v7.3-rc4-70-gfe2ec83746e5 in QEMU (x86_64, TCG) with
    DMA_API_DEBUG (all_errors=1) and DMABUF_DEBUG, A/B against the same
    base:
    
                                            before        after
      DMA_BUF_IOCTL_SYNC, 64 MiB udmabuf    1 report      0
      vivid import, 4 MiB udmabuf           2 reports     0
      vivid import, 2 MiB hugetlb udmabuf   2 reports     0
        frames captured                     5/5           5/5
    
    vb2-dma-contig rejected the non-contiguous import in both runs.
    
    For v2, a focused importer advertising PAGE_SIZE / 2 returned
    -EINVAL under KASAN and DMA_API_DEBUG. No warning, BUG, or DMA-API
    report was emitted.

 drivers/dma-buf/udmabuf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index df6dd00462423..018937435356e 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -133,15 +133,22 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 {
 	struct udmabuf *ubuf = buf->priv;
 	struct sg_table *sg;
+	unsigned int max_segment;
 	int ret;
 
+	max_segment = dma_get_max_seg_size(dev);
+	/* The SG allocator requires a segment limit of at least PAGE_SIZE. */
+	if (max_segment < PAGE_SIZE)
+		return ERR_PTR(-EINVAL);
+
 	sg = kzalloc_obj(*sg);
 	if (!sg)
 		return ERR_PTR(-ENOMEM);
 
-	ret = sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount, 0,
-					ubuf->pagecount << PAGE_SHIFT,
-					GFP_KERNEL);
+	ret = sg_alloc_table_from_pages_segment(sg, ubuf->pages, ubuf->pagecount,
+						0, ubuf->pagecount << PAGE_SHIFT,
+						max_segment,
+						GFP_KERNEL);
 	if (ret < 0)
 		goto err_alloc;
 

base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.53.0

