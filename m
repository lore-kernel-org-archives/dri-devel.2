Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC75C61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E1110EA50;
	Tue, 25 Aug 2026 13:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iEhHAq2l";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCE310EA50
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 13:19:45 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-4b28df1f600so3673745b6e.2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787663984; cv=none;
 d=google.com; s=arc-20260327;
 b=sqYJNTNA087P1y1q3ybE6TSkz3YZB9gfQbuK79X3SU/G40wqDInKKkN0iXTinpsewX
 6MMf5Ij7EU4iPj1gkdI+c4qf1JDqKgl/zJIRE4O/zDuo2WDrdnxKweZ60GvuOx9kRRuw
 XasGv4b48D51zFWP9vulBrvyp28femZVKVCXetYpDiK3Pm1S24B48ClEwfXjOFAvoIHV
 FcyGvagg/BnZQ8PaxdkUBI2edhs1yASzTCUXykSBwTR1b1BABK8DS42SiBo0df2Z6QRb
 ge5IgnKzIne8QNSSz5vfgRbPdPDiZ1OPrgdHkBwgYrQxNskp4vo2Y6W8P/uxgCvGEQxq
 6Fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ryafxuN2NVDXET22ji86N975MiFgQobw58o1y8zRykE=;
 fh=+x2JmX4jTY4CBWZKWWVSxHV7Fmb+y6lobmwVS+3J+bA=;
 b=bXBn+X6b48jrx6WyVSMOIZGTQwmqGNSRg6Zp0MzzgCUvrOJQCygkqWd9GYvES0s2zp
 OSEpj9tsKXwF1NgZyDnywJi8EofFooly+f2+m7Bv+tniIZEUQZD0WkvGR0cWB1NFQ8wq
 rs+/Yy7pMqe4PTMEsuFzQefSXQMyGVo9jSs6RPLR0MMBvWlLcAhjnv3XaASbxZS4ufHf
 tNxrDd9yaJjnutstzPtu1pz9WZeCu8g/HVzxLwTRdnFLrRA5sWx3S/wH+4pnJJd4pZdy
 y3ztBgp6HRju7D0OEwmPMPSxEinusu7tzXiIqYVl9Au+Ge47aziZ0yyv5d7VAah39uEW
 wUUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787663984; x=1788268784; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ryafxuN2NVDXET22ji86N975MiFgQobw58o1y8zRykE=;
 b=iEhHAq2lU+s8e84cRXuab68vg+F66cUm4UYkAS7IqNdKSSHcmvdvvrTJONBLEzERth
 SvaK1prNT6tX5g/rJfOmWL2asxZXE6shVerFuok2MmxHDIBOgGJLW8MlOwBJv9Frknrq
 uW08EOQbBOfpiFZu8mCzoHCZIzznphpTt6raGt/9YmSh5fg4wemYkY90Q4rjJxVzZ3Rd
 u4+HJmQVurfnNSonwCKRY2qRmyCPde5LbNuuaSvlOsum4V2j8rbMJaBJBtuPFTNsbA7f
 wODuh3i7YSdyjc/jkw8ZqQzRrWmGtbZgUffAhSbMMxKaqkIAFujHY0m9ACQHCPvRvtid
 kNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787663984; x=1788268784;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ryafxuN2NVDXET22ji86N975MiFgQobw58o1y8zRykE=;
 b=E6DwYG+8E1wF5k1i7l1z7QtnaRjQQrwUiac+fLFeYBcc/WPPE2X6Ntdke4dL4+ScUm
 dXSgyvDo4mOHhZi/TjACxmXfcPpTdmDK/2eEDGMePHEuq2U9gPMcQDblZTZMLcpQcpnJ
 nxAwyh7N6o9TVjPDd20tZ/O591LSET+YtPDksuDLgkvm4iufdk3ZipnNgyPQfLSkVUHz
 3HsriXRNQQzwz908sPwx8x8nziTrB6UMEcMjxALLkwb3+JHnWIRdXhwc0OWkN+3ujMSp
 M3ItK77xFMpRr48sz/9CFfuMsIldQ+X/Z6ng7v42iuhV9p6HWoFA4hSQBMqor2I0Gvjg
 57Xw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9+sh/d0GvlzzOV4QA6QcmVO2PKjasNlyDnB58oY4TzoRRolWx879N/turGiXJFs46Kzq/XmJwJ2E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkBJTc7lpz+1YVajfgeL1YU7Ua1+afKxvaM03tufK5esDBFbSf
 L2i1qxmObU0on2bXSlw99rNDjQRyLZq9w213jFNtQsvlKksHX2MUu6JRzx7cFtLWZ9mA3K0yC4F
 0IK5b0dUNJe+21vAGt9hyaHD+bP7edUU=
X-Gm-Gg: AR+sD13+cz91dgjy+ruvXiZW+9u8YinamP5o5+pngeeIrTUCHDUvf4oRBoUkES6epQv
 haPz3lt9qdVk6FqnfxSeatR31WiJdqbyF+KAf8L1mtrxbj15Ncn6TNjsHSNMkh6Ak2uNNAZVr24
 0jNFxmWR3fkA0EtDypCDs8g7QHYKmKaVVikH334KXL3i988VPgI6AFcGivTXCYbKXg+iNYMExnS
 iKnMKMw60NschSuNi9nGIdZjy83TKCd9CHjosrxW+3Lq3IFybZco9vsYNw0KjmS0T7oHfRAHXJU
 x/LQ6Ua9v8bBtVuV3UYfSqhfHOheexbwxXPe0tFZ2f/1v9MiGdwEj7ownQ9VL+6z6Ge1EvMo3u7
 p0k1r0kT4tuhLpPB7gxumFsstIsTDrg==
X-Received: by 2002:a05:6808:1a20:b0:4a4:934:b316 with SMTP id
 5614622812f47-4b350905f5dmr5794481b6e.21.1787663984073; Tue, 25 Aug 2026
 06:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260819185349.29407-1-pisarevden@gmail.com>
 <20260824153542.491012-1-pisarevden@gmail.com>
 <CADnq5_MEb72btY3NtbEVgZm=H_7OV6k1xC_t5YXVM_ONrZ2b3A@mail.gmail.com>
In-Reply-To: <CADnq5_MEb72btY3NtbEVgZm=H_7OV6k1xC_t5YXVM_ONrZ2b3A@mail.gmail.com>
From: Denis Pisarev <pisarevden@gmail.com>
Date: Tue, 25 Aug 2026 15:19:07 +0200
X-Gm-Features: AcwNN1W4Y2xRJrtZsVnUMey6eN7OnoZecn67lO3We9LtCVc1fE306t9_w-6Tonc
Message-ID: <CAMpx=TVt=iHo-Tj=3yFv+E0PKxMf+e-GO7oeMZMhLJCm4kKD_w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/1] drm/amdgpu: MMIO TLB invalidation fallback
 when KIQ is wedged after S4 resume
To: Alex Deucher <alexdeucher@gmail.com>
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

Hi Christian, Alex,

Understood regarding the fallback - dropping that approach. A working
KIQ after S4 resume is the real fix.

Regarding GFXOFF, I agree that a gated-off CP/ME/KIQ would also fail
the ring test, which aligns with the data. The ring test passes upon
resuming and sched.ready is set; however, the write-reg/wait-ack
handshake begins to fail during runtime, starting in the same second
as the thaw and persisting for hours (80-140 errors per hour, measured
over 9+ hours). So the KIQ initialises fine, but then stops completing
those packets.

The GFXOFF attribution comes from a single-variable experiment only:
same workload, one hibernation cycle each. GFXOFF held off across the
whole S4 cycle (disabled before hibernating and verified to be still
off after resuming): zero errors. Also zero errors over 15 minutes
after re-enabling it post-resuming. Plain S3 suspend never triggers
it. This is merely a correlation; I cannot prove that it is a
mechanism. The existing semaphore workaround comment in gmc_v9_0.c
about losing invalidate acknowledge state across power-gating cycles
appears to be relevant, but I cannot prove that. I am happy to run
whatever tracing is required to identify the mechanism from the
affected machine (RLC/ME state, gfx_off_state sampled at the time of
failure, KIQ fence timestamps and register dumps).

Thanks,
Denis

On Mon, 24 Aug 2026 at 20:31, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Aug 24, 2026 at 12:30=E2=80=AFPM Denis Pisarev <pisarevden@gmail.=
com> wrote:
> >
> > Hi,
> >
> > v3 addresses the two findings from the sashiko-bot review of v2.
> > Failure data and trigger isolation are unchanged (bugzilla 219492):
> > S4 resume on Cezanne (gmc_v9, GFXOFF) wedges KIQ TLB flushes at
> > 80-140/hour for 9+ hours with sched.ready true throughout; holding
> > GFXOFF off across the S4 cycle produces zero errors.
> >
> > 1. [High] "VFs and interrupt contexts silently drop TLB flushes once
> >    the threshold is reached" - correct, and fixed. In v3 the latch
> >    only reroutes bare metal process context to MMIO. VFs and IRQ
> >    contexts keep submitting to KIQ exactly as before this patch, with
> >    per-failure logging, because they have no MMIO alternative; there
> >    is no longer any code path that drops a flush without attempting
> >    and logging.
> >
> > 2. [High] "KIQ and MMIO race on the same invalidation engine if KIQ
> >    recovers" - this remains the documented open question; no code
> >    change in v3. Our analysis: once latched, this path submits no new
> >    KIQ commands, so the exposure is limited to already-queued stale
> >    commands and the recovery transition window. The engine serializes
> >    requests internally, so the realistic worst case is a lost flush
> >    request caught by the existing ACK timeout ("Timeout waiting for VM
> >    flush ACK!"), not silent state corruption. If maintainers consider
> >    a fence necessary (or a dedicated invalidate engine for the MMIO
> >    path), guidance on the preferred mechanism would be welcome.
> >
> > Full patch history: v1 (initial fallback+counter), v2 (GFXOFF hold,
> > per-instance counter, irqsave, VF/IRQ restrictions, MES error
> > propagation) - all from bot review; v3 (this one) fixes the VF/IRQ
> > drop regression the bot found in v2.
> >
> > Also still open from the cover letters: the alternative direction of
> > fixing the S4 resume ordering itself (RLC/ME vs GFXOFF) instead of a
> > runtime fallback. Happy to run tracing on the affected hardware.
> >
>
> If that's a problem, that should be fixed.  That said, did you have
> any success with the branch I proposed?
>
> Alex
>
> > Patch 1/1 follows.
> >
> > Denis Pisarev
> >
> > Denis Pisarev (1):
> >   drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
> >     unresponsive
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 123 +++++++++++++++++++-----
> >  5 files changed, 114 insertions(+), 33 deletions(-)
> >
> > --
> > 2.55.0
> >
