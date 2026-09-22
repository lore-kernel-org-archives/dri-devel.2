Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F0BC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367F710EF58;
	Wed, 23 Sep 2026 07:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MB7zTjp6";
	dkim-atps=neutral
Received: from mail-vs2-f15.google.com (mail-vs2-f15.google.com
 [74.125.227.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A50F88C3D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:46:45 +0000 (UTC)
Received: by mail-vs2-f15.google.com with SMTP id
 71dfb90a1353d-5c981b0d59cso2674569e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790088404; x=1790693204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pQEnr/EicmnE9fouwie8yhLYFu1eRPi4qy1fbPXbXw0=;
 b=MB7zTjp6xi0En0kuvBEdh30jzURHq+XvThR0S2hOyKtwMemsuCjMZQxg5y89gQKCrz
 rG3mKIroLu9h7AhlyTqd4XA3NvP0bj7XWfUTRk4GoVRLCCMvlAxlXsxjrqp2C8L4sans
 cLIeD/uOErt4iVlbVhUsf84ttihFW783ypkw1IGQm4uWbxtBD0YAt0T5wNWvP+371Fzj
 JkA0myqvJ/Wpw9HIa8A/MwhYHoCqlRH7z0m0WrariKbzy2k1ZWk4PO/YdS5zM/Fjudz8
 ICgQgq1W1XEzrtVKpX7USiClhxpyN0sYOVsIP8VzvMYatXylcWWW8xmZeQ5JbhUUgfhs
 oafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790088404; x=1790693204;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pQEnr/EicmnE9fouwie8yhLYFu1eRPi4qy1fbPXbXw0=;
 b=qppcvoNrNCFV1R7xDAIPAB3RRhjq+qUzyK1arZGYgtEz/dDE962YgX7oEOm8YwfGt3
 3zoGztVNS2nAExDK86B3nbTka7uMq5Tq4i5vIWFpRV9RcCAPAlA35H0ZE0FDBsLSHAoX
 seDT4QagBaxQJXtt6Crq0S9zKOkSA+IjLP4qMx0VUOHB8WK3kSybm0cUCk9uy8Wxir+b
 ZHwGQJIBGUHA4Y5SWKO3MYd+3t/rdBiYCl3238DXdbF/+RF71wDYNkeOWJR7GcI47ejl
 fm1lGYXTuS2up9iQwnmGY/C3cZ13papqjL2vGMVSGqgVnzaAegDvhZrrhMDT+rYIwpbb
 5oJA==
X-Forwarded-Encrypted: i=1;
 AKwUvByb/HKXXHQXNHSA2Cow04ApjUYv33/3dkcjSQmzy0KBsRhQREDzwNG+njlh7GRSS5VCV9FxD5SWj/g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ns7oa8oTQMw7mQvLeGpaW1uAYfAKokw2ue1+CPQzU0RHmcKK2Z
 xrE6xauLIth7yY3nXxWHeAierK1qbCruTNApa7WIXl/Cd/41tnTjZanD
X-Gm-Gg: AYBFou1XsmTJ0jiYTURkmkvv7F9+gEmnn4wkAIxTjNygV3trDBOzSyj2Z5XanwLxTud
 Xq2LzkBVN6y2aGC8fWhsxNshDX2QkqCB7q8BBjIeb0Ju5vfxwYy1UFnnDU4UM+FYx7ZsXmqfsS+
 LvHl90KmB1XF/PVcsS2WciTXyPSkkkSWU3Pwt6ps7qVZwKFDjTlP8m2vspqYcvHUNPn4xq9l9sT
 TQEqt0jcHYDTsaZXfr4KTQ1wFB6gT5yBsgU5oGylI/TdeF8Rt/xR+XbDWPeKXe3ZuzLTCeOag4U
 gjBvpIoyy5JwVp4P3ZzP1mgLl02aXdDWzZ0TsseZOdMN0XqxdA0PwrLuKNy6uBIXrkGIlFY0QnI
 ie6BbB5aSzPrsNjsd091gkl1YG2f/w7wPYcumV0Fqe+rSQG/0yN/PY1uDo8vPx9IGEhzvDVZQ+D
 riHF3mAXubmh0RhMydEOtWbTBXCT7EnTfvwRePt22ih+qQ1gwNlHsp+yoMTBPULebDZ8LmIHRXV
 BkjZnieD+0ZiOuclYaKBHmpnZAvW3M01w+8TTbfqUAvUSiWP3WOkZzaf4BHx+s=
X-Received: by 2002:a05:6122:1b8c:b0:5c9:a60b:e5b8 with SMTP id
 71dfb90a1353d-5c9b599c8c3mr9484721e0c.17.1790088403930; 
 Tue, 22 Sep 2026 07:46:43 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.210.5])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9850d661d77sm2017067241.7.2026.09.22.07.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:46:42 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 jani.nikula@intel.com, navonjohnlukose@gmail.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v6 0/3] drm/xe: fix GuC TLB invalidation ack stalls on ARL
 (Wa_22016122933)
Date: Tue, 22 Sep 2026 11:46:31 -0300
Message-ID: <20260922144634.55130-1-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
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

v6 of the TLB invalidation ack stall fix for ARL. Tracked in:

  https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

The whole series now carries Matthew Brost's Reviewed-by - thank you for
working through it, including cross-checking patch 3 against the i915
implementation.

Recap: on the standalone media GT of MTL/ARL the CPU reads stale cache
lines for data the GuC has already written. The visible symptom is TLB
invalidation acks appearing to stall for a near-constant ~2.3s. i915
works around this as Wa_22016122933; xe never inherited it. Patch 3
implements it, applying XE_BO_FLAG_NEEDS_UC to the GuC-shared
allocations (CTBs, log, ADS, SLPC, engine activity) on the standalone
media GT, scoped by a new OOB rule (22016122933 MEDIA_VERSION(1300)).

The one code change since v5 is in patch 1, from a second issue Sashiko
raised: the capture could run without a runtime PM reference. Every
pending invalidation fence holds one, taken in
xe_tlb_inval_fence_init(), and xe_tlb_inval_fence_signal() drops it via
xe_tlb_inval_fence_fini(). The timeout loop signals the expired fences
and only then calls xe_devcoredump_gt(), whose forcewake acquisition has
always relied on the caller holding a PM reference. If those were the
last references the device could begin autosuspending before the
snapshot touched the hardware. v6 takes a reference while the pending
fences still guarantee the device is awake, and releases it after the
capture. Matt confirmed the analysis and the fix on the list.

I am carrying Matt's tag on patch 1 across that change since he reviewed
the fix itself, but flagging it here so it is not silently inherited.

Two open points from earlier revisions, both now settled:

 - LRC coverage: i915 also marks the LRC UC on non-dGPU
   (__lrc_alloc_state()). That does not match the erratum's direction -
   LRC writes come from hardware context save and the GuC reads it -
   and Matt's guidance was to leave i915 alone and treat it as out of
   scope for xe.

 - SIGID: the TLB logging in patch 2 will be converted once a TLB
   component exists in DEFINE_XE_LOG_COMPONENTS(); a colleague of
   Matt's volunteered to do that as a follow-up on top of this series.

Two notes carried over, still open to either answer:

 1. CPU mapping: keeping XE_BO_FLAG_NEEDS_UC (uncached on both sides).
    It is the tested configuration and no throughput difference against
    the CPU-WC variant was measurable. Matching i915's exact CPU-WC +
    GGTT-UC combination needs either a new BO flag or decoupling the
    GGTT cache-mode selection from XE_BO_FLAG_NEEDS_UC; happy to add
    that plumbing if parity is preferred.

 2. Fixes:/Cc: stable are left out, since MTL/ARL is require_force_probe
    in xe. Also happy to add them.

Validation of patch 3 is six weeks on two ARL machines (7d51 and 7dd1),
across kernels 7.1.6, 7.1.8 and 7.2, with over 10M TLB invalidations
processed and zero ack stalls. Before the fix both machines reproduced
20-60 stalls/day, every day, on two GuC firmware versions. The 7dd1
machine, which could not survive a day of media workloads on xe without
a platform freeze, has been running xe full time since 11 August with
zero incidents.

checkpatch is clean, except for one --strict CHECK about macro argument
reuse in the xe_devcoredump() wrapper in patch 1, which is intentional:
the macro only exists to forward (_q)->gt alongside _q.

v5 -> v6:
- Rebased on today's drm-tip; builds clean, no conflicts.
- Patch 1: hold a runtime PM reference across the devcoredump capture
  (second issue reported by Sashiko, confirmed by Matt).
- Patches 1-3: collected Reviewed-by from Matthew Brost.
- Patches 2-3: otherwise unchanged.

Thanks,
Tales

Tales A. Mendonça (3):
  drm/xe: Capture devcoredump on TLB invalidation timeout
  drm/xe: Log when a timed out TLB invalidation ack finally arrives
  drm/xe: Implement Wa_22016122933

 drivers/gpu/drm/xe/xe_devcoredump.c         | 46 ++++++++++--------
 drivers/gpu/drm/xe/xe_devcoredump.h         | 15 ++++--
 drivers/gpu/drm/xe/xe_guc.c                 | 16 ++++++
 drivers/gpu/drm/xe/xe_guc.h                 |  2 +
 drivers/gpu/drm/xe/xe_guc_ads.c             |  3 +-
 drivers/gpu/drm/xe/xe_guc_ct.c              |  6 ++-
 drivers/gpu/drm/xe/xe_guc_engine_activity.c |  6 ++-
 drivers/gpu/drm/xe/xe_guc_log.c             |  7 ++-
 drivers/gpu/drm/xe/xe_guc_pc.c              |  3 +-
 drivers/gpu/drm/xe/xe_tlb_inval.c           | 54 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_tlb_inval_types.h     | 17 +++++++
 drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +
 12 files changed, 143 insertions(+), 33 deletions(-)

-- 
2.55.0

