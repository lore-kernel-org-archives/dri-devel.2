Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626A1C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4826B10EC2F;
	Tue, 18 Aug 2026 17:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n/EOBuP7";
	dkim-atps=neutral
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A7F89EAC
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:56:20 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-977c81214bcso2697241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787075779; cv=none;
 d=google.com; s=arc-20260327;
 b=eO+ROTZzjHKVAfd5sO46+4ZTtnghlTWW9NnQnkJSquyHuDrUg31dLtcRERVu5HMT6r
 RDS3NI58+mCvq7gG76ZI1XH6G0SEnYa7w2QFEb4T5ALLSb4qYMXmiSrE69HLqHmpA3yz
 cGdy6jmQAIsd/Z+kJPmSzZNozddjZJUkZzUkkrGVuFt9H6ictvt8Ju6ne0GrShIdSCGi
 u5j4ECj0JVjCU3j4R3MxEZM3/t1/dPZwzZzFVSTbM0AQJZ85moD6X8/ninMeSNggrw8h
 e1he2a6DJKKycqBJ8brebyembZh6OR3DVQinD1rIhTbgz7yyYtEFGB9LeflEtVufU2pj
 q/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O2Guo2cfQRnj9tcFfEAaGvAISaRSftC/+14D5jKa588=;
 fh=0RW11OuIBysmMcTVWE2KQhlCr58/sR1F0Cqr6EEY2fk=;
 b=bfahQ++tKjc+iWlF8lBftUZmOZu5UKMW2tXHJ07JyTwqrx1k7uu4TYnOpdUaBezq1Q
 qPMnGx55j9cllj373jT3Shvod8ZVSyVKj/8kCM13lLyRqxiBGgB7mh7kFnVRQcSD5J4t
 TjP0n575g8n36hutiKNGzdgRyeGaIQ5L3odLKNjf8LSU3sh2pNWnCOnl7wSKzL2E0DA5
 UKXqjJ1mz5DCOWZVg+HFCUxvB7j8aYD1MjEn1AtAkoimL3GMDJFSwvKszFpBz9qjdTjf
 yK533QMVE2xi+gT7M7cY8g3gOjBKS4iZppMS2Ut/xzAdBrrtTttyqCid7m5PhXqxx07x
 NCuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787075779; x=1787680579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O2Guo2cfQRnj9tcFfEAaGvAISaRSftC/+14D5jKa588=;
 b=n/EOBuP7y6maEoZ+y3fT8TzcheUxorEy8DFa4p+jRIlhzM3V2xsnj0iu2T/gfxC0Op
 dsc0XAta8VkowaWb8kAlbDQY7U+wXLscks3g/zY7kpnVMiFLCtDzzJa+qp5TV1F89OiC
 LQIKcOQS9RwKRHbMqPfCyVR6Nz1+iPFqOrsC6GlEwKHOrJk2YOws3QaoF5tsnT+IsVFg
 +KMGEVl71X3YwuEYgVJr8yswVvkkywMKw+DZWVpt5cyBeAKvz1J0Yr809lvVGJP3Auso
 FUdcUHJGwjzNHo8A6kkEKb/tk9cMxwHj32jEsMfiVxjDuiqGAVmTZOBITyn+F7Moa8iA
 92bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787075779; x=1787680579;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O2Guo2cfQRnj9tcFfEAaGvAISaRSftC/+14D5jKa588=;
 b=XfPEtMxssslJcjBDwkbFJglgRCHqaDbOVsiPTIeDUwFCVbrLBEFStMZTTzCdn1S0L7
 p+C0JW/3QYgi2t6ASbcXP6HeNQUBZBGtsHLp0Avp6ntA2mo7GqHVLlq2vC9Vw0yiWcJC
 xOZI1UfDgY3OggQEwVwgiCiWrKiWIXZbsldlIKaGaU+MNrWKu2EZeyhi/1BYGgMvLLBA
 0PdGjm5ufToYTH+9zeWlLt4XIakHcrC5GeQ19EqV3eAJmWVSVz7D+Z9X5N43VGts+Z0q
 aGBNvC5d6TEi0MMcjOSdDTWBfngNP82dgAiAYTk/f00WC3vnkDXy3vv8+XqR42yRKLqU
 3B9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbI/hIbs2AjEfIoq17CfuLdznNgCb4fIR1WwtX1LIlA7tBJkAGbz7b7DZFUJ9aSZDtZypKShSdwT8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYZ4GUKxrA1DF8rOIyu7TUM0UYU8hYiywDJQ5Ee1sABVIJyrGZ
 tibDzR1wDfxas0LbEtACmxArsr40RIMC37zFoyai1K5kqBQBzp0xHzrAZHy88jo2sxheelkzz3E
 v5WDN86A928ebBAL6Cxr7ji1Gcd4OzKM=
X-Gm-Gg: AR+sD13IsyxZz/SbHFACUDsOCBc8BU9kp8nTnyVs7KL5oAo6TL5pbg6RErFsWiY+g4b
 TgON4owStneSDobcuXZKhJbX9G58QII+mfT0MS67pZZjgoTylq43/zYSDSd0ILtWy0DXdlNZlg1
 ZE+7tZocNWEpxcIo3D8ld77DF5X1EJnWoxiyszzFBl7fdW9sZFj89spSSjCfU8R43fq+HWJzTRC
 slpob8jbzNHxhDXJKghDk4jNYlX6OQ7lMu4D/42GR3+KDQlMR8egW+xoMs47cDelPX1MaCo+Mbf
 ydAjRB/k8r6qe4XA2OjFHxECu5J7qJ5CX8xL0DXZW/5+Jr9Ytcgehx8ZaKr9dXqSDtZI/vngAkR
 JUHX2simNefD6gay72P8S7a1mSKXl+oEMi4PLnH5QBQ==
X-Received: by 2002:a05:6122:6d03:b0:5bd:ae1c:afcf with SMTP id
 71dfb90a1353d-5c591f935b9mr3403639e0c.3.1787075778874; Tue, 18 Aug 2026
 10:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
 <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
 <20260818152113.31b72e30@pumpkin>
 <CADnq5_MOSxt4=15C941PyuKH0V6bubx7Wi55x5zoWjAsBS2ffg@mail.gmail.com>
 <CAHfa7xV-pPN0nAdd4q=bDYS59snoMf563OwS96_LLg4eb3yqQQ@mail.gmail.com>
In-Reply-To: <CAHfa7xV-pPN0nAdd4q=bDYS59snoMf563OwS96_LLg4eb3yqQQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2026 13:56:06 -0400
X-Gm-Features: AcwNN1UV1BDx6Pxjqmx1q4CmVpcvGtmNjpr811EmS5vHb4kE8vmCcTuMpJjKRpk
Message-ID: <CADnq5_NhH0WC_r7SVPyXOG4r36O++sUGis2Ej-A9J4MNJu7GoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
To: Amin <amin.gattout@gmail.com>
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

On Tue, Aug 18, 2026 at 1:51=E2=80=AFPM Amin <amin.gattout@gmail.com> wrote=
:
>
> You raise a fair point about the compile-time truncation check.
> My reasoning follows the kernel's own deprecation guidance, which
> explicitly lists strcpy() as deprecated and names strscpy() as the
> safe replacement:
>
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

RIght.  My thinking was that strscpy() would be preferred to avoid
static checkers from complaining about strcpy().

Alex

>
> Regards.
> Amin.
>
> Le mar. 18 ao=C3=BBt 2026 =C3=A0 19:39, Alex Deucher <alexdeucher@gmail.c=
om> a =C3=A9crit :
> >
> > On Tue, Aug 18, 2026 at 10:21=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 18 Aug 2026 09:01:43 -0400
> > > Alex Deucher <alexdeucher@gmail.com> wrote:
> > >
> > > > Applied.  Thanks!
> > > >
> > > > On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@=
gmail.com> wrote:
> > > > >
> > > > > strcpy() has been deprecated because it performs no bounds checki=
ng
> > > > > on the destination buffer, which can lead to buffer overflows. Re=
place
> > > > > it with the safer strscpy().  No functional changes.
> > > > >
> > > > > Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_mca.c
> > > > > index cc6d1a4e4c3a..1caa393c44d5 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > > > @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_de=
vice *adev)
> > > > >                 return err;
> > > > >         }
> > > > >
> > > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > >
> > > I missed this being proposed.
> > > Both strcpy() and strscpy() get converted to the same memcpy()
> > > (which might itself get converted to writing a 64bit constant).
> > >
> > > But if the string were too long strcpy() would generate a compile err=
or
> > > whereas strscpy() just trunctates the string.
> > >
> > > Which one is better?
> >
> > I don't know.  I can go either way on this.
> >
> > Alex
> >
> >
> > >
> > >         David
> > >
> > > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MC=
A_BLOCK__MP0;
> > > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_=
UNCORRECTABLE;
> > > > > @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_=
device *adev)
> > > > >                 return err;
> > > > >         }
> > > > >
> > > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MC=
A_BLOCK__MP1;
> > > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_=
UNCORRECTABLE;
> > > > > @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu=
_device *adev)
> > > > >                 return err;
> > > > >         }
> > > > >
> > > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MC=
A_BLOCK__MPIO;
> > > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_=
UNCORRECTABLE;
> > > > >
> > > > > ---
> > > > > base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> > > > > change-id: 20260818-amdgpu-strcpy-0e92d18299c6
> > > > >
> > > > > Best regards,
> > > > > --
> > > > > Amin Gattout <amin.gattout@gmail.com>
> > > > >
> > > >
> > >
