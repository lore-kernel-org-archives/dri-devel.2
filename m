Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1273FC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4268110F299;
	Wed,  2 Sep 2026 15:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="CaVVrtb4";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9452810F299
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788363780; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mhY+Byip9E6ub3/2RISN6a4JsxdL5kXw3uZ5IwjI+I89U849LZE4onJNwi5fTGOXhdeDf4dyi+UXN3qxWGRKJ09vCoP/tRrCdaD1YQuvJXzuymZ+/Kq7+V1XvPqAVZohhAa9WgN4snPRc37qr6Yglr7n5VoosLse5BWcC/z/ORI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788363780;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wPkVNY6HgR4EPSBYmFwbo6fY/dHsnL8uz2ZRlRYszDA=; 
 b=jOU9DL6W4rN13Ip0B2h84iIbs+z9GVrL/X5GY60L5v/RCpUj8JsuF2qOgXVj25gBvoMxYkoICIQ4eBhHokG5/fcsyD7GobdJu3xuaZWmjNcNqzAXqLK4mP/fnfOMpal1/x6Sz8Edu8syBC2l3vl0+7QQii0tWQ8F/ACjHC4w0gc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788363780; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=wPkVNY6HgR4EPSBYmFwbo6fY/dHsnL8uz2ZRlRYszDA=;
 b=CaVVrtb4VS8WYT0rxLcoar38w1ysf+FSD30rorVya3zOZhQxXo51CuN1mOI4MPJc
 i74o08aBsjAMc/FkIpO/ca9E72YuVHH/yFIPdT38SYjsTTKpemr9uxoxDVtloOlRKzD
 zWbBprs/Yq1YwqUEG1vukBAq3nvJTQe0CbKM2o5I=
Received: by mx.zohomail.com with SMTPS id 1788363778748606.1071272860789;
 Wed, 2 Sep 2026 08:42:58 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:42:53 +0100
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
Subject: Re: [PATCH v7 11/17] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
Message-ID: <aphD4_tNK6w9yc9j@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-11-72a13b2c125d@collabora.com>
 <20260901152726.280f57e0@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901152726.280f57e0@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.352.18
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

On 01.09.2026 15:27, Boris Brezillon wrote:
> On Fri, 28 Aug 2026 21:56:51 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > This will be of great help when testing potential races between the GPU
> > reset sequence and other parts of the code accessing HW registers.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 35 ++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index d8acae9b8cfa..b6a48ae0d3a6 100644
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
> > @@ -600,9 +601,43 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
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
> > +
> > +	if (pm_runtime_get_if_in_use(pfdev->base.dev)) {
> 
> Are you sure it's not pm_runtime_get_if_active() we want here? If use
> the _if_in_use() variant and autosuspend is enabled, we might skip a
> reset on a device that's active.

Do you mean if a driver has brought the RPM count down to 0 and scheduled a deferred suspend?
Couldn't manually triggering a reset then somehow race with whatever is being done in
panfrost_device_runtime_suspend() ?

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
> > +static void panfrost_reset_debugfs_init(struct drm_minor *minor)
> > +{
> > +	debugfs_create_file("reset", 0600, minor->debugfs_root,
> > +			    minor->dev, &panfrost_reset_debugfs_fops);
> > +}
> > +
> >  void panfrost_device_debugfs_init(struct drm_minor *minor)
> >  {
> >  	panfrost_gems_debugfs_init(minor);
> >  	panfrost_sched_debugfs_init(minor);
> > +	panfrost_reset_debugfs_init(minor);
> >  }
> >  #endif // CONFIG_DEBUG_FS
> > 

Adrian Larumbe
