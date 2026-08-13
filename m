Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C379C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45EA910E242;
	Thu, 13 Aug 2026 12:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="LW+swV7H";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAE910E242
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786623636; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ai1WssBWk6AOOUlOa1LspB4C+wrBx1uvOBZn8q4CA7T/gvnlDv2f87+GchreBNPgY3E3SXP+ytIEBeRrc8VpCSpw04QOT3IsFspFaLdbWFq1zHORYs78Qd9PiJNE5qi4CBEXRWTyzuHrJ2Q7K/BBnjL7tZGvgf2odGxoKai5XV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786623636;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=C+e/iuB0NatsIev4wxUrNzN6oeUfYvL0lnbve/t8AT0=; 
 b=huW1exv/LB0nG2x5leaeCl4DiHNnsiGc6wwaBcQ/4ystLkmx95K3VIhsgx8RPlmRKZ468w8IdcmKhq0MSWh+62ZPcr8hFv2kYyLPvOGBYhcwn3X1u3KTgKZtbNElwU52wBIdhJTv0TD3ny9SJ27hEVwVIDJlzHwClCD5rtRQu2k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786623636; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=C+e/iuB0NatsIev4wxUrNzN6oeUfYvL0lnbve/t8AT0=;
 b=LW+swV7HPdlKfrpL6QBsndhSdCLrThhzDBkoSso/1aj8HfHiwIQEfHuRrEG0necX
 lo98Ry0qijydthKSZ4T4A3Z6Pobl7Mi9eBmYcfZbmFsIYmWT9xPzBoH7r8oI//SJvM/
 4LnElqCfmN9P5iahw+teD9A94Jv9ZlePEOMe+abA=
Received: by mx.zohomail.com with SMTPS id 1786623634820563.348431501779;
 Thu, 13 Aug 2026 05:20:34 -0700 (PDT)
Date: Thu, 13 Aug 2026 13:20:29 +0100
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
Subject: Re: [PATCH v5 07/11] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
Message-ID: <an215ifaeM2C4gvL@sobremesa>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-7-3d692c9e98c2@collabora.com>
 <20260812111751.285b5080@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812111751.285b5080@fedora-21.home>
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

On 12.08.2026 11:17, Boris Brezillon wrote:
> On Tue, 11 Aug 2026 22:42:16 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > This will be of great help when testing potential races between the GPU
> > reset sequence and other parts of the code accessing HW registers.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 39 ++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/panfrost/panfrost_device.h |  3 +++
> >  drivers/gpu/drm/panfrost/panfrost_drv.c    |  1 +
> >  3 files changed, 43 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 52f4b8c6a05f..5b66173c75b9 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
> >  /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
> >  
> > +#include <linux/debugfs.h>
> >  #include <linux/clk.h>
> >  #include <linux/reset.h>
> >  #include <linux/platform_device.h>
> > @@ -608,3 +609,41 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
> >  	if (enable_job_int)
> >  		panfrost_jm_enable_interrupts(pfdev);
> >  }
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static int reset_get(void *data, u64 *val)
> > +{
> > +	struct panfrost_device *pfdev =
> > +		container_of(data, struct panfrost_device, base);
> > +
> > +	*val = atomic_read(&pfdev->reset.pending);
> > +	return 0;
> > +}
> > +
> > +static int reset_set(void *data, u64 val)
> > +{
> > +	struct panfrost_device *pfdev =
> > +		container_of(data, struct panfrost_device, base);
> > +	int ret;
> > +
> > +	ret = pm_runtime_get_if_in_use(pfdev->base.dev);
> > +
> > +	if (ret > 0) {
> > +		panfrost_device_schedule_reset(pfdev);
> > +		flush_work(&pfdev->reset.work);
> > +		pm_runtime_put(pfdev->base.dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(panfrost_reset_debugfs_fops,
> > +			 reset_get, reset_set,
> > +			 "0x%08llx\n");
> > +
> > +void panfrost_reset_debugfs_init(struct drm_minor *minor)
> > +{
> > +	debugfs_create_file("reset", 0600, minor->debugfs_root,
> > +			    minor->dev, &panfrost_reset_debugfs_fops);
> > +}
> > +#endif // CONFIG_DEBUG_FS
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> > index 0fd33bc5b86f..4bbaaaf827a5 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -350,4 +350,7 @@ panfrost_device_started(struct panfrost_device *pfdev)
> >  	return pfdev->js;
> >  }
> >  
> > +#ifdef CONFIG_DEBUG_FS
> > +void panfrost_reset_debugfs_init(struct drm_minor *minor);
> > +#endif // CONFIG_DEBUG_FS
> >  #endif
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 8410de95e364..958f1d36ab10 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -916,6 +916,7 @@ static void panfrost_debugfs_init(struct drm_minor *minor)
> >  {
> >  	panthor_gems_debugfs_init(minor);
> >  	panfrost_sched_debugfs_init(minor);
> > +	panfrost_reset_debugfs_init(minor);
> 
> Nit: I'd probably go for panfrost_device_debugfs_init(), and since gems
> and sched are sub-components of the device, I'd call the other
> panfrost_{gems,sched}_debugfs_init() helpers from
> panfrost_device_debugfs_init().

Acked, will do for the next iteration. Also, I noticed there's quite a bit of debugfs stuff
in panfrost_drv.c. I should probably move it all under the relevant subsystem file and make
the debugfs init functions available to panfrost_drv.c

> >  }
> >  #endif
> >  
> > 
