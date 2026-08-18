Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DD2C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B089210EC29;
	Tue, 18 Aug 2026 17:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KZu7ETWi";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D8610E51D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:39:40 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5bfa1e7e123so5118e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787074779; cv=none;
 d=google.com; s=arc-20260327;
 b=GAe2SyHeRgxLGvi25ncqHOLYEbomzZrtuLImfcTPuVaT1xl6lg6xjYP7X+AdNdA3FF
 x69ejQx/0W7CshOR4bSeOKq08vqmgw8ntpojdh9Qq0+zneFpNDEyKPkGuznbK9XwoxTw
 O99VGunHhe3ZPbovqt32B1OgHqV8cwwtkWJpHmCHcPBscI9GxIaH+sFFUblxqYD1VELn
 uTSSy3i9DBAy+vSeiCAE7Zv/JjXGtOzUIQIHNUR4Bjh8N4uUWlwXydlE3PUveSuV3eFB
 zQ9ICqPFMaigjHBh7TZsxauoX60Az1mtQO1s3+UXsPgleQD2wLkf3wRfKAe28ixm3hur
 3H+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eEckY2/FWef46lUE2RU5Sdg+eCXq1PHhVlFbUmRSmPA=;
 fh=paqoLFvoFCMayeVZ2N/AiSyndYowW2kxQk5yu8fubR0=;
 b=TsilWTaZgqu77ENYddbtrVkjAHQ4K4iHGOUpyHsSwGtI/693v7sYPfC7C6LQmzWhFN
 PxzHLGnl1d/0m32+nFTJVrcQDn0dJs5f7/x0dCU01TNhg7wNAYcxQzw6baJBVtOQQGcl
 PSIZhFmGehmKG1sCj7AhfvXKEA2OXbsCHFBbjksQ2akSojNGOKICXFbTWGyvW1qaHmO5
 Rt84IHEvjb5JEHDvdS38Y0Qhek+kcFU6eseTr76p+JYvzeLkZ2higuHt6bx4XOpm8cgI
 X/WSXUyQWxX1emO3nwhGXA1W9OR/kb83UxzQKzp3SzRQ1kLidWt3nMK8t1puDUysln0M
 k7rQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074779; x=1787679579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eEckY2/FWef46lUE2RU5Sdg+eCXq1PHhVlFbUmRSmPA=;
 b=KZu7ETWi/JPtcmIdqIsk1ycfh1Q0h81/6ip/C31gWWjTUGsAssy4C//8y2JHCHAm0F
 X3tgIlVapYLfpjmhYpyeVMs0ch79puMbLjfHl8Mwv4plK7cJ5gJvd2iyvY3KFDu9vaZ9
 HLXsQJUjLnk5eERkuydQeP8RYC27dPi9mHq/EhPgbp3/PJWNfSesRvh7rD9q8f2H2aNK
 yhJ/nxAK5gw1Gf3BRwHlALG5VSIN3Cv/d8l/WQf8wRDLqUp2JmVsKTTGw9eDtlf+x8CO
 ycqV9TnvBN2Isfyh05ryA2ioisc5+aAguaT6Vsol7kseFCr+Hdcx84rEBvwKZoC3RLxX
 jPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074779; x=1787679579;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eEckY2/FWef46lUE2RU5Sdg+eCXq1PHhVlFbUmRSmPA=;
 b=tVDwqqwD5Bip2vVM1i0AebczG9gQ7ddpZroDyqUGjWPodtorQU5Pxd8zJc6OztntoF
 sHrGkxNAs6hi5qo0Sum6a/V34WnMAYbcBEdbFKQVFg89rzbnTrs2QiztQTfRnJ0TvEkt
 B0jROv1fWUfuHz61gkDUBWMzBapao6Mdn9LLVHkI2hnZY4HhTblvzjmkhvmpVG69cb5g
 YULDsBISfj2HF9gl/6ILz6b7TqlG9qZKt815NTIW7Ge/8yErDuuLTQU2mI5ilD4aXuw6
 nE0E9wkQv8Jp5JC/PFWcJweZX8rH8rk5EEShP+P33fu7rwqQTsryjcdqFKg/qF6f/fja
 H7TQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfAZenQ9OC2pkQPnUOXmkOXBt/QQLPUwkHTTRCYcVNJzI1bNpX0NKp920Rmf9eki+JLuompuhLvwo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqubguRFtu6nimMNaS2hIkwwKf52KhYqGy0Djpt6G4zmY9WEPz
 z5ndELBkQqVk0D8bfcA1+9F29Fnl2WRLZT4sRtgkYoGEe8/y6FCp0P/dAR4hscsOTSgmgiRk6FS
 vjYrnm7XjvAi3Go8a5eqw4vKE/P5XHj4=
X-Gm-Gg: AR+sD11aLX5knX0mpogJhhJVNWCfG37/6SeBwU2Ab6/zEEVWvdgVs+45MsFLvq3JIgw
 4vvLtw4q06nGYYsg2qE8dX35InvRzF8uPxIkBKbD5xU+ZAd7QfaRYjLyI/yLaetfJSqxLFmBfof
 ISrtDsyrP17bz7NaNo0TNsqMLKU5hcdR2/VDnVf1pj5JyXsDMnfemfFOTRB8a+Kv+rNW6DOJi8E
 6wtSNh23klc1zNpdBW0YqS9PpMzpuaTzapvwJsp2rInYRvFA9deXGG/cug3uErA5d6FeiZGwVOa
 aOviSa8WJIodKzW0ZP5PaK7Ae518IBOK8jcD6LBrsSc0usnVTX/jFZCl8gYdn0OEOUwJF8DDWDx
 egj4IBPp5NtA4UARUSr/O2ev83H010so=
X-Received: by 2002:a05:6122:6d03:b0:5bd:ae1c:afcf with SMTP id
 71dfb90a1353d-5c591f935b9mr3387342e0c.3.1787074779223; Tue, 18 Aug 2026
 10:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
 <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
 <20260818152113.31b72e30@pumpkin>
In-Reply-To: <20260818152113.31b72e30@pumpkin>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2026 13:39:26 -0400
X-Gm-Features: AcwNN1UdAawiuNlezTn1mx5MGXf0fGYUPgu4-splMDm1iIm25D8BbUfMfTsnfsM
Message-ID: <CADnq5_MOSxt4=15C941PyuKH0V6bubx7Wi55x5zoWjAsBS2ffg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
To: David Laight <david.laight.linux@gmail.com>
Cc: Amin Gattout <amin.gattout@gmail.com>,
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

On Tue, Aug 18, 2026 at 10:21=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 18 Aug 2026 09:01:43 -0400
> Alex Deucher <alexdeucher@gmail.com> wrote:
>
> > Applied.  Thanks!
> >
> > On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@gmai=
l.com> wrote:
> > >
> > > strcpy() has been deprecated because it performs no bounds checking
> > > on the destination buffer, which can lead to buffer overflows. Replac=
e
> > > it with the safer strscpy().  No functional changes.
> > >
> > > Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_mca.c
> > > index cc6d1a4e4c3a..1caa393c44d5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device=
 *adev)
> > >                 return err;
> > >         }
> > >
> > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
>
> I missed this being proposed.
> Both strcpy() and strscpy() get converted to the same memcpy()
> (which might itself get converted to writing a 64bit constant).
>
> But if the string were too long strcpy() would generate a compile error
> whereas strscpy() just trunctates the string.
>
> Which one is better?

I don't know.  I can go either way on this.

Alex


>
>         David
>
> > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BL=
OCK__MP0;
> > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
> > > @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_devi=
ce *adev)
> > >                 return err;
> > >         }
> > >
> > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BL=
OCK__MP1;
> > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
> > > @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_dev=
ice *adev)
> > >                 return err;
> > >         }
> > >
> > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BL=
OCK__MPIO;
> > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
> > >
> > > ---
> > > base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> > > change-id: 20260818-amdgpu-strcpy-0e92d18299c6
> > >
> > > Best regards,
> > > --
> > > Amin Gattout <amin.gattout@gmail.com>
> > >
> >
>
