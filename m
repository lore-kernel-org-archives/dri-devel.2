Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FC8F99C6B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A19E10E00B;
	Fri, 17 Apr 2026 21:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tB+tarb7";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F2410E04D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:51:08 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6729c6f0ca7so1024104a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776437467; cv=none;
 d=google.com; s=arc-20240605;
 b=Yiw+X4+X0Z4U6tdKmTR7q290PXEniOvTq4iy/+Y25eqhsFZhRVj4RZ3iS8jqhiDn3+
 Mgw53x5E30nIgqaFe62qr/X9jlytcsVa37hEvhWht9eMxYrlWW8PnbtBDkhP41jDLtrY
 t7vR6nxch3FWflHgJfJhUOkiuOJ+8mEgjfCoTvJeopS+lL4opW3ZwixeTl5PXayDEyCs
 wl/gsfE2vP8Qjz/36QdVZ5/Z3YC6AlMb3DEZN+Hfna8IyVOLl7nVdT++vSek7TSK26/R
 x6kLYPzLEN1m0RAHJXV735ncPP0azT88eQcDnT1mcOVzcYfKtQiEtAA1j4VQH5MhcgH3
 AlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GqspcooKgst7WD1YTyYSebsG6+WnjIGRXNERmo7wEPU=;
 fh=rhgRfbCG8wWeIUAqAbSS+1V48l0H7MsVsPW4rKSkqB0=;
 b=Yn/rb/N/qPc92uALDFSv0CVh5bEe5TGDQ26QAGAyF8sceeEwCsui6ddlxlL4W6bM1I
 iSGqdy7Tb4AiuFGmdL8F65icP+aaePYon6XASAzC5m6kc+cXyQUDtHgpWwYS75bChClr
 M+HdO1wxNEv4oys5PrjufHLzLmPQfKjwoVAVXlsq3KHIgYw214QrJd05CtWGK+skKa74
 mdZU+mL1Ay3aCTAmzQzSB8thcN49mdlRlzoQulEImc96+DdCKZPyxMEOaoRH33r6+DKM
 F4shOHY6OhxVVtB6d3OGBSkrwmgdiPKZD+kwOByIYDOCUBOPp/e64obGOMVPpHwp8C1g
 tE3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776437467; x=1777042267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqspcooKgst7WD1YTyYSebsG6+WnjIGRXNERmo7wEPU=;
 b=tB+tarb7x7a9ZHzL09LlUJMvki6nFqHVGNwd9p/xSMVmV9LSDygpXaYcsyYSdqTZDQ
 4HBMZReBwUdw+7NAWCtBRJUHsH1GvEupE/F2K1rlbSF06rV2oxLO68dSZ0EOZvs3UJ6w
 6oJeN4avA/6hfYQRwocX80HfRDGS/0Plt1Z7L73ZzxGCGbfN8VFhcALuquEkxCJ7ZeGX
 kBlqo3vk7iEfdDqHpgJ7Hh/7GREILwq+87mxOMYu7t7/0xchu9BsNx0LizGfVeBSFvPG
 n9MLX2ATxtbbq2JS0mt56FRms5mwotjkpKU5cc6Y2rhHT03js/oYJeQrmaL+3FZsfIrC
 A6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776437467; x=1777042267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GqspcooKgst7WD1YTyYSebsG6+WnjIGRXNERmo7wEPU=;
 b=Z+Wg1ZhGJIsM5+mSVsXR58wTxAlglcgjzueDGS8g25Z9BB3sywXDVljGkE3b6tULQT
 aLCl9Fv1MlrXFTAh/IG5kpR4QeSGkG/eXeCgsgC2u3PTWRm2+jBc3gQbBrHCM7vv9ti1
 KGlowrCia/46h0Pb07TYtmSh3mXqiwLnTlcdv9e8ITJzAB7A/L94Jfh0ozilDLrpmwAT
 maeggAYoUs/tWaWUG3+O/X/CgccOAhmcTWGs6/1/GpLruMiB89N1BXk1+tpjB2aORrUx
 D3301RP3LpV4N2u2BlhzSoINlQ7bzin/kPQps8PTBxjla49DO+dgxXSPiyC7cGeM+23v
 4U7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DZmPSRC75wj+mpF47kx++ru1amUoC6HbA4fc0mUdMf2u6eHJ3kvWgnVtXnlfFiw+rjqkmT1o4FZg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPBBSJLIIiSUdUn49w1g+c87bXctVEB0FV9hVFuifMdyEovnMP
 jSNY/hPTotub74nSyNdfVgNi4p+XvFltn6BziIqG90Q8tLwAyhwRxh6Zd40Fmy+gcLisoyB6mRb
 MtS6U4Z/2uBLcPMbVGX1xlbo8ikni8kU=
X-Gm-Gg: AeBDiest/iq1D75irDzNo08oVpLRQSMuiHFRCIjRU8jMQvCIZekAcrK9ds8CrWoUnmn
 Jp3oj1L8h+IhGC2LjqHEYCWZRflKYuLOH9FqEy4lZjs9QCse09Pep9e3DRT8c6Ud8Z7s2Pv4l2w
 SYOmAO0qQKuh7z8BfgERO7LOM73dwYijpjn6lgq1gOg6/vjJO64DCvZsJsvA4rdSRb7RtdR+7CT
 eGd3yfbKNtnmNPSGWchFfUf0EtJqdoKhZxTqa6+o1AmrpyIAvODmdN5a1Cc34i6xqVdqoGtz88R
 +xmg7+22rljm8HKd
X-Received: by 2002:a05:6402:2b99:b0:672:f75:5095 with SMTP id
 4fb4d7f45d1cf-672bfd82182mr1549620a12.4.1776437466608; Fri, 17 Apr 2026
 07:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260416195537.3632-1-dbgh9129@gmail.com>
 <CADnq5_NrVgGwAYbBGgGc9t-ke5xt_0iJNExXARb7LxdnHSwDQA@mail.gmail.com>
In-Reply-To: <CADnq5_NrVgGwAYbBGgGc9t-ke5xt_0iJNExXARb7LxdnHSwDQA@mail.gmail.com>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Fri, 17 Apr 2026 10:50:54 -0400
X-Gm-Features: AQROBzC7i9ei1CiJnYg6HROzf4GBLzx1H6GJ7IgyCxXJkBfyW-5LW2DspgZwtVg
Message-ID: <CACrCO_VKvhA-zx1KPhDxbOR4HzDs87Hsbdtc5SZXgvLeK9ZX=A@mail.gmail.com>
Subject: Re: [PATCH v1] drm/radeon: fix memory leak in radeon_ring_restore()
 on lock failure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 "Kim, Taegyu" <tmk5904@psu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 17 Apr 2026 21:55:06 +0000
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

Dear Alex,

Thank you for applying the patch.

Best regards,
Yuho Choi

On Fri, 17 Apr 2026 at 10:05, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Applied.  Thanks!
>
> On Fri, Apr 17, 2026 at 3:06=E2=80=AFAM Yuho Choi <dbgh9129@gmail.com> wr=
ote:
> >
> > radeon_ring_restore() takes ownership of the data buffer allocated by
> > radeon_ring_backup(). The caller (radeon_gpu_reset()) only frees it in
> > the non-restore branch; in the restore branch it relies on
> > radeon_ring_restore() to free it.
> >
> > If radeon_ring_lock() fails, the function returned early without callin=
g
> > kvfree(data), leaking the ring backup buffer on every GPU reset that
> > fails at the lock stage. During repeated GPU resets this causes
> > cumulative kernel memory exhaustion.
> >
> > Free data before returning the error.
> >
> > Fixes: 55d7c22192be ("drm/radeon: implement ring saving on reset v4")
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> > ---
> >  drivers/gpu/drm/radeon/radeon_ring.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/rad=
eon/radeon_ring.c
> > index 581ae20c46e4b..a5dff072c1ac0 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ring.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> > @@ -356,8 +356,10 @@ int radeon_ring_restore(struct radeon_device *rdev=
, struct radeon_ring *ring,
> >
> >         /* restore the saved ring content */
> >         r =3D radeon_ring_lock(rdev, ring, size);
> > -       if (r)
> > +       if (r) {
> > +               kvfree(data);
> >                 return r;
> > +       }
> >
> >         for (i =3D 0; i < size; ++i) {
> >                 radeon_ring_write(ring, data[i]);
> > --
> > 2.50.1 (Apple Git-155)
> >
