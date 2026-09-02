Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB77C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471A410F298;
	Wed,  2 Sep 2026 15:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="j1bobwI8";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521FE10F298
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788363740; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Z1LLPmqxAPcRd3o0pcxK1HenerVmj85vCh8cLLQrss+rsVmXqbEwEwtCfnu+1OQdx6CeEpM1QJjznJSVmuWD+swVr8UtSM9Hg7xbFgfdwTxcOFeRcPxsZwTBFDUfCKCLKUYosZAb2+MwgkN01koeSRmPP+HDKd/3ZywHRGIQEv4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788363740;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2picS1OgChPLKvse87oVsLacm/Le15G/jsD8lmSkT14=; 
 b=eu9NqlsVYG86cG6XIYntga3yjKDjLzL7n9Vgk9/L1XE3zW3YuWMgNYxKSTki1Hyms4SzSLmgkkxUOcYxM9m0Jk0q3VFKWbqLxpc9JLVnjkmVYEBCGKiTFbI/cW+FPfWnrz3OOvMwe/a8gW1R8AOnKGQ5i3M5Sx9vI4vOasdOPOI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788363740; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=2picS1OgChPLKvse87oVsLacm/Le15G/jsD8lmSkT14=;
 b=j1bobwI8vQ9s/ncUv6KABo4OhtqdesanPFFxMZB3ynDOoyO9CoR72iE5P8Ka99L5
 SNSYBkb7idqnJPgyifyfv887ABcjTZ5wOcBeGXwIvEw+FFTeSPEWqudISp56/bCZcLm
 o00rNeR0JZ5UmvD5oKuKt6iJiYo7LLP3ON9sFPlI=
Received: by mx.zohomail.com with SMTPS id 1788363738335560.949957580038;
 Wed, 2 Sep 2026 08:42:18 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:42:12 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 09/17] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
Message-ID: <aphDworPxx8fDJ_Z@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-9-72a13b2c125d@collabora.com>
 <20260901151856.433920b6@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901151856.433920b6@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.352.18
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

On 01.09.2026 15:18, Boris Brezillon wrote:
> On Fri, 28 Aug 2026 21:56:49 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > During device probe(), failure to do a PM get() will leave the usage_count
> > set to 0, which is the value assigned at device creation time. That means
> > when the autosuspend delay expires, runtime suspend callback won't be
> > invoked, so the device will remain powered on forever.
> > 
> > On top of that, failure to call PM put() during device unplug means
> > Panfrost device's PM usage_count increases monotonically for every new
> > module reload.
> > 
> > The combined outcome of both of the above was that devfreq OPP transition
> > notifications would be printed all the time, even when no jobs are being
> > submitted. This quickly fills the kernel ring buffer with junk.
> > 
> > To fix the above:
> > - Manually adjust the PM refcnt at device probe and removal time.
> > - Ensure pm_runtime_dont_use_autosuspend is called in the wind-down path.
> > - Call pm_runtime_put_autosuspend() when device is ready to accept jobs
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> > Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> 
> Because of how things are currently ordered, this won't be backportable
> without patch 2, which doesn't have a Fixes tag, so, either we put the
> fix first, and then we move code, or we make it a single commit.

I think I mentioned it in a previous reply. Maybe it's best to fix the outstanding issues first
and then moving code into panfrost_{init|fini}().

> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 99f7da2180f9..70c8109ea698 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -322,6 +322,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  
> >  	pm_runtime_set_active(pfdev->base.dev);
> >  	pm_runtime_mark_last_busy(pfdev->base.dev);
> > +	pm_runtime_get_noresume(pfdev->base.dev);
> >  	pm_runtime_enable(pfdev->base.dev);
> >  	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> >  	pm_runtime_use_autosuspend(pfdev->base.dev);
> > @@ -334,9 +335,13 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  	if (err < 0)
> >  		goto out_devreg;
> >  
> > +	pm_runtime_put_autosuspend(pfdev->base.dev);
> > +
> >  	return 0;
> >  
> >  out_devreg:
> > +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > +	pm_runtime_put_noidle(pfdev->base.dev);
> >  	pm_runtime_disable(pfdev->base.dev);
> >  	panfrost_device_disable_hw(pfdev);
> >  	panfrost_gem_fini(pfdev);
> > @@ -363,7 +368,9 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  void panfrost_device_fini(struct panfrost_device *pfdev)
> >  {
> >  	pm_runtime_get_sync(pfdev->base.dev);
> > +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> >  	pm_runtime_disable(pfdev->base.dev);
> > +	pm_runtime_put_noidle(pfdev->base.dev);
> >  
> >  	panfrost_jm_stop_sched_jobs(pfdev);
> >  	panfrost_device_disable_hw(pfdev);
> > 

Adrian Larumbe
