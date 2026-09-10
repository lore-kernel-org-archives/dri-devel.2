Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A2BC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 05:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1370E10E5C3;
	Thu, 10 Sep 2026 05:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N5NajTRI";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF5010E5C3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:45:59 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd78e6eso1014675a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789019159; x=1789623959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YkmKEwjSzJzm/ZcQfO9s4H31K3Ko5LXj6dOZ0ec6uns=;
 b=N5NajTRIvweJajMFSrqh6OVXj0H7rFmc+MnUoZAurAWISyS02nTWzQPhS5t4rkfsQg
 +kVsOhMlQXBLuWAvZURv960JZf3zpGxMvoiKLnlSw0s1IS0BqZcsbEE1ODOv1FdHdUMe
 6MhMoHYvX4qSgPe0f3jewgOWqbOop0XmnEu7ON8gfs7v4zLm5fcOOxLb7twCeyVNr/Mt
 ZI/DaqkVy3XNtC2N5bpF4rh0kiUCjTeEOu3U/uy2A6ayDg2y4HObn4ZuI1RvzRrUXuRl
 R2YZYnnbIlkqi1cdybbpXaKiy2NW/RB2HzR72YT26e+DY/azlj/NCL2qyMo/h54gH361
 T+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789019159; x=1789623959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YkmKEwjSzJzm/ZcQfO9s4H31K3Ko5LXj6dOZ0ec6uns=;
 b=Zbe7JsS/yoZo0C9RY8qY/upAPWUZaayR3JT7R3cpAX7Rqbjt2tPHnyu5Q6IGDjg8mC
 p8JdATAyN5F4o6j4AXBVl30a6dxMwVumpEBJDXCLCJ6Vtn3c4CzDXCf1BZHBqMDop9CS
 KGwPSItt2l/Xt780d440WN30GkmtVF4Zdbwz1VAMX3l8jAx5HCdKGpRLCRmDYCvDAp3n
 UZKjHhn6LlgGEnC0aDBR0tXtGxOBCCfp/b/tXl6rRIu1jJJKdIW6nMcVPG5xX0oDP9wq
 vAJ1XCraQRdTLO5SvnmSFs80fc6K5Jk2R40nXd0nfhwdyeKF1y0RkN+1iOqf07PDkvCS
 IgtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4p/uyLTtH+y/eNXIzgM2Klcn1XGBieAk7KnyVw5jmaT9fRn2lKoKe2ozf+wfRpKAMbemmtw6QFeM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m84ZYwowIrg1PZPAyA9XDqzhsSpqHmTzUz3OjP3IXW8P4trNVh
 roXd07j4GiBIxiCRvSXgz3vy+ca0EqeAih9Ko6R0BqC9HJSYXYid5hc=
X-Gm-Gg: AYBFou1wls09EFYnbVDUA6yg3D07RezvKzu3bTfP3J1uzCSfLQl+gEcWst3f775fcu1
 CZqsX7sb6BAZdpgmDKkObhpyJJgttsvr/P3Ze9mxddfTLL72lxSiKLUgr3Wuj64vS50MHqrQQ3Y
 pG2p6U5x/g7Xzl2NUmUbCzLxdvdHokcD+yuNDs9kv10006VWrUUE4YNSAXhb6AugqZsD6T/eUPf
 qs8+kRki3sbMsOh2IQ/5p/qZEXk7NGpso3ZyEf+ChJpffzw7b9VN7zfO8dGGF5sonhXa3aeJGxr
 02nkC3a8umIav6SvgkhPkOYxpmZGY4WIpB5gMpQz/aTVAlnF2n+7WEXALdD3ln2oaxfRhRLnmTj
 GWnbNPzrSglw+RAEfXuJivy82NurlU5FWLL2VIu4jybW+NVXmXFlT5g0nHUqZG456tcn/tWwdf7
 EXsfveXLvb2nTfRcs6mHT3ixWByS8ZwuqfzWTMFS8Fex64y8TlOPNPmvyYE9fgLCzvPdqhJxri5
 YUNuPOlnL+FxVQxftIptbSRKg==
X-Received: by 2002:a17:90a:fc47:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-39d7799fcc2mr2492773a91.3.1789019158573; 
 Wed, 09 Sep 2026 22:45:58 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7e77b1afsm2310421a91.5.2026.09.09.22.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 22:45:57 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, donggeunyoo.kernel@gmail.com
Subject: [PATCH] drm/amdgpu: don't release the fence reference consumed by the
 scheduler
Date: Thu, 10 Sep 2026 14:45:51 +0900
Message-ID: <20260910054551.634054-1-donggeunyoo.kernel@gmail.com>
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

drm_sched_job_add_dependency() consumes the fence reference in both the
success and the error case. The kernel-doc has said so since commit
ebd5f74255b9 ("drm/sched: Add dependency tracking") added the function,
and sched_main.c does the dma_fence_put() itself when its xa_alloc()
fails.

Three amdgpu callers take an extra reference for the callee and then put
it again when the callee returns an error, dropping a reference they no
longer own. The refcount ends up one short of the number of owners, so a
later put consumes someone else's reference and the fence is freed while
that owner still points at it.

In amdgpu_sync_push_to_job() the fence usually comes from
amdgpu_sync_resv(), which walks a BO's dma_resv and hands each fence to
amdgpu_sync_fence(), where the sync entry takes a reference of its own.
The fence stays installed in that dma_resv, so once the entry's reference
is gone amdgpu_sync_free() eats the reservation object's instead and the
fence is freed underneath a dma_resv that still lists it. The
use-after-free lands in an unrelated thread.

amdgpu_vm_sdma_update() is cross-thread by construction. It walks with
dma_resv_for_each_fence_unlocked(), whose cursor holds exactly one
reference, and the dma_resv_iter_end() on the same error path drops it a
second time.

amdgpu_cs_submit() stays local: the extra put takes the gang member's
scheduled fence to zero, handing the whole drm_sched_fence to call_rcu()
while its finished half is still live.

The extra get is correct at all three sites and stays. Only the put on
the error path is wrong.

Every other drm_sched_job_add_dependency() caller in the tree - etnaviv,
imagination, msm, nouveau, panthor, v3d, xe - hands the reference over
and returns the error untouched, as does
drm_sched_job_add_resv_dependencies() in the scheduler itself.

The trigger is xa_alloc() failing during command submission or a VM
update.

Measured on a Radeon 780M (GC 11.0.1) with a forced -ENOMEM return from
drm_sched_job_add_dependency(), printing the fence's reference count in
amdgpu_sync_push_to_job() on entry, after the failed call, and as the
error is returned:

  unpatched  entry=5 after_call=5 on_return=4
             entry=6 after_call=6 on_return=5
  patched    entry=5 after_call=5 on_return=5
             entry=6 after_call=6 on_return=6

after_call equals entry in both, which is the callee consuming the
reference the caller took for it. Unpatched, the dma_fence_put() that
follows takes it one below where it started, and that reference is the
sync entry's own; patched, there is no put left to make and the count
leaves the function as it arrived.

Fixes: 41cc108b2451 ("drm/amdgpu: fix missing dma_fence_put in error path")
Fixes: ed21f6c3fe42 ("drm/amdgpu: fix another missing fence reference in the CS code")
Fixes: c1c4a8b21721 ("drm/amdgpu: grab extra fence reference for drm_sched_job_add_dependency")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Resent: the original reached lkml but not dri-devel/amd-gfx - I was not
subscribed at the time. Apologies to those seeing it twice.

Tested on a Radeon 780M (GC 11.0.1) running 7.3-rc2 with KASAN, lockdep
and DEBUG_LIST on, driving compute submissions through radeonsi. The
-ENOMEM was forced by a temporary module parameter on gpu-sched that
makes drm_sched_job_add_dependency() fail after N calls, consuming the
fence on the way out exactly as the xa_alloc() failure does; the counts
above come from a probe printed in amdgpu_sync_push_to_job(), with the
unpatched and patched drivers run through the same harness. Neither
produced a KASAN report or a refcount warning: at the point of the extra
put the fence still had four or five other owners, so it is not freed
there. Observing the use-after-free itself needs the stolen reference to
be the last one, which this workload does not arrange.

Only the amdgpu_sync_push_to_job() site is reachable from a plain
compute workload. amdgpu_cs_submit() skips its loop body unless the
submission is a gang of more than one job, and amdgpu_vm_sdma_update()
was not reached; both are fixed here on the same reasoning.

No Cc: stable. I believe this qualifies under
Documentation/process/stable-kernel-rules.rst:19 - it is a use-after-free,
not the theoretical race condition line 27 excludes - but I have not
observed the failure itself, so I am leaving the tag off rather than
claiming more than I measured. No objection if you want to add it.

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c    | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 1 -
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 03b41f803520..12ec031c0812 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1303,10 +1303,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		fence = &p->jobs[i]->base.s_fence->scheduled;
 		dma_fence_get(fence);
 		r = drm_sched_job_add_dependency(&leader->base, fence);
-		if (r) {
-			dma_fence_put(fence);
+		if (r)
 			return r;
-		}
 	}
 
 	if (p->gang_size > 1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index d6ae9974c952..4f31021b2152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -447,10 +447,8 @@ int amdgpu_sync_push_to_job(struct amdgpu_sync *sync, struct amdgpu_job *job)
 
 		dma_fence_get(f);
 		r = drm_sched_job_add_dependency(&job->base, f);
-		if (r) {
-			dma_fence_put(f);
+		if (r)
 			return r;
-		}
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 50cc0779c340..c070c4a032eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -234,7 +234,6 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		dma_fence_get(fence);
 		r = drm_sched_job_add_dependency(&p->job->base, fence);
 		if (r) {
-			dma_fence_put(fence);
 			dma_resv_iter_end(&cursor);
 			return r;
 		}
-- 
2.53.0

