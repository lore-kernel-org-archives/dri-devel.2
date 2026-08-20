Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1486C5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 21:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E094510EBA5;
	Thu, 20 Aug 2026 21:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCJkZ989";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BE210EBA5
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 21:11:08 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-392af6bda98so30639a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787260267; cv=none;
 d=google.com; s=arc-20260327;
 b=D/agq2eGRaA9/vXBm/ULG4Zmw3uNftIP9fseT/j7FRa5ArB1Std92Hx4ZV0i8OueVG
 7Rj1a9bM1jG3p/WNgTWRCP6R67dYzcO251HgjVWuEJlSV6G2phyoCyC7IQ+zLDIlXdh6
 FY6vUo9gqfvc3TI5t0A+1ezeYl7bj7J7E1l5nVz5TanNuzK08SPGUYTBTU21wWys2OOD
 3YcB4e5gzCcXy8SPuYFIjnh+Ha2Rm+gcJMUFv3bSdZoVr1p0kKWBOPokFLJkPwG+aWTP
 hR9srBj6NmpwDWOA0L3rOUFrd3qTCij+dfCjjvHjmq3R7yw45XK6XJ52IkP5OoQ40s9J
 d+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+58ppq7/IWpYfDH5uV4f+qEE0t5tg8bvsSH5WVPCSWM=;
 fh=vSNvwtZ5v2K37V2HETQuNrY1ZEgsx1En8dsHa2LEx8M=;
 b=NVklixFjqXIDP53d7funl/4/Hog49f7Kqnm+lx9cpwB1s1CdUc7YBmFr/S1aRL24jl
 5YlaPem0wJDEC/CwocdQJiu94CzD0BJ6uXyLkHabqctiDS8tFC5WKmJFEiUFjuUCzISQ
 ezkixSWvZkGEPzfQ+jqnekLZoDyb52aQQgTfFAbFnXBdEOnAdIo4hswCy3yUDYFnWuOn
 /TDYzo+hPMzyi9Ptrm/9Ni4roOgho8+Fc3zjSwpEciU8jwLZo5xk736XBknVRksCtA2u
 7q+7bp2e4yjsbLceEWeQTpVUl17GZazMg5h9S8ygplisxl+aFZ0yiuzpwV2yxZFIALYw
 BgDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787260267; x=1787865067; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+58ppq7/IWpYfDH5uV4f+qEE0t5tg8bvsSH5WVPCSWM=;
 b=gCJkZ989CoT909pSCFzbTHUa+4pKMy7p1ONBhS1I+W0NhTqDU2sxDVomA27qsMNgMl
 DAayTzLVD7Slghu3eFYHQAJNNluM81WAYBI/yIEICme6h6pyP00Sd1Xq+CsdNbsjCOib
 b2m3FCmDAnYMNO0FVfbJYtzN7Ab4znjO40gq48A42ZgPoaGzWH4uBqRjgx2H1KQeywJW
 A5OEuFnujj8icuENStKAEY6NTbo6TiQjTutq2K0wn9y9okPAM6Kk9qoSG8eLDeWnjA64
 v6p/Qc0FjCvatJL43/y8kRbUEx3YVJY5DWOZbznezku+OH5oNW5Mtl1aSocFJQuAER8+
 kdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787260267; x=1787865067;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+58ppq7/IWpYfDH5uV4f+qEE0t5tg8bvsSH5WVPCSWM=;
 b=TPcYqy+uQllsQgVEBKVP+4zln9t57qoBpgd5XDHDfh2enETsMsGJVIh9p5PN8umTrh
 yOjzi35U5pnoxOAx1xLvDHtXCbKKjvZScQvsnAPa5ALKop6dpzRMek4BD9NNZiqcXIhF
 1mlIrgJu7eDZql604gjnhDE0wz+D58MKw1QtmK+PoOxCVlEtCAayWd1D5cvbGeLZM58u
 a8LYTGlDdrg4+GCXLHuIwXFDLhi3hVe+lMKSQU9kMYarglDjwp38h0/KmFXLBPdkcU1f
 Kryux5+ywzjUVMWz2ENMFpVHqHCM3XqOQTF1SG9dX8l7qEERfZLG8GZafclSWuQXwPwz
 NiwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RotGiPNpwHEHeG0cSeuJpg+7TumeeymqMUWU/uC6RJnmvkLViMTj6iHnHeP1EqaoKwoizpQHfIW26w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kec9Zz92qWuXRH9ZAUAa6VgJPJNSw9MEoCtgOjqkShLVU78WPR
 gFtu/kVTDyYV56fKn70mqO9l41dWkq2A6lgWP21W4rI1svx+JErBpmnE4oNH/0dG6pH7jYdLtaQ
 2hdTh/TUf2lMbk8s/48+guaeoPVbOy3c=
X-Gm-Gg: AR+sD10KepQHk6WBC5HpPFv2FoL1IbKyungaEfx5Disja4UTAJDuM/ZPbz9WHB4eWvG
 0odPnbUIrlw4WJ3NgmUZOcBkpFBqUgNoToIO7ysVxQ40xv+Hi8fRS2kY/ePHP3Ra3My8jLk/Zei
 xrMdElLs8shtmtIDSBrtGQCWFLsRSvj/Q8g/uoXuM5K2To7ZQpr0BX7M3ld+kVFxbHSHTgcs4S3
 Snn58xqz7VZVc/OcJBu5nQiBID9wYKBwwa+eOVxdHs/pOKvDy+y18UNCtqaoJM1+6Gg9S10hgnn
 DWiZEnuGxQL5457+hC6bUqlUb9zlfT+tiTMWR7wfTumuyGaZgHgYNRnxCqxTFmsykhOUmoSShg1
 1os7IC2gvbypiMR2+0rQxTFL6+0/eM5Y=
X-Received: by 2002:a17:90b:4484:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-395c33571d5mr1031283a91.1.1787260267517; Thu, 20 Aug 2026
 14:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260819185349.29407-1-pisarevden@gmail.com>
In-Reply-To: <20260819185349.29407-1-pisarevden@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 17:10:55 -0400
X-Gm-Features: AcwNN1Vai7aWO5WsKEL-otmSiwSsfGMkQzj2Cck3gdB3K6hYszYtDUormEy7lTs
Message-ID: <CADnq5_M5yrY+QW2-8phcYhZ7McE-zpFvDh9beZ6jvzTEH1A1xw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] drm/amdgpu: MMIO TLB invalidation fallback when
 KIQ is wedged after S4 resume
To: Denis Pisarev <pisarevden@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, mario.limonciello@amd.com, ionut_n2001@yahoo.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 19, 2026 at 3:30=E2=80=AFPM Denis Pisarev <pisarevden@gmail.com=
> wrote:
>
> Hi,
>
> This RFC follows up on bugzilla 219492 ("failed to write reg 28b4 wait
> reg 28c6" after hibernation) and on the resume_gpu_stable proposal
> rejected in January:
>
>   https://lore.kernel.org/amd-gfx/20260106125929.25214-6-sunlightlinux@gm=
ail.com/
>
> The rejection argued that (a) kiq sched.ready is managed correctly -
> set false in suspend, set true again only after ring tests pass on
> resume - and (b) the proposed flag would have disabled the KIQ flush
> path permanently. Both points are correct, and this RFC takes a
> different route: nothing is disabled proactively; the driver reacts to
> observed failures.
>
> MEASURED FAILURE MODE (Cezanne iGPU, Ryzen 7 PRO 5850U, 7.1.8, KDE
> Wayland, no ROCm):
>
> - S4 resume -> "failed to write reg 28b4/28c6" + "1a6f4/1a706" pairs
>   begin in the same second as the thaw and continue at 80-140/hour
>   for 9+ hours until reboot. kiq sched.ready is true throughout (the
>   ring test at resume passed).
> - Two user-visible consequences: each failed flush burns the ~5 s KIQ
>   retry window (desktop-wide sluggishness), and the invalidation is
>   then silently dropped (stale TLBs - correctness).
>
> TRIGGER ISOLATION (single-variable tests, one hibernate cycle each):
>
> - stock (GFXOFF allowed across S4):    ~70-140 errors / 30 min of use
> - GFXOFF held off across S4:                    0 errors (30 min)
> - GFXOFF re-enabled 40 min after the clean
>   resume:                                      0 errors (15 min;
>   gating resumption not independently verified)
>
> So the wedge forms in the S4 resume window while GFXOFF is allowed,
> and is consistent with the existing semaphore workaround comment in
> gmc_v9_0.c about losing invalidate-acknowledge state across
> power-gating cycles. A boot-time amdgpu.pg_mask=3D0 does not even
> initialize on this part (probe -ETIMEDOUT), so runtime debugfs
> control was used.
>
> THE PATCH (1/1):
>
> - amdgpu_gmc_fw_reg_write_reg_wait() returns -ETIME on failure and
>   counts consecutive failures
> - gmc_v9_0_flush_gpu_tlb() uses its existing MMIO path as fallback
>   when the KIQ submit fails (invalidations no longer dropped), and
>   after 3 consecutive failures skips the KIQ path entirely until the
>   counter resets - so wedged systems stop paying 5 s per flush
> - counter resets on every success and in gmc_v9_0_hw_fini(); each
>   suspend/resume cycle re-arms KIQ. No proactive disabling anywhere.
> - gmc_v10/v11/v12 call sites unchanged and compile-safe (int return
>   used as statement); extending the fallback to them is trivial once
>   the approach is agreed.

I think it would be better to get KIQ and MES out of the TLB path.  If
they get hung, we have bigger problems.  Can you give this branch a
spin?
https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref_typ=
e=3Dheads
It switches over to using SDMA and only falls back to MMIO if SDMA is
not available.  If you use MMIO, you need to disallow gfxoff before
you touch the registers over MMIO otherwise you'll hang GFX.

Alex

>
> This mirrors what the sibling PASID path already does (KIQ submit,
> -ETIME on timeout, MMIO variant as fallback), applied to the per-VMID
> path.
>
> OPEN QUESTIONS:
>
> 1. Root cause in the S4 window: RLC/ME not processing KIQ invalidates
>    while GFXOFF is allowed? Happy to run tracing (amdgpu.vm_debug,
>    VM_INVALIDATE ack registers) on the affected hardware on request.
> 2. Should the latch be per-xcc-inst?
> 3. Should amdgpu_gmc_flush_gpu_tlb_pasid()'s KIQ branch share the
>    latch?
>
> Patch 1/1 follows. Comments very welcome - especially on whether the
> failure-driven fallback is the right shape vs. fixing the S4 resume
> ordering directly.
>
> Denis Pisarev
>
> Denis Pisarev (1):
>   drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
>     unresponsive
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 +++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 18 ++++++++++++++----
>  4 files changed, 30 insertions(+), 9 deletions(-)
>
> --
> 2.55.0
>
