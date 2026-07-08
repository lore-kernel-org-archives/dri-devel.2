Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EE0C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09ED10E5BB;
	Wed,  8 Jul 2026 12:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LN0SxY6Q";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5D810E5BB
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fKkvQYvKN2aGayw4qXlz8dAJL4n4ldi8fh+LPYNIP9A=; b=LN0SxY6QdlVDGcEC58vCGz72Xj
 iwhwixtSIEwBimLJNKDLLPorgqUeuYQejWS8wgLYnn9kRBxOJoXxSMvDX3j4VLcH+p+UsgbK/buDA
 za6ZfzrlnZaRySxFY2DZwhubd5Jq8eJJH+b3EAjGd7I8JhB3/PY7SfsWpXgOT/t1GdN6CObvgWp2B
 lf5laDw1TrzeckZPCRki4q9psBrY+JB+UzScCmHx8yInT/7lK9AIXrhA5cYlqK7HQkt3itDsvXvGZ
 gX++Eq2uFRvKfsxC1Kthvq9bzDHIqtWtrFGLhLE7bR3W46hJKMrz7tatRB2tgenpomdScregnwSvo
 kd7YFDkg==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1whRIg-00BhD1-E6; Wed, 08 Jul 2026 14:22:50 +0200
Message-ID: <dc850e55-4efa-4cea-9d1b-d8e361c6f30d@igalia.com>
Date: Wed, 8 Jul 2026 09:22:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/v3d: bound CPU-job query writes to their
 destination BO
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Melissa Wen <mwen@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260707221334.3854433-1-michael.bommarito@gmail.com>
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
In-Reply-To: <20260707221334.3854433-1-michael.bommarito@gmail.com>
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

Hi Michael,

I pushed [1] to drm-misc-fixes yesterday, so I picked this patch instead
of v5.

Applied to drm-misc-next, thanks!

Best regards,
- Maíra

On 07/07/26 19:13, Michael Bommarito wrote:
> The V3D_SUBMIT_CPU CPU jobs take user-supplied offsets and indices and
> consume them at exec time without checking that the accesses stay inside
> their BO:
> 
>    - TIMESTAMP_QUERY and RESET_TIMESTAMP_QUERY write one u64 per query
>      into bo[0] at a fully user-controlled per-query offset.
>    - COPY_TIMESTAMP_QUERY copies one u64 per query into bo[0] at
>      offset + i * stride, and reads each result from a user-controlled
>      offset in the source bo[1].
>    - COPY_PERFORMANCE_QUERY writes nperfmons * DRM_V3D_MAX_PERF_COUNTERS
>      counter slots plus an availability slot into bo[0] at the same
>      geometry.
>    - INDIRECT_CSD reads three u32 work-group counts from bo[0] at a
>      user-controlled offset, then writes each count back into the
>      indirect BO at a user-controlled u32 index (wg_uniform_offsets[]).
> 
> A render-node user (DRM_RENDER_ALLOW, no master, no capability) can make
> the handlers read or write past a BO's vmap mapping.
> 
> Validate the full access extent against the BO size once the BOs are
> looked up, before the job is queued, rejecting out-of-range geometry
> with -EINVAL. The copy extent offset + (count - 1) * stride + write_size
> is computed in u64, mirroring the u8 * pointer arithmetic in the
> executors: (count - 1) * stride is a u32 * u32 product that is exact in
> u64, so one overflow check on the total guards the bound. The
> performance slot count and the bare timestamp, copy-source and indirect
> offsets are computed in u64 the same way, so a user value cannot wrap
> the comparison.
> 
> Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
> Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
> Fixes: 34a101e64296 ("drm/v3d: Create a CPU job extension for the reset timestamp job")
> Fixes: 6745f3e44a20 ("drm/v3d: Create a CPU job extension to copy timestamp query to a buffer")
> Fixes: 209e8d2695ee ("drm/v3d: Create a CPU job extension for the copy performance query job")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v4:
>   - Rebase onto drm-misc-next (Maira Canal): this is a fix, but a
>     reasonably large change and not a critical bug.
>   - Reconcile with the "drm/v3d: Miscellaneous fixes" series [1]. Drop the
>     INDIRECT_CSD NULL indirect-BO reject: [1] patch 2/3 ("drm/v3d: Reject
>     invalid indirect BO handle in indirect CSD setup") already returns
>     -ENOENT for a bad handle at parse time, so that check is redundant.
>     This patch assumes that series lands first. The out-of-bounds
>     offset/index checks here are still novel and unfixed by [1].
>   - Declare the loop index i as u32 rather than int (Sashiko, Maira
>     Canal): a signed index could go negative once count exceeds INT_MAX.
>   - Trim the TIMESTAMP_QUERY comment and restore the v2 wording of the
>     COPY_PERFORMANCE_QUERY comment (Maira Canal).
>   - INDIRECT_CSD: name the rewrite target dst and the counts BO src, add
>     the "3 == x, y, z workgroup dims" and 0xffffffff-sentinel comments,
>     and rename the local to indirect_csd (Maira Canal).
> 
> [1] https://lore.kernel.org/dri-devel/20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com/
> v3: https://lore.kernel.org/all/20260617125811.3692951-1-michael.bommarito@gmail.com/
> v2: https://lore.kernel.org/all/20260614211644.217116-1-michael.bommarito@gmail.com/
> v1: https://lore.kernel.org/all/20260614131058.2525157-1-michael.bommarito@gmail.com/
> 
>   drivers/gpu/drm/v3d/v3d_submit.c | 126 +++++++++++++++++++++++++++++++
>   1 file changed, 126 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index ee2ac2540ed50..277823b774bed 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -4,6 +4,8 @@
>    * Copyright (C) 2023 Raspberry Pi
>    */
>   
> +#include <linux/overflow.h>
> +
>   #include <drm/drm_print.h>
>   #include <drm/drm_syncobj.h>
>   
> @@ -1300,6 +1302,126 @@ static const unsigned int cpu_job_bo_handle_count[] = {
>   	[V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY] = 1,
>   };
>   
> +/* Reject offset + (count - 1) * stride + write_size if it leaves the BO. */
> +static int
> +v3d_check_copy_extent(struct drm_device *dev, size_t bo_size,
> +		      u32 offset, u32 stride, u32 count, u64 write_size)
> +{
> +	u64 last;
> +
> +	if (!count)
> +		return 0;
> +
> +	/*
> +	 * The executors walk a u8 * cursor, so the furthest written byte is
> +	 * offset + (count - 1) * stride + write_size, matching the pointer
> +	 * arithmetic in v3d_copy_query_results()/v3d_copy_performance_query().
> +	 * (count - 1) * stride is a u32 * u32 product that is exact in u64,
> +	 * and offset + write_size stays far below the u64 range, so a single
> +	 * overflow check guards the total.
> +	 */
> +	last = write_size + offset;
> +	if (check_add_overflow((u64)(count - 1) * stride, last, &last) ||
> +	    last > bo_size) {
> +		drm_dbg(dev, "CPU job copy buffer exceeds the destination BO.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Reject a query CPU job whose writes would land outside their BO. */
> +static int
> +v3d_cpu_job_bounds_check(struct v3d_cpu_job *job)
> +{
> +	struct drm_device *dev = &job->base.v3d->drm;
> +	struct v3d_timestamp_query_info *tquery = &job->timestamp_query;
> +	struct v3d_copy_query_results_info *copy = &job->copy;
> +	u32 elem = copy->do_64bit ? sizeof(u64) : sizeof(u32);
> +	struct v3d_bo *dst, *src;
> +	u64 slots, write_size;
> +	u32 i;
> +
> +	switch (job->job_type) {
> +	case V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY:
> +	case V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY:
> +		/* Each query writes one u64 timestamp slot into bo[0]. */
> +		dst = to_v3d_bo(job->base.bo[0]);
> +
> +		for (i = 0; i < tquery->count; i++) {
> +			if ((u64)tquery->queries[i].offset + sizeof(u64) >
> +			    dst->base.base.size)
> +				goto err_range;
> +		}
> +		return 0;
> +	case V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY:
> +		/* Copies one u64 per query from bo[1] into bo[0]. */
> +		dst = to_v3d_bo(job->base.bo[0]);
> +		src = to_v3d_bo(job->base.bo[1]);
> +
> +		for (i = 0; i < tquery->count; i++) {
> +			if ((u64)tquery->queries[i].offset + sizeof(u64) >
> +			    src->base.base.size)
> +				goto err_range;
> +		}
> +
> +		write_size = (copy->availability_bit ? 2 : 1) * elem;
> +		return v3d_check_copy_extent(dev, dst->base.base.size,
> +					     copy->offset, copy->stride,
> +					     tquery->count, write_size);
> +	case V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY:
> +		/*
> +		 * Each query writes nperfmons * DRM_V3D_MAX_PERF_COUNTERS
> +		 * counter slots into bo[0], plus an availability slot at
> +		 * index ncounters. nperfmons and ncounters are user values,
> +		 * so the slot count is computed overflow-safe.
> +		 */
> +		dst = to_v3d_bo(job->base.bo[0]);
> +
> +		slots = (u64)job->performance_query.nperfmons *
> +			DRM_V3D_MAX_PERF_COUNTERS;
> +		if (copy->availability_bit)
> +			slots = max(slots,
> +				    (u64)job->performance_query.ncounters + 1);
> +
> +		write_size = slots * elem;
> +		return v3d_check_copy_extent(dev, dst->base.base.size,
> +					     copy->offset, copy->stride,
> +					     job->performance_query.count,
> +					     write_size);
> +	case V3D_CPU_JOB_TYPE_INDIRECT_CSD: {
> +		struct v3d_indirect_csd_info *indirect_csd = &job->indirect_csd;
> +
> +		/* 3 is the three dimensions (x, y, z) of the workgroup counts. */
> +		src = to_v3d_bo(job->base.bo[0]);
> +		if ((u64)indirect_csd->offset + 3 * sizeof(u32) >
> +		    src->base.base.size)
> +			goto err_range;
> +
> +		dst = to_v3d_bo(indirect_csd->indirect);
> +		for (i = 0; i < 3; i++) {
> +			u32 uidx = indirect_csd->wg_uniform_offsets[i];
> +
> +			/*
> +			 * 0xffffffff means "skip this rewrite", so the exec
> +			 * path never writes that index and it needs no check.
> +			 */
> +			if (uidx != 0xffffffff &&
> +			    (u64)uidx * sizeof(u32) + sizeof(u32) >
> +			    dst->base.base.size)
> +				goto err_range;
> +		}
> +		return 0;
> +	}
> +	default:
> +		return 0;
> +	}
> +
> +err_range:
> +	drm_dbg(dev, "CPU job query offset exceeds the BO.\n");
> +	return -EINVAL;
> +}
> +
>   /**
>    * v3d_submit_cpu_ioctl() - Submits a CPU job to the V3D.
>    * @dev: DRM device
> @@ -1364,6 +1486,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   			goto fail;
>   	}
>   
> +	ret = v3d_cpu_job_bounds_check(cpu_job);
> +	if (ret)
> +		goto fail;
> +
>   	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
>   		ret = v3d_setup_csd_jobs_and_bos(&submit, &cpu_job->indirect_csd.args,
>   						 NULL);
> 
> base-commit: 1acd235bc8b8cf62da1a2b497f3e8c5cf01a2205

