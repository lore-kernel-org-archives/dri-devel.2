Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876F1C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFE410F396;
	Thu, 13 Aug 2026 15:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FWPCZRqg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8680A10F396;
 Thu, 13 Aug 2026 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786634196; x=1818170196;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=g7347jQkxNuoDRf12u9GqL+4ls5r3X2gKhlW/m3Jw2s=;
 b=FWPCZRqgdPb4Dcf9OaWj/D9HcrcTH9WJDHtwKMaNjrikGPgocNq4ocVQ
 /yQAvWVjlNIC7eTI1pXUrxF+B9TlfLoAruzFMPn32JEM9yYvvM/OBVhhY
 tZnwSN5R99j5Vfj+d6yVvWM7MwCRrt/ONN1gGxilXPoKLAMYROG6yAu3H
 /6ajuVOSYU1esld09jblJyud2W1unkmB1gbpOiRGGanDOPE/eqagAV8Hp
 YV8vp3NsLhPbmT6p480u+S2eFbvGgK4I43QNjyiru87ItqlpK0eIFqFNl
 bjx4ceCGspYfBFxkmgAlCpz/aQxf04VkbILXSz2PKh9/QGisjFoFDdNg6 g==;
X-CSE-ConnectionGUID: 69dVO5mfTQ2OHRmYn0flWQ==
X-CSE-MsgGUID: W/WgHNv4Tj63h0mBZdM2ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87134349"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87134349"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:16:35 -0700
X-CSE-ConnectionGUID: rZZU6/quRKWvLing9hWwqQ==
X-CSE-MsgGUID: 2ia+Rg46ScSLCk98fEK9Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="267475800"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.244.28])
 ([10.245.244.28])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:16:32 -0700
Message-ID: <a9b38792-bdd0-42da-a46a-7a048c26c0c2@linux.intel.com>
Date: Thu, 13 Aug 2026 17:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: dim-tools@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PULL] drm-misc-fixes
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Dave, Sima,

A few fixes and a bunch of reverts due to performance regressions with the gpu scheduler fair policy.

Kind regards,
~Maarten Lankhorst

drm-misc-fixes-2026-08-13:
drm-misc-fixes for v7.3:
- Revert fair scheduler patches and mark fair policy as experimental due
  to reported regressions.
- Fix OOB read in connector/hdmi infoframe.
- Handle invalid scaling parameters and empty messages in log target.
- Skip attempting to populate unmapped pages in amdxdna.
The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-08-13

for you to fetch changes up to f4f2bba28df9b9aaa00262a462139dbbcdc38d9f:

  drm/log: Fix infinite loop when scale is too large for display (2026-08-13 15:49:40 +0200)

----------------------------------------------------------------
drm-misc-fixes for v7.3:
- Revert fair scheduler patches and mark fair policy as experimental due
  to reported regressions.
- Fix OOB read in connector/hdmi infoframe.
- Handle invalid scaling parameters and empty messages in log target.
- Skip attempting to populate unmapped pages in amdxdna.

----------------------------------------------------------------
John Harrison (1):
      drm/connector/hdmi: Fix out of bounds memory read

Lizhi Hou (1):
      accel/amdxdna: Skip unmapped range in aie2_populate_range()

Maarten Lankhorst (1):
      Merge remote-tracking branch 'drm/drm-fixes' into drm-misc-fixes

Shixiong Ou (3):
      drm/log: Fix division by zero when scale module parameter is 0
      drm/log: Fix out-of-bounds read on empty message length
      drm/log: Fix infinite loop when scale is too large for display

Tvrtko Ursulin (19):
      Revert "drm/sched: Remove drm_sched_init_args->num_rqs"
      Revert "drm/xe: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/v3d: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/sched: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/panthor: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/panfrost: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/nouveau: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/msm: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/lima: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/imagination: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/etnaviv: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/amdgpu: Remove drm_sched_init_args->num_rqs usage"
      Revert "accel/ethosu: Remove drm_sched_init_args->num_rqs usage"
      Revert "accel/rocket: Remove drm_sched_init_args->num_rqs usage"
      Revert "accel/amdxdna: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/sched: Embed run queue singleton into the scheduler"
      Revert "drm/sched: Remove FIFO and RR and simplify to a single run queue"
      Revert "drm/sched: Switch default policy to fair"
      drm/sched: Mark fair policy as experimental

 drivers/accel/amdxdna/aie2_ctx.c                 |  17 ++++
 drivers/accel/ethosu/ethosu_job.c                |   1 +
 drivers/accel/rocket/rocket_job.c                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          |  27 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h        |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c          |   8 +-
 drivers/gpu/drm/clients/drm_log.c                |  12 +++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c  |   3 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c          |   1 +
 drivers/gpu/drm/imagination/pvr_queue.c          |   1 +
 drivers/gpu/drm/lima/lima_sched.c                |   1 +
 drivers/gpu/drm/msm/msm_gem_vma.c                |   1 +
 drivers/gpu/drm/msm/msm_ringbuffer.c             |   1 +
 drivers/gpu/drm/nouveau/nouveau_sched.c          |   1 +
 drivers/gpu/drm/panfrost/panfrost_job.c          |   1 +
 drivers/gpu/drm/panthor/panthor_mmu.c            |   1 +
 drivers/gpu/drm/panthor/panthor_sched.c          |   1 +
 drivers/gpu/drm/scheduler/sched_entity.c         |  52 +++++++---
 drivers/gpu/drm/scheduler/sched_fence.c          |   2 +-
 drivers/gpu/drm/scheduler/sched_internal.h       |  15 ++-
 drivers/gpu/drm/scheduler/sched_main.c           | 121 ++++++++++++++++++++---
 drivers/gpu/drm/scheduler/sched_rq.c             |  89 ++++++++++++-----
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c |   1 +
 drivers/gpu/drm/v3d/v3d_sched.c                  |   1 +
 drivers/gpu/drm/xe/xe_dep_scheduler.c            |   1 +
 drivers/gpu/drm/xe/xe_execlist.c                 |   1 +
 drivers/gpu/drm/xe/xe_gpu_scheduler.c            |   1 +
 include/drm/gpu_scheduler.h                      |  42 +++++++-
 32 files changed, 335 insertions(+), 97 deletions(-)
