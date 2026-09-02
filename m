Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95477C624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F4A10E81A;
	Thu,  3 Sep 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sxl/aY4d";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3248A10F112
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:58:16 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cc11a905ba5so646518a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788346696; x=1788951496; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FhJ3rNj3BMMmAadCEQfLTR+seEymXdU0q5qyqSuHK34=;
 b=sxl/aY4d7jSs33RoUKszABWphYA87tnrGwIxpDcpXGkbJM5tAcKNlm2u4/KQ8nPncC
 rHOstDR0G9SiXC/F1Yz3s24z5vRqsTHIostndJQvuD+zfqOZNAKpjsTUu8hgQ9Z9jEa3
 0fFgZGUnoHL6POVVjvnIv6x9DjkxQ2gbFgc5Rsq7yC3eCTYMtf+0/gW559ZrM/W2tVKT
 5RoL6le9wHdiHVx1CAwfEdm4NTCOFM8h083RYAKs3V8SXm5nO5xTfdW4twWKapA9pxcq
 YJr5ZFO0l8+O+zcr7vcjc5liCCXzbWs3y2nd7oPL0rDnE4V2wUPfvA//gj4u/KwcKmXm
 H9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788346696; x=1788951496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FhJ3rNj3BMMmAadCEQfLTR+seEymXdU0q5qyqSuHK34=;
 b=R9+1MB8pWYRqCp2rLOA3EJ7xXATuP0V9cBik7iZpKg/5rL9GFJCKAMIbIQA4D1QCnE
 El1dGAyaXfqKKZ2cOx8S4lQdS/oS9Lw//Z66HeLIIAD/0Qr9+8SbGxPuBg/xCtaw4PcY
 NjG0vcpH6zHEjd5zLDypPk1Yy9yUNnsDMXtlXJhjry9Ut0sQJl2m3+zplSpn9JId2cEN
 yd+G/6OVNl7GNl4R4v8XlasDDD5/dbyqs0rPHLAqJXU0ZJZnBefCcOg/LCbEfcrRkziI
 CGVB9/tAW2SrbE7rgjBxYwgE+uFJpSGKLSeHKM4PDE2iYzH2ZWmEMHT7zVZTckDc+0DX
 kffw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJbph9bfJLNbuIlRj58Vel29Hd1F/OjU2EEKDzLV//isr91w/UWZaN3rmyuZwjVl8rJfxLIHne4js=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mqVIsfj0CRndE+vhA1WfWdQtR4/T+kR44ZECkm9kV1aD7LcwIe
 XtqxYIimIPPTy+tOW3F3neiVVaSZGDHzpFcR1V4IDAKd00RSs80IJllqlvf8/jE=
X-Gm-Gg: AYBFou1hfHF/7SWGD0G5W1R8RpNH/LIcURpEgRZYy9wXAK+DEYdVST3JODCvhcTEb3V
 mxvwc/EZ3ZvK5Mxgzd9L3uaxbUS4conAtkxMEwSIpSkh1Oh6MjysHlXL7SYrquiCQBybfNXE1Fn
 iJByvv4JZn00138CT+GacCOHiVsHSQCyW4exJwczA+6v9iyM+m60ywt10h0+6ki3J3o/XONWUDd
 aLVpiiQE9gJAG+8MMR/5qWGyFakCMPIyiRcrXYQurrvJ3y49hVKx/jbPP0b64xrIyjA5b9uTFTt
 qQsqEbO9WaBYX1clmagOvRYKePYCpA2f2UyfS0Ed/Rdd+pMWSZZxurvUw0TlzYi1bQNqq+bIQcX
 Y3cm1O2NvU51MASWfFjMb6UkDuT8lzvACCVY8YvWCkIzGF/q/Ag4b1Ftfpeaw6g7hi5EvUu8TT4
 Cgjx7ExLgoKhYyY47zxgpoXw7ur4LTXX2m2nmGme+eFCmhayAB9T4mL4I3VKvQx8YLBgB9JAGfW
 wYJH1TryO3Xu6LvZnegCX+zmSc=
X-Received: by 2002:a17:90a:dfc5:b0:398:d292:e6d5 with SMTP id
 98e67ed59e1d1-39aee17a08fmr6299131a91.24.1788346695576; 
 Wed, 02 Sep 2026 03:58:15 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae0dfcd65sm4963143a91.3.2026.09.02.03.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 03:58:15 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: tursulin@ursulin.net, phasta@kernel.org, matthew.brost@intel.com,
 dakr@kernel.org
Cc: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/sched: fix use-after-free of the fence timeline
 name
Date: Wed,  2 Sep 2026 19:58:06 +0900
Message-ID: <20260902105808.1541063-1-malhyuk97@gmail.com>
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

drm_sched_fence_get_timeline_name() dereferences fence->sched, but a
per-context/per-queue/per-VM scheduler can be freed on an unprivileged
context/fd close while userspace still holds the exported ->finished fence
(sync_file / drm_syncobj). A later SYNC_IOC_FILE_INFO then reads the freed
scheduler:

  BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name

This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
(drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm
(VM_BIND) are still affected in mainline, so patch 1 fixes it in the core for
any per-context-scheduler driver at once.

Patch 1 caches the scheduler name pointer in the fence at init time and
returns it from get_timeline_name() without touching fence->sched, plus
documents in struct drm_sched_init_args that the name must outlive any
exported fence. Patch 2 is a KUnit reproducer exercising the mock scheduler
under KASAN (no hardware needed).

v1 -> v2:
 - Keep caching the name pointer and document the lifetime rule, rather than
   kstrdup()-ing per fence, to avoid an allocation on the submit path for a
   debug-only value (Tvrtko).
 - Reworked the test to query through the public dma_fence_timeline_name()
   API and moved it to a new tests_integration.c so tests_basic.c stays
   focused on core scheduler behaviour (Tvrtko).

Tested with the patch 2 KUnit test under KASAN (kunit.py --arch=x86_64):
  - with patch 1:    [PASSED] drm-sched-dma-fence-uaf
  - without patch 1: [FAILED] - BUG: KASAN: slab-use-after-free in
    drm_sched_fence_get_timeline_name+0x9c/0xb0 (read of the freed scheduler)

As discussed, the cleaner long-term fix is to drop drm_sched_fence's
ops->release so dma_fence detaches ->ops on signal and decouples the name
itself (Philipp); that is a larger sched_fence rework and is left as a
follow-up, with this cached-name fix as the immediate, backportable one.

Jonghyuk Kim(MalHyuk) (2):
  drm/sched: cache the timeline name to fix a use-after-free
  drm/sched/tests: add a UAF regression test for the timeline name

 drivers/gpu/drm/scheduler/sched_fence.c       | 16 +++-
 drivers/gpu/drm/scheduler/tests/Makefile      |  1 +
 .../drm/scheduler/tests/tests_integration.c   | 83 +++++++++++++++++++
 include/drm/gpu_scheduler.h                   | 18 +++-
 4 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/scheduler/tests/tests_integration.c

--
2.43.0

