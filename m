Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF1BCD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFAC6112B77;
	Sun, 31 May 2026 13:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TEQHAyAm";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Sun, 31 May 2026 09:41:52 UTC
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCA610E5B7
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780220510; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=wXubRgIQov6KKC0DBoFpb8dlsukOt/+vAZvDFHs1O38=;
 b=TEQHAyAmuznCEpXVLr2SuwxsE4jLfIfqIJeXB3MSII902axbs48NUeP1pGlW2q4Gh6Xz/EAGKZR3vD32UKa03uCpJQTEPCpd45NE5+YIi/1N5zFesYojnEpgGYVRZk/U3UtRXpVbWBx6tM0b2qq+BeMa1hyQW0u14BR8zE7HrU8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R831e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=27; SR=0;
 TI=SMTPD_---0X3tRVlc_1780220197; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X3tRVlc_1780220197 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 31 May 2026 17:36:46 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, alex@shazbot.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jgg@ziepe.ca, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org
Cc: xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com,
 shiyu.zsq@linux.alibaba.com, wei.guo.simon@linux.alibaba.com
Subject: [PATCH 0/9] iommu: introduce iova_to_phys_length for efficient
 IOVA-to-physical translation
Date: Sun, 31 May 2026 17:36:28 +0800
Message-ID: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260529115116.GR2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:32 +0000
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

This series introduces a new iova_to_phys_length() interface across the
IOMMU subsystem that returns both the physical address and the PTE mapping
page size in a single page-table walk.

Motivation:

The existing iova_to_phys() only returns a physical address without any
information about the page size of the underlying PTE mapping. Callers
like VFIO and iommufd that need to traverse IOVA ranges are forced to
walk one PAGE_SIZE step at a time, even when the IOMMU has mapped large
regions using 2MB or 1GB huge pages. This results in O(n) page-table
walks where O(1) would suffice per mapping entry.

Approach:

The new callback .iova_to_phys_length returns the physical address and
sets *mapped_length to the PTE page size (e.g. 4KB, 2MB, 1GB). This
allows callers to skip ahead by the actual mapping granularity.

The migration follows an add-migrate-remove pattern to ensure every
commit in this series compiles independently (bisectable):

  1. Add the new interface with fallback to legacy iova_to_phys
  2. Migrate all IOMMU drivers (io-pgtable, generic_pt, per-SoC)
  3. Migrate callers (VFIO, iommufd, DRM)
  4. Remove the deprecated iova_to_phys from ops structs

Performance impact:

For VFIO unmap of a 2MB region mapped with 2MB pages, this reduces
page-table walks from 512 (PAGE_SIZE steps) to 1 (one per 2MB PTE),
a ~512x improvement in that path.

Guanghui Feng (9):
  iommu: introduce iova_to_phys_length in iommu_domain_ops
  iommu/io-pgtable: introduce iova_to_phys_length in io_pgtable_ops
  iommu/generic_pt: implement iova_to_phys_length
  iommu/arm-smmu: implement iova_to_phys_length
  iommu: apple-dart/ipmmu/mtk_iommu implement iova_to_phys_length
  iommu: direct page-table drivers implement iova_to_phys_length
  vfio/iommufd: use iova_to_phys_length for efficient unmap
  drm/gpu, iommu/io-pgtable: switch to iova_to_phys_length
  iommu: remove deprecated iova_to_phys from domain_ops and
    io_pgtable_ops

 drivers/gpu/drm/panfrost/panfrost_mmu.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  2 +-
 drivers/iommu/apple-dart.c                    | 11 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 ++-
 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 13 ++--
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 11 +--
 drivers/iommu/exynos-iommu.c                  | 21 ++++--
 drivers/iommu/fsl_pamu_domain.c               | 26 ++++++-
 drivers/iommu/generic_pt/iommu_pt.h           | 49 ++++++++-----
 drivers/iommu/io-pgtable-arm-selftests.c      | 12 ++--
 drivers/iommu/io-pgtable-arm-v7s.c            | 25 ++++---
 drivers/iommu/io-pgtable-arm.c                | 14 ++--
 drivers/iommu/io-pgtable-dart.c               | 17 +++--
 drivers/iommu/iommu.c                         | 30 +++++++-
 drivers/iommu/iommufd/pages.c                 | 71 +++++++++++++++----
 drivers/iommu/iommufd/selftest.c              |  2 +-
 drivers/iommu/ipmmu-vmsa.c                    | 12 ++--
 drivers/iommu/msm_iommu.c                     | 25 +++++--
 drivers/iommu/mtk_iommu.c                     | 12 ++--
 drivers/iommu/mtk_iommu_v1.c                  | 15 +++-
 drivers/iommu/omap-iommu.c                    | 32 ++++++---
 drivers/iommu/rockchip-iommu.c                | 11 ++-
 drivers/iommu/s390-iommu.c                    | 15 ++--
 drivers/iommu/sprd-iommu.c                    | 13 +++-
 drivers/iommu/sun50i-iommu.c                  | 13 +++-
 drivers/iommu/tegra-smmu.c                    | 12 +++-
 drivers/iommu/virtio-iommu.c                  | 13 +++-
 drivers/vfio/vfio_iommu_type1.c               | 24 +++++--
 include/linux/generic_pt/iommu.h              | 13 ++--
 include/linux/io-pgtable.h                    | 10 ++-
 include/linux/iommu.h                         | 12 +++-
 32 files changed, 404 insertions(+), 146 deletions(-)

-- 
2.43.7

