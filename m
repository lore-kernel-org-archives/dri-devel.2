Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F60C98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6884110E77E;
	Mon, 28 Sep 2026 05:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VM9hPf9C";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E7710E77E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 05:39:10 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-86dba3e584dso75931b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 22:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790573950; x=1791178750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e1GfyXNzZ7U9i0Z+Tk5I9ck9dnyRvvtvnuEFHqewoGY=;
 b=VM9hPf9Cy1EoI1enx4zqO4aIaAorWREH09ddnquEdExvyQUdxd4u6Zeo7dCezZWZzR
 iA9i+OuJ+Ae+GswpZDgtyTYeqUmMXoT/qaKzmd2jXIZ0ApYKp0ped8NTAVAEqMgi+6N+
 vhmJAULx0RqF7qF7WnfirFg2YP6X1mV6FMDDh/t0IP10UmjQP+gZzgzIqqG+iTuO73pg
 Ksw0GM9MwLU4es3XxhrYg3f7AlP3toz9UkKErKE22DcnBQiHHcJv3TDkIRrb+RzL5jAL
 xejE8qR9Uq7R+388Y59AOoXDOkkheT3BPMBtioYsXeU58ly5GXqO+4ZGE9ZD0iqiGbwv
 Da9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790573950; x=1791178750;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e1GfyXNzZ7U9i0Z+Tk5I9ck9dnyRvvtvnuEFHqewoGY=;
 b=lzgKjzLp2Kl3Ci/B5SibT7kQmupRRQyOtfGZFwwNeYbyPUT4ly3UHfLMdWeHnxylwm
 nFKQaywtuqzBzY76Nc4n6s8JpLEH1ycQ8xsSewoupWNw2kRCWv/qRYJ37PB+g6d4QOqg
 pxvaB7+MoYitPJjPA4NLTaPnvAKSoorC0NWDXR2WhNEFB3T4IGv3X74kvzPJsiykEaZJ
 XPB4KuAkGVbtmonh9XoQh1HAvQvzdl8Dgnawr3f6qvGaN+p5gmVzSFnbno/k0E8NKLaB
 4aXCs0+yw6ZjyzuqocpgktOuTvqaNOMH0NVVHyq1M11og4GK0YprAX68WbxReSnvGQV8
 0zCw==
X-Gm-Message-State: AFuF++lxcgT5Vo77SNcfeskhAR6rxSAvQcBHpCyOIG73/QnCmp3FSFTW
 1tBsLyBwKV0twZma2jxGTevI5qWCZ037c7D37y3ji2TeHb01KsnsEgEynRcL5zur
X-Gm-Gg: AYBFou2srDUtxlIYK5tYc+J+JMggrDMlsnlcpgrhqqmN5ZfGYAFHpex0FvL27O0kIAy
 vdeUYD+54teq6iVU+8TNa7UOcuBNYmrvH1Kk9WBN4jYgi5af4y8zlREQlU97lVHNXE57Rn+VOwh
 7MxHa07DK2Kv8nrlGPbJW3aYgRbXnK2oWyYdJDMQyJ3RJLhWR3q3bxwEhkrkIGiIMTbVtxtzU/s
 PKesBq/Oc2q8zhBlpSmyuyQDQiUu1w/ZtolpwE5xkPih5X+cNVFWV7lqin4M7mHXzR8SgWyZILn
 mb6DVpkEkGYvjfazWTEBvjNL8PMF9jEUbub50HvDBm1w4Ym1+fn0zecBonA+rK2tCrFlVIak2jj
 OBoOSg0G1I7mTIiuvuv2sTTbOe0dAT6KT2bvGGvS285wvzrtqBG1bt1odQ9R/USzzNjD17oRS+U
 NtRkq7uKIOPcY8+xL6o4aEFts4tmuOLsq+rj9FRilzRLrZBsAZMiVLO6JNZkOxZXggPxkKNPhDU
 LycreIj1NfUIg==
X-Received: by 2002:a05:6a00:4807:b0:864:59e2:2968 with SMTP id
 d2e1a72fcca58-87fd0d8cbc6mr6922416b3a.0.1790573950242; 
 Sun, 27 Sep 2026 22:39:10 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87febb82357sm3591121b3a.61.2026.09.27.22.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:39:09 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, freedreno@lists.freedesktop.org,
 iommu@lists.linux.dev, Dmitry Baryshkov <lumag@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 Bryan O'Donoghue <bod.linux@nxsw.ie>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Will Deacon <will@kernel.org>
Subject: [PATCH v1 0/2] drm/msm: followup - map page-less imported sg_tables
Date: Mon, 28 Sep 2026 13:38:49 +0800
Message-ID: <20260928053901.7270-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


Hi Rob,

this is the follow-up I promised: it fixes the two remaining map
paths that still consume struct page/sg->length of imported
sg_tables, and therefore completes the DMABUF_DEBUG=y story when
applied on top of your series [1].

Test results on x1e78100 (Snapdragon X1E78100, DMABUF_DEBUG=y,
kernel v7.3-rc4 based), which is the machine that originally
reported the UCHE translation faults and the one hardware test
environment for imports of buffers not first exported by drm/msm:

 - v7.3-rc4 stock: arm-smmu UCHE translation faults during hardware
   video decode in clapper/chromium (bisected to 143755bdabaa9)

 - your series alone: video plays via the userspace copy fallback,
   zero GPU faults, but a WARN storm from __arm_lpae_unmap()
   (472 traces within a minute of video playback) - every map of a
   page-less sg_table silently maps nothing, so the matching unmap
   finds no PTE and WARNs.  This matches your cover letter saying
   the map paths are not addressed by the series.  Your patch 2
   ("mmap imported dma-bufs via the exporter") in particular works:
   a test importing a linux,cma-heap buffer via
   DRM_IOCTL_PRIME_FD_TO_HANDLE and mmaps it both through the heap
   fd and through msm's GEM mmap sees the same memory through both
   mappings, including writes visible in both directions.

 - your series + this series: zero arm-smmu faults, zero io-pgtable
   WARNs, and hardware video decode displays correctly in clapper
   and chromium.  The GPU per-process pagetable path is exercised
   with real decoder capture buffers (videobuf2-dma-contig, 2MB
   frames) and maps them from their DMA addresses.

Patch 1 exports iommu_get_dma_domain(), which msm needs to look up
the dma_addr -> phys mapping of imported buffers through the msm
drm device's DMA-API domain.  On platforms where the drm device is
direct mapped (like mine: ae01000.display-controller is in no
iommu_group) the lookup degenerates to the identity; on platforms
where it sits behind a translated IOMMU the translation is needed.

Happy to rebase on whatever your tree looks like - and I can rerun
the full test matrix (WARN count, fault count, kmssink scanout of
real V4L2 frames, chromium/clapper hardware decode) on any revision.

[1] <20260926183051.25754-1-robin.clark@oss.qualcomm.com>



Jianfeng Liu (2):
  iommu: export iommu_get_dma_domain()
  drm/msm: map page-less imported sg_tables from their DMA addresses

 drivers/gpu/drm/msm/msm_gem_vma.c |  9 ++++
 drivers/gpu/drm/msm/msm_iommu.c   | 90 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h     | 13 +++++
 drivers/iommu/iommu.c             |  1 +
 4 files changed, 111 insertions(+), 2 deletions(-)

---
base-commit: d6882ed4e5b3970a13d721a07d2737c4831cdced
branch: msm-map-followup-v1

-- 
2.47.3

