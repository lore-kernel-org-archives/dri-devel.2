Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC25C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3466410E411;
	Sat,  5 Sep 2026 15:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y1qjo+Zf";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABB110E54F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:06:24 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d6f9e2f681so8340975ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788509184; x=1789113984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AvzKUaxKqDduKUy6EaV8rSY/p2Qwfvb5qYVmt7Thsg8=;
 b=Y1qjo+ZfxyohJ2ave+wlqbw0iqewjFqzV7ndrUC6+Y0kQ0TeTh1CaQlXrRCAdoC6Yl
 QNZkHJsGJSmr2C60SxlSPKuZhzrC6R0/eHq2nIgu0LFljSLRSY0Po/jQMDNBOHWVCLcQ
 XumJIqWvqmVegPYcgFJY7xyiRXts7/G1XyHUT7gtjso/wmROX0YUnPwq5HegOHYLu315
 Hqs/JHH6frnDzQbmlGaDR5NsZsIB6n3VlwSpL3Gb6J9zCu3Y8onbl3ViFTvQFgtQEjGW
 CE8mMhv/wcN7iOb3AJ0PFsEvBel3f8WAqUHIRYDNrZ1D2ErFneUShNFlCwhsUWFQBUJy
 sVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788509184; x=1789113984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AvzKUaxKqDduKUy6EaV8rSY/p2Qwfvb5qYVmt7Thsg8=;
 b=SCqHKaseIl8VyfLYHvvWpSsbiZ4WPdAoDOpfBos64dfx1Rm6LD7CVerSu6860ax8Tx
 55pn19II/ibs5UG4tAVMGyLnZ/X40wcgz3/ha+2i/eG/B5cjYivIDTZUHv+2tgaRptpd
 py0khfA53nsYn51LuLEnrFwVW8hik+vfaLg/8hjvITBjqAgTlvZi3ZpZaDwJ1f9nVjpc
 9RSziMN25vM/XM9Rl/C/TqoiuoBMJQ96eaJMfhjLc23H5mDqq5uRo/Gf7MMUEWpBKTBb
 qQDfUZPqI76F/mTI27KgzDZ/n31rXg1sq33NXz8zWn+ZnQv0snEhjIwvmG5ypj8oPlsE
 EM9Q==
X-Gm-Message-State: AFuF++nbn1tYO8BaIWVf6ySPi1PQa3gzLaxQeGhCL7m0aUlxrdXDspWq
 c6XLjibX2a2+BHUhm6wZ/mdCu/b+42oX/e9aHJpXy3zo8UZO6O5c1Lg=
X-Gm-Gg: AYBFou331sKM10ZmAChm/1zG2y5VWdK6B2VYNd4sN6T9Cv4nlo3oB/16tGDQAYquQ+r
 /p9uevYdFsnnvvG0xBH3IByAu0c3xULxa8b0APjYuMYrpsdY30+Xdm5Kx1G63K1Tb2YXv1oLCMW
 11fBhNQGtesxD4v7nbAVmtRoWekaJjo7wjObZilNNCfFFTBpkGiaiI+1Hu5K7nQL225FnKAgLIP
 aGkIy2vQI0hFYlEu8/AQYICVf2pwrzEf7DCqikaASxNUDtijA/JTeQCSmgUpbgZLkf0u9l2MbwE
 Ffv34RxvEQ0gkmXe8WKAV5eVt7rR7L22AaWD+AKGxBvQ4+U5vn993ghjNiStC5ICfuLI90UOPTL
 jAQogjoXRcK5+xoIWve8qnstBD0T7c4tojX+GG1wnvgzYrG7MGg/CbB+ySFaI40A1YHNPjpp3qp
 F2dslUeJAP+Xlvd5QFJ2CCJYJ1r0L91c2Dox2lbEzRTQRNUC9lot9j/xZ/KsG9MR3BuVYY0d2R9
 ic9smokrhL7C+I9kF7menX+Ru4=
X-Received: by 2002:a17:90b:2f87:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-39b260fe42amr7289642a91.5.1788509183617; 
 Fri, 04 Sep 2026 01:06:23 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b261549f3sm3181153a91.16.2026.09.04.01.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:06:22 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: phasta@kernel.org, christian.koenig@amd.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
Subject: [PATCH v4 0/3] drm/sched: fix use-after-free of the fence timeline
 name
Date: Fri,  4 Sep 2026 17:06:15 +0900
Message-ID: <20260904080618.2098450-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

drm_sched_fence_get_timeline_name() dereferences fence->sched->name. A driver
that allocates a drm_gpu_scheduler per context, queue or VM frees that scheduler
on context teardown, but the finished fence can outlive it: unprivileged
userspace holds the exported fence via a sync_file or drm_syncobj and later
queries its timeline name (e.g. SYNC_IOC_FILE_INFO), reading the freed
scheduler. Same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
(drm/panthor); amdxdna, nouveau and msm (VM_BIND) are still affected in
mainline, so this fixes it in the core.

v3 tried to drop the finished fence's ->release so that dma_fence detaches the
ops on signalling. That turned out not to be viable:

 - amdgpu dereferences to_drm_sched_fence() unconditionally
   (amdgpu_cs_p2_dependencies(), amdgpu_ctx_fence_time()), and ops-detach makes
   the helper return NULL for a signalled fence - a deterministic NULL deref
   reachable by an unprivileged process;
 - drm/imagination uses the ops pointer as an identity test in
   pvr_queue_fence_is_native(), which Philipp showed would then race; and
 - Christian pointed out that the reference must go from the finished to the
   scheduled fence, not the other way around, so v3's refcount rework was wrong.

So v4 goes back to the minimal caching fix: get_timeline_name() returns a name
cached at fence init and never dereferences ->sched. Both .release callbacks,
the shared allocation, the call_rcu() free and to_drm_sched_fence() all stay
exactly as they are today, so there is no amdgpu/pvr regression and nothing new
for the backend to reason about.

Detaching the ops is still the better fix in the long run - it is what the
dma-fence rules ask for, and it would also cover get_driver_name(), which can
return a string literal from a module that has since been unloaded. Patch 2
records that as a TODO entry (and a comment next to the fence ops) with the
three blockers that have to be solved first, so the cleanup is not lost.

There is no unrelated formatting churn in this version; the kerneldoc reflow
that was mixed into v3 is gone.

Tested with KUnit under KASAN and kmemleak (kunit.py --arch=x86_64), matched
pair:

  - unfixed (get_timeline_name() dereferencing ->sched):
      [FAILED] drm_sched_dma_fence_uaf
      BUG: KASAN: slab-use-after-free in
          drm_sched_fence_get_timeline_name+0x9c/0xb0
  - fixed (this series):
      [PASSED] drm_sched_dma_fence_uaf
      Testing complete. Ran 43 tests: passed: 43

No kmemleak reports, and the whole drm_sched suite passes with no regressions.

Link to v3 (ops-detach):
https://lore.kernel.org/lkml/20260902144204.1843670-1-malhyuk97@gmail.com/
Link to v2 (caching):
https://lore.kernel.org/lkml/20260902105808.1541063-1-malhyuk97@gmail.com/

v4:
 - Drop the ops-detach/refcount rework; return to caching the timeline name
   (per the amdgpu/pvr regression above and Christian's reference-direction
   point).
 - Add a TODO comment and a Documentation/gpu/todo.rst entry for the
   ops-detach cleanup (per Philipp).
 - Keep Cc: stable with "we don't know since when" (per Philipp).
 - No formatting-only hunks in the fix patch.
 - Test suite renamed to drm_sched_dma_fence_uaf_tests for consistency with the
   sibling suites; re-verified under kmemleak as well as KASAN.

Jonghyuk Kim(MalHyuk) (3):
  drm/sched: cache the timeline name to fix a use-after-free
  drm/sched: add the fence ops-detach cleanup to the TODO list
  drm/sched/tests: add a UAF regression test for the timeline name

 Documentation/gpu/todo.rst                    | 39 ++++++++
 drivers/gpu/drm/scheduler/sched_fence.c       | 24 ++++-
 drivers/gpu/drm/scheduler/tests/Makefile      |  1 +
 .../drm/scheduler/tests/tests_integration.c   | 88 +++++++++++++++++++
 include/drm/gpu_scheduler.h                   | 18 +++-
 5 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/scheduler/tests/tests_integration.c

-- 
2.43.0

