Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D60CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD3A10EF55;
	Thu,  4 Jun 2026 20:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="c85+bNpt";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A8710EF55
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UbNMjWfINow3mVyXiGJKsCdu6qbrK2RjCvVmfk3zv3k=; b=c85+bNptTsHF3JCrrnJASwle2p
 zS1WlOj3G8D+ZhNfI0NHGPxPAFeJN+0ohY2GSpNpVgmgaFeoblGBDOBJX9zxV2EjpjLiU4QwsMFr2
 7SrOlzqw2KrgKQr7LdqepdTAnAmEiYZkUKSOofYMsxAsXAW5MnZHi5u+U3j/EeWrNTneMNbLbmIZL
 PnVx0xeoNJymIKUFQzZ4ss3hw61SWWu+F/ScKnGbn6Kr5VfVcB4ciYvpED+v3IT+EznyIVSzdkg8v
 v4mSgmU1Xg8f/KJ0+fHbHEsFBzzY0XMVYexApg/opgZ0VMGBmffG0SunQj/tpIctOL/lS4YCgL/H3
 inLthnjw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVEjo-00CoGD-AI; Thu, 04 Jun 2026 22:32:24 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v4 00/12] drm/v3d: Scheduler and submission fixes and
 refactoring
Date: Thu, 04 Jun 2026 17:32:13 -0300
Message-Id: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOwQrCMAwG4FcZPVtpm65TT76HeEi7uAXUySpFG
 Xt3uyEMUY9/wv8lg4jUM0WxKwbRU+LI3TUHuypEaPHakOQ6Z2GUccqqSiaoZQwt1fLCMcgTPyh
 KZ6CCrdIVlSBy9dbTvMjNwzHnluO965/zlaSn6RvU8BtMWirpMTjATSDvwp4bPDOuQ3cRk5jMo
 pRa/VFMVgJa9AgW6OS+FFgUp/79AlmpK62t91iWqD6UcRxf9a8cDEUBAAA=
X-Change-ID: 20260407-v3d-sched-misc-fixes-623739017e53
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6674; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=8/cuXDFk8Xss0c6U4rlbydY8/YVTRMh1hh6ZiBaFDtI=;
 b=kA0DAAoBP/MOinaI+qoByyZiAGoh4NOi+RaZ99cVLL2I1uRLsqxA/dE0b1lMYycQ0zC/KQv02
 IkBMwQAAQoAHRYhBPjkXX0BFncHKaZ30T/zDop2iPqqBQJqIeDTAAoJED/zDop2iPqqkTMIAMWB
 d+H225/irX3uoisoeVJXkzPFdB28i38LP3dantUxzdXS4v+jAWwr0WnI55JGIDEoEIYTeezB5cW
 UtaGYuBDvX3yXGMkjT281RQaUE34zHkQVs0+Y+v0CgONyr0No/YzLlRiEYOpfRC5zrdKWsghuL5
 K1MhKo/zvdhHkQkrdyQHhHbfNxsigWEyFfBP5FxdFj9IuqCKNb0KxPmNoWpgI+T5MZ+gBJy/+IF
 Aho94uMzK09H6qkBAiR0aS4tDHZqhc7vpWn+6pj6MUDEj1o1CJfjphpoW7upJZL0SFg8sD9BMlq
 vjcSwwS+qjBxQL+xsWpOCM9pnPKViw5j53cWX+I=
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

This series addresses several issues in the v3d scheduler and submission
code. Most of the fixes were motivated by feedback in the vc4 scheduler
series [1], which inherited issues from v3d. Based on the issues found
there, this series addresses the issues in the v3d driver as well.

This series has cleanup patches, fixes, and finally, a refactoring of
the submission code, which allowed us to fix the atomicity of a submission.

- Cleanups and small improvements:
  - PATCH 1/12: "drm/v3d: Drop unused drm_encoder.h include from v3d_drv.h"

- Fixes:
  - PATCH 2/12: "drm/v3d: Clear queue->active_job when v3d_fence_create() fails"
  - PATCH 3/12: "drm/v3d: Extract v3d_job_add_syncobjs() helper"
  - PATCH 4/12: "drm/v3d: Reject invalid syncobj handles in submit ioctls"
  - PATCH 11/12: "drm/v3d: Reject invalid out_sync handles in submit ioctls"

- Submission refactoring:
  - PATCH 5/12: "drm/v3d: Migrate BO reservation locking to DRM exec"
  - PATCH 6/12: "drm/v3d: Introduce struct v3d_submit and convert CL/TFU/CSD ioctls"
  - PATCH 7/12: "drm/v3d: Make v3d_get_cpu_indirect_csd_params() a pure parser"
  - PATCH 8/12: "drm/v3d: Convert submit helpers to operate on struct v3d_submit"
  - PATCH 9/12: "drm/v3d: Refactor CPU ioctl into unified submission chain"
  - PATCH 10/12: "drm/v3d: Split BO fence attach from syncobj output handling"
  - PATCH 12/12: "drm/v3d: Ensure atomic submissions in v3d_submit_jobs()" (Also a fix)

During the refactoring, I tried to break the conversion into small steps.
On the one hand, this helps reviewability; on the other hand, some things
may look unfinished at the end of a given commit. I tried to balance the
trade-off, but I'm happy to take split or squash requests during review.

[1] https://lore.kernel.org/dri-devel/20260205-vc4-drm-scheduler-v1-0-c6174fd7bbc1@igalia.com/T/

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com

- [2/14, 3/14, 5/14, 6/14] Add Tvrtko's R-b tag (Tvrtko Ursulin)
- [4/14] Use spin_lock() instead of spin_lock_irq() and change the commit message
         (Tvrtko Ursulin)
- [4/14] Use scoped_guard() instead of open-coding spin_(un)lock()
- [6/14] s/NULL/zero in the comments (Tvrtko Ursulin)
- [8/14] s/kcalloc(1, size, GFP_KERNEL)/kzalloc (Tvrtko Ursulin)
- [8/14] Save one atomic in v3d_attach_perfmon_to_jobs() by adding a conditional
         in the loop (Tvrtko Ursulin)
- [8/14] Zero is implied when initializing the struct v3d_submit (Tvrtko Ursulin)
- [8/14] Create v3d_submit_put_jobs() and v3d_submit_cleanup_jobs() (Tvrtko Ursulin)
- [9/14, 10/14, 11/14] NEW PATCHES: Trying to make the original patch
                       "[PATCH 09/10] drm/v3d: Refactor CPU ioctl into unified
                       submission chain" a bit easier to review.
- [10/14] Wrap drm_exec_fini() in a function v3d_submit_unlock_reservations()
          (Tvrtko Ursulin)
- [12/14] NEW PATCH: "drm/v3d: Split BO fence attach from syncobj output handling"
          - Split v3d_attach_fences_and_unlock_reservation() into different functions
            and fold parts of it into v3d_submit_jobs (Tvrtko Ursulin)
- [13/14] NEW PATCH: "drm/v3d: Reject invalid out_sync handles in submit ioctls"
          - Stop silently ignoring invalid syncobj handles (Tvrtko Ursulin)
- [14/14] Move the error path to a goto
- [14/14] Skip fence attachment and syncobj exportation to user-space if the
          submission has failed (Tvrtko Ursulin)

v2 -> v3: https://lore.kernel.org/r/20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com

- Rebased on top of drm-misc-next.
- [1/14] Add Iago's R-b tag (Iago Toral)
- [4/14, 7/14, 9/14] Add Tvrtko's R-b tag (Tvrtko Ursulin)
- [5/14] Create a job->queue variable to be used by v3d_job_add_syncobjs()
- [8/14] v3d_submit_add_job() returns struct v3d_job * instead of using
         void **container as argument (Tvrtko Ursulin)
- [10/14] Pull v3d_submit_lock_reservations() out of
          v3d_setup_csd_jobs_and_bos() (Tvrtko Ursulin)
- [11/14] Assert that jobs[1] is actually a CSD job (Tvrtko Ursulin)
- [11/14] v3d_submit_lock_reservations() is now called unconditionally
          in v3d_submit_cpu_ioctl() (Tvrtko Ursulin)
- [12/14, 13/14] Fold v3d_submit_process_post_deps() and v3d_submit_put_jobs()
                 into v3d_submit_jobs() (Tvrtko Ursulin)

v3 -> v4: https://lore.kernel.org/r/20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com

- Dropped "[PATCH v3 03/14] drm/v3d: Use inline lock for dma fence
  initialization" and "[PATCH v3 04/14] drm/v3d: Replace spin_lock_irqsave()
  with spin_lock()".
  - As pointed out by Sashiko, decoupling the DMA fence lock from the queue
    lock would break implicit synchronization, causing a UAF of `bin_job` in
    `v3d_overflow_mem_work()`.
  - I'll need to rework this in the future.
- [6/12, 8/12, 9/12, 10/12, 11/12] Add Tvrtko's R-b
- [2/12] Propagate the error pointer when v3d_fence_create() fails instead
         of treating the job as successfully completed (Sashiko)
- [6/12] Don't initialize the variables: render, clean_job and tfu_job
         (Tvrtko Ursulin)
- [11/12] Add an assert that sync_obj and multisync are mutually exclusive (Tvrtko Ursulin)
- [11/12] Document that multisync is prioritized over sync_obj (Tvrtko Ursulin)
- [12/12] Change the loop to for (i = 1; i < count; i++) (Tvrtko Ursulin)

---
Maíra Canal (12):
      drm/v3d: Drop unused drm_encoder.h include from v3d_drv.h
      drm/v3d: Clear queue->active_job when v3d_fence_create() fails
      drm/v3d: Extract v3d_job_add_syncobjs() helper
      drm/v3d: Reject invalid syncobj handles in submit ioctls
      drm/v3d: Migrate BO reservation locking to DRM exec
      drm/v3d: Introduce struct v3d_submit and convert CL/TFU/CSD ioctls
      drm/v3d: Make v3d_get_cpu_indirect_csd_params() a pure parser
      drm/v3d: Convert submit helpers to operate on struct v3d_submit
      drm/v3d: Refactor CPU ioctl into unified submission chain
      drm/v3d: Split BO fence attach from syncobj output handling
      drm/v3d: Reject invalid out_sync handles in submit ioctls
      drm/v3d: Ensure atomic submissions in v3d_submit_jobs()

 drivers/gpu/drm/v3d/Kconfig      |   1 +
 drivers/gpu/drm/v3d/v3d_drv.h    |  35 +-
 drivers/gpu/drm/v3d/v3d_sched.c  |  66 ++--
 drivers/gpu/drm/v3d/v3d_submit.c | 770 +++++++++++++++++++--------------------
 4 files changed, 445 insertions(+), 427 deletions(-)
---
base-commit: 86925ba9da20857b7d4525256a405fe789d4aa33
change-id: 20260407-v3d-sched-misc-fixes-623739017e53

