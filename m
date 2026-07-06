Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB87C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D0310E0EB;
	Mon,  6 Jul 2026 10:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="feH0dY4n";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A241010E0EB
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:56:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4FE832AD
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:56:04 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 DAAC53F85F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783335369; bh=3wEprY72kVJPX73cGbaDluxrU1g56xSSUPXF+d8Mh00=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=feH0dY4n01IevzC6i4FFDxN2nLbk6be9Tb8w/e/D2wObWeg9L1jo2vycON/B8/aiP
 wiY5wil4DCtt3OhQV4F7FIEpp3DBI3fz8YDjmu0dJVtmFF07/3FM2s4pmxlDclwARS
 flGLDo7DjjfVSR6t7euibM2KAY0LSdYME+LQxouQ=
Date: Mon, 6 Jul 2026 11:55:58 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sashiko <noreply@sashiko.dev>
Subject: Re: [PATCH v4 1/3] drm/panthor: Check for sparse binding range
 overflow
Message-ID: <akuJvu4Um7_zL659@e142607>
References: <20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com>
 <20260704-vm_bind_checks-v4-1-4705b6ca9f8a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260704-vm_bind_checks-v4-1-4705b6ca9f8a@collabora.com>
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

On Sat, Jul 04, 2026 at 05:46:44AM +0100, Adrián Larumbe wrote:
> This check is being already carried out further down the call stack inside
> drm_gpuvm_sm_map -> drm_gpuvm_range_valid, but it's best to fail early in
> the driver before GPUVM functions are invoked so that we won't waste time
> allocating vm_bind context resources.
> 
> Reported-by: Sashiko <noreply@sashiko.dev>
> Closes: https://sashiko.dev/#/message/20260623204220.CDB1B1F000E9%40smtp.kernel.org
> Fixes: 12cf826bf1dd ("drm/panthor: Support sparse mappings")
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 31cc57029c12..163231c1703d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2975,12 +2975,16 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  {
>  	ssize_t vm_pgsz = panthor_vm_page_size(vm);
>  	struct drm_gem_object *gem;
> +	u64 end;
>  	int ret;
>  
>  	/* Aligned on page size. */
>  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
>  
> +	if (check_add_overflow(op->va, op->size, &end))
> +		return -EINVAL;
> +
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
>  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
> 
> -- 
> 2.55.0
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
