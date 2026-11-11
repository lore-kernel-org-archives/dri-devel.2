Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF8606A33D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kH17knM2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBBB10FD89;
	Wed, 11 Nov 2026 19:24:41 +0000 (UTC)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6221010E456
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:24:23 +0000 (UTC)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4ea2c058e67so3962056b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794425062; x=1795029862;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
 b=kH17knM2M/9rfiHepX67n/F0dDAVH+Lc6NAB2C9ll3tHUt8Z1y2Mtwq4SAVagA9zzY
 iA8fmgnv3mBd+MrhPS6rU0fYiME1mLTYgiIp/ycT9+IZ9vagmjlDTe8BGTR6Lp4OBvbS
 JobO//ZojmqEfPPmr19kRpGER8ji2vzmdBc0ujy3S8AQdoIJZY7EZhfsLgD4IjXPvWXX
 Kc+Q2dNtgGhUNCF47Ffz9Zxi2EMz9xprCNObZcIVfWvsBN6Jf06n804E+KuzZvF9HGo4
 VOZ9wmlw11nSUxXfJ1eYAzHyoS0AtODrezxJRp8aZ0hLmUtCkBg87cDXuCmYpM+cjB4G
 WQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794425062; x=1795029862;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
 b=RnM35xSqpy8GB5iUUI4bhuirFo4CtHxt8BGD44sL3xhufa39HtrlJz8RGxTrU/tkhb
 +afRdaOwT1bd0Cq0mdFiHRkkO9FzTAPS/W4eDyv6DNb1QK6u7WNlyKRXKxJWgQGsnwHq
 qaA0ugVVkTy/GwHiI3LFucmn9vjguIi51MsFWVS0ESKp6AQXjExTTZeD2+rGTO509ZNq
 YuODIzR8DWd5HHGcmLEtzKw+qIXxGp2mkgmPKixHxfzfG9twUI+It78paLCBIHE6lrb/
 5Gj9MDvGf51hZ5i7NJx2mQu2P66mpWyqv5KSDMbOWkIJs7/z3KOsSFIMS4OzQIuvA3H8
 BB+w==
X-Gm-Message-State: APuU4Z97IVPv2XEqopPJ5fSlVRVaVtxHu/Hdm0h33k85cAkNe0WivA6L
 qPBOydjxvP2W4o915p0GRKpKcGva+JE4LE7KgZM3flWA7WHxdAr1IrQcksZKxU9RsfnYEPtMS70
 HCETVPF2B+wvYl7R/guKOSbveBDhkEye+XiA7eilLqykf8oG3HltGsouJQOrk5qnoiPEL6tb2bl
 qKtdZ58zkmi3130lI273HQDo6Bi4wAEJyJE01PboSKQ138a5jOOGeJGhEAOZI=
X-Received: from ilbec1.prod.google.com ([2002:a05:6e02:4701:b0:527:120b:a51d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:191f:b0:53f:3c0e:c74b with SMTP id
 5614622812f47-56b93447ed4mr3152606b6e.9.1794425061950; 
 Wed, 11 Nov 2026 11:24:21 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:09 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-6-dmatlack@google.com>
Subject: [RFC PATCH 5/7] vfio: selftests: Add iommu_map_file() helper
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 David Matlack <dmatlack@google.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Matt Evans <mattev@meta.com>, 
 Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add iommu_map_file() and __iommu_map_file() to map a file descriptor
(such as a memfd or VFIO PCI dma-buf) into an iommufd IOAS via
IOMMU_IOAS_MAP_FILE. Also skip regions without a host virtual address in
__iommu_hva2iova(), since file-backed DMA mappings do not require one.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  9 ++++++
 tools/testing/selftests/vfio/lib/iommu.c      | 29 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..2b39c49e66da 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -42,6 +42,15 @@ static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
 	VFIO_ASSERT_EQ(__iommu_map(iommu, region), 0);
 }
 
+int __iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+		     struct dma_region *region);
+
+static inline void iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+				  struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_map_file(iommu, fd, file_offset, region), 0);
+}
+
 int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped);
 
 static inline void iommu_unmap(struct iommu *iommu, struct dma_region *region)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..ba602685f892 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -71,6 +71,9 @@ int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova)
 	struct dma_region *region;
 
 	list_for_each_entry(region, &iommu->dma_regions, link) {
+		if (!region->vaddr)
+			continue;
+
 		if (vaddr < region->vaddr)
 			continue;
 
@@ -149,6 +152,32 @@ int __iommu_map(struct iommu *iommu, struct dma_region *region)
 	return 0;
 }
 
+int __iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+		     struct dma_region *region)
+{
+	struct iommu_ioas_map_file args = {
+		.size = sizeof(args),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE |
+			 IOMMU_IOAS_MAP_FIXED_IOVA,
+		.ioas_id = iommu->ioas_id,
+		.fd = fd,
+		.start = file_offset,
+		.length = region->size,
+		.iova = region->iova,
+	};
+
+	if (!iommu->iommufd)
+		return -EOPNOTSUPP;
+
+	if (ioctl(iommu->iommufd, IOMMU_IOAS_MAP_FILE, &args))
+		return -errno;
+
+	list_add(&region->link, &iommu->dma_regions);
+
+	return 0;
+}
+
 static int __vfio_iommu_unmap(int fd, u64 iova, u64 size, u32 flags, u64 *unmapped)
 {
 	struct vfio_iommu_type1_dma_unmap args = {
-- 
2.56.0.567.gdb80ae8cd5-goog

