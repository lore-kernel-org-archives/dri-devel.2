Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58F6C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC98F10F572;
	Fri, 11 Sep 2026 08:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QMurpJZt";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9276410F572
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:25:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E8DE16A3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 01:25:02 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 E6D6B3F7B4
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789115106; bh=pg2xKrTSSwShkOsUdLdeGDqS93TawwwTnBwMiecesqU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QMurpJZtqnybB5+agxGhIxOJebcr3OIGqF0+nDho3/woblZpAc7s/7HRjmJJGYapg
 ecStrJ4l10HiGVIbLkv7WrBXcwk8SsoZIzE3nRLiT8U9Tkn9APm0t0PWIAbKQGAD8u
 42FnnxRsI5hpxse+82k7KZtyansw9HzKm84PJ1is=
Date: Fri, 11 Sep 2026 09:24:49 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/gpuvm: reject zero-length range in
 drm_gpuvm_range_valid()
Message-ID: <aqO60UtyI9WlN0fw@e142607>
References: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
 <20260902-drm-gpuvm-zerorange-v2-v2-2-da63269c6ec4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902-drm-gpuvm-zerorange-v2-v2-2-da63269c6ec4@gmail.com>
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

On Wed, Sep 02, 2026 at 08:28:43PM +0800, Zhenhao Wan wrote:
> drm_gpuvm_range_valid() is the common gate every GPUVM map/unmap path
> funnels through: drm_gpuva_insert(), __drm_gpuvm_sm_map() and
> __drm_gpuvm_sm_unmap() all reject a request unless it passes. It checks
> for overflow, the managed-range bounds and kernel-node overlap, but it
> never rejects a zero-length range. A range of 0 is page-aligned and
> addr + 0 does not overflow, so a zero-length VM_BIND request from
> userspace passes validation.
> 
> The GPUVA interval tree derives a node's last key as addr + range - 1
> (GPUVA_LAST()). With range == 0 this underflows to addr - 1, producing
> an interval whose end lies below its start (and, for addr == 0, wraps to
> U64_MAX). __drm_gpuva_insert() then issues its overlap query with that
> inverted interval, so the -EEXIST guard matches nothing and a malformed
> zero-length node is inserted, corrupting the augmented interval tree's
> subtree-last invariant and misleading the overlap checks of later
> map/unmap operations on the same VM.
> 
> Because the shared helper's own kerneldoc promises to validate "the
> range" yet silently accepts range == 0, drivers have papered over this
> individually and inconsistently: imagination and xe reject a zero range
> at/near the ioctl boundary, while nouveau and msm do not. Fix it once at
> the common gate so every current and future caller is covered.
> 
> The only in-tree user that legitimately accepts a zero range,
> xe's DRM_XE_VM_BIND_OP_UNMAP_ALL, interprets it at its ioctl layer and
> never passes range == 0 into the GPUVM core, so it is unaffected. The
> in-core lookups drm_gpuva_find_prev()/drm_gpuva_find_next() pass
> range == 1 and are likewise unaffected.
> 
> Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_gpuvm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index c422c5af1f4b..b73ad6988171 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -1021,7 +1021,8 @@ drm_gpuvm_in_kernel_node(struct drm_gpuvm *gpuvm, u64 addr, u64 range)
>   * @addr: the base address
>   * @range: the range starting from the base address
>   *
> - * Checks whether the range is within the GPUVM's managed boundaries.
> + * Checks whether the range is non-zero and within the GPUVM's managed
> + * boundaries.
>   *
>   * Returns: true for a valid range, false otherwise
>   */
> @@ -1029,7 +1030,8 @@ bool
>  drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
>  		      u64 addr, u64 range)
>  {
> -	return !drm_gpuvm_check_overflow(addr, range) &&
> +	return range != 0 &&
> +	       !drm_gpuvm_check_overflow(addr, range) &&
>  	       drm_gpuvm_in_mm_range(gpuvm, addr, range) &&
>  	       !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
>  }
> 
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
