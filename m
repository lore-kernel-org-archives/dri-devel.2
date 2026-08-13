Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C9AC5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 02:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9496010E179;
	Thu, 13 Aug 2026 02:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qMIGjvBB";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE08110E179
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:11:01 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-81f3b227a4aso26017547b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786587060; cv=none;
 d=google.com; s=arc-20260327;
 b=UjUEi8S8fIP4aDk+LFqVT86K61Psh+J7VdAIgXGfWaSpMm1kdDs1XsZRujK3IfjbBa
 6HKjGRb1SlTZqvtdjRppzqlewK4FyKW6l3zOnaaUOHaxeHwgQAHvYrOhCrg9XAPU5ZyT
 xM0BMqGgUf1sCVL4nwdi42z2IgCYg8pfJAyQz/q4SirioQZNgb/CmcTY7ifNJ4WabLbS
 cmNIjMoeL9ZJqWrTxPqD7w0ztIWg/vauSZ0/uwjBI2YrsmH/t/kF3CFXfUH28ujlFvpQ
 zAspUXoFmYflH/AF6rEJmYr1kjKc0Yn6opKZ4+ReZz2ce+B4MmFFyX3yrTrzqS99V5CI
 W8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Rp5SLXgfrCQhmh0UUbqTofIr9miP1ABO7B+OUhWdvU=;
 fh=RlgabHkmQlDac1x5RxiYyQQZw2H0yEzyKAkAFD1gt3A=;
 b=f2lZWwFiOhhigGv2uUjtZUMrEEi5ksvPsrzE/h70YpVq0JqUxUVZdnYi+kkLE2/fq6
 Zqc7k8SRq+3Xng8gTsXGDB8qCrXjtFhhoX/wYmbBJ09aaLfysUu/9+yMOSeHeSb+9Lsu
 0yTc7BERQTLbCdopxDs+v9DYTeohnyvsR3A4t7/OkR7YGQw4OPk1ZlcnMm9ZB+qeuG5X
 IzQZLRAaiplAp5bFItFgBm+OBaTbsGHfIBqJNbR/5XFovSX18ITaCu5Z614FrkO17Mjk
 0/xLuQWJqHselC/Bq+i11I1mTIFIBOjlCoa5Y99LC+J17k1ShViJbGVjtm7+U7XhVb/6
 g/nA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786587060; x=1787191860; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9Rp5SLXgfrCQhmh0UUbqTofIr9miP1ABO7B+OUhWdvU=;
 b=qMIGjvBBH32gRYSMabDtjpyXacW8Y0IBS2qta9Riy24updQG1vj4+GmPHaPOQ5+Gt6
 74lLt4Up/92AB7X6vWeMPtFhVzA6qE2RJLa2Gpr8ACe/s3Jvfqrht9io7747fsQToJM0
 OsjlhA9qGw777G5lI8XRfUaEoJKOvVzwaj5g7qbxfF/13mKMKgw4Wo/1reZJhoanzaqW
 GpsZ1FYg+aUQz4+YFgITKsQEEOcvChaK6o34ubM70TWDAXghFHmSpN+EUNLKjxtbRV2E
 TMaenkYa0uWIKiQX8dPnK3YubjwOCksCEhoLSBaDmVIwv2gfGl0CpYloRQgCyfHNxwjd
 Aydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786587060; x=1787191860;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Rp5SLXgfrCQhmh0UUbqTofIr9miP1ABO7B+OUhWdvU=;
 b=c3wOPjDzGbp3WCpqX9oegGSC5sc43xBEq/99btCX9FSusG8mkDyQ6hCs59mu7rnBRx
 5WPKhJinRMZ136/2XObBHHR7+FsGBpuiGm/e+CRtHbflefgxBXpxp85g362+rzwzpymN
 435MUqzqARXLQMHjblZ9Wuyifihgge3aIVOSWZ8kqIsI6c6WaE7QsgyU5beUDMs5I8Dz
 ikvsk3roW4ec9BUSDn54q5Bnon5HQ7pSFxgGqrYFTQOFsDjfo/V0HBZ2diDOCnICUnrv
 p74lxAzxWDAgTSAmm59u2J4Ef3mQFmT/kPxpFxKoLjF5f/3Vqdce1uPP4SV9slS4/yUD
 /yUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnNFUcc1pLWAUYykfvNutUwucAfx5+6OrbxscKFc99/cpLFE0I5XNIYsS8iYzheC+4s31tdW839GI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz70kvKw8fVs2LfxlkP1NQ5vdxyoaRCb65AUFDTuerm8Yifmto
 6k1fpuGChXu9XdtF1SoVkx6H+fHyhmPXMM85dpp/9U1wC4LGuk0hzmVdecF+caY+D2X734xuQ0e
 5oN5203LzmstJ4Jpg9pxlV6AGbrkum9I=
X-Gm-Gg: AR+sD12rQ1Fq9LbnSDfHwrgmfFlwfnrk2BnX8tw3Ez+FVxutywTQLUL+UMF2eLqr/aD
 RFJUY4WOw0Eb5tORmeJ6f27wtjh7MKPxilnBnNGD5NLyOD8BKmjgyjKDE8hzFq5CJVR9y8rkTc7
 TgFjLh9AX9A3lUc9YJDFdYqc5In3foGYMWITog7XXpTSD61UEq/3ao7wP1q73ZpN1uTo2UCD9zw
 9tdIRKgjrO8w1NRZk0boZZl7z7PxelUW6UMMFU5nzpokter1v/mWIaDUT5LzvUkUncJ6z5xr1gV
 HD9hC4Ac9VOueOpog/gv4q4n+RIuxWf7jQVjhK4yBDTZ8cRC3kGzk7QFk0g=
X-Received: by 2002:a05:690c:4382:b0:81e:6cd1:5322 with SMTP id
 00721157ae682-8347410554cmr9789827b3.20.1786587060367; Wed, 12 Aug 2026
 19:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260808135025.2872956-1-lgs201920130244@gmail.com>
 <anx91vwww0TMjLn8@sobremesa>
In-Reply-To: <anx91vwww0TMjLn8@sobremesa>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 13 Aug 2026 10:10:49 +0800
X-Gm-Features: AUfX_mxdPMQKUM5spWc1_tbZcR93BbRrOrNtf5zkfvwbqCalbIw3eawOEzoR4Pw
Message-ID: <CANUHTR9Xneqaa7FvdKmwuBfKiBuj2nE+nOXOxuR_cJYjExiemQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: fix autosuspend cleanup during teardown
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Hi Adrian,

On Wed, 12 Aug 2026 at 22:35, Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
>
> Hi Guangshuo,
>
> Recently I've been working on a patch series that addresses PM refcnt imb=
alances in Panfrost.
> One of the fixes introduces devm_pm_runtime_enable(), so manually calling=
 pm_runtime_dont_use_autosuspend()
> is no longer necessary like you mentioned in the commit message.
>
> However, there might be a point in using it during device teardown and pr=
obe error just like Panthor does,
> becasue it doesn't make sense to postpone suspension when the device is g=
oing away.
>
> Anyway, you can have a look at it here:
> https://lore.kernel.org/r/20260811-claude-fixes-v5-0-3d692c9e98c2@collabo=
ra.com
>
> I was thinking, I'll let you know when I've v6 ready and then you could r=
ebase this patch onto it
> before I submit the series to the ML so that I can send them all together=
?
>
> Kind Regards,
> Adrian
>
> On 08.08.2026 21:50, Guangshuo Li wrote:
> > panfrost_probe() calls pm_runtime_use_autosuspend(), but neither the
> > probe error path nor panfrost_remove() calls the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> > probe failure and device removal paths.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/=
panfrost/panfrost_drv.c
> > index 784e36d72c2b..007dcba62e62 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -1011,6 +1011,7 @@ static int panfrost_probe(struct platform_device =
*pdev)
> >  err_out2:
> >       drm_dev_unregister(&pfdev->base);
> >  err_out1:
> > +     pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> >       pm_runtime_disable(pfdev->base.dev);
> >       panfrost_device_fini(pfdev);
> >       pm_runtime_set_suspended(pfdev->base.dev);
> > @@ -1025,6 +1026,7 @@ static void panfrost_remove(struct platform_devic=
e *pdev)
> >       drm_dev_unregister(&pfdev->base);
> >       panfrost_gem_shrinker_cleanup(&pfdev->base);
> >
> > +     pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> >       pm_runtime_get_sync(pfdev->base.dev);
> >       pm_runtime_disable(pfdev->base.dev);
> >       panfrost_device_fini(pfdev);
> > --
> > 2.43.0
>
> Adrian Larumbe

Sure, I=E2=80=99d be glad to do that. Please let me know when v6 is ready, =
and
I=E2=80=99ll rebase my patch on top of it.

Best regards,
Guangshuo
