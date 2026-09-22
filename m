Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6CBC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C134010E50D;
	Tue, 22 Sep 2026 19:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="foIrbrCo";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E5B10E50D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790106536; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MlPBaavk29ZezJmOyPaHh2WVaQ/XgRa3z4yDCD7Bi6IuFbtAwbHvAGgueUkb5E7nN1l+6fgfst7tzHJunIu41pIyv3s7vnZh0cfubkifxd5sFU3w0jggPtFfDRw0ZZMCXprLo13cxVrnpKLkxROIzjF2uX4qntfUX9oMouXHI1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790106536;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fN4E694cv3ODeRMa+28gkiMvY1YDqV4H4WuCsqs10B8=; 
 b=HR1ftkVMnUWznJXKEEfR2O3H9RR046f2qT7ftc8Nq5YhKVlgHTeku/0J69DvwgZPCseXjPsjn5Gp+dto8iQiYgyoF/LYoo4TMWmJp0Wi0h0orta3hRuRGVH7W17f3UBvp8NGoLVcLML5zLiWXBveCnrp0NwIonmqCKW/7MmTQyc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790106536; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=fN4E694cv3ODeRMa+28gkiMvY1YDqV4H4WuCsqs10B8=;
 b=foIrbrCoI7GWAFHuCwD/4LB5NitoLJQI1dFapEo14sNeD/7kP5hp7TpFBUPA6nyD
 jfHRiP7zJT4uZc/tDMnwtYwPBBAbdxBN+4zv7tJdSd/AKPy3AOsE3Biw2gIpSg9gpz4
 DzzD8hnZt6nS9TATgdThKDmVf+D+DOFdWXvMXsAo=
Received: by smtp.zohomail.com with SMTPS id 1790106535786519.7385543340581;
 Tue, 22 Sep 2026 12:48:55 -0700 (PDT)
Date: Tue, 22 Sep 2026 20:48:49 +0100
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
Subject: Re: [PATCH v9 01/16] drm/panfrost: Move shrinker initialization and
 unplug one level down
Message-ID: <arFQG1AYMXlRgmJS@sobremesa>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-1-e588feaa61ef@collabora.com>
 <20260914103646.6f1b7246@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914103646.6f1b7246@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.95.26
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

On 14.09.2026 10:36, Boris Brezillon wrote:
> On Sat, 12 Sep 2026 00:28:02 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Since the moment we call drm_dev_register() the device should be in a
> > position to accept jobs, so it's best if the shrinker is already
> > initialized by then.
> > 
> > On top of that, make shrinker functions take an panfrost_device pointer
> > like other functions in the same sequence and rename them accordingly.
> > 
> > Essentially mimic the init/fini behaviour in Panthor.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> One remark below.
> 
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++++++-
> >  drivers/gpu/drm/panfrost/panfrost_drv.c          |  6 ------
> >  drivers/gpu/drm/panfrost/panfrost_gem.c          | 26 ++++++++++++++----------
> >  drivers/gpu/drm/panfrost/panfrost_gem.h          |  7 ++++---
> >  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 ++------
> >  5 files changed, 28 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 485349faf251..05c40d5a20b5 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -280,9 +280,14 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  	if (err)
> >  		goto out_job;
> >  
> > -	panfrost_gem_init(pfdev);
> > +	err = panfrost_gem_init(pfdev);
> 
> It feels weird to have the GEM subsystem initialized last when you
> consider the fact other subsystems might want to allocate GEMs in their
> _init() function. I know it's where the panfrost_gem_init() is right
> now, and that ultimately it doesn't prevent anyone from allocating
> GEMs, but I think it would make sense have this called before any of
> the other subsystem init functions, still.

I think we discussed having panfrost_gem_init() be called before the other
subsystem init functions, but then I checked panthor and saw it's also being
called right after all the others there too. I think you're right that it's
best to initialise gem first, because I wonder whether other subsystem init
functions creating GEMs when the mount point for huge page-backed objects
hasn't been created yet could lead to some sort of trouble.

However, given how much this patch series has already grown, I believe it'd
be best to leave this change for a later one.

> > +	if (err)
> > +		goto out_perfcnt;
> >  
> >  	return 0;
> > +
> > +out_perfcnt:
> > +	panfrost_perfcnt_fini(pfdev);
> >  out_job:
> >  	panfrost_jm_fini(pfdev);
> >  out_mmu:
> > @@ -304,6 +309,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  
> >  void panfrost_device_fini(struct panfrost_device *pfdev)
> >  {
> > +	panfrost_gem_fini(pfdev);
> >  	panfrost_perfcnt_fini(pfdev);
> >  	panfrost_jm_fini(pfdev);
> >  	panfrost_mmu_fini(pfdev);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 96a66d673ba6..9882a3ede75f 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -1003,14 +1003,9 @@ static int panfrost_probe(struct platform_device *pdev)
> >  	if (err < 0)
> >  		goto err_out1;
> >  
> > -	err = panfrost_gem_shrinker_init(&pfdev->base);
> > -	if (err)
> > -		goto err_out2;
> >  
> >  	return 0;
> >  
> > -err_out2:
> > -	drm_dev_unregister(&pfdev->base);
> >  err_out1:
> >  	pm_runtime_disable(pfdev->base.dev);
> >  	panfrost_device_fini(pfdev);
> > @@ -1024,7 +1019,6 @@ static void panfrost_remove(struct platform_device *pdev)
> >  	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
> >  
> >  	drm_dev_unregister(&pfdev->base);
> > -	panfrost_gem_shrinker_cleanup(&pfdev->base);
> >  
> >  	pm_runtime_get_sync(pfdev->base.dev);
> >  	pm_runtime_disable(pfdev->base.dev);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > index 3a7fce428898..f39c0f50ed4f 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > @@ -15,20 +15,24 @@
> >  #include "panfrost_gem.h"
> >  #include "panfrost_mmu.h"
> >  
> > -void panfrost_gem_init(struct panfrost_device *pfdev)
> > +int panfrost_gem_init(struct panfrost_device *pfdev)
> >  {
> > -	int err;
> > +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && panfrost_transparent_hugepage) {
> > +		int err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> > +
> > +		if (drm_gem_get_huge_mnt(&pfdev->base))
> > +			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> > +		else if (err)
> > +			drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> > +				 err);
> > +	}
> >  
> > -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > -	    !panfrost_transparent_hugepage)
> > -		return;
> > +	return panfrost_gem_shrinker_init(pfdev);
> > +}
> >  
> > -	err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> > -	if (drm_gem_get_huge_mnt(&pfdev->base))
> > -		drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> > -	else if (err)
> > -		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> > -			 err);
> > +void panfrost_gem_fini(struct panfrost_device *pfdev)
> > +{
> > +	panfrost_gem_shrinker_fini(pfdev);
> >  }
> >  
> >  #ifdef CONFIG_DEBUG_FS
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
> > index 79d4377019e9..5c823cdbd980 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> > @@ -129,7 +129,8 @@ drm_mm_node_to_panfrost_mapping(struct drm_mm_node *node)
> >  	return container_of(node, struct panfrost_gem_mapping, mmnode);
> >  }
> >  
> > -void panfrost_gem_init(struct panfrost_device *pfdev);
> > +int panfrost_gem_init(struct panfrost_device *pfdev);
> > +void panfrost_gem_fini(struct panfrost_device *pfdev);
> >  
> >  struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t size);
> >  
> > @@ -154,8 +155,8 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *bo,
> >  void panfrost_gem_mapping_put(struct panfrost_gem_mapping *mapping);
> >  void panfrost_gem_teardown_mappings_locked(struct panfrost_gem_object *bo);
> >  
> > -int panfrost_gem_shrinker_init(struct drm_device *dev);
> > -void panfrost_gem_shrinker_cleanup(struct drm_device *dev);
> > +int panfrost_gem_shrinker_init(struct panfrost_device *pfdev);
> > +void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev);
> >  
> >  void panfrost_gem_set_label(struct drm_gem_object *obj, const char *label);
> >  int panfrost_gem_sync(struct drm_gem_object *obj, u32 type,
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> > index 2fe967a90bcb..fefae87535d6 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> > @@ -95,10 +95,8 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
> >   *
> >   * This function registers and sets up the panfrost shrinker.
> >   */
> > -int panfrost_gem_shrinker_init(struct drm_device *dev)
> > +int panfrost_gem_shrinker_init(struct panfrost_device *pfdev)
> >  {
> > -	struct panfrost_device *pfdev = to_panfrost_device(dev);
> > -
> >  	pfdev->shrinker = shrinker_alloc(0, "drm-panfrost");
> >  	if (!pfdev->shrinker)
> >  		return -ENOMEM;
> > @@ -118,10 +116,8 @@ int panfrost_gem_shrinker_init(struct drm_device *dev)
> >   *
> >   * This function unregisters the panfrost shrinker.
> >   */
> > -void panfrost_gem_shrinker_cleanup(struct drm_device *dev)
> > +void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev)
> >  {
> > -	struct panfrost_device *pfdev = to_panfrost_device(dev);
> > -
> >  	if (pfdev->shrinker)
> >  		shrinker_free(pfdev->shrinker);
> >  }
> > 

Adrian Larumbe
