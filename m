Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1CEC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F185610EB97;
	Tue,  1 Sep 2026 07:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ObZgXNnL";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D4110E2ED
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:01:12 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-836cb2fa1bcso33721467b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788192071; cv=none;
 d=google.com; s=arc-20260327;
 b=B4qt67BLsEs5/LyP7MWhPjLAcEJTWbjgEawscFWZAxma3B2F3jQWpXK0/xJ5p3Ik1r
 9X8FQ2LjSr8VjwwzFLC9QRegednIHquu+PvUh4pqYt10m2aF5aJ6iCB+c6g4LMAaGWf8
 2n7Dj4gJ5dYzb6ZFA9T9p/kF1LkCyMpWX9fWGiXskkpSVV5hnrw5Qf9s/jKloFt/gSr7
 eD3GLfh0/9pkj8aFgGQekKJBvfbMOkp8Qw/wZ9Uam1K3aWnSwPLBD31cfLgKspPIqvmJ
 t6cZvNTXhrWlWtIwgOHH/K76X7VclQRUClcWWnjqbytRBo6cOhXU5Ugh2hySyrwc4cLM
 ZVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ESNV4ph15b9j2FbSLaZw6uJteHQDQdNhxnbMXCIu30E=;
 fh=y2EEibh/0USRl/U8uVzKcVXyO9ya7r0ylmYXALKiC0s=;
 b=SE3+xpUbilShtCmgF699NbEytVRnqWIpy06NvzWGoF4yJ87uuz6sl+vHnOD1cMRCTe
 RuGquTN7MhsjiILOfX3xQ3QG16CWocZnC/he7z8vq9PllxfcyL8sZ1eorz0AoJcnpGYs
 KDuTkSQT/d4PhC85bSMuvU1XEVgkybyIYkSdC78CGXMTWWuYIkOLW0lIKR1hhGhmvXeD
 rpKNK9XGmloEcrRQcTS5vdSo+zpIxgxwXsC+oMFho1Uh8usuReq01K2AePGJpFgDpnLp
 OmPOHJx2F2SpLoFcubIsTAwJJWEnt7AGZ9lGSc+SgDZGrlJ6InAGe87SkcOC1yU37pOh
 vaqQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192071; x=1788796871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ESNV4ph15b9j2FbSLaZw6uJteHQDQdNhxnbMXCIu30E=;
 b=ObZgXNnLfipWu74x4tsP0hTBMRNmNBriIobfuhrCrjo+eGXyVRXdXOhIIAJgvnXHm3
 0B2Ayya81P7gVrRGoJq5V4qtzv8/GeYCfV36OqNPlx5zsjA8uXvKUepFsmGuvTirmkDc
 grq3DQOFWeXEtOwGfeW/2nyUGCeLAGlPZ3OWFjd2uODCVkDxDXgXA2/d5I/zoqOjhA2D
 3W2/pgeV5DAH0J9EXLtVs+eB+ccNtZv3zEafzJPMj97MvpA1qZj6qkkKvO42r9qcp75X
 nwB4yJhtJgFQwfylFkX3bQBfLfatGuUY/k/6k472zZAI6sBr4WsmCEYJMbHwiqlSHQxu
 XRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192071; x=1788796871;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ESNV4ph15b9j2FbSLaZw6uJteHQDQdNhxnbMXCIu30E=;
 b=miYVzNPAzOq/Add/d19oMc2kBUHqSXUsoqyW1nZUySXQysavK9C7lm4XsqTevw4lAf
 8YOmpxqBBgIzpvw7lH5PP+ktNM4UEcJTIOgt9Ur2lgXyn9nCUD3aDjTNyHVT6A10anfy
 MccCtYrDnd5yvTUmDIhCeNPqcbixMkus+L1z2vcoUvPe64RrATQI1mfEhE55QUj3D/fx
 UABSmX2DEWWaSkr83ZByYWy/gLyBZ8xtvY54ygEmD4+WPfQjnnQ3tg6wywG7YBF57yA3
 rHudQWUB6iVJFbt//ariLSbMipBV0Er5JcXNCcp08GQCSZX2nSvlC3Ymrk15OpWOra9i
 eDxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb7hqToAozXsgErj5h49hYH0UuyvW2d/WjAnO6NVVjHtQJGCWKKn5xo+e1+2VJQVNsJV9Dfep8jr8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nSSIFKMGcXHBjjC2N87d0GOudzEcY90Kr5wZl1sM3SmWSqo31S
 At991n27JRwiSQmfIjIHUNJ2W+Ko2AiYaCMNGmT/yHJvWELqTA2k8T3iBcSox0qHZA9v9nsZsDv
 BlebaE4bLqSJedDjGRgbT13uqGunea4Q=
X-Gm-Gg: AYBFou0S52XJ9oZCLvq/fZ0B9wVbJgYPUhf6HHWupcBSFGoPGdwgQyUG6WfTec9v2Pn
 toDZlVQcccf3aN5wC2EuVToRpBgV9k/3mEj9Penu+wFI2bRjAhz+msqX0D/VzaK1Gp5mbLz/Fgf
 kFX5o1bkgUn5L5ibc6QvNOkchsCvBi+OglEJTuTdoWXyxcsqoDDDXCfGyr5BO4J632itCShfD+3
 gOGk/5lmmtHnhqocoYjBxLud0l6TmiIM1kqMtROLxf33GZXgIHAc+mMs3kZ+OFfYOf6yT4ztFsO
 e3nfBxKapnjflDvzjyHMfbjZNo9GIZU/WzpTkCg0gQnon4zrBX+68DDuRXYeJPs2autypyeLstc
 +UW9alcrfTcOvc/EJBWLkK0fN87dvvbuh
X-Received: by 2002:a05:690c:a583:b0:81e:ae6f:ac0a with SMTP id
 00721157ae682-85d6ee0a27dmr75676847b3.24.1788192070682; Mon, 31 Aug 2026
 09:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260824140748.54974-1-talesam@gmail.com>
In-Reply-To: <20260824140748.54974-1-talesam@gmail.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Mon, 31 Aug 2026 13:00:58 -0300
X-Gm-Features: AcwNN1VQIGgx0fRQI5CTNMwuvZJlwR-D_D7e2bl7IOjwdjqhvPvytoYuUezr-64
Message-ID: <CAHBRX4G2OEk2gDvpbDTt_NDWteSzngmU2E+9hGKFP9h=aBpd4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/xe: fix GuC TLB invalidation ack stalls on ARL
 (Wa_22016122933)
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com, 
 stuart.summers@intel.com, julia.filipchuk@intel.com, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 navonjohnlukose@gmail.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

Daniele, Matt - now that rc1 is out, could you weigh in on the two open
questions from the cover letter? They are the only things I am unsure
about, and I would rather follow your preference than guess:

1. CPU mapping. This series uses XE_BO_FLAG_NEEDS_UC, which maps both
   the CPU side (uncached) and the GGTT side (XE_CACHE_NONE). i915
   documents the workaround as WC on the CPU side and UC on the GPU
   side. A CPU-WC variant with the GGTT side left at XE_CACHE_NONE was
   measured to be equally effective, but expressing it needs either a
   new BO flag or decoupling the GGTT cache-mode selection from
   XE_BO_FLAG_NEEDS_UC - swapping in XE_BO_FLAG_FORCE_WC alone
   silently relaxes the GPU side back to WB and the stalls return.
   Keep the stricter UC, or should I add the plumbing for i915 parity?

2. Scope. i915 applies the workaround to all media-GT shared memory,
   including LRC/ring state; this series covers the GuC-shared
   allocations (CTBs, log, ADS, SLPC, engine activity). Should xe match
   i915's full scope?

Either answer is a small change; I just do not want to pick the wrong
one unilaterally.

Meanwhile both test machines have moved to 7.2 with this exact series
applied (previously they ran a cruder CTB-only variant), and the
workaround shows up where it should - present on the media GT's OOB
list, absent on the primary GT:

  gt0/workarounds: (no 22016122933)
  gt1/workarounds: 22016122933

Still zero ack stalls on either machine. The 7dd1 machine, which used
to freeze under media workloads on xe, has been running xe full time
since 11 August, including a day with 16 video transcoding sessions,
with no stalls and no freezes.

Thanks,
Tales

Em seg., 24 de ago. de 2026 =C3=A0s 11:07, Tales A. Mendon=C3=A7a
<talesam@gmail.com> escreveu:
>
> Hi,
>
> v3 of the TLB invalidation ack stall fix for ARL, tracked in:
>
>   https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>
> Root cause recap: the GuC replies in time, but on the standalone media
> GT the CPU reads a stale cache line of the G2H CTB - the caching
> erratum i915 works around as Wa_22016122933 and xe never inherited.
> Patch 3 implements it, scoped like i915.
>
> Since v2, Navon John Lukose A/B tested the series on an ARL 7d51 and
> produced three results that are folded into this version:
>
>  * Making the mapping coherent instead of uncached does not work: a
>    GGTT PAT entry repurposed to WB|COH_2WAY still stalls
>    (request-to-ack 2290ms). Now documented in patch 3 - it is the
>    obvious question to ask about this patch, and the answer is
>    measured rather than assumed.
>
>  * xe_guc_engine_activity.c allocates GuC-written, CPU-read buffers on
>    the same GT without the workaround flags; the symptom there would
>    be stale busyness stats rather than hangs. Now covered.
>
>  * CPU-WC (matching i915's wording) is equally effective, but
>    XE_BO_FLAG_NEEDS_UC currently drives both the CPU mapping and the
>    GGTT cache mode, and naively switching to XE_BO_FLAG_FORCE_WC
>    relaxes the GPU side back to WB and brings the stalls back
>    (3 hits/20min measured).
>
> His Tested-by on patch 3 is from v2; the only code change since is the
> added engine activity coverage.
>
> Two questions I would rather have answered than decide unilaterally:
>
>  1. CPU mapping: keep the stricter UC as in this series, or add a way
>     to express i915's exact combination (CPU WC + GGTT XE_CACHE_NONE)?
>     The latter needs either a new BO flag or decoupling the GGTT
>     cache-mode selection from XE_BO_FLAG_NEEDS_UC. No measurable
>     throughput difference between the two.
>
>  2. Scope: i915 applies the workaround to all media-GT shared memory,
>     including LRC/ring state; this series covers the GuC-shared
>     allocations only (CTBs, log, ADS, SLPC, engine activity). Should
>     xe match i915's full scope?
>
> I also left out Fixes:/Cc: stable, since MTL/ARL is still
> require_force_probe in xe - happy to add them if you would prefer the
> fix to reach stable kernels.
>
> Validation of patch 3: two ARL machines (7d51 and 7dd1), ~4 weeks of
> combined runtime, >7M TLB invalidations, zero stalls. Before the fix
> both machines reproduced 20-60 stalls/day, every day, on every kernel
> and on two GuC firmware versions. The 7dd1 machine, which could not
> survive a day of media workloads on xe without a platform freeze, has
> been running xe continuously for two weeks including video
> transcoding, with zero incidents.
>
> Patches 1-2 are the diagnostics that made the investigation possible,
> unchanged from v2 except for a commit-message line wrap.
>
> v2 -> v3:
> - Rebased on drm-tip.
> - Patch 3: cover xe_guc_engine_activity.c; document the coherency
>   experiment and the UC-vs-WC tradeoff; add Suggested-by/Tested-by.
> - Patch 2: wrap a quoted log line to silence checkpatch.
> - checkpatch is clean on all three patches now.
>
> Thanks,
> Tales
>
> Tales A. Mendon=C3=A7a (3):
>   drm/xe: Capture devcoredump on TLB invalidation timeout
>   drm/xe: Log when a timed out TLB invalidation ack finally arrives
>   drm/xe: Implement Wa_22016122933
>
>  drivers/gpu/drm/xe/xe_devcoredump.c         | 46 +++++++++++----------
>  drivers/gpu/drm/xe/xe_devcoredump.h         | 15 +++++--
>  drivers/gpu/drm/xe/xe_guc.c                 | 16 +++++++
>  drivers/gpu/drm/xe/xe_guc.h                 |  2 +
>  drivers/gpu/drm/xe/xe_guc_ads.c             |  3 +-
>  drivers/gpu/drm/xe/xe_guc_ct.c              |  6 ++-
>  drivers/gpu/drm/xe/xe_guc_engine_activity.c |  6 ++-
>  drivers/gpu/drm/xe/xe_guc_log.c             |  7 +++-
>  drivers/gpu/drm/xe/xe_guc_pc.c              |  3 +-
>  drivers/gpu/drm/xe/xe_tlb_inval.c           | 39 +++++++++++++++++
>  drivers/gpu/drm/xe/xe_tlb_inval_types.h     | 17 ++++++++
>  drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +
>  12 files changed, 128 insertions(+), 33 deletions(-)
>
> --
> 2.55.0
>


--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
