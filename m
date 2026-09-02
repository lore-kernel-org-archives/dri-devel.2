Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD38C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C4C10F296;
	Wed,  2 Sep 2026 15:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="GgzBWjSj";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8AA10F296
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788363708; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KKYTpyvzXnKrdt6KvMTEbGbOo4gux76GHpJ6d6KpryVWj3IIBihg7Vet0aTQWvMZdEWeCuRNJzOckZlBQbQ0nRP7mDdraijXn08Cs1pW83IjHdW3064oFAXLsBGUv2jJjJsSYyaijwwaLTMQNwt7ja1XhRVlb3mWOLwMBtmVceg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788363708;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bL1rhEjtVjVACmuqzxzHnLDDgrtS/yEaQZfQmL0QZMU=; 
 b=RllbzE30L8NwMzcBdCXAmkwRskRdMABY+DhU67E6PLrERFhU05rEx3NcR5nvBC9OSTM4ozu+zKLQxgb73FvdebX3UQAoPAP859EF9xGb/abeU7/6WvB8qI23+e4pSdnWgHCdZr65uFfdydPRJ2qVHz44NPhOzKT3+n5a7aZw/y0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788363708; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=bL1rhEjtVjVACmuqzxzHnLDDgrtS/yEaQZfQmL0QZMU=;
 b=GgzBWjSjl2aBmgpYJvfU7VkcQM3dbPtSOP2106t2MU9Leg530c4VpjMd9xlIhaau
 bry3j6gIsVFCkkSVlH5+H+1LZ+tucHtuMJ3L+aVkIr+VXaDIztjTxqAibUl4ihg8smF
 M8DEaRyuYQI7MERTcJQtaka+b+dQh6frkZ5+/9ug=
Received: by mx.zohomail.com with SMTPS id 1788363705301608.302088977019;
 Wed, 2 Sep 2026 08:41:45 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:41:40 +0100
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
Subject: Re: [PATCH v7 08/17] drm/panfrost: Split subsystem init/reset from
 interrupt enablement
Message-ID: <aphDm1vDtk2Pei3i@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-8-72a13b2c125d@collabora.com>
 <20260901150804.75ce2f47@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901150804.75ce2f47@fedora-21.home>
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

On 01.09.2026 15:08, Boris Brezillon wrote:
> On Fri, 28 Aug 2026 21:56:48 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Because MMU interrupts are only enabled when the device is reset, it
> > happened that after DRM device registration, the very first job targeting
> > the tiler heap BO would always time out. The reason is the reset sequence
> > is only part of PM runtime resume, which is not called explicitly at driver
> > probe time, and an actual reset work item manually triggered after a HW
> > error.
> > 
> > I have attempted a somewhat drastic solution, which is completely
> > decoupling GPU/MMU/JM subsystem initialisation and reset from interrupt
> > enablement, so that we can handle IRQ toggling a bit more flexibly.
> > 
> > To this end:
> > - Ensure every subsystem with its own IRQ has an 'enable interrupts'
> > method, and that it doesn't enable them anywhere else.
> > - Force IRQ masking at MMU reset time. Up until, now, panfrost_mmu_reset()
> > was clearing the MMU IRQ suspension bit, but at no point that is set during
> > the reset sequence.
> > 
> > Then manually enable all interrupts when the device is fully initialised at
> > probe time, right before DRM device registration, or after the reset
> > sequence is complete. Also disable all interrupts at device remove time,
> > so that their IRQs can be sync'ed right before tearing the device down.
> > 
> > Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> > Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 40 ++++++++++++++++++++++--------
> >  drivers/gpu/drm/panfrost/panfrost_device.h |  3 ++-
> >  drivers/gpu/drm/panfrost/panfrost_gpu.c    | 19 ++++++++------
> >  drivers/gpu/drm/panfrost/panfrost_gpu.h    |  2 ++
> >  drivers/gpu/drm/panfrost/panfrost_job.c    |  7 +++---
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c    |  9 +++++--
> >  drivers/gpu/drm/panfrost/panfrost_mmu.h    |  2 ++
> >  7 files changed, 56 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 9e02fb5f73c8..99f7da2180f9 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -226,6 +226,27 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
> >  	return err;
> >  }
> >  
> > +void panfrost_device_enable_int(struct panfrost_device *pfdev)
> > +{
> > +	panfrost_gpu_enable_interrupts(pfdev);
> > +	panfrost_mmu_enable_interrupts(pfdev);
> > +	panfrost_jm_enable_interrupts(pfdev);
> > +}
> > +
> > +static void panfrost_device_enable_hw(struct panfrost_device *pfdev)
> > +{
> > +	panfrost_device_enable_int(pfdev);
> > +	panfrost_devfreq_resume(pfdev);
> > +}
> > +
> > +static void panfrost_device_disable_hw(struct panfrost_device *pfdev)
> > +{
> > +	panfrost_devfreq_suspend(pfdev);
> > +	panfrost_jm_suspend_irq(pfdev);
> > +	panfrost_mmu_suspend_irq(pfdev);
> > +	panfrost_gpu_suspend_irq(pfdev);
> 
> Hm, I think I'd prefer if those suspend/resume_irq() were hidden in
> some subcomponent panfrost_<subcomp>_suspend,resume() helpers. And
> then we just have to resume/suspend component in the right order
> instead of treating IRQs as a standalone object (enabling/disabling
> only makes sense if the subcomponent handling those interrupts is
> resumed/suspended).

I thought it would only make sense to enable interupts for a given subsystem
when all the other subsystems are also resumed or initialised. This was prompted
by Sashiko warning of the possibility of spurious interrupts causing a handler
to be run when one of the subsystems it touches on hasn't yet been initialised.

Adrian Larumbe
