Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAABCD8CA8
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 20:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4C310E0ED;
	Sun, 14 Jun 2026 20:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="eMNPnd4k";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C7C10E0ED
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aei49ArYLouvRSITNcHnJFJUdIWbTTOHfwBgsHIsZQc=; b=eMNPnd4kW9KLRRJEJ7l1SgKaqH
 lNnLOoPhmFBYSlnQY1oha7lxO1MBBxQMrHI2HeGXTSsLEv/wyHS0jQuqsvhMXtdZhSKM7zf9r+8Ta
 E54p6jvwUPLLVvPdkqWUcefAsuK4ZC7KCFKFc1qKRUSMLgh3hp66LoDafdHX7/lxviEIkySC9WsZk
 67n61Ee6GQEnKtgq5Ex4h/3Rd3qH/UsaSZAG/nzg5TMTKOdKUEMCoi6z/orBUwyLlqfb5jYKVRtuI
 azPbF1IyMYFTO7cZMHtJeqSIWtHr6zERzNBa3+f9qyrhjEX05URL3Y+FrB1VR0yYfKOITnoJdymVa
 XGaNITvw==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wYrC9-00HXq5-PG; Sun, 14 Jun 2026 22:12:38 +0200
Message-ID: <6f1d1888-8176-48eb-ae4d-bda06bd07ef5@igalia.com>
Date: Sun, 14 Jun 2026 17:12:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/v3d: validate copy-query buffer bounds against
 destination BO size
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Melissa Wen <mwen@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260614131100.2525157-1-michael.bommarito@gmail.com>
 <20260614131100.2525157-2-michael.bommarito@gmail.com>
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
In-Reply-To: <20260614131100.2525157-2-michael.bommarito@gmail.com>
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

On 14/06/26 10:10, Michael Bommarito wrote:
> The V3D_SUBMIT_CPU COPY_TIMESTAMP_QUERY and COPY_PERFORMANCE_QUERY

If you are doing it for V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY and
V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY, you should also do it for
V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY and
V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY.

> extensions store a user-supplied destination offset, per-query stride and
> query count on the job and consume them at exec without checking that
> offset + (count - 1) * stride + per-query write size stays inside the
> destination BO. The copy then writes counter values and the availability
> bit past the BO's vmap mapping; the timestamp variant also reads each
> result from an unchecked offset into the second BO. A render-node user
> (DRM_RENDER_ALLOW, no master, no capability) controls the offset.
> 
> Validate the full write extent against the destination BO size once the
> BOs are looked up, before the job is queued, rejecting overflow or
> out-of-range geometry with -EINVAL; the per-query write size is computed
> with check_*_overflow() so a u32 product cannot wrap the bound, and the
> timestamp source offsets are bounded in the same pass. A KUnit reproducer
> follows.
> 
> Fixes: 6745f3e44a20 ("drm/v3d: Create a CPU job extension to copy timestamp query to a buffer")
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
> Reproduced under KASAN via a KUnit (patch 2) driving the real
> v3d_copy_query_results() over a shmem-backed BO; a copy offset at the BO
> size writes past the one-page vmap mapping:
> 
>    BUG: KASAN: vmalloc-out-of-bounds in v3d_copy_query_results+0x807/0x900
> 
> The trigger faults on stock and is rejected at submit time on the patched
> tree; two in-bounds controls pass on both. The performance-query copy
> shares the bound; its write values come from perfmon counters and were
> checked by source review rather than this hardware-free run.
> 
>   drivers/gpu/drm/v3d/v3d_submit.c | 86 ++++++++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index ee4512db294b3..23e19dacfdce2 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -1246,6 +1246,88 @@ static const unsigned int cpu_job_bo_handle_count[] = {
>   	[V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY] = 1,
>   };
>   
> +/* Reject offset + (count - 1) * stride + write_size if it leaves the BO. */
> +static int
> +v3d_check_copy_extent(struct drm_device *dev, size_t bo_size,
> +		      u32 offset, u32 stride, u32 count, u32 write_size)
> +{
> +	u32 span, last;
> +

You don't need the variable "span".

> +	if (!count)
> +		return 0;
> +
> +	if (check_mul_overflow(stride, count - 1, &span) ||
> +	    check_add_overflow(span, write_size, &span) ||
> +	    check_add_overflow(span, offset, &last) ||
> +	    last > bo_size) {
> +		drm_dbg(dev, "CPU job copy buffer exceeds the destination BO.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Bound the copy-query CPU-job writes; the exec-time copy does not. */

This comment is a bit confusing.

> +static int
> +v3d_cpu_job_check_copy_bounds(struct v3d_cpu_job *job)

How about "v3d_cpu_job_bounds_check"?

> +{
> +	struct drm_device *dev = &job->base.v3d->drm;
> +	struct v3d_copy_query_results_info *copy = &job->copy;
> +	u32 elem = copy->do_64bit ? sizeof(u64) : sizeof(u32);
> +	struct v3d_bo *bo, *timestamp;
> +	u32 slots, write_size;
> +	int i;
> +
> +	switch (job->job_type) {
> +	case V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY:
> +		bo = to_v3d_bo(job->base.bo[0]);
> +		timestamp = to_v3d_bo(job->base.bo[1]);
> +
> +		slots = copy->availability_bit ? 2 : 1;
> +		if (check_mul_overflow(slots, elem, &write_size))

How could this ever overflow? slots is 1 or 2; elem is 4 or 8. The
maximum product is 2 * 8 = 16. That cannot overflow any integer type.

> +			return -EINVAL;
> +
> +		if (v3d_check_copy_extent(dev, bo->base.base.size, copy->offset,
> +					  copy->stride, job->timestamp_query.count,
> +					  write_size))
> +			return -EINVAL;
> +
> +		for (i = 0; i < job->timestamp_query.count; i++) {
> +			u32 end;
> +
> +			if (check_add_overflow(job->timestamp_query.queries[i].offset,
> +					       (u32)sizeof(u64), &end) ||
> +			    end > timestamp->base.base.size) {
> +				drm_dbg(dev, "CPU job timestamp query offset exceeds the BO.\n");
> +				return -EINVAL;
> +			}
> +		}
> +		return 0;

I have the impression that this function is over complicating something
simple. This could be as simple as:

dst = to_v3d_bo(job->base.bo[0]);
src = to_v3d_bo(job->base.bo[1]);

for (i = 0; i < tquery->count; i++) {
     if (tquery->queries[i].offset + sizeof(u64) > src->base.base.size)
         goto err_range;
}

write_size = (copy->availability_bit ? 2 : 1) * (u64)elem;
return v3d_check_copy_extent(dev, dst->base.base.size,
                              copy->offset, copy->stride,
                              tquery->count, write_size);

The same logic of simplification also apply to
V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY (with its own caveats).

About your second patch (the KUnit reproducer), it's a nice test to
reproduce this issue, but for me, it's a no-go in terms of upstreaming.
This is a very simple issue, not related to any v3d functional
regression. So, I'd prefer not to take the KUnit test to the branch.
Regarding this fix, a v2 addressing the issues pointed out is welcome.

Thanks for your patch.

Best regards,
- Maíra
