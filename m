Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C0ED3517D
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D429610EE04;
	Wed,  1 Apr 2026 13:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gmfrQmlb";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC8010EDD3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 13:24:38 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c5729da886so252339eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775049878; cv=none;
 d=google.com; s=arc-20240605;
 b=IEkCQCHRjmu7eEUdjs/fml84p+y67zzY+yuQC6ZOvCn11G1/QIHnkqkv+iOpwjaktJ
 DcN+fjNPmgITLezRHzO525ud6jawABJ4gVrhBxWT+U20Cyp7+Lr3evbZE4ZdIwBg3682
 5qO98wZt5vx6SBeiYNjZNmhj3peHV1t29zlwqAKQodLojaCoS+j5Hj4vyGiqvUw6h0Jm
 vS4OWa5o26oWIEbxRvF1mJ3qE4KshapLs9WuYa5tefZD53wpiEErC18kS7mCZz+4qhiM
 mlM/VVXL1nSvxELRQQ/38KGFateXUE3mHadJttWL3wNlfs87oN+lRE7iafISa6dwA3PD
 DTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IDufKBR+XlMKiQydxoWaasabDEo99JV6htcx9j+jpD0=;
 fh=mz1wKgtmm2icMCkTyo83/NCnTN4pG3LcCgXOVbMOWkw=;
 b=OpAKanjDCmDanX3jNb+aQfl/5pRCFpy9KFw24lAfF5szc22ZWTcypysdUGPfrj+7jR
 pXD9ZlHE2zFEhLlITYdDo8Lha4akmWmERNVSjtnM8CD6B8uAdThg+YgRxfKrXEvlPipb
 BSFUgLSV5K9rGGxrn0OA+k7RGTVXMIbCol0BNF3gvHxf6Xn1RgLj4EihhKuxaMmmVJ9m
 0jNNd6YBSvmj+lbxOLVCDR4T+VtF1xhtfZgp2NyLQT98PG+rx69MGFPwpIWC5F/3S9/9
 1xbs0edYjkgvQYb2CMTzLOMvSrdp3SevIGNHcDmOce5lMY0CFvqkuSqIx6PZcX0iAA3p
 FWiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775049878; x=1775654678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDufKBR+XlMKiQydxoWaasabDEo99JV6htcx9j+jpD0=;
 b=gmfrQmlbyZzmhkcpL+GdqGkaTBYZLziies2af9/CWfCR9Tf7CXjspgsAkX9AG3tRZc
 0wl4v4MQ3ipo138bq5grC95K+tyohHxOjpahLaTj57jkorE8s//7hnUPVqZaBJEDNtiw
 xyElzhbUv44e/3BPF+1cl+wy+utyflC+T/MTt0gUZSTyVO7xWeISyjipO86f7YsstPy0
 WcP1zWYbY6gMCcjOFDwIOhZhqJNvpGu/5aCMbtqpfJFtyi/jGWhquKo2rHiZuYoq4X65
 2Ohau5+1n15ZjPZF7uufbHvWxVHsUMeTl/ZpI0k2KmjlvfTnj6Rfv1ciyz/YzOMfc3j2
 Uoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775049878; x=1775654678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IDufKBR+XlMKiQydxoWaasabDEo99JV6htcx9j+jpD0=;
 b=sLefySFJYn5TQkjsWlqI+VJZqPm5T3Bb7EU+XZxsaH26aHD7Siyw1ZRxNnhdgqZGlX
 ooxWgyLi58K5omv6j1syawPS6csFTFBz/oFcDY+ZIi8l0i+GssLrQkpBwOC4zAV06wVA
 KGhjxquuPlzNBHyYYhcZJBFyNgbpwFHGsvjUR7Ho3Jl3VZVlv3Lu2vQsSpa+zgZ662iI
 dfx5q2+s9MfEunSh6lD+j5wVGybKaSvi90+hIEW2njTIh+tvqH9hDS2uLsp+hblKQlfJ
 ZzOxolPb7XtlSoTz68VBUgX21oGf3o4jvtsNHiZHwU+VcZxTeJ4lWMx3jgDc5b+OCWDM
 SCjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4opT7aO59HofMsUB4gLtvhsBDz+pnvCGqU3RmRBlniiezxTPbFGvuxHbLIC+91gA+jyQysOVu87o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAQVs1g9ClbV0ktWl0FPzVV52d2yHfRjAfWbsv+QT9xU0b4Zp9
 cdFuvDOgB//EXXPIjbBXilPndC/2+FD2idVu+CK4D3tFj15c+wzpy42B+5BG//fshLLROe6LRtl
 0Mb6f+1D3AAUbcb155vgGdFrDtZeQaQM=
X-Gm-Gg: ATEYQzx1OlW6sfcsHuJotMFQBudI5SOu/rZsDcaLAdVY6FkePJ/0omy4gFd3Mpr0Vjl
 /yQ7Mmdu6gHOHFWqsuXb03Z7ZKq9HVeTLpJ4PlOthWx8WKWXvNzFPBxC/t79gTpnW3YsSNbW9Ww
 3wQ/ZO1DZWtFLI9KK8/1TT8vgF+BbW2Ys1N+4N5jv3sat6I3ucRq/aJArEUjgDtJbFjlMbbNUSQ
 dZXNKjRpKa/WQEfPBQxva1l2d0jWgs6u3Aa1c+MoHuy3QHzKUfeih86uQpq8BR7FVC5lH1bTwZG
 LxAnJ76aJR+VmJCjEssh6Z0yz5ijcT1bS2pnvOKZkL7Hd4vGZJp/8oXzcLgvtqn7QNFFpg==
X-Received: by 2002:a05:7022:698e:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-12be62e92f4mr1007497c88.0.1775049877886; Wed, 01 Apr 2026
 06:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
 <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
 <CABXGCsNcRQnQmsZJAhfJPsR71HXU5+CG4URJiX03xkPJD+f7SA@mail.gmail.com>
 <d37e1e34-8a9b-49dc-ace5-76f23c0375e3@amd.com>
In-Reply-To: <d37e1e34-8a9b-49dc-ace5-76f23c0375e3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Apr 2026 09:24:26 -0400
X-Gm-Features: AQROBzDtwC2uHCPbn47xrdsYtCW1ppTW7fCCiZAyw4rC-_YtNNFBrKFHsMlI2hU
Message-ID: <CADnq5_MiwKNWOMfWZ1BGRYQyeAeih9SiHd44Y0QGL=tDKmp64A@mail.gmail.com>
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Apr 1, 2026 at 3:24=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 3/31/26 19:12, Mikhail Gavrilov wrote:
> > On Tue, Mar 31, 2026 at 7:38=E2=80=AFPM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> >>
> >> Applied.  Thanks!
> >>
> >
> > Hi Christian, Alex,
> >
> > While testing v7, I noticed that xa_erase() and xa_alloc_cyclic()
> > use plain xa_lock()/xa_unlock() regardless of XA_FLAGS_LOCK_IRQ =E2=80=
=94
> > the flag only affects lockdep annotations, not runtime locking.
> >
> > The XArray API provides separate _irq variants for this:
> > xa_alloc_cyclic_irq() and xa_erase_irq(), both defined as inlines
> > in include/linux/xarray.h using xa_lock_irq/xa_unlock_irq.
>
> Ah, crap I wanted to double check exactly that but then had no time for i=
t.
>
> >
> > I confirmed this by hitting the same lockdep WARNING with v6
> > (which has the same locking), and by reading lib/xarray.c:
> >
> >   void *xa_erase(struct xarray *xa, unsigned long index)
> >   {
> >       xa_lock(xa);              // plain spin_lock, not _irq
> >       entry =3D __xa_erase(xa, index);
> >       xa_unlock(xa);
> >       return entry;
> >   }
> >
> > Should I send a v8 using xa_alloc_cyclic_irq() and xa_erase_irq()?
>
> Alex already applied the v7 so it would probably be best if you provide a=
 delta patch on top of that.
>
> It's then up to Alex if he can squash the patches together before upstrea=
ming.

I dropped v7 so I can either apply v8 or squash v7 with the fixup patch.

Alex

>
> Regards,
> Christian.
>
> >
> > Thanks,
> > Mikhail
>
