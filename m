Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B74BC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA5410F72D;
	Fri, 11 Sep 2026 23:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Jsm26mRv";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3310510F72D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169608; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mAAVftruK7RZ9u89zhkmXNyh3qvxYiEGBEfrf57eZyJ86b36g/B5ryA4hiQV0RqoedA4bpd8zpK1NsTyVvRHJbr1DeAXi1Kd01fg9n7QR47TsCQkse1bzw5oFKzOD9myRp/Wq7Um0u5pM8Of0CtrM9SgJ/WOtm4ojBdL+MOCzRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169608;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FlSuAj76Xa7+btWKg1rFtrdbbsqdb8pmg5RuE4pVw8Q=; 
 b=KOu9AHP+5+6zaagWPzxr7jUzdbDqRjd7lAHX07oPuNAdmWxivMZtgFm4HVr0wY8ikXd9tQRS6sYpZtRobQYDwKVlROiQM2TNkbjZk8dRn+oAAaPjwIaeoOQisOcg0yGBfju8Vo7gpSfptYKpfBZVLCR1SvviZjLDz+kvUh8o1kY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169608; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=FlSuAj76Xa7+btWKg1rFtrdbbsqdb8pmg5RuE4pVw8Q=;
 b=Jsm26mRvp27+E7Gla/l/m9cPR7hCZ1J2W4HW0n+RIU2a2CEH0uwfLiqJim278yny
 nG8BOSCvsoWFVxI1e1cUCRJJ3y7WLy7Iy9P6iy/hh80Z/uaYzhmOXOfknvZOD23s8uT
 uuOXzZfOt4eODuFaxxRJAx7ut4v1pR818WEse8nU=
Received: by mx.zohomail.com with SMTPS id 1789169607383556.0096067894884;
 Fri, 11 Sep 2026 16:33:27 -0700 (PDT)
Date: Sat, 12 Sep 2026 00:33:23 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Eric Anholt <eric@anholt.net>, "Marty E. Plummer" <hanetzer@startmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: fix autosuspend cleanup during teardown
Message-ID: <aqSOyUCZ7rT-u1hF@sobremesa>
References: <20260808135025.2872956-1-lgs201920130244@gmail.com>
 <anx91vwww0TMjLn8@sobremesa>
 <CANUHTR9Xneqaa7FvdKmwuBfKiBuj2nE+nOXOxuR_cJYjExiemQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANUHTR9Xneqaa7FvdKmwuBfKiBuj2nE+nOXOxuR_cJYjExiemQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.144.59
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

Hi Guangshou,

I'm afraid in the end I can't apply this patch because the series I wrote, besides including this
fix, has quite a few others to deal with existing issues with power management in the driver.
It felt awkard to apply this one in isolation without addresing the other bugs at the same time.

Check https://lore.kernel.org/r/20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com for further
context, patch 6/16 to be more precise.

However, like I said in a previous message, I'll soon be compiling a list of existing issues
and post them on a Freedesktop Gitlab issue for anyone curious to have a go at.

Cheers,
Adrian

On 13.08.2026 10:10, Guangshuo Li wrote:
> Hi Adrian,
> 
> On Wed, 12 Aug 2026 at 22:35, Adrián Larumbe
> <adrian.larumbe@collabora.com> wrote:
> >
> > Hi Guangshuo,
> >
> > Recently I've been working on a patch series that addresses PM refcnt imbalances in Panfrost.
> > One of the fixes introduces devm_pm_runtime_enable(), so manually calling pm_runtime_dont_use_autosuspend()
> > is no longer necessary like you mentioned in the commit message.
> >
> > However, there might be a point in using it during device teardown and probe error just like Panthor does,
> > becasue it doesn't make sense to postpone suspension when the device is going away.
> >
> > Anyway, you can have a look at it here:
> > https://lore.kernel.org/r/20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com
> >
> > I was thinking, I'll let you know when I've v6 ready and then you could rebase this patch onto it
> > before I submit the series to the ML so that I can send them all together?
> >
> > Kind Regards,
> > Adrian
> >
> > On 08.08.2026 21:50, Guangshuo Li wrote:
> > > panfrost_probe() calls pm_runtime_use_autosuspend(), but neither the
> > > probe error path nor panfrost_remove() calls the matching
> > > pm_runtime_dont_use_autosuspend() during teardown.
> > >
> > > If the autosuspend delay is set to a negative value while autosuspend
> > > is enabled, the runtime PM core increments usage_count to prevent
> > > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > > during teardown, this reference is not dropped.
> > >
> > > The documentation for pm_runtime_use_autosuspend() also notes that it
> > > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > > driver exit time, unless runtime PM was initially enabled with
> > > devm_pm_runtime_enable().
> > >
> > > Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> > > probe failure and device removal paths.
> > >
> > > This issue was found by manual code inspection.
> > >
> > > Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > index 784e36d72c2b..007dcba62e62 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > @@ -1011,6 +1011,7 @@ static int panfrost_probe(struct platform_device *pdev)
> > >  err_out2:
> > >       drm_dev_unregister(&pfdev->base);
> > >  err_out1:
> > > +     pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > >       pm_runtime_disable(pfdev->base.dev);
> > >       panfrost_device_fini(pfdev);
> > >       pm_runtime_set_suspended(pfdev->base.dev);
> > > @@ -1025,6 +1026,7 @@ static void panfrost_remove(struct platform_device *pdev)
> > >       drm_dev_unregister(&pfdev->base);
> > >       panfrost_gem_shrinker_cleanup(&pfdev->base);
> > >
> > > +     pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > >       pm_runtime_get_sync(pfdev->base.dev);
> > >       pm_runtime_disable(pfdev->base.dev);
> > >       panfrost_device_fini(pfdev);
> > > --
> > > 2.43.0
> >
> > Adrian Larumbe
> 
> Sure, I’d be glad to do that. Please let me know when v6 is ready, and
> I’ll rebase my patch on top of it.
> 
> Best regards,
> Guangshuo

Adrian Larumbe
