Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4F60A2605
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nLIWCviT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821CF1120F4;
	Thu, 29 Oct 2026 09:00:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6FC10E7E0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:59:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 976BA600DA;
 Thu, 29 Oct 2026 08:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFE41F01825;
 Thu, 29 Oct 2026 08:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1793264396;
 bh=MfZsiPR9z6Giv1Nay+HsSdw6MpOIDutAzqAQVq0AcZo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nLIWCviT4VYVZ40Is/cPJ+WahIS91fZhzRCp4zqICNJjUSc/5rocLhfPknIOHWbVY
 sg6jT2MJX/F8VeK/rw+NsrdUNLdKOeXxBtUPmt41+nZ2wzrjmOxYI5dMHBaXhzqdR9
 AnfeNlAo0NprTw/81wkVCYdjiS4CND2e9YGk8AX0=
Date: Thu, 29 Oct 2026 09:59:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5r2Y54Wc5p2t?= <panyuhang@hdu.edu.cn>
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 security@kernel.org
Subject: Re: reject PRIME export without TTM backing
Message-ID: <2026102940-unlivable-cytoplast-352a@gregkh>
References: <ACEAWQCGLEhWF5vMItAIpqoW.1.1793262795047.Hmail.242270054@hdu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ACEAWQCGLEhWF5vMItAIpqoW.1.1793262795047.Hmail.242270054@hdu.edu.cn>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 04:33:15PM +0800, 潘煜杭 wrote:
> Hello,
> 
> GPT-5 assisted with the initial analysis and drafting the proposed fix. I am
> responsible for this report and patch.
> 
> While fuzzing the vmwgfx PRIME import path, I observed a kernel NULL pointer
> dereference in vmw_gem_object_get_sg_table(). The userspace operation was
> DRM_IOCTL_PRIME_FD_TO_HANDLE. The call path was:
> 
>   __x64_sys_ioctl()
>     -> vmw_unlocked_ioctl()
>     -> vmw_generic_ioctl()
>     -> drm_ioctl()
>     -> drm_prime_fd_to_handle_ioctl()
>     -> vmw_prime_fd_to_handle()
>     -> drm_gem_prime_fd_to_handle()
>     -> drm_gem_prime_import_dev()
>     -> dma_buf_map_attachment()
>     -> drm_gem_map_dma_buf()
>     -> vmw_gem_object_get_sg_table()
> 
> The vmwgfx callback obtains the TTM buffer object and uses bo->ttm as the
> embedded dma_ttm member of struct vmw_ttm_tt. In the crashing path, bo->ttm
> was NULL. container_of() consequently produced a NULL-based vmw_ttm_tt
> pointer, and reading vmw_tt->vsgt.sgt faulted at offset 0x88:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000088
>   RIP: 0010:vmw_gem_object_get_sg_table+0x2f/0xa0
>   RBP: 0000000000000000
>   CR2: 0000000000000088
> 
> The faulting instruction reads from [RBP + 0x88]; with RBP equal to zero,
> this matches the reported address. The callback requires a vmwgfx TTM
> translation table, so it must reject an object without bo->ttm before
> container_of() and member access. This patch returns -EINVAL in that case.
> 
> The patch below is against the Linux 7.3 source tree; it
> applies cleanly and passes checkpatch.pl --strict.
> 
> Assisted-by: OpenAI Codex (GPT-5)
> Signed-off-by: Yuhang Pan <242270054@hdu.edu.cn>

No Fixes: or cc: stable tags?

thanks,

greg k-h
