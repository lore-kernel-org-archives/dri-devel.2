Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CFBC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C243510EBC7;
	Tue, 11 Aug 2026 13:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g1EYQVsg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A539C10EBC7;
 Tue, 11 Aug 2026 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=MdDSOxkknt+Lz03V4J+d5YfMUkb2czaqzWcEf7nkJIA=; b=g1EYQVsg2yMQfoZ3S97loEYmfd
 gPfuLdFeAeGerIdl2vqjnEM1KbH/sM9f/3cDHq2cbngIifEzgE9zGbP7K7i0/i+0eMDdsr9SPsNL/
 waad9VHK//nRLCk810sQswy5FkjFrH1Xlx3ijKiLD8TnTDIBRZ5Ceac9vjNvLv2lb653Th9GL47+D
 LZK6wZpYEqEDFHZufpRmJTPrsEINyK0VxIlgxlZBX8AW7b/m39sAH7vPgxga+iMScHpVCgHXEklBW
 N+554x26xQaiI+s8d7xEuJO9oYrH9bO/Bg2C2hSYwnnIk4+cyhK6FkENh8eZnQdRE6scKL+OmpRnz
 3Ee9f+SA==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpl-00H9mH-0Y; Tue, 11 Aug 2026 15:48:01 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 00/20] Revert switching default DRM scheduler policy to fair
Date: Tue, 11 Aug 2026 14:47:38 +0100
Message-ID: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

There was a late minute user reported regression report[1] so lets revert this
so it can be debugged in peace.

I have not been able to locally reproduce it yet, but at least a partial fix
looks to be this[2]. Further debug will be needed, possibly after the holiday/
vacation season is over.

[1] https://lore.kernel.org/dri-devel/TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me/
[2] https://lore.kernel.org/dri-devel/20260811134223.96203-1-tvrtko.ursulin@igalia.com/

Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>

Tvrtko Ursulin (20):
  Revert "drm/sched: Remove redundant entity->rq initialization and
    checks"
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
  Revert "drm/sched: Remove FIFO and RR and simplify to a single run
    queue"
  Revert "drm/sched: Switch default policy to fair"
  drm/sched: Mark fair policy as experimental

 drivers/accel/amdxdna/aie2_ctx.c              |   1 +
 drivers/accel/ethosu/ethosu_job.c             |   1 +
 drivers/accel/rocket/rocket_job.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  27 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |   4 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c       |   1 +
 drivers/gpu/drm/imagination/pvr_queue.c       |   1 +
 drivers/gpu/drm/lima/lima_sched.c             |   1 +
 drivers/gpu/drm/msm/msm_gem_vma.c             |   1 +
 drivers/gpu/drm/msm/msm_ringbuffer.c          |   1 +
 drivers/gpu/drm/nouveau/nouveau_sched.c       |   1 +
 drivers/gpu/drm/panfrost/panfrost_job.c       |   1 +
 drivers/gpu/drm/panthor/panthor_mmu.c         |   1 +
 drivers/gpu/drm/panthor/panthor_sched.c       |   1 +
 drivers/gpu/drm/scheduler/sched_entity.c      |  61 ++++++--
 drivers/gpu/drm/scheduler/sched_fence.c       |   2 +-
 drivers/gpu/drm/scheduler/sched_internal.h    |  15 +-
 drivers/gpu/drm/scheduler/sched_main.c        | 130 ++++++++++++++++--
 drivers/gpu/drm/scheduler/sched_rq.c          |  87 ++++++++----
 .../gpu/drm/scheduler/tests/mock_scheduler.c  |   1 +
 drivers/gpu/drm/v3d/v3d_sched.c               |   1 +
 drivers/gpu/drm/xe/xe_dep_scheduler.c         |   1 +
 drivers/gpu/drm/xe/xe_execlist.c              |   1 +
 drivers/gpu/drm/xe/xe_gpu_scheduler.c         |   1 +
 include/drm/gpu_scheduler.h                   |  42 +++++-
 30 files changed, 319 insertions(+), 94 deletions(-)

-- 
2.54.0

