Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5C6CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E6310F27D;
	Thu, 30 Apr 2026 08:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HOROBGZ0";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9EB10F27D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:04:47 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so347841f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 01:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777536286; cv=none;
 d=google.com; s=arc-20240605;
 b=GI18RXehGRl3nrXGjVo3Tw7L+7Dt4Pw0NL2XwGyOLvfTkTFLOLSjTmEXGxZcM7Fr1c
 N6qJzenJtFmQ5KX8u/cmMuXdY6p/PirlcdnoDWMRptB/NTYbIZA192HwIq7/eoyTR60G
 9DezY3c8lpBhUriN51IZD4DNPVRXUvyeJ0qAm12VVz0wjw8hW3mQXX1t3BBRiibfOpRL
 hEJtCGvIghsT8OYU2p0FMP0Fj8wbFIo8tLIyCHnjX4LLnH/uuwrfsT/+MZx92gll6y7j
 154InU7Adv/ja4KoodeY8LxJKR6daWJwSFl2Nug2+Auf4XR7a1194y53gx5+5RA2aPaN
 wioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aZrGBqXYPdLgNn5aQC9hh+9jzHstDAbAkt2IwwGF1kY=;
 fh=aFpocZJr8ke0jPeMZ8t6jbD/lnKjEycT5T+H/H9ie7A=;
 b=GUyOeBz56b1l5Y+Ra/UvERdapDy/DhozDsLiEb98rHmby6gS1XoGaqr3bPXYnwvnY5
 ts+94gLrGQADfjZdVdu2JXA4P1jkoOSTAnbLD+OrQrDF+0qPbR+vqsJbRnP8wAS2NK5i
 G2TrfGF8RQK1S58YMLn3QHEjpwqGmrVabbLLIVUmBpeGpv4tDq8eHs9Yrs3xONvPoxPS
 d+H9C1JHl1vv52z+lHMIJ1tJFtVG7U6IlqsTrH4+z6M/vkvMmAzNdIUSSXQLuf4S+7Lh
 4uqMYpI61eqkfLih31Fw3matcW4tZTgNfN/em/4pLTX4Cyeu9YVPB5Dbuci5YT2h7UGG
 XWiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777536286; x=1778141086; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZrGBqXYPdLgNn5aQC9hh+9jzHstDAbAkt2IwwGF1kY=;
 b=HOROBGZ0psSbtZ0abPyGzrCRwt4m0C8xkNxQjUHCXRFiJMy/GMsVKmXUD6XZ7s9kl6
 rD/dYaScLqEVifQ2qJTLOrMYD/isijNAJ2xdYIArAbKqsz+Kgy1r/lxvNj3YFOlygi3N
 NIUrBbNKbx8zG168gbij5Y4VuctLpfsnj15S20L0FcUj6kvVdax2RAv+GhRp0zGj8Z9c
 cBz9BzqvM1cTxFGpE13ezyjX6wZyMWgnBggIIzH8ZGOl62rErKynJ3VxOInLWrxahC04
 PlryjZlW0tmw/+f0jvk8k0h0j5iRc1qvc49NjiNLGPIzTa6DOr6sB6JK+mCsbW1XzdOE
 wY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536286; x=1778141086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aZrGBqXYPdLgNn5aQC9hh+9jzHstDAbAkt2IwwGF1kY=;
 b=S7LXfPSd5TOjWgEYMXqQLZIYTmfxA7YOsZordYkQddJjcxHYDYUBq9lw9MagC4Ap1O
 mvuvQ7YGRLhxTOA+EN1eXrETk4GEoHTnCHV5iFGrN41u9B0sVMrwb+5xu8VuS6odSV5g
 KIF9RhjnRZBWRE/aPB82QfNigfhxCUJXMBfux5Ryo+UnJWJYfOvV7DbGmpJ3DxGbzTBL
 Hqn81OznkwrftIh07Q8osq0DCDlL1iTA5kENV+BjFmGz9kEko/ScisWR7qR/Jg2bwDQq
 q4YAxnJ8AKoEi0I85MfqMZM5/pGj5nyYu+ahQPVnzhUr2V6kRLI0Z21Oo6i9cCyfd6eF
 27Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WLON9kjxo2+TXzcURhT3eNEVKy2C698NQpTaExFqrpFuHCQ3fFVXKpfFEonIb+PRO/Jm7IGA1AvE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxf0fzKZhdIR2C5wa0fxJ6prMcuasjhLsmpc/gwdBeVxDjssp/E
 6yyDOj3dLxHb9fGhp4TK4Ta2rNhYwiFtyzVjI5b0dTVxhM/Gyt1KjFN8tn2iKiP72/ucrtmc0Q3
 qO85tIKxngnfNGzpmV3BNFpNE2GGclgM=
X-Gm-Gg: AeBDiev9cxPQkmM02mZx24Et/G6/xaV8fWuwiZMA4bL0rbvzm9XJzlIcf4z9ouGqGap
 F1B82c3CfN+daXPn6tF8bPA7NjZ5H17bv359yjwaQy0xp/uiPEl57odW2fMxzJCD/bLytCptO4J
 PoAaSxFlnxz76llNAE0Gqd922Y+9PwrecXb701FzFmeCjCjdMU8V17fNGHy/hZCSaK81EUClnkb
 XMHqVGWXbqwRcqEEKqb6QtI3qIL8rAB0W4XvQRAVfTIXKlrpOLwjV60BaeQIcUlaGljmx6sAXjz
 cylPk3voVGCaw0dSbMU=
X-Received: by 2002:a05:600c:6285:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-48a84485623mr32551075e9.28.1777536286057; Thu, 30 Apr 2026
 01:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260427075856.85208-1-clamor95@gmail.com>
 <gUUml1BmSZiZjQ7gY5A_cg@nvidia.com>
 <CAPVz0n0q77SVN7=47fEQR9ASQUnLoEgaGh3tJihxLSe9UhrPaw@mail.gmail.com>
 <SGKRjIZyS4mU2gPAiUbKJg@nvidia.com>
In-Reply-To: <SGKRjIZyS4mU2gPAiUbKJg@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 30 Apr 2026 11:04:32 +0300
X-Gm-Features: AVHnY4J3f47Ssn3vff5AA01Azy11Bi0ZSOBuJyaaCs1Zt8ajGgiFrXmKZX1YrmQ
Message-ID: <CAPVz0n16zCgCZwPXWMPg=KiYLwc3beBzVqYVB96in7zn0Wkxqw@mail.gmail.com>
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

=D1=87=D1=82, 30 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 09:2=
3 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tuesday, April 28, 2026 1:57=E2=80=AFPM Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 28 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
04:53 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Monday, April 27, 2026 4:58=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > From: Ion Agorria <ion@agorria.com>
> > > >
> > > > The gr*d_remove() has pm_runtime_disable, this indicates it should =
be
> > > > paired with pm_runtime_enable in the probe instead of being inside
> > > > gr*d_runtime_resume().
> > > >
> > > > Signed-off-by: Ion Agorria <ion@agorria.com>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
> > > >  drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
> > > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/g=
r2d.c
> > > > index 21f4dd0fa6af..71f092d59d65 100644
> > > > --- a/drivers/gpu/drm/tegra/gr2d.c
> > > > +++ b/drivers/gpu/drm/tegra/gr2d.c
> > > > @@ -286,6 +286,10 @@ static int gr2d_probe(struct platform_device *=
pdev)
> > > >       for (i =3D 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
> > > >               set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
> > > >
> > > > +     pm_runtime_enable(dev);
> > > > +     pm_runtime_use_autosuspend(dev);
> > > > +     pm_runtime_set_autosuspend_delay(dev, 500);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -367,10 +371,6 @@ static int __maybe_unused gr2d_runtime_resume(=
struct device *dev)
> > > >               goto disable_clk;
> > > >       }
> > > >
> > > > -     pm_runtime_enable(dev);
> > > > -     pm_runtime_use_autosuspend(dev);
> > > > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > > > -
> > > >       return 0;
> > > >
> > > >  disable_clk:
> > > > diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/g=
r3d.c
> > > > index 42e9656ab80c..33e88ca4d4c5 100644
> > > > --- a/drivers/gpu/drm/tegra/gr3d.c
> > > > +++ b/drivers/gpu/drm/tegra/gr3d.c
> > > > @@ -517,6 +517,10 @@ static int gr3d_probe(struct platform_device *=
pdev)
> > > >       for (i =3D 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
> > > >               set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
> > > >
> > > > +     pm_runtime_enable(&pdev->dev);
> > > > +     pm_runtime_use_autosuspend(&pdev->dev);
> > > > +     pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -578,10 +582,6 @@ static int __maybe_unused gr3d_runtime_resume(=
struct device *dev)
> > > >               goto disable_clk;
> > > >       }
> > > >
> > > > -     pm_runtime_enable(dev);
> > > > -     pm_runtime_use_autosuspend(dev);
> > > > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > > > -
> > > >       return 0;
> > > >
> > > >  disable_clk:
> > > > --
> > > > 2.51.0
> > > >
> > > >
> > >
> > > Oof, looks like I had managed to really bungle this with my earlier
> > > patch. Thanks for fixing it!
> > >
> >
> > Hello Mikko!
> >
> > Thank you for taking time and looking into this patch. Don't be so
> > harsh to yourself, PM is easy to mess and hard to set properly. This
> > patch does fix gr*d access but it does not resolve the issue itself.
> > PM should be set in the init/exit rather then probe/remove. I have v2
> > which fixes this and one more minor issue and I will send them later
> > on.
>
> Thanks! Why do you think it's necessary to enable runtime PM in init?
> If you look at the commit I referenced below (in 'Fixes'), we've had
> some issues in the past with doing pm_runtime_enable outside of probe,
> where the engine's power domain would be left enabled even when it is
> idle.
>
> gr2d/gr3d I suppose wouldn't be in practice affected by that issue
> though given they aren't in their own power domains.

WDYM, gr2d and gr3d have their own power domains.

If the master device is unbound and rebound, gr2d_init() will run again, bu=
t
pm configuration is only located in this probe function which will not
run again, while pm disable are both in exit and remove. This results
in pm issue we are observing.

Solution would be either do everyting in probe/remove, or init/exit.
Probe/remove will lead to domain being turned on even if engines are
idle. Init/exit seems to me more suitable and we have tasted this
configuration for a quite while in the grate DRM version.

Best regards,
Svyatoslav R.

>
> Cheers
> Mikko
>
> >
> > So for now this patch should not be picked.
> >
> > Best regards,
> > Svyatoslav R.
> >
> > > FWIW, I've been working on adding some nightly testing for Host1x/
> > > TegraDRM, so hopefully we'll be able to catch such things easier
> > > in the future.
> > >
> > > Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
> > > Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> > >
> > >
> > >
>
>
>
>
