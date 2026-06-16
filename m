Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7AACD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 22:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A2110E0B7;
	Tue, 16 Jun 2026 22:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="PfJpz6Ca";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484F410E0B7
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 22:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781649553; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ERU5qAurCzagDHqx5jfKbcQD/YZE94MX4wO+0nzT6xNJX4auMtUHQOgAxfaUXZbdtFX0B8bJI25sheH19aGy1rhKTULOSCr9At6era/Rr0wppg7+sVC40FWrDR4ZIZALOkZLiXjcT0jXWTVto/Sje/Cam1powkCI+aNc4JDZoa0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781649553;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HLW96QtYbLYk6bM6HlaRFgraAMzhxHUNpo8fqZH8yfY=; 
 b=mQX/G0rAaQlSQ2nYL7qCEAYRv/DwFIAqgxOLFNaKUMyMlICr1tMDUmCBv4qwIG8qxPbO6XjUojhYV4hIQX47V6UjcS/VWzErKj1OVhLh9zL87yp75Zn1gLyFYm8Fx4Nt8Te4Rfua1keYt4D2OGboqz/48y6NYwMYXcVS+nZLQ8I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781649553; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=HLW96QtYbLYk6bM6HlaRFgraAMzhxHUNpo8fqZH8yfY=;
 b=PfJpz6CaVAen9YhMBE+GgBicwPxqTZJMDEQzkjt2tY524T+iIQODwwIOH36i1Yv4
 2g/yxTd6lZr0MdekUA38VdILfrudAD4EyEKVtzYT0xJJgiPKHycthwYE+Pa0C6MbhF8
 K2SumwCL80OzpaZjLZeamRNsYZwMtTc9Lmp8dYQM=
Received: by mx.zohomail.com with SMTPS id 1781649551285120.31526656158815;
 Tue, 16 Jun 2026 15:39:11 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 5/7] drm/panfrost: Make reset sequence deal with an
 active HWPerf session
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
In-Reply-To: <20260604202613.4afe53f1@fedora-2.home>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-5-57c6bd4c1655@collabora.com>
 <20260604202613.4afe53f1@fedora-2.home>
Date: Tue, 16 Jun 2026 23:39:01 +0100
Message-Id: <178164954145.482538.4666042173411800435.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7951;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=rqA41nWdN6tGmcdCAB/0BPMZ1Z8PnhuA5zOcaC3UPeY=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqMdCLxsshinnZfCLYA/OP18UGg10Mv/OnGbJPP
 HmiIqvHhYOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajHQiwAKCRAOJn5M7lND
 PYucDAC5afrUI66x6uSJgrpPzEkRuvw8+l2B5runtojyYeWkBY/Oz0FZqgZDdqFp0ZQeOazXUJC
 YUwE0q8chqvFhM6VIO4j12IBRGHSItP3BEid6sKMkRZyiOMVW0I7XGC0H7kaY6BLSLNapRJXPCv
 LPdnEbC4SmvYYlseomnjUN/Tt12Qmb6SPr0Hzzv3zPPthej6BwqxOdAll+Q+pgu78ngWLwUSl+w
 F4FNEP/y+yQMpEQgac04O0/+luXYnhPURoX0RPPT+iBLtx00MzSxgGyfg3e2T75pMyujD1D8zSC
 y9iDmX/4HOhhd9hH24VNpT72p14Fnb8EhniKxmpH0l0jsUMKV5WNYc0MX2blthDAVJm5YQWQkAk
 +Wl/HIrbuKJ7dLh9+lWBJRem9Gvsx8vRoBR+HhOCrWhG/BC5DIfqI0d8Cs5W9jsjVMxVBdHFMRD
 foOT8y2UntM06lWMUnDCXRuT4J9KhCkeaRY1a+l9W0UyXMP1M0lz+HrOf5V1A8uv2AB6g=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On 2026-06-04 20:26:13+02:00, Boris Brezillon wrote:
> On Thu, 04 Jun 2026 18:35:24 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Right now, if there's a HW reset and an HWPerf session is active,
> > panfrost_mmu_reset() will reset the AS count for every single open file's
> > mmu struct back to 0, and also invalidate their AS numbers. Then, when
> > disabling hwperf, panfrost_mmu_as_put() will WARN that mmu->as_count is
> > less than zero.
> > 
> > Fix this by introducing a perfcnt HW reset path.
> > 
> > The choice was made to render perfcnt unusable after reset, so that a
> > user might have to reprogram it with a full disable/enable sequence
> > before requesting more perfcnt dumps.
> 
> Can't we do better than that. We store the config of the perf session,
> so if a reset is in progress, we can simply block on it, restore the
> old config in the post_reset path, and get going with the DUMP request
> once the reset has been done. There's certainly something to do to
> report the discontinuity to userspace, but that's something we can
> reflect through and extra field added to drm_panfrost_perfcnt_dump.

Do you mean perfcnt_dump() should wait until the reset is finished in the ioctl
itself? However it makes me wonder what we could do when the reset happens and
there's an going perfcnt_enable() ioctl, and the reset might render the initialised
state void.

> > Reported-by: Claude <noreply@anthropic.com>
> > Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c  |  1 +
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 46 ++++++++++++++++++++++++++++-
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |  1 +
> >  3 files changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 87b372c9e675..2805d50c1b9b 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -426,6 +426,7 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
> >  
> >  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
> >  {
> > +	panfrost_perfcnt_reset(pfdev);
> >  	panfrost_gpu_soft_reset(pfdev);
> >  
> >  	panfrost_gpu_power_on(pfdev);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > index ad1156678e91..c2087ea705fe 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > @@ -33,6 +33,7 @@ struct panfrost_perfcnt {
> >  	struct panfrost_file_priv *user;
> >  	struct mutex lock;
> >  	struct completion dump_comp;
> > +	atomic_t hw_reset_happened;
> >  };
> >  
> >  static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
> > @@ -57,9 +58,13 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
> >  
> >  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> >  {
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> >  	u64 gpuva;
> >  	int ret;
> >  
> > +	if (atomic_read(&perfcnt->hw_reset_happened))
> > +		return -EIO;
> > +
> >  	reinit_completion(&pfdev->perfcnt->dump_comp);
> >  	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> >  	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > @@ -140,6 +145,15 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  		goto err_vunmap;
> >  	}
> >  
> > +	/* If a reset is ongoing, the AS we get right below will be torn
> > +	 * down, so rather than waiting until this becomes obvious in a
> > +	 * perfcnt_dump() ioctl, we ask the user to try again slightly later.
> > +	 */
> > +	if (atomic_read(&pfdev->reset.pending)) {
> > +		ret = -EAGAIN;
> > +		goto err_vunmap;
> > +	}
> > +
> >  	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> >  	if (ret < 0)
> >  		goto err_vunmap;
> > @@ -173,6 +187,16 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> >  		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> >  
> > +	/* If a reset happened, we've no way of knowing whether it was between the time we called
> > +	 * panfrost_mmu_as_get() or before perfcnt_enable(), so clearing this flag and going forward
> > +	 * isn't possible. We must clear the flag and try again in the hopes no resets will happen
> > +	 * between this and the next ioctl invocation.
> > +	 */
> > +	if (atomic_cmpxchg(&perfcnt->hw_reset_happened, 1, 0)) {
> > +		ret = EAGAIN;
> > +		goto err_disable;
> > +	}
> 
> This should really be transparent to the user, apart from reporting
> that samples might have been lost because of the reset.
> 
> > +
> >  	/* The BO ref is retained by the mapping. */
> >  	drm_gem_object_put(&bo->base);
> >  
> > @@ -180,6 +204,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  
> >  	return 0;
> >  
> > +err_disable:
> > +	panfrost_perfcnt_gpu_disable(pfdev);
> >  err_vunmap:
> >  	drm_gem_vunmap(&bo->base, &map);
> >  err_put_mapping:
> > @@ -209,7 +235,8 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
> >  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
> >  	perfcnt->buf = NULL;
> >  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> > -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> > +	if (!atomic_read(&perfcnt->hw_reset_happened))
> > +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> 
> Why not call panfrost_mmu_as_put() in panfrost_perfcnt_pre_reset(),
> which is called before panfrost_mmu_reset()? If we do that, the AS
> should be returned, and we can add a panfrost_perfcnt_post_reset()
> that's called after panfrost_mmu_reset() and which re-acquires the AS
> and re-instantiate the perfcnt settings.

I was doing this revision 1, but then that could lead to races because panfrost_perfcnt_reset()
and panfrost_perfcnt_disable_locked() could call panfrost_mmu_as_put() right after another,
leaving the as_count at -1.

> >  	panfrost_gem_mapping_put(perfcnt->mapping);
> >  	perfcnt->mapping = NULL;
> >  	pm_runtime_put_autosuspend(pfdev->base.dev);
> > @@ -346,3 +373,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
> >  	/* Disable everything before leaving. */
> >  	panfrost_perfcnt_gpu_disable(pfdev);
> >  }
> > +
> > +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
> > +{
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +
> > +	/* Since this function will be called either from a scheduled HW reset
> > +	 * or a runtime resume, tearing down any perfcnt resources means we're
> > +	 * doomed to deadlocking with perfcnt_{enable/disable}, since we'd have
> > +	 * to take the perfecnt lock. On top of that, it'd also violate DMA fence
> > +	 * signalling rules because GFP_KERNEL allocations are made with the perfcnt
> > +	 * lock taken in perfcnt_enable.
> 
> Question is, do we really need these allocation to happen with the lock
> held? And if yes, can't we protect perfcnt ops with a separate reset
> lock?

I'd rather do the latter, I think Panthor is doing something like that already?

> > In light of this, the only thing we can do
> > +	 * is disabling perfcnt unconditionally, and notifying the perfcnt user of
> > +	 * the reset having happpened so that they can take recovery measures.
> 
> Informing userspace about the discontinuity is fine, but I think we
> should try to restore the config in a post_reset() hook.


