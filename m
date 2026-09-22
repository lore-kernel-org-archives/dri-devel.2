Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DFCC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218FD10EE40;
	Tue, 22 Sep 2026 19:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="W4wB5KM4";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0A910EE40
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790106857; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bRlVRgLElU4LD+KV/AQMFcs6jqQrJTa2VzH20wPRSqdobAbXx7wmu4y1hXXEEglS2AoWLXRrbjcMJvMld9N6Z24k2tzUl6WRxPXhiEcWJ4oNggFDIPap84yFsuwcB7ePzX/TBBr9fmr01ELmRuB86EM6ZU3FWlFW4yJeJNCJbI8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790106857;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xA2gQHz1BoPItfLD4XYfLhH14+q7ZvnIkpUMcxp9UW0=; 
 b=nzdD8tkbuIX2HePbMRQXux3rOqUXkPXNRMpMLQKKcuuCdgpedXWk88mTew1VEbrM33VZdw0MVVTPE3TJx5ldoXoPyzDl1nL+FH9q+UBYr06GZT/+9vSjGDLn0pPa1Eex3xPWy870noIN5iF+at33IDACi0YExoCWfoqpC1PbfxU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790106857; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=xA2gQHz1BoPItfLD4XYfLhH14+q7ZvnIkpUMcxp9UW0=;
 b=W4wB5KM4FYFOXzkGCgrfuSAI5ULYmkb8D0ArKmZBayT0p+GEU3iDXyUAsaXZ+3PN
 RTPWav6UqWTO6vlPYvLpjpHkub4k1ODaKI+EQ9UuDWkpzgZNhwP2XEQNIZvRSiq9nCF
 SvKXmGdwJEpwPmI2BYTfMUExHJeoPSsg+uYbs0h4=
Received: by smtp.zohomail.com with SMTPS id 1790106856657676.256698215347;
 Tue, 22 Sep 2026 12:54:16 -0700 (PDT)
Date: Tue, 22 Sep 2026 20:54:11 +0100
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
Subject: Re: [PATCH v9 10/16] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
Message-ID: <arGKAk8ZWGOGDWEY@sobremesa>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-10-e588feaa61ef@collabora.com>
 <20260914113946.69936104@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914113946.69936104@fedora-21.home>
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

On 14.09.2026 11:39, Boris Brezillon wrote:
> On Sat, 12 Sep 2026 00:28:11 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > This will be of great help when testing potential races between the GPU
> > reset sequence and other parts of the code accessing HW registers.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> One comment below.
> 
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index d75566a45392..0aee1d87a7ab 100644
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
> > @@ -583,9 +584,45 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
> >  };
> >  
> >  #ifdef CONFIG_DEBUG_FS
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
> > +	int ret = pm_runtime_get_if_active(pfdev->base.dev);
> > +
> > +	if (ret) {
> > +		panfrost_device_schedule_reset(pfdev);
> 
> It feels weird to schedule a reset if the device is suspended, because
> a suspend/resume cycle already acts as a reset. Any particular reason
> you'd want to do that? If not, I'd suggest going for:

That's been my goal all along, for the knob to trigger a reset only when
the device isn't suspended. pm_runtime_get_if_active() docs states that:

"""
Increment the runtime PM usage counter of @dev if its runtime PM status is
%RPM_ACTIVE, in which case it returns 1. If the device is in a different
state, 0 is returned. -EINVAL is returned if runtime PM is disabled for the
device, in which case also the usage_count will remain unmodified.
"""

So (ret != 0) means the device either doesn't support RPM or else it
was in the ACTIVE state. In both cases, that means the device is powered
so we can proceed with the reset. However, I only decrement the usage
counter when kernel RPM is enabled (ret > 1).

> 	if (ret <= 0)
> 		return ret;
> 
> 	panfrost_device_schedule_reset(pfdev);
> 	pm_runtime_put(pfdev->base.dev);
> 	return 0;
> 
> > +		flush_work(&pfdev->reset.work);
> > +		if (ret > 0)
> > +			pm_runtime_put(pfdev->base.dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(panfrost_reset_debugfs_fops,
> > +			 reset_get, reset_set,
> > +			 "0x%08llx\n");
> > +
> > +static void panfrost_reset_debugfs_init(struct drm_minor *minor)
> > +{
> > +	debugfs_create_file("reset", 0600, minor->debugfs_root,
> > +			    minor->dev, &panfrost_reset_debugfs_fops);
> > +}
> > +
> >  void panfrost_device_debugfs_init(struct drm_minor *minor)
> >  {
> >  	panfrost_gem_debugfs_init(minor);
> >  	panfrost_sched_debugfs_init(minor);
> > +	panfrost_reset_debugfs_init(minor);
> >  }
> >  #endif // CONFIG_DEBUG_FS
> > 

Adrian Larumbe
