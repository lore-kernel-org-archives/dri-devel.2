Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A27BC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2D110E3EB;
	Thu, 13 Aug 2026 12:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="NLMQgDKA";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2EB10E3EB
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786623226; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=etVA2vj5k/53aGbPJCagg5V0mgs37Ee1eUtoyGR9jRaU4EqEYtN/UYR8Th3+5+4tBT2E2OGY9h3R4XyHZwn5yzyFfJ9TV+fjG/cwcBjfdAjo6gmnTT9+arU/GrKS4NgentLMlqZUNuHoAqCnJ1nhSyWeyQnLJktUHPgmtlSG7Nw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786623226;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wqOdRYtb0vZ5F+MtjvPnCnjoIXqeosMrsVTjv2kiOUU=; 
 b=a/M9Z4+wAFc3PXFTqTyRxkzKONOj4YsIwMvT0SzJJyWp2iR6auT4sGFE7P74qKZvzqXfSoCIFQQcWtBzsmbpz0PlEpAPxxDppcittvcloHZFTSYHE5iX8VXD+jIK+r3KwUXyd7pQyH5mR+Ht6d/e/iqkvvnxcaOCh2XCMgd2YU0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786623226; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=wqOdRYtb0vZ5F+MtjvPnCnjoIXqeosMrsVTjv2kiOUU=;
 b=NLMQgDKAg3YQQOS9sZ9pb+oCszkqAaCRyAO24iS5jKLajQCyJRMn6S7T9gpUMh+8
 h7czYoA2YU9OASI+6nAII9s0liaXwDDrMIu+JAbnYq/Vj+ACG+uIIGswfOsBKaAvyP/
 xeBEdOn3gIX2VafoGXuHAMGKTe19t88evtc707rc=
Received: by mx.zohomail.com with SMTPS id 1786623224736558.9306832210069;
 Thu, 13 Aug 2026 05:13:44 -0700 (PDT)
Date: Thu, 13 Aug 2026 13:13:39 +0100
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
Subject: Re: [PATCH v5 04/11] drm/panfrost: Move shrinker initialization and
 unplug one level down
Message-ID: <an2zl5n-OD0ucwwk@sobremesa>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-4-3d692c9e98c2@collabora.com>
 <20260812100755.123e7ee0@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812100755.123e7ee0@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.586.17
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

On 12.08.2026 10:07, Boris Brezillon wrote:
> On Tue, 11 Aug 2026 22:42:13 +0100
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
> > On top of that, remove the config feature check, because it's unnecessary.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++++++-
> >  drivers/gpu/drm/panfrost/panfrost_drv.c          |  6 ------
> >  drivers/gpu/drm/panfrost/panfrost_gem.c          | 25 ++++++++++++++----------
> >  drivers/gpu/drm/panfrost/panfrost_gem.h          |  7 ++++---
> >  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 ++------
> >  5 files changed, 28 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index d8421fd6a662..74992deb0b3a 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -281,9 +281,14 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  	if (err)
> >  		goto out_job;
> >  
> > -	panfrost_gem_init(pfdev);
> > +	err = panfrost_gem_init(pfdev);
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
> > @@ -305,6 +310,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  
> >  void panfrost_device_fini(struct panfrost_device *pfdev)
> >  {
> > +	panfrost_gem_fini(pfdev);
> >  	panfrost_perfcnt_fini(pfdev);
> >  	panfrost_jm_fini(pfdev);
> >  	panfrost_mmu_fini(pfdev);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 2e931fa90da0..331a3bd5b98c 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -1002,14 +1002,9 @@ static int panfrost_probe(struct platform_device *pdev)
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
> > @@ -1023,7 +1018,6 @@ static void panfrost_remove(struct platform_device *pdev)
> >  	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
> >  
> >  	drm_dev_unregister(&pfdev->base);
> > -	panfrost_gem_shrinker_cleanup(&pfdev->base);
> >  
> >  	pm_runtime_get_sync(pfdev->base.dev);
> >  	pm_runtime_disable(pfdev->base.dev);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > index 3a7fce428898..7b993a089af2 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > @@ -15,20 +15,25 @@
> >  #include "panfrost_gem.h"
> >  #include "panfrost_mmu.h"
> >  
> > -void panfrost_gem_init(struct panfrost_device *pfdev)
> > +int panfrost_gem_init(struct panfrost_device *pfdev)
> >  {
> >  	int err;
> >  
> > -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > -	    !panfrost_transparent_hugepage)
> > -		return;
> > +	if (panfrost_transparent_hugepage) {
> 
> Hm, are you sure it compiles fine when CONFIG_TRANSPARENT_HUGEPAGE=n?
> Feels like the linker would complain about a missing symbol in that
> case.

Yep, I don't have it enabled in the build config, and yet it compiles troublefree.
Steven had suggested getting rid of the feature check altogether, and I thought it
might trigger a compiler error, but it seems the linker might be resolving undefined
external variable symbols to 0.

> If you really want to simplify it this way, you probably need
> 
> #if IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> extern bool panfrost_transparent_hugepage;
> #else
> #define panfrost_transparent_hugepage false
> #endif

This makes it more clear so I'll go for it in the next iteration.

> in panfrost_drv.h.
> 
> > +		err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> > +		if (drm_gem_get_huge_mnt(&pfdev->base))
> > +			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> > +		else if (err)
> > +			drm_warn(&pfdev->base,
> > +				 "Can't use Transparent Hugepage (%d)\n", err);
> > +	}
> >  
> > -	err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> > -	if (drm_gem_get_huge_mnt(&pfdev->base))
> > -		drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> > -	else if (err)
> > -		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> > -			 err);
> > +	return panfrost_gem_shrinker_init(pfdev);
> > +}
> > +
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
