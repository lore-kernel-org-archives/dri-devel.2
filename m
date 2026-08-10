Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EB4C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF13110E0A9;
	Mon, 10 Aug 2026 15:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K5cU2qrF";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A051010E219
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:19:19 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-384422b05b5so197713a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375159; cv=none;
 d=google.com; s=arc-20260327;
 b=f5WEXOOubhwJtS0LpPNa7c/ahkmir6NVqNMOG/W/bWNDN3YIUkBx1hDoHPOEHew0GN
 xRJdMICLKy5QlL8XgsXd8xVokpMHyikxxSrrDEn8YIyuLt2eKG07M3e8whTayfCBe2p8
 1z7bDQ1nHHABCzRNDh2eq6bdFGSdMwtxYpBzLxxr9bnyQVeTm6DTqGnDUww5uvX5o0/W
 a2btif/0D7E8BbPRuxV2eAPXlRlJSjARvNCdCP7h2/zJk69bFhBG2IINLa+W/CbyVOoq
 yEgqQvkWPtHaC6Ui7LCMM1C3ThSgUiBrJzTcSbQ54M7dUf4hbWwm3MESeOIiHTG47uRB
 /WBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B1rzR26ClzMaYFuUSq8Lzwl7sxG7gX5jiXeOHc3Ewd4=;
 fh=KUUGfllrikjI6XQaEK5ihUMxXxt520W58S5+cdPH5dY=;
 b=TMeAlWUrmzumrWOqctQs5GEXWuUSu9vT7S1x7RFTZjYZf2D3F5TxhfaLr8pAJ9/zNJ
 zI35N/D0O0yJMV7SfmEwolopt4MBvt/+uEzkxBnDs8S0ayIFI/sdT+4pvpZeGt+5tl0g
 myi1mgQWL/4Eglycwd/VA0HZXHJJAEC+K2zMotWcJCvlwIt2hZ+SlYnjV1740IdwKCn7
 PDLXPS0sJBAH3vsGQOuAnixjUiG7BvaEsv5nGkyAQNT06al295Kdb/W/899XNslsd3aK
 z/Ii3/gqHfrvKhLgX/qHEo3YkCecD4nuy7gbw6M7sOIFxTwxt1Ch3ypvJyZ2Ne6o02A/
 ejNQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786375159; x=1786979959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B1rzR26ClzMaYFuUSq8Lzwl7sxG7gX5jiXeOHc3Ewd4=;
 b=K5cU2qrFyZ1ww80toj9JWERD2lU7AMA7P05aI79IBsj8gnS4sUwoW1bAJdWZx6fM6P
 tbY424M3aMqDOum9sSD0ISYXsSrtq8GGT7T7rf9FYrRBMLe+mY7294c79Grz7ggx0FUq
 8nzBAVbhaMj9oAlwZm0TlqF80YNh/OYD+enai5FBe9aaVo3GyS/L2Ef2LMH/gaCoMIN8
 UTDciBj2vRWKq8UHJBg9G+/J1oEFipHvQT5iILfAkYBlMHGWbX8Ei2Ebgv/9q1e6jNJN
 JAqM3D96NYIs7BlyzU7jI9oQ+Yzo5OIdJ4tYr8hgYvg6lxJ9CAt/Kd+QZhThwjkWzKDf
 w/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786375159; x=1786979959;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B1rzR26ClzMaYFuUSq8Lzwl7sxG7gX5jiXeOHc3Ewd4=;
 b=mx85bs4iKJAHC+6+LVqWsKShi1ppdy59y17uJzcBuGBjMAdAH051mBaz3S5gjYe4NC
 /dGZEZEMutQlgwqPftsIvwOFGK440kp4EfiQe0FJXNFFe2TYrvJvtgQparDRA9Uz+I4g
 u2BPwgQmq96ODtm30xk/u3DUtcMIBR7Nk7HawXwAnUmHiI69lxUv3DUfrpy9i+6Nn2bQ
 Q65btsWY6E9akSa0aRf4oKLx/Q7SSH8X9o9ThJUxN3TFr07RVCNmALfimIb6xv3UTnQ9
 Zs1XIiqFswrrPRGId1bKlQ4qI/pPz6+3l7/9KdEaoFz5UAu6OO2L47oJvBw11uke2ZYb
 9z8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzEqGdRutVB79YoWo9oHp9g2vtnUKRXoEj7MlYWAL23fJ6zSgzFmKOmEmtSnrTjYCOKml0tGa3vrQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+aLdYX+xFyozn8h1LzPjmaH0s55RNCp1DAcI53PrIL2ZAyRLz
 Ih86ZcmPY335q7dB/KQ38NupoOhHyYOGKPDGYXeNAGuEGSP8hLEd9GsK4w6UVvq1fPvG59AoXwb
 5O19qe0CfWXOJ6206Pp82BBYpA79JfHM=
X-Gm-Gg: AR+sD118yNEjAdJb7WoAaIx7fV1+o5MYTKnoOYSIaenk9vIvOLXdYfmP0hyjzrVqczV
 UYuiw4rBsL+4flhsAmu6edDkxeHZrL753pXoEvUNEG2MneIQ0PCCTSPxrYk2Q0PXbLhynC5O+sL
 GWlEv0uKbV6YWfYEVMx24gG//CSLllUtMdq7TgBta06Epyb7KgRb7BiFtQYQyJyoOgd5KKcW3op
 QyIVcFql7eSGx2Gqx7a69UD05kbs0M7pCrj95IP4HM0iT2INt7WUzklJ509bvf8jHOCqwuFP0w5
 26W8kNU0UodN/wAbgdxWw6tlCEcoviVduzwIviGmWLjzpiGfFzxqH4vLNQmcc6nTnVTeiheNT1p
 5UVsijn66k+TJojocWKXK9BUrRvNEjXd8Rt9NbSMCNYo=
X-Received: by 2002:a17:90b:1651:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-3903c7278f5mr30731971a91.3.1786375159041; Mon, 10 Aug 2026
 08:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <aneGaKJUl_Jyu05n@stanley.mountain>
 <77e1ef2b-24ab-4492-bc91-08c01f012a46@amd.com>
In-Reply-To: <77e1ef2b-24ab-4492-bc91-08c01f012a46@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 11:19:07 -0400
X-Gm-Features: AUfX_my-fKt5c9y2JIhF4-1Z_U26HVMXLUvLd5Y3sRxip_FQzAlVj9Rt96mRi6A
Message-ID: <CADnq5_Mc89DZGYwXrCQ+WLYVE8RBj9vdV5TBbZbwgcuV==HeEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: silence uninitialized variable warnings
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Dan Carpenter <error27@gmail.com>, Asad Kamal <asad.kamal@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yang Wang <kevinyang.wang@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
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

Alex

On Mon, Aug 10, 2026 at 12:50=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 09-Aug-26 1:11 AM, Dan Carpenter wrote:
> > Smatch complains that:
> >
> >      drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu15/smu_v15_0_8_ppt.c:196=
4
> >      smu_v15_0_8_set_performance_level() error: uninitialized symbol 'r=
et'.
> >
> > In this line there is an "if (ret)" condition where "ret" is either
> > zero or uninitialized.  Initialize "ret" at the start of the function t=
o
> > avoid a potential uninitialized variable bug.  But also delete the
> > condition since it is never true.
> >
> > Fixes: 422b399b09c7 ("drm/amd/pm: Add od_edit_dpm_table support")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > ---
> >   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> > index 59fdd2319b66..c78e611d2a25 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> > @@ -1920,7 +1920,7 @@ static int smu_v15_0_8_set_performance_level(stru=
ct smu_context *smu,
> >       struct smu_dpm_table *gfx_table =3D &dpm_context->dpm_tables.gfx_=
table;
> >       struct smu_dpm_table *uclk_table =3D &dpm_context->dpm_tables.ucl=
k_table;
> >       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
> > -     int ret;
> > +     int ret =3D 0;
> >
> >       switch (level) {
> >       case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
> > @@ -1961,9 +1961,6 @@ static int smu_v15_0_8_set_performance_level(stru=
ct smu_context *smu,
> >                               SMU_DPM_TABLE_MAX(uclk_table);
> >               }
> >
> > -             if (ret)
> > -                     goto out;
> > -
> >               smu_cmn_reset_custom_level(smu);
> >
> >               break;
>
