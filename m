Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6122CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4D510E630;
	Fri,  2 Oct 2026 15:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="VEXuqrMX";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5B91010E630
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:34:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73E23143D;
 Fri,  2 Oct 2026 08:34:55 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C5103F85F;
 Fri,  2 Oct 2026 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790955298; bh=trtR+s01elaDJMhAurTszPiTKfZo8xAqeqlZBtV1GTo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VEXuqrMXiFXFNSutxilLVc1xl52bHGqQswylLZqFvnMUrcIwI06Caqk927r8F9WJK
 9nladCFAkoTAOl03d6kqpdw7OlRw/TjcN8LONEkvvUKMmmtE0pGnLojeik3iE8DejM
 EerFmP3YjGr+4ee/d//KRDKvtI87g62aRj/TElEc=
Message-ID: <c43e07c5-863e-4997-aab5-69654e51fa28@arm.com>
Date: Fri, 2 Oct 2026 16:34:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 14/15] drm/panfrost: Introduce a reset lock
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-14-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-14-62beb08de207@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 29/09/2026 04:44, Adrián Larumbe wrote:
> So as to avoid accessing HW register while a reset is ongoing, a read/write
> semaphore that envelopes the reset sequence will help driver entry points
> avoid racing with it. For now, the only such racy entry point is the ioctl
> that returns the current GPU timestmap.

Typo: s/timestmap/timestamp

> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 2 ++
>  drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 9 ++++++---
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 1 +
>  4 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 94d2de341838..80d8f6aed090 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -481,6 +481,8 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
>  
>  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
>  {
> +	guard(rwsem_write)(&pfdev->reset.lock);
> +
>  	panfrost_gpu_soft_reset(pfdev);
>  
>  	panfrost_gpu_power_on(pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index a0b9a2145fc9..63452febb1cf 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -165,6 +165,7 @@ struct panfrost_device {
>  	struct {
>  		struct workqueue_struct *wq;
>  		struct work_struct work;
> +		struct rw_semaphore lock;
>  		atomic_t pending;
>  	} reset;
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index f77780c72a1a..571a26b84126 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -41,9 +41,12 @@ static int panfrost_ioctl_query_timestamp(struct panfrost_device *pfdev,
>  	if (ret)
>  		return ret;
>  
> -	panfrost_cycle_counter_get(pfdev);
> -	*arg = panfrost_timestamp_read(pfdev);
> -	panfrost_cycle_counter_put(pfdev);
> +	/* We should not read timestamp register while the GPU  is being reset */
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_cycle_counter_get(pfdev);
> +		*arg = panfrost_timestamp_read(pfdev);
> +		panfrost_cycle_counter_put(pfdev);
> +	}
>  
>  	pm_runtime_put(pfdev->base.dev);
>  	return 0;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index ab65786bf63b..4ddf4b722ddf 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -877,6 +877,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
>  	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
>  	spin_lock_init(&js->job_lock);
>  	mutex_init(&pfdev->sched_lock);
> +	init_rwsem(&pfdev->reset.lock);
>  
>  	js->irq = platform_get_irq_byname(to_platform_device(pfdev->base.dev), "job");
>  	if (js->irq < 0)
> 

