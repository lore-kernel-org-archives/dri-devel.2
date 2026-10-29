Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC060A263A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NCDv9Hzu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE9910E7B0;
	Thu, 29 Oct 2026 09:01:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C9CA10E7B0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:00:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DF46601FE;
 Thu, 29 Oct 2026 09:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7FE1F01828;
 Thu, 29 Oct 2026 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1793264429;
 bh=DgX+B0l0y0JObzSV9Y9eOGQGcmRVOIfdFOkUhnziwVY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NCDv9HzuMoEmCs8WRoESgwJLXAydU8XhMhF12n47jW7sNHzO0X3BOlXZ/mz1dMhx7
 E7qvCiqCWFwk8wyTMscwk/6QjlqbduI5fvc7W/pTjh2wxzJYhaNDYMpU3hrhgbxIoL
 5aHamqVza5xepn1xnc1cl+e7OSEauaV/fpYpSKmg=
Date: Thu, 29 Oct 2026 10:00:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5r2Y54Wc5p2t?= <panyuhang@hdu.edu.cn>
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 security@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: unpin BOs without revalidating placement
Message-ID: <2026102908-calculus-reenact-6ec5@gregkh>
References: <AD6AfwDkLPJWAKFimg*tgar*.1.1793261964318.Hmail.242270054@hdu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AD6AfwDkLPJWAKFimg*tgar*.1.1793261964318.Hmail.242270054@hdu.edu.cn>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 04:19:24PM +0800, 潘煜杭 wrote:
> 
> Unpinning a buffer object does not change its memory placement.
> Placement revalidation is unnecessary. Currently
> vmw_bo_pin_reserved() calls ttm_bo_validate() for both pin and unpin
> operations and treats any validation error as impossible with BUG_ON().
> 
> During PRIME/GEM cleanup, vmw_gem_object_unpin() calls
> vmw_bo_pin_reserved(vbo, false). The Linux 7.3-based QEMU reproducer
> confirmed that ttm_bo_validate() returned -EINVAL. The following BUG_ON()
> crashed the kernel during process exit. 
> 
> The relevant report excerpt is:
> 
>   [   72.916147] [BO_PIN_TRACE] before-validate pin=0 old_mem_type=0 target_mem_type=0 flags=0x10
>   [   72.916201] [BO_PIN_TRACE] after-validate ret=-22 old_mem_type=0 new_mem_type=0 ...
>   [   72.918841] kernel BUG at drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:342!
>   [   72.918892] Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   [   72.933292] CPU: 1 UID: 0 PID: 346 Comm: repro_vmwgfx_bo
>                Not tainted 7.3.0-dirty #2 PREEMPT(lazy)
>   [   72.937912] RIP: 0010:vmw_bo_pin_reserved+0x36d/0x380
>   [   72.947235] RBP: 00000000ffffffea
>   [   72.990254] Fixing recursive fault but reboot is needed!
> 
> The reproducer created a dumb GEM buffer, exported/imported its PRIME fd,
> performed GEM flink/open/close operations, and exited. During exit_group(),
> the call path was vmw_gem_object_unpin() -> drm_gem_map_detach() ->
> dma_buf_detach() -> drm_prime_gem_destroy() -> drm_gem_shmem_release() ->
> vmw_bo_pin_reserved().
> 
> The fix skips ttm_bo_validate() when unpinning. Validation remains on the
> pin path before ttm_bo_pin().
> 
> Assisted-by: OpenAI Codex (GPT-5)
> Signed-off-by: Yuhang Pan <242270054@hdu.edu.cn>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> index 9c7a73c..14d28e2 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -308,6 +308,11 @@ void vmw_bo_pin_reserved(struct vmw_bo *vbo, bool pin)
>      if (pin == !!bo->pin_count)
>          return;
>  
> +    if (!pin) {
> +        ttm_bo_unpin(bo);
> +        return;
> +    }
> +
>      pl.fpfn = 0;
>      pl.lpfn = 0;
>      pl.mem_type = bo->resource->mem_type;
> @@ -321,8 +326,5 @@ void vmw_bo_pin_reserved(struct vmw_bo *vbo, bool pin)
>  
>      BUG_ON(ret != 0 || bo->resource->mem_type != old_mem_type);
>  
> -    if (pin)
> -        ttm_bo_pin(bo);
> -    else
> -        ttm_bo_unpin(bo);
> +    ttm_bo_pin(bo);
>  }
> 
> -- 
> 2.34.1

This patch is corrupted and can not be applied :(

Also, no Fixes: or cc: stable tags?

thanks,

greg k-h
