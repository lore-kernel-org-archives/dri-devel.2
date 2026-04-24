Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4997FED3D1
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D0E10F5D0;
	Fri, 24 Apr 2026 14:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cWLN6kwR";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6307010F5D1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 14:28:10 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12c750eaf4cso472506c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 07:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777040890; cv=none;
 d=google.com; s=arc-20240605;
 b=WCOEl8z+x/dvecfGobkMSVMxJc04bvPv6n9ILYmyjNTdISIjZP7u8N+rMiZ09zLZrD
 Dfk1jkWO2OycrMTrsgQO3Y0NIKVAKQcXmTZkKCR5Gl5GTHjQvyr8oL4vaN+sYosPpRvD
 HwSFXRvhaxPWq6oGks8kYEGZ23Fdupe0Z5TkrKQ6pKSue8TWXd0XDlxizQ2elUQPQfUI
 2adAl0kwu8knb4v5ldW8ivrGWzkFFC9HvYzIuhFop72dLgcjPV8CVwZVtW/Y3Rg3xSkk
 2zEh8s9K5BYoB3N9lvTN8WOX7yZ26ch7PGe/nCi51baFHVuu8TSpGbowPN9IGUcyUlUC
 ZO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VUnGOxMsE5B5u4ajUmOXsj9fKAVq9wRll5g8iH5CF4I=;
 fh=RrntfI/fFM6+77UmjxpzxrmiRKDHXc2YH/A9Shg9U/E=;
 b=CFTA2zSmgkCLCSIfGqRzQytov4rUGPt1EdVoqwsN7KipEkuNqNRXaD0t7xpAdOxRKu
 gCDZbhB97wA+0Nb6wMSLSybsHCmELOBm41pJMIu+6fCYeaaw3v/kuy6bE+bDwTAp6PQl
 QamXGwgBhDDj3pD53R3ZSSzTxnTAzJw8I8jh2v6yHpWAk9lpd8n6R9uBaS1AP++17Kwc
 /nvm7GuMr+s12JhCmrXTvOX9ouJtxyfuCOtgpiLCTVQ6YvrsZ8aYxaBUBREKs2krFpfL
 X+NK3c7EPMDvn2hW0uG+he0XRbYJBAAFe0FTDdOxAN4YqYtytX0oVuRdjzmyeLe4zoMq
 Ux6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777040890; x=1777645690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUnGOxMsE5B5u4ajUmOXsj9fKAVq9wRll5g8iH5CF4I=;
 b=cWLN6kwRmzPqxtAZ4C9A/mqkc1VveBlwbnvUzl4cKZhHY9QayCHUQfb0PtuwgQe7pr
 RSyZePgxiM/T5sjSAOZwz1TFiuIzZtkd25da5k1mW9UF4S79sBjikvRR+p/mSUwqkezM
 r48qUznKPLS64efzNFdusnbaNaRu/kQ2RfSFoPux5BgWpgFMv3pYza2d6cgImnGmPctc
 N1iIpjF7Uf19BvJSFYzHiNBwnZQoap/MciGS6G8qxAoQVR2/hpvA4L9OOVxtTcKnBUB1
 AkqhGhYE26zadoX+s//YrrKb0RxhP/J/nXgdn3AvmbJ2TKDZ0q27gh6t78HRtLplzJ4F
 Yu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777040890; x=1777645690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VUnGOxMsE5B5u4ajUmOXsj9fKAVq9wRll5g8iH5CF4I=;
 b=ViSgWYMghFzjmMDkuPLKKWohq3BAJpeyEQ2z2xo+YvCZkTffAJUliulynJIwAJwzjk
 58WZrvhfz5eVLeQrTQPiYSFNiH0uZSlXtvAsiShxJRsrp6ow8nFMGvkHAj6tn9h7DFJA
 JySIfqQUDAwoklalLeRCfGibNcK/xc+11RRuZc92fIW4rIqAb9DWYWY8ox2hrE54ETUg
 C3fxo8FHMlSFBQ2lYinHCL62ZqeBqu8POJRZwOAjk3sl/cO5A8reO0Q+KkAo/4gY4Qw2
 P/qU8tlP5IcLudKxGfDIcFUEAAGB8uNU/KT/H+ILQ8H+Bug4HXsIBm5pjRTkpN2X5OPD
 MovQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BpICYOoROk8PcIs3OkEtKhaXnoiBjZaUudlEXMSKcaQLg64990yWBoCSfp9QRMGbYFQHqXmIkyZg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWaaHn0D5F5p6/JoKWrfOerr6+3rpDuOt1yX5/nVhwQlMzXRl9
 PDM+7oMGuP9wLOtr2JGa1oO2ctWTreTa8RcEr8xvn5wCx7/HERcN0EastptLWWO8ejKUigk2rVg
 xKaspTOcg0RBwLnjuJ0ZNR7uxYzdqL24=
X-Gm-Gg: AeBDieuifJtLebFf7bSTnjAsnAuk4CasosCJQatuqvlXt/rxhh4oT+ck7IHkWaB7kTO
 B65InMJ0cZXzS/dpmAtOW0sqEI4NT4c1nMDpK6OPFAQuhemQj7pZuGpWnq+XCvIgr2/DmnUbQDM
 nvbfPbCoBTO/uWeagc/fypjGymLqPZIPl5yWy44HyFE9D4cLcJludgEsYzSkjc4+NKmBQV6utZs
 KOSVaWyErV4AI1/gvnIv+HXpZj6BVAJJjtYK86si6QkMHrnNYr9OfkzyrEqFYmtVAMR08ShRV7S
 8+r0GwZxfUQZZvMNtZwxL4HwszkLwR/qUVYbEot/fFC5f9Px4Pg1jeYzXwjMAYXBKiH4LT5K0t7
 3gOja
X-Received: by 2002:a05:7022:f8c:b0:12d:c6d9:5faa with SMTP id
 a92af1059eb24-12dc6d96099mr513846c88.4.1777040889420; Fri, 24 Apr 2026
 07:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260424004910.21003-1-gabrielsousa230@gmail.com>
 <20260424004910.21003-2-gabrielsousa230@gmail.com>
 <975a945c-1bb8-4dbe-9767-d39f3c98e778@amd.com>
In-Reply-To: <975a945c-1bb8-4dbe-9767-d39f3c98e778@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2026 10:27:57 -0400
X-Gm-Features: AQROBzCkU-HE18UMY_snK4d5BoDk-5ksSQuIfTmlSXvsabkGuvzO2DiI1ybJMeQ
Message-ID: <CADnq5_OTtKYeuaVBF+e+n=m9tTQ_K862-rS9Ax5XDWLEZqdw5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: move read_indexed_register to
 amdgpu_reg_access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Gabriel Almeida <gabrielsousa230@gmail.com>, alexander.deucher@amd.com,
 airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
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

Applied the series.  Thanks!

Alex

On Fri, Apr 24, 2026 at 3:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/24/26 02:49, Gabriel Almeida wrote:
> > The read_indexed_register helper is duplicated across multiple files
> > with identical logic.
> >
> > Move it to amdgpu_reg_access.c as
> > amdgpu_read_indexed_register and update all users accordingly.
> >
> > No functional changes intended.
>
> Yeah, as far as I can see we have already abstracted the HW generation de=
pending parts in amdgpu_gfx_select_se_sh(), so the change is most likely a =
valid cleanup.
>
> > Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> > ---
> > v3:
> > - split into two patches as requested
> >
> > v2:
> > - move read_indexed_register to amdgpu_reg_access.c
> > - drop amdgpu_common
> >
> >  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 18 ++++++++++++++++
> >  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 +++
> >  drivers/gpu/drm/amd/amdgpu/nv.c               | 19 +----------------
> >  drivers/gpu/drm/amd/amdgpu/soc15.c            | 19 +----------------
> >  drivers/gpu/drm/amd/amdgpu/soc21.c            | 19 +----------------
> >  drivers/gpu/drm/amd/amdgpu/soc24.c            | 21 +------------------
> >  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 20 +-----------------
> >  7 files changed, 26 insertions(+), 93 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_reg_access.c
> > index 540040c76..daefbeeee 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> > @@ -956,3 +956,21 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_=
device *adev, uint32_t inst,
> >       }
> >       return ret;
> >  }
> > +
> > +
>
> A bit kerneldoc here would be nice to have, but not mandatory.
>
> With that done Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.co=
m>
>
> Regards,
> Christian.
>
> > +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> > +                            u32 se_num, u32 sh_num, u32 reg_offset)
> > +{
> > +     uint32_t val;
> > +
> > +     mutex_lock(&adev->grbm_idx_mutex);
> > +     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > +             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > +
> > +     val =3D RREG32(reg_offset);
> > +
> > +     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > +     mutex_unlock(&adev->grbm_idx_mutex);
> > +     return val;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_reg_access.h
> > index 4d88e5cd1..a1011af6b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> > @@ -160,4 +160,7 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_d=
evice *adev, uint32_t inst,
> >                                   uint32_t reg_addr, char reg_name[],
> >                                   uint32_t expected_value, uint32_t mas=
k);
> >
> > +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> > +                                     u32 se_num, u32 sh_num, u32 reg_o=
ffset);
> > +
> >  #endif /* __AMDGPU_REG_ACCESS_H__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdg=
pu/nv.c
> > index 030d80664..72edf5326 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -354,29 +354,12 @@ static struct soc15_allowed_register_entry nv_all=
owed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u=
32 se_num,
> > -                                      u32 sh_num, u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> > -
> >  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
> >                                     bool indexed, u32 se_num,
> >                                     u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return nv_read_indexed_register(adev, se_num, sh_num, reg=
_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_C=
ONFIG))
> >                       return adev->gfx.config.gb_addr_config;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/a=
mdgpu/soc15.c
> > index 27bcbbae5..87b398dd0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -401,29 +401,12 @@ static struct soc15_allowed_register_entry soc15_=
allowed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
> >  };
> >
> > -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > -                                      u32 sh_num, u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> > -
> >  static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
> >                                        bool indexed, u32 se_num,
> >                                        u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return soc15_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_C=
ONFIG))
> >                       return adev->gfx.config.gb_addr_config;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/a=
mdgpu/soc21.c
> > index 7e4353d0c..93c002e51 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -306,29 +306,12 @@ static struct soc15_allowed_register_entry soc21_=
allowed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > -                                      u32 sh_num, u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> > -
> >  static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
> >                                     bool indexed, u32 se_num,
> >                                     u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return soc21_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG) && adev->gfx.config.gb_addr_config)
> >                       return adev->gfx.config.gb_addr_config;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/a=
mdgpu/soc24.c
> > index d1adf19a5..265db9331 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> > @@ -132,31 +132,12 @@ static struct soc15_allowed_register_entry soc24_=
allowed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev=
,
> > -                                         u32 se_num,
> > -                                         u32 sh_num,
> > -                                         u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> > -
> >  static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
> >                                        bool indexed, u32 se_num,
> >                                        u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return soc24_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG) &&
> >                   adev->gfx.config.gb_addr_config)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/am=
d/amdgpu/soc_v1_0.c
> > index 709b1669b..4a5fe8e9d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > @@ -184,31 +184,13 @@ static struct soc15_allowed_register_entry soc_v1=
_0_allowed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
> >  };
> >
> > -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *a=
dev,
> > -                                            u32 se_num,
> > -                                            u32 sh_num,
> > -                                            u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> >
> >  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev=
,
> >                                           bool indexed, u32 se_num,
> >                                           u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return soc_v1_0_read_indexed_register(adev, se_num, sh_nu=
m, reg_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG_1) &&
> >                   adev->gfx.config.gb_addr_config)
>
