Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CA5C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D0510F2AF;
	Thu,  6 Aug 2026 20:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eB74IWnd";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988BD10F2B1
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 20:25:52 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38cfcb507a3so343643a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 13:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786047952; cv=none;
 d=google.com; s=arc-20260327;
 b=Xw9S2FoymN/b8BM1oGhBT69DmSEFkKmubtDpFPLc06z27OC/1PIrCZkoqdeM8xFkCE
 YZTrbguh53DWLQhZx3d8/kglrY9pCDJes1UFl+4gxePxQ/xU8PHz1uAPX/FpYIXvaEnr
 HQ4z6K2uJNeQu/e3CZrnzts8pTyWPs65xxM2we2tWXA1clEQWM4XnlCV0nUpRWyfHGYQ
 AShxl2SRoGO6xC0NHhTX9fi9V4rmH79WD6z8hhq7UlWUzK7JAUYCHvZwqLrXoMv+mqi+
 58rFH2Q+/9okYZg1w643Iejl/eN2IzHbIEZrPXi5fzWph9rUWSIHMNaQ4aA/Y/Rkg3FW
 jIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UB/TLDxrBBY2QlfdHBPHAu0QzanH7iO9OxicGBoPGLA=;
 fh=wrFovJ1+CVvCSvN0ELbozPTRswruIohhLPPl5okbTAI=;
 b=NM1pSQ2SuV48XPmecC3MNx4mIg2nlbduP2LeuK12SOkKhyeCuKsXj5y86/DtGQIj4t
 AHn/Ju4hvkwl6b5SnfUNCZhWfcBOr5KUl6nPKBexuwjCHiE2+IL4JJwxmG0wSNVQyC7E
 rc2n6ckzGV25ZQ8fYqwo0XuLcd4GLjC+52CGM4RN5BsPqNllNUx6yvcWrMjrRc+aYGlH
 QYK8xZiTTO7L/4p1+tp3IXVdRirPZt5TE7QCigfpGk0UBd7dJjN8LGuqoJvpruaG7UBa
 zKDgwODKcZ6BVEOo+btLxECzeS0/LS7cDY6nCHDSql8s8K5GqsFtKHyXuggqzjQ1QRoJ
 56ag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786047952; x=1786652752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UB/TLDxrBBY2QlfdHBPHAu0QzanH7iO9OxicGBoPGLA=;
 b=eB74IWndRiG121Jq+oAkfL3Q/D/24KqWcB4BMJhPmLvvWdNxoUmsuJiJ8eTuZX75VF
 2CcG7JELo/zVEM8+0y90QdLByXGsisea9EdWdKlC0WKLjvh7Y8u0S7GZUEMmbrx8wjbM
 PisQJuA2bx617Nadwj+WwkPk61YFE1kjIocm01qFoOgbmhvHfl3vybRwNwiQjwmmA3J9
 tuBrsWHvmO72Sni0Au2H4a5lVZ4jcVw6zY5EeeOF6qziLMONLDxgd3bSwzvPb79JTmen
 fyXWK4fNlOOsK4IhFoHk8bAhfW1RUobRHENvIZ9tWvbisXIIKuhH78a57Xd17XR6+8zb
 0X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786047952; x=1786652752;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UB/TLDxrBBY2QlfdHBPHAu0QzanH7iO9OxicGBoPGLA=;
 b=r3Oy1UpfsOq+Dk3MKkV8CevD2iEnS1kIowZB8v1r/AHbqUXc9bpAvjuM07D1xYO8zT
 /B1QjyQNKtxMG4Kx+8pQZR/43Vuik6cXKsujwxp/p/R2i3qFtAl/KWJGqA+FTfNHkvP/
 PGh4+PmiaJquXKLTHVWnO7mje+4EX34oPDs1iZBoEflNmcG95kfep8KU/2xKe8SKVlCe
 PFWo0Iam4LGSHZSOkNuoXZFZXCP+4a0csjinSLxjYqr0E5UIActNl0O+RxhwjJYcwTYw
 C/lyd6SNQW7qO8A5Kd9OXr8BpUt5zuZMzhRe2npAK5i+YrO3+S7ytQ0m1cbdutdBHSNG
 hGSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjRIqwa/FG506fthTuiFN5+YIRlBY8q0ilQgqVSGoSnjbyRtMNpLhcV7xqEAViZ5H+uqkEINpYzFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc4rtOk4c7Sjma/lpcJesW3Jqflnwnpw/HfpahMyYE9mLA4knl
 9i7V2MgGa7M5SeFOXclY8O9Y/fPvbmgnwgD1nEm4w5BAx0i/GzhpfOcAwcfExnIYY/8HN0OkvEA
 xIt3LeGEp3/MwdaJTVSXOQUH6kp30n+ar+w==
X-Gm-Gg: AR+sD10aaHYQxC2vGopA4zN4WkngIqsMp+0xnOtJYM67d2FA6RwRNPMybRGYHGoRzA1
 JjjfyRIUJusqrIV5U1L71guf6LnQVSyakrDUGryPFxvClkjKWZZnA+GqO6eIuhnl2v4ofI/FEnI
 WmahVDTGGlsXr1rHC5+A1oN1DUUN3SjHLb+a9fnhrR2xfdVo7PIilq65Bz1fhmaS9vv5qtwEYV4
 KTV+bqzov3q4XaTTZ10Z079q6z6gVztKzdT5/Zf7WAspOkfRa1wI4DULpHZYz8rFrBE/Dg4nizW
 JVheCiUba8fp+mmXfPIXar4mpG+xLqNqdQoXNFpFnz7JUpNISih9vvwcYKpjN8ZvL15KGQUe2Mz
 8y10IH1mVQt2erk6KRE6fgCGbGlJPaIg=
X-Received: by 2002:a17:90b:3a81:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-3903c510c3cmr11918552a91.1.1786047952031; Thu, 06 Aug 2026
 13:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-1-ce247012d4da@outlook.com>
 <75a5fe30-4ae4-450b-8053-2a4633c5115f@amd.com>
In-Reply-To: <75a5fe30-4ae4-450b-8053-2a4633c5115f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Aug 2026 16:25:40 -0400
X-Gm-Features: AUfX_mwniMh7P5P2yqjjnyFH_x3k9YJsgfjH2jDtORPTDpSehrDugpH-kLVXCOM
Message-ID: <CADnq5_O3FeOFFmdR0tQx6cATN9PRmS43Q+4+HZTSXnb5HVUqvA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: disallow multiple FENCE chunks in one
 submit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: moonafterrain@outlook.com, Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
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

On Thu, Aug 6, 2026 at 8:03=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 8/6/26 06:45, Junrui Luo via B4 Relay wrote:
> > amdgpu_cs_pass1() dispatches on chunk_id once per chunk without
> > rejecting repeated ids. p->uf_bo is a single-slot field, so a
> > submission carrying two AMDGPU_CHUNK_ID_FENCE chunks runs
> > amdgpu_cs_p1_user_fence() twice, and the second run overwrites
> > p->uf_bo with a freshly referenced BO without dropping the reference
> > taken by the first.
> >
> > amdgpu_cs_parser_fini() only unrefs the final p->uf_bo, so every FENCE
> > chunk but the last leaks a BO reference. The leaked BO outlives handle
> > close and process exit.
> >
> > Reject duplicate FENCE chunks the same way commit fec5f8e8c6bc
> > ("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit") did
> > for p->bo_list.
> >
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Assisted-by: Claude:claude-opus-5
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks,
> Christian.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 5445f75741b5..9c514cb01096 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -228,6 +228,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser=
 *p,
> >                         if (size < sizeof(struct drm_amdgpu_cs_chunk_fe=
nce))
> >                                 goto free_partial_kdata;
> >
> > +                       /* Only a single user fence is allowed to simpl=
ify handling. */
> > +                       if (p->uf_bo)
> > +                               goto free_partial_kdata;
> > +
> >                         ret =3D amdgpu_cs_p1_user_fence(p, p->chunks[i]=
.kdata,
> >                                                       &uf_offset);
> >                         if (ret)
> >
> > --
> > 2.51.2
> >
> >
>
