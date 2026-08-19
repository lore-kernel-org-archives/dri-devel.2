Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43389C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9330F10E584;
	Wed, 19 Aug 2026 17:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Lyy7VsZE";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BA410E584
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787158908; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HNdS8MjByfsKVGSrHAjsjLc1nfEtpMofJhsenJU+pJeDHWNrOV0WX3IKbfd2x/4vdSFwPiePDXADV2PLgXlJajZFjZuGyw+vFqfpw4lXqIZ/v3T4GuJ/2Vgz/xvxsmLHUaqDhMMkWFqOIkA6KdCpzncigl3csMyYlsCZQN4HPOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787158908;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HUzoSDR1e8bxaibYyiWC1Kp95BxbUNo5sg5WntGsUPo=; 
 b=X0oeW2oZu6pLgeo2omdDslO+ue1nQ/mDin3IKV+8FbIQwhxUyzMvEDj8uitVtRJA+Tr4nWgVDEG0FpCfxVYhb2UJRjbU23Fj+KNnNHuAnD6IaAMSFS3vjeYDg/Bn2RAaa39ZaQCJqE+JCJqUfbwn3lVD8UcFMvSZefnkAcsNP5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787158908; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=HUzoSDR1e8bxaibYyiWC1Kp95BxbUNo5sg5WntGsUPo=;
 b=Lyy7VsZEM5bCF+krL+qmfTBZo4OPHVx1qb6lFiXiunyvaNXKqStYgbXcXjytYe4K
 kNeCiiOd3NuFaCz0EebA6suaSlO92RB1zlssSZyqQxxiB1fJsyZ3nFiCEK0hRfFbokE
 mu6J3/xOPmgFUF6lLNif/vxV2VHFFRF8eaNJrlag=
Received: by mx.zohomail.com with SMTPS id 1787158905742487.7381506216959;
 Wed, 19 Aug 2026 10:01:45 -0700 (PDT)
Date: Wed, 19 Aug 2026 18:01:40 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 04/13] drm/panfrost: Move shrinker initialization and
 unplug one level down
Message-ID: <aoXhZrkyo0flUi-k@sobremesa>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-4-01968f2ec77a@collabora.com>
 <faac1559-e1d1-4756-9bbd-01f760628fb9@arm.com>
 <anvJUe007987gwNY@sobremesa>
 <246ab9b9-cf18-48bd-9c44-b02351445360@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <246ab9b9-cf18-48bd-9c44-b02351445360@arm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.151.46
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

On 19.08.2026 11:37, Steven Price wrote:
> On 12/08/2026 02:19, Adrián Larumbe wrote:
> > Hi Steven,
> > 
> > On 30.07.2026 11:39, Steven Price wrote:
> >> On 29/07/2026 03:54, Adrián Larumbe wrote:
> >>> Since the moment we call drm_dev_register() the device should be in a
> >>> position to accept jobs, so it's best if the shrinker is already
> >>> initialized by then.
> >>>
> >>> On top of that, make shrinker functions take an panfrost_device pointer
> >>> like other functions in the same sequence and rename them accordingly.
> >>>
> >>> Essentially mimic the init/fini behaviour in Panthor.
> >>>
> >>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> >>> ---
> >>>  drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++++++-
> >>>  drivers/gpu/drm/panfrost/panfrost_drv.c          |  6 ------
> >>>  drivers/gpu/drm/panfrost/panfrost_gem.c          | 19 ++++++++++---------
> >>>  drivers/gpu/drm/panfrost/panfrost_gem.h          |  6 +++---
> >>>  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 ++------
> >>>  5 files changed, 22 insertions(+), 25 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> >>> index d8421fd6a662..03905495aee2 100644
> >>> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> >>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> >>> @@ -281,9 +281,14 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >>>  	if (err)
> >>>  		goto out_job;
> >>>  
> >>> -	panfrost_gem_init(pfdev);
> >>> +	err = panfrost_gem_init(pfdev);
> >>> +	if (err)
> >>> +		goto out_perfcnt;
> >>>  
> >>>  	return 0;
> >>> +
> >>> +out_perfcnt:
> >>> +	panfrost_perfcnt_fini(pfdev);
> >>>  out_job:
> >>>  	panfrost_jm_fini(pfdev);
> >>>  out_mmu:
> >>> @@ -305,6 +310,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >>>  
> >>>  void panfrost_device_fini(struct panfrost_device *pfdev)
> >>>  {
> >>> +	panfrost_gem_shrinker_fini(pfdev);
> >>>  	panfrost_perfcnt_fini(pfdev);
> >>>  	panfrost_jm_fini(pfdev);
> >>>  	panfrost_mmu_fini(pfdev);
> >>> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> >>> index 2e931fa90da0..331a3bd5b98c 100644
> >>> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> >>> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> >>> @@ -1002,14 +1002,9 @@ static int panfrost_probe(struct platform_device *pdev)
> >>>  	if (err < 0)
> >>>  		goto err_out1;
> >>>  
> >>> -	err = panfrost_gem_shrinker_init(&pfdev->base);
> >>> -	if (err)
> >>> -		goto err_out2;
> >>>  
> >>>  	return 0;
> >>>  
> >>> -err_out2:
> >>> -	drm_dev_unregister(&pfdev->base);
> >>>  err_out1:
> >>>  	pm_runtime_disable(pfdev->base.dev);
> >>>  	panfrost_device_fini(pfdev);
> >>> @@ -1023,7 +1018,6 @@ static void panfrost_remove(struct platform_device *pdev)
> >>>  	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
> >>>  
> >>>  	drm_dev_unregister(&pfdev->base);
> >>> -	panfrost_gem_shrinker_cleanup(&pfdev->base);
> >>>  
> >>>  	pm_runtime_get_sync(pfdev->base.dev);
> >>>  	pm_runtime_disable(pfdev->base.dev);
> >>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> >>> index 3a7fce428898..aa3a604b3439 100644
> >>> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> >>> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> >>> @@ -15,20 +15,21 @@
> >>>  #include "panfrost_gem.h"
> >>>  #include "panfrost_mmu.h"
> >>>  
> >>> -void panfrost_gem_init(struct panfrost_device *pfdev)
> >>> +int panfrost_gem_init(struct panfrost_device *pfdev)
> >>>  {
> >>>  	int err;
> >>>  
> >>>  	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> >>> -	    !panfrost_transparent_hugepage)
> >>> -		return;
> >>> +	    panfrost_transparent_hugepage) {
> >>
> >> Note you haven't quite inverted the condition here, but I don't think
> >> the new condition is wrong - we skip the otherwise no-op helpers. The
> >> old condition seems a bit backward. Indeed I'm not really sure why we
> >> bother with the IS_ENABLED() check at all. But the new code looks fine.
> > 
> > I've heeded your advice and done away with the IS_ENABLED() check in v5.
> > I'm curious about why that would work though. Is it because the linker initialises
> > symbols marked as 'extern' to 0 when they aren't resolved?
> > 
> > Otherwise I would've assumed the compiler would throw out a missing definition
> > error at link time, but then again I'm unsure about this.
> 
> Hmm, I hadn't actually spotted that panfrost_transparent_hugepage wasn't
> defined unless CONFIG_TRANSPARENT_HUGEPAGE. Usually this is handled with
> a bit of macro magic that #defines the symbol if it's not relevant. I
> would expect the linker to complain if this symbol still exists in the
> final output.

Boris suggested I do this too, namely declaring the symbol as a preprocessor
define in case CONFIG_TRANSPARENT_HUGEPAGE is not enabled.

> One possibility is that the compiler is spotting that the
> drm_gem_huge_mnt_create() and drm_gem_get_huge_mnt() functions are all
> no-ops in this case, so the entire if() branch can be removed (along
> with the condition check). Although I'm not sure how safe it is to rely
> on such compiler optimisations.

My understanding is that one cannot build the kernel without compiler optimisations,
but still for the sake of clarity and to avoid any nasty surprises in the future,
I think I'll just declare panfrost_transparent_hugepage as a macro equal to 0
when the kernel is built without support for transparent huge pages.

> Thanks,
> Steve
> 
> >> Reviewed-by: Steven Price <steven.price@arm.com>
> >>
> >> Thanks,
> >> Steve
> >>
> >>> +		err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> >>> +		if (drm_gem_get_huge_mnt(&pfdev->base))
> >>> +			drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> >>> +		else if (err)
> >>> +			drm_warn(&pfdev->base,
> >>> +				 "Can't use Transparent Hugepage (%d)\n", err);
> >>> +	}
> >>>  
> >>> -	err = drm_gem_huge_mnt_create(&pfdev->base, "within_size");
> >>> -	if (drm_gem_get_huge_mnt(&pfdev->base))
> >>> -		drm_info(&pfdev->base, "Using Transparent Hugepage\n");
> >>> -	else if (err)
> >>> -		drm_warn(&pfdev->base, "Can't use Transparent Hugepage (%d)\n",
> >>> -			 err);
> >>> +	return panfrost_gem_shrinker_init(pfdev);
> >>>  }
> >>>  
> >>>  #ifdef CONFIG_DEBUG_FS
> >>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
> >>> index 79d4377019e9..d6e55c2e4d86 100644
> >>> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> >>> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> >>> @@ -129,7 +129,7 @@ drm_mm_node_to_panfrost_mapping(struct drm_mm_node *node)
> >>>  	return container_of(node, struct panfrost_gem_mapping, mmnode);
> >>>  }
> >>>  
> >>> -void panfrost_gem_init(struct panfrost_device *pfdev);
> >>> +int panfrost_gem_init(struct panfrost_device *pfdev);
> >>>  
> >>>  struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t size);
> >>>  
> >>> @@ -154,8 +154,8 @@ panfrost_gem_mapping_get(struct panfrost_gem_object *bo,
> >>>  void panfrost_gem_mapping_put(struct panfrost_gem_mapping *mapping);
> >>>  void panfrost_gem_teardown_mappings_locked(struct panfrost_gem_object *bo);
> >>>  
> >>> -int panfrost_gem_shrinker_init(struct drm_device *dev);
> >>> -void panfrost_gem_shrinker_cleanup(struct drm_device *dev);
> >>> +int panfrost_gem_shrinker_init(struct panfrost_device *pfdev);
> >>> +void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev);
> >>>  
> >>>  void panfrost_gem_set_label(struct drm_gem_object *obj, const char *label);
> >>>  int panfrost_gem_sync(struct drm_gem_object *obj, u32 type,
> >>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> >>> index 2fe967a90bcb..fefae87535d6 100644
> >>> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> >>> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> >>> @@ -95,10 +95,8 @@ panfrost_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
> >>>   *
> >>>   * This function registers and sets up the panfrost shrinker.
> >>>   */
> >>> -int panfrost_gem_shrinker_init(struct drm_device *dev)
> >>> +int panfrost_gem_shrinker_init(struct panfrost_device *pfdev)
> >>>  {
> >>> -	struct panfrost_device *pfdev = to_panfrost_device(dev);
> >>> -
> >>>  	pfdev->shrinker = shrinker_alloc(0, "drm-panfrost");
> >>>  	if (!pfdev->shrinker)
> >>>  		return -ENOMEM;
> >>> @@ -118,10 +116,8 @@ int panfrost_gem_shrinker_init(struct drm_device *dev)
> >>>   *
> >>>   * This function unregisters the panfrost shrinker.
> >>>   */
> >>> -void panfrost_gem_shrinker_cleanup(struct drm_device *dev)
> >>> +void panfrost_gem_shrinker_fini(struct panfrost_device *pfdev)
> >>>  {
> >>> -	struct panfrost_device *pfdev = to_panfrost_device(dev);
> >>> -
> >>>  	if (pfdev->shrinker)
> >>>  		shrinker_free(pfdev->shrinker);
> >>>  }
> >>>
> > 
> > Adrian Larumbe
