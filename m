Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EA4F34C5E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39AF310E4B3;
	Mon, 13 Apr 2026 15:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="RWt5p5zf";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF5510E4B3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aYtBkHNLit+Qxzmee9VQ1dGH8Q9cWLWRcqlawUEZ2QU=; b=RWt5p5zfuygSrTWqgmpwswFJoB
 pClDkFcvT7eq1QOc3o6WA4Lzzxv93D4q8Mh9awvlsVQtvCx2wRt+h6IXM6EU4B3GEpuX1m5F3eCrw
 shARPPkIBDZMPX2aD17zrVA+kgGV6XDcRBpLUCwcYOy7kdOBEqCdvnHT5zoYjX3ft6iVTz6OSoBL+
 HfNyRXe1JpDkWb/9szsxJaGi5v4FuIGB1wzFX9vRfZVcclwjg2mj9NBojnxjr8AhlRxEqxCxy3gHb
 mU1KnECnv0RycGndxvJ+Rdj0JOXI8lWBvA2bIRbiEiZ+xwYc88dcPcK8UzSWe3SWXgzr+X1KDe7r8
 gzYFTIXw==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCIqo-00FSq1-Kz; Mon, 13 Apr 2026 17:05:22 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 00/10] drm/v3d: Scheduler and submission fixes and refactoring
Date: Mon, 13 Apr 2026 12:03:15 -0300
Message-Id: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LTQqAIBBA4avIrBswraSuEi1Cp5pFPzgggXj3p
 OXH42UQikwCk8oQKbHwfVW0jQJ/rNdOyKEajDaD7rTDZAOKPyjgyeJx45cEB2OdHXXrqLdQ1yf
 SH+o5L6V8GKhFYWYAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2559; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=1WtR1vHRBRyRNF5WZk7JOiOcv/SsyCyH5Z98vFn1DHU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBp3QYtb/i5D6SILGkn+BZ01Dygk2hq1tOThRq59
 pIEcvKvr36JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCad0GLQAKCRA/8w6Kdoj6
 qlETB/4wzcUnio0oEeW7oTXZ5BsESw2T3KuDUSStFT7zT62simga0HYmPhqcmzTWJgzPp8LBdd3
 d9vTEXufCyqFb7LDlypShoJsZlcSsGK4h6fNeC9E7LkOPywJyuj/89gMmAlFSWjY0hwNmgnL9xp
 Gq83AEr4LqgeqyBg80h0IwoITcHskIoqTRJ6e0KCoqmKTHw1kEVhDmuN1h/eRHL3EnDFbms8gWg
 4Y+uzwPV/m5CR41Fm85jT9sgwl3Tpcx95LHjccHivhPp45BVi/ZHacH9Oytq+4Yyeh6zARlZbCU
 rYUs766Lq7+VAOuuY0el5pIU/Sy3Avz4lMREZsiivzu8mg8q
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
the submission code, which allowed us to fix the atomicity of a
submission.

- Cleanups and small improvements:
  - PATCH 1/10: "drm/v3d: Drop unused drm_encoder.h include from v3d_drv.h"
  - PATCH 3/10: "drm/v3d: Use inline lock for dma fence initialization"
  - PATCH 4/10: "drm/v3d: Replace spin_lock_irqsave() with spin_lock_irq()"

- Fixes:
  - PATCH 2/10: "drm/v3d: Clear queue->active_job when v3d_fence_create() fails"
  - PATCH 5/10: "drm/v3d: Extract v3d_job_add_syncobjs() helper"
  - PATCH 6/10: "drm/v3d: Reject invalid syncobj handles in submit ioctls"

- Submission refactoring:
  - PATCH 7/10: "drm/v3d: Migrate BO reservation locking to DRM exec"
  - PATCH 8/10: "drm/v3d: Introduce struct v3d_submit and convert CL/TFU/CSD ioctls"
  - PATCH 9/10: "drm/v3d: Refactor CPU ioctl into unified submission chain"
  - PATCH 10/10: "drm/v3d: Ensure atomic submissions in v3d_submit_jobs()" (Also a fix)

[1] https://lore.kernel.org/dri-devel/20260205-vc4-drm-scheduler-v1-0-c6174fd7bbc1@igalia.com/T/

Best regards,
- Maíra

---
Maíra Canal (10):
      drm/v3d: Drop unused drm_encoder.h include from v3d_drv.h
      drm/v3d: Clear queue->active_job when v3d_fence_create() fails
      drm/v3d: Use inline lock for dma fence initialization
      drm/v3d: Replace spin_lock_irqsave() with spin_lock_irq()
      drm/v3d: Extract v3d_job_add_syncobjs() helper
      drm/v3d: Reject invalid syncobj handles in submit ioctls
      drm/v3d: Migrate BO reservation locking to DRM exec
      drm/v3d: Introduce struct v3d_submit and convert CL/TFU/CSD ioctls
      drm/v3d: Refactor CPU ioctl into unified submission chain
      drm/v3d: Ensure atomic submissions in v3d_submit_jobs()

 drivers/gpu/drm/v3d/Kconfig      |   1 +
 drivers/gpu/drm/v3d/v3d_drv.h    |  32 +-
 drivers/gpu/drm/v3d/v3d_fence.c  |   2 +-
 drivers/gpu/drm/v3d/v3d_irq.c    |   7 +-
 drivers/gpu/drm/v3d/v3d_sched.c  |  63 ++--
 drivers/gpu/drm/v3d/v3d_submit.c | 674 +++++++++++++++++----------------------
 6 files changed, 369 insertions(+), 410 deletions(-)
---
base-commit: ac6cba38729f63b2b9c947a973e3a45ba8ec448a
change-id: 20260407-v3d-sched-misc-fixes-623739017e53

