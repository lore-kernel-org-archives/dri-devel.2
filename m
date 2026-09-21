Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D45C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A99A10EBE4;
	Tue, 22 Sep 2026 08:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BG4OkUzR";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6555410E8CF
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:21:31 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso2571479a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790014891; x=1790619691; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ei5giWzghMksrMNaXLe7L4JTxplKdbY9ZlauLOVvWzo=;
 b=BG4OkUzRTEslKAt/PhQEiO5he9DYmYO2vWsEnJ3Oy74O6XDf78g2AhCpi4IWeaa7YE
 IJoC2q6ZyfIVVgHe+XNpr9e2AkbBuSCuW3kXZSmY0Bqgh6pXBVkz0AyydSkQV+mj4jRA
 nZE8TdipOLNq76z8fK9UnMx8+ht0Iip3HFhaZ9vjkcrS1myn0W9xuGKrNa7JDJP7Y9/R
 kw3O6qOyHSaioRxfWOxh2ojdK1wJk+MIcgiXRcRt1m6X6vije9/u6gL8Mz+9nSgrVoF/
 3NuFUjfpAtfQLp49Vp83pnGpl5l4vBP297SXT8qYkpJz01AlxThgURm6x1H8K0VIseFT
 RHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790014891; x=1790619691;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ei5giWzghMksrMNaXLe7L4JTxplKdbY9ZlauLOVvWzo=;
 b=g6N/IsXBelY7BYLaypY230gmUtrnhKv2vIOhYApAJOPLwk/Lt55ukSAoSvGJ5mOrxg
 JCLScvjODN4aCdhXFppfT7I0SfkmgaUJNB6yXcl/yeG6ezM1z1szESnmCY4KrSLt3HeH
 9y83gsLG7N2TeqetNz+tujrl/l2FkATrTb6OT8b1hf/2IhfznFHgakyX3TaAtlRG/DMq
 9/ILdbpjU3yyo5G7ipv5ctUuWH/3L6NQAHnabQu5cPRumzSyU01KyjxS9gCIzU9fqYU2
 fXJ+37dAAKG9NDFP0HKFuDoF2sRDx3VwRRwRVDkyhbueEZwwNxZLrAyY1tP4+ljGHoCK
 cpPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3b6sFBU4I24dk+LBvboEmsCJGm3P9BP0agMqJOmJvN0vofBFl2Lr3lBBW/BFohmt4my+yTKsIFK0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kWBDU95WrRppCfnF2zQ4hnXNR0X/sJTV6sol4PjxT4l6udjIYl
 H/8d/Tm7z2TUwqldZG3M9wKO6p6XQlH0sR8pjLMVneBX7pQhiMkD9c6b
X-Gm-Gg: AYBFou0Pw3PpXf6HOf6nYhGaWS0cmPzEKlyPau0BHIiGgZHdMq31TMPRmmuikef7w6n
 tztV9EKGIQiFaSJrutyCtdccesHV4V2FHqnnM5iRKhr+R24msp5y99L9DskOTDluA2LzuYdmHA9
 qKmpM9FvCV8XBqENpHMMMkTFWe5s6hcCMyFUfRaY2PIPE9hgQWpj4XEOa0mR4+l5xShnIY9bXYs
 g0rUlgAl2K9HIm2xtc7m1+1xxXqcu4o+65qY2p0aije8+9bFVRJ00XRwsJks4aCcIUTxzhz+Iod
 4hVkItH6gzlOAePfOLscaK7atZyGDW+EtvB4qeZEDEztZ34a8eumRxZVRi5jjVNA+sCYNz+JRdt
 91OrcYDEhBn2wmKkmfQj/S2kvBfLwB/7WhasveLUi3YM6bakFvbKJ0hn9KeKs4RLuqwyrwTCTed
 pe2gs8IspHA+hlAQyZA0U4x5d2ThzvqNp2o4+zhU4wXYnTs77uPBRQNhKBnb6q30DOKMwtjGFXD
 0i3LmG1IO0IpxHQFs1d1JhzHSIrDKWhCO07pKzmwM+cCYWKd3LNf/xwzZF/Acdu
X-Received: by 2002:a17:90b:4b03:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-3a0645d08ccmr999705a91.1.1790014890734; 
 Mon, 21 Sep 2026 11:21:30 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.211.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55e8954sm38587021c88.14.2026.09.21.11.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 11:21:30 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 jani.nikula@intel.com, navonjohnlukose@gmail.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v5 0/3] drm/xe: fix GuC TLB invalidation ack stalls on ARL
 (Wa_22016122933)
Date: Mon, 21 Sep 2026 15:21:18 -0300
Message-ID: <20260921182121.308217-1-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

v5 of the TLB invalidation ack stall fix for ARL. Tracked in:

  https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

Recap: on the standalone media GT of MTL/ARL the CPU reads stale cache
lines for data the GuC has already written. The visible symptom is TLB
invalidation acks appearing to stall for a near-constant ~2.3s. i915
works around this as Wa_22016122933; xe never inherited it. Patch 3
implements it, scoped like i915.

Patches 1 and 2 picked up Matthew Brost's Reviewed-by - thank you. On
patch 2 we agreed the SIGID conversion of the TLB logging is a follow-up
on top of this series, to be done by the people working on SIGID; there
is no TLB component in DEFINE_XE_LOG_COMPONENTS() yet. Happy to rebase
on top of that work once it lands.

Patch 3 is unchanged since v4 and is still the one without review. It is
also the one that actually stops the stalls: it applies
XE_BO_FLAG_NEEDS_UC to the GuC-shared allocations (CTBs, log, ADS, SLPC,
engine activity) on the standalone media GT, scoped by a new OOB rule
(22016122933 MEDIA_VERSION(1300)). The approach was suggested by
Daniele. Daniele, Stuart, would one of you be able to take a look?

Validation of patch 3 is now six weeks on two ARL machines (7d51 and
7dd1), across kernels 7.1.6, 7.1.8 and 7.2, with over 10M TLB
invalidations processed and zero ack stalls. Before the fix both
machines reproduced 20-60 stalls/day, every day, on two GuC firmware
versions. The 7dd1 machine, which could not survive a day of media
workloads on xe without a platform freeze, has been running xe full
time since 11 August with zero incidents.

Two notes carried over from v4, still open to either answer:

 1. CPU mapping: keeping XE_BO_FLAG_NEEDS_UC (uncached on both sides).
    It is the tested configuration and no throughput difference against
    the CPU-WC variant was measurable. Matching i915's exact CPU-WC +
    GGTT-UC combination needs either a new BO flag or decoupling the
    GGTT cache-mode selection from XE_BO_FLAG_NEEDS_UC; happy to add
    that plumbing if parity is preferred.

 2. Fixes:/Cc: stable are left out, since MTL/ARL is require_force_probe
    in xe. Also happy to add them.

checkpatch is clean, except for one --strict CHECK about macro argument
reuse in the xe_devcoredump() wrapper in patch 1, which is intentional:
the macro only exists to forward (_q)->gt alongside _q.

v4 -> v5:
- Rebased on today's drm-tip; builds clean, no conflicts.
- Patch 1: fix a data race reported by Sashiko - seqno_recv was read
  outside pending_lock in the timeout path. It is now sampled while the
  lock is still held and passed to xe_devcoredump_gt() by value, so the
  capture itself still runs outside the lock.
- Patches 1-2: collected Reviewed-by from Matthew Brost.
- Patch 3: unchanged.

Thanks,
Tales

Tales A. Mendonça (3):
  drm/xe: Capture devcoredump on TLB invalidation timeout
  drm/xe: Log when a timed out TLB invalidation ack finally arrives
  drm/xe: Implement Wa_22016122933

 drivers/gpu/drm/xe/xe_devcoredump.c         | 46 +++++++++++----------
 drivers/gpu/drm/xe/xe_devcoredump.h         | 15 +++++--
 drivers/gpu/drm/xe/xe_guc.c                 | 16 +++++++
 drivers/gpu/drm/xe/xe_guc.h                 |  2 +
 drivers/gpu/drm/xe/xe_guc_ads.c             |  3 +-
 drivers/gpu/drm/xe/xe_guc_ct.c              |  6 ++-
 drivers/gpu/drm/xe/xe_guc_engine_activity.c |  6 ++-
 drivers/gpu/drm/xe/xe_guc_log.c             |  7 +++-
 drivers/gpu/drm/xe/xe_guc_pc.c              |  3 +-
 drivers/gpu/drm/xe/xe_tlb_inval.c           | 41 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_tlb_inval_types.h     | 17 ++++++++
 drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +
 12 files changed, 130 insertions(+), 33 deletions(-)

-- 
2.55.0

