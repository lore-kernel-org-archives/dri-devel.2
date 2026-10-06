Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C96CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 14:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B6810E364;
	Tue,  6 Oct 2026 14:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="M6ms3DmM";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600A710E364
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 14:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791296111; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HUbNVJbEBp0y+bxIDuw8VT2YQ/f8yAe5tk6lDceeDDsw80g6VzmXjU/iD3aAworHDj/6fIHPhGePRwss2MrHlk4XXJEkutpBwjpywQAmxhEfY9U1cDOGVt+pkIXa42JLlNquS10Qi6g5dCU4hnqJaRDdlEG6VTM5low8InVAQo0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791296111;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=y3JiIy2jN3Vycl9ULpVc1NJ3a6PBiybwHdYHJMNwg30=; 
 b=EuefOzcCmMB9kRbr0/H591C9NNEIw40W2txH7ZtsCDFhXfXoxsFqptHDdjp6S+EbNPIHccGTD0XPfh4UDRBnx08Kvt72sLEy+0pN8yf6yu5uZy53uNjHo65StyqLlQG8U2bOLAM38oEXDA3wvuhmkXigWVAC44kVVstEpcvhLKo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791296111; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=y3JiIy2jN3Vycl9ULpVc1NJ3a6PBiybwHdYHJMNwg30=;
 b=M6ms3DmMsHVW2TyuVh0D2J1TQ7pjaNsdYsI+jL0H4oe1vgangv7J2iZrC956zNVO
 7MfrxCb1Vg08Shg+ID1kV2OdUfbce4YlrezXBBqwdFuWTELVyldmFkZ107dP+V1xjqB
 U3vRBv19ZjmIPv2Nw6hE07EFMYZnD1VCUP2fvMCY=
Received: by smtp.zohomail.com with SMTPS id 1791296110932273.82012697157575; 
 Tue, 6 Oct 2026 07:15:10 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <b9992315-be8f-4d58-91ea-cc6a8c1e3213@arm.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-15-62beb08de207@collabora.com>
 <b9992315-be8f-4d58-91ea-cc6a8c1e3213@arm.com>
Date: Tue, 06 Oct 2026 15:14:59 +0100
Message-Id: <179129609942.1018806.16482741317481449092.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10840;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=nQ6uvDAJ3TgsjESSYhGqxuJAUhE8rh6rSP4N9dfbl7g=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxQJjO/kRU/V2PpRPML2q2Sp4LUD5hg77GBeJi
 Xxp8dD5CGyJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasUCYwAKCRAOJn5M7lND
 PdxhDAC0LHaZcMwh09L03vD9k3oHJy3anXalp43I9aiUGIHGQmE7BM/d2NXOvNOm4a1V9UUu91B
 x1qaIltBSye4IY2k759gm7undDdjOHSxWHWKskuK4HPfihazOokcX1dIpCe0EMj0WIr1f5TJQPZ
 jtTlHA6zwE3sZduGSoSA+jdWQC7kEhjIndAWG18PUh/rU5kbzRQ6KI5hT3vNRETv1F12NMApfcM
 SmzglzuTgx0u1LhJGOUzp7u4n3wsIBLOpnuu55TM0RiQJLqUiLteWmY4RHTYbRwpzBfaJyr2WKv
 B2YUCwflPjcF61UXIdi+MyScggfnP6SMeIblo2XDT9zR3tAxLIq3bsehu/j9DYLKMPGiYHkjRlY
 VHJR/xCmEsYVOOUtFWRcfeTgkprhiboPco33Pw1/s37vaWcXnk4NSd6kEehAqaED19a+MXeHpoa
 KIctq4c1fzPrjeafcjoFIWvrqUsqHM4PbBM6HXf2a9vzfyNAyhVXxibcHS/0ZOjRBige8=
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

On 2026-10-02 16:44:59+01:00, Steven Price wrote:
> On 29/09/2026 04:44, Adrián Larumbe wrote:
> 
> > Formerly, the reset sequence would race with panfrost_mmu_as_put()
> > when tearing down a perfcnt session. On top of that, poking GPU
> > registers to program a perfcnt session or obtaining a dump might lead to
> > undefined behaviour when done at the same time a reset was ongoing.
> > 
> > Use the reset r/w semaphore when disabling and re-enabling perfcnt
> > configuration, and also in the sections inside the 'enable'and 'dump'
> > ioctls where device registers are being accessed.
> > 
> > On top of that, expand the DRM uAPI for the perfcnt DUMP operation
> > so that user space can be made aware of a reset having happened,
> > whether it succeeded or failed to restore the original configuration.
> > UM needs to know about this condition because counter data is inaccurate
> > after a reset, so the best approach might be simply to try again.
> > 
> > Finally, update driver uAPI documentation to explain the meaning of the
> > new perfcnt dump ioctl's state flags, and bump DRM driver minor number
> > to reflect the new DUMP IOCTL req field.
> > 
> > Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> > Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c  |   2 +
> >  drivers/gpu/drm/panfrost/panfrost_drv.c     |   3 +-
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 272 +++++++++++++++++++---------
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
> >  include/uapi/drm/panfrost_drm.h             |  29 ++-
> >  5 files changed, 222 insertions(+), 85 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 80d8f6aed090..47a869232e10 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -491,6 +491,8 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
> >  	panfrost_jm_reset_interrupts(pfdev);
> >  	if (enable_job_int)
> >  		panfrost_jm_enable_interrupts(pfdev);
> > +
> > +	panfrost_perfcnt_reset(pfdev);
> >  }
> >  
> >  static int panfrost_device_runtime_resume(struct device *dev)
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 571a26b84126..de9b1c115181 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
> >   * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
> >   *	   PANFROST_IOCTL_QUERY_BO_INFO and
> >   *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
> > + * - 1.7 - adds PERFCNT_DUMP req state field
> >   */
> >  static const struct drm_driver panfrost_drm_driver = {
> >  	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
> > @@ -820,7 +821,7 @@ static const struct drm_driver panfrost_drm_driver = {
> >  	.name			= "panfrost",
> >  	.desc			= "panfrost DRM",
> >  	.major			= 1,
> > -	.minor			= 6,
> > +	.minor			= 7,
> >  
> >  	.gem_create_object	= panfrost_gem_create_object,
> >  	.gem_prime_import	= panfrost_gem_prime_import,
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > index b3f71d7fd82a..13521e078ce7 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright 2019 Collabora Ltd */
> >  
> > +#include "asm-generic/errno-base.h"
> >  #include <linux/completion.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/iosys-map.h>
> > @@ -11,6 +12,7 @@
> >  #include <drm/drm_file.h>
> >  #include <drm/drm_gem_shmem_helper.h>
> >  #include <drm/panfrost_drm.h>
> > +#include <drm/drm_print.h>
> >  
> >  #include "panfrost_device.h"
> >  #include "panfrost_features.h"
> > @@ -28,21 +30,31 @@
> >  
> >  struct panfrost_perfcnt {
> >  	struct panfrost_gem_mapping *mapping;
> > +	unsigned int counterset;
> >  	size_t bosize;
> >  	void *buf;
> >  	struct panfrost_file_priv *user;
> >  	struct mutex lock;
> >  	struct completion dump_comp;
> > +	u32 state;
> > +	bool owns_as_ref;
> >  };
> >  
> >  static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
> >  {
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +
> >  	gpu_write(pfdev, GPU_PERFCNT_CFG,
> >  		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> >  	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> >  	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> >  	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> >  	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > +
> > +	if (perfcnt->owns_as_ref) {
> > +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> > +		perfcnt->owns_as_ref = false;
> > +	}
> >  }
> >  
> >  void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
> > @@ -58,43 +70,161 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
> >  		complete(&pfdev->perfcnt->dump_comp);
> >  }
> >  
> > -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> > +static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
> > +{
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +	u32 cfg, as;
> > +	int ret;
> > +
> > +	lockdep_assert_held(&pfdev->reset.lock);
> > +	drm_WARN_ON(&pfdev->base, perfcnt->owns_as_ref);
> > +
> > +	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	perfcnt->owns_as_ref = true;
> > +
> > +	as = ret;
> > +	cfg = GPU_PERFCNT_CFG_AS(as) |
> > +	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
> > +
> > +	/*
> > +	 * Bifrost GPUs have 2 set of counters, but we're only interested by
> > +	 * the first one for now.
> > +	 */
> > +	if (panfrost_model_is_bifrost(pfdev))
> > +		cfg |= GPU_PERFCNT_CFG_SETSEL(perfcnt->counterset);
> > +
> > +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
> > +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
> > +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
> > +
> > +	/*
> > +	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
> > +	 * counters.
> > +	 */
> > +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > +	else
> > +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > +
> > +	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> > +
> > +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > +
> > +	return 0;
> > +}
> > +
> > +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u32 *state)
> >  {
> > -	u64 gpuva;
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +	u64 gpuva = perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> >  	int ret;
> >  
> > -	reinit_completion(&pfdev->perfcnt->dump_comp);
> > -	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > -	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > -	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> > -	gpu_write(pfdev, GPU_INT_CLEAR,
> > -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		*state = perfcnt->state;
> > +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> > +			return -EIO;
> > +
> > +		perfcnt->state = 0;
> > +
> > +		reinit_completion(&pfdev->perfcnt->dump_comp);
> > +
> > +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> > +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> > +	}
> > +
> > +	/*
> > +	 * Here we release the reset semaphore because perfcnt should not get in the way
> > +	 * of a HW reset. Besides, a legitimate reset might be issued during the wait.
> > +	 */
> >  	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
> >  							msecs_to_jiffies(1000));
> > +
> > +	/* A reset might come through in the gap between the completion returning and the following
> > +	 * check, but because no sample was produced, we don't care to relay the state back to UM.
> > +	 */
> >  	if (!ret)
> > -		ret = -ETIMEDOUT;
> > -	else if (ret > 0)
> > +		return -ETIMEDOUT;
> > +
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		*state |= perfcnt->state;
> > +
> > +		/* UM must re-enable their session before requesting new dumps. */
> > +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> > +			return -EIO;
> > +
> > +		/* If we faced a reset during our SAMPLE, the user needs to try again. */
> > +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET)
> > +			return -EAGAIN;
> > +
> > +		/* Only when we know no re-eanble or re-dump is required, we can afford
> 
> Typo: s/re-eanble/re-enable/
> 
> > +		 * to reset the internal state. Otherwise it must be kept so that later
> > +		 * ioctls know about error situations in this DUMP and work around it.
> > +		 */
> > +		perfcnt->state = 0;
> 
> Am I missing something or does the above comment say we only get here
> when perfcnt->state is already 0? If either
> PANFROST_PERFCNT_SESSION_DEAD or
> PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET is set then we return
> early. So unless there's some other flag we can't get to this line
> unless it's already 0...

You're right, this is pretty much a NOP. This was me trying to fix an issue
with a previous revision in a way that only added cruft.
Doing nothing after checks for both flags would be the right thing:
 - If PANFROST_PERFCNT_SESSION_DEAD is set, then we need to go through
   the enable ioctl() so that the state variable will be reset and
   perfcnt configuration reestablished.
 - If PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET is set, then another dump
   should be attempted, and when getting back to the beginning of this function,
   state will be again reset. By then, UM should've taken note of a reset having
   happened, so there's no trouble in resetting it after a new dump.

> It's Friday afternoon so I might well be missing something - perhaps it
> will all make sense next week?
> 
> Thanks,
> Steve


