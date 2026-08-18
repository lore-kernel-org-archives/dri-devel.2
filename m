Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503AAC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8BA10ED25;
	Wed, 19 Aug 2026 06:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="azHuhLR3";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8F410E00D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:25:51 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-8200ca16f26so67110747b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787066749; cv=none;
 d=google.com; s=arc-20260327;
 b=Zdz6kzaI8ysAgdNhLSsyLOJnVzGEK10dU9e1KmRPy0lCYM5shDqK6hWav2p+pg9akJ
 USksqSum1NgP/fHMgpqo+IMHg+xvPFB3rYNxgtiWHpdbNXcwqV9CotiGj/Er6qlbTtR/
 q5BjRtpZVmBaaFGZQHp9gBLHl7Z4NzY4zQc9DLb2WuW0pDJWUOGhfDoC5bTkMSWFxqaL
 I+TRGdk9yJ/ObLwxIN9Iw+etxgL5ku/VpGKLwP5AL0VpK3FNF/aEG3nrrLaBgMRcNLxO
 49MyAdcgGYyxsvkoQGxBct24OE5YmRw1Dsg3KjwwlHSpLi3L3oJ2CfX66vNdfaUSHwqw
 4Prw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G1FlOSu7ivJtDLb2bWkv9DL482AXJicMlDmui4P/8KM=;
 fh=rFt6SVo76UnTZnqSEbqNKA8AadHB88IALXwYRQLvgbI=;
 b=U71j1H3c1iO46BJVeTJ8wm/HJCI01+Yr4KIoZXluvi8Pc2U/nEhJY9CFsDWSJ0SfCw
 35jEDmmIX4c3eEuDiK/5lGcWz3U/hLGbPMrLWyEYE3aSGGIFVq5oEVyaN4Wkulx6vxwU
 2cH13OGfABHnestrkhW7zWx470HbLXHdNj2cwfKWf3pbwsPn3EwJW6R9J93gliUwkeEc
 1V5tb/uTqCddj9afRKKlySN6c0PXlpcTrEa/80/Fu+T/rnCYO2qRAag8aBnW23Eyaev7
 n6pkOwZqKgwLQwYivd10O1KIFUhO7V2jfIkhgauCU33qKIelvH2NcKS7QiAVjsiIGiq0
 2mew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787066749; x=1787671549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G1FlOSu7ivJtDLb2bWkv9DL482AXJicMlDmui4P/8KM=;
 b=azHuhLR3i2XHpail66UZwbNAXsFNuO/nztt9T4eDywSrxarJtQWIYm/sM6ty3yC74h
 XQBY1F9O/HXA1vlUcTIsk8hHRItDFHZ8K/QJGWnQ6VEOU9e2ncT1yQh7RKXqR2DPWVXQ
 oftHXXr5+jiDVlpodnyz42t9KTp+gFbQdvZX+gj7JKZTL1CqKHPRK2D/wA12GF8vE2pU
 r1yGp/DJhNJxIssb4NtB2xbYtA5GOVE6XOFjMXBIOQIgUAR5xfHvvcO6T72a78Lvaz/E
 G/uQ3dsNiRm6WPjNO6DBppYperA68dzRlAOviLmiwNRhIceJmYiLGhc7uJwz52Gy1+Og
 KyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787066749; x=1787671549;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G1FlOSu7ivJtDLb2bWkv9DL482AXJicMlDmui4P/8KM=;
 b=l4ZKIZN4MTC/MWJAOzjtSry3EPPJjILgZZ2n8qmGRPl7cKkCHRk8tgqUFnlDXRrT6q
 apDjPfCQsTXxUOejdrTc/hn4zxinc04DmvX3uUGBeYrltBe2DTehlV6foVonlYSnBgPy
 CrSRwRp3rXnp5MUaEbBVEpc/MNm2N+xvWTe9Em2gsFcanwrjhsoB2nqyczYt926n+oa/
 IJcMoXLXr4sJULQq6txKBHNLrD2pp0CPBZwiEq3GHpC9zwWHUXddxegkHk2h0x6JPa4Y
 zQbwl3owOnaFYF7ZmX1u/3kNvsmTfaxMSJvdf2kZRlPzvNz7gJHrHFKdqb+XnXTKpmOO
 zt3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJaDwHQSrwgUKtuD8HrXQEXa7guVHecxOGVQK/r9FZ15K9LLtGG2IobHnD1rcQAyxkc5j/swiw5J0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMQ0dRbGGsGNqrZFUCtI6/qkl/mhNKJM5jjC+SkBQAMrRgpUTG
 2IaxIuiQov15b8I78Ua3HXsXsF5b1ra0IoUlwolAc5k0TcqBrQX6QE5PBFSyfJoviLSZvIERj4J
 6MkfqNXLBMvzrb1smeRRgJw1c2Db6DYo=
X-Gm-Gg: AR+sD11zVourU7OdbHQPfbR4CSxyxSSCiJcGLZJe5azN8MvmihGmLtJvggnhzx9aTya
 qcvqHfKl3/CKEukeFgOO1bAVkHFamyHS9yIlCBmAIe/RDpKxYCKbHX7+8ltNMthqIU3Cti4qG3I
 Mv3lLCPvN2ZT54Tzk57yLgU4QzNO2XOae13UXq73ChlqGuba+06q/23ukgVrpdjhU/d4D/zUJ9F
 7waL6Jq/qJnkypzJnRRE+82pjKpNfWQtwrrLWuCkTzNzaBiZRht6IV5L9VKVnszig3Bvh0zaLTm
 L8ZOhlMB3anspPUAA7BI+HD0uY09fbYetM+QXz+Ekx5UH9RhToYylLgu3lg9gWUc7NW6wLBuU1t
 X7zVi0iWU0Q5I1B6IR0f1bIfckX2mZvDe+kFk3QSswQ==
X-Received: by 2002:a05:690c:c3a2:b0:816:b469:ccec with SMTP id
 00721157ae682-8412ed81021mr35451047b3.15.1787066749283; Tue, 18 Aug 2026
 08:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260813023016.805573-1-talesam@gmail.com>
In-Reply-To: <20260813023016.805573-1-talesam@gmail.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Tue, 18 Aug 2026 12:25:38 -0300
X-Gm-Features: AcwNN1Uq1vvVXXUSTEEyCTeL2d7Ad3PCBMgH9DazHLUva-cXSsmnQCADrzN4OXc
Message-ID: <CAHBRX4EwVmx2Nc6NWkt9Tu2Z0hPDKmqkFVoxYKDOh+bJKGUVuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/xe: fix GuC TLB invalidation ack stalls on ARL
 (Wa_22016122933)
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com, 
 stuart.summers@intel.com, julia.filipchuk@intel.com, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Gentle ping - anything needed from my side on this series?

Patchwork status so far: CI.Patch_applied, CI.Build and CI.KUnit all
green; CI.checkpatch has only the known warning for a quoted log line
in patch 2's commit message. The full hardware run does not seem to
have been triggered - could someone with permissions kick off the BAT
run on the series (patchwork series 172110)?

Meanwhile the two ARL test machines keep validating the fix: 17+
machine-days combined and >8M TLB invalidations since Wa_22016122933
was applied, still zero stalls - and the 7dd1 machine has now spent a
full week of normal use on xe (including plenty of video transcoding)
with zero platform freezes.

Thanks,
Tales


Em qua., 12 de ago. de 2026 =C3=A0s 23:30, Tales A. Mendon=C3=A7a
<talesam@gmail.com> escreveu:
>
> Hi,
>
> v2 of the TLB invalidation ack stall series for ARL, tracked in:
>
>   https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>
> The investigation concluded since v1: the GuC always replied in time.
> The CPU was reading a stale cache line of the G2H CTB - the GT1 caching
> bug that i915 works around as Wa_22016122933 and xe never inherited.
> Thanks Daniele for spotting the GT1 pattern in the GuC logs and
> suggesting the test, and Matt for the review and the guidance to mirror
> the i915 workaround.
>
> Patch 3 is new and is the actual fix: Wa_22016122933 for xe, scoped
> like i915 (media GT on media version 13.00) and covering the GuC-shared
> allocations the CPU reads from.
>
> Validation of patch 3 on two ARL machines (7d51 and 7dd1): before,
> 20-60 ack stalls/day, every day, for weeks, on two GuC firmware
> versions; after, zero stalls across 6+ days combined and >5M TLB
> invalidations. The 7dd1 machine, which could not survive a day of media
> workloads on xe without a platform freeze, ran 34h+ continuously
> including video transcoding with zero incidents.
>
> Patches 1-2 are the diagnostics that made the investigation possible,
> updated per Matt's v1 review.
>
> v1 -> v2:
> - Dropped the "kick" workaround (RFC patch 3): obsolete now that the
>   root cause is fixed by Wa_22016122933.
> - Patch 1: unified with the existing devcoredump path -
>   __xe_devcoredump() taking a GT plus nullable q/job, with
>   xe_devcoredump()/xe_devcoredump_gt() wrapper macros (Matt).
> - Patch 2: record the first timed out seqno instead of the last one,
>   and use xe_warn() (Matt).
> - New patch 3: implement Wa_22016122933.
>
> Based on today's drm-tip.
>
> Thanks,
> Tales
>
> Tales A. Mendon=C3=A7a (3):
>   drm/xe: Capture devcoredump on TLB invalidation timeout
>   drm/xe: Log when a timed out TLB invalidation ack finally arrives
>   drm/xe: Implement Wa_22016122933
>
>  drivers/gpu/drm/xe/xe_devcoredump.c     | 46 ++++++++++++++-----------
>  drivers/gpu/drm/xe/xe_devcoredump.h     | 15 +++++---
>  drivers/gpu/drm/xe/xe_guc.c             | 16 +++++++++
>  drivers/gpu/drm/xe/xe_guc.h             |  2 ++
>  drivers/gpu/drm/xe/xe_guc_ads.c         |  3 +-
>  drivers/gpu/drm/xe/xe_guc_ct.c          |  6 ++--
>  drivers/gpu/drm/xe/xe_guc_log.c         |  7 ++--
>  drivers/gpu/drm/xe/xe_guc_pc.c          |  3 +-
>  drivers/gpu/drm/xe/xe_tlb_inval.c       | 39 +++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_tlb_inval_types.h | 17 +++++++++
>  drivers/gpu/drm/xe/xe_wa_oob.rules      |  1 +
>  11 files changed, 124 insertions(+), 31 deletions(-)
>
> --
> 2.55.0
>


--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
