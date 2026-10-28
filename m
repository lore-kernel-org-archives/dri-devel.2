Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC95606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=g93tGe/w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9242C10E6B4;
	Wed, 28 Oct 2026 16:26:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8952D10FDA2
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:26:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEDA01756
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:26:31 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 B16353F59E
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793204794; bh=PExIaZTAjhGQMicvNikfB9CMe3bBt0uH+ireCrymzdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g93tGe/wqCDSl+kI0+rDtqGWZ3pXpDPgsaLWNDwV8+x0toy7hCxLWIh8ELPUoUIc5
 iQD2bdP7Z8m2WMNBSsmHGGgf7NePvYRDF7ipPcTieixm55ZHBJ7I/3vQUYtOb5DYkX
 BWUzX2kz5iiQmoR8URCjFvsbgsYsBPqhgUFsq/bA=
Date: Wed, 28 Oct 2026 16:26:33 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v1 09/27] drm/panthor: Skip devfreq when no OPP table is
 present
Message-ID: <auIiOVi13v0U8fIp@e142607>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-10-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922204535.2850094-10-karunika.choo@arm.com>
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

On Tue, Sep 22, 2026 at 09:45:03PM +0100, Karunika Choo wrote:
> On Mali v15 AM systems, frequency scaling is handled outside panthor by
> the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.
> 
> Make panthor_devfreq_init() return early when dev_pm_opp_get_opp_table()
> returns -ENODEV, and guard the devfreq helper paths against a missing
> devfreq instance. Also make it so that frequency can be queried even if
> the devfreq instance is missing.
> 
> This keeps devfreq enabled for existing platforms while allowing v15 AM
> systems to probe without a local devfreq setup.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
> v1:
> - Only skip panthor_devfreq init when OPP lookup returns -ENODEV instead
>   of direct DT-property check.
> - Support frequency query without devfreq.
> 
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 31 ++++++++++++++++++-----
>  drivers/gpu/drm/panthor/panthor_hw.h      |  6 +++++
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 2249b41ca4afe..18c1a7e56ca08 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -12,6 +12,7 @@
>  
>  #include "panthor_devfreq.h"
>  #include "panthor_device.h"
> +#include "panthor_hw.h"
>  
>  /**
>   * struct panthor_devfreq - Device frequency management
> @@ -164,6 +165,19 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	 */
>  	table = dev_pm_opp_get_opp_table(dev);
>  	if (IS_ERR_OR_NULL(table)) {
> +		/*
> +		 * On v15 GPUs, frequency scaling is handled outside of panthor
> +		 * by the AM_GOVERNOR block, so the GPU DT node may not provide
> +		 * an OPP table. In such cases, do not initialize devfreq for
> +		 * panthor.
> +		 */
> +		if (panthor_hw_is_gen5_am(ptdev->base.dev) &&
> +		    PTR_ERR(table) == -ENODEV) {
> +			drmm_kfree(&ptdev->base, pdevfreq);
> +			ptdev->devfreq = NULL;
> +			return 0;
> +		}
> +
>  		ret = devm_pm_opp_set_regulators(dev, reg_names);
>  		if (ret && ret != -ENODEV) {
>  			if (ret != -EPROBE_DEFER)
> @@ -267,7 +281,7 @@ void panthor_devfreq_resume(struct panthor_device *ptdev)
>  {
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	panthor_devfreq_reset(pdevfreq);
> @@ -279,7 +293,7 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
>  {
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	drm_WARN_ON(&ptdev->base, devfreq_suspend_device(pdevfreq->devfreq));
> @@ -290,7 +304,7 @@ void panthor_devfreq_record_busy(struct panthor_device *ptdev)
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  	unsigned long irqflags;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	spin_lock_irqsave(&pdevfreq->lock, irqflags);
> @@ -306,7 +320,7 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  	unsigned long irqflags;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	spin_lock_irqsave(&pdevfreq->lock, irqflags);
> @@ -319,14 +333,17 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
>  
>  unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
>  {
> +	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  	unsigned long freq = 0;
>  	int ret;
>  
> -	if (!pdevfreq->devfreq)
> -		return 0;
> +	if (!pdevfreq || !pdevfreq->devfreq)
> +		get_cur_freq = panthor_devfreq_get_cur_freq;
> +	else
> +		get_cur_freq = pdevfreq->devfreq->profile->get_cur_freq;

You don't need the whole pointer to a function dance. You can just do:

--8<-------------------------------------------
+	if (!pdevfreq || !pdevfreq->devfreq)
+		ret = panthor_devfreq_get_cur_freq(ptdev->base.dev, &freq);
+	else
+		ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
  	if (ret)
  		return 0;
-->8-------------------------------------------

With that,

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

>  
> -	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
> +	ret = get_cur_freq(ptdev->base.dev, &freq);
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index 48232254fef97..e5bcb908068cb 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -101,4 +101,10 @@ static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
>  	return ptdev->gpu_info.l2_features;
>  }
>  
> +static inline bool panthor_hw_is_gen5_am(struct device *dev)
> +{
> +	return device_property_match_string(dev, "compatible",
> +					    "arm,mali-gen5-am") >= 0;
> +}
> +
>  #endif /* __PANTHOR_HW_H__ */
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
