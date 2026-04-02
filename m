Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27777D6AAEC
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 18:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8274210F298;
	Thu,  2 Apr 2026 18:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="obb4PxBU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7141C10F28D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=THlaSA5OmYOZEw7LkxE/2XGE1ySfYk56ZsQnrhlg4/w=; b=obb4PxBUhTBsEbXNZKOEmnF+k9
 TtkQmr7rDxwAJuaucmN7yaZODelwX2cV0CGA8tJdFWr3brlrdO1FmNlCI9ZsAGynTGjYt/HfLp1jW
 Jzs82Few7mtGlQQaWVCJnD/q7JTQAXOQGBZAPSGSoBRt+AZ+RaTBPfAEnhm0SSzq3PQTk0/kYXhyh
 O88gK7yUjAFbkeTPxgxLNdBm6uMp//SKNRISoSd38vG2AtK7nKnZTgD1H/ANtYJv2bHlmxMWi6vpP
 HaBIVUlsH8lJlWmUdEL7IOO4quia9GLROOmLUsHC4VRFHnOQA5a2+UTlLV4rnAe1rMTr2KOKmOJvW
 dcj7qZgQ==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w8Mto-00AaZZ-U2; Thu, 02 Apr 2026 20:36:13 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/7] drm/vc4: Switch to DRM GPU scheduler
Date: Thu, 02 Apr 2026 15:36:00 -0300
Message-Id: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4XM2jFtwWJc+R+GBUwHmISHabXRk
 P67Fbcuz0nuuRsE9sIBLsUGnqMEWZcM5lAAje0yMIrLDEYZq7TRGKlC52cMNLJ7TuxRleTOtlZ
 d2VvIu7vnXl5789ZkHiU8Vv/eL6L+2l/NqNOfWtSokKyuq97VXUf6KkM7SXukdYYmpfQBMxbXv
 7MAAAA=
X-Change-ID: 20260121-vc4-drm-scheduler-03cd8670b3f6
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5664; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=9uUip30M9q0ZK9RHkj5fW+dO6g104OeTpfc9f0MOqZI=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDJnntovIaRw48/bZ7/uhkxMiWXS98gtOFYd71vI/LjX7Z
 dFxfVJrJ6MxCwMjF4OsmCLLjyextYxi5eyay8ovwgxiZQKZwsDFKQAT4drB/j88cHlmer5caH8u
 s0bFDnf2hccjd05cxeW2qEN0rZWETVta2Z1pE8rDA5gyHWbP+/dKa47jh5xb8Wd1UyqtxK0eNFj
 pPVTYvOTxo+de5uvcWo6Zm1T1qM8SK5lf/vJE9OYXv52XFZvkfFO2rOjb+s/OqJt/ubhh+rvc16
 xNZsWmX7iiddIvv/6zqOmMgWLcnkWN7+ce3Kv619lr3SLNd2ZlJQl7f7fK3Cp/rMvSNvV41GJBl
 a9uSUI8H1uUVWRydFrLzpQ/kl3u9W2OutyKMAM3iW4fnr28u6Jyb/+KiVL4H5vns/3CIv9itXPH
 dXlZ53cxfemNrmmrmBH1qpBpu2Z6h6T86ffRC+23sM0CAA==
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

Hi,

Since its introduction, the vc4 driver schedules its jobs and tracks the
dependencies in between them using its own internal job queue
implementation. This internal implementation is based in job lists, wait
queues and hand-rolled seqnos. Although job scheduling worked most of
the time, in more GPU intensive scenarios, many GPU hangs were reported
[1][2].

After investigating several GPU hangs, I noticed that job dependencies
weren't being tracked correctly, which could lead to synchronization
issues and GPU resets. Also, the GPU reset path had issues related to
job resubmission.

Considering the many issues related to the internal job queue
implementation, this series proposes switching to the DRM GPU scheduler,
which is a well-established implementation used by multiple DRM drivers.

This has many advantages:

1. Using common code: Instead of relying on a custom implementation, use
   a trusted common framework. This helps with maintainability of the
   vc4 driver. It also makes the code more readable.

2. Synchronization issues are gone: With this series, applications can
   work reliably on RPi 3. Many users reported that they weren't able to
   open applications like emulators on the device. Now, it's possible to
   play several retro games without issues.

3. GPU resets are recoverable: Even if a timeout happens, the GPU is able
   to recover successfully with minimal impact to the user.

4. PM actually works: Before this series, the GPU was active during the 
   entire runtime. After this series, the GPU is able to autosuspend and
   resume when needed.

In order to improve reviewability of the patches, I introduced piece by
piece of the new infrastructure without actually plugging it in. The
actual switchover only happens in the patch "drm/vc4: Switch to DRM GPU
scheduler".

For this second version, I moved all the fixes patches to a different
series [3] with the goal to make this series more focused on the
scheduler changes.

This series was mostly based on the design of the v3d driver as the two
drivers are very similar.

[1] https://github.com/raspberrypi/linux/issues/5780
[2] https://github.com/raspberrypi/linux/issues/3221
[3] https://lore.kernel.org/dri-devel/20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com/T/

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260205-vc4-drm-scheduler-v1-0-c6174fd7bbc1@igalia.com

- Moved all miscellaneous fixes and improvements to a separate series:
  https://lore.kernel.org/dri-devel/20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com/T/
- [1/7] Add Melissa's R-b (Melissa Wen)
- [2/7] Squash "[PATCH 04/11] drm/vc4: Introduce vc4_job structures for DRM
  scheduler integration" and "[PATCH 05/11] drm/vc4: Add DRM GPU scheduler
  infrastructure" (Tvrtko Ursulin)
- [2/7] Centralize the initialization of queues in vc4_sched_init() (Melissa Wen)
- [2/7] Handle error when vc4_fence_create() fails (Melissa Wen)
- [2/7] Protect vc4->render_job when updating the pointer in `run_job()` (Melissa Wen)
- [2/7] Handle error when drm_sched_entity_init() fails (Tvrtko Ursulin)
- [2/7] Clarify comment in sched_lock (Tvrtko Ursulin)
- [2/7] Remove fence_lock as dma-fences now support a built-in lock (Tvrtko Ursulin)
- [2/7] Use spin_(un)lock_irq in `run_job()` callbacks (Tvrtko Ursulin)
- [3/7] Add a comment explaining why we don't need to unreference BOs in
  case of failure in vc4_lookup_bos()
- [3/7] Several stylistic adjustments to vc4_get_bcl() (Tvrtko Ursulin)
- [3/7] s/kvmalloc_array/kvmalloc in vc4_get_bcl() (Tvrtko Ursulin)
- [3/7] Remove all error messages related to allocation failures (Tvrtko Ursulin)
- [3/7] Rename vc4_job_init() to vc4_job_alloc() (Tvrtko Ursulin)
- [3/7] Address cases in which in_sync or out_sync <= 0 (Tvrtko Ursulin)
- [3/7] Replace vc4_attach_fences_and_unlock_reservation() with
  vc4_attach_fences() + drm_exec_fini() (Tvrtko Ursulin)
- [3/7] Don't clean-up the BIN job if it has already been pushed.
- [4/7] NEW PATCH: "drm/vc4: Refcount vc4_file for safe access by jobs" (Tvrtko Ursulin)
- [5/7] Use vc4_file refcount to get a fd reference.
- [5/7] Add comment explaining why we use dma_fence_get_rcu() in
  vc4_wait_seqno_ioctl() (Tvrtko Ursulin)  
- [7/7] Return "unknown" instead of NULL when the fence type is unknown (Tvrtko Ursulin)

---
Maíra Canal (7):
      drm/vc4: Move vc4_wait_bo_ioctl() to vc4_bo.c
      drm/vc4: Add DRM GPU scheduler infrastructure and job structures
      drm/vc4: Add new job submission implementation
      drm/vc4: Refcount vc4_file for safe access by jobs
      drm/vc4: Add per-file descriptor seqno tracking
      drm/vc4: Switch to DRM GPU scheduler
      drm/vc4: Use unique fence timeline names per queue

 drivers/gpu/drm/vc4/Kconfig         |   1 +
 drivers/gpu/drm/vc4/Makefile        |   2 +
 drivers/gpu/drm/vc4/vc4_bo.c        |  33 ++
 drivers/gpu/drm/vc4/vc4_drv.c       |  49 +-
 drivers/gpu/drm/vc4/vc4_drv.h       | 234 ++++-----
 drivers/gpu/drm/vc4/vc4_fence.c     |  34 +-
 drivers/gpu/drm/vc4/vc4_gem.c       | 961 ++----------------------------------
 drivers/gpu/drm/vc4/vc4_irq.c       | 132 +----
 drivers/gpu/drm/vc4/vc4_render_cl.c |  17 +-
 drivers/gpu/drm/vc4/vc4_sched.c     | 337 +++++++++++++
 drivers/gpu/drm/vc4/vc4_submit.c    | 581 ++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_v3d.c       |  24 +-
 drivers/gpu/drm/vc4/vc4_validate.c  |  21 +-
 13 files changed, 1243 insertions(+), 1183 deletions(-)
---
base-commit: 4b9c36c83b34f710da9573291404f6a2246251c1
change-id: 20260121-vc4-drm-scheduler-03cd8670b3f6

