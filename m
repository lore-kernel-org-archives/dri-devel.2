Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22CCFF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5307710E126;
	Thu, 30 Apr 2026 09:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4GmwMg1";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C326410E126
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:10:10 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so10614555e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777540209; cv=none;
 d=google.com; s=arc-20240605;
 b=A4p32Gv8Iw9wCN3uiMl2nqzUxTHrMmu9GQSGLEO1cZkkTpKsD+AQPL/ju2fAaFvUYh
 Ieh9vW+p216oHWlMNDDtHP5+V110X61YmdgHJKjwX7hgst2ELIgvuOSspRmM2cn7miaV
 1Io6mequWPkaOITizT8lIIDpdcFomqMowJ8DDzWjB0Wyrn4Sb1eNf3rybhhnJc2ZN30R
 KEm4fUW0TMmxhYW7u/Za5GSereWCN/irNCQjqZLiJVOHiU2c0nf4JeMbliYXYSp/voUN
 JzHZwGgjHbXHZSPDVsa8GUEPgpkb3o8etuznPN/147KuxzY8ECtu5Pcj4Dvjq0xfzp9v
 5Rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uNayLLCXFFg34wv8nX5d4Vm4GrWa+HjlsC1+5DIJvb4=;
 fh=B7Fi2doGcq56k7n666shJv/PTHtclU27eudgXRrsYV4=;
 b=E/qEl1N8JtcOZnsGYK/z92hYd8HKNyV/DtTx6ZSZT3caz4sHVprkLHoNX4GyxdBbPH
 g+WyFp+3OrDE/BKV1j0JwxYjSAibIpAT9GNSHeaA0DKbec01AQrkAk27QEr/Cf13ULaz
 NneXos2XRz2c3aGDy/d8w3ufHFMjGaEmOXCW0Vpcov3cR5iAf92gyA74f76bwPG8M2gJ
 jT0FNvqAUUabHFlkD52a0P9S4CWt5jNeSV6HVCDRQ+4DNRI3a8/oCoGq3mHP1KZOC40J
 9SG1xjvdg5XbhFIr90AGkGvsnuGg0KqZCLkFVuz2Z0dewez2mlqEC0TN/laVxg9SiVEZ
 wdfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777540209; x=1778145009; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNayLLCXFFg34wv8nX5d4Vm4GrWa+HjlsC1+5DIJvb4=;
 b=J4GmwMg10VJxTsCVr7PoomFyjYTu/OZu0NQ8SL1SRdzylBhGfkQLHhzQoqeN3pNuyx
 T9J/FwVlvwDNdWJHW2BvbH0T1qSb5oPNf1dzf7HSlw3i2KCZnjfH+sHVwSrvpkO9ouPI
 cZejP8lMK7E6jed2qFXwft4XhUnSI+vQY8xAat2g8Hrb1LSv6j2lg0YidE2qtZMa3T7/
 hPn8r0yD0D0R5UoktlDCb2uSyNgOcnBVkQVqFmzB/TM0g5c5kTk3FiU/dnGuVF3f1rtF
 vYuH+H/iUfH8wqEkmXKerz8oTO000fiBVLXnAXi3/313igFP/YFNNscFZzdtPlQSoiAq
 UCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777540209; x=1778145009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uNayLLCXFFg34wv8nX5d4Vm4GrWa+HjlsC1+5DIJvb4=;
 b=Bo2wRo6Ty+Vw0xjajz226gCOlED10ex9BzXAMV1BRIgj8LnX+Wrg6VQZr8psiTg6qq
 WsT2Y+Elpb7hUdA7E2mT6Ot6gWzCK68pQmPLmKAck5nd0JXvfKHi3pjHLQcSsMntQ9SV
 V0vrFVszmXyYsWSc/Xa8ftTa0WY3kGIJSCf0Rv2xWdBOh5QxgDvZzwGmz+zLxm1zqUOy
 jF4mN945R3Z9AGm5fjCcoqpzZsaPnf5ZQZDtAhWpPiXvIhBq/fKJzxAOSVhbDTAbTl+m
 HU0Drs0phXkTtM0yHOTAfZDrd2r81FSM2860491j8PS+QlknTwQ0iWCxusvmkjhWfhA7
 0LTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uWUy8KO6NarncMSrvck2/wEy44o247jg0bemnu/lBbe8yXeZBY0C2IM+0yO9uhsldIVxwmstDhwE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkrQPqJj6alyBmbJ1l77LAfvylbIFDWlNkp4lc345ES2gze1cA
 4X5aAUxSqSlXz3td8DV8auJecDmWlVwzwPrMM/wdzEiLh7CDiaFcZVHwmmD3pEHzxUyVASiaw/p
 YZNEr8QL87ggHa+S8L5MKtfWJG5CXy2Y=
X-Gm-Gg: AeBDietBNoSR9y1iqAFPsJym/k3EpZ11dei4dzwueaUvspf9ff+aRTui+fZrzgULSl7
 n0XAmsv8tXSzf+HLSOoEHU9pJEvnw+XBFc2z7ym6QSAUf46r1bCuH119KUByYRj5YBtXAHZr2Q3
 GTGrg3ifNKd7h7Q/rtRy7SMsKwpFJbxfPKV+wuNItPGI0lYRvJBqZzjQrFkslGenLbuxpCn9nN/
 gUaoBxHzqFejtbxaV1hS06dWMuWkohwJAXIFz6raDCKXKUqz/j4mp/FjMKWTLEmngAB8xs+BwuD
 mNjGCMUXNIBbLzD9KE8=
X-Received: by 2002:a05:600c:a412:b0:48a:65ab:8059 with SMTP id
 5b1f17b1804b1-48a8607972amr22587615e9.13.1777540208950; Thu, 30 Apr 2026
 02:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260427075856.85208-1-clamor95@gmail.com>
 <SGKRjIZyS4mU2gPAiUbKJg@nvidia.com>
 <CAPVz0n16zCgCZwPXWMPg=KiYLwc3beBzVqYVB96in7zn0Wkxqw@mail.gmail.com>
 <soBCUeXPQ72A3pDzGjjMng@nvidia.com>
In-Reply-To: <soBCUeXPQ72A3pDzGjjMng@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 30 Apr 2026 12:09:57 +0300
X-Gm-Features: AVHnY4Je3sxCo-rN1StvJwz9cYuHqAYEyt3eRd6sgOWUegGJDGG9BA1xaOhYGlA
Message-ID: <CAPVz0n24mV5z_gqBtG9SXAvbu8EbAmNwrMEEa6XbGz_pUb4SVA@mail.gmail.com>
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

=D1=87=D1=82, 30 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:3=
8 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thursday, April 30, 2026 5:04=E2=80=AFPM Svyatoslav Ryhel wrote:
> > =D1=87=D1=82, 30 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
09:23 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Tuesday, April 28, 2026 1:57=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > =D0=B2=D1=82, 28 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 04:53 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Monday, April 27, 2026 4:58=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > > > From: Ion Agorria <ion@agorria.com>
> > > > > >
> > > > > > The gr*d_remove() has pm_runtime_disable, this indicates it sho=
uld be
> > > > > > paired with pm_runtime_enable in the probe instead of being ins=
ide
> > > > > > gr*d_runtime_resume().
> > > > > >
> > > > > > Signed-off-by: Ion Agorria <ion@agorria.com>
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
> > > > > >  drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
> > > > > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/teg=
ra/gr2d.c
> > > > > > index 21f4dd0fa6af..71f092d59d65 100644
> > > > > > --- a/drivers/gpu/drm/tegra/gr2d.c
> > > > > > +++ b/drivers/gpu/drm/tegra/gr2d.c
> > > > > > @@ -286,6 +286,10 @@ static int gr2d_probe(struct platform_devi=
ce *pdev)
> > > > > >       for (i =3D 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
> > > > > >               set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
> > > > > >
> > > > > > +     pm_runtime_enable(dev);
> > > > > > +     pm_runtime_use_autosuspend(dev);
> > > > > > +     pm_runtime_set_autosuspend_delay(dev, 500);
> > > > > > +
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > @@ -367,10 +371,6 @@ static int __maybe_unused gr2d_runtime_res=
ume(struct device *dev)
> > > > > >               goto disable_clk;
> > > > > >       }
> > > > > >
> > > > > > -     pm_runtime_enable(dev);
> > > > > > -     pm_runtime_use_autosuspend(dev);
> > > > > > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > > > > > -
> > > > > >       return 0;
> > > > > >
> > > > > >  disable_clk:
> > > > > > diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/teg=
ra/gr3d.c
> > > > > > index 42e9656ab80c..33e88ca4d4c5 100644
> > > > > > --- a/drivers/gpu/drm/tegra/gr3d.c
> > > > > > +++ b/drivers/gpu/drm/tegra/gr3d.c
> > > > > > @@ -517,6 +517,10 @@ static int gr3d_probe(struct platform_devi=
ce *pdev)
> > > > > >       for (i =3D 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
> > > > > >               set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
> > > > > >
> > > > > > +     pm_runtime_enable(&pdev->dev);
> > > > > > +     pm_runtime_use_autosuspend(&pdev->dev);
> > > > > > +     pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> > > > > > +
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > @@ -578,10 +582,6 @@ static int __maybe_unused gr3d_runtime_res=
ume(struct device *dev)
> > > > > >               goto disable_clk;
> > > > > >       }
> > > > > >
> > > > > > -     pm_runtime_enable(dev);
> > > > > > -     pm_runtime_use_autosuspend(dev);
> > > > > > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > > > > > -
> > > > > >       return 0;
> > > > > >
> > > > > >  disable_clk:
> > > > > > --
> > > > > > 2.51.0
> > > > > >
> > > > > >
> > > > >
> > > > > Oof, looks like I had managed to really bungle this with my earli=
er
> > > > > patch. Thanks for fixing it!
> > > > >
> > > >
> > > > Hello Mikko!
> > > >
> > > > Thank you for taking time and looking into this patch. Don't be so
> > > > harsh to yourself, PM is easy to mess and hard to set properly. Thi=
s
> > > > patch does fix gr*d access but it does not resolve the issue itself=
.
> > > > PM should be set in the init/exit rather then probe/remove. I have =
v2
> > > > which fixes this and one more minor issue and I will send them late=
r
> > > > on.
> > >
> > > Thanks! Why do you think it's necessary to enable runtime PM in init?
> > > If you look at the commit I referenced below (in 'Fixes'), we've had
> > > some issues in the past with doing pm_runtime_enable outside of probe=
,
> > > where the engine's power domain would be left enabled even when it is
> > > idle.
> > >
> > > gr2d/gr3d I suppose wouldn't be in practice affected by that issue
> > > though given they aren't in their own power domains.
> >
> > WDYM, gr2d and gr3d have their own power domains.
>
> Ah, my bad, didn't look far enough in the device tree.
>
> >
> > If the master device is unbound and rebound, gr2d_init() will run again=
, but
> > pm configuration is only located in this probe function which will not
> > run again, while pm disable are both in exit and remove. This results
> > in pm issue we are observing.
> >
> > Solution would be either do everyting in probe/remove, or init/exit.
> > Probe/remove will lead to domain being turned on even if engines are
> > idle. Init/exit seems to me more suitable and we have tasted this
> > configuration for a quite while in the grate DRM version.
>
> Yes, we should only do it in one place. Where are you observing the
> domain being turned on when idle?
>
> Genpd turns on the domain before probe is called, and it should turn
> it off again after probe if probe had enabled runtime PM and the usage
> count is zero. That's what we have currently for the newer engines like
> VIC and it's working.
>
> We used to have it in init/exit, but then we were seeing the domain
> sometimes being left on at boot, which makes some sense since as probe
> didn't enable runtime PM, genpd would leave the domain powered after
> probe. The domain would then also never get powered off when init
> enabled runtime PM. I assume the reason this only happened sometimes
> was that it was dependent on if the init function or the genpd
> post-probe code ran first.
>
> Based on that we should have the runtime PM handling in probe/remove,
> to ensure genpd turns off the domain after probe when there are no
> users.
>
> Mikko
>

Thank you for an explanation, I will adjust v2 accordingly (configure
PM in probe/remove).

> >
> > Best regards,
> > Svyatoslav R.
> >
> > >
> > > Cheers
> > > Mikko
> > >
> > > >
> > > > So for now this patch should not be picked.
> > > >
> > > > Best regards,
> > > > Svyatoslav R.
> > > >
> > > > > FWIW, I've been working on adding some nightly testing for Host1x=
/
> > > > > TegraDRM, so hopefully we'll be able to catch such things easier
> > > > > in the future.
> > > > >
> > > > > Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
> > > > > Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > > >
> > > > >
> > > > >
> > >
> > >
> > >
> > >
>
>
>
>
