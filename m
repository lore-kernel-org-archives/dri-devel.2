Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F40DC88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDCFF10F581;
	Fri, 11 Sep 2026 10:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RkpkPdVz";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A131C10E17A
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:47:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3BDE1570
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:47:53 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 22E9F3F7B4
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789123677; bh=Vv6b41N7hKpD6FS7GYQvY+Y2yoBtiEJc+nuA8pm/TRc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RkpkPdVztWRFKUxV+2XVVGJIFL1lO6KAMVw4IIue08ZMFrUbtGsQgF00jCql7C3r5
 sEDPxmYUsRTTAcfh+ljkrg5EqTzRi4ViJ8oeg6+R3LEFrIFkxW1I/dsj/1KsZay/Ek
 44FLVKVEkfPgBQrE40VKcMK8k9oWL7PzpSGgO0bA=
Date: Fri, 11 Sep 2026 11:47:54 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/3] drm/panthor: lock the resident BOs of a submit last
Message-ID: <aqPcWol3x8QgGM3q@e142607>
References: <20260814073258.893007-1-matthew.brost@intel.com>
 <20260814073258.893007-4-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814073258.893007-4-matthew.brost@intel.com>
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

On Fri, Aug 14, 2026 at 12:32:58AM -0700, Matthew Brost wrote:
> panthor_vm_prepare_mapped_bos_resvs() locks every external object mapped
> in the VM and then validates the evicted ones. Validation here means
> panthor_vm_bo_validate(), which swaps the BO's pages back in and restores
> its VMAs. That is slow, and an external object is one which can be shared
> with another process, so the whole of it happens while holding dma-resv
> locks other processes may be waiting on.
> 
> Nothing is gained by holding those. A resident object needs no swapping
> in; only the evicted ones do. Split the locking into the two passes
> gpuvm now understands: the early pass takes just the evicted external
> objects and swaps them in, and the late pass takes the ones which were
> resident and are therefore normally ready to use as they are. Private
> objects are covered by the VM resv, which is held from the start, so
> evicted ones are still validated in the early pass.
> 
> The split is only worth it when there is something to validate, so
> drm_gpuvm_needs_two_pass() decides, and a submit with nothing evicted
> keeps doing exactly what it does today in a single pass.
> 
> Both passes run in the same drm_exec transaction, so nothing is unlocked
> in between and the late pass only ever adds locks. They take disjoint
> sets of objects, so passing slot_count to both still reserves it exactly
> once per object.
> 
> The early pass reads the evicted state without the object's dma-resv,
> that being the lock it is trying not to take. The race is benign: an
> object evicted right after the early pass skipped it is picked up by the
> late pass instead, which is why that pass still validates.
> 
> Validation here allocates pages, which can recurse into panthor's own
> shrinker, so it is worth being explicit about what the early pass can
> evict. There is no deadlock: drm_gem_lru_scan() acquires the resv with
> ww_mutex_trylock() and skips what it cannot get. VM-exclusive BOs share
> the VM resv, which is held across both passes, so those are always
> skipped. External objects are not held by the early pass, though, so
> reclaim can evict one while the early pass validates something else.
> 
> That is handled, and is why the late pass validates rather than only
> locking: it picks up anything evicted after the early pass looked at it.
> The cost is that the swapin for such a BO happens under the full set of
> locks, i.e. it degrades to the current behaviour for that one object.
> 
> Xe avoids this by refusing to evict BOs bound to a VM the current task is
> validating (xe_bo_eviction_valuable() and xe_vm_is_validating()). Panthor
> has no equivalent guard. Adding one would make the split more effective
> under memory pressure, but it is not needed for correctness, so it is left
> as a follow up.
> 
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Assisted-by: GitHub_Copilot:claude-opus-5

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 53 ++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 9f63a048df61..ef7fac18ade3 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -3256,6 +3256,26 @@ int panthor_vm_unmap_range(struct panthor_vm *vm, u64 va, u64 size)
>   * need to reserve a slot on all BOs mapped to a VM and update this slot with
>   * the job fence after its submission.
>   *
> + * When something is evicted the locks are taken in two passes; when nothing
> + * is, a single pass is used, as before. The early pass only takes the external
> + * objects which actually need validating, i.e. the evicted ones, and swaps
> + * them back in. Private objects are covered by the VM resv, which is held
> + * from the start, so they are validated here too. The late pass then takes
> + * the external objects the early pass left out, which were resident and so
> + * normally need no swapping in; it still validates, since one of them may
> + * have been evicted in the meantime.
> + *
> + * The point is that panthor_vm_bo_validate() swaps pages back in, which is
> + * slow, and an external object is one which can be shared with another
> + * process. Doing that while holding the resv of a resident shared BO would
> + * stall whoever else needs it, for no benefit, since a resident object is
> + * ready to use as it is.
> + *
> + * Both passes run in the same drm_exec transaction: nothing is unlocked in
> + * between and the late pass only ever adds locks. The passes take disjoint
> + * sets of objects, so reserving @slot_count in each still reserves it
> + * exactly once per object.
> + *
>   * Return: 0 on success, a negative error code otherwise.
>   */
>  int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm *vm,
> @@ -3268,11 +3288,40 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm
>  	if (ret)
>  		return ret;
>  
> -	ret = drm_gpuvm_prepare_objects(&vm->base, exec, slot_count);
> +	/*
> +	 * With nothing evicted there is no validation to keep the resident
> +	 * objects unlocked for, so do not pay for the second walk.
> +	 */
> +	if (!drm_gpuvm_needs_two_pass(&vm->base)) {
> +		ret = drm_gpuvm_prepare_objects(&vm->base, exec, slot_count);
> +		if (ret)
> +			return ret;
> +
> +		return drm_gpuvm_validate(&vm->base, exec);
> +	}
> +
> +	ret = drm_gpuvm_prepare_objects_pass(&vm->base, exec, slot_count,
> +					     DRM_GPUVM_EXEC_PASS_EARLY);
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_gpuvm_validate_pass(&vm->base, exec,
> +				      DRM_GPUVM_EXEC_PASS_EARLY);
>  	if (ret)
>  		return ret;
>  
> -	return drm_gpuvm_validate(&vm->base, exec);
> +	ret = drm_gpuvm_prepare_objects_pass(&vm->base, exec, slot_count,
> +					     DRM_GPUVM_EXEC_PASS_LATE);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Objects the early pass skipped were resident then, but another
> +	 * process may have evicted one since. Now that everything is locked,
> +	 * pick up whatever is left.
> +	 */
> +	return drm_gpuvm_validate_pass(&vm->base, exec,
> +				       DRM_GPUVM_EXEC_PASS_LATE);
>  }
>  
>  unsigned long
> -- 
> 2.34.1
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
