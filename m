Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E15C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 12:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B52710E6BF;
	Sat,  4 Jul 2026 12:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="s79843KM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9667B10E6C1
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+E4v1d5N8/A/atzqvxdUcaTEAx9Y5SbPsbMLr8Z3i9E=; b=s79843KMRcbkGdBoHA/JayMBA0
 YmUYdmqAtVtE7vZCoNnD8Q8Tuz8pW6/d/5DSWF8i8V6Wditp6U+nlsIrF3OwISuOBhgcC3j6OEsNM
 dcJFcAhQhYAFgCJ3fh6WgCP18wIgONn7Cpr6SF3ufob6PKAIXWL0L+f2/HXkVlwIKmvM6LVZHQYO4
 gudbNI7gchPtG3zR892DmkA0H8pol+IrHF4c0CH/vo/Bm4HxpT16kQeIJ1gHm0jlpqUE0/Z10nyD2
 4O0x9AQe34QA/JHXJhbubJpimP/+3+28l8zYKEILuGVZKfEy+TGCNhmf3e/WO0jRTVKNDmPVJ26l7
 x5ELT/8g==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfzHe-008xDl-B9; Sat, 04 Jul 2026 14:15:46 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 0/2] drm/v3d: Fix perfmon locking and cross-queue isolation
Date: Sat, 04 Jul 2026 09:15:38 -0300
Message-Id: <20260704-v3d-perfmon-lifetime-v3-0-fd26dfdc2153@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBQE4KuQrq1pCyXFlfcwLgp9hZfwZ4uNh
 nB3C8aoiS5nkvlmJh4cgieHZCYOAnoc+hjSXUKqRvc1UDQxE8FEziSTNKSGjuBsN/S0RQsTdkA
 zVRUGDGcFL0mcjg4s3jb2dH5mB5dr1Kd32aCfBnffrgNf29eL+v0SOGXUylLmmaiYkvaItW5R7
 6uhI6sYxIeS8j+KiErOwGSZklqw9EtZluUBy6sCYBQBAAA=
X-Change-ID: 20260505-v3d-perfmon-lifetime-48c9ded1091b
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4909; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Zh9R2dPO8cTFLNpIEaQ9LwtaTMBTmYst9ppSmPU76Yc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqSPlvvJIJ/VtTcDnfrl8o6rkFaYbGIIlAG48t1
 oBxoO/0YqaJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCakj5bwAKCRA/8w6Kdoj6
 qo/LB/9XVwBSqUV/T48m38L0RmgK1VlIfdhGzrSvXAaXVS5y+YJAR3KBMEf4O8wmi2NujeqJ/bC
 mXMMyE78aQ2Hv+0Jev/wsPqPpu35pNOy6eYnFYL9BDCnJhxPb8P8fQDv+XmeDIb/CvHyRZFXgM/
 J2gqTzZhMcEwsnw4/HmPJuP/CihpkF4QJf1w0ryUQ9I8RBXC/hHhx5IPN5wKMIamJuyuc7pM6BP
 FTIVfUWFs1k7EXbLO1CaIawqoxkbWjD2aaguBHMT+pnpwZlwsPoDsMl43toyF6Dbq+bpTFeyTd/
 8sNy5EeNlV2SIm/fKubZAA03dRcD4HkRt95gFOP0b9dnjWTt
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

A v3d core is able to expose a single set of HW performance counters, so at
any moment at most one perfmon can be programmed in HW. Currently, the
driver tracks the active perfmon with v3d_dev->active_perfmon, but three
long-standing issues makes perfmon handling unreliable:

1. The active_perfmon pointer is accessed lock-free from scheduler
   callbacks, the GPU-reset path and the perfmon ioctls. Note that the
   v3d_perfmon->lock mutex serialized start/stop of one perfmon object
   against itself, but the invariant that needs protection is device-wide.

2. perfmon start/stop is hooked exclusively to run_job() callbacks via
   v3d_switch_perfmon(). If nothing is queued behind a perfmon-carrying
   job, the perfmon is never actually stopped.

3. A non-global perfmon should count events generated by a specific
   submission, but the scheduler can run jobs from different queues
   concurrently. Without explicit cross-queue serialization, an unrelated
   job running in parallel pollutes the counters and produces unusable
   results.

This series aims to address all three issues.

PATCH 1 moves the locking to where the invariant actually lives (fixing
issue #1) and replaces the sleeping mutex with a spinlock, which allows us
to stop the perfmon from the IRQ handler at job-completion time (the
natural boundary for "active perfmon follows the active job") and fixes
issue #2.

PATCH 2 addresses issue #3 by building on the new locking to enforce
cross-queue serialization when a non-global perfmon is attached, by adding
scheduler fence dependencies during submission. The fence dependencies
allow us to enforce two rules:

1. A job that carries a non-global perfmon waits for every job currently
   in-flight across all HW queues to finish.

2. While such a job is in-flight, any subsequently submitted job waits
   for it.

This allows us to ensure cross-queue isolation and the reliability of
the performance counter values.

To make sure that this series actually produces the expected results and
improves the overall reliability of v3d's performance monitors, this
series is accompanied by a IGT series [1], which was already merged.

[1] https://lore.kernel.org/igt-dev/20260514201637.1811428-1-mcanal@igalia.com/T/

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260508-v3d-perfmon-lifetime-v1-0-f5b5642c085f@igalia.com

- Rebased on top of "[PATCH v2 00/14] drm/v3d: Scheduler and submission
  fixes and refactoring"
- [1/4] NEW PATCH: "drm/v3d: Fix global performance monitor reference counting"
        - Minimal patch for stable branches only fixing the reference leaks
          in global perfmons.
- [2/4] Start/stop the global perfmon inside the set_global_perfmon ioctl and
        simplify global perfmon management across the helpers (Iago Toral)
        - In the reset path, before stopping the perfmon for the HW reset,
          v3d_reset() now re-arms the global perfmon with v3d_perfmon_resume(),
          as the global perfmon's start/stop points live only in the IOCTL.
        - v3d_perfmon_get_values_ioctl() no longer stops the perfmon, it
          only captures the values. Lifecycle management is left to the job
          (per-job perfmons) or the SET_GLOBAL ioctl (global perfmon).
- [2/4] In v3d_perfmon_delete(), first, stop the perfmon and then, check if
        it's a global perfmon (Iago Toral)
- [2/4] Add some comments to explain the refcount logic for global perfmons
        (Iago Toral)
- [3/4] Move the job->queue introduction to this patch instead of the
        previous one.
- [4/4] NEW PATCH: "drm/v3d: Drop the queue argument from v3d_job_add_syncobjs()"

v2 -> v3: https://lore.kernel.org/r/20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com

- Rebased on top of drm-misc-next.
- "[PATCH v2 1/4] drm/v3d: Fix global performance monitor reference counting"
  was applied to drm-misc-fixes.
- "[PATCH v2 4/4] drm/v3d: Drop the queue argument from v3d_job_add_syncobjs()"
  was no longer needed after "[PATCH v4 00/12] drm/v3d: Scheduler and
  submission fixes and refactoring" was applied to drm-misc-next.
- [1/2, 2/2] Add Iago's R-b (Iago Toral)

---
Maíra Canal (2):
      drm/v3d: Refactor perfmon locking
      drm/v3d: Serialize jobs across queues when a perfmon is attached

 drivers/gpu/drm/v3d/v3d_drv.h     |  47 ++++++++--
 drivers/gpu/drm/v3d/v3d_gem.c     |   7 +-
 drivers/gpu/drm/v3d/v3d_irq.c     |   7 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c | 189 ++++++++++++++++++++++++++++----------
 drivers/gpu/drm/v3d/v3d_power.c   |   4 +
 drivers/gpu/drm/v3d/v3d_sched.c   |  26 +-----
 drivers/gpu/drm/v3d/v3d_submit.c  |  68 +++++++++++++-
 7 files changed, 261 insertions(+), 87 deletions(-)
---
base-commit: 903f8773ee96c5dc5fb9aec65227f39fd3e7a1dc
change-id: 20260505-v3d-perfmon-lifetime-48c9ded1091b

