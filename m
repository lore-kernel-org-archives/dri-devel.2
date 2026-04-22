Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E24F9EDF9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF6310E2CB;
	Wed, 22 Apr 2026 15:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RlSp7wVQ";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E97610E2CB
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:21:25 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c8cac037cso335757c88.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 08:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776871284; cv=none;
 d=google.com; s=arc-20240605;
 b=YY+S3Lf/GBH3LEk62AgSUy5bowBdkOnjAXRhiCZJYgBajZziuUpOTUeX87mEikvSzb
 Q0xeyigDJaZzDhRBbs0YDjsKayalfl+0TJgYFyP3h3D5g4j0RpDOq7jZU/moUnvLl5CZ
 4MJQ7dz+NEhfVgfr4K/gc3omloIveBdjGqFln6LRnoiSIwJajbnScEGdXWje1m31pVQc
 P7Bgm95obu4T5tx8e1PtbuAaUT5Ywpf6TdGGinhv7k/jHlTsvAGJYUaa1L0rN7XqR0p7
 pnHyB76Me7lO/rJ8x1bc75VipTdKoiC8xK/Qqja8GEu1Ij+dC8Krx14oLH9Ys6gVq7s8
 lvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PRVwp2dnScW6r8xUQitR2DStMGtshyNjJneKJxOSVYw=;
 fh=bILhxf60BJWxLc1Uvk9Xs9zT4iLoCBPgxjfWfwNtYtk=;
 b=V0wbWwbsSgvMberlEcWGOIGsDxiE76CZhVaE8ZoHV4jJOoJifFEuASsLUcuhu++Dql
 FDcTXqQrLR+c/Mqhr5PB27yMLCgL/DGEkVI5wvVvuWQQ0MkSo9v4p0kqRvYr4S5LKShB
 e3zDBP4baxkOaHi9P8JKgp6DueVyZqn0QfViw9WGkfWT9ito0c8jD6MxZ8w52jm/qsY2
 k0iTRbm0z/azWNP4qZ10mBDZLLho+vpHjeiTNyPqSYPvd910vsDBQAw4kLaIyadVsuP0
 hlUdalKn9HwprzDaA8mvRf0vghIiHUu+awuyVObS/OsV45yxeU6QLXyU6Vy9sdXxbwzY
 mVfQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776871284; x=1777476084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRVwp2dnScW6r8xUQitR2DStMGtshyNjJneKJxOSVYw=;
 b=RlSp7wVQCJ9L/3pPg92GyT+vGkHPtS/JHtl9UVA1SqShgaQJPcIy2LjQ0G1TxKt0zV
 OvuwICxUIxIHIDN4OitsgUjANiMe2cd1rSCrNJq5Y23I2yr/UAQ+wJa7d9ud0quW+mIu
 azMzG44f/X5wFxIMVG8Ncthhlr46w6Czv9dgaY/Bl2T4MBsO0nuG8BUywCHfN1y89Hwl
 3O+59ob8j2iDNTDLKEd1yTovjdBGyKoRHDG+tu5nVp42shErgJ+cFmlfBhtDOiyn/YlO
 kuygzvOLzoPPiXIdtUN3eFs2OjIO7VFQfTYH00UAxfBlh7JlUTBD3Ebs7/wem5Rmr4xZ
 NIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776871284; x=1777476084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRVwp2dnScW6r8xUQitR2DStMGtshyNjJneKJxOSVYw=;
 b=sdcyJBquyrfvJy7pS+msfDdyVo2A9YbM9WFL7qyabCEswlDeLFlaBn9Mece1Ktmxij
 jcJDSjM31E1Jw818kdxw98uYcDmbI36/KJq4OFgvdqg0EZV/MMUbzpGyaBN8E6H2t7ko
 3BKM1QT6/c929zka56aNhNvmrelB1WQttj/rWc53mY37PE2wyGbZqKukHhgZ0jY8JYqc
 E2EqZlxLno+IWnNXPwWhJRusMHRQ1bc0CrfWh5CTXBPiSahGQfZbH92SRq6IC+2Y/9gY
 qNgmOv0Nf069dbc8sdlhZ7H8iCw7Cih9oZSjRkk//VLGbMoVdHpaJ1gxzrqAm73xsVbt
 240w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1KNv2DcHt4bWfVOK40hJoHdV4wtaQG/AhE9qy0rUH3U19Xh9V8wtb4IlkaSyjfa182HhOCYQlKx8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1Z7pgYTJk4Vfnw/X9afVB7cmA7YEEPDN8nUMvGS+HEBL5HIt2
 8ZtIeOvAJu3luRGojQLtbgb+RaSkbFvK5ZYxs8cZcpCXAxeI3fVEfv8aHjfoPZa4hKwTVNPdGCk
 bVuxRsvAGV3X7/1hHKk3OMBH8FaeVXZY=
X-Gm-Gg: AeBDieuVFKgrUQhFODcLibCncgJelH/TxvNhRCBPZnrB/muiKlrpsvOMFKDO5C1GDUh
 0TPKI9yRgZ5M0lwMLbdZc+wwOwNcGziNkKMBixWgvdmXjlDL6OrLIJdVFYzLu0bx0DSPLDPQxZY
 wJ+hqvFWacbFzzlONkX2Al4Q9eKNUt7lH5fR5HQBmel1nHB/UVXn9/+m9IBWyn+8iZ5J7CNCOXv
 YP4s2EZfzORdC6pWr4516N1cQPJNF99hFXfcLQcMrIgBZhhSn2Zgb8YJCETLbSgpwz8IgYJn5rp
 J29tqdRoi+bNpYebbBOT8fAMs2vPG5Jz8ee4itjU7oFGjGhHP0H7U7Ssk2bBjjPWtU4oS8lQrUO
 SjIEpexx22tJPy5M=
X-Received: by 2002:a05:7022:459e:b0:127:332d:63e with SMTP id
 a92af1059eb24-12c73f9b5d7mr5030583c88.5.1776871284314; Wed, 22 Apr 2026
 08:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260422123817.1940-1-getshell@seu.edu.cn>
 <879c6e0f-76e3-4eb0-bada-b38230d0d23e@amd.com>
In-Reply-To: <879c6e0f-76e3-4eb0-bada-b38230d0d23e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Apr 2026 11:21:10 -0400
X-Gm-Features: AQROBzBgaNCRleXArmeRyzHxy-XR8oh864TQTHE93XoF24lgZ7zJ0UBC0WrRxuI
Message-ID: <CADnq5_PyPfz-Z9Cygy4R50RxLRDt08We5U0X3beW0Ta4KWeVdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: avoid double drm_exec_fini() in userq validate
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Hongyan Xu <getshell@seu.edu.cn>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jianhao.xu@seu.edu.cn, 220245772@seu.edu.cn
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

Applied.  Thanks!

On Wed, Apr 22, 2026 at 8:59=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/22/26 14:38, Hongyan Xu wrote:
> > When new_addition is true, amdgpu_userq_vm_validate() calls
> > drm_exec_fini(&exec) before iterating over the collected HMM ranges and
> > calling amdgpu_ttm_tt_get_user_pages().
> >
> > If amdgpu_ttm_tt_get_user_pages() fails in that path, the code jumps to
> > unlock_all and calls drm_exec_fini(&exec) a second time on the same
> > exec object. drm_exec_fini() is not idempotent: it frees exec->objects
> > and may also drop exec->contended and finalize the ww acquire context.
> >
> > Route that error path directly to the range cleanup once exec has
> > already been finalized.
> >
> > Fixes: 42f148788469 ("drm/amdgpu/userqueue: validate userptrs for userq=
ueues")
> > Issue found using a prototype static analysis tool
> > and confirmed by code review.
> >
> > Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> > Signed-off-by: Slavin Liu <220245772@seu.edu.cn>
>
> Good catch, Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.c
> > index 9d67b770bcc2..fe49108fabbd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -1193,7 +1193,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr =
*uq_mgr)
> >                         bo =3D range->bo;
> >                         ret =3D amdgpu_ttm_tt_get_user_pages(bo, range)=
;
> >                         if (ret)
> > -                               goto unlock_all;
> > +                               goto free_ranges;
> >                 }
> >
> >                 invalidated =3D true;
> > @@ -1220,6 +1220,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr =
*uq_mgr)
> >
> >  unlock_all:
> >         drm_exec_fini(&exec);
> > +free_ranges:
> >         xa_for_each(&xa, tmp_key, range) {
> >                 if (!range)
> >                         continue;
> > --
> > 2.50.1.windows.1
> >
>
