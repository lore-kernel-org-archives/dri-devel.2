Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD055CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1504510F208;
	Thu, 25 Jun 2026 09:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P5KJhcJe";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B85310F208
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:47:10 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c88b59bfba7so953911a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782380829; cv=none;
 d=google.com; s=arc-20260327;
 b=HTk0Zc8cjt/BoAbbJq+XvaFgaka1f7k8SoGXul5Eo625uLrJ4UOxl+gxNlKeGA9QKB
 5Lr7lcvnJDiCy2VGiEqbpPJwZ2NPBzxlvRV5wiOsrT/iNzKoh1AgdYnKx8NwrW78nKR7
 UiNTFTejus5TDIj2Y5uu7G85GZX+SM0vJK0JrXj/5ICS+Vi+PMp2mkhha69r/zAobX2Y
 VmixkKHlFTzehuSpq0nHPmzWGBZjoO0YM9azzJeGdywhqW07Y+jnvc6xXhc5Y4lYi7UC
 UQdlcLMz7UjdJkBhojVNejlhBrDI9qZ0FrA3BWqvVGjfYgX2tTz4F9b/N5tdYc7pj2wy
 RwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NeTcUSKNh7vn3DPm8mPGV6I8X3SxE2IeoHKBOqLxT7s=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=Srqp6zYBBho8/2QjjRVNclUZ27JsUvhAu/jGr6imA5B3BdxCOLuTcoFdu28oMOGE0W
 Xl6eCHcgWqLanHqjmf07Grc0pOTMq09HEpaQ3zh0FFS8j7d42oQYRllbYp+Kts8c6z/R
 9P35eYRKnrUhcIPU1fLhodtOhb58GzrwgXxzlvWR/Tyvs7uhi2I0KGVOibijxWftRLcg
 SS4E0CI2oYX0muV10pMQN/Hdm15nCIldlCIWmSJtfaJv8bzjoISf/WlTvg2UNw28gBMY
 TsGl2pvbeibau/7FxYJsA50BhjT5Ujf9NK11iYcdkPWKsBDn0vSGEmiUBh5UytRHIodA
 atHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782380829; x=1782985629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeTcUSKNh7vn3DPm8mPGV6I8X3SxE2IeoHKBOqLxT7s=;
 b=P5KJhcJeEiHJD5ULaAf7RAQtX5A1VW9QY8L9LD+VDy84gK+mgUdsdOJCedvOP/e1NJ
 D4k+Dl3tOGaLNUU6/nbhpi6ET0bYrGjfziBapGnZib6jomHchvdIv9PO5Ks2N1TF7Trg
 /e3hvB9mCgMIvSd2OMBz/a2hfFXU4qCu7Iyq1HClx9km+94gdU6l7lDVNoy1AxmT5D6D
 W+2qJtdghC/iuksYa99L6t3aDhrAvaeTl/Ugx+NVxoS5VtXEtCEFVBbcTjv6TsFB4hD4
 o+jCjCIeITDuEGrIFyevwxtY1X1iOM6fbH8o/jfsc7a+IR6K1XouVjfWfEzeImj534RB
 03fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380829; x=1782985629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NeTcUSKNh7vn3DPm8mPGV6I8X3SxE2IeoHKBOqLxT7s=;
 b=SiMU0a4xp0uZ1AimaH8330iHbYoXiKicIimhmBybZ16Fsi3z+xOEEml86dklo6+L+T
 2nEqbgZ4Yqf1QliL98ph2y/KbI2tFsscf8opz8jBGWNuqxbZvPQ1lH6WIDuNksmOWhQg
 f4ibMiFCabOzq0mkNhBz3mQqXECAz791dRnSM+v3e/x4p/yQDZstV68UhYqrogvI0imh
 KUs7oE+aXGIT1tKGoxMnYo3DmHF7a0tIi5Fjz+2oiR1bi7ICTnJi7mEK8Vbuw3H3tkFV
 b81GEz+uIpcXeKPNyDdkH/i+RRkJGtthNFBIDu+dUuP05OTobbv4BgYXL9QkH6zht8DS
 qSJg==
X-Gm-Message-State: AOJu0YzpC1ixke2R5xd3twe1e+A4q7ct6vr2u7ToateLa34D0b281Sfs
 xJfTgoaCGU4mAEThAIDC3v881LiZF/kyOpTtY3GtHUJYfS5YU7u4IpQvI90QwHyF5RY6LFIjEPm
 X4yoTksIXc/atT2n9C/Of0ub5TGBYilS0AS1vA7E=
X-Gm-Gg: AfdE7ckCA6HOv82zeUqO8y0qMr28EYPDhRy+qsTluSyWBBCFmYZqeB+CgCdRWa71Zkx
 PASZaAAiBGfnyBHj35GSVg3gEInBn/PbCDVrraxnONX6/fEUH9nmZ2rNP6igrSvn7NyY7qH1IjF
 2xPkMHHFmrPbN//wDy1660tkf4UD7lkqpTkgZyhxeE7wehn1yXomA42HmOLbOSYtdduGnCJfqp5
 OOfQMORfUhsRsukGKg5aPNamJ1nJNT98/uLzjWtgOasFhQIS3QIR7d110HBTmZ//CU4rgEmUN8=
X-Received: by 2002:a05:6a21:48a:b0:3b3:1c7b:ff7 with SMTP id
 adf61e73a8af0-3bd4b013d3dmr2153617637.46.1782380829609; Thu, 25 Jun 2026
 02:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260625092721.238366-1-suryasaimadhu369@gmail.com>
 <20260625094138.3703C1F000E9@smtp.kernel.org>
In-Reply-To: <20260625094138.3703C1F000E9@smtp.kernel.org>
From: Sai Madhu <suryasaimadhu369@gmail.com>
Date: Thu, 25 Jun 2026 15:16:58 +0530
X-Gm-Features: AVVi8CfsHYSnakeHovcTcaZI38pNmBO3X7k9j1ewhVQt7YnLD6s_rVgjH6ruqwA
Message-ID: <CAB0uMAe0V5GL0M4tVFYag+4TsYskfiSk=+HANgM6hRb31KB7xw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace empty modifier argument with
 no-op macro
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
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

Thank you for the review. These are pre-existing issues not
introduced by my patch. I will investigate and send fixes
for both the unaligned access and buffer size calculation.

Regards,
suryasaimadhu.

On Thu, 25 Jun 2026 at 15:11, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Incorrect buffer size calculation causes out-of-bounds read and =
information leak over SPI when `startbyte` is used.
> - [High] Pointer arithmetic creates an unaligned pointer for 16-bit regis=
ter writes when `startbyte` is used, causing an unaligned memory access.
> --
>
> commit 5efb24fc5a4ff6b0f2481a7887082d742684defc
> Author: suryasaimadhu <suryasaimadhu369@gmail.com>
>
> staging: fbtft: replace empty modifier argument with no-op macro
>
> This commit defines an identity function fbtft_write_reg_no_modifier() an=
d
> uses it to replace empty modifier arguments in define_fbtft_write_reg()
> macro calls to fix checkpatch errors.
>
> > diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/=
fbtft-bus.c
> > index 30e436ff19e4c..2169f8d1d1b83 100644
> > --- a/drivers/staging/fbtft/fbtft-bus.c
> > +++ b/drivers/staging/fbtft/fbtft-bus.c
> > @@ -11,6 +11,7 @@
> >   *
> >   *********************************************************************=
********/
> >
> > +#define fbtft_write_reg_no_modifier(x) (x)
> >  #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)=
        \
> >  void func(struct fbtft_par *par, int len, ...)                        =
        \
> >  {                                                                     =
        \
>
> [Severity: High]
> This is a pre-existing issue, but does this pointer arithmetic create an
> unaligned memory access on strict-alignment architectures?
>
> When par->startbyte is non-zero, buf is advanced by one byte in
> define_fbtft_write_reg():
>
>         if (par->startbyte) {
>                 *(u8 *)par->buf =3D par->startbyte;
>                 buf =3D (buffer_type *)(par->buf + 1);
>                 offset =3D 1;
>         }
>
> Since buffer_type can be a 16-bit type like u16 or __be16 (for example, i=
n
> fbtft_write_reg16_bus8 or fbtft_write_reg16_bus16), adding 1 byte to the
> aligned par->buf creates an odd address.
>
> The code then dereferences this unaligned pointer:
>
>         *buf =3D modifier((data_type)va_arg(args, unsigned int));
>
> Could this trigger an alignment fault resulting in a kernel panic on
> architectures that require strict alignment?
>
> [ ... ]
>
> > @@ -62,9 +63,9 @@ out:                                                 =
                             \
> >  }                                                                     =
        \
> >  EXPORT_SYMBOL(func);
> >
> > -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> > +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_write_reg_=
no_modifier)
> >  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be1=
6)
> > -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> > +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_write_=
reg_no_modifier)
>
> [Severity: High]
> This is a pre-existing issue, but is there an out-of-bounds read when
> calculating the length to send over SPI?
>
> When startbyte is configured, offset is set to 1. The macro
> define_fbtft_write_reg() uses the following size calculation for the fina=
l
> transfer:
>
>                 fbtft_write_buf_dc(par, par->buf,
>                                    len * (sizeof(data_type) + offset), 1)=
;
>
> Because the parenthesis includes both sizeof(data_type) and offset, the s=
ize
> grows too quickly. For example, with a len of 63, a 16-bit data_type, and=
 an
> offset of 1, the size evaluates to 63 * (2 + 1) =3D 189 bytes.
>
> Does this result in reading past the end of par->buf and sending
> uninitialized kernel heap memory to the display controller, potentially
> causing a kernel panic if it crosses an unmapped page boundary?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625092721.23=
8366-1-suryasaimadhu369@gmail.com?part=3D1
