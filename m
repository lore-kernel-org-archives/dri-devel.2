Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3DFCD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 272D510EB84;
	Tue, 16 Jun 2026 21:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="JBpUEqdp";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F68510EB84
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 21:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781646637; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lLRtcahlZ1Jn+2W0Y7wyQA/2FUccc7ZM9I8C80aRudZlntHoVTwMDqraUuzmgutSXKdvPSxLO3OWAwB5XfZYUJhDdcutI7QlKgVa4aXNTPcoxkIbPlkmV8clgCaBD4FXqimC5PmJ/0jGd/iLbJvyLBdi86gAwVqeCBKtbM2DrTk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781646637;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ORx90GUjLfrYFeumSHeW4zoduUOfs/rnXYVxNKsf8X4=; 
 b=kVOvHK0x/8uSEAWV3V5s6r90rDe/D4zaNYkHEXHoFt7Rj5DTw4TrjpTy7NMNgR4wyJN8UITbpwgAr96ghm1JWKUfBbVR+/YpJnaS2sIwRyuFa7sA6Vzg/VM3E5YPt4OW9U5vjjTfAGzIpzEZxLpe0deRRCV5fea4PIXUMv58FN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781646637; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=ORx90GUjLfrYFeumSHeW4zoduUOfs/rnXYVxNKsf8X4=;
 b=JBpUEqdpIp3Zy1FQN2YnIayb9SZvEtD6uNlZXeJ3rDo1PXZnIKLDQ4+k5ONHAmcL
 bzl5ge7dpMhnUm5oUZrWXuMa2PPFuKV/wOO7xh43MMuuqTtm54kMY5nOY0eSmVXrhKN
 jAMbZoYyZbwnBfHc8kI6z4Sckl1vK8DsXxFoCb7A=
Received: by mx.zohomail.com with SMTPS id 1781646635271384.4921958030527;
 Tue, 16 Jun 2026 14:50:35 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 5/7] drm/panfrost: Make reset sequence deal with an
 active HWPerf session
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604174918.2BC551F00893@smtp.kernel.org>
References: <20260604-claude-fixes-v2-5-57c6bd4c1655@collabora.com>
 <20260604174918.2BC551F00893@smtp.kernel.org>
Date: Tue, 16 Jun 2026 22:50:26 +0100
Message-Id: <178164662685.450479.6904294010009293249.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6897;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=c3K+UtdL4o7jemvgbuzk6Ot2hHco585tVC0nhdKFgss=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqMcUqHln40mPrNWYqcVQPQcowt3Mjoztcgbea/
 xO9AokKYtCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajHFKgAKCRAOJn5M7lND
 PZA3C/sEuXgxQZQkjkMa3A3dqrlCqSj7DMuHm5FNCBCtCDPGU9N9AtL/jNIsDEIVMqWfBZnkhYc
 jgwVQp2Gs22Vc7SmCkIJvMr1F0rvma/nsK5J2S5qVh6waq/VvOTGR1jR2CmEQbp/C1hEkM5A1O6
 5jGNotQuipZ6XHUs/U2U5llylPCJTMeablDUjCgOLw8VA2gFb6a18L2ZPjrRAhkn59a4j/wD51N
 +dFpJG5tmJAhZHyJ6i9z2EmNDh1dGv+K5lb8ymtpyDzOKbZ511mK7XsjfQyyHAXl+JqR8ooygKi
 hOwYFMp5Y828u/eXgzbymucrb20ySHwmq3zqhcDcakyYyl1ke3ElG94JaV+qfYRXPqVGs6vT4gf
 khghw826tYd2PqZXwQtXD5H43pntKubgutZxf7BJjoJUUmxpRXp5vhFUe/BTLeJ0SypMoIq9oq7
 C2g0yE8svDiwC9Z+aUWXDRBcCN9AtUcuSvMIJS6ZAd500CYapAHiaU63lQ8brsn2YhPhA=
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

On 2026-06-04 17:49:17+00:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Address Space reference (mmu->as_count) permanently leaks when hardware reset aborts perfcnt_enable_locked.
> - [High] A TOCTOU race between disable_locked and the asynchronous reset workqueue reintroduces the mmu->as_count underflow WARN.
> - [Medium] A positive error code (EAGAIN) is incorrectly returned directly to userspace instead of the negative standard (-EAGAIN).
> - [Medium] Spurious initialization failures occur for new perfcnt sessions due to a stale hw_reset_happened flag.
> --
> 
> commit 555dc068f79668462a998f3ee4fa95ead697090d
> Author: Adrián Larumbe <adrian.larumbe@collabora.com>
> 
> drm/panfrost: Make reset sequence deal with an active HWPerf session
> 
> This commit introduces a perfcnt HW reset path to handle active HWPerf
> sessions during a HW reset. It renders perfcnt unusable after reset and
> notifies the user to take recovery measures.
> 
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
> Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
> 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > index ad1156678e91c..c2087ea705fe6 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> 
> [ ... ]
> 
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
> 
> [Severity: Medium]
> Does this return a positive error code directly to userspace instead of the
> standard negative one (-EAGAIN)?
> 
> DRM ioctls pass positive return values directly back to user space as the
> ioctl syscall result. Because of this, user space will incorrectly interpret
> this as success and subsequently fail on dump ioctls since the session wasn't
> actually enabled.
> 
> > +		goto err_disable;
> 
> [Severity: High]
> Can this leak the Address Space reference if a hardware reset aborts the
> enable sequence?
> 
> If a GPU reset occurs before panfrost_mmu_as_get() is called, the reset
> handler clears mmu->as_count to 0, and then panfrost_mmu_as_get() increments
> it to 1. The code subsequently detects the reset via the hw_reset_happened
> flag, clears it, and jumps to err_disable here. Because err_disable skips
> panfrost_mmu_as_put(), the AS slot reference is permanently leaked,
> eventually exhausting the limited hardware AS slots.
> 
> > +	}
> > +
> >  	/* The BO ref is retained by the mapping. */
> >  	drm_gem_object_put(&bo->base);
> 
> [ ... ]
> 
> > @@ -209,7 +235,8 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
> >  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
> >  	perfcnt->buf = NULL;
> >  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> > -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> > +	if (!atomic_read(&perfcnt->hw_reset_happened))
> > +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> 
> [Severity: High]
> Could a race between this check and an asynchronous reset reintroduce the
> mmu->as_count underflow WARN that this patch was explicitly intended to
> prevent?
> 
> The non-atomic gap between reading the flag and executing
> panfrost_mmu_as_put() creates an exposure window. If an interleaved
> asynchronous hardware reset occurs in this window, panfrost_device_reset()
> will clear mmu->as_count to 0. The subsequent execution of
> panfrost_mmu_as_put() decrements it to -1, directly triggering the WARN.
> 
> >  	panfrost_gem_mapping_put(perfcnt->mapping);
> >  	perfcnt->mapping = NULL;
> >  	pm_runtime_put_autosuspend(pfdev->base.dev);
> 
> [ ... ]
> 
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
> > +	 * lock taken in perfcnt_enable. In light of this, the only thing we can do
> > +	 * is disabling perfcnt unconditionally, and notifying the perfcnt user of
> > +	 * the reset having happpened so that they can take recovery measures.
> > +	 */
> > +	panfrost_perfcnt_gpu_disable(pfdev);
> > +	atomic_set(&perfcnt->hw_reset_happened, 1);
> 
> [Severity: Medium]
> Will this unconditionally set the reset flag even if no perfcnt session is
> active, causing the next new session to spuriously fail?
> 
> Since this function is called during any GPU reset, it sets the flag even
> when perfcnt->user == NULL. If user space later attempts to start a
> completely new session, panfrost_perfcnt_enable_locked() will consume this
> stale flag and abort with EAGAIN, functionally breaking the feature on the
> first attempt after a reset.

Revealed by b4 review tui:

"For HW with `HW_ISSUE_8186` (the Tiler-counter erratum that the enable
path goes out of its way to handle by toggling Tiler around the CFG
write), turning off the master CFG while Tiler counters are still
enabled is the exact ordering the enable path tries to avoid. The commit
message does not acknowledge this functional change, and there is no
analysis of whether the new sequence is safe on `HW_ISSUE_8186`
parts. (Also flagged by sashiko-bot.)  **Suggested fix:** Either
preserve the original disable order in the helper (zero block enables
before clearing CFG), or document/justify in the commit message that the
new order is safe on all supported GPUs including `HW_ISSUE_8186` ones,
and drop the "no functional change" framing."

If it's true this breaks a HW quirk workaround, I might have to drop
this patch altogether.

