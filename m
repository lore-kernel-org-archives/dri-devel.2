Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C56EC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD9B10F419;
	Thu,  3 Sep 2026 07:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lGnx8X78";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBA810F22C
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 14:42:12 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so1053272b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788360132; x=1788964932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rKM/PPFy7W4wICYY4yvWsIe6e1r+fY7pf2VDor/H3i8=;
 b=lGnx8X78ij2PC4j8a0sAcRf2aeW///S/dQ9xZ+7AVNFRup2xAnhxmtEyVbjZzIF84K
 QCwhPH/IBdD+u07ypaJ/v+Jm2fdcUvAhsoT9QDmvORVAyWOPdimB1aPAuztNiXjEQXas
 nwTdbt/Oev8DMAPiM9fAsh9tIswd5MUiiWKtkPw65JaRLkLIx1uJP18897ua6rlPx+lG
 19HqxM0kjxMjZG0XQWaZowM4d+hyZJJvCzWKAg4oUdwVqOrvZ0Zrwc7u8bnypoVLICTM
 8lXzOVGicQYDJ2JAHBiHHcudLfZuYJxA/HLbGokn8+7ML0y6NwhhS3fTWDrPWQlwIwU0
 Urrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788360132; x=1788964932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rKM/PPFy7W4wICYY4yvWsIe6e1r+fY7pf2VDor/H3i8=;
 b=k81F9JKxPqlTNDjFSX6XmlLcgPsnD600UWpg6VanHc9RaZsytZtNILm15oV3dH/q5o
 EYiDQ3SMFkejpQJLUYW1TozYqCDLfJj85/Kn7oCXPFZ7HTmZLTXFMdk57YsP/YGGFwXV
 H4fWM5cGtDWoD7H5yGF9kHPB35GVLqpKtZa4hNFXxws0RaOrsvWH64qEsuJSmLcmMG9k
 OgA977xZIig6Yc/VMQipmlHoqGjl8t3bV6SqMwnwTBda7Qcnqx+jZr0ROUYnoRQSKAS/
 Z7CFLY9+ZBAimN/nTff04lR9PR+IH5pmnhS4kqv2blgu5CieFAETMoZrQKOfK+XjJIGg
 RaOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJy6hK11LbVCGw+bcQ4g/F4tPsd2Tdqe5/NGXm5081FiztU5hYBlK56N47wWZO1Jq9g5A2Y4NE5no=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lDwpNC8eRnaVPIynddlbkQCjXkl6PLMhc6YZsfzSv6oCzupwb+
 KSQ8b4EjCbkukh9gtwxfJoc7NXsoepDW/6wYqhVXyDULzthIO6pqatM=
X-Gm-Gg: AYBFou0FF3lPuLddPA0uidE6YVS8CqVBqVpVfDMK5W8D9BIRoarQUjAoRBzV4c3vfRA
 Z+3jXyFZ5RsiJshnbdVit5woHz+ztCQuxCxUTMwQ5L5xzy6GWPG5mdbgPNiDfZuMJqiQI+z3duk
 WCgZTxIwid/ue3c7PrLfY6RUFkNy/kgxV7ZpUahE4CJc3+pHnQAaG4bv7nis6WvK1QRCsBtecnE
 ssm4OMYAsknU0TseZ3A3RqZOox+WJG+StP6amQ8uE5qMiNekfL28Tue/g4Vt74N6KuLBaHc3aXC
 te6uibYKWRJFkFwGX4PRkcgahUQIFUNLAdNa63tyDfU0IRYxig/66M0HmtXPGbDV/UWEHJK/sRz
 Zam4J0LfKWj3prZjEYVsED1xa2OR+XE6hOg8cN09NaQg14HSqk1TTsfTAAq1YmAOV8UOnJPToin
 zqAV6p0REVoGYm67R3hiNLQCLX5mfvfLQtfZ6OwV0GMW5BKt415/EjR5BWVb0+ZNr/Afs7I0+6t
 //vOJ4E1/NALAwmDI5Zg1TKSuc=
X-Received: by 2002:a05:6a00:368c:b0:851:c1d2:c48d with SMTP id
 d2e1a72fcca58-85ed25e0713mr8399867b3a.8.1788360131651; 
 Wed, 02 Sep 2026 07:42:11 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db23f8d8asm1655776b3a.12.2026.09.02.07.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:42:11 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: tursulin@ursulin.net, phasta@kernel.org, matthew.brost@intel.com,
 dakr@kernel.org
Cc: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
Subject: [PATCH v3 0/2] drm/sched: fix use-after-free of the fence timeline
 name
Date: Wed,  2 Sep 2026 23:42:02 +0900
Message-ID: <20260902144204.1843670-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

drm_sched_fence_get_timeline_name() dereferences fence->sched->name. A
driver that allocates a drm_gpu_scheduler per context, queue or VM frees
that scheduler on context teardown, but the finished fence can outlive it:
unprivileged userspace holds the exported fence via a sync_file or
drm_syncobj and later queries its timeline name (e.g. SYNC_IOC_FILE_INFO),
reading the freed scheduler. Same class as CVE-2025-38703 (drm/xe) and
CVE-2025-71302 (drm/panthor); amdxdna, nouveau and msm (VM_BIND) are still
affected in mainline.

This series fixes it in the core rather than per driver.

v1 and v2 took the approach of caching the name at fence init. Review showed
that is the wrong fix:

 - Tvrtko pointed out the documented contract does not require the name
   passed to drm_sched_init() to outlive the scheduler, so caching the bare
   pointer only narrows the window; and

 - the sashiko review bot pointed out that caching does not help drivers
   whose timeline name is dynamically allocated and freed with the queue
   (drm/panthor, drm/xe) - it just moves the UAF to the string's lifetime.

Philipp suggested dropping the finished fence's ->release callback instead.
That is what this series does. dma_fence detaches a fence's ops on signalling
when it has neither .release nor .wait (dma_fence_signal_timestamp_locked()),
and dma_fence_timeline_name() returns a static string once the ops are gone.
So with the callback removed, get_timeline_name() is simply never reached on
a signalled finished fence - no ->sched dereference at all, for static and
dynamically-allocated names alike. The finished fence's only job in that
callback was to drop the scheduled fence's reference, which patch 1 moves
elsewhere.

Link to v2 (name caching):
https://lore.kernel.org/dri-devel/20260902105808.1541063-1-malhyuk97@gmail.com/

Note: detaching the finished fence's ops on signalling also makes
to_drm_sched_fence() return NULL for a signalled finished fence. Callers
already handle NULL (the normal foreign-fence result), a signalled fence is
an already-satisfied dependency so the scheduler's dependency collapsing is
unaffected, and it avoids the container_of() on a possibly-freed foreign
scheduler that amdgpu_sync_same_dev() and pvr_queue_fence_is_native() would
otherwise do. Flagging it explicitly since it touches an exported helper.

I did not add Fixes:/Cc: stable tags: the ->sched->name deref dates back to
1b1f42d8fde4 ("drm: move amd_gpu_scheduler into common location") but only
became reachable once drivers began allocating per-context schedulers, so
the right attribution is unclear to me. This is stable material as the
driver instances are live - happy to add whatever tags you prefer.

Tested with KUnit under KASAN (kunit.py --arch=x86_64), matched pair:

  - unfixed (finished fence keeps .release):
      [FAILED] drm_sched_dma_fence_uaf
      BUG: KASAN: slab-use-after-free in
          drm_sched_fence_get_timeline_name+0x9c/0xb0
      Read of size 8 ...
  - fixed (this series):
      [PASSED] drm_sched_dma_fence_uaf
      Testing complete. Ran 47 tests: passed: 47

(The whole drm_sched suite passes with the series, no regressions.)

v3:
 - Switch from caching the timeline name (v1/v2) to dropping the finished
   fence's ->release so the ops are detached on signalling (per Philipp);
   also fixes the dynamically-allocated-name drivers caching could not.
 - Rework the scheduled/finished fence lifetime: the scheduled fence now
   holds a reference on the finished fence, which is released last and freed
   from dma_fence_free(); @finished moved to offset 0. drm_sched_job_cleanup()
   drops the scheduled fence's initial reference.
 - Move the regression test to a new tests_integration.c and query via
   dma_fence_timeline_name() (per Tvrtko's review of v2).

Jonghyuk Kim(MalHyuk) (2):
  drm/sched: fix use-after-free of the fence timeline name
  drm/sched/tests: add a UAF regression test for the timeline name

 drivers/gpu/drm/scheduler/sched_fence.c       | 46 +++++-----
 drivers/gpu/drm/scheduler/sched_main.c        |  9 ++
 drivers/gpu/drm/scheduler/tests/Makefile      |  1 +
 .../drm/scheduler/tests/tests_integration.c   | 92 +++++++++++++++++++
 include/drm/gpu_scheduler.h                   | 22 +++--
 5 files changed, 139 insertions(+), 31 deletions(-)
 create mode 100644 drivers/gpu/drm/scheduler/tests/tests_integration.c

--
2.43.0

