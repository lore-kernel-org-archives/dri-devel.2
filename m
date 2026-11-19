Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548F606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dnSNx4i0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8000E1125C8;
	Thu, 19 Nov 2026 16:01:29 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621CE1125B0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795104082;
 bh=67SZ4GsDP8PODyZ1ZuSPzWHjwvxyjW+OI9ZqSZIELfM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dnSNx4i0miJAGMJi8H9UX1wDPoogmpSWmS9HfrIH7qHmbn88FhEVzCsgyi5zgUaWx
 Ghh4UxT7DJOA1UciBQPnqxFu/xcbaEFy3YGVOWgC3j0NgEO3emjZnpjVN9kE1Rllgf
 q4KfK6r3EjzwzwH/mgrO7KSB2OkxO5GG+vN202xXEf/6A/5qpkOze+aDtC6Z2Wagtj
 zyxTvDJopxeW0D6cfTHrC+S/k6t8bx3MvrRmOccOor444gKosAxDCDlPcDd3wErQ1k
 Pa9zs4SfIb/xRfX46EMC6RIcxg3A3q6gMAQe/G8yApVdG3MlNj86Y8FEGCev/e+U8+
 UL01/xg9eYw3g==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F77717E047C;
 Thu, 19 Nov 2026 17:01:21 +0100 (CET)
Date: Thu, 19 Nov 2026 17:01:04 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v4 7/9] drm/panthor: Skip devfreq when explicitly disabled
Message-ID: <20261119170104.70015639@fedora1.home>
In-Reply-To: <20261119154604.2519184-8-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
 <20261119154604.2519184-8-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 15:45:57 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> On Mali v15 AM systems, frequency scaling is handled outside panthor by
> the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.
> 
> Add generic devfreq_disabled field to panthor_soc_data to allow
> disabling of devfreq for other use GPUs and make panthor_devfreq_init()
> return early when this flag is set. Ensure frequency can be queried
> without devfreq instance and omit drm-maxfreq-panthor from fdinfo when
> the maximum frequency is unknown.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> v4:
> - Use panthor_soc_data flags instead of compatible to allow earlier GPUs
>   to also disable devfreq. Resetting R-bs as a result.
> v3:
> - Omit drm-maxfreq-panthor from fdinfo when the maximum frequency
>   is unknown, as on AM systems without an OPP table.
> v2:
> - Directly call functions instead of storing function pointers.
> - Picked up R-b from Liviu
> v1:
> - Only skip panthor_devfreq init when OPP lookup returns -ENODEV instead
>   of direct DT-property check.
> - Support frequency query without devfreq.
> 
>  drivers/gpu/drm/panthor/panthor_devfreq.c |  9 +++++++--
>  drivers/gpu/drm/panthor/panthor_device.h  |  3 +++
>  drivers/gpu/drm/panthor/panthor_drv.c     |  5 ++++-
>  drivers/gpu/drm/panthor/panthor_hw.h      | 10 ++++++++++
>  4 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 2249b41ca4afe..8b215e24b02c3 100644
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
> @@ -154,6 +155,9 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  
>  	ptdev->devfreq = pdevfreq;
>  
> +	if (panthor_hw_is_devfreq_disabled(ptdev))
> +		return 0;
> +
>  	/*
>  	 * The power domain associated with the GPU may have already added an
>  	 * OPP table, complete with OPPs, as part of the platform bus
> @@ -324,9 +328,10 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
>  	int ret;
>  
>  	if (!pdevfreq->devfreq)
> -		return 0;
> +		ret = panthor_devfreq_get_cur_freq(ptdev->base.dev, &freq);
> +	else
> +		ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
>  
> -	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
>  	if (ret)
>  		return 0;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index f0a96ff0f13da..31f9341b5aeda 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -45,6 +45,9 @@ struct panthor_soc_data {
>  
>  	/** @asn_hash: ASN_HASH values when asn_hash_enable is true. */
>  	u32 asn_hash[3];
> +
> +	/** @devfreq_disabled: True if devfreq is handled external to Panthor */
> +	bool devfreq_disabled;
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index dc8d0191aef42..b4d3d339b04b4 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1715,7 +1715,10 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
>  	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_CYCLES)
>  		drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);
>  
> -	drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
> +	/* Omit the maximum frequency when it is unknown */
> +	if (ptdev->fast_rate)
> +		drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
> +
>  	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n",
>  		   panthor_devfreq_get_freq(ptdev));
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index 4cb603a3acef6..f93a6b16df2af 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -95,4 +95,14 @@ static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
>  		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
>  }
>  
> +static inline bool panthor_hw_is_devfreq_disabled(struct panthor_device *ptdev)
> +{
> +	const struct panthor_soc_data *data = ptdev->soc_data;
> +
> +	if (!data)
> +		return false;
> +
> +	return data->devfreq_disabled;
> +}
> +
>  #endif /* __PANTHOR_HW_H__ */

