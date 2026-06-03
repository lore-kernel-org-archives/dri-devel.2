Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE26ECD6E6B
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3BB112422;
	Wed,  3 Jun 2026 22:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SsPWKlsm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F897112422
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=10X+UgkPE/oBXp/khggiNvVQJ5EDv/fsn5wiNKEHW3c=; b=SsPWKlsmNMucDOL6G7aJV/c2wC
 +WYC/iCZ8zHXnT9g/sEhKZpG9C1whrC6YeB6z1jjyUsP1XApFdrZwYBn+peRICtw2cQBJfUB/2XaO
 P61wa83McwZf8tbi/FZF2wQ0HaxeOaGSd/T6Zltjxnc1Tp5ZN/BWk5tfjfLFtb1OuGxnf6ufbE1lf
 AYgpZcJHKkQI7ycTShHa78AvEW34zMbKSPE3cZCE0Y05GF8M7tIpGxrJDYbn6/fqpq6qxFGEgzj7x
 HBbuCmTmt9T4iPI32MmD1DWYfNo0HeU3M/k9JNNs2fNY6KiBCQanUrCQ0voGkyWEpNy50NIRDzyoI
 WUKeGH4w==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUu1T-00CNgx-0I; Thu, 04 Jun 2026 00:25:15 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 00/14] drm/v3d: Scheduler and submission fixes and
 refactoring
Date: Wed, 03 Jun 2026 19:25:02 -0300
Message-Id: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQrCMBAF0KuUrB1JMm2qrryHuJim03bAWmkkK
 KV3Ny2CCLr8f/hvJhV4FA7qkE1q5ChBhmsKuMmU7+jaMkidsrLaOp3rEiLWEHzHNfQSPDTy4AD
 OYol7bUouUKXpbeT1kJanc8qdhPswPtcv0SztGzT4G4wGNFTkHdLOc+X8UVq6CG390KtFjPajF
 Eb/UWxSPOVUEebIjftS5nl+AfYpDwv/AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5989; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=vzydWD36ZsUPWAwqie9TyvjZkECG8E4+3z3onuGgNZQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIKnFNuxHAV5PGmZ8tOsmvopTHJ9Hia9nd6tZP
 TaIKKJ0yRWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiCpxQAKCRA/8w6Kdoj6
 qrCvB/4pU93nQo1yE2EZi0/Q1OIYVfsY2JEBFDrnz0LyLanAsdjX9WfPrrvELUI/ckaitUVhd7I
 EmjZUhKsVJxo8rWUiOSPow9mpYbtwpFNg/VEpeoXgr0gkwTxAJUA+iEZ+1nE3QfWDc+eiy90cmJ
 zE2QM020vbuYMVwV4K/XFYm0bY/6AYj69B75P/ODtcLx1PhoM6DYuy4xn8XE6c75FmH95PPIW8p
 0MscOaJV+wG+vMSW7eau+aL/dP2yLS7t8ZQaDViJH3EHt0vhejJOpmyLI6rNp9ZWCiFA5YnmcJR
 MnZEVSeL3uHfvW4dcXZgVuidlOzhG9iPTyDMmVPQqYEwVcBk
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
  - PATCH 1/14: "drm/v3d: Drop unused drm_encoder.h include from v3d_drv.h"
  - PATCH 3/14: "drm/v3d: Use inline lock for dma fence initialization"
  - PATCH 4/14: "drm/v3d: Replace spin_lock_irqsave() with spin_lock()"

- Fixes:
  - PATCH 2/14: "drm/v3d: Clear queue->active_job when v3d_fence_create() fails"
  - PATCH 5/14: "drm/v3d: Extract v3d_job_add_syncobjs() helper"
  - PATCH 6/14: "drm/v3d: Reject invalid syncobj handles in submit ioctls"
  - PATCH 13/14: "drm/v3d: Reject invalid out_sync handles in submit ioctls"

- Submission refactoring:
  - PATCH 7/14: "drm/v3d: Migrate BO reservation locking to DRM exec"
  - PATCH 8/14: "drm/v3d: Introduce struct v3d_submit and convert CL/TFU/CSD ioctls"
  - PATCH 9/14: "drm/v3d: Make v3d_get_cpu_indirect_csd_params() a pure parser"
  - PATCH 10/14: "drm/v3d: Convert submit helpers to operate on struct v3d_submit"
  - PATCH 11/14: "drm/v3d: Refactor CPU ioctl into unified submission chain"
  - PATCH 12/14: "drm/v3d: Split BO fence attach from syncobj output handling"
  - PATCH 14/14: "drm/v3d: Ensure atomic submissions in v3d_submit_jobs()" (Also a fix)

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

---
Maíra Canal (14):
      drm/v3d: Drop unused drm_encoder.h include from v3d_drv.h
      drm/v3d: Clear queue->active_job when v3d_fence_create() fails
      drm/v3d: Use inline lock for dma fence initialization
      drm/v3d: Replace spin_lock_irqsave() with spin_lock()
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
 drivers/gpu/drm/v3d/v3d_fence.c  |   2 +-
 drivers/gpu/drm/v3d/v3d_irq.c    |  17 +-
 drivers/gpu/drm/v3d/v3d_sched.c  |  73 ++--
 drivers/gpu/drm/v3d/v3d_submit.c | 758 +++++++++++++++++++--------------------
 6 files changed, 447 insertions(+), 439 deletions(-)
---
base-commit: 6e7eb171ac96fefa32197afa658e7d9da238be89
change-id: 20260407-v3d-sched-misc-fixes-623739017e53

