Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFCEC5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D5E10EB96;
	Tue, 18 Aug 2026 14:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Az+NFpOA";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6AC10EBC6
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 14:21:23 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so12849645e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787062882; x=1787667682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xh6sznIcTWQR5cHVojCsxyM98WEjQuypf/fmpziWKAg=;
 b=Az+NFpOAu6PbeZF6+mJ3XoeEpyYSuqIb8lLQqHRDjm+5RNzBervVUXprw/mDDb0PHr
 SNUX0G52Itk0/FwKlSqbtgMeFwzJPjQHMCny/tXlPyYTrmae+UaLmFvaFE1rLFvEN+jf
 0LokU34HIPjfPWRRjr63FoWDd9RexVfik5MmMa5gr+mmUYrPO6kwwiPI8rpQg3pjkgi8
 cKjMAk8Szwp3J4zLCSyzyBJLNjIeF/IBn/JAXI/KDTAO3zpdv0xHJQObaKefiM7RyZri
 klpeB+jHVzlwQ30bK0iweabxQG3TxogR1c14HIW3oryz+5RK5/vN7qcyYSkzoH15WadM
 MRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787062882; x=1787667682;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xh6sznIcTWQR5cHVojCsxyM98WEjQuypf/fmpziWKAg=;
 b=RyIQN3vKs8WQLE48CxLVHnh6KCJeozqV7epUZEfg0/SlMT8KM1co9o0cHr8B6CFugz
 Q9XktZ6/IamHnZq9QxshkwRdxvjIy/iL2t5EXdVX4b1Z8uwicZvEJ4ra8YL4m4roO5v1
 wnmWcSKxVUJ2K9+izKnOH5keqY2pUQs8y+ZGihLC++mT6An/fp7NvyuTPIWjHxnWUfex
 GgG6ieJUI4ZYuzqvckh4palEu0SN/hslF+nbM33ynKwePjEWd1KFlKIVqwfKqvEt1uV5
 t0SJ2GdWz96/0JSMIG8Jrx6P/1tt8k0bwJ3YTSwb6xe5jFclHcRfzgEFJZNZpZzoBS2Z
 EdeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7Frzmf90JeJDFd7mltxQLD53XRBQBAElsDa1RouFZvgbXGSBRPEQzkEZ0HHaIvzjUYQ5fQz0TwuY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyub299GMjLqIYA1hPzP7dBAguLDsYvg5CL/d1QIlp5U+R71G5c
 QAWLFSqtE8Uk1wmV89y88VTINokbpR35l01aGtjcf8/Q775VYEnumU8B
X-Gm-Gg: AR+sD103Gt6fF9Uu5BG7JlkbLVQElMPuDSJ3YGY1ye5f7cr7gJoUEs3TEnUOAWaacoC
 rk+eKqK3+zFXJDStFDy3ixjhFnQh4ubcR7bThTwkeY5DnpsmW8dX4rG0X7AupHz5JrsC09Na237
 9sajzN+AJHJjIlIIw9Nh272GlcfjPjw/0iVJmnHJJG+S1ndRA+92ICEEYvwlPNm8x25Qsrz92YP
 1V7kRF2nvsoGu1mgTNLYJz+of60I3J8jeC9yz/13DRxP2csqbTMK87rfE/u7U8xuOKbMOeT5Mgi
 YLnCAAwxUlYSxjywgFv6tQMrmCqBzfBq9qlu/X+q3kDieUP9Um8RUDIsQWpUhbSjBeCV8gd6IfC
 H9G6/AtaUXnCbBIPdMgCu3SUbXexC6sH9JSbER1OyvH5v8kcO5CsjdbqQyp0SCin9r8gWWrCD0Z
 cb2BpkWvLt7O91ZSVwROaYRByvmsPWodr68QfeWISAH78xWLIjgYnLfxiYyN4fW6sXgb7YgDT04
 bSa9koKBTxsF9Lb1ils1ZbxfA==
X-Received: by 2002:a05:600c:858e:b0:499:5f81:8ca1 with SMTP id
 5b1f17b1804b1-499a08d2c5fmr119294355e9.6.1787062881505; 
 Tue, 18 Aug 2026 07:21:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b81715sm12428769f8f.35.2026.08.18.07.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:21:20 -0700 (PDT)
Date: Tue, 18 Aug 2026 15:21:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Amin Gattout <amin.gattout@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
Message-ID: <20260818152113.31b72e30@pumpkin>
In-Reply-To: <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
 <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 18 Aug 2026 09:01:43 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> Applied.  Thanks!
>=20
> On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@gmail.=
com> wrote:
> >
> > strcpy() has been deprecated because it performs no bounds checking
> > on the destination buffer, which can lead to buffer overflows. Replace
> > it with the safer strscpy().  No functional changes.
> >
> > Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_mca.c
> > index cc6d1a4e4c3a..1caa393c44d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *=
adev)
> >                 return err;
> >         }
> >
> > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");

I missed this being proposed.
Both strcpy() and strscpy() get converted to the same memcpy()
(which might itself get converted to writing a 64bit constant).

But if the string were too long strcpy() would generate a compile error
whereas strscpy() just trunctates the string.

Which one is better?

	David

> >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOC=
K__MP0;
> >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORR=
ECTABLE;
> > @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device=
 *adev)
> >                 return err;
> >         }
> >
> > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
> >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOC=
K__MP1;
> >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORR=
ECTABLE;
> > @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_devic=
e *adev)
> >                 return err;
> >         }
> >
> > -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
> >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOC=
K__MPIO;
> >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORR=
ECTABLE;
> >
> > ---
> > base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> > change-id: 20260818-amdgpu-strcpy-0e92d18299c6
> >
> > Best regards,
> > --
> > Amin Gattout <amin.gattout@gmail.com>
> > =20
>=20

