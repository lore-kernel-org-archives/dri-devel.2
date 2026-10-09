Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297EFCA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5876A10E32F;
	Fri,  9 Oct 2026 00:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YB7noe/U";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC5510E32F
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 00:21:28 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso63392585e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791505286; x=1792110086; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WQqOqFaR8S6Kxc8KfBqHhYsGrjh61dZF/m/XQ0uNMYQ=;
 b=YB7noe/UXEQEYMNPCtnCrPzvfBRi+/scoiTnJsoB+CGErSu1Y5FKchnRYrE9Qfluwa
 IqpUEBMz5z6ADrmPY3JAW1D0E+ZZTUFFUzbhEQMNkjf17eh29tU2hLdmXSoPw1JtLLr0
 syd4mphlQSyCxPM/DuHq9zhFpEILVl2sedr5rnCODK/dQMa4FWtzc0rNv4nVTcMqBYOc
 UNb4lwfo+Jxme3Tpa0b9N4fjuuJzfhAuqQYIwF9PNg+TCNYF+aF8m8YSa6iSc6Na1kVs
 BeC+A9sDcVNd36gL4BV3pmGkptvHhndyU1Nd3PP2DAhOi01fct7BMbby+nZrMWJIm8ff
 waxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791505286; x=1792110086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WQqOqFaR8S6Kxc8KfBqHhYsGrjh61dZF/m/XQ0uNMYQ=;
 b=ax+GKvwCaVJ8qZhaso2ZD+48nlL0SJVBpusrc4qrheYLHHxl2bdo9kF4VFCH8TOuHs
 SGiRAABmAET0drQoFlze8RtAt5Y2NSlzIKn6KHTX2hXAg+raMWp/NXl4AGT/+eAgF3Ny
 OywR1PorzwosxDzStkbAcSE0zGUDpPEjT2iXAi2tLn6OeTJ8BCDnwoADq1dd606gqv3K
 NAMHLDwJjY08WFpHXq9/UBC3Dc9qKtTriM1WK0vdjW7YB4lmhVHsDhChVlJ8OZZaDESk
 R+7rxpDx88kZ1YPIAM7nkYRn7JvobM2+qeINeOK+oB2FGWhhP57VhRPFW/A8wqZIJREE
 kH6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7g4pLkpiJOmC1JY52cMMzVcR4FI1I9hm4D2TYofiz8CchGdA30QuHEBZee61oVqsmsFDZf5IhoKw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k5VIiXDxzGbc6+eEmp9KRBwACu9CFMG0ZoxfZ5HISxL64wg3a7
 e4W4Fq+ItB5e1crAPsSFFRC/dCtQZAeBDSvekYJH4qF7TefFUigWDB0a
X-Gm-Gg: AYBFou2jtQSAyt2qh4JdMrbVqjzW78HuGkOcDn6nyOWoyqaTA7G1d9UZahm0LiPLzns
 sCrbbIOzmiHYtUIh6QoMPjASCzy3AO9LvDxlVqhOoBqcuXFjrSYNu2FVM112SdtXlPRbFTxmbTC
 YjyhRCeqtMBg8ZrNAsNFZUUNgI0AiG7/x1/98/db5faCKV0aGYP3tCpmUuVhOGYUX1Hg716xPJl
 GD21kp2MfhdlFTXvKmOGpDOrZsxeKnHJeCudnWKl5ESJYI9JN5qNbYD/MA2SemurjKEC60Wvfu+
 pMRJnVW21f/7HeLK+oXvqNNLD/dTN/LDf7ytUCYpMQ3pdwuGshj6WLSdE40NyVCZIwsdrSWqtSA
 eZ89IvWPZy1YrCN/q4H3udpS0koYF4l/oSjgJoMOktz73uPQEmd2hLAM3gwD96+eEq6ZMmbmPT0
 OHEZGm+AtbUf2/CWKa6EpBdP6e3YlNzElx4mhcLf1iB3W9mnTjifzv3HXjWnG5O0kbKIVpWrpg1
 3RSdbGJ40VniQl0+sIpcpWSmueNib/DiTxUg9DtOj5iWRNnrYgtMzoNin6Qp866v8V+aB3jTo9K
 WzRs9oVLQCxH+mnLgzM8/9KywkquYTY0eSulJmztT7Ulu4RhanFtiiw1buTz31AlYWULXHu0d7u
 8Stp+i3s=
X-Received: by 2002:a05:600c:524a:b0:4a1:8824:c9ba with SMTP id
 5b1f17b1804b1-4a18e49234fmr2630825e9.18.1791505286061; 
 Thu, 08 Oct 2026 17:21:26 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-ad61-5a01-743c-891f-b33c-cae7.310.pool.telefonica.de.
 [2a02:3100:ad61:5a01:743c:891f:b33c:cae7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e4987casm3364605e9.1.2026.10.08.17.21.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 17:21:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] iommu,
 drm/rockchip: Map private-domain imports from DMA addresses
Date: Fri,  9 Oct 2026 02:21:12 +0200
Message-Id: <20261009002114.67851-1-kmehltretter@gmail.com>
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

Diederik reported failed video-buffer imports on RK3588 with
DMABUF_DEBUG. The proposed warn-only mode [1] confirmed CPU-side
attachment access in rockchip_gem_iommu_map() during Sway video resizing.

This RFC keeps Rockchip's private scanout domain. Patch 1 copies live
iommu-dma mappings into another domain. Patch 2 uses it for PRIME
imports. Unsupported inputs keep the old page-based path, which remains
unfixed under strict DMABUF_DEBUG.

Rob's MSM approach assumes direct DMA [2]. Rockchip's attachment instead
provides IOVAs from the VOP's default domain, which cannot be mapped
unchanged into the private domain. Each import retains both mappings
and adds one reverse lookup per 4 KiB.

Christian rejected reverse translation in the earlier MSM proposal [3].
Robin NAKed exporting iommu_get_dma_domain() [4]. Keeping the helper in
dma-iommu.c does not resolve the physical-address objection.

Sharing the first VOP's default DMA domain, as Exynos does, would avoid
the translation but also change native-buffer mapping.

Is retaining the private domain and reverse-translating the DMA mappings
an acceptable direction? If so, I'll address the remaining limitations
before posting a non-RFC version.

Base: mainline 602042bf29f6. The warn-only RFC is not a prerequisite.
No stable backport requested. Strict-by-default DMABUF_DEBUG took effect
in v7.3-rc4.

Testing (builds and QEMU only):

- W=1 object and stub builds passed on arm64, ARM32 with/without LPAE,
  x86-64 GCC/Clang, i386, s390, RISC-V and UML, including dynamic SWIOTLB.
- Rockchip strict/warn A/B reproduced the control failure and warning.
  Treatments checked every page and byte in 83 imports each. Primary
  buffers had 1/127/507 DMA segments under the default 64 KiB limit.
- SMMUv3 strict/lazy tests, missing-source, bounds and rollback tests
  passed. Real bounced attachments exercised alignment and pool
  rejection with no target mapping or DMA.
- Invalid forced-SWIOTLB Rockchip provider runs are excluded. Expected
  segment-limit and unsupported-fallback diagnostics remain.

The rig uses a custom Rockchip IOMMU model and the real GEM callback in a
test module, not VOP2, Sway or a real exporter. RK3588 hardware, two-VOP
and 32-bit ARM runtime testing are outstanding.

Hardware testing is welcome, particularly with Diederik's Sway resize
workload. Compare control and both patches on the same base/config,
first with strict DMABUF_DEBUG, then with the warn-only RFC on both.
Please report full dmesg, config, exporter and visible display problems.
Keep a known-good boot kernel. DMABUF_DEBUG=n testing is welcome too.

Developed and tested with LLM assistance.

[1] https://lore.kernel.org/r/20261005064133.7305-1-kmehltretter@gmail.com/
[2] https://lore.kernel.org/r/20261006131000.81501-1-robin.clark@oss.qualcomm.com/
[3] https://lore.kernel.org/r/bd4e5ece-1358-4e0b-bb04-ba9de62d26f6@amd.com/
[4] https://lore.kernel.org/r/47bf9a4c-2a47-4e93-bcdf-8d953c9a5ab8@arm.com/

Reports:
https://lore.kernel.org/r/DLR74W1U9YPC.375IK0HOYHDIG@cknow-tech.com/
https://lore.kernel.org/r/DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com/

Karl Mehltretter (2):
  iommu: Add iommu_map_sgtable_dma()
  drm/rockchip: Map imported buffers from DMA addresses

 drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  19 ++-
 drivers/iommu/dma-iommu.c                   | 131 ++++++++++++++++++++
 include/linux/iommu.h                       |  12 ++
 3 files changed, 157 insertions(+), 5 deletions(-)


base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5
-- 
2.53.0

