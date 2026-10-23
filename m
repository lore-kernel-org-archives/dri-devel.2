Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A3606A323
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BL/Lw7tc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF0810E63B;
	Fri, 23 Oct 2026 14:32:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B503E10E496
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 14:32:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 129C91C14
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:32:20 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 102113F673
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792765943; bh=anSElN5yBjJkYZBOkU/8sr3NncGEwgUdXZ2Ow2+bIdw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BL/Lw7tclapUr7xayI4e5tm8BlgTgxOue8eA9KsEck5zw3e6OQRm4gE14NwORC/VC
 9BzeB0cmSAlgD+t80YURutxCaoC1cDUBvaVHlcfK699RDsi3X+VGZdPGcVbtoZH4m4
 WrkZiMlCp3BoSRe9eqMhncM+KVAGp041YJAiUMB4=
Date: Fri, 23 Oct 2026 15:32:11 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v7 7/8] drm/panthor: Add suspend, resume and reset handling
Message-ID: <attv60kGpPPpKfJG@e142607>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-7-12c32495062f@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011-panthor-performance-counters-v7-7-12c32495062f@arm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Minor nit: subject line gives the wrong idea about the patch.

On Sun, Oct 11, 2026 at 06:36:54PM +0100, Lukas Zapolskas wrote:
> The sampler must disable and re-enable counter sampling around
> suspends, and must re-program the FW interface after a reset to
> avoid losing data. Additionally, if a request was pending before the
> reset and it was not acked, the reset will have cleared it, so we toggle
> the flag and re-request a sample.
> 
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  8 ++-
>  drivers/gpu/drm/panthor/panthor_perf.c   | 83 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_perf.h   |  6 +++
>  3 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 535383ef629f..c842480472ac 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -138,6 +138,7 @@ static void panthor_device_reset_work(struct work_struct *work)
>  	if (!drm_dev_enter(&ptdev->base, &cookie))
>  		return;
>  
> +	panthor_perf_pre_reset(ptdev);
>  	panthor_sched_pre_reset(ptdev);
>  	panthor_fw_pre_reset(ptdev, true);
>  	panthor_mmu_pre_reset(ptdev);
> @@ -147,6 +148,8 @@ static void panthor_device_reset_work(struct work_struct *work)
>  	ret = panthor_fw_post_reset(ptdev);
>  	atomic_set(&ptdev->reset.pending, 0);
>  	panthor_sched_post_reset(ptdev, ret != 0);
> +	if (!ret)
> +		panthor_perf_post_reset(ptdev);
>  	drm_dev_exit(cookie);
>  
>  	if (ret) {
> @@ -539,8 +542,10 @@ int panthor_device_resume(struct device *dev)
>  			ret = panthor_device_resume_hw_components(ptdev);
>  		}
>  
> -		if (!ret)
> +		if (!ret) {
>  			panthor_sched_resume(ptdev);
> +			panthor_perf_resume(ptdev);
> +		}
>  
>  		drm_dev_exit(cookie);
>  
> @@ -604,6 +609,7 @@ int panthor_device_suspend(struct device *dev)
>  		/* We prepare everything as if we were resetting the GPU.
>  		 * The end of the reset will happen in the resume path though.
>  		 */
> +		panthor_perf_suspend(ptdev);
>  		panthor_sched_suspend(ptdev);
>  		panthor_fw_suspend(ptdev);
>  		panthor_mmu_suspend(ptdev);
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
> index c66ad658a95d..28b02003f9f9 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
> @@ -1798,6 +1798,57 @@ int panthor_perf_session_sample(struct panthor_file *pfile, u32 handle, u64 user
>  	return err;
>  }
>  
> +/**
> + * panthor_perf_suspend - Prepare the performance counter subsystem for system suspend.
> + * @ptdev: Panthor device.
> + *
> + * Indicate to the performance counters that the system is suspending.
> + *
> + * This function must not be used to handle MCU power state transitions: just before MCU goes
> + * from on to any inactive state, an automatic sample will be performed by the firmware, and
> + * the performance counter firmware state will be restored on warm boot.
> + *
> + */
> +void panthor_perf_suspend(struct panthor_device *ptdev)
> +{
> +	struct panthor_perf *perf = ptdev->perf;
> +	int ret;
> +
> +	if (!perf)
> +		return;
> +
> +	guard(mutex)(&perf->op_lock);
> +
> +	ret = perf_disable(perf);
> +
> +	if (ret)
> +		drm_warn(&ptdev->base, "Could not stop sampling before suspend, err = %d", ret);
> +}
> +
> +/**
> + * panthor_perf_resume - Resume the performance counter subsystem after system resumption.
> + * @ptdev: Panthor device.
> + *
> + * Indicate to the performance counters that the system has resumed. This must not be used
> + * to handle MCU state transitions, for the same reasons as detailed in the kerneldoc for
> + * @panthor_perf_suspend.
> + */
> +void panthor_perf_resume(struct panthor_device *ptdev)
> +{
> +	struct panthor_perf *perf = ptdev->perf;
> +	int ret;
> +
> +	if (!perf)
> +		return;
> +
> +	guard(mutex)(&perf->op_lock);
> +
> +	ret = perf_enable(perf);
> +
> +	if (ret)
> +		drm_warn(&ptdev->base, "Could not resume sampling, err = %d", ret);
> +}
> +
>  /**
>   * panthor_perf_unplug - Terminate the performance counter subsystem.
>   * @ptdev: Panthor device.
> @@ -1868,3 +1919,35 @@ void panthor_perf_pool_destroy(struct panthor_file *pfile)
>  
>  	pfile->sessions = NULL;
>  }
> +
> +void panthor_perf_pre_reset(struct panthor_device *ptdev)
> +{
> +	if (!ptdev->perf)
> +		return;
> +
> +	guard(mutex)(&ptdev->perf->op_lock);
> +
> +	perf_disable(ptdev->perf);
> +}
> +
> +void panthor_perf_post_reset(struct panthor_device *ptdev)
> +{
> +	bool rerequest = false;
> +
> +	if (!ptdev->perf)
> +		return;
> +
> +	guard(mutex)(&ptdev->perf->op_lock);
> +
> +	perf_enable(ptdev->perf);
> +
> +	scoped_guard(spinlock_irqsave, &ptdev->perf->pend_lock) {
> +		rerequest = ptdev->perf->fw_sample_requested;
> +
> +		if (rerequest)
> +			ptdev->perf->fw_sample_requested = false;
> +	}
> +
> +	if (rerequest)
> +		perf_fw_request_sample(ptdev->perf);
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
> index 0e1172dbae39..e4a323fe6f0d 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.h
> +++ b/drivers/gpu/drm/panthor/panthor_perf.h
> @@ -18,6 +18,8 @@ int panthor_perf_pool_create(struct panthor_file *pfile);
>  void panthor_perf_pool_destroy(struct panthor_file *pfile);
>  
>  int panthor_perf_init(struct panthor_device *ptdev);
> +void panthor_perf_suspend(struct panthor_device *ptdev);
> +void panthor_perf_resume(struct panthor_device *ptdev);
>  void panthor_perf_unplug(struct panthor_device *ptdev);
>  
>  int panthor_perf_session_create(struct drm_file *file,
> @@ -30,5 +32,9 @@ int panthor_perf_session_sample(struct panthor_file *pfile, unsigned int handle,
>  
>  void panthor_perf_report_irq(struct panthor_device *ptdev, u32 status);
>  
> +void panthor_perf_pre_reset(struct panthor_device *ptdev);
> +
> +void panthor_perf_post_reset(struct panthor_device *ptdev);
> +
>  #endif /* __PANTHOR_PERF_H__ */
>  
> 
> -- 
> 2.43.0
> 

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
