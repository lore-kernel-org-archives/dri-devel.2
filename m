Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DD5CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFE610E42E;
	Sun, 10 May 2026 22:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gKIYiWxC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F5410E428
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AIPh4nq12W2NworF5UAtcbMuJS9eLdTFmy0cIhTkdnY=; b=gKIYiWxCTntG8yI58H6KkNsznU
 yWJ4WZ5SO1OvijnggOIM5cothYf2uA8ktjK862hxMwQDOza0trhhJ2dTOO6zP+0jXm9lstu4g7wOF
 1gi4mk+EXjU/Iq1rftt2tzvAmnQAxW6CuYoMFdZX5b8OySkseYzKJ91yR1+ZfNo7CVxRgrKaRf1D9
 ZmN5NxxTh2TCdUKhhKD9RCRqQgNShJkAWcZq8KTKsheCKeNduyuEOUwfIQx59WbzBAjEFU85jZxyG
 UKMr3ZQz68KNeVXZG5BtVgz+kCvsdZ/ZRCeyh0pBs1dVSykkR+4/GxntqvFSe/O5SkfGVjoURM8VX
 b6J+KxXg==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCNe-008k1J-70; Mon, 11 May 2026 00:12:09 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 00/14] drm/v3d: Scheduler and submission fixes and
 refactoring
Date: Sun, 10 May 2026 19:11:57 -0300
Message-Id: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NSw7CMAxEr1J5jVE+kAIr7oG6SF3TWqIUxSgCV
 b07oWLJ8s3ozcygnIQVTtUMibOoTPcCblMBDfHeM0pXGJxxwexMjdl3qDRwh6Mo4VVerBicr/3
 R2Jr3Hor6SLwWxbw0hQfR55Te60u23/Q3aP3/wWzRYBsp+HggbgOdpY83iVuaRmiWZfkAbrk1D
 7kAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5005; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Dhm9ia66dyqLQIMUsnS34AzlIUkgkIrjjehvXyg2Wq0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQKzX8JSfAvgK4sH44YSVZIjlIrnrobqwI7nV
 v55ZFMIUpyJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECswAKCRA/8w6Kdoj6
 qnVsB/433qIbi+MIH8XQA3YBQ1I2TFT6025FFWtbn921YBayqHnpBbJ8imk8fl/Tc5Cx8FzEnhA
 UNTW14YIAgQQZHADFusVv/s214pBnLKb2hpbIGev1ylsRld15l7MH2aqwN2dIZnlsn7KCsiilo8
 uJJIi9tdr9BqdhF1pjgwlY+tEqgcJvgPhKX+PTWs48aZ0oPgj17CyxODyYC6jnh00ieNfXCOhxx
 RC0hZgLJNOLmJCj2zqGgL5mUUWmF6qxJXSyZy8kOaP2oeWBBuvCQ+XZid2lrFGcIpcy0xILh65p
 6qK++mrK8sRa7vhRxRVAabZVdmf6ugmjcFhkohB17B7EvhXH
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
  "[PATCH 09/10] drm/v3d: Refactor CPU ioctl into unified submission chain"
  a bit easier to review.
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
 drivers/gpu/drm/v3d/v3d_drv.h    |  32 +-
 drivers/gpu/drm/v3d/v3d_fence.c  |   2 +-
 drivers/gpu/drm/v3d/v3d_irq.c    |  17 +-
 drivers/gpu/drm/v3d/v3d_sched.c  |  73 ++--
 drivers/gpu/drm/v3d/v3d_submit.c | 736 +++++++++++++++++++--------------------
 6 files changed, 435 insertions(+), 426 deletions(-)
---
base-commit: 19d584a634fe999786acfb0ac5289710cc84a5f6
change-id: 20260407-v3d-sched-misc-fixes-623739017e53

