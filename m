Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62335CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A575210F44F;
	Fri, 15 May 2026 07:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tAztS6MG";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A134F10F44F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:37:05 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso9788518eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 00:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778830625; cv=none;
 d=google.com; s=arc-20240605;
 b=DQnbks02EWYTvXYD6cW9QQ2IYdByVybdoPIXm4Zh0eZOh0quOasa7ru7c57coOrogj
 Fk0QSg/L5pVLIabkwnx8EHdA8f4KnqG0NsxxY0+PUbLpq65a+66vtpODgLQl+OdhD35T
 OpxQBWT0kS6LCKWUVIeFjS0fd+BFLHkpW50Wh0pa/C7QCEo6YhVaCh+29zCE5c287quW
 iWpGXCG/x+S2zNb+K4eqjy96Sf/1XkQYJ7Xvs5BgTXz9IyJsvhYqd9SxlmnKNEBOjv4a
 Tix8aPIeMOwLh0oqUtZtct1Z1OmKDdkV60dsfWZ2ghVfKEnhGPmA0kkta3Z3h5no6Y2a
 yOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NGjsU1/O6Qd2VzZsEHIRxKkGqBUr56OKbf0ka9VzVNg=;
 fh=qexzfrYoGx6t3a2B+QTPAYTsCSLHsoXtPYk0TuvJ0Go=;
 b=PmMQBpTq0lddjaqQXO8DRjo9Q1d+dOdKJYdV5jx+ELjcl5aK99jfgbTmg1NCDCe6LF
 X+f9y7ks6XiOTjTIv6lU3HOQHe3yi5DkVBExLYElwh7u2XLIfkaImv4N2CtvbOU214w6
 edGCOMGbmH842ZH3bSjXWcx7v0HYB9+n6jACMXp0bzr+v502t8TcLkq8a14S7mP1l7QD
 gZAZxZawbINCWb4FBeVc28pjBmo0MQ0Mf6g6vzb53EuYXn9WBN3qDjeDoTr9XK5FhlQ5
 PFsVVrwKL6CuAGb2PsgkrZ2stBa0cvIt9jXWTtXKOFnesJWMlMSZZ7XodPT+zEwAC9K/
 s2sQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778830625; x=1779435425; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGjsU1/O6Qd2VzZsEHIRxKkGqBUr56OKbf0ka9VzVNg=;
 b=tAztS6MG6l1KmbS2vASbpTGPpAVwsrlTZv694HCvK/M33jSKMyJHtyIkVTTXINb8pA
 TYTcmtAxTKui17Ps6FNBcfS+ZACaAE00lwtVvqfOaHaFH53fGk/uyNQVMKHDxE5xIgtL
 A04U5Zt27SzIFONPW9wupkMZlINe/YUnYG5r7dIuU5F3CbGSeFScR8z5hpFaoUx3pZNt
 Rca4lNB5PSQMQvFGM3bQMcyZrGyrHSnGH1466aGrZ46O4niHc/ij64pRtAzOORUSy+H9
 d6D890MceMkUO07vYOKS3pzC23OW8y5ZWkbWIf+FyGi24a4XhVTFatbbEQGDdilglOIB
 QbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778830625; x=1779435425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NGjsU1/O6Qd2VzZsEHIRxKkGqBUr56OKbf0ka9VzVNg=;
 b=rnKM/j2lKziPD8zhZlwOMW7VPOocZkKCRzuoIQL8qtvjOImlOQ/QdwhM5/50LnQLdg
 pXUwmcAB2SE90dkDcRq1PY8c5jfAruDXWHUnwSETI+0V0IUsaKBs7AN3oWa+GWp7XL9t
 WPETRSgim+/WPajAcz4OdyRNRGqo1ij0DFvO7N7hSOncnHiuKFXyy2Rr8tHtSTRTvAZy
 dI4iWs0ndtVwBqZhYU4vKXpj3ayZ4FKATvt3PCXnp0NG+VmhKInVfdmj5KDehtbhPJqQ
 3ZhxxSmRedRoOKUo2vNy5qttMLZqN6jxPHv2K5KvAugb7dyFrcvWph238O3B5axRb3Ku
 +noQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6uLepk6/U+so7owhavIvUumKxxcDDjIYQrr02g3xGWte8osZIARDnPY1iMfHYt51B9/s56kR6w1I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9be48GpyXWxOfSvg+tf0C6RX4M6hitNxf2XKL6vX2rJuaoKBH
 VWPQXZJDFe8x68+CIv2Svg1Y6razAwP00SgIvCkRRJHPPbl18Lx0OYVzGQ7+WzbxycAnYwcXpam
 RQsjwiZ+6pkk31n99wBr+3OOM2Kt73po=
X-Gm-Gg: Acq92OGBB/0FFg3j4TYVFOhuEb6mfIMgoaJLEa6ggg4oYt93IRmmkZni8P7iesx4qFg
 lHK/a9usofDafS2pbT2JPxyRA1r+jMgwFpQ49/NHgXpROrpZGPA6KGd3DJ9pAEugyp1jtzZLMRP
 15SeqY6u/vrxKwFpFFKlOMAkfvrFlmH6RT4c7+OVp/x6UPgOVpZHN/rVBzmj7j8fX+jct6jXveV
 aclVlmxv1szt0lxCVFjZmyjk+FusWt8Hx2nwCKBiPSK3KJ1d0bpJynzH0pCIy8O7iRTiheCRTRa
 1VnGf8+X
X-Received: by 2002:a05:7300:b10b:b0:2f3:986d:2d01 with SMTP id
 5a478bee46e88-3039868d07fmr1247518eec.19.1778830624718; Fri, 15 May 2026
 00:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260503163842.213489-1-clamor95@gmail.com>
 <20260503163842.213489-3-clamor95@gmail.com>
 <CAPVz0n1N4YHDPW=gsUZWZmRZbt8xQB1V8JWn6cyM75fo7H020w@mail.gmail.com>
 <yUGHnUTQTKW8E9_u4r6I9Q@nvidia.com>
In-Reply-To: <yUGHnUTQTKW8E9_u4r6I9Q@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 15 May 2026 10:36:52 +0300
X-Gm-Features: AVHnY4JzXMAApBNZ5wqO34OO89oihr8_LAAIa35jMjef7VdzRh3okcZk_JAMTcI
Message-ID: <CAPVz0n2vZ7p_7C6zsau0600JQM08Zyo3x09h=it6Z+=mXV5FMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/tegra: gr2d/gr3d: Contain PM in the
 gr*d_probe/gr*d_remove
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Ion Agorria <ion@agorria.com>, 
 Thierry Reding <thierry.reding@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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

=D1=87=D1=82, 14 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 07:0=
7 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Monday, May 4, 2026 3:36=E2=80=AFAM Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 3 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 1=
9:38 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > From: Ion Agorria <ion@agorria.com>
> > >
> > > The current power management configuration causes GR2G/GR3D to malfun=
ction
> > > after resume. Reconfigure all PM actions to be handled within the GR*=
D
> > > probe and remove operations to address this.
> > >
> > > Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
> > > Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > Signed-off-by: Ion Agorria <ion@agorria.com>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/gr2d.c | 11 ++++-------
> > >  drivers/gpu/drm/tegra/gr3d.c | 11 ++++-------
> > >  2 files changed, 8 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2=
d.c
> > > index e4148b034af7..ffcd076b5831 100644
> > > --- a/drivers/gpu/drm/tegra/gr2d.c
> > > +++ b/drivers/gpu/drm/tegra/gr2d.c
> > > @@ -100,9 +100,6 @@ static int gr2d_exit(struct host1x_client *client=
)
> > >         if (err < 0)
> > >                 return err;
> > >
> > > -       pm_runtime_dont_use_autosuspend(client->dev);
> > > -       pm_runtime_force_suspend(client->dev);
> > > -
> > >         host1x_client_iommu_detach(client);
> > >         host1x_syncpt_put(client->syncpts[0]);
> > >         host1x_channel_put(gr2d->channel);
> > > @@ -286,6 +283,10 @@ static int gr2d_probe(struct platform_device *pd=
ev)
> > >                 return err;
> > >         }
> > >
> > > +       pm_runtime_enable(dev);
> > > +       pm_runtime_use_autosuspend(dev);
> > > +       pm_runtime_set_autosuspend_delay(dev, 500);
> > > +
> >
> > Hello Mikko!
>
> Hello!
>
> >
> > I have used same setup as in VIC. May you please take a look to sashiko=
's check
> > https://sashiko.dev/#/patchset/20260502124055.22475-1-clamor95%40gmail.=
com
> >
> > I do agree with statement that pm_runtime_enable should be before
> > host1x_client_register since this same approach is widely used in the
> > media subsystem too.
>
> Yep, I agree as well.
>
> >
> > But I am more interested in your thoughts regarding sashiko's
> > gr2d_exit situation reasoning.
>
> It sounds accurate to me, there is probably a real issue. I expect
> there to be in general some driver unbind related issues, since it
> (particularly when the device is in use) isn't really being tested.
>
> FWIW, in an ideal world, it would probably make more sense to do the
> IOMMU handling on the platform device side, since the device's memory
> accesses are not related to host1x. But we can't really do that right
> now.
>
> For the time being, I don't think fixing this is particularly critical
> since other things will go wrong as well if root causes .exit to happen
> while the engine is executing. I can't say offhand what the proper full
> solution would be.
>

Thank you for sharing your thoughts on this topic. I will adjust
accordingly in v3

> Thanks
> Mikko
>
> >
> > Thank you!
> >
> > >         return 0;
> > >  }
> > >
> > > @@ -367,10 +368,6 @@ static int __maybe_unused gr2d_runtime_resume(st=
ruct device *dev)
> > >                 goto disable_clk;
> > >         }
> > >
> > > -       pm_runtime_enable(dev);
> > > -       pm_runtime_use_autosuspend(dev);
> > > -       pm_runtime_set_autosuspend_delay(dev, 500);
> > > -
> > >         return 0;
> > >
> > >  disable_clk:
> > > diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3=
d.c
> > > index 47b0c6c56bfd..cd5554e2117f 100644
> > > --- a/drivers/gpu/drm/tegra/gr3d.c
> > > +++ b/drivers/gpu/drm/tegra/gr3d.c
> > > @@ -109,9 +109,6 @@ static int gr3d_exit(struct host1x_client *client=
)
> > >         if (err < 0)
> > >                 return err;
> > >
> > > -       pm_runtime_dont_use_autosuspend(client->dev);
> > > -       pm_runtime_force_suspend(client->dev);
> > > -
> > >         host1x_client_iommu_detach(client);
> > >         host1x_syncpt_put(client->syncpts[0]);
> > >         host1x_channel_put(gr3d->channel);
> > > @@ -517,6 +514,10 @@ static int gr3d_probe(struct platform_device *pd=
ev)
> > >                 return err;
> > >         }
> > >
> > > +       pm_runtime_enable(&pdev->dev);
> > > +       pm_runtime_use_autosuspend(&pdev->dev);
> > > +       pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -578,10 +579,6 @@ static int __maybe_unused gr3d_runtime_resume(st=
ruct device *dev)
> > >                 goto disable_clk;
> > >         }
> > >
> > > -       pm_runtime_enable(dev);
> > > -       pm_runtime_use_autosuspend(dev);
> > > -       pm_runtime_set_autosuspend_delay(dev, 500);
> > > -
> > >         return 0;
> > >
> > >  disable_clk:
> > > --
> > > 2.51.0
> > >
>
>
>
>
