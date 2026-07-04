Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246EEC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 12:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA8810E062;
	Sat,  4 Jul 2026 12:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="goa+123w";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D618E10E062
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CTpvZVbUU9v1mSVDc0erQ7yDB/kzf93Bb5HL+Klgmks=; b=goa+123wSBfr4HLUohr6y7cuBG
 aZVhEZLQWmXk3bZl8PovFg4nF+Kxx6pAc2hagJyfLbmdf6x30WkW8hmOW85yVcF516WzeWYnqvEpu
 WOlPdi5eo0p3LiBZMcHPbV3EgAzPBo8bE2B8auaI9kKJN3hDLmJOPf0dJhiThFnCjJ4ugdDzeXv24
 vk4aLEDS18TkE+mwdljkUa62o1XS+1iPYSsUH59j/fYr/Z0d/yPVp4P1SNgUlwr9XcV3v1SQZ6FbR
 Dw4CtH18XOtsUh5gsdKgVLye/5GwUtrGiVC/lVot0QLC39SolvoVxotC+jW756/IT2fKRb3/8selL
 bCMY6JUg==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wfzDF-008xAJ-KY; Sat, 04 Jul 2026 14:11:13 +0200
Message-ID: <10d3d64a-0321-4223-8a56-d32a654297fd@igalia.com>
Date: Sat, 4 Jul 2026 09:11:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/v3d: bound CPU-job query writes to their
 destination BO
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Melissa Wen <mwen@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260617125811.3692951-1-michael.bommarito@gmail.com>
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
In-Reply-To: <20260617125811.3692951-1-michael.bommarito@gmail.com>
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

Thanks for your patch!

On 17/06/26 09:58, Michael Bommarito wrote:
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
> +	int i;

Sashiko pointed out that this should be a u32 at least.

> +
> +	switch (job->job_type) {
> +	case V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY:
> +	case V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY:
> +		/*
> +		 * Each query writes one u64 timestamp slot into bo[0]. The
> +		 * offset is cast to u64 so a 0xffffffff query offset cannot wrap
> +		 * the addition past the BO size.
> +		 */

"/* Each query writes one u64 timestamp slot into bo[0]. */" was enough
of a comment.

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
> +		 * counter slots into bo[0], plus an availability slot at index
> +		 * ncounters. nperfmons and ncounters are user values; the slot
> +		 * count and write size are computed in u64 (u32 * small
> +		 * constant) so they cannot wrap.
> +		 */

I preferred the previous comment (from v2):

/*
  * Each query writes nperfmons * DRM_V3D_MAX_PERF_COUNTERS
  * counter slots into bo[0], plus an availability slot at
  * index ncounters. nperfmons and ncounters are user values,
  * so the slot count is computed overflow-safe.
  */

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
> +		struct v3d_indirect_csd_info *icsd = &job->indirect_csd;

I'd prefer to call it "indirect_csd".

> +
> +		/*
> +		 * The exec-time work-group rewrite reads three u32 counts from
> +		 * bo[0] at the user-supplied offset, then writes each count back
> +		 * into the indirect BO at a user-supplied u32 index. Reject a
> +		 * missing indirect BO (drm_gem_object_lookup() returned NULL for
> +		 * a bad handle, which the exec path would otherwise dereference)
> +		 * and bound both accesses.
> +		 */
> +		if (!icsd->indirect)
> +			return -ENOENT;

No need for that after [1].

[1] 
https://lore.kernel.org/dri-devel/20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com/T/#m6c2cb9021bc6b524fb713150f94bdfee3553cf72

> +
> +		dst = to_v3d_bo(job->base.bo[0]);

New line. Also, instead of the big comment on the beginning of this
case, I'd prefer a smaller comment here explaining that 3 is the three
dimensions of workgroup counts (x,y,z).

> +		if ((u64)icsd->offset + 3 * sizeof(u32) > dst->base.base.size)
> +			goto err_range;
> +
> +		src = to_v3d_bo(icsd->indirect);

I'm not sure src makes a lot of sense here, as we copy from BO to the
indirect BO. Maybe dst?

> +		for (i = 0; i < 3; i++) {
> +			u32 uidx = icsd->wg_uniform_offsets[i];
> +
> +			if (uidx != 0xffffffff &&

Add a comment explaining that, as 0xffffffff means "skip this rewrite",
the exec path doesn't write it, so there is no need to range-check it.

Finally, although it's a fix, I'd prefer to apply it to drm-misc-next as
(1) it's a reasonably big change and (2) it's not a critical bug. So, if
possible, rebase the patch on top of drm-misc-next.

Best regards,
- Maíra
