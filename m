Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F2DC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D315D10E11F;
	Tue,  4 Aug 2026 13:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rgKcYt/7";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA95510E11F
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:45:11 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso242684a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 06:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851111; cv=none;
 d=google.com; s=arc-20260327;
 b=ZghZAooCGXkG7Jl420xCCyg7fFUrMZNRgpTqMxHExHXll4oXb8pgWfTg52QeKwF4sb
 Oam2vYgdx8w6354MROCM9GyfLfbdz9oRlAleFR+JFPtVAdtf096OJDfwgCPI1KrRmHNF
 7Gm3FgYG8e+mo9KytCO7ejCbu//maV7r50S7alVWu2mr8eHMzW7ICwTG/jPI4aO58LvM
 X8tie3LYK0FBFTLlS03RE7t8wP2FlPYNFslrmvK/FNfU9I4TsVWUbmn6HJkvdtnNcJZR
 pMuKLhA3oWoKmqKwwGCeAnE3L4iCyH9Brfr6sBRV+rTQbshefAZUizKcqrta3U6JYOko
 8qEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6KLSkQQH2H4b9RLq8BMZeOvATgLTkZiGqz35LpzOs3k=;
 fh=bYy1gdffJzDCrIK7z4EL5b/4iCdagfa/eUW4B0maKQ0=;
 b=PZP6yg5HMOLiMpMxEW+SwoBXrOwVCvKhfc9QdQ9b6OLpQe996c+GI9kqokfnWW3G7o
 Oe0MA2shz+1rzrcoBs3GUAf0Q6WAb7iWhnLHAgF7/yMf3/Mld5nTO6VvPG7bGvn9Zdjs
 k1mVk3xV/midZEew/PzcQqOKkiXYZGOjMx8Xj5mRv2gVQViZpO0dwZBLPpwzKHMxjuvX
 G3cFTBM7uE88oiRi/TRDF/oGA2lSXmw7QsUrlle/kChJ6Nm9DeiL3q0l/1toZ7VPVYc+
 R+00unSdJ5XGv4xMU1JnvP+f9mBCeKXXpa6omUrkIWHY1CwKrH18wLAxBOUgCoVx+mMs
 JUNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785851111; x=1786455911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6KLSkQQH2H4b9RLq8BMZeOvATgLTkZiGqz35LpzOs3k=;
 b=rgKcYt/7TFBehmEfn4PLovhK7JX6/4Z33/t4VXRluS34Kza+bnTLRXIIjdlM/Pv7VX
 6ckSN4WNWlDHxj+V5OEvdoeQZNY9nGOKIQZeVQv3OQWKz29LoIzBZ9+5kR4yox2fT4UI
 AezxyHh63vcEdt7WXkRtjWgDnPVhBEoqIPNY6XnxK9zKcWDPzjro8kFhgnfs470WNIE+
 GCg4TddE4gMZHPBfRQw2ozIaPjxvRWmg8/3OCjRlfqVkE3y2/xHOH84zus927LiQcubU
 pWWk5VTkyTjUaDTARhMeWwwHdFz3ELzTgUo38p8biVH8YmzRnHQ2XIr1/TR30tDXVXcN
 hR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785851111; x=1786455911;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6KLSkQQH2H4b9RLq8BMZeOvATgLTkZiGqz35LpzOs3k=;
 b=I5/9XcpYxD+oX66VoolCCvy4d0/yH1WhrrVfYrEd+rTtRw4tuD2DYfWZ+lhhNnj5ok
 H/u9nffctJ0IIsQ3f0iIjyDrBuyndgQI9V5zWZNj/3i3P4FNfum2e4MouoGNufv1BGkZ
 uzuAS4c06aLfFFPJMQ7pMjDRidL2uNI08MZnZonpB1TJAmCiNFxyG289dUsDE05GXjOI
 PBpXuCUeHNlj+4jp1fTULiPSdhiSBJZu60XTXndmTRoR12df2/N8eTa0V5TEO9mZ/ssb
 IVGRtex7PRYEz4cbopdhrA68xr9cX/W0HTrsapKtyMakZS8Zk0cNYk5GjhzOcyeyWfAS
 31VQ==
X-Gm-Message-State: AOJu0Yx5IB2uBDZdBNuhOtlSLc0uKWPxh6SpfsqShmg/F4wgiZK6W3BC
 1Hgwh9X9mXHdmpkYWh9/BKjbfoXEIPtSVQtP2Rs5cJLPfdZ5WONgr6lfsba8Sm2/q7ywT27XOly
 EUPtEfmlh+4jhNnKCxP2K6sxkE4OAkVl8qg==
X-Gm-Gg: AR+sD12jidNaK0HY3YIBS0JWrFwtfvtHCB+NOSMTeLDJ0W+gTktahOUhxpilre5nEPA
 IYzjJMqbuD/lw3zrZ+QlALliJZrZH/jABIRLbnBakJBJcxEm/bRoEmqhdJWMS1eAedY3wo/Czf9
 dlLl7flCv2reSZ04Fd3GRCesi+bbV80WBTwI+yX5s6dnywY95YPSXnoCML7zeYTMJtvQdMnwXs4
 TMPW66wfZLyk7vVvzeTHgkEo33Vk/0fxDb5fZ7KfVziEmKzAAmbNsGoEj5xZFG7B4PRebFxyWDQ
 pFMzI/mhg0AyZW1ST9xSrC6djraAme9ZPNT8avHXNWX3oprmJIo8289/9comJeXrBn+2E/s3R/h
 tdPOIPMKEFkZ49BVbFiVzMFg4FXscVgp5eM8GeXRr
X-Received: by 2002:a17:90b:3947:b0:38e:549:9e04 with SMTP id
 98e67ed59e1d1-38fbc3ebbb2mr17761731a91.1.1785851110674; Tue, 04 Aug 2026
 06:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260730153555.15176-1-harimishal1@gmail.com>
 <20260730154644.226891F000E9@smtp.kernel.org>
In-Reply-To: <20260730154644.226891F000E9@smtp.kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 09:44:59 -0400
X-Gm-Features: AUfX_mwKR1ANLuyrvYO3QQh0kig5k8rc7ey8Arj9zRakX_48umkBTtR4sxPzqCk
Message-ID: <CADnq5_MBQJ4XctXY8opW9+=iEb6PygYniwu7SLCcJOq-znD-Zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: reject alloc_memory_of_gpu with wrapping
 va_addr/mmap_offset
To: sashiko-reviews@lists.linux.dev, Hari Mishal <harimishal1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
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

On Thu, Jul 30, 2026 at 12:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The patch adds an unconditional overflow check on `args->mmap_of=
fset`, which is strictly an OUT parameter for most allocation types. This w=
ill cause perfectly valid ioctl calls to randomly fail with `-EINVAL` if us=
erspace leaves the output field uninitialized.
> --
>
> --- Patch [1]: [PATCH] drm/amdkfd: reject alloc_memory_of_gpu with wrappi=
ng va_addr/mmap_offset ---
> commit 90e63e5cacd60faaf13c89e037955751ad085487
> Author: Hari Mishal <harimishal1@gmail.com>
>
> drm/amdkfd: reject alloc_memory_of_gpu with wrapping va_addr/mmap_offset
>
> This commit adds check_add_overflow() checks to kfd_ioctl_alloc_memory_of=
_gpu()
> to prevent integer wrap-arounds when calculating the end address of va_ad=
dr
> and mmap_offset.
>
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_chardev.c
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -1089,10 +1089,15 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct=
 file *filep,
> [ ... ]
> >       if (args->size =3D=3D 0)
> >               return -EINVAL;
> >
> > +     if (check_add_overflow(args->va_addr, args->size, &end) ||
> > +         check_add_overflow(args->mmap_offset, args->size, &end))
> > +             return -EINVAL;
> > +
>
> [Severity: High]
> Will this check cause valid allocation requests to fail if the user space
> application leaves args->mmap_offset uninitialized?
>
> According to the uAPI in kfd_ioctl.h, mmap_offset is an OUT parameter
> for non-USERPTR allocations:
>
> struct kfd_ioctl_alloc_memory_of_gpu_args {
>         ...
>         __u64 mmap_offset;      /* to KFD (userptr), from KFD (mmap offse=
t) */
>         ...
> };
>
> Since this check is unconditional, if userspace calls this ioctl without =
the
> KFD_IOC_ALLOC_MEM_FLAGS_USERPTR flag and leaves the mmap_offset field
> uninitialized on the stack, random garbage in that field could trigger th=
is
> overflow check and spuriously return -EINVAL.
>
> Should the args->mmap_offset overflow check be restricted to only run whe=
n
> (args->flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) is true?

Hi Hari,

I think this change makes sense.  Can you take a look and respin?

Thanks,

Alex
