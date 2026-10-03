Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22211CA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ACAA10EADD;
	Sun,  4 Oct 2026 17:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nahida.im header.i=@nahida.im header.b="aKKk2bji";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABA810E4B9
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:05:08 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b059eae96so36741f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 19:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790993107; cv=none;
 d=google.com; s=arc-20260327;
 b=jvi1v8CaEVjqLndUePUNskH5s/aA606ecwiM3pZ46ORbSzdqtUclT0ZU/rRPwa2x8q
 xt2ibPUNa1jaGpc6zaUxwuWP7NYR6UwWLI+r5gYnTXg/fogAaFTDAH3yF8vuvAxq73To
 2AVcTnaT3GexHuq/r/NHmiKdaS/+gS78YFhuWHkYcO4Rq1M6FGytyuFLSc3936/fpIyw
 4DtFFGh0p2ox8ZLFQKXyfKGsVsh7vYiUHGrq9XRK0kx72xj44A2L40pRDXBVDq893sGw
 U5aiM3YdYBeXhEYNrcL6rJVsFdwTpkxAyazZtprpHKPWgDZ7UWnBbDf4sEtl09nu/E2g
 4Nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t+8QgWjahKnuvKzRyDtBXHsZJiJkScJBHz23qDo+hDM=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=NsDZ1gssqn79+d3dEIzF6xh4peGWGhtNbw/Kj1sxnzZvAtU5G+kVkV4cgF89MxF3sG
 JMJ9TL/b5Wmjsl4zEf6oQkujpC1IbRyaZ/geY3WuetOiQI4qNeI4eM5gat+dTQlokYYD
 b9nU48UPFYk4kN/1TJA6F4g4vCK7I5xP3fOmR9egHsseHwS+HdeWuHSjnQKQCGIZSFsE
 zJBi7d3+BhgCYNLg9mYQEivVP2p8i3CZORsqHN1AXJHzURG9ThOddijTlNMrT0UJShoz
 Uu4f0tLmvmaKKSE1Jcs/9RpwXMODHyG/DfMM29pL7VA/IT54c5/0/jg/9bEZiYqooFvc
 2MUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nahida.im; s=nahida; t=1790993107; x=1791597907; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t+8QgWjahKnuvKzRyDtBXHsZJiJkScJBHz23qDo+hDM=;
 b=aKKk2bjiOuIlf5+aj9YTPVlRJUEZ1p9SKMc+/b2O6QyC36/8d6FodKT5P+pBgrGbrL
 i7oI9mJfMAzk9r73mvYDxcQSCwgYuH8OseNeoo1gL0DFPhUe0RcAlC/vA8XcrbRihTkt
 osZzdxNCgzX3LSXk1WTIq8iUmDqJkYBNIVce5zY8Xm8P1ROvs4xHEsU54DMuwgjewcAx
 cSjFpiFMfDfm7ECVebmafa5vv6XFK+MifqVFFOmn+eHZvIL7xTSnbEuxWfypUi6w77eD
 nG3+gObGxkIOoQCpFyBkoq5Ifc/aKHap5j9YVvDfrcECTNn3j9xhhoq0fn8I2JnKuC8X
 Jx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790993107; x=1791597907;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t+8QgWjahKnuvKzRyDtBXHsZJiJkScJBHz23qDo+hDM=;
 b=ZKZHe7mb/MJkwmzAQFfJobl4bsbrcPqrjzuFLVqdZfxOI7w0UNI0uRIKX9IevkOGkK
 pT6LKN+KPaLi8ja2GQk1irLYmnfIE/7aAcCUvNoIzVOnDo5blx2Q7MkhOmqf8F9ukGYc
 4mInEsb1L89VKWUG07eA9APjsBwMvHfJ0D/Pu/8H13zg4BQgQwYNy/4AOtsyPxV+LEzw
 iUO8jfXCXS0NJ9+FI1Teyr3hO0zS8OTzJH5OzPjaBnFCHeUbr02Y0pEntpDSWrg/0Jqp
 d1f+u+IeBSF4hGKDaFSWQX9wuOa25SDJzWggaEzvS0aImfGVky/X4q6sTjttmmtZcZ6i
 v5iA==
X-Gm-Message-State: AFq9FYIpu1uL4xEsLuCHMlBC6XVlLwAHYVNhn/94iYcLlNbhxyqNax2W
 9SodoTue4Fz/Q+/9EmiATZUcniEu3CW6ED4inOyCcP9XUZA6eh9c0isn9scXwVf9603vSOe08tj
 64Tueu7YQdjoYltb3AOC2hXHQjxoqj5112xh7tyuZUuw=
X-Gm-Gg: AYBFou3ZwTmZCX5mq1vFTyhXbAqej0T7J0XrfUITa3cCserJqFGBIoBw5XDUgHoZi3w
 ePovo814x+gNDvwHdv2YGr6C6cvXL9IsA+uvd21yxts0xYFGfWHmsi1O2EGVMNgk2GWkTE4d23G
 TRIghoLDF7cYIwQFBbXqIJ8iDfVYa3C6CMwhOnqRcZO7RQmg5kAqLfWsVOmmqpsu7IgLs88+x1y
 3mdQAREJbfUyRL6ThX4+MJKLLuj9B2+CVm7R5J3lQQKRqVYkXowvi/YINwQHvl3aTXNnJdfU/9u
 y1UPnZUhbZ6VT9BhbyAyXDuFgFz39TJG5DgtWY/MdXJLpk7ZmytDtmsufX29eFSavHfV7XSyZHF
 mqCrhvJGI8NrrsEGAnz0fNL1V
X-Received: by 2002:adf:f304:0:b0:48a:fbf7:15b3 with SMTP id
 ffacd0b85a97d-48b12747253mr6029639f8f.54.1790993106650; Fri, 02 Oct 2026
 19:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20261002203140.121165-1-me@nahida.im>
 <20261002222021.149450-1-me@nahida.im>
 <20261003013405.9EF9B1F00893@smtp.kernel.org>
In-Reply-To: <20261003013405.9EF9B1F00893@smtp.kernel.org>
From: =?UTF-8?B?57qz6KW/5aayIMK3IE5haGlkYQ==?= <me@nahida.im>
Date: Sat, 3 Oct 2026 10:04:55 +0800
X-Gm-Features: AclHuK_dQjIHK3_7hoLlUhTHoLKkninCH-PAncgkVstKtoNod_DO7nt3bkfbd6s
Message-ID: <CAEEzyciPRcDWJ9pgaJBx9peeV16p9t=wx4bdy9ZyKyjgMZ+NKQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panic: allow overriding panic QR code URL
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

OK I'll fix it in v3

<sashiko-bot@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=883=E6=97=A5=E5=91=
=A8=E5=85=AD 09:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] drm/panic: OOB read due to missing null-termination on panic_q=
r_url
> --
>
> commit 4020ffafa052ada60c700fa2d64b78e9eb01e839
> Author: =E7=BA=B3=E8=A5=BF=E5=A6=B2 =C2=B7 Nahida <me@nahida.im>
>
> drm/panic: allow overriding panic QR code URL
>
> This patch adds a module parameter to override the DRM panic QR code base=
 URL
> at boot or module load time. It exposes a getter function for the DRM pan=
ic
> helper to retrieve and format the configured URL when generating the QR c=
ode.
>
> > diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> > index 9fe97c4eda6c8..463544f71c537 100644
> > --- a/drivers/gpu/drm/drm_panic.c
> > +++ b/drivers/gpu/drm/drm_panic.c
> [ ... ]
> > @@ -49,6 +49,15 @@ MODULE_LICENSE("GPL");
> >  static uint panic_qr_version =3D CONFIG_DRM_PANIC_SCREEN_QR_VERSION;
> >  module_param(panic_qr_version, uint, 0644);
> >  MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR c=
ode");
> > +static char panic_qr_url[256] =3D CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL;
>
> [Severity: Medium]
> Will this array be null-terminated if CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL=
 is
> exactly 256 bytes or longer?
>
> In C, initializing a fixed-size character array with a string literal of =
equal
> or greater length does not append a null terminator.
>
> [ ... ]
> > diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_p=
anic_helper.c
> > index 8913c3d22e8d3..b0ea0b4e8edef 100644
> > --- a/drivers/gpu/drm/drm_panic_helper.c
> > +++ b/drivers/gpu/drm/drm_panic_helper.c
> [ ... ]
> > @@ -609,17 +609,20 @@ static void drm_panic_helper_qr_exit(void)
> >       stream.workspace =3D NULL;
> >  }
> >
> > -static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned in=
t qr_version)
> > +static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned in=
t qr_version,
> > +                                         const char *qr_url)
> >  {
> >       struct kmsg_dump_iter iter;
> > -     char url[256];
> > +     char url[512];
> >       size_t kmsg_len, max_kmsg_size;
> >       char *kmsg;
> >       int max_qr_data_size, url_len;
> >
> >       url_len =3D snprintf(url, sizeof(url), "%s?a=3D%s&v=3D%s&z=3D",
> > -                        CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
> > -                        utsname()->machine, utsname()->release);
> > +                        qr_url, utsname()->machine, utsname()->release=
);
>
> [Severity: Medium]
> Could this lead to an out-of-bounds memory read during a kernel panic?
>
> If qr_url points to a panic_qr_url array that lacks a null terminator,
> snprintf() will read past the end of the array until it encounters a null
> byte in adjacent memory. This could potentially leak adjacent memory into=
 the
> QR code URL or cause a secondary crash that prevents the panic screen fro=
m
> displaying.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002222021.14=
9450-1-me@nahida.im?part=3D1
