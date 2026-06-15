Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DEECD98E0
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1EF610E3DA;
	Mon, 15 Jun 2026 12:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="deu2KD+t";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6F010E3DA
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r6t8pEQMG/UEroaJuiFgvbpi61MI/xmzIluA2WJS9N8=; b=deu2KD+thByw6h0DBu1HEsfycZ
 oelv8N2GRFCkv2bSL6AzBgDnRZKtmdebxua/q7Hd55mOpgrsHwzEh977xcds+gKTQvNOyPjeHVJQk
 1ZJRXdukHXaESZ7jOINsu8859PMjPBXrkZ4q76AMzWyDaGOnmNtAxGylEXXTJ9U0pXT5AnlxhhiVZ
 GYghsVJA3I6QlgmMnE3A5QZxfMuTKwjJafjbIXD/V7SZ3PVtvGN26Mcj7bJTpa2vuNSdEva5xdJE4
 aByq+UD5DVH8Yk3dhneIdo4JeLRSuH9vx850viAS2LimQt+Spr/zteVBqheSEr2Kx3AljUjjubX18
 5uc3hUTA==;
Received: from gwsc.sc.usp.br ([143.107.225.16] helo=[172.24.56.86])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wZ6cG-000EJD-3E; Mon, 15 Jun 2026 14:40:36 +0200
Message-ID: <7a1a1380-dff3-4493-b188-0926fb918cf4@igalia.com>
Date: Mon, 15 Jun 2026 09:40:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/v3d: bound CPU-job query writes to their
 destination BO
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Melissa Wen <mwen@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260614211644.217116-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
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
In-Reply-To: <20260614211644.217116-1-michael.bommarito@gmail.com>
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

I just noticed that the same problem also apply to
V3D_CPU_JOB_TYPE_INDIRECT_CSD. Could you also address this issue for
such extension?

On 6/14/26 18:16, Michael Bommarito wrote:
> The V3D_SUBMIT_CPU query CPU jobs store a user-supplied destination
> offset (and, for the copy variants, a per-query stride and query count)
> on the job and consume them at exec time without checking that the
> writes stay inside the destination BO:
> 
>    - TIMESTAMP_QUERY and RESET_TIMESTAMP_QUERY write one u64 per query
>      into bo[0] at a fully user-controlled per-query offset.
>    - COPY_TIMESTAMP_QUERY copies one u64 per query into bo[0] at
>      offset + i * stride, and reads each result from a user-controlled
>      offset in the source bo[1].
>    - COPY_PERFORMANCE_QUERY writes nperfmons * DRM_V3D_MAX_PERF_COUNTERS
>      counter slots plus an availability slot into bo[0] at the same
>      geometry.
> 
> None of these are bounded against the BO size, so a render-node user
> (DRM_RENDER_ALLOW, no master, no capability) can make the handlers
> write past the BO's vmap mapping.
> 
> Validate the full write extent against the destination BO size once the
> BOs are looked up, before the job is queued, rejecting out-of-range or
> overflowing geometry with -EINVAL. The copy extent
> offset + (count - 1) * stride + write_size is accumulated with
> check_*_overflow() so a u32 product cannot wrap the bound, and the
> performance slot count is computed the same way since nperfmons and
> ncounters are user values. The bare timestamp writes and the copy
> source reads are a single fixed u64 slot per query and are bounded
> directly.
> 
> Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2:
>    - Extend the bound to the bare TIMESTAMP_QUERY and
>      RESET_TIMESTAMP_QUERY job types, which also write one u64 per query
>      into bo[0] at a user-controlled offset (Maira Canal).
>    - Simplify v3d_cpu_job_bounds_check(): the timestamp source/dest u64
>      slots are bounded directly without the can-never-overflow
>      check_mul_overflow(); only the genuinely user-sized copy extent and
>      the performance slot count keep check_*_overflow().
>    - Drop the redundant local in v3d_check_copy_extent(); rename the gate
>      to v3d_cpu_job_bounds_check(); reword the helper comments.
>    - Drop the KUnit reproducer patch; the suite is kept out of tree.
>    - Re-pin Fixes: to the earliest introducing commit (the timestamp
>      query job) now that the bare timestamp writes are covered.
> 
> Reproduced under KASAN with an out-of-tree KUnit driving the real
> handlers over shmem-backed BOs: with a query offset at the BO size the
> stock tree reports a vmalloc-out-of-bounds write in each of
> v3d_copy_query_results() (4 bytes), v3d_timestamp_query() (8 bytes) and
> v3d_reset_timestamp_queries() (8 bytes); with this patch the submit-time
> gate rejects the geometry and all in-bounds controls still pass. The
> write is plain CPU memory and not architecture specific (x86_64,
> COMPILE_TEST).
> 
>   drivers/gpu/drm/v3d/v3d_submit.c | 102 +++++++++++++++++++++++++++++++
>   1 file changed, 102 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index ee4512db294b3..fe11fd7e6e14a 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -1246,6 +1246,104 @@ static const unsigned int cpu_job_bo_handle_count[] = {
>   	[V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY] = 1,
>   };
>   
> +/* Reject offset + (count - 1) * stride + write_size if it leaves the BO. */
> +static int
> +v3d_check_copy_extent(struct drm_device *dev, size_t bo_size,
> +		      u32 offset, u32 stride, u32 count, u32 write_size)

Looking at the actual copy executors, I think the extent math in
v3d_cpu_job_bounds_check() should be done in u64 rather than u32 +
check_*_overflow().

The executors (v3d_copy_query_results/v3d_copy_performance_query)
compute the destination at pointer width:

       data = (u8 *)bo->vaddr + copy->offset;
       for (...) { write data[idx]; data += copy->stride; }

So the furthest byte is offset + (count - 1) * stride + write_size,
accumulated on a real u8 * (64-bit on arm64). Doing the extent in u64
mirrors the executor and would simplify the code.

I'd suggest having v3d_check_copy_extent() take u64 for write_size and
compute offset + (count - 1) * stride + write_size in u64. The (count -
1) * stride term is u32 x u32, so it's exact in u64 and needs no
overflow check, which removes the bulk of the check_*_overflow() dance.
The final additions can still be guarded with a single
check_add_overflow().

> +{
> +	u32 last;
> +
> +	if (!count)
> +		return 0;
> +
> +	if (check_mul_overflow(stride, count - 1, &last) ||
> +	    check_add_overflow(last, write_size, &last) ||
> +	    check_add_overflow(last, offset, &last) ||
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
> +	u32 slots, write_size;
> +	int i;
> +
> +	switch (job->job_type) {
> +	case V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY:
> +	case V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY:
> +		/* Each query writes one u64 timestamp slot into bo[0]. */
> +		dst = to_v3d_bo(job->base.bo[0]);
> +
> +		for (i = 0; i < tquery->count; i++) {

Maybe add a comment here mentioning that we need (u64) so a 0xffffffff
offset won't wrap.

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
> +		if (check_mul_overflow(job->performance_query.nperfmons,
> +				       (u32)DRM_V3D_MAX_PERF_COUNTERS, &slots))
> +			goto err_range;

With the previous suggestion, you can drop this check.

Best regards,
- Maíra
