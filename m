Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FB3C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A066510E053;
	Thu, 13 Aug 2026 12:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="LpoSZRkQ";
	dkim-atps=neutral
X-Greylist: delayed 140902 seconds by postgrey-1.36 at gabe;
 Thu, 13 Aug 2026 12:51:01 UTC
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C16710E286
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786625452; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bE51dzvh6sdjUyoaQ+d00UqW4ln5Qfg1UGt2AfIMu+5dpexFIxYCnxbnLdEVh7I3p6XicTfqKUP/jgjqyU3DzHsTeG6Sf9nF/HHLmK+Ll0J3cA+Vu5rAl8ojr9Bk6vanrLRoLlyZMX7ppYK7DKMKP0VrxYoqXUHZD6W/P8a/Jh0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786625452;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ERHd4uYlx40Bignb8TDOpB+QKlzsKWdH22Ia1hSOx+I=; 
 b=H+2BJ7nwRYgNIE2mr2iEqsGVOXd6uuqKpUfDA1sp+rOTx325pru3DhRbpZ1D7onG0NMY7go7Yn3aHo+6cjHv7KSJGGEEv8PFJWt7upEESzWFZ6adm/ZvZ6WoQsrg4SN/8e1x5GGJBNl+MalKkAuPR3ZcAvO96y3dvkeL6kQ4yLg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786625452; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=ERHd4uYlx40Bignb8TDOpB+QKlzsKWdH22Ia1hSOx+I=;
 b=LpoSZRkQrMmZj4FqZNhsnzizeRKoWM+/pEA0tgAh+duW0aNM6sxVfN+G83kP+3GU
 WYKdVTXtVuNxxVdKdqKlRyh0aJ989VsYfxS7lYoIe1I7VcFCJDS96SD5iPH5UWdQgRQ
 1fpJfqYbw7ryKuorVGVul3XLyVcCC5D5TOYxzP7A=
Received: by mx.zohomail.com with SMTPS id 1786625450234573.1393337968727;
 Thu, 13 Aug 2026 05:50:50 -0700 (PDT)
Date: Thu, 13 Aug 2026 13:50:45 +0100
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
Subject: Re: [PATCH v5 09/11] drm/panfrost: Introduce a reset lock
Message-ID: <an29irJv7zbcNx6N@sobremesa>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-9-3d692c9e98c2@collabora.com>
 <20260812114543.17e5c10d@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812114543.17e5c10d@fedora-21.home>
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

On 12.08.2026 11:45, Boris Brezillon wrote:
> On Tue, 11 Aug 2026 22:42:18 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > So as to avoid accessing HW register while a reset is ongoing, a read/write
> > semaphore that envelopes the reset sequence will help driver entry points
> > avoid racing with it. For now, the only such racy entry point is the ioctl
> > that returns the current GPU timestmap.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 2 ++
> >  drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
> >  drivers/gpu/drm/panfrost/panfrost_drv.c    | 9 ++++++---
> >  drivers/gpu/drm/panfrost/panfrost_job.c    | 1 +
> >  4 files changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 5b66173c75b9..e0390b6c0d22 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -602,6 +602,8 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
> >  
> >  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
> >  {
> > +	guard(rwsem_read)(&pfdev->reset.lock);
> 
> Oops, s/rwsem_read/rwsem_write/. This is actually fixed in the next
> patch.

Sorry about this, I seemed to have botched the final interactive rebase.

> > +
> >  	panfrost_gpu_soft_reset(pfdev);
> >  	panfrost_gpu_power_on(pfdev);
> >  	panfrost_mmu_reset(pfdev);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> > index 4bbaaaf827a5..a2a68e042225 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -166,6 +166,7 @@ struct panfrost_device {
> >  	struct {
> >  		struct workqueue_struct *wq;
> >  		struct work_struct work;
> > +		struct rw_semaphore lock;
> >  		atomic_t pending;
> >  	} reset;
> >  
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 958f1d36ab10..ff23b1a979bb 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -41,9 +41,12 @@ static int panfrost_ioctl_query_timestamp(struct panfrost_device *pfdev,
> >  	if (ret)
> >  		return ret;
> >  
> > -	panfrost_cycle_counter_get(pfdev);
> > -	*arg = panfrost_timestamp_read(pfdev);
> > -	panfrost_cycle_counter_put(pfdev);
> > +	/* We should not read timestamp register while the GPU  is being reset */
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		panfrost_cycle_counter_get(pfdev);
> > +		*arg = panfrost_timestamp_read(pfdev);
> > +		panfrost_cycle_counter_put(pfdev);
> > +	}
> >  
> >  	pm_runtime_put(pfdev->base.dev);
> >  	return 0;
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> > index c761379851da..9d7dafa29f19 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> > @@ -874,6 +874,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
> >  
> >  	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
> >  	spin_lock_init(&js->job_lock);
> > +	init_rwsem(&pfdev->reset.lock);
> >  
> >  	js->irq = platform_get_irq_byname(to_platform_device(pfdev->base.dev), "job");
> >  	if (js->irq < 0)
> > 

Adrian Larumbe
