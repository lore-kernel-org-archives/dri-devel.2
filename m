Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77BCC88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E6910E968;
	Fri, 18 Sep 2026 07:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q4RR+Sf9";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047EA10E4E7
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 23:19:04 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66e4aac9321so199888d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789687143; cv=none;
 d=google.com; s=arc-20260327;
 b=WAj6hCaViWhGwO0FFNWQ+PjepvV4RQJ4FADvgTultXM+wBPpqlWdsllMgZvTupL/qu
 pbJVBDq/hMqQZLNfVUe6S7KF7FjBsbhWJaoUMgktNzOpPkAct0UMWXYx+4hMkAn6bgad
 yPXrJ+4w1NxjAbvIBKA+Z7w8ODO+cuZoR/0uQN3Hc7tJzCFBjpUf210Tso5ht28vHadY
 z2PPzGOYGZsHQEfPCMAmpQ6dO3Iy9kGAFgLhRVtP7ojF+d2kBPgSl/lLCFmMcamy22m8
 yG/XSWYaFgbXOqB9rU/rvO6ZtXm76m8Gg92NVRRqY9pTvllLOokEP69CRcMThMMILePa
 Y6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U2XagsX8bBU1jjmpUfXKrlW1BPZCFHkmBoZ36ck5PtA=;
 fh=GzWdt8WFF8qbr+GiRUEJHRgL1b0rceQH6Wbxc7O6mks=;
 b=DOrok0QbbyhHoWmLEB5wSEm3yMLw7nprVXX6PzjdB9xUBIK6xM/mCRq9EF+1BR3t9h
 mObCmYOe5pPoIL1GWn9Mj6w276cDqV3wDVp2TODsOPzweqUt2Pjjl/rSMr495xdRlccx
 whh4/veyGxixa6Iwh0g9Wy9Kl2CuhW4ROTe3KtcC+VippV//G4OYLKGfW7SPRBvMPxKd
 hBT6/Md4cLxGHuvM9fxC/Ih9clO/ccQlMQQcwJpximLUAP0rUxl/0aTnBO++Cr/DY59t
 lyx508Nr+DdSqwGmhMRDGnxUWiCit1RWRvn98+tmT/QkrumUoYUKWm2rAXv4i10DD2a+
 NAag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789687143; x=1790291943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U2XagsX8bBU1jjmpUfXKrlW1BPZCFHkmBoZ36ck5PtA=;
 b=Q4RR+Sf9YWEVrkN5NUzejbOvxqmIlwjZ2OdYjewSden7qTUktNlxYXa9r0xvn2wJN3
 Hurdgtxyj5goDGL1BIYCs0ZjThXLmwEZGfIOk1b1hdH5RpMW1+0UD+u52BwVL0kIst3E
 JuYE9QkTNCm+qIZGTa2d2RWilxXsfGHPus3sdpICBNRZTw3fNq/ZQyUwebIwm3CoikUe
 D6cnGHmdWqoCJVeafB55agHnp70yf3PYp+fEzav28c6h2HFNcKrDvYzPWmzs4ayBXvMx
 eQZJKHg1uxeRUPlmOReMrnu2wYf+M9rcVdUumRl7HYgUG9agaTT2yPTB8zqQTABhHhYe
 fXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789687143; x=1790291943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U2XagsX8bBU1jjmpUfXKrlW1BPZCFHkmBoZ36ck5PtA=;
 b=HtCalmEWVq5vgY4NrEJPrtDHAIczRiSGn6E32OFrS4oh1fz5VGTRaKNboIV0ot+bOU
 iA2z00NYURpChxH92VtdK8zgp7bRKCzDH99KjPy+JIWgygh0vFN3weoByRlYoqI37UsQ
 55skWcsBIxjpBxw8GQJdi8Ze7OclBSFPbqUextsxXULWoS1V9qo/e7qr9aFi04/mZcu2
 YDJXiqeNRjmU/TnxIKQc9tWl7XHtaF25VjD3cb5aFlHF4iLG7BdwyvPGvdo3iSvBgJlQ
 Erdm0Q2NR/1tXkfGIekayDaGXkBtAFgxILWrUbRXk/Tdl65icdGyCeO9XcHEPmnQRsyu
 JLoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYHE28SCV5jwA762znIPGbjLhWnVzyOmMy0bPJ/3OAI1H7k6lEHwzctbidg7fpS2TRZXjXO0bLL4c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mlk5weWHhp6hFNxVt0k00LywqvHVYSxrVdBfYJDJKJUK5laAPF
 zxRpcDDCUhWgC4m3HfVKrYdkEZ82bwAmHR9EibwNPiF9cdStrwrm0q+nxuDhHLOGPmlNjKkNFJ4
 V2XYZSUZ40bOfXOKPMFXuOkQlWiAe3aE=
X-Gm-Gg: AYBFou0N1eBCaVVFqEthwa4Mz4MJcZpJGYV+EqBuzjkbZC0pOUMF1Dx3n9uIyC6fj1I
 4P9EYMxUlSHxsXbboHTtM3k5plumbeM7noqoNIEEKcB2V2KPQQBCfIokZF+ce6eAGVHna2RF/M5
 t4CVTRbrk/M1lpUcIx4Q4h7jgTN6cqU528IBIis52H+uYwDpxqjtIs4QvAhcs3hkJ3ByQ8ssNOb
 VJqeAbxXHrqpSKk7qW9/bhvyV1DyW/sBI/lCTBU3DtGuw9LeaHyRrlca2x+KwkTNn8SPWo0rbth
 x+56VnliGQrLoizJXnxbKkD6W2YyBbQfvxwBrBqWcY8pz2iyubx3+EB+LF1C6giF4YiDrZ6Bx4K
 lIpQ/FrHu03b2uPk/fnFZP6fT0mG9d+r9UfJaTefF9+I=
X-Received: by 2002:a05:690e:440c:b0:66f:c1be:a644 with SMTP id
 956f58d0204a3-6717fd8f9b3mr177202d50.54.1789687142763; Thu, 17 Sep 2026
 16:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260917163553.1742580-1-talesam@gmail.com>
 <20260917163553.1742580-2-talesam@gmail.com>
 <20260917165042.7466A1F00893@smtp.kernel.org>
In-Reply-To: <20260917165042.7466A1F00893@smtp.kernel.org>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Thu, 17 Sep 2026 20:18:49 -0300
X-Gm-Features: AcwNN1X2qQB50H7FD8zGbqFyjanOiNGftj2LssNSFrprx0J4Khv2MWqFXi1u3rk
Message-ID: <CAHBRX4HxqoXm=Y4CgNZkngPEZZDe4f=Ai1y6g8maRhuAeM5feA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
To: sashiko-reviews@lists.linux.dev
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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

Good catch - that read is genuinely racy, and it is my patch that
introduced it. seqno_recv is written with WRITE_ONCE() from
xe_tlb_inval_done_handler(), and I deliberately moved the devcoredump
call outside pending_lock (the capture takes sleeping locks), which
left the read unsynchronised.

  Fixed locally by sampling it while the lock is still held:

        seqno_recv =3D tlb_inval->seqno_recv;
        spin_unlock_irq(&tlb_inval->pending_lock);
        ...
        if (timedout_seqno)
                xe_devcoredump_gt(tlb_inval_to_gt(tlb_inval),
                                  "TLB invalidation fence timeout,
seqno=3D%d recv=3D%d",
                                  timedout_seqno, seqno_recv);

  This will be in v5, together with any other review feedback.

Em qui., 17 de set. de 2026 =C3=A0s 13:50, <sashiko-bot@kernel.org> escreve=
u:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] drm/xe: data race in xe_tlb_inval_fence_timeout() reading seqno_r=
ecv
> --
>
> commit ef794f6bbaafa679257b9fec9405245af4942e68
> Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>
>
> drm/xe: Capture devcoredump on TLB invalidation timeout
>
> This commit adds xe_devcoredump_gt(), a variant of xe_devcoredump() for h=
angs
> that are not tied to an exec queue or job. It hooks this new capture mech=
anism
> into the TLB invalidation timeout path to capture the GuC log and CT stat=
e.
>
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>
> > diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_=
tlb_inval.c
> > index 7c3bf32d9258b..7a0c04fac60aa 100644
> > --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> > +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> [ ... ]
> > @@ -97,6 +107,16 @@ static void xe_tlb_inval_fence_timeout(struct work_=
struct *work)
> >               queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->fen=
ce_tdr,
> >                                  timeout_delay);
> >       spin_unlock_irq(&tlb_inval->pending_lock);
> > +
> > +     /*
> > +      * Capture the GuC log and CT state so the firmware side of the h=
ang
> > +      * can be inspected; there is no queue or job to blame here. Must=
 be
> > +      * outside pending_lock as the capture takes sleeping locks.
> > +      */
> > +     if (timedout_seqno)
> > +             xe_devcoredump_gt(tlb_inval_to_gt(tlb_inval),
> > +                               "TLB invalidation fence timeout, seqno=
=3D%d recv=3D%d",
> > +                               timedout_seqno, tlb_inval->seqno_recv);
>
> [Severity: Low]
> Does this code introduce a data race when reading tlb_inval->seqno_recv?
>
> In xe_tlb_inval_fence_timeout() in drivers/gpu/drm/xe/xe_tlb_inval.c, the
> pending_lock spinlock is dropped just before this block. Because seqno_re=
cv
> is read locklessly here, and concurrent updates (such as those in
> xe_tlb_inval_done_handler()) use WRITE_ONCE(), reading it directly could
> result in a data race.
>
> Could this lead to KCSAN warnings or logging a corrupted value in the
> devcoredump reason string? Would it be safer to read this using READ_ONCE=
()
> or cache the value while the lock is held?
>
> >  }
> >
> >  /**
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163553.17=
42580-1-talesam@gmail.com?part=3D1



--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
