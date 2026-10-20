Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6E606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mZgjq80Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C7510F27F;
	Tue, 20 Oct 2026 06:38:37 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8181A10F27F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:38:30 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so2135468f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792478309; x=1793083109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u9+toBtEEPVpz6hTN7Pcfhr9T4/drBZovt9bfqsgE5Q=;
 b=mZgjq80YRdJr3ZwaLg8qPnesPxtiEz2tBPnvOA9Jy+E9/byEDlUTNBl6s6dFvQLkR7
 Vqi9/YCL/j6izupKF1HBBc2+rQexyuxlDTbsv/4VEWAbzTNJEtqUfJ5m17hBcBbYpzCo
 OWCHsvdBqeJ5izYfcAyLGpZvr3iAwzzvcVPtG6wpFR+JAAoY3xvfVXqCoow8EZBXjjvn
 MBHtDxJNZbI74tuFPuL/0D2vJX0KkZOWwo8Db49yKXh+HaDyGX3aTAep5tygCNeCiL20
 uGOnz+f5oJadQD6ZGjjT+jeCYZdkleA5rkoT+rb3tLQelvucRV0s7B1DjUgPPJBRIp9K
 +SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792478309; x=1793083109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u9+toBtEEPVpz6hTN7Pcfhr9T4/drBZovt9bfqsgE5Q=;
 b=xjmLZm+4ZjixUIt/FqEBo95IyUGWNQRcbvAGZJkOXXWNfA7ER+UGW/G3jXWrWNPaIe
 N5J/CrGoSac2LbUo1OsVPI2vTow4GHMJ7v39rfjLhqhp0G/XjUEg4AFASWqX/TiXpHxx
 WcZL8ULzJfb6sBrhbSX6teowudb4XbkXDxD6mrZemn9aBlc34f5tSSpGwR6wCXMDYsJx
 5R49IIlNQxWJMRSyGz8DDJ5dsLO0792Np1vYQBlMoWigTXrC01c2/GXufiwDOgAfrGAR
 yojfnoocoXnXFtDu/+4F3Ytg11AziBnYpR0G5jnZ3bXlsbTHctJNPbwi0JgZJYLwIFIa
 uAdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw11ey7dJP+dtjxBdtPFYXS+HENN3iPi9T1R5oeHpr0neBJwOj9HRjeAdmuI/4YDiFSZi5uxCPSGmE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLfi4OJ8Qo7UJRTjfYoBuI82FXYzXbYutbm5d1eL1G5UV7BLbN9
 QZTER7RjIAPwnl1wZvvxJu1yEWIRk5r2qZy5MTfopYhMS+zUZw9qZq6vZ4Ne4bwK
X-Gm-Gg: AYBFou2YKQPrKbv09kzCgmYJn/64cTW/uk2x2JP4WaVleLVHJdoI1f1ltPn6qFLAoAY
 4R5ukoL1X8LU4+udeiW9ig9XVDL4T17njN7bClRH3lUDlibcHQlCiibRj6vJ0nvjHkI1fudyKSW
 XfYuLcB9EcRYwQOjk9dxjfee6cCNmlf9WT1EX1r6actP6ts1zeoboFQseTFfy6qA5CSUCKuK8WK
 bh70dFgU44hZLUSlqp/qlSvj6LlQn8TyDU0R8FOWfFEDWB9g7HapF0ZL7eXPMw4+btRMAemP8r2
 0j4JYhEENwLf/BBzuUynMDPg3qJXfG5l85Dzovjq5VQS2XX8WEKTE/9AIhfesynpJzfssM9b2+e
 BhVV5MEBb3dL/RPZ6AW9aOj5NMfppo8GN32jSTTBTZy6lFLRlSeBwx470Z+o7Vu5dhwmnqoj2Np
 Y2FoQ6jXXfmil8WJvOR3igWo0fJbQm+iRMtq3PL2HyB/cVlHM1yvIeOxxDgAIS49LPy1pn1rP1K
 zlooXO7ARPz4t/q+etj8L9Z56/GNK4mSyU0I2YeaFX8G/pWCD7lrX7nnyEXn8DxbEEMaZbLokML
 bAt0dQuQqmFxzfzn4WNxk8IRxwBt6rmUl4r7ss/E3uIZhB5c8ibi/1KIY9NJpPsZMk3abvcjgD3
 JXA==
X-Received: by 2002:a05:6000:400f:b0:48e:d88:55e5 with SMTP id
 ffacd0b85a97d-48e0d885ae8mr18682745f8f.6.1792478308630; 
 Mon, 19 Oct 2026 23:38:28 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de.
 [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 23:38:28 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 3/6] iommufd: Clear the PAL list before dropping resv
Date: Tue, 20 Oct 2026 08:37:42 +0200
Message-Id: <65a7be483aa5e374e0afd4d72cbafab0fd07a4a3.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792477872.git.kmehltretter@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

iopt_release_pages() frees the PAL physical list while holding resv but
leaves exp_phys pointing to it. Between the reservation unlock and
dma_buf_detach(), an invalidation can see that pointer and unmap the same
list again.

Clear exp_phys before dropping resv so a later invalidation sees that
there is no live PAL mapping.

Link: https://lore.kernel.org/r/20261016194022.62065-1-kmehltretter@gmail.com/
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9e9bc6a1c..76d8803d6 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1674,9 +1674,11 @@ void iopt_release_pages(struct kref *kref)
 		struct dma_buf *dmabuf = pages->dmabuf.attach->dmabuf;
 
 		dma_resv_lock(dmabuf->resv, NULL);
-		if (pages->dmabuf.exp_phys)
+		if (pages->dmabuf.exp_phys) {
 			dma_buf_pal_unmap_phys(pages->dmabuf.attach,
 					       pages->dmabuf.exp_phys);
+			pages->dmabuf.exp_phys = NULL;
+		}
 		dma_resv_unlock(dmabuf->resv);
 
 		dma_buf_unpin(pages->dmabuf.attach);
-- 
2.39.5 (Apple Git-154)

