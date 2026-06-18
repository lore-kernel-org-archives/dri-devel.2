Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B11CD98F6
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724F410ECC0;
	Thu, 18 Jun 2026 06:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MnXpvPmd";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFF710ECB3
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 06:45:11 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7e6e9408e30so545130a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 23:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781765111; cv=none;
 d=google.com; s=arc-20240605;
 b=lpb00oFRe3VZ9Ux2y/IefVfsbLTZ2SkT0DMDAyPXmnidFE3yFwxhCG3LSAuKNB9KB9
 Tvfmf0nr7nVKhHb+ZqFBkiWkWjNpfhZyQJFiGNBGNruLsI6Rr/enaEp+bcvbwDgp4Nl2
 gv51R5yTfuKye4bwauCOdpYUfaP9okxaISUqeWianGKAJX5gltAODyMw09jSH5XG5g5u
 4WjAhXG1P+Dx48U6B68kBgAHoGbQlh2PxXJoOyiNDhpXaJZubTygUK4TtBPbafoGy/3A
 CLtTX/nQdHqM3qU6Ggs2bd6s2VpiRs57TPXBAVTQyOVLoC6b7R4P7E9lGSoAwvYMlIcf
 Ck/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Aw7+Ysr8IWme6YKCtFAf4Wtx49VGl1R8xVbGoroEzf4=;
 fh=1ANcksFQ8byr9OCZkB9UeyFhQNT99Z2aR8Bb6CgP//E=;
 b=R/znkaqJxsq68J4TYlKZpVTjK1+6ivVwuIOFFo2tH2RQX89359Sj55+2AqK8PXw350
 RtQW8GVYqWWr9FV10oEAlfKQQuA92gZp0qBzyBwUm0fzweHFJhfge4lJjZgJKWlheuO3
 Nx5TqhNLBqfVjUg7VqGGmisWF+hg6y7MjUSs/XOBNnwRBN0oSRqYFaqXBKZY9YcHl7dr
 t+Yb9jlpkBEEFD/agSABw9EBUPerpsjZA0LgtWiybVClBhiaziM3BaJE7lgYVQO6Bf1S
 nwY2x/KThFSyBNX8kW+b+uyPmSGmCCqi+hvYvFJqOMpbl5Oph1cl7cAuHka7/QZebrAC
 uOFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781765111; x=1782369911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aw7+Ysr8IWme6YKCtFAf4Wtx49VGl1R8xVbGoroEzf4=;
 b=MnXpvPmdmQSmpg6ChUC6walwZfV0M2fv0eTAQdXZm/c2Ukj6zSLFAyKTOiDmFD5oXc
 2Fm/VV1ag31HjrpGlj3sAAwAnUm7BIDi3rroiMnFrXelDJhCy1RZvZsy+QYAUYtUuvhJ
 X19KPJ2gusxBSl4hDZLhPGERnPF9Y24AY65vCRCIXj0/utvbL/eYBqSjRR7wcbrup3Al
 GEpUv1j0yvXMJmzQBMnFdwS2VwV6XaYyAcmTIjWATEryiGWRznMUludGwBI2jOEwFAVk
 byl3GnrAHA5dNwF1zlpFhzNdb4JhiXkxxy3mmAHGHHczYnNqNZBBPztD3ez/fvIQdmbu
 OUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781765111; x=1782369911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aw7+Ysr8IWme6YKCtFAf4Wtx49VGl1R8xVbGoroEzf4=;
 b=qGT2qNOiP1b7Bc3uqZTKV296FlBsmHiphnGdwjwFZowV6uB2P08XnodSNcMLHpXJdu
 w/jQ9fNgaO7dUfzxSUNlQuzPlezvuG1kMAWE1Z/iZKeDmHVipqF2Dm/ChX6isePWh0+e
 RUygjajDYY27ZkaUrC5GEa6K8ceqMuaObDpu6zRSiu5+qw076OePqKmc/fkycQKG/sRg
 8tFK4oMJOfw7QUYMINEZEssLVTNKx+GdJwhEBvsZ1vsEyR0vmfpv3qbN1TL7A2PPjMxc
 lgtyy2zweajbMAodkhL2Zy8EGaYB19dAzgjo/e5CwzVV5tuJa1D8CLJ802XgHkhFVcKX
 2niQ==
X-Gm-Message-State: AOJu0YyYbyUilsT8BdjugsptznVHCctq/+8N4acchNsbPZbCC3460pus
 kBgwBQwwqpdzI7sn9rYhlEIKNVEC1l9WypmALchDNmUwNYdx66KmLcaQY9MxdIun8QyFy0rxTTC
 EgIBpkn7begRWcro1e6Gr78B7mLoJeDs=
X-Gm-Gg: Acq92OHBMA84IYDWgCkaq0Q54x6urGgPTChk+31RqGT18HLpez+p54v/QrUnZ1lcA54
 /LI/4wRqMgPHslGQd/ToJez+25csM4/rvnYWX4MpzM9pGJpOx0T3WuzXv61J5/fnLSFMOOaOPnX
 CT/ZJrCFv6abZ937HIX6DXBSkSwBRnm4QdERc6kjRYhG6bduM1chDfR9ZRNOhuzZrwfMqIQDNF8
 wMSxb5Vw1mfJNACHKItTjoFCXkG9IOdAcdiuf849fI8wi73sHuYI8bOn3NWwm/dz7laYAqRn0M=
X-Received: by 2002:a05:6830:6d4f:b0:7dc:df37:844b with SMTP id
 46e09a7af769-7e91c0fbf54mr2313833a34.4.1781765110831; Wed, 17 Jun 2026
 23:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260618055216.56191-1-mikhail.v.gavrilov@gmail.com>
 <20260618061728.75BDF1F000E9@smtp.kernel.org>
In-Reply-To: <20260618061728.75BDF1F000E9@smtp.kernel.org>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 18 Jun 2026 11:44:58 +0500
X-Gm-Features: AVVi8CcdRAiVNAPkl0B3_vJtXygoy8kBQDI2uhJDlcKLkPHtrH-T6C0HJWVrOP8
Message-ID: <CABXGCsNgUaSkfLw1Nn7-BzD2LBUqscQJtce0Wk6F9pK0+Y6Zyw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: do not enter fs_reclaim under notifier_lock
 in lockdep training
To: sashiko-reviews@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Thu, Jun 18, 2026 at 11:17=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Removing the `fs_reclaim` lockdep annotation silences a true-pos=
itive warning about a real ABBA deadlock between memory reclaim and GPU res=
et, rather than fixing the underlying bug.
> --
>
> commit 4896f663f62249014930226b2bc964c2419486d0
> Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>
> drm/amdgpu: do not enter fs_reclaim under notifier_lock in lockdep traini=
ng
>
> The commit removes the fs_reclaim_acquire() and fs_reclaim_release() call=
s
> from amdgpu_lockdep_init() to silence a circular locking dependency warni=
ng,
> claiming it is a false positive.
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_lockdep.c
> > index d5d71fd7c70d0..eeb3b5007f80f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> > @@ -150,12 +150,6 @@ int amdgpu_lockdep_init(void)
> >       /* Level 6: Reset control lock */
> >       mutex_lock(&reset_ctl.reset_lock);
> >
> > -     /*
> > -      * Mark potential memory reclaim boundary.
> > -      * GPU operations might trigger memory allocation/reclaim.
> > -      */
> > -     fs_reclaim_acquire(GFP_KERNEL);
> > -
>
> [Severity: High]
> This is a pre-existing issue, but does removing this lockdep annotation
> silence a true-positive warning about a real ABBA deadlock?
>
> While the circular dependency might not happen in the same thread, couldn=
't a
> cross-thread deadlock occur between memory reclaim and GPU reset?
>
> For example, if Thread A executes the MMU notifier amdgpu_hmm_invalidate_=
gfx()
> (e.g., during direct reclaim), it acquires adev->notifier_lock and blocks=
 in
> dma_resv_wait_timeout() waiting for a hardware fence:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c:amdgpu_hmm_invalidate_gfx() {
>         ...
>         mutex_lock(&adev->notifier_lock);
>         ...
>         r =3D dma_resv_wait_timeout(vm_root->tbo.base.resv,
>                                   DMA_RESV_USAGE_BOOKKEEP, false,
>                                   MAX_SCHEDULE_TIMEOUT);
> }
>
> If Thread B (the GPU reset thread) takes down_write(&adev->reset_domain->=
sem)
> to reset the GPU and signal the fences, and performs GFP_KERNEL allocatio=
ns,
> it could be forced into direct memory reclaim (fs_reclaim). This would in=
voke
> the MMU notifier, attempting to acquire adev->notifier_lock, forming a cy=
cle.
>
> Would it be better to fix the underlying deadlock by wrapping the GPU res=
et
> path with memalloc_noreclaim_save() or memalloc_noio_save() to prevent it
> from entering memory reclaim, instead of removing the lockdep annotation?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618055216.56=
191-1-mikhail.v.gavrilov@gmail.com?part=3D1

The reported splat is not the reset/reclaim deadlock described here.

It is single-threaded: kswapd holds fs_reclaim and the mmu_notifier range,
then takes notifier_lock in amdgpu_hmm_invalidate_gfx(). That is the normal=
,
mandatory direction fs_reclaim -> mmu_notifier -> notifier_lock. The MMU
notifier callback runs from inside reclaim, so notifier_lock is acquired
below fs_reclaim and is never held across a reclaiming allocation.

amdgpu_lockdep_init() asserts the opposite edge, notifier_lock -> fs_reclai=
m,
by calling fs_reclaim_acquire() while notifier_lock is held. That edge does
not occur at runtime, so the reported cycle is a false positive. Dropping t=
he
annotation removes the impossible edge and touches no real lock.

On the cross-thread reset case: if the reset path really holds
reset_domain->sem across a GFP_KERNEL allocation, lockdep learns
reset_sem -> fs_reclaim from that real allocation, not from this annotation=
.
The fs_reclaim_acquire() here adds nothing for that real edge; it only inje=
cts
the impossible notifier_lock -> fs_reclaim one. And because it fires on the
innocent kswapd path, it calls debug_locks_off() and disables lockdep for t=
he
rest of the boot, which would prevent detecting exactly that reset deadlock=
.

Note memalloc_noreclaim_save() on the reset path would not silence this spl=
at:
the false edge lives in amdgpu_lockdep_init(), independent of the reset pat=
h.
The splat reproduces with a userptr BO + MADV_PAGEOUT and is gone after thi=
s
change; I verified both.

If reset is confirmed to allocate under reset_domain->sem with reclaim, tha=
t
is a real and separate issue and memalloc_noreclaim_save() there would be
reasonable, but it is a different patch and does not change this one.

--=20
Best Regards,
Mike Gavrilov.
