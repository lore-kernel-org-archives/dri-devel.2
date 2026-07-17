Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CCDC4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 03:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050DB10E2BD;
	Fri, 17 Jul 2026 03:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="IW2ulNpa";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 03:35:26 UTC
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 775C210E2BD;
 Fri, 17 Jul 2026 03:35:26 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 46879f80c;
 Fri, 17 Jul 2026 11:30:19 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kevinyang.wang@amd.com,
 kenneth.feng@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, runyu.xiao@seu.edu.cn
Subject: [RFC PATCH v2 0/5] drm/amdgpu: rework ring writeback pointer accesses
Date: Fri, 17 Jul 2026 11:30:04 +0800
Message-Id: <20260717033009.649538-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6e2001a103a1kunm4f30d137220ef
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQk5OVkpCGkxKGh1PTUsZGlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=IW2ulNpa91/ndxr7C1I7pp+JDaezYFZEspcOkDSrPY+e7XruNr+XbqEn4IKcUYL/LV/bg+QYQNqn1k/niV2FtBKMoI+FAzeJ35wdPBQVU7X4G/a7qbSeKnqr6l1jRVTsn/1FVzoxIu7GXTInTqHMZtJCDlUEL9AfB81108nSsp0=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=OZXD4eDo9A9IwMSfycM+NqNpkd5vPMmsvoqbG1+IRvA=;
 h=date:mime-version:subject:message-id:from;
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

Hi,

This RFC reworks AMDGPU ring writeback pointer accesses so that 32-bit
and 64-bit writeback slots are handled through typed helpers instead of
ad hoc casts and direct dereferences at the call sites.

The immediate motivation is the MES queue-init reset path. In
mes_v11_0_queue_init(), mes_v12_0_queue_init(), and
mes_v12_1_queue_init(), the reset/suspend path clears wptr_cpu_addr with
a plain 32-bit store even though the same slot is otherwise used as a
64-bit wptr carrier. That can clear only the low 32 bits and leave stale
high 32 bits behind.

However, that MES issue sits on top of a broader access-model problem in
the ring code. Current users still mix direct u32-typed dereferences,
plain u64 casts, READ_ONCE()/WRITE_ONCE() on casted pointers, and
atomic64_t casts for the same class of writeback slots. Review feedback
pointed out that the atomic64_t cast hack should go away, that
rptr_cpu_addr and wptr_cpu_addr should become typeless, and that the
related rptr read paths should be fixed in the same series.

This v2 follows that direction. It first adds typed helpers for 32-bit
and 64-bit ring writeback slots, then converts existing users to those
helpers, then makes rptr_cpu_addr and wptr_cpu_addr typeless in
struct amdgpu_ring, and finally fixes the MES queue-init reset paths on
top of that cleanup.

The helper conversion is intended to preserve the existing writeback
memory access semantics while making the intended slot width explicit at
each call site. The helpers do not add new synchronization semantics.

Patches 1-4 are preparatory cleanup only. The functional MES fix is in
patch 5.

Changes since v1:
- drop the atomic64_t-cast based MES-only fix
- rework the series around typed 32-bit / 64-bit writeback-slot helpers
- convert the related rptr read paths in the same series
- make rptr_cpu_addr and wptr_cpu_addr typeless after call-site cleanup
- keep the actual MES reset fix as the final patch on top of the cleanup
- fold the MES reset paths into one final functional patch
- include mes_v12_1 together with mes_v11_0 and mes_v12_0 on the current
  amd-staging-drm-next base
- clean up the split so the 32-bit conversion patch does not carry the
  gfx_v8_0 64-bit wptr reset conversion

Build testing:
- make O=/home/ubuntu22/kernel_lab/build-amdgfx-v2-rfc olddefconfig
- make O=/home/ubuntu22/kernel_lab/build-amdgfx-v2-rfc modules_prepare
- make O=/home/ubuntu22/kernel_lab/build-amdgfx-v2-rfc -j$(nproc)
  M=drivers/gpu/drm/amd/amdgpu
- make O=/home/ubuntu22/kernel_lab/build-amdgfx-v2-rfc -j$(nproc)
  KBUILD_MODPOST_WARN=1 M=drivers/gpu/drm/amd/amdgpu

The module build compiled the touched amdgpu objects and linked
amdgpu.o. Strict modpost failed because this standalone output directory
does not have a full-kernel Module.symvers, so I reran the same module
build with KBUILD_MODPOST_WARN=1; that completed and produced amdgpu.ko.

No AMDGPU hardware was available for runtime testing.

Runyu Xiao (5):
  drm/amdgpu: add typed helpers for ring writeback slots
  drm/amdgpu: convert 32-bit ring writeback accesses to helpers
  drm/amdgpu: convert 64-bit ring writeback accesses to helpers
  drm/amdgpu: make ring rptr_cpu_addr and wptr_cpu_addr typeless
  drm/amdgpu/mes: reset full 64-bit wptr in queue init

 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 26 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 18 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 18 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 18 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c   |  9 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 12 +++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 14 ++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  5 ++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 11 +++++-----
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 11 +++++-----
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   | 14 ++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 11 ++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 20 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 14 +++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 13 ++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 13 ++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 13 ++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 13 ++++++------
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 12 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  4 ++--
 48 files changed, 204 insertions(+), 211 deletions(-)

-- 
2.34.1
