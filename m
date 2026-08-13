Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCFEC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610EA10E032;
	Thu, 13 Aug 2026 12:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="lW4qlzUD";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81B610E032
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786624916; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ggYl6+Q0supk3LZfWGJkWDcjecxruqcCXpkhCzNdKwAOon9216Cm8oPyfRtJpKCZ6EIN5C6tPy6u42TyepaTlOPRStpyZT1QuqGCupo0xljCpPX5ohs0Q3fuwKiKCtxCou7jnFQUxddvEAjx5ApNzmk7ZCMtLWwKExzQOUXHcuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786624916;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0ZTw48cMy64A4QAlrr5yU1lyKa2QUpTY+QtQ+gnk0iU=; 
 b=kb98MZjGHAEm0Bc5ncR0InqNBcdt8OWj2Fb6cbPVmRdSSxbZ18MNJS74C53Xp8TpvGYt/2SYLkxd1KNaU1tF3ELuJiNBU+Bu1vct0czC9BlDE2g75shH89rv20odndYeiwP5iMnFIAJ1xo5D7TBPHjCybDMVpmk0BMSGB5e7doc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786624915; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=0ZTw48cMy64A4QAlrr5yU1lyKa2QUpTY+QtQ+gnk0iU=;
 b=lW4qlzUDgPjCDF9NJKZn79QuwWf1Th5yBiQWtrQTtQLFtiTBX/cJa3SFzjxG8aZY
 +Jmey6bj9eS5EX0oWEzRVJbI8K/5AlkcNl1UvpRwp5j1kt/8wwTVK3GgelXjfxB3ejX
 4GxUduCHkRRrifdFlWbU0y+9VhKOdJ8wPQ1SrgLQ=
Received: by mx.zohomail.com with SMTPS id 1786624913536637.0416285389443;
 Thu, 13 Aug 2026 05:41:53 -0700 (PDT)
Date: Thu, 13 Aug 2026 13:41:48 +0100
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
Subject: Re: [PATCH v5 06/11] drm/panfrost: Explicitly enable MMU interrupts
 at device init
Message-ID: <an2465_kVWU7RXYY@sobremesa>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-6-3d692c9e98c2@collabora.com>
 <20260812111453.330dd57a@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812111453.330dd57a@fedora-21.home>
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

On 12.08.2026 11:14, Boris Brezillon wrote:
> On Tue, 11 Aug 2026 22:42:15 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Because the device must be in a position to accept jobs between the time
> > drm_dev_register() is called and autosuspend first kicks in, there's a very
> > narrow window inbetween during which jobs targeting the tiler buffer
> > object would time out, since the device's PM status is 'Active', but no MMU
> > interrupts were enabled at device initialisation time.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> It's probably good to have the IRQ regs initialized in the init()
> function, though I'd like to be sure this is enough. If we assume
> that a reset is what it takes to have a functional device, shouldn't we
> do this reset in the device_init() path, before drm_dev_register() is
> called?

Do you mean doing it right before returning from panfrost_device_init()?
I thought about this, that maybe all device interrupts (gpu, mmu, jm) should be
enabled only when all the other subsystems are initialised, perhaps in a sort of
panfrost_device_init_initerrupts() function at the very end of panfrost_device_init().

Some of the pre-existing issues detected by Sashiko were about potential nasty interactions
of the IRQ handler when triggered by a spurious interrupt at the time some of the driver
structures aren't fully initialised, so this might be good. What do you think?

> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > index 3fe37dd12360..a8ce5d65825c 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > @@ -336,6 +336,12 @@ void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu
> >  	WARN_ON(atomic_read(&mmu->as_count) < 0);
> >  }
> >  
> > +static void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
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
> > 

