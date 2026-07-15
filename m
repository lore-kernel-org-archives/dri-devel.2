Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4293C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF0C10E1B5;
	Wed, 15 Jul 2026 13:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Odj07E44";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6872910E1B5
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Ru5LYuC+6oHfWU4xGRWATE4of7UZEeRs3wFwkdxrz2c=; b=Odj07E44XaxteUsR41IVBYih0f
 vBpV1134K6r8iuoM1BGCCD/U00UDeba/SjdRk7bIq5RcU4oV21LkRHBHX3RgUC4x8yVchXlSUHBEr
 qpF0kae432qwCgK16fWFt6e7np6b93ndcyI5PErIDbP7Wk++R0bmCqlcG2BB3p+9eIH2TdKwkNJtI
 LZDytS5r7tv8E4sKeMklJJe+FKg/Inx6aR691Pr4PUGSwcHPrVNC3jXL/5T9kJsva3Jw2K0EsDM3c
 WYpF5aUrQuyNDaATWlLDvEa+IpLpOUqNK99/9lVQPIz/tpmMEMoxgEU2vQSaOHAyDkC6uCedp48hG
 udNVJwzw==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wjzni-00FTUo-EO; Wed, 15 Jul 2026 15:37:26 +0200
Message-ID: <9e5ff763-b51c-4161-b56d-8e3575daea77@igalia.com>
Date: Wed, 15 Jul 2026 10:37:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/v3d: release CPU job resources on pre-init failures
To: Guangshuo Li <lgs201920130244@gmail.com>, Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260713160630.1362131-1-lgs201920130244@gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260713160630.1362131-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Guangshuo,

On 13/07/26 13:05, Guangshuo Li wrote:
> The changes referenced by the Fixes tags moved CPU job resource cleanup
> to v3d_cpu_job_free(), the CPU job kref destructor.
> 
> However, CPU job extensions are parsed before v3d_job_init() has
> successfully installed that destructor. Timestamp and performance query
> arrays, their syncobj references, and the indirect CSD GEM reference can
> therefore be acquired before the CPU job is managed by the kref cleanup
> path.
> 
> If a later pre-init validation fails, or if v3d_job_init() itself fails,
> the CPU job can be cleaned up or deallocated without running
> v3d_cpu_job_free(). Those extension resources are then leaked.
> 
> Move the CPU-job-owned resource release into a helper and call it both
> from the normal CPU job destructor and from the pre-init error paths.
> 
> Fixes: b0fe80c0b925 ("drm/v3d: Fix use-after-free of CPU job query arrays on error path")
> Fixes: 6eb6e5acafa4 ("drm/v3d: Release indirect CSD GEM reference on CPU job free")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>    - Rebase onto drm-misc-fixes.
>    - Fold the indirect CSD GEM pre-init failure fix into this patch.
>    - Drop unnecessary pointer and count resets after releasing resources,
>      as suggested by Maíra Canal.
> 
>   drivers/gpu/drm/v3d/v3d_submit.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 7682b24f13ec..2b1dc92d4709 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -127,11 +127,8 @@ v3d_render_job_free(struct kref *ref)
>   }
>   
>   static void
> -v3d_cpu_job_free(struct kref *ref)
> +v3d_cpu_job_free_resources(struct v3d_cpu_job *job)
>   {
> -	struct v3d_cpu_job *job = container_of(ref, struct v3d_cpu_job,
> -					       base.refcount);
> -
>   	v3d_timestamp_query_info_free(&job->timestamp_query,
>   				      job->timestamp_query.count);
>   
> @@ -140,7 +137,15 @@ v3d_cpu_job_free(struct kref *ref)
>   
>   	if (job->indirect_csd.indirect)
>   		drm_gem_object_put(job->indirect_csd.indirect);
> +}
> +
> +static void
> +v3d_cpu_job_free(struct kref *ref)
> +{
> +	struct v3d_cpu_job *job = container_of(ref, struct v3d_cpu_job,
> +					       base.refcount);
>   
> +	v3d_cpu_job_free_resources(job);
>   	v3d_job_free(ref);
>   }
>   
> @@ -1313,6 +1318,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
>   		if (ret) {
>   			drm_dbg(dev, "Failed to get extensions.\n");
> +			v3d_cpu_job_free_resources(cpu_job);

You shouldn't call v3d_cpu_job_free_resources() if v3d_get_extensions()
failed, as it handles the cleaning path internally.

Best regards,
- Maíra
