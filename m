Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD75DC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF2910E4BE;
	Tue, 18 Aug 2026 17:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tMq5g2Nn";
	dkim-atps=neutral
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D86010EC31
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:51:43 +0000 (UTC)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-977fca41f52so34951241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787075502; cv=none;
 d=google.com; s=arc-20260327;
 b=ZoMJnJutCNNscSmRg6nQIu2kttMb3kE9F7P9+zZM1CfoBtnVDJBcD1VjfE7k7f2e43
 FVcZT+NAPi9eHr1GWkTiOXw0coVPyuOgyK4fFJPCY5WdQyRoTNljxqPbLSgGLWVEX4ev
 iXsZRTO97r0uJmIYrwqN/0LDRsqL51l9qJ0uTBbhLmr1z12Epi7RjiHjsBfbhR+b0Jw6
 983S7oRus2BAv/MKhxT7tLeJ6LAVdPD/HoIq05cwU1kwjursXd2M/Pn/Ymwqmfvw92gb
 mPIQ4iAPRMTnUR8pKHJjTaLj94A8PDnr2qcfXclmD8ivbfS9emtaculfGD1d2+O0aMB4
 gBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fj10KLB7ZYx6C7bHsVdJNlLRg+uyLYRvpM0Ff5BHU6c=;
 fh=RO5aYRvSpvn2WaPZJi2y/PHWBgcThkSRag8pPMKBj4E=;
 b=dxlA402TJTAZDiUBRzpVIdH4mtxlCB8EncUGMSO1UWfjfqe0C/eXUecYQ9fXcfju3U
 vghRR1ebaQmYn1GtRgRbw8sLXneD3QjMh4iXtIK/Cjt97Mwsq9CCpHheLOy1dCxsmKEv
 YbZXcLLR+1dz4u9ygLUY5aMLryY4g9oj8/rnCESTao7jiSvKrId5PKrXTfThGC2E98g2
 B8nqOTGRIuCwykjDS+IrxKDwguOfgW8pTHI3ny7q7FklYSNyIedLHxkMLF8U9ycrF9SE
 Ji9uR3FHP3fKsxjjefdtkgQ5XDBCH5laKRgrlWK3NgokxEzDJ0eCNw7zerV1LSoL9e7S
 RejA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787075502; x=1787680302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fj10KLB7ZYx6C7bHsVdJNlLRg+uyLYRvpM0Ff5BHU6c=;
 b=tMq5g2NnRWF06AQtuUu1NfxYL6C2EQqY/tjdMS0PxOA0jcktiExj3CYplerAZjaLc2
 TnC+TpEoDce69dLD34E8orUgok/L0FiIewQUcbsTfgEzLbvhVcRQUdONR488wR5LiSuA
 k150x0uJAMZ6+IOBr94YshYaUzXczHbUeGDcI5c73iHiMEXtWANW5udZG9UxQVQyvuPH
 jIjCmW/1fqSsZoq1dlzJ1z+mtGTKGunAs6WkIr3qdgbm/corT72/6rxt2Umxax6Ui2kK
 xGFEWUSvuE3pNr+T7M3wQouQz9uuJ3ToR3QBPgcyax5YJnmIKSTBxZC5hcpBMBxxBMdA
 r3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787075502; x=1787680302;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fj10KLB7ZYx6C7bHsVdJNlLRg+uyLYRvpM0Ff5BHU6c=;
 b=ep9i8y1o7PrLGEa8jykPOwQJFSkMSq3f1UJ69AcneMJMazAfAcqqulFoKfWp6L5Eq+
 QSvRtYCtSWup0+ZwdzwvuDvJzu/qqyfXs13bxhHVsp+cbNf2plHMSJCZdY15NPFq/Yf7
 KxDHs6xPMkJnAQZOXgvJ5pvYkq6FTeQdBqfYdJqM1tcS2JVFgSOaG0320Zn8sv+MEaXP
 JP9Ux7pA0JTcSYyXqJ7VYm53Ht16BtipP5oXMMpsTXSJjZWedj0VQXpERHYGdiNFLX9n
 CVCKTrdMuoS4gDu22/CRmpb2aSrFdtYLEyBrE9rMWyNny24nJG0cMlEOEqBaO063q73U
 x8Gg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqt2Ay9pN5sEnhklSZfDlkrWmlOyif7DD55FpSWUcPjqCFyRiqAanYkVtSCusXOW/Smr/lO5LpDzy4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznQURoktta+cvHv9KkojPEkn/Yv3y0iuAlQ5kNPT4dtYzLk+IA
 UZT657pP5sBraKUZdltHLfszXBjyXkALZkKsOK0dmS7NmgqLSd3w9tixRRQYRD36KQKxm93sTwF
 XgpR6YWYMdHUg3hwQ88gt2iNqrb82zdI=
X-Gm-Gg: AR+sD13pmS8Ee6XiQT+593y+6rnzaeg8uJ1sWdXIlGGGiGVbz3FAQ184wQhz8JZ+ri/
 /NdQiG+eY1wahYg4qYb9zmJsHWKfY4AmLsebu5XlMhe28rGc1EZwqK3cpsne3EDdl7uUrxla7x7
 MG8aHNZkv6GDIpazwYwsPw0qcmskUQUdwS7UBYHBmHrz2l8t0/GcKJp9H7RzZjLwQYIhoE4izGc
 p0d/ah+4ajVYcqj9M6usBUrJrIXaV+C/rvQyZm1IFPdvOz4bYrWwnJM5JY9s1NT+EXbcOAIv2Vv
 UPDDVo5hHwEkpVdNV6IZxpLJjvJQQXCC5Nf8oImgHE5hrFGtnCJcFZ8UlKD40X6stVTYnW0WqlU
 8+Q==
X-Received: by 2002:a05:6102:94c:b0:774:ffde:3d47 with SMTP id
 ada2fe7eead31-774ffde3e02mr2066845137.7.1787075501861; Tue, 18 Aug 2026
 10:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
 <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
 <20260818152113.31b72e30@pumpkin>
 <CADnq5_MOSxt4=15C941PyuKH0V6bubx7Wi55x5zoWjAsBS2ffg@mail.gmail.com>
In-Reply-To: <CADnq5_MOSxt4=15C941PyuKH0V6bubx7Wi55x5zoWjAsBS2ffg@mail.gmail.com>
From: Amin <amin.gattout@gmail.com>
Date: Tue, 18 Aug 2026 19:51:30 +0200
X-Gm-Features: AcwNN1VaQkT_kHjaCjLZSVMRLFOY1oYzfkYTo6gr0E6vTM151Wv16NiuEE2yq98
Message-ID: <CAHfa7xV-pPN0nAdd4q=bDYS59snoMf563OwS96_LLg4eb3yqQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
To: Alex Deucher <alexdeucher@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

You raise a fair point about the compile-time truncation check.
My reasoning follows the kernel's own deprecation guidance, which
explicitly lists strcpy() as deprecated and names strscpy() as the
safe replacement:

https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Regards.
Amin.

Le mar. 18 ao=C3=BBt 2026 =C3=A0 19:39, Alex Deucher <alexdeucher@gmail.com=
> a =C3=A9crit :
>
> On Tue, Aug 18, 2026 at 10:21=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 18 Aug 2026 09:01:43 -0400
> > Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > > Applied.  Thanks!
> > >
> > > On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@gm=
ail.com> wrote:
> > > >
> > > > strcpy() has been deprecated because it performs no bounds checking
> > > > on the destination buffer, which can lead to buffer overflows. Repl=
ace
> > > > it with the safer strscpy().  No functional changes.
> > > >
> > > > Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_mca.c
> > > > index cc6d1a4e4c3a..1caa393c44d5 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > > @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_devi=
ce *adev)
> > > >                 return err;
> > > >         }
> > > >
> > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
> >
> > I missed this being proposed.
> > Both strcpy() and strscpy() get converted to the same memcpy()
> > (which might itself get converted to writing a 64bit constant).
> >
> > But if the string were too long strcpy() would generate a compile error
> > whereas strscpy() just trunctates the string.
> >
> > Which one is better?
>
> I don't know.  I can go either way on this.
>
> Alex
>
>
> >
> >         David
> >
> > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_=
BLOCK__MP0;
> > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UN=
CORRECTABLE;
> > > > @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_de=
vice *adev)
> > > >                 return err;
> > > >         }
> > > >
> > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_=
BLOCK__MP1;
> > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UN=
CORRECTABLE;
> > > > @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_d=
evice *adev)
> > > >                 return err;
> > > >         }
> > > >
> > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_=
BLOCK__MPIO;
> > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UN=
CORRECTABLE;
> > > >
> > > > ---
> > > > base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> > > > change-id: 20260818-amdgpu-strcpy-0e92d18299c6
> > > >
> > > > Best regards,
> > > > --
> > > > Amin Gattout <amin.gattout@gmail.com>
> > > >
> > >
> >
