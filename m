Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45764CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69B110E28E;
	Tue, 16 Jun 2026 19:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="TOTSunRI";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E05A10E28E
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 19:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781637367; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oD9wBVABTZ06Y9SqLS6//PKJ6HV0Uy0WaPmnugAW07TLRSElvLh8PpkEVxo69uwGPyxmVyfHSQQ9zUxhfOzLKz4HOfBWEENGIKgCO47KiyahbP85JWlDhwN4VxEVsI9eGRAsmEHA94kY/2ttjek0wIjcrMH+IFT0qw64I9Is+co=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781637367;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CmM3J7PF5BDdEv47qpyAkCJjv+suDMnpgC8mIrWCUtw=; 
 b=KoAbmNO4fZCOJDZOJ0tJLZYkghiXZr8fqpXt0h06gOe4wD6mHLM6a5S8nMlkZiBNug0i5/Vh6AWwI3qvbFWdMpbp1EszkGUH5n3FbHKlcX+v/nTM1Cfuxmg9B3JIGJtaIyaSK0jtiQa01KowjpaeddoKTBm4jD2U3kGRUVQOgCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781637367; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=CmM3J7PF5BDdEv47qpyAkCJjv+suDMnpgC8mIrWCUtw=;
 b=TOTSunRIQL3Y3vL8SlutSjEMcGxQTMJx2m7Hljb8xF9LWyLAV2FBeIVs2veuaPwd
 +dDzc1r4D+tLKaMyzMmnJGJmSbYaoQWzBg5AY9QujGyPBYokeM7d7BnaGEcnKFn9plv
 41O7BX2AH6smH0HOeUyToOG9by6O2ioUcXk6C1tY=
Received: by mx.zohomail.com with SMTPS id 1781637364886659.9998836413525;
 Tue, 16 Jun 2026 12:16:04 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:15:59 +0100
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
Subject: Re: [PATCH v2 7/7] drm/panfrost: Explicitly enable MMU interrupts at
 device init
Message-ID: <ajGg4WGT0YVmPz0B@sobremesa>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-7-57c6bd4c1655@collabora.com>
 <20260605085657.1c56998e@fedora-2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605085657.1c56998e@fedora-2.home>
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

On 05.06.2026 08:56, Boris Brezillon wrote:
> On Thu, 04 Jun 2026 18:35:26 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Because the device must be in a position to accept jobs between the time
> > drm_dev_register() is called and autosuspend first kicks in, there's a very
> > narrow window inbetween during which jobs targeting the tiler buffer
> > object would time out, since the device's PM status is 'Active', but no MMU
> > interrupts were enabled at device initialisation time.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 +++++++++--
> >  drivers/gpu/drm/panfrost/panfrost_mmu.h |  2 ++
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > index 4a3162c3b659..0e1ad6256c2c 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > @@ -336,6 +336,12 @@ void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu
> >  	WARN_ON(atomic_read(&mmu->as_count) < 0);
> >  }
> >  
> > +void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
> > +{
> > +	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
> > +	mmu_write(pfdev, MMU_INT_MASK, ~0);
> > +}
> > +
> >  void panfrost_mmu_reset(struct panfrost_device *pfdev)
> >  {
> >  	struct panfrost_mmu *mmu, *mmu_tmp;
> > @@ -355,8 +361,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
> >  
> >  	spin_unlock(&pfdev->as_lock);
> >  
> > -	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
> > -	mmu_write(pfdev, MMU_INT_MASK, ~0);
> > +	panfrost_mmu_enable_interrupts(pfdev);
> >  }
> >  
> >  static size_t get_pgsize(u64 addr, size_t size, size_t *count)
> > @@ -970,6 +975,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
> >  		return err;
> >  	}
> >  
> > +	panfrost_mmu_enable_interrupts(pfdev);
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> > index 27c3c65ed074..3140eb4fea0f 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> > @@ -12,6 +12,8 @@ struct panfrost_mmu;
> >  int panfrost_mmu_map(struct panfrost_gem_mapping *mapping);
> >  void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping);
> >  
> > +void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev);
> 
> You don't need to expose this function, it's only used inside
> panfrost_mmu.c.

Will remove in the next revision.

> > +
> >  int panfrost_mmu_init(struct panfrost_device *pfdev);
> >  void panfrost_mmu_fini(struct panfrost_device *pfdev);
> >  void panfrost_mmu_reset(struct panfrost_device *pfdev);
> > 

Adrian Larumbe
