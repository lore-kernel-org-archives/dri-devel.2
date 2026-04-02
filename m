Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7FCD6AAF4
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 18:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48CE410E040;
	Thu,  2 Apr 2026 18:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kQeJV4eX";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E1E210E00B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:27:54 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so30934c88.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775154474; cv=none;
 d=google.com; s=arc-20240605;
 b=lnPlj91GZuVtJpNTM1Hd0LcDAV7GmPuv3Fuj9LyBOI8pEDtJe6+vOgMXGTNt8NCVe6
 FXDmMBDBk2s692WAFqyS5uGUKuCFo4a5cZ1SEM+Gz/DugrrQYGlYN0HtIqfB5rCtaYAL
 jzi4YmQyxixiOTFODumIj07LfBmUwwyxNH46E7OjwuguAUPVqU1SO7gzAQwPjSShVMRk
 A5oh7sEwLqaKPd6N7GsJggS/Qn7okkvTNQf0aQO5vWO/S41btqcqDTAZleDOrB4wlTaT
 D0cLOCA2qt7cjfg2xzJqU8OU7PBBB3oEceuXo3SFCmHq2ZZHlhG/hSSQJrh8A4JYXFNR
 /dDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3nz78P8JwO8WYCJwneSwFruPF9nag3r5N/7yHGc7wHg=;
 fh=ZBvdVqpIxMD6eBuDDpRZpYPS3BASU37IQkYOGCDQn/o=;
 b=Ag5GLosKIfMBuw2EFIpVrB7o3Y+RShMaaBB1Dywq3TWcmhtnhDWVy9NnEjDFK8VnOI
 AOy7nChK0BzdGzYRY5xia/Po5DwjG1Z8of5wmIQ0ZdXUrJu/ox5XjeCNKuZ/6TmMt3Yj
 jerhO4djbCvpYkGPry/RSfEu3xH/xe+eWgvAToYTsVZFO19+bfVxr7zTH6OCfYjN4oJc
 r3Zed/0scHP8igJrswfyD8gqEQF5NzBQ2EoDl5jZh9MWzP+9q3iWm4VT4rnkHip82tO+
 zdUOwDJCDrKH01sM6YPCw+rr/KJKRGcPYAW1L7S/BebJlfPZ/VrsSX9rv66kNEeYZRTQ
 yPHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775154474; x=1775759274; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3nz78P8JwO8WYCJwneSwFruPF9nag3r5N/7yHGc7wHg=;
 b=kQeJV4eX6KiTq9DzIbb2JcRkQSVQmwpfclep84r0M0ne+jgQa58gwHbg4JIyQ1eAs7
 Y0yfQp2QHyTIRvZrwqbsKwtL1aYqUDR1C/bTPPLBQ9S1ZzmOBIHOeCQVxCf7buX72qSN
 04KzWiqfhwo4D8vCNX3+QWf0G8Zk7O+QIc/+xRwU3lJzTmbOvdQ5pf1OSbvlUemonvo+
 3r2prBaFaSM9y6+TGo2gzeacBIvqliQHyrpM78S9U6WlT2+56SMlroZ//6MhSV9e6Sr1
 uD+JsH/O/s1rzo2oRaLIfR7XehGa8zihFcToiXW0QIvXKkh8u6s1KaD3yhSvgpMTWhak
 DT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775154474; x=1775759274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3nz78P8JwO8WYCJwneSwFruPF9nag3r5N/7yHGc7wHg=;
 b=of4lzVyU918ConZ3FqUlZQN2Prg6qv579nGFkxA94MZ9dhZ7wHncTWyUzrxAyoQlX3
 mABV6NE7jUqT9o4Nx0e49C8JF7bZUExEhsRyyh++cKNo7O81xzHnkVQIfiW3j5p2blme
 C9x/6tfiMuX89ck6Mr9dWFZqXFVpAFclBnqRQiILfbaLzPQHyX3LkU3R0NWHgVWt7vow
 fLA+bHrKDEyZqjpI1GU62HsjHkudKrQbPEbYTZKNIFLJfllyftC9ky+awE1Wt9YsMSnE
 4eMjo0ypoFUID8tGJN0Lpi4Yd0rVRLBMcFL+Yp4GqZsc9vY23NaGZfleZg0Ri+WEXIAv
 4yng==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4FvqiDCKfUjI08DZt7YumLL6KaMGVWJoQiAUa8Ej79x9VYwVfx1tt20/SNCKQSrm5A/Mdy1nldd0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxplyFspHuKRn4K++HMKu4BlSdKhGxBHRBBCjnw8SC4GZ0VZ+mr
 P/Jui1HSU8dgocXaMXr/GYj/XoliBU0OA2HNz2riuHSJl91bVo7JzdPOdjRwoePrxRwKoKYmeDk
 LqHwPM99mmD2Kzw7BN3UtQkBvBaPiMwQ=
X-Gm-Gg: ATEYQzzbIEy+l20+W1zoMwfgwfK7m37AEeRW6EukqYRkh0r15hCoJ24iekDQRtQkyR6
 6osHSGERj2WR3uG7e1PMwuZtqZqVkZx2KdZka1ydpL+PQzefe031O5paCPBGb+9iHj2oX+nm6jl
 O3IOeMO6Nui9R41klJeaO9wslpdKPUtHJ/1KBMWbImwJFIOu4YBGONa7RVSI5X3AjNp5Vut5Njz
 928p/WckvyJzDBCEHJrz8CuG6yRoAiqCiAQpDtgr50xrd5oBZpvTtXTU48cwmPGUaizMpLVqauo
 KLB1KHFrFn2NkJ+LVp5adu9bgHYifqPcIx5YXaioc+y0Gryl71/rcfp8y666l5WYwZhtjg==
X-Received: by 2002:a05:7022:226:b0:12b:f9aa:a13d with SMTP id
 a92af1059eb24-12bfb6ed5ccmr22345c88.1.1775154473621; Thu, 02 Apr 2026
 11:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260401184456.3576660-1-alexander.deucher@amd.com>
 <47c508c3-3424-4e8a-a63c-1f29d13b6ebe@leemhuis.info>
In-Reply-To: <47c508c3-3424-4e8a-a63c-1f29d13b6ebe@leemhuis.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Apr 2026 14:27:41 -0400
X-Gm-Features: AQROBzBC6IbXZRo0MtyoO7uYGz-yAUxbl3iCRexA4WI6UV1jaB5oEu9t-_ooXNY
Message-ID: <CADnq5_MiFOYLP9aUnYw4HFb-xWLZdq245ZB3e6iGn09ywOsY2w@mail.gmail.com>
Subject: Re: Regression fix for audio issues with pre-DCN401 chips (was: Re:
 [pull] amdgpu, amdkfd drm-next-7.1)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 airlied@gmail.com, simona.vetter@ffwll.ch, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Linux kernel regressions list <regressions@lists.linux.dev>,
 dri-devel@lists.freedesktop.org
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

On Thu, Apr 2, 2026 at 4:59=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Lo! Me again, sorry for pestering you folks about workflow issues again
> after doing so just a few weeks ago. :-/
>
> On 4/1/26 20:44, Alex Deucher wrote:
> >
> > More stuff for 7.1.
> >
> > The following changes since commit a51973c5dff8a0f01cc7d1b2007306ea0004=
fa16:
> >
> >   Merge tag 'drm-xe-next-2026-03-26-1' of https://gitlab.freedesktop.or=
g/drm/xe/kernel into drm-next (2026-03-30 06:04:59 +1000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-=
2026-04-01
> > [...]
>
> I noticed that this lacks "drm/amd/display: Wire up
> dcn10_dio_construct() for all pre-DCN401 generations", which is a fix
> that was posted 10 days ago[1] for a 7.0-rc1 regression that at least
> three people hit[2]; a fix that now seems to be in "this week's display
> driver promotion cycle before merging"[3] at AMD.
>
> Is this delay really needed / worth it for a regression fix at this
> point of the our devel cycle?
>
> And yes, I understand that this might be shared code that AMD wants to
> test internally first. Still asking, because at the same time it would
> be nice to (a) fix the regressions rather sooner than later and (b) not
> fix in the last minute.
>
> Are "pre-DCN401" chips even tested in this "driver promotion cycle"? And
> how often does it find problems anyway? Can't we just apply the fix and
> revert it quickly later in case AMD find problems (yes, I understand
> that this complicates things, but I wonder if that might be worth it if
> this is rare)?
>

There are always new fixes.  Worse case it ends up in 7.0.1.  If it
causes other regressions, then we end up introducing a new regression
in rc7. Pick your poison I guess.

Alex

> Ciao, Thorsten
>
> [1]
> https://lore.kernel.org/all/20260323211343.263909-1-sunlightlinux@gmail.c=
om/
>
> [2]
> https://lore.kernel.org/all/CAOKSTBs1VNBdjRZe3M2v-nC%2BpLZZ0-KQtRUZUj6ACq=
b4Xe7LDg@mail.gmail.com/
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5052
>
> [3]
> https://lore.kernel.org/all/22eb66d8-b74a-4e0a-9851-7e39c7f950cd@amd.com/
