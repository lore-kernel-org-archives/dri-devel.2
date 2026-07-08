Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF82C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEC410F0F7;
	Wed,  8 Jul 2026 11:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ad+CbklO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAF810F0F6
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E4aM3YRlafpM5a8oHo4XXi/eDNOKBzJdhWRaC0FFX5s=; b=Ad+CbklOEu+1uwYwnEQskXrAyO
 dfdtjGoEht/pyxQMLMY10XIoIOUCC3LmwWjh8pQdovZU5h6SNJTuCOma7GlDy3//n10Adq1EIi9qV
 3+YpKg7odtJg+TLXTMoBg477ejhyyHsHVif8DPuXM8q60rdxEBVQYH/U9W99p3MqCBI3Wmt6RZnTN
 LwQDI7F0FAkrN6+InnwGaPP/VdsrNnClL8opp0JOS9ZI7n3gKZlOrlh/M662bGIqUIM/rD39FmyGD
 ppK0gtqvx/bihcsPNhwikatXMTIBC+KhGa7XR9SGMTX/WjC19Y28VutxYoJZsjZ/l5T10HvniVzuZ
 O1f5pA6Q==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1whQqN-00BgT9-Lk; Wed, 08 Jul 2026 13:53:35 +0200
Message-ID: <ae060a6c-c8a8-4bbe-b0bc-568fac1116ee@igalia.com>
Date: Wed, 8 Jul 2026 08:53:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: release CPU job resources on pre-init failures
To: Guangshuo Li <lgs201920130244@gmail.com>, Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260708090132.738819-1-lgs201920130244@gmail.com>
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
In-Reply-To: <20260708090132.738819-1-lgs201920130244@gmail.com>
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

You could incorporate your patch "[PATCH] drm/v3d: release indirect CSD
GEM on pre-init failures" into this one, which would be a much cleaner
solution.

The patch looks okay to me, just a few things.

First, please rebase your changes into drm-misc-fixes.

On 08/07/26 06:01, Guangshuo Li wrote:
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
> Move the CPU-job owned resource release into a helper and call it both
> from the normal CPU job destructor and from the pre-init error paths.
> 
> Fixes: b0fe80c0b925 ("drm/v3d: Fix use-after-free of CPU job query arrays on error path")
> Fixes: 6eb6e5acafa4 ("drm/v3d: Release indirect CSD GEM reference on CPU job free")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 8ed95a203810..2cca9c49f30c 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -127,20 +127,28 @@ v3d_render_job_free(struct kref *ref)
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
> +	job->timestamp_query.queries = NULL;
> +	job->timestamp_query.count = 0;

Why do you need to do that? It looks unnecessary to me.

Best regards,
- Maíra

>   
>   	v3d_performance_query_info_free(&job->performance_query,
>   					job->performance_query.count);
> +	job->performance_query.queries = NULL;
> +	job->performance_query.count = 0;
>   
> -	if (job->indirect_csd.indirect)
> +	if (job->indirect_csd.indirect) {
>   		drm_gem_object_put(job->indirect_csd.indirect);
> +		job->indirect_csd.indirect = NULL;
> +	}
> +}
>   
> +static void
> +v3d_cpu_job_free(struct kref *ref)
> +{
> +	v3d_cpu_job_free_resources(job);
>   	v3d_job_free(ref);
>   }
>   
> @@ -1318,10 +1326,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
>   		if (ret) {
>   			drm_dbg(dev, "Failed to get extensions.\n");
> -			if (cpu_job->indirect_csd.indirect) {
> -				drm_gem_object_put(cpu_job->indirect_csd.indirect);
> -				cpu_job->indirect_csd.indirect = NULL;
> -			}
> +			v3d_cpu_job_free_resources(cpu_job);
>   			goto fail;
>   		}
>   	}
> @@ -1329,12 +1334,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   	/* Every CPU job must have a CPU job user extension */
>   	if (!cpu_job->job_type) {
>   		drm_dbg(dev, "CPU job must have a CPU job user extension.\n");
> +		v3d_cpu_job_free_resources(cpu_job);
>   		ret = -EINVAL;
>   		goto fail;
>   	}
>   
>   	if (args->bo_handle_count != cpu_job_bo_handle_count[cpu_job->job_type]) {
>   		drm_dbg(dev, "This CPU job was not submitted with the proper number of BOs.\n");
> +		v3d_cpu_job_free_resources(cpu_job);
>   		ret = -EINVAL;
>   		goto fail;
>   	}
> @@ -1344,10 +1351,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
>   			   v3d_cpu_job_free, 0, &se, V3D_CPU);
>   	if (ret) {
> -		if (cpu_job->indirect_csd.indirect) {
> -			drm_gem_object_put(cpu_job->indirect_csd.indirect);
> -			cpu_job->indirect_csd.indirect = NULL;
> -		}
> +		v3d_cpu_job_free_resources(cpu_job);
>   		v3d_job_deallocate((void *)&cpu_job);
>   		goto fail;
>   	}

