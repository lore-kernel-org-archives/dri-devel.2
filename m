Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35CD2ED08
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DFB310E198;
	Wed,  1 Apr 2026 13:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="c4vICUQ4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9628210E198
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775051346;
 bh=OHO+OKhsULLNuQdxo4AVizMofpb6KtmB13E5DX4BBWc=;
 h=From:To:Cc:Subject:Date:From;
 b=c4vICUQ4fgkS6oG6euj6OXaDO7b4Q+jQAd/dDiJqEaZljXrqoiu8NcFzLBsoChaZP
 sDJ/e8w49c5lAL1joqXBbOAK8b1+AtBGqhtzjYKpzsFp9L9Aj0U6iWra/gJV/MNK+T
 FugZS+zOvGQtd5o8Qmg634XeUOMTYOpwfDvx01o57c5vOVY3XVwePGo681MbNaLkYM
 81Ruq0ugjgxoDFLYVCJOo3KcklWBvoPSPjmKYShE2iJlFlGDRRqWQhxGVCQsmBBScn
 inPAeVy4dHj9j+ZKBG9zFE5RI+KLD2FSPmziyZbpFcZv4/devu9FZPAWu5c0wAq+HC
 WPzREkHpehd7Q==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:a2a7:f53:ebb0:945e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C526A17E74AB;
 Wed,  1 Apr 2026 15:49:05 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Chris Diamand <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Chia-I Wu <olvaffe@gmail.com>,
 kernel@collabora.com
Subject: [PATCH v7 00/10] drm/panthor: Add a GEM shrinker
Date: Wed,  1 Apr 2026 15:48:44 +0200
Message-ID: <20260401134854.2275433-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.53.0
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

Hello,

This is an attempt at adding a GEM shrinker to panthor so the system
can finally reclaim GPU memory.

This implementation is losely based on the MSM shrinker (which is why
I added the MSM maintainers in Cc), and it's relying on the drm_gpuvm
eviction/validation infrastructure.

I've only done very basic IGT-based [1] and chromium-based (opening
a lot of tabs on Aquarium until the system starts reclaiming+swapping
out GPU buffers) testing, but I'm posting this early so I can get
preliminary feedback on the implementation. If someone knows about
better tools/ways to test the shrinker, please let me know.

A few words about some design/implementation choices:
- No MADVISE support because I want to see if we can live with just
  transparent reclaim
- We considered basing this implementation on the generic shrinker work
  started by Dmitry [2], but
  1. with the activeness/idleness tracking happening at the VM
     granularity, having per-BO LRUs would caused a lot of
     list_move()s that are not really needed (the VM as a whole
     become active/idle, we can track individual BOs)
  2. Thomas Zimmermann recently suggested that we should have our
     own GEM implementation instead of trying to add this extra reclaim
     complexity to gem-shmem. There are some plans to create a
     gem-uma (Unified Memory Architecture) lib that would do more
     than gem-shmem but in a way that doesn't force all its users
     to pay the overhead (size overhead of the gem object, mostly)
     for features they don't use. Patch "Part ways with
     drm_gem_shmem_object" is showing what this component-based lib
     API could look like if it were to be extracted
- At the moment we only support swapout, but we could add an
  extra flag to specify when buffer content doesn't need to be
  preserved to avoid the swapout/swapin dance. First candidate for
  this DISCARD_ON_RECLAIM flag would probably be the tiler heap chunks.
- Reclaim uses _try_lock() all the way because of the various lock order
  inversions between the reclaim path and submission paths. That means
  we don't try very hard to reclaim hot GPU buffers, but the locking is
  such a mess that I don't really see a better option to be honest.


Changes in v2:
- No fundamental changes in this v2, since the feedback I got were more
  focused on bugs than the overall approach. Check the changelog in each
  patch for more details.

Changes in v3:
- Mostly fixes (see the changelog in each patch)

Changes in v4:
- Only fixes (see the changelog in each patch)

Changes in v5:
- Only fixes (see the changelog in each patch)

Changes in v6:
- Fix huge fault handling and various other things reported by Adrian
  and the review bot (see the changelog in each patch for more)

Changes in v7:
- Fix a deadlock reported by lockdep
- Add a commit to remove an unused field

Regards,

Boris

[1]https://gitlab.freedesktop.org/bbrezillon/igt-gpu-tools/-/commit/fc76934a5579767d2aabe787d40e38a17c3f4ea4
[2]https://lkml.org/lkml/2024/1/5/665

Akash Goel (1):
  drm/panthor: Add a GEM shrinker

Boris Brezillon (9):
  drm/gem: Consider GEM object reclaimable if shrinking fails
  drm/panthor: Remove unused panthor_vm_op_ctx::map::new_vma field
  drm/panthor: Move panthor_gems_debugfs_init() to panthor_gem.c
  drm/panthor: Group panthor_kernel_bo_xxx() helpers
  drm/panthor: Don't call drm_gpuvm_bo_extobj_add() if the object is
    private
  drm/panthor: Part ways with drm_gem_shmem_object
  drm/panthor: Lazily allocate pages on mmap()
  drm/panthor: Split panthor_vm_prepare_map_op_ctx() to prepare for
    reclaim
  drm/panthor: Track the number of mmap on a BO

 drivers/gpu/drm/drm_gem.c                |   10 +
 drivers/gpu/drm/panthor/Kconfig          |    1 -
 drivers/gpu/drm/panthor/panthor_device.c |   11 +-
 drivers/gpu/drm/panthor/panthor_device.h |   73 ++
 drivers/gpu/drm/panthor/panthor_drv.c    |   33 +-
 drivers/gpu/drm/panthor/panthor_fw.c     |   16 +-
 drivers/gpu/drm/panthor/panthor_gem.c    | 1453 ++++++++++++++++++----
 drivers/gpu/drm/panthor/panthor_gem.h    |  136 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    |  512 ++++++--
 drivers/gpu/drm/panthor/panthor_mmu.h    |    8 +
 drivers/gpu/drm/panthor/panthor_sched.c  |    9 +-
 11 files changed, 1923 insertions(+), 339 deletions(-)

-- 
2.53.0

