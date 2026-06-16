Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D6ECD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410CE10E822;
	Tue, 16 Jun 2026 19:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Z8xsV58j";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFDA10E822
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 19:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781637319; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IpBJUWTdT7RT9QRbJ3zpzfssnUt0WtMyMFxGNkUyH49g52zBtgc9rlFVdKFONax1HedyGq43EW3QvI1dHfHTVX/wE9s7ZcOLOK4WxYVL2gkw9MC8wz6v5O0dTmk7cyznsP4Bq3zg0ZbNk3pKnCNJFupKYgYysoFEP0QBmZrKGD0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781637319;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BAZfFJhK7BAlmOVgBfnDcsb9o7dXLckamZVFSn2NDfA=; 
 b=Mn7jFQXvvHHtnMpU+JepUf2ROOFlStqk1W5x9eo5c18cDn4QK5hDMgBs2FsAYBo/+nYEWkb5KCklHFdGY/W3Md0H68GkA3K3/xAw6+GMxcGc1cw9CmEMRqFeEc14Y5U4yEMKXx4bb+0bcsiHFiD62njoIl0+eTNPZbFbg8fFc7U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781637319; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=BAZfFJhK7BAlmOVgBfnDcsb9o7dXLckamZVFSn2NDfA=;
 b=Z8xsV58jBrtQ5hELlPowch8zBSdZTE/KLdMawvzDMCtFZW3YNgNJYs8L5UNRtqKQ
 V0bm4x9U02HgLfGyC4KEd2QSLtIvf0bc+nI1rxhcPGYElvesCT8J9n5ud4aKrQhjpPv
 K7+GL2cEO41SW3SJ6UV6aRGBqsU0GlzR/oqrW6Hc=
Received: by mx.zohomail.com with SMTPS id 1781637317246786.2221356183986;
 Tue, 16 Jun 2026 12:15:17 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:15:11 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
Subject: Re: [PATCH v2 5/7] drm/panfrost: Make reset sequence deal with an
 active HWPerf session
Message-ID: <ajGb81qNmCbhLTCn@sobremesa>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-5-57c6bd4c1655@collabora.com>
 <20260604202613.4afe53f1@fedora-2.home>
 <9ec2de4c-9404-4c9b-9d86-c5aad9cde721@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ec2de4c-9404-4c9b-9d86-c5aad9cde721@arm.com>
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

On 05.06.2026 11:41, Steven Price wrote:
>On 04/06/2026 19:26, Boris Brezillon wrote:
>> On Thu, 04 Jun 2026 18:35:24 +0100
>> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
>> 
>>> Right now, if there's a HW reset and an HWPerf session is active,
>>> panfrost_mmu_reset() will reset the AS count for every single open file's
>>> mmu struct back to 0, and also invalidate their AS numbers. Then, when
>>> disabling hwperf, panfrost_mmu_as_put() will WARN that mmu->as_count is
>>> less than zero.
>>>
>>> Fix this by introducing a perfcnt HW reset path.
>>>
>>> The choice was made to render perfcnt unusable after reset, so that a
>>> user might have to reprogram it with a full disable/enable sequence
>>> before requesting more perfcnt dumps.
>> 
>> Can't we do better than that. We store the config of the perf session,
>> so if a reset is in progress, we can simply block on it, restore the
>> old config in the post_reset path, and get going with the DUMP request
>> once the reset has been done. There's certainly something to do to
>> report the discontinuity to userspace, but that's something we can
>> reflect through and extra field added to drm_panfrost_perfcnt_dump.
>
>I agree with Boris' point, ideally reset should be as transparent as
>possible. Reporting that it has happened is useful, but there's no need
>to force user space into restoring the context unnecessarily.
>
>One other minor issue below.

I think the fact that this is going to require a non-negligible amount of effort in thinking
out a stat-save-and-restore sequence for perfcnt in the event of a reset, I guess I'd better
leave it off for another series of its own.

>>>
>>> Reported-by: Claude <noreply@anthropic.com>
>>> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>> Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
>>> ---
>>>  drivers/gpu/drm/panfrost/panfrost_device.c  |  1 +
>>>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 46 ++++++++++++++++++++++++++++-
>>>  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |  1 +
>>>  3 files changed, 47 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
>>> index 87b372c9e675..2805d50c1b9b 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
>>> @@ -426,6 +426,7 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
>>>  
>>>  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
>>>  {
>>> +	panfrost_perfcnt_reset(pfdev);
>>>  	panfrost_gpu_soft_reset(pfdev);
>>>  
>>>  	panfrost_gpu_power_on(pfdev);
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
>>> index ad1156678e91..c2087ea705fe 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
>>> @@ -33,6 +33,7 @@ struct panfrost_perfcnt {
>>>  	struct panfrost_file_priv *user;
>>>  	struct mutex lock;
>>>  	struct completion dump_comp;
>>> +	atomic_t hw_reset_happened;
>>>  };
>>>  
>>>  static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
>>> @@ -57,9 +58,13 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
>>>  
>>>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
>>>  {
>>> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
>>>  	u64 gpuva;
>>>  	int ret;
>>>  
>>> +	if (atomic_read(&perfcnt->hw_reset_happened))
>>> +		return -EIO;
>>> +
>>>  	reinit_completion(&pfdev->perfcnt->dump_comp);
>>>  	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
>>>  	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
>>> @@ -140,6 +145,15 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>>>  		goto err_vunmap;
>>>  	}
>>>  
>>> +	/* If a reset is ongoing, the AS we get right below will be torn
>>> +	 * down, so rather than waiting until this becomes obvious in a
>>> +	 * perfcnt_dump() ioctl, we ask the user to try again slightly later.
>>> +	 */
>>> +	if (atomic_read(&pfdev->reset.pending)) {
>>> +		ret = -EAGAIN;
>>> +		goto err_vunmap;
>>> +	}
>>> +
>>>  	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
>>>  	if (ret < 0)
>>>  		goto err_vunmap;
>>> @@ -173,6 +187,16 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>>>  	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
>>>  		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
>>>  
>>> +	/* If a reset happened, we've no way of knowing whether it was between the time we called
>>> +	 * panfrost_mmu_as_get() or before perfcnt_enable(), so clearing this flag and going forward
>>> +	 * isn't possible. We must clear the flag and try again in the hopes no resets will happen
>>> +	 * between this and the next ioctl invocation.
>>> +	 */
>>> +	if (atomic_cmpxchg(&perfcnt->hw_reset_happened, 1, 0)) {
>>> +		ret = EAGAIN;
>
>Missing '-' on EAGAIN.

Acked.

>>> +		goto err_disable;
>>> +	}
>> 
>> This should really be transparent to the user, apart from reporting
>> that samples might have been lost because of the reset.
>> 
>>> +
>>>  	/* The BO ref is retained by the mapping. */
>>>  	drm_gem_object_put(&bo->base);
>>>  
>>> @@ -180,6 +204,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>>>  
>>>  	return 0;
>>>  
>>> +err_disable:
>
>We're leaking the AS reference here - you need a panfrost_mmu_as_put() call.

Acked, will fix.

>>> +	panfrost_perfcnt_gpu_disable(pfdev);
>>>  err_vunmap:
>>>  	drm_gem_vunmap(&bo->base, &map);
>>>  err_put_mapping:
>>> @@ -209,7 +235,8 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
>>>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
>>>  	perfcnt->buf = NULL;
>>>  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
>>> -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>>> +	if (!atomic_read(&perfcnt->hw_reset_happened))
>>> +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>
>The atomic_read() scares me - is this really safe and not subject to races?

You're right, it's racy because the thread executing the ioctl could be scheduled out right before
panfrost_mmu_as_put() is executed, then a reset come through in the meantime, and by the time it's
resumed the as_count would again be < 0. I guess I need a proper spinlock to protect access to the
mmu struct from perfcnt.

>Thanks,
>Steve
>
>> 
>> Why not call panfrost_mmu_as_put() in panfrost_perfcnt_pre_reset(),
>> which is called before panfrost_mmu_reset()? If we do that, the AS
>> should be returned, and we can add a panfrost_perfcnt_post_reset()
>> that's called after panfrost_mmu_reset() and which re-acquires the AS
>> and re-instantiate the perfcnt settings.
>> 
>>>  	panfrost_gem_mapping_put(perfcnt->mapping);
>>>  	perfcnt->mapping = NULL;
>>>  	pm_runtime_put_autosuspend(pfdev->base.dev);
>>> @@ -346,3 +373,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
>>>  	/* Disable everything before leaving. */
>>>  	panfrost_perfcnt_gpu_disable(pfdev);
>>>  }
>>> +
>>> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
>>> +{
>>> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
>>> +
>>> +	/* Since this function will be called either from a scheduled HW reset
>>> +	 * or a runtime resume, tearing down any perfcnt resources means we're
>>> +	 * doomed to deadlocking with perfcnt_{enable/disable}, since we'd have
>>> +	 * to take the perfecnt lock. On top of that, it'd also violate DMA fence
>>> +	 * signalling rules because GFP_KERNEL allocations are made with the perfcnt
>>> +	 * lock taken in perfcnt_enable.
>> 
>> Question is, do we really need these allocation to happen with the lock
>> held? And if yes, can't we protect perfcnt ops with a separate reset
>> lock?
>> 
>>> In light of this, the only thing we can do
>>> +	 * is disabling perfcnt unconditionally, and notifying the perfcnt user of
>>> +	 * the reset having happpened so that they can take recovery measures.
>> 
>> Informing userspace about the discontinuity is fine, but I think we
>> should try to restore the config in a post_reset() hook.
>> 
>>> +	 */
>>> +	panfrost_perfcnt_gpu_disable(pfdev);
>>> +	atomic_set(&perfcnt->hw_reset_happened, 1);
>>> +}
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
>>> index 8bbcf5f5fb33..8b9bc704b634 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
>>> @@ -14,5 +14,6 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
>>>  				  struct drm_file *file_priv);
>>>  int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
>>>  				struct drm_file *file_priv);
>>> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
>>>  
>>>  #endif
>>>
>> 

Adrian Larumbe
