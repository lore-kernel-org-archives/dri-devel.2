Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38E2CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E5A10F5AA;
	Thu, 28 May 2026 19:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="h5bKZWpQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B39B10F5AA
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RBMGdbHnd2aynUHC7hmEf31MglTT+0KoAoR9rUzgEK0=; b=h5bKZWpQeCK5LbL1t6XehMyv32
 F0sQ71E+zNdN3At2C6NIhD/1vblAWHNhpMF8okaTPYpDhXmU5HFmRRhW34UWVZAt1ENnibtWtA5J+
 LRbli0ozr2VWBZ+nvcRDyt83aKRdFwazy1L8U8GsotvJXvZnDalEc0148qzRVschvztYOKaj0IEws
 kDVEapzGEZihblFUcBwFchmcyyyCNPvAqMG8N7x6PqSbLmp2c1pSLokzs08WhIrYuxh3Z+IalaXdM
 AnJu28lq6czMK8RkjV2ZO7KSZuFmivWP3vZ7ft8uScDcPpJ3rCf5gD99aWlTAfDMyerkwO5Ok1CDu
 mHzNJ7Gw==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wSgBV-009W1X-HB; Thu, 28 May 2026 21:14:25 +0200
Message-ID: <9956a72e-57ad-4bad-a3f6-87710eb4924d@igalia.com>
Date: Thu, 28 May 2026 16:14:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: fix to avoid cleaning up uninitialized CPU jobs
To: Jeongjun Park <aha310510@gmail.com>, Melissa Wen <mwen@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org
References: <20260525140422.1545327-1-aha310510@gmail.com>
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
In-Reply-To: <20260525140422.1545327-1-aha310510@gmail.com>
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

Hi Jeongjun,

On 25/05/26 11:04, Jeongjun Park wrote:
> The CPU submit ioctl checks cpu_job->job_type before the CPU job has been
> initialized with v3d_job_init(). When no CPU job extension is supplied,
> the check fails and the ioctl goes to the common error path.
> 
> That path calls v3d_job_cleanup(), which expects a fully initialized
> v3d_job. However at this point the CPU job has only been allocated,
> so the embedded DRM scheduler job state has not been initialized yet.
> 
> Initialize the CPU job after parsing extensions, but before validating
> the CPU job type and BO count. Keep pre-initialization failures on a

Considering that this is a minimal fix for stable, could you explain me
why do you believe moving v3d_job_init() is the best solution?

Best regards,
- Maíra

> separate path that only deallocates the job and releases multisync
> post-dependencies. Also use the CPU-job release callback so initialized
> CPU jobs are released through the normal cleanup path.
> 
> Cc: stable@kernel.org
> Fixes: aafc1a2bea67 ("drm/v3d: Add a CPU job submission")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 3ddd53b6f437..f5a1b388eaa3 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -1300,10 +1300,18 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
>   		if (ret) {
>   			drm_dbg(dev, "Failed to get extensions.\n");
> -			goto fail;
> +			v3d_job_deallocate((void *)&cpu_job);
> +			goto fail_init;
>   		}
>   	}
>   
> +	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
> +			   v3d_cpu_job_free, 0, &se, V3D_CPU);
> +	if (ret) {
> +		v3d_job_deallocate((void *)&cpu_job);
> +		goto fail_init;
> +	}
> +
>   	/* Every CPU job must have a CPU job user extension */
>   	if (!cpu_job->job_type) {
>   		drm_dbg(dev, "CPU job must have a CPU job user extension.\n");
> @@ -1319,13 +1327,6 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   
>   	trace_v3d_submit_cpu_ioctl(&v3d->drm, cpu_job->job_type);
>   
> -	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
> -			   v3d_cpu_job_free, 0, &se, V3D_CPU);
> -	if (ret) {
> -		v3d_job_deallocate((void *)&cpu_job);
> -		goto fail;
> -	}
> -
>   	clean_job = cpu_job->indirect_csd.clean_job;
>   	csd_job = cpu_job->indirect_csd.job;
>   
> @@ -1402,6 +1403,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   	v3d_job_cleanup((void *)cpu_job);
>   	v3d_job_cleanup((void *)csd_job);
>   	v3d_job_cleanup(clean_job);
> +
> +fail_init:
>   	v3d_put_multisync_post_deps(&se);
>   
>   	return ret;

