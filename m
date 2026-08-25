Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADBAC61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC9910E13C;
	Tue, 25 Aug 2026 17:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e//1o+yH";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1BB10E13C
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 17:20:42 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d590f4c291so292235ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787678442; cv=none;
 d=google.com; s=arc-20260327;
 b=VGrtnYjXUAbRwkeZ0yemjH5MSX6eJIbH19ZsuPUoPnvPV5zL9dJo+UkkvcT/WEaz76
 62VdjMHqk30ljPMIvLkKZlbi7lcVsCG/9xY5+I929UYcTvVREQP6496v3oPXFIYVyR3R
 UtCvD/EaqdI2y9L+nkPjOza4LNjTsH+LEUcCLf68KJe4CjtmmiEBsmevrL3DHc6mng9t
 OOQYzEGBPzs+KoaV7Z7TPkitkZwCvmxdLTRwReSh6BXjtxZdGmE+wbuum7dWa2ywEwo6
 6AxuxhrlqXS7MVIR3+a7JX6Z1W8WAKI8A5lddom0b5CkwCHW7mMv/VeV07hMm5l4/7Fl
 VX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nLiTTCZcAeBKpbQu/6NCsZ+pblUxK72kSDJNVj/ogIs=;
 fh=vK2sgxboLOOqVAE7LrQOPebnZyAA5Mat9j6dv/CL3QA=;
 b=MqatXk0Y3Slm1+0Rs4qWOYA1HcqzjGmzJlq/d3Hqu2Je9IWm0kgbS4/I13vqGuGz3t
 yC9RRUwJnWBGyWl/z6P6cwD9WOBlab4vxZwhGuFSh4MmWRicZboE+u0zkNTCzjn5GPIq
 xwNJgKSo14MvkKxj+SQln9dM05YyRlgoXY+FCk+Y9kfa1ZAUNKpoQql9zo4WpComFuyX
 4hxNiEifpI27eT04uMYWPfDN3Z6LkBA7R99Pm1EUsvfEbwgQ6b8txdAtB9jBIq7PDvxu
 X5sQ67mCSZcWAxePQgVzacAbYvfHKJDj5LuLw3VdfLB0y83UWxOYVNcrZej0ibJAkgEk
 MVZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787678442; x=1788283242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nLiTTCZcAeBKpbQu/6NCsZ+pblUxK72kSDJNVj/ogIs=;
 b=e//1o+yH+OIUZlshUjFepA6+ioCmCtKcmciYOnSf90Yle70Gl9X3YK54nnEa97hICA
 xuFr4xo5x1/Is8JrYov64cAhcXNDwQ9MXeW5Rp3pqfNLJ5+I0gZhMPY6xQAnXZuUTyJm
 de9uVKmIF8ZxjK6beoq/1YN8EANrvWXMA6Rz2O1+umpUNomKtmuz/xcCucKNY0/hqebl
 mkLlGsvXse/SAIb44s8GhjV3RUaGjxhmd84cIklVFp9VlgRvtrXEbvqJdPkJEmvtjXR+
 bZlRbwTAreTNXZ+hWUoXuJQQD8T1dqhZ3SXRQOMEvl8qtYzu59vKUzRPIXDXklL0skwY
 ik6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787678442; x=1788283242;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nLiTTCZcAeBKpbQu/6NCsZ+pblUxK72kSDJNVj/ogIs=;
 b=c4JJAZszFYynD/+JYTMdUAcC+32CZEhyu8XJeiMm7KKQndtUH2/38OZNu4GMZX6PfI
 6lo67mMVrM5qBhNs6yEufgpUFfnot/tZhdU+oWxEk77jYLJoveaf1AKlqf6tEXlUAd6k
 jtg+SgPnkyRKci581zTUVjdC6D+VzJgmJKKW6aQCcE/hCzzPg4Rtok4mtYAZ5FxNPw5l
 SP8mfyQomkbgw8kfHWa5XoxPOPKrZrHnSUVGut3bWThwxxxnCcnit3fv23J9LIAZGY6y
 WHy/ljge8ppUmpLuowuhlpIt03LK/+tCQRGKLcjwR3JusEH4XLKL9U6DzyfORxkf0kXQ
 NX5g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rodysb/gsaLV1X6zfGpY2pAlX1Lg7ZxOajwKgU+6Cb+PmrFsTZpiBSVCxjUxOugMcg6sF1uKx3UfOY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n/xSHXg56LY8+POXQ3OYKNKN2Zh/TR7LPixkUBfRg09eGoTliv
 IIOqMAcjghvaX4leZGQmmEmHsS0uJ1xiRF8exzyPwEAM+mez36rF97H6oto2MO/FGw41d60KJZW
 iZtaezgDg1tSfrz3aK2pkcqWv6EpagC4=
X-Gm-Gg: AR+sD132XqY5XbM7bPTnkD7SeZIsgX2zLLGiDKX31CaRbvzkanEDm/fRytca8KcLXz6
 wp2QKN1ofFKJ+sBxVAZhI6bo8nMvWZbcl22NZqSCXkceDj7HEeE+khGLkusk8tdvaCAq/Rpl88N
 faJXPPJyFhtuGgiDDaRTgFW7/9AAiSrTRB4xMHYHLkJhxJrBiKLEg6R7DsE2SPzecFYloRZkw9O
 x9rpYOXtixBhDb51VWQ6BYfEZU2iVYH9HtlXsvREhP1O/KV/4JwftF5uVnuzamr+RxC1mqugxei
 zqaZVRZo62vz9yUX0K1FjDIHXA1Ot4Mx1YvlxOQPWyNZn5Wwwgtg+5LiFH38dXAxQQhJKVUBYg4
 49MPaNiZ3tTRTW0wOZL6qUmFshbQxzr8nUJA+mqRGVw==
X-Received: by 2002:a17:902:ef01:b0:2cf:7dfa:7f56 with SMTP id
 d9443c01a7336-2d64aff2aa4mr328859625ad.2.1787678441811; Tue, 25 Aug 2026
 10:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260819185349.29407-1-pisarevden@gmail.com>
 <20260824153542.491012-1-pisarevden@gmail.com>
 <CADnq5_MEb72btY3NtbEVgZm=H_7OV6k1xC_t5YXVM_ONrZ2b3A@mail.gmail.com>
 <CAMpx=TVt=iHo-Tj=3yFv+E0PKxMf+e-GO7oeMZMhLJCm4kKD_w@mail.gmail.com>
In-Reply-To: <CAMpx=TVt=iHo-Tj=3yFv+E0PKxMf+e-GO7oeMZMhLJCm4kKD_w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Aug 2026 13:20:30 -0400
X-Gm-Features: AcwNN1VuarY_16AiENZhP1Qw0I_vEP7VUq_cHsjkmc-lWOdcOeZcayi6aAZiNhs
Message-ID: <CADnq5_PvB8BeQTGRowzF2jkdUOpEdXb7C7S-Y0tFiqJqCEHP4g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/1] drm/amdgpu: MMIO TLB invalidation fallback
 when KIQ is wedged after S4 resume
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

On Tue, Aug 25, 2026 at 9:19=E2=80=AFAM Denis Pisarev <pisarevden@gmail.com=
> wrote:
>
> Hi Christian, Alex,
>
> Understood regarding the fallback - dropping that approach. A working
> KIQ after S4 resume is the real fix.
>
> Regarding GFXOFF, I agree that a gated-off CP/ME/KIQ would also fail
> the ring test, which aligns with the data. The ring test passes upon
> resuming and sched.ready is set; however, the write-reg/wait-ack
> handshake begins to fail during runtime, starting in the same second
> as the thaw and persisting for hours (80-140 errors per hour, measured
> over 9+ hours). So the KIQ initialises fine, but then stops completing
> those packets.
>
> The GFXOFF attribution comes from a single-variable experiment only:
> same workload, one hibernation cycle each. GFXOFF held off across the
> whole S4 cycle (disabled before hibernating and verified to be still
> off after resuming): zero errors. Also zero errors over 15 minutes
> after re-enabling it post-resuming. Plain S3 suspend never triggers
> it. This is merely a correlation; I cannot prove that it is a
> mechanism. The existing semaphore workaround comment in gmc_v9_0.c
> about losing invalidate acknowledge state across power-gating cycles
> appears to be relevant, but I cannot prove that. I am happy to run
> whatever tracing is required to identify the mechanism from the
> affected machine (RLC/ME state, gfx_off_state sampled at the time of
> failure, KIQ fence timestamps and register dumps).

Can you try this branch?
https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref_typ=
e=3Dheads

Alex

>
> Thanks,
> Denis
>
> On Mon, 24 Aug 2026 at 20:31, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Mon, Aug 24, 2026 at 12:30=E2=80=AFPM Denis Pisarev <pisarevden@gmai=
l.com> wrote:
> > >
> > > Hi,
> > >
> > > v3 addresses the two findings from the sashiko-bot review of v2.
> > > Failure data and trigger isolation are unchanged (bugzilla 219492):
> > > S4 resume on Cezanne (gmc_v9, GFXOFF) wedges KIQ TLB flushes at
> > > 80-140/hour for 9+ hours with sched.ready true throughout; holding
> > > GFXOFF off across the S4 cycle produces zero errors.
> > >
> > > 1. [High] "VFs and interrupt contexts silently drop TLB flushes once
> > >    the threshold is reached" - correct, and fixed. In v3 the latch
> > >    only reroutes bare metal process context to MMIO. VFs and IRQ
> > >    contexts keep submitting to KIQ exactly as before this patch, with
> > >    per-failure logging, because they have no MMIO alternative; there
> > >    is no longer any code path that drops a flush without attempting
> > >    and logging.
> > >
> > > 2. [High] "KIQ and MMIO race on the same invalidation engine if KIQ
> > >    recovers" - this remains the documented open question; no code
> > >    change in v3. Our analysis: once latched, this path submits no new
> > >    KIQ commands, so the exposure is limited to already-queued stale
> > >    commands and the recovery transition window. The engine serializes
> > >    requests internally, so the realistic worst case is a lost flush
> > >    request caught by the existing ACK timeout ("Timeout waiting for V=
M
> > >    flush ACK!"), not silent state corruption. If maintainers consider
> > >    a fence necessary (or a dedicated invalidate engine for the MMIO
> > >    path), guidance on the preferred mechanism would be welcome.
> > >
> > > Full patch history: v1 (initial fallback+counter), v2 (GFXOFF hold,
> > > per-instance counter, irqsave, VF/IRQ restrictions, MES error
> > > propagation) - all from bot review; v3 (this one) fixes the VF/IRQ
> > > drop regression the bot found in v2.
> > >
> > > Also still open from the cover letters: the alternative direction of
> > > fixing the S4 resume ordering itself (RLC/ME vs GFXOFF) instead of a
> > > runtime fallback. Happy to run tracing on the affected hardware.
> > >
> >
> > If that's a problem, that should be fixed.  That said, did you have
> > any success with the branch I proposed?
> >
> > Alex
> >
> > > Patch 1/1 follows.
> > >
> > > Denis Pisarev
> > >
> > > Denis Pisarev (1):
> > >   drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
> > >     unresponsive
> > >
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
> > >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 123 +++++++++++++++++++---=
--
> > >  5 files changed, 114 insertions(+), 33 deletions(-)
> > >
> > > --
> > > 2.55.0
> > >
