Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F76ACD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 17:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D2310E3CD;
	Thu, 14 May 2026 17:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ni9qhWy5";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB9810E3CA
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 17:09:22 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-65e170f1ca5so1710727d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778778562; cv=none;
 d=google.com; s=arc-20240605;
 b=c67V7Frb9oqt1dpPuIs6DjlY9w9oUuNeH7yek8Q8Znfl82WWTDWX6DScPwhPW5GdpO
 qovJPE4/ymL0AAAwVz+NabTD3ZYEMgmyN6aFTB2B1CcPr6+D+Cf4/MO6FstMvqt6GXIO
 FSIYz4o/N7arMfFORVnl47rT1UeM8IBnILFMbbkqZT4NpnbrhfJk+ZT0tVzWPK/Q0sQF
 Wu6NEDv1PHC009bFS+piL4Y5xOzMZyT6Hn1hvXYcJzfV5HC8WHeFG2O7oYrnaJp93NLS
 jXeEBZ6vjA7sFIn9KFLMatXxJ6Quc++uBj/FoAdtg9FE5u1SiVYIUAsVd0YrfCEm6hSK
 QxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q68k3qvFh5WSmW5/XAb3NIaTUyA2Pk7yy6D1aLYaWeE=;
 fh=QCto1aBWyM9GCkf/i5CpntnMvN4GFcoc6V+fbtLcnAY=;
 b=EDzjzYsjH8X4z5lqkDPTb5H/fGcFXUHNVU/kBDlxP1+q2kP7K2AsSR0NbmCnbD84dj
 gMQqylBjLQenOiGnPTQhbOlMrHp7JF4r/u9+YkFW6Z01oBbxJdq/QdeniQ0GQRq1lzNU
 9RlSAayLe6JBOzZxx4s7oOouq4htuUCfcWpy4Zn6ufgAqFVXz5NfWubgaEWHPTgTtTpP
 1N/BHVTPqOgMkJsAoyd0Czv4Y6qmUdxlF8AyPmOavtFdH/2Tg9Z1Ap0eAUYdqY8WnU+/
 DUABahFuaKaAuqRJcm2PObz9I9of65AktKuGgLYGTFtKA4g/9t04iem8ZNEAJKy2eVzp
 b8/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778778562; x=1779383362; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q68k3qvFh5WSmW5/XAb3NIaTUyA2Pk7yy6D1aLYaWeE=;
 b=Ni9qhWy5Yn08TFjJwuaOOENnurnsCVeM2iiAUC6yk6gmeFagApIg5iLNgPR8NPmB/l
 SbnY+xDc84YS2dHXayMOLEn/H1EollMT6z61Xtz5tnohpgGHexsy02r56hiW2qXWIYSk
 LzSIVOfGsXlqqQKN6SN+f0jSMHm55iXn59+qtbiS4oeJhXdciMfIO8TbG19R2IA1kkHi
 yyp0sBI0QMAWlWjdD+cosRzRHzP+BcMySShQtE5YTYfmXaa5UhHkr3/yi4+25FjUQsD1
 MNaetEVnKS075Eb65ZigJwxhYIyervkRyf3gHXVMCFoVJ/0p7L0EaiH8O8WP5nEnYEtA
 Mnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778778562; x=1779383362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q68k3qvFh5WSmW5/XAb3NIaTUyA2Pk7yy6D1aLYaWeE=;
 b=k6TGagH90wD/jFe/WhzJ1yf975BpWv/+evM5ISfG/CzLdi6kCo5s+sq4GUOmijDFkj
 V8j9tEFUVpUc8baM0njGwCPY+d+VKddflww98pfSj7thirg52liYcWh/++ngc6R6Itvz
 IZiG4r37UT8iKXbymhixPdohkp9p3xYe5vy/2CLNgmbuoHbWFuenNvtlCMj7RuYJxYk0
 L1PGhUtasi5eYZ+RrnjJXn0aGAuWokHoC94M+45mGD05B254RgTY9MopmW1bqLZr3L3p
 ENqMBvsIwDmxno4cGq2LrT61KkWzaFNKtiQkDFPqwqrty/+Q7GM8fA7CUc3/FBw8VJ70
 Nxxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/L0Fa4AZlBDo0fAcj4XVPrnCt33nMWWpxE2zuUphHyR6NYyzFZsZ3cTpRveK3d9acVjbwaVOvptT4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yznv/2pkoBrJ7VvWaw3jBVHw5QuoYJHkeGrpZxMuA8TMBPKKUlq
 DEtR4iyVW8nb+PHjr4vmX8Gm63ixOk3dDMGnapLTVJYgOdXz+eir9c52ZY8jZ96a0bwMP2I5OGE
 3ZIFh9sQ6safhC8pUTG6SeMi13Df37vk=
X-Gm-Gg: Acq92OHxQCFSXIbdQGsa1CmpE0XILvfhc2Pg9J+li39zbk3fCTAgXe975WJnOKm+CW3
 DmBH1RzURipPvpulFI25t/XtcrHIfCCR2i5Pqd73UFuisaWFr9y5w8D6IaV9AzHHKgOwFwnI8tS
 6xwAv0CaAVmKweC0QG3DyTcQJcK1LAG+PoTtZ5nTWdt9/4r7RY3M/IHFzAUjdHNIY9MLcar4Dqf
 vNgkCgtcSwShLmooBWOyigFqyvS8E09WlGfAqqPK8RiTaE/TpMUEyBCTmkTeVq8VBFuOQ8sKph7
 QkKxxdehTapxwUbcT98X0tooBFkgSBDuYRyYlZ+icvoXn/MHm6ndd4HGV+zFSiiFB5N51CbUxw=
 =
X-Received: by 2002:a05:690c:6d84:b0:7bd:7b55:ebe1 with SMTP id
 00721157ae682-7c959f80c19mr1966067b3.1.1778778561722; Thu, 14 May 2026
 10:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-1-f2d8c15a97ce@collabora.com>
 <5ab2d07c-74a4-4a2c-b145-6ed7b0060944@arm.com>
In-Reply-To: <5ab2d07c-74a4-4a2c-b145-6ed7b0060944@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 14 May 2026 10:09:10 -0700
X-Gm-Features: AVHnY4I212PjTT_rDyYSXIkovkEef-Opnswhr90mIqa564wAfvhabndPAnzBHJ8
Message-ID: <CAPaKu7S9WMbJERrWa=bj5qyQg72no9MPex6S1MY6t8nXoMbB-Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/panthor: Driver-wide xxx_[un]lock ->
 [scoped_]guard replacement
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
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

On Thu, May 14, 2026 at 6:24=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> On 13/05/2026 17:58, Boris Brezillon wrote:
> > Right now panthor is mixed bag of manual locks and guards. Let's
> > make that more consitent and thus encourage new submissions to go
> > for guards.
>
> I'm fine with encouraging guards for future code - but I'm a little wary
> of a big change like this - it's hard to review it and check that
> everything works the same. And it's a little dubious that the mechanical
> refactoring produces more readable code in some cases.
I agree with Steven in general, although I am in favor of landing now
that you've gone through the trouble.

I also have mixed feelings about some of the non-scoped guards. Their
scopes are extended slightly than before, supposedly to avoid adding
another level of indentation. But other than slightly slower, it also
becomes less clear what exactly do the guards protect.

>
> That said I asked my friendly AI bot...
>
> [...]
>
> > @@ -3142,48 +3126,44 @@ panthor_mmu_reclaim_priv_bos(struct panthor_dev=
ice *ptdev,
> >       LIST_HEAD(remaining_vms);
> >       LIST_HEAD(vms);
> >
> > -     mutex_lock(&ptdev->reclaim.lock);
> > -     list_splice_init(&ptdev->reclaim.vms, &vms);
> > +     scoped_guard(mutex, &ptdev->reclaim.lock)
> > +             list_splice_init(&ptdev->reclaim.vms, &vms);
> >
> >       while (freed < nr_to_scan) {
> >               struct panthor_vm *vm;
> >
> > -             vm =3D list_first_entry_or_null(&vms, typeof(*vm),
> > -                                           reclaim.lru_node);
> > -             if (!vm)
> > -                     break;
> > -
> > -             if (!kref_get_unless_zero(&vm->base.kref)) {
> > -                     list_del_init(&vm->reclaim.lru_node);
> > -                     continue;
> > +             scoped_guard(mutex, &ptdev->reclaim.lock) {
> > +                     vm =3D list_first_entry_or_null(&vms, typeof(*vm)=
,
> > +                                                   reclaim.lru_node);
> > +                     if (vm && !kref_get_unless_zero(&vm->base.kref)) =
{
> > +                             list_del_init(&vm->reclaim.lru_node);
> > +                             vm =3D NULL;
> > +                     }
> >               }
> >
> > -             mutex_unlock(&ptdev->reclaim.lock);
> > +             if (!vm)
> > +                     break;
>
> ... and it said the above has changed behaviour.
>
> In the !kref_get_unless_zero() case you now assign vm =3D NULL which then
> leads to the 'break' case above. Previously we 'continue'd.
>
> Thanks,
> Steve
