Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43E9CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0551C10E7F4;
	Tue, 16 Jun 2026 18:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="AR9dr0ni";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D416710E7F4
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 18:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781636046; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SK6BjwKZwmt2utiJL16iastjHhAML1IBbamMsh2iw53ypLsJ+wGdQhBFdW+DrK74cW8F4jc0QhWEWE9BRQbYnfZSYaso24Yy7WBPL1tNy5W5tYuHHi21b1TlK18Umv4rIcu1prryWXZbLZgzSltyeykUC5QvvmoW/QeXg3YwPP4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781636046;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1aV6M0pdUDxs+vXPo+6VMuqh+yzAl7I0/BtPsFYApFI=; 
 b=la256jv94v9v8cgBej4O1QCjTwhxNjUQ4d33j4GKuWCl9ZTeQ9z6SwgyRVSk15bC3rzT5huL6cgnQ0sxVnWxzSn5otJqGNmAWAyxTe81TQyTJGqDN5NYjm+EqVcVgZ8BZbBrIcgs/TwYSUe9qS98gXJzyNSA9fnhtnQVEpz8GkM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781636046; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=1aV6M0pdUDxs+vXPo+6VMuqh+yzAl7I0/BtPsFYApFI=;
 b=AR9dr0nia78LQ/j2dLX0SVRN1OWk0n1Pj5VcTayISVLb3wagLLAeNyDOZaU/blYl
 5FbvSiIKSgD8g0wBp9h1Zkesp12wx+1z2mFfGRLGa4CCYfvjX+u+R1gAeUb1pkX6r9w
 RTzQ/X4q3ZmyVColsq80y4cP4vl6FmzNYztba5DM=
Received: by mx.zohomail.com with SMTPS id 1781636043847279.81290595257667;
 Tue, 16 Jun 2026 11:54:03 -0700 (PDT)
Date: Tue, 16 Jun 2026 19:53:58 +0100
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
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/7] drm/panfrost: Move shrinker initialization and
 unplug one level down
Message-ID: <ajGbsQGTtjnqjLdH@sobremesa>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-3-57c6bd4c1655@collabora.com>
 <20260604200436.3db662af@fedora-2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604200436.3db662af@fedora-2.home>
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

On 04.06.2026 20:04, Boris Brezillon wrote:
> On Thu, 04 Jun 2026 18:35:22 +0100
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
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c       | 7 +++++++
> >  drivers/gpu/drm/panfrost/panfrost_drv.c          | 6 ------
> >  drivers/gpu/drm/panfrost/panfrost_gem.h          | 4 ++--
> >  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c | 8 ++------
> >  4 files changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 7fed22d555a5..87b372c9e675 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -282,9 +282,15 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  	if (err)
> >  		goto out_job;
> >  
> > +	err = panfrost_gem_shrinker_init(pfdev);
> > +	if (err)
> > +		goto out_perfcnt;
> > +
> >  	panfrost_gem_init(pfdev);
> 
> It feels weird to have the GEM shrinker initialized before the GEM
> component. Also, I'd consider the shrinker part of the GEM logic, so
> maybe call panfrost_gem_shrinker_init() from panfrost_gem_init() and
> change the prototype of panfrost_gem_init() to return an int.

Will move the code around in the next revision.

> >  
> >  	return 0;
> > +out_perfcnt:
> > +	panfrost_perfcnt_fini(pfdev);
> >  out_job:
> >  	panfrost_jm_fini(pfdev);
> >  out_mmu:
> > @@ -306,6 +312,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  
> >  void panfrost_device_fini(struct panfrost_device *pfdev)
> >  {
> > +	panfrost_gem_shrinker_fini(pfdev);
> >  	panfrost_perfcnt_fini(pfdev);
> >  	panfrost_jm_fini(pfdev);
> >  	panfrost_mmu_fini(pfdev);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index cb8e5015847f..2d4b6aa95c66 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -1000,14 +1000,9 @@ static int panfrost_probe(struct platform_device *pdev)
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
> > @@ -1021,7 +1016,6 @@ static void panfrost_remove(struct platform_device *pdev)
> >  	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
> >  
> >  	drm_dev_unregister(&pfdev->base);
> > -	panfrost_gem_shrinker_cleanup(&pfdev->base);
> >  
> >  	pm_runtime_get_sync(pfdev->base.dev);
> >  	pm_runtime_disable(pfdev->base.dev);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
> > index 79d4377019e9..323a1aee255e 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> > @@ -154,8 +154,8 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *bo,
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
