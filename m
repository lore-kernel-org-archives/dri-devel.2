Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC69CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508DF10EA63;
	Wed, 14 Oct 2026 16:58:22 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B8610E9CD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:58:15 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5c7d0f9cecaso190866e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791997094; cv=none;
 d=google.com; s=arc-20260327;
 b=bc8upXOeBMv5pIN+NsDIuyYrwWsCopE8FCEzhPU+k3ZFqEgwrSmxYvhCo+bYBuefSh
 XoIJ7UbLa32WDcUJa5UN3uJpR4/dQGVzkG2Cpqu5xjdN99JMQmarfWK3vrck4stCmsQs
 +I2MXyjB9MHY9lxG4cDchatg26f7uUF80DpdrgtVU223nEfPyP6vvjbAROpTkebfYKt7
 FmPn9zHzus/kMgU/2uxYZlfsSvn7S95WzsXKtkOQceVlnu/DfODX8FNJHeh3lddqRdOl
 w+IgTx6JZBWnkMBHWDlNyLwMVusK9FlIHbWX7aroVJfqfw1Sslm0d6kZTDzpDlrLh2hz
 qoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/HhNnMIsDqB1+l9DBxS7zqLucMRzhiJvM22vwbSViEA=;
 fh=brs8y77oZ7TpUz/bA735cMsCNRmhfr2ghD3d4P2TbhQ=;
 b=AJzo5RWUqklh8dH3KCmu6B7sB57UdJOalpLFk8/mRo1EpgY8rzFlOYcZXOgXKNt5Xv
 bz1BXTDH3hmDhrxpXHpfpuoG7tYxsIcmJpbITqV8EItuDnD/7hy32RtbGCr/OpyBIttP
 IMuoa/NyhRuVfwTL3AWNGgqEmvxufRZPbuJ8W0K6nFHkQmd/Q/d7aZ/DJYqYXZcCDmlO
 lFA6aT0e1VOCZ1NmiRQ9xBzIRVbCA8Q/3wH7XhzNTPX7dpqTLu/Q6sCtCqS4YPB0GfPk
 N8pD42RKcikCZTL9KaeuWQi73oP9+eqsLILK6nMZPwyjerYrJINha6qwIPxfaPk31wN2
 Aq4Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791997094; x=1792601894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/HhNnMIsDqB1+l9DBxS7zqLucMRzhiJvM22vwbSViEA=;
 b=PiYr733LrEKLCT0J+yNkqyt3wsx5uDbMJfLo1IhFaY/5A24+8CGcnLOMqlqw1fuRcy
 /hvbTQhmjNWWFKLpuMVaCPfdPl+/5xD2HcRIEdZJ2xrfGdGzDCQ79DRFO+NYZwYx1CC+
 NQIl9mq1lgwduVpfktit3wSOQIt5+QzuQymz/wA695P4n5JS0RvuDNT+QgZntV+wkO+4
 PtCqeO7A5txAUtUrPpM/ujqN2bYGHxEZyhipC8lGor6yYpPCHsy+UM6WipiYtmJVocgT
 Vu7XCC0VNB68mCY9JKnF+3SY6usPUyhkdDFnj0dtuMGHILzwMO8lUJ5kSsUEijhl5w/7
 QGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997094; x=1792601894;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/HhNnMIsDqB1+l9DBxS7zqLucMRzhiJvM22vwbSViEA=;
 b=Gwkf/M+o6LUEeFmsb18tI/bj5FoeWdcW2Skmt7quXkCa+DzGG32dt7OFnhPC4YtUH7
 VegsoRiYkQOc11T0XpO/cEpv/gITTzQh4GiJvCa4wVNPGYqy5662AFfZkL7rHeiAZYGI
 rUh9iSdYkl+4aTAvmYGHOjxLqea9Fy3ccU3OcTTN+N5HOeydh3FLd+mH8WpuqJj+N7ku
 y6RctyT12kmEc59SFE75hTfj1yOyByujlF1GgWff8vFtXPHB1ZypGMPBN6ivVrMn9aJE
 KIQhm9wokYFb/OPULZJuCAQTepRa3lCtvQdUkK/C9eRR09nez+JPv1R2laBfZUx4UA+7
 watQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByzQeQjG7ZVgTXmGiQNaHUefeuLsjjX5tqbu7pcm+x4BgRR32LckoZGsY6/olr2HxWfWFB7TQ4cDQM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLAA0//pv8g7+iMbg/THtjWuGIhO3kxfhrbYRqEQimjh9QJihqu
 Nuv5e/mzfsTm/CUObCClTQjHI2wpC4VC7TV16o85tjKEi4IWiqbHnCf8dsTwK0ouappurB0hzQv
 4neAKaDFkTqituz9TeQKUseV/2xxE+a0=
X-Gm-Gg: AYBFou250ixnDwMubcyOCJp+9dmTRCBKek4M4A3BBJfrlaSiYfJ4K0FykEaHjiirfDc
 GrGNqjQc/azLDBZqE6fcGSgl/KZ9UJrLQwz2ybQjDaNMSW/DJzrgoPpsX1pA1bJghoU8FqZhgKe
 KbV9AUb1hXpo1V4UJfuxTORGEJnOCMyWjGEQwf4NYag2Yto6LM0yHdcwS54S+cPZCzjoBm6tdS4
 1o05KwJlUmEvgaIt+0MwTQKSJF8t8ZqxUvwfkFCUHX8OcY4ikNHVyCc1L2cj1eppez20nzo5HRs
 juBq5kcTUhkSdPqa98x4nRq/HOOarscigmXwfrft2BibKKXRIXkl7km4b0TxswOa+xfX8RV3zjb
 JXmXzxN77sTLh8QKoTI+8qsyxAQHVDzNlf1UJv/R5rw==
X-Received: by 2002:a05:6102:c07:b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7cb3668aa3fmr4094273137.1.1791997094312; Wed, 14 Oct 2026
 09:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261014002858.172853-1-williandossantosdeoliveira287@gmail.com>
 <CADnq5_O0gGsDD96KkCTc71rPh1QJsBnWPw_XVvuwRoRQ9Wbhjg@mail.gmail.com>
In-Reply-To: <CADnq5_O0gGsDD96KkCTc71rPh1QJsBnWPw_XVvuwRoRQ9Wbhjg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 12:58:01 -0400
X-Gm-Features: AclHuK-keNlpItKGRgHS5Ga4AVpU-D6rkogwfe7eeC6U3-_jmpZg5nefB2U8zCI
Message-ID: <CADnq5_O=kVgSZoqe_ZVQDmVTWNb+OZ2XhmVx=0CPQQfCaf2idg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx8: remove redundant RLC cleanup
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
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

On Wed, Oct 14, 2026 at 12:47=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Tue, Oct 13, 2026 at 8:46=E2=80=AFPM Willian Oliveira
> <williandossantosdeoliveira287@gmail.com> wrote:
> >
> > gfx_v8_0_sw_fini() already releases the RLC objects used by gfx8
> > (clear_state_obj and cp_table_obj). The generic
> > amdgpu_gfx_rlc_fini() also frees save_restore_obj, which is not used
> > by gfx8.
> >
> > Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.co=
m>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> > index 7f91186ef1d1..088428e41f44 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -2059,7 +2059,6 @@ static int gfx_v8_0_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
> >         amdgpu_gfx_kiq_fini(adev, 0);
> >
> >         gfx_v8_0_mec_fini(adev);
> > -       amdgpu_gfx_rlc_fini(adev);
>
> I'd suggest dropping the explicit free calls and just use
> amdgpu_gfx_rlc_fini() for symmetry with other gfx IPs and the rlc init
> calls.

While you are at it can you fix up gfx7 as well?

Alex

>
> Alex
>
> >         amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> >                                 &adev->gfx.rlc.clear_state_gpu_addr,
> >                                 (void **)&adev->gfx.rlc.cs_ptr);
> > --
> > 2.47.3
> >
