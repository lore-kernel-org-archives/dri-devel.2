Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1291BC61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7310510EA91;
	Tue, 25 Aug 2026 14:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XPL2dz73";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA0C10E7C3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:07:59 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-81f3b227a4aso54551087b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787580478; x=1788185278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0yNqopektA6CmGzMtywYajCtH1yhmgLiF2mewMkr3m0=;
 b=XPL2dz73LFGx3n2vPEobQLEhQyx/5Plhy9WfPNL7t0Z68pMuIutjLHDYr5IYNAoSkp
 7Oe4nG5tsosISpEJQiATta8UN4TRdLz0IdBuiNc2UhDjawsz2nB31L4kSVgYbManBTmC
 Vzqwsn0YJTUSnEhz0aFHVGmD0aoX/Q+4r03uvWgUVDS1Cw67rHr/pkAlsLPFA10adoPa
 3Fq+2sm/r3obYhN0RTqlgtAn1Ba+0SBYSTsi9pUFpH6wqkosgWAz/lOfTNWg+bZSnzmv
 h7z6y8Nl0mUXJF6f9u88VE3btIbye9A3pRYW+Txlj/ysRLl26P/xalqiNPXUqsV917RG
 YZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787580478; x=1788185278;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0yNqopektA6CmGzMtywYajCtH1yhmgLiF2mewMkr3m0=;
 b=i4B+zIjIt8J0ny0cncqEXV4m2SM3sjdemPZB550ZXuIYBsOQQpZH5C1WBxR5QxT7f4
 D4rLCsOeomJu/xktMwFIbAlCEH1AK9Fsy0SzuJhhtBp0mHyh0kmpI5P8k+pkANlonmIY
 xVKkpF+siyYTeNflYLQvKMAoEsiq6WSNnn+JUTFAEeqG9sruTJU/3y10djgiPDke0iTX
 NlxaBMQJBnQHrzJE1inGwFH71h75evDcanRZyzRIS7WdBtR0TSocCRnp1ORtms5v5OPR
 Z/dsTXZtT0pf+h0UzhkMjxEIqMGXksoc6avv30yg3yGTUkZa/i/QRS/VDK1wdg7kj7NS
 CzNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNZcU9WxGOZrfA34ffronPfMxAXP8eVov4+0bk7xjGKMACTd8b10eWFR82f6FolQWqf8Ju+G7rWec=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nDJGsIzIVpsboCeWsvk94XkDSokwt6bMRGuGXqDqvYjFCnYi9Y
 pMsXF46J/ZtoL6Td3crlQ03Ww4jJggCtD1kfMbzaE/eiUin3Kv9H/46Z
X-Gm-Gg: AR+sD13ktL6PxoO/+xwU5sy1vtesWfFE697+TfP8Gy3ojTE4edppVbAbv4ebX6O/yZ/
 GJV7GI87Z6xqpKNn0G9TtMOnrzCOWAdRxRux6IHzFJMIDlFVrSqUfY/i9Wb4TePX7HBDARBxZmy
 A64pcJNA5KCXJ8IRrv744uL8pAwZJiQMxSVcd25YB1t+c+DldYhSO1iyKZilQKZiZfVb66lhrEr
 q8GICS3fqnptxzc3wwNMXeKG6/G3x5fs8yejbmUkongF+TWvt8EUK7qk8MHss3EqziZ1pfz+iyl
 OsibLjkMghC7yLbIm+9Npu3EOuFfsKmNaQwWKz9vEkcT7st/nDw58Co6l2qsamQeDQBOoJxlPMJ
 KKsJapqvwKRKLYFPNVpKl7zuOjAx9ybzNiYBMrfvViOvnFRy3MXJffA6GuBsNIihib0K3Ak2Zhi
 cj8pgm/ruvZT7plcNbNx0m6ashFy6guopxt36pICdb4GiD+NmtzgOVjHlKd6Gci1pVuTDMEpYyx
 9E2N0UojZNXntiiu3ilE6d4lCFdcWlW1Wr/U8g=
X-Received: by 2002:a05:690c:a714:b0:81e:893c:2c23 with SMTP id
 00721157ae682-849f14c4040mr92883567b3.11.1787580478334; 
 Mon, 24 Aug 2026 07:07:58 -0700 (PDT)
Received: from lord ([170.246.211.189]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-853ff053a84sm3326337b3.4.2026.08.24.07.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 07:07:57 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 navonjohnlukose@gmail.com, dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v3 0/3] drm/xe: fix GuC TLB invalidation ack stalls on ARL
 (Wa_22016122933)
Date: Mon, 24 Aug 2026 11:07:45 -0300
Message-ID: <20260824140748.54974-1-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

v3 of the TLB invalidation ack stall fix for ARL, tracked in:

  https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

Root cause recap: the GuC replies in time, but on the standalone media
GT the CPU reads a stale cache line of the G2H CTB - the caching
erratum i915 works around as Wa_22016122933 and xe never inherited.
Patch 3 implements it, scoped like i915.

Since v2, Navon John Lukose A/B tested the series on an ARL 7d51 and
produced three results that are folded into this version:

 * Making the mapping coherent instead of uncached does not work: a
   GGTT PAT entry repurposed to WB|COH_2WAY still stalls
   (request-to-ack 2290ms). Now documented in patch 3 - it is the
   obvious question to ask about this patch, and the answer is
   measured rather than assumed.

 * xe_guc_engine_activity.c allocates GuC-written, CPU-read buffers on
   the same GT without the workaround flags; the symptom there would
   be stale busyness stats rather than hangs. Now covered.

 * CPU-WC (matching i915's wording) is equally effective, but
   XE_BO_FLAG_NEEDS_UC currently drives both the CPU mapping and the
   GGTT cache mode, and naively switching to XE_BO_FLAG_FORCE_WC
   relaxes the GPU side back to WB and brings the stalls back
   (3 hits/20min measured).

His Tested-by on patch 3 is from v2; the only code change since is the
added engine activity coverage.

Two questions I would rather have answered than decide unilaterally:

 1. CPU mapping: keep the stricter UC as in this series, or add a way
    to express i915's exact combination (CPU WC + GGTT XE_CACHE_NONE)?
    The latter needs either a new BO flag or decoupling the GGTT
    cache-mode selection from XE_BO_FLAG_NEEDS_UC. No measurable
    throughput difference between the two.

 2. Scope: i915 applies the workaround to all media-GT shared memory,
    including LRC/ring state; this series covers the GuC-shared
    allocations only (CTBs, log, ADS, SLPC, engine activity). Should
    xe match i915's full scope?

I also left out Fixes:/Cc: stable, since MTL/ARL is still
require_force_probe in xe - happy to add them if you would prefer the
fix to reach stable kernels.

Validation of patch 3: two ARL machines (7d51 and 7dd1), ~4 weeks of
combined runtime, >7M TLB invalidations, zero stalls. Before the fix
both machines reproduced 20-60 stalls/day, every day, on every kernel
and on two GuC firmware versions. The 7dd1 machine, which could not
survive a day of media workloads on xe without a platform freeze, has
been running xe continuously for two weeks including video
transcoding, with zero incidents.

Patches 1-2 are the diagnostics that made the investigation possible,
unchanged from v2 except for a commit-message line wrap.

v2 -> v3:
- Rebased on drm-tip.
- Patch 3: cover xe_guc_engine_activity.c; document the coherency
  experiment and the UC-vs-WC tradeoff; add Suggested-by/Tested-by.
- Patch 2: wrap a quoted log line to silence checkpatch.
- checkpatch is clean on all three patches now.

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
 drivers/gpu/drm/xe/xe_tlb_inval.c           | 39 +++++++++++++++++
 drivers/gpu/drm/xe/xe_tlb_inval_types.h     | 17 ++++++++
 drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +
 12 files changed, 128 insertions(+), 33 deletions(-)

-- 
2.55.0

