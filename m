Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABD2C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A3010E82D;
	Mon, 17 Aug 2026 15:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IzTMZgmS";
	dkim-atps=neutral
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5565010E82D
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:12:44 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-73e516d6ddcso94176137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979563; cv=none;
 d=google.com; s=arc-20260327;
 b=VgrGmGEt2oVCOODg19xJbvMTY/4npnFwYMhSRX93L2RHu7ejXAouau8XeeNHHtgyAF
 Te2Ed3znBOgMq5EuUtOT8jj1gPc9NxPboLDfxPFZAlKz97LLnbWbwEdCxQw5gK/NEnU4
 ewb94MHMgQiwcLmrNwOOfFt/niTzsJpUwH/ADatuMQdhK7PUEqthhs5OTRl1I2IH2bON
 tobv0byYmYwGXEek5gi4ukLWaaguCKlRgiTDia0QVGcxXgKJ2/TdK7Cuj+O/SNZBmBxs
 5EmGcEkH4hHs34VZMfFO3L/64/bfKK8ORzBo2zIl97iQb6HWkDRSjXEVWzqIQCkHEsr/
 OKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vaf9Cx5bbS91iI9Sw9I5LhAq5i2BXevWkKrJ5KbO5u0=;
 fh=eQNErawaF7q9yXpKBRWNkRlm4IB0y10ec6TFVVC8q4w=;
 b=UH4RKGJbLiu6TzQ6usVp7mllheOSmLwDL8dD+XfoDY7k3tejF7KXvzaonxgb+ucp1t
 062UMnLesst+/Nc/BisaYh3Od6zPAnhHMQyj7pvgdhFe643bbjdeuv7xcFk5npJmw9wq
 EgSWVWX3rBXcBdvAsbWUaNvK1gqzrS14k9qGUyVpy24lpjIx75Wsq21RqCtUgKIOfpXC
 zvu8MrT+7HR5L0H/ic175t0OwyiNa8db1MNIx+YTcAbbVeC0cqHiZqNYBb8wdXsV8hpq
 +QCjyrOfvZ9XHA6rtqXFDFEHH4vw37wHQ+1X0jUeGn2gouoCSATCkMUS4yDcBWFXoOWI
 3DYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786979563; x=1787584363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vaf9Cx5bbS91iI9Sw9I5LhAq5i2BXevWkKrJ5KbO5u0=;
 b=IzTMZgmSpobJmjpwI427ErVDoEgXXQNl1DRNQfNdiB2SbTxMxZns3GyTnwj+xVjQGF
 N2kdSYDOVGtJf1tvPvgPPSzM+MXM2+XMP/mUft6e6f1KAFDYZR0V2K1VejFk1e/uWRfY
 qoA5eGj5c00MpoGJr1ZJrqWgvlh1Luqg7jMmCHS5THPPuXT14VmqxxTXwNV/0778fIlO
 EniICeW6mJGzm4tE1qVKFADLwEwuNLME4dVRXMepcc3s8T4yDJvWooQYZGidRY2eK0ZR
 IA3PXoYbZAQnAh/agp1ryuK24AQZAvY4112MRWKGS7Jg2i3bfQ4pzb2/XorwC/OZtMgN
 ZFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979563; x=1787584363;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vaf9Cx5bbS91iI9Sw9I5LhAq5i2BXevWkKrJ5KbO5u0=;
 b=mlKhuxuVfg4z2gHmjD4wFL23dxMC8Ydw9jHAgZ3VG6d4sdtO4OddEWgEgBg3BehjWs
 H86YXDszsxWpaZCs/KfGb+MU5uWKF9uAwFhWwLxghdpVU+kVLkBKwjwwaEc9SNVK2Cw6
 Tmep35LA/DLPY5otJB9rbz6WZGMJxhO1BN8fXyCz0dI5XpbEg64iMwFpiLdiAiTaQyYz
 ANr09NDT6scRsBsRbs2M0GmwZEc6B9BIv376pB8O6iIzHdTqVXNY+zrxwf309q4gSrb0
 ek1VqdtaYdg4mOuhTCcbYYGMEsLBHw6iYMD3Rx1pmJdWnbYPwjn12cFtX/YLZg9TXUtD
 12MQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrj/k41jYBK6jcBbUjT0bNCmjNGGhK01IM7TItMvKe/BmVHYSZN5yLCsl4XBYvomwQqHmj4teWbYvQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxM5a1lCS47NIRFDSmU3/u/kiiek1GIKA8bzQQ5p5YVQvrPSwvA
 lODBc67LdugrLFGtPAAj6o2wc0JFi/OZaVTkq1mVi746meJGBHrDE4w7hXYLkxO46cPY3mhWtT0
 x6g3R8/DHAJ9fAPDzLyyEM5/95W+yTaM=
X-Gm-Gg: AR+sD12Z+mRe5iExS4jNuKVzKEzMN7j+4JgtPs2Peh9csU8oaaxBbvT0aT7vMHMQQhx
 vZY/dVcrBa6R3bJ81g7VN10K7kjNTs+yLD9npoxlNYvSZqrT6po0YmoyCramzob0GPHmWUkgKyj
 x3xEW1D0um5TdLfVlnSiNFMBHpz5vuG20uYe9bpH/AYxsAMtmUp93m+UPyXEVpqTayFKmdJI7YR
 DI7Bo1YlLk/ZvTzcqs4+R9xVMIzCOaeVkrQFjd018o4cCCel9B3/P7S9QWNE4Xny81kqVVUAys+
 P2UTFtIyKt2QtZvmxzbPbQ1hPCFBVDR+0V16STXuliv77vmJAj/RjCwffcPDi4cMOBenDPLb4BY
 U1sDCDlHaj7iKxjsgtAfo2kO4e4zKlkli
X-Received: by 2002:a05:6102:c13:b0:738:8d0f:72a3 with SMTP id
 ada2fe7eead31-76f2d5762b4mr1616598137.4.1786979563020; Mon, 17 Aug 2026
 08:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260814171335.1099999-1-colin.i.king@gmail.com>
 <3ec52129-0629-46cb-a0d9-cc4dc68a502a@web.de>
In-Reply-To: <3ec52129-0629-46cb-a0d9-cc4dc68a502a@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 11:12:30 -0400
X-Gm-Features: AcwNN1VF2iMgMunOjlyCoDEKc8oOXYaVq-li5iG15rUf9zg_MtFAAXGEZuaCAzQ
Message-ID: <CADnq5_M+DcrDvy+1pvW0u6prJYQvG602-rNkni2Dj06fEpsE_g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake "optmization"
 -> "optimization"
To: Rolf Reintjes <rolf.reintjes@web.de>
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Austin Zheng <austin.zheng@amd.com>, 
 Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
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

Squashed in the additional "resul" fix and applied.  Thanks!

Alex

On Mon, Aug 17, 2026 at 3:20=E2=80=AFAM Rolf Reintjes <rolf.reintjes@web.de=
> wrote:
>
> Hello,
>
> Am 14.08.2026 um 19:13 schrieb Colin Ian King:
> > There is a spelling mistake in a DML_ASSERT_MSG message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >   .../drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c | 2 +=
-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/d=
ml2_top_utm.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dm=
l2_top_utm.c
> > index ab9cadaf5a60..79ec5838c26f 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top=
_utm.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top=
_utm.c
> > @@ -123,7 +123,7 @@ static enum dml2_status dml2_top_perform_stage_opti=
mization(struct dml2_instance
> >       DML_ASSERT_MSG(worksheet->validation_result.is_mode_support_valid
> >                       && worksheet->validation_result.is_mcache_allocat=
ion_valid
> >                       && worksheet->validation_result.is_prefetch_valid=
,
> > -                     "worksheet must be valid on exit independent from=
 optmization resul!\n");
> > +                     "worksheet must be valid on exit independent from=
 optimization resul!\n");
>
> There is another spelling mistake here: "resul" should be "result".
>
> >   //  DML_ASSERT_MSG(iteration <=3D MAX_OPTIMIZATION_ITERATIONS,
> >   //                  "exceeds max optimization iterations!\n"
> >   //                  "\t is_permissible_found =3D %s\n"
>
