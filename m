Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA5CFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 04:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B497A10E0EB;
	Tue, 28 Apr 2026 04:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EBjCN7O8";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BCA10E0EB
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:57:23 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so8081199f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777352242; cv=none;
 d=google.com; s=arc-20240605;
 b=ksE074bd+u825/TjWr4iiL+z+nYRu36Lmjnd4W/J8S8i5cR/cGRi8Zscb64Bm47X4S
 zTz9r8OpvHRLe1KkvI0sLNaW27mBjReH7OvrM62rknsTiDhY+Q9tyZkQbYm7M7Vgp6vC
 2lrnDBJXYiPtiUhHKvLti15NxLpXAfu6pNcp3sk4ihwlVmnCBfrlT5HUmGADxXkoPHuS
 XGk/4YBnzUX5vquoRkd+l7Xcpn7VShAo2xYDt/3zicWPSElMcQ4fLu/I+47AOTiYRb/2
 TllK0y5+eP1Zh9dDrLXBGDNkqHZ5ZZRUiYhwX6kGscyhBoHDalpXHPOESJwRVIgu9/UV
 lthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nd1/QqzjArDnTXh+sjQgJCmnUECsah1/qdKQYQu4dDg=;
 fh=tQqDWmgIKu3fUqWhIBko2rB4SAPruY2Z8nxTsO4lLFo=;
 b=Ex+zUWoNv9DofPZaqPzoP8TzPAy1qSAcEsrxi/WeaN4vnpyHBEofmY2lPMVfpdxM4n
 6a5ZqOPk6VMK+gNTGt+R2X1Hs6x7QB/60Q6dH5qbWDrD3jQSarbIjaZmSveEWAjy80Qv
 jFK5EE/7uF2s67ccgDoPtA89Ci+Aa3P6KJb4Ct+VdTeZpnQzAOaJ6HJtnJtl9no5TkIH
 vruE7c69cWRPwpMY2gBgoZQaP/ChZoOEEiqC6EYm/Q8GtYHuwo63+5vaOkWvHmZOHWw8
 yGsj4TTfhZsQQ9JH89gGIHWT9u16Xx12mfk43XntkrzQqgB7uBwuNGDM4jSJ0WMUd9AJ
 7dAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777352242; x=1777957042; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nd1/QqzjArDnTXh+sjQgJCmnUECsah1/qdKQYQu4dDg=;
 b=EBjCN7O81yOwT2iGBRyT0bStQUVaixDPUG2H1pArga8/TY5pbXMs5O+9wcgoRE6asM
 bRoPqTQqtqSfw/zKu/MjdJ3EIRq7a3AK1e3hF2rbIvz6DXi2KO5AyEhONrPr8yQMHrhC
 bDuH/tAUu3kFUZ1tGILCwKB+ixqcLY1U0WeXsqaCwi3hwmWDIRsCYGFfYg46DWJ9eNIj
 WNyNNsDKvFFy9/fptG1TSGaghqPTmwQnk9OqATltErbMbc5AMKI9Gif5+YrQCmyNTLcs
 VZZwz0Zq//StnBLI9ZrLsQwBPbk57KYUVftRFSUl7eoxfSrEZk4PZdkznpDfpE6WAjFM
 fjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777352242; x=1777957042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nd1/QqzjArDnTXh+sjQgJCmnUECsah1/qdKQYQu4dDg=;
 b=Li5Z7GgubCdwA3Kh1AIpKH61qCRomRULO4kI1tOGeDdRFcvf3WyexdHFvjMVszuqEX
 jMd0FoUdO8jEtmmteoJRpEDNRsPqc0iPYyijZg5uR8Hre/jd3jShAWPTXpb6+XRxWO6g
 yiJ7Puc//BrsuWpgwaWTWHpZKrDe6YK2dI2ziIH9BFRoLcuRRr7EDKfTcyHtIFnk2N36
 5bAPWAUa+clvwoF5l/yUsug2YbJdf21LnalttwaVN76FGTK16Z+9eEBFPyrXaMdRYP+W
 Bb+azDuPqzMFSHMtQobAgeajzL8FEUQwOrnkdYxdNJB7t1pd6xFhF2/IhUfIs7kLuQFp
 ktkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TBJ/rD9+9nXAOE9upBKbaeCb6fCSRldjw8YcSHk8026tTCSBgX4zKNFKz47RFrm2m+8UDoJz+qqg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiglYHFQxF3NByAeE4gpQqRJuAXFvzAgfzs8IJ6q3kFPEfraFj
 0imNyk+hbkYyDHRCU9dCg8QunjXeYOsSwRjPT8mOBtUw4sQ5Ac68367YiJwY6BwPaS652Daw340
 nd9phWveLv2F1FJEP3LBjZrJi3TMvL2Q=
X-Gm-Gg: AeBDievOYyqf3+sT+Yeag1ulZIh9X0Kp/WSN3hawYHmn99fVmu9g+U07kvksiH5S5FE
 i4yg/sAb1jIUCG3QreT/9FAqSKfGVrJKNJG4rEG3LsiAwcr6HpSJ4BRpo/AQBARAWeW+p7rEy6q
 fdcq/uVIILn3kAdsmanq9ORLCNEDGzrczWhWWeJTugkAcTCn4gHOOEMmQlmyJCJf9S3gohBQaAn
 G8kA5Exlpt64KhbPbMF8Q8NL5oyZoMw/rEfCbuWDRxXInBs4dwYefcuvrpQqLoWSVdg2ZfG2LSy
 MbcCyG3ikOcG+sWHpas=
X-Received: by 2002:a05:6000:240e:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-44649c9973emr2630806f8f.38.1777352241852; Mon, 27 Apr 2026
 21:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260427075856.85208-1-clamor95@gmail.com>
 <20260427075856.85208-2-clamor95@gmail.com>
 <gUUml1BmSZiZjQ7gY5A_cg@nvidia.com>
In-Reply-To: <gUUml1BmSZiZjQ7gY5A_cg@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 28 Apr 2026 07:57:09 +0300
X-Gm-Features: AVHnY4LI76aCvDtWfafVdfCQxyDNR500_itc7PsbVg4RhSzhSUX-qsfcx-3dp4A
Message-ID: <CAPVz0n0q77SVN7=47fEQR9ASQUnLoEgaGh3tJihxLSe9UhrPaw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/tegra: gr2d/gr3d: Move pm_runtime_enable to
 gr*d_probe
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ion Agorria <ion@agorria.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

=D0=B2=D1=82, 28 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 04:5=
3 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Monday, April 27, 2026 4:58=E2=80=AFPM Svyatoslav Ryhel wrote:
> > From: Ion Agorria <ion@agorria.com>
> >
> > The gr*d_remove() has pm_runtime_disable, this indicates it should be
> > paired with pm_runtime_enable in the probe instead of being inside
> > gr*d_runtime_resume().
> >
> > Signed-off-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
> >  drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.=
c
> > index 21f4dd0fa6af..71f092d59d65 100644
> > --- a/drivers/gpu/drm/tegra/gr2d.c
> > +++ b/drivers/gpu/drm/tegra/gr2d.c
> > @@ -286,6 +286,10 @@ static int gr2d_probe(struct platform_device *pdev=
)
> >       for (i =3D 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
> >               set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
> >
> > +     pm_runtime_enable(dev);
> > +     pm_runtime_use_autosuspend(dev);
> > +     pm_runtime_set_autosuspend_delay(dev, 500);
> > +
> >       return 0;
> >  }
> >
> > @@ -367,10 +371,6 @@ static int __maybe_unused gr2d_runtime_resume(stru=
ct device *dev)
> >               goto disable_clk;
> >       }
> >
> > -     pm_runtime_enable(dev);
> > -     pm_runtime_use_autosuspend(dev);
> > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > -
> >       return 0;
> >
> >  disable_clk:
> > diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.=
c
> > index 42e9656ab80c..33e88ca4d4c5 100644
> > --- a/drivers/gpu/drm/tegra/gr3d.c
> > +++ b/drivers/gpu/drm/tegra/gr3d.c
> > @@ -517,6 +517,10 @@ static int gr3d_probe(struct platform_device *pdev=
)
> >       for (i =3D 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
> >               set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
> >
> > +     pm_runtime_enable(&pdev->dev);
> > +     pm_runtime_use_autosuspend(&pdev->dev);
> > +     pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> > +
> >       return 0;
> >  }
> >
> > @@ -578,10 +582,6 @@ static int __maybe_unused gr3d_runtime_resume(stru=
ct device *dev)
> >               goto disable_clk;
> >       }
> >
> > -     pm_runtime_enable(dev);
> > -     pm_runtime_use_autosuspend(dev);
> > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > -
> >       return 0;
> >
> >  disable_clk:
> > --
> > 2.51.0
> >
> >
>
> Oof, looks like I had managed to really bungle this with my earlier
> patch. Thanks for fixing it!
>

Hello Mikko!

Thank you for taking time and looking into this patch. Don't be so
harsh to yourself, PM is easy to mess and hard to set properly. This
patch does fix gr*d access but it does not resolve the issue itself.
PM should be set in the init/exit rather then probe/remove. I have v2
which fixes this and one more minor issue and I will send them later
on.

So for now this patch should not be picked.

Best regards,
Svyatoslav R.

> FWIW, I've been working on adding some nightly testing for Host1x/
> TegraDRM, so hopefully we'll be able to catch such things easier
> in the future.
>
> Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
> Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
>
>
>
