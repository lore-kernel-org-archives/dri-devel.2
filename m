Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA93C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D7710F118;
	Thu, 20 Aug 2026 17:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qUOo6r9s";
	dkim-atps=neutral
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EAB10F10D
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:04:06 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3a12ffc112cso11554211fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787245444; cv=none;
 d=google.com; s=arc-20260327;
 b=l1m6ZkhyEad+MJZ01yzkTd/6o9UzBPjzqM+3TAnaSAzftYeCKjKo+yXtbWjltkqyGC
 Lf+7cXoqKGqlLChCAPSa5XIq11m8j8lfoD+yrdiRHTPYNdiAzsWokuEb1++id/mQMAKU
 CoNml3w4qUw26Kyg/Ux/6GKnRMKbg5cEeyhUWKF99cGU9Y5Emv76ZkCGy0XvGlwTWKwC
 jwoxo/IH3I45RUn5JWrK5kBq275CISTbIwuAUqbSXzJi551D6ye0yqPYg2I+2nljID8e
 BMfB6ZC3ehw+tFZsdr6SQg7tqhtEIdfMfpneUrRakDpTC0sqRf47lrl4exFb4YpRkLym
 dwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IIkgwb1Qi9IIwPivKlXlZcMTAwsxzm2MJ22/33JPb8g=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=dJdYprQYj/Dism+fx2n0nK+3MauzLcUDkACMOfhCjXWJ/yYotXJJsPzkcGnKRGq451
 AOSYJL47PafrNHV6VChtz6ZVUZxFT23//mGrnqYYRgT8JSc7OBRRohwDeYnYRf1d/vOd
 xx4tZVoJ5Pfxz7eqHCzvD4pKJZ6UVoeRHJvvgFpSUyFCou1Kahlza8MxHj9lWoA31+Sv
 g5fuU1OXKhYKh8miu9ln7YZOhZQAjPe9oE1ceybLZAyL8hHMAzRtJZBehqmZsKEDGlzy
 74DG+uurzcZ6NH4x9K2SYNtYisSGKiqgYlsVuTYYXMMgRff/ixjm9YNfBAYvGcM0/ytr
 mgBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787245444; x=1787850244; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IIkgwb1Qi9IIwPivKlXlZcMTAwsxzm2MJ22/33JPb8g=;
 b=qUOo6r9sL6yFuoN0/CLGruV1NscIoRDbs+X6HyPhaa20M1yiYQ7kyW+KN+TUKJd4rg
 XV2HPklVXzM/FSe4upE/E8wpNH49QugplI99iYk1taxcsnL4KXSyYm30UkTbsL0WKma6
 XDEfaSXHAM7D+R4sgqOWQpseFeo8ZHzFlrSk2WMJs2Cj606eX63KOYAhPXaLGDL4yfmO
 GYhrwbG6ts0FEUvYledpbcBIA6YgfNj4AAT5nkl1jmAAsBfPHb1ZI7vbZc0BB/pPsMBv
 d2kYrlLVLdF5F1kvQRN0aSUJ1HFZg5K/4dy4MhKIxAeFwIKEyWIXMUwALt1VkzWo93IF
 GQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787245444; x=1787850244;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IIkgwb1Qi9IIwPivKlXlZcMTAwsxzm2MJ22/33JPb8g=;
 b=o6Y2WJFJAQ5wpHaESzgdihaW/i8zVM8RqFH+6j2deb8NTn1U+sunWMi6yJSPtHMvjI
 tGeuorPC5PYKNhntjXqcVrXQMNe31Rmob8+t4hM0nqA8blJRbQCWCoHtuYkVSuem0Zns
 PevGcUH09x2nObbCpsgtqclbxVbXvGBy5OEB8haf1/Gil8MzQQycIHCh4j6o3BgKCasQ
 ENlUgVvur89snh4U+1vgDDPGMriVweSj/uK5qePOVhPTOAEgxiY3jpVpAowFGfH8z4oK
 xJPzZuOm+l+VfgazkaTY/Ki2egJ6XhAwgqJYWALWXbXeAnuH8LsdIzBCQ2JCxmq70U0x
 DuVQ==
X-Gm-Message-State: AFuF++lja6X7NUbGG8t8T8Py0t6jhudjUahij1CNC3IOhsXQA0DVasaO
 1x3tOiPtO88SH02lVqP7sbY6ZOcJWVRUugWeu4cOBCBQbkJR04cjWFFHKNw1mDawmC9trRgMy/t
 tAA/Xt1tVE1raw5KpYmDy7cxckIeZN2e6o6qp
X-Gm-Gg: AR+sD12QjY93Ew0TvBodRnQFfm8Y3t53MkVmi8HAgrekHNZSgIvRDQhHh6EPDKphZ95
 37wu+0dSvk070y+mL6yCEJNLvEWBppOJuuLrwZK1kd7dGEGH8vVxEpzyj5n/VnpEw/ZAwhIVONV
 pzOjQeZSKX2tjj9sc2JtmrXEWxq/MDHkU7HAFXfE52DlkZ2xnzTgFtD+zefKcUQwfou/u8bLf+1
 iJ8tZSOWYJ8IniINb3BnbYoNjKTMfRTS0iu9sEZreJS2bZd8BTw8xVFxSYXMaUW1jr3vZCGA38s
 ByLfLK4uGT1TXlSDShJ163rNJ8ZU4AZmspNMdk9xkqg=
X-Received: by 2002:a05:6512:3988:b0:5b2:aa5d:9ce7 with SMTP id
 2adb3069b0e04-5b47d4f55ddmr2350758e87.10.1787245443748; Thu, 20 Aug 2026
 10:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-4-mohamedahmedegypt2001@gmail.com>
 <20260820170147.C0EFD1F000E9@smtp.kernel.org>
In-Reply-To: <20260820170147.C0EFD1F000E9@smtp.kernel.org>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Thu, 20 Aug 2026 21:03:50 +0400
X-Gm-Features: AcwNN1V9FlMJ-LWtJ9Pc65CSZG9MLJjpQy86MYExt0qd7F4yhYJlqhBo3X8SD7M
Message-ID: <CAA+WOBtXtzhDn+KrwBJNHMg+F5jw874j6qmGj0nH9upd6f_-9g@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] drm/nouveau/disp: route GSP-RM display MMIO
 through nvkm_disp_func hooks
To: sashiko-reviews@lists.linux.dev
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

On Thu, Aug 20, 2026 at 9:01=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Pre-existing Use-After-Free and Double Free in `r535_disp_ne=
w` error path when `nvkm_disp_new_` fails after subdev registration.
> - [High] Pre-existing NULL pointer dereference in the error path of `r535=
_disp_new` due to unconditional lock initialization on a potentially NULL p=
ointer.
> --
I saw those and can confirm they are very much real. However, fixing
them is out of scope here (I was actually going to roll them in at
first), because there are 5 (that I have seen, might be more)
r535_disp_ functions that have the exact same issues.

>
> --- Patch [3]: [PATCH v2 03/10] drm/nouveau/disp: route GSP-RM display MM=
IO through nvkm_disp_func hooks ---
> commit eaafa1eb740ad36427480951cde140701ddc6d3a
> Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
>
> drm/nouveau/disp: route GSP-RM display MMIO through nvkm_disp_func hooks
>
> The GSP-RM display code in rm/r535/disp.c borrows a few
> register-programming routines from engine/disp (the head-timing
> interrupt handler, vblank enables, armed head state and scanout position
> readback, the AVI/VSI infoframe writers and the GCP AVMute write) and so
> far picked them by name, which means it has to know which chip it runs
> on the moment a generation changes any of them.
>
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/d=
rivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> > index cd4451e625122..f3e55253bcbca 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> [ ... ]
> > @@ -1688,6 +1729,7 @@ r535_disp_new(const struct nvkm_disp_func *hw, st=
ruct nvkm_device *device,
> >       rm->uevent =3D hw->uevent;
> >       rm->sor.cnt =3D r535_sor_cnt;
> >       rm->sor.new =3D r535_sor_new;
> > +     rm->gsp =3D hw->gsp;
> >       rm->ramht_size =3D hw->ramht_size;
> >
> >       rm->root.oclass =3D gpu->disp.class.root;
>
> [Severity: Critical]
> This is a pre-existing issue, but can the error path in r535_disp_new() l=
ead
> to a use-after-free and double-free?
>
> If nvkm_disp_new_() fails after subdev registration, the subdevice is alr=
eady
> attached to the device's subdev list. r535_disp_new() handles the error b=
y
> freeing the dynamically allocated rm struct:
>
>         ret =3D nvkm_disp_new_(rm, device, type, inst, pdisp);
>         if (ret)
>                 kfree(rm);
>
> However, disp->func still points to this freed memory. Later, during devi=
ce
> teardown on the error path, nvkm_subdev_del() invokes nvkm_disp_dtor() wh=
ich
> evaluates the pointer:
>
>         if (disp->func && disp->func->dtor)
>                 disp->func->dtor(disp);
>
> This dereferences the freed rm struct and calls r535_disp_dtor(), which
> subsequently executes kfree(disp->func), causing a double-free.
>
> [Severity: High]
> This is another pre-existing issue, but can the same error path cause a N=
ULL
> pointer dereference?
>
> If nvkm_disp_new_() fails early before allocating the struct, *pdisp is s=
et
> to NULL. r535_disp_new() then unconditionally attempts to initialize a mu=
tex
> on it:
>
>         ret =3D nvkm_disp_new_(rm, device, type, inst, pdisp);
>         if (ret)
>                 kfree(rm);
>
>         mutex_init(&(*pdisp)->super.mutex);
>         return ret;
>
> Passing an offset from NULL to mutex_init() will cause a panic when it tr=
ies
> to write to the mutex fields.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820164929.17=
117-1-mohamedahmedegypt2001@gmail.com?part=3D3
