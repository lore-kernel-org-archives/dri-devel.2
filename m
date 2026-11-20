Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99290606A331
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=s395kUab
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0990B112A63;
	Fri, 20 Nov 2026 13:21:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD8410E0ED
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=FD8qNqxuGkw2ONxsf6uof1ejRB1r6IPhsvDKJD5h66E=; t=1795180870; x=2110540870; 
 b=s395kUabunqFU0py9h9v/CHH8L/TCfMKkxN7goeWTaV6cLe0AJVmltfXo2DdtChW8lBpw9m6iwi
 QQrBPqTP3lB5JWNl5TnSvwxC0HQ4r18mB01exKtxWDOWtnSPp2Ao+lMr4mHtbwXZTsE256wdowCVb
 p7GJRxgOjJRn3UN5OPw5Q2M1FzTsYNk5iNrfh0UV1B7fUQCcJCGyXblIEDGWdYduDXWg52zLh7nwm
 Rccnx+GqiI2ONxBjXrvs7p/JOfX4sfFmTjQAFBMtd+9ge/bMveB4OkiRqtdOOtiT1qkqYdcP93g7i
 1Jz9V221jN0YOueaXQaFEV6U/UlW7/UaDrEQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xUOY8-00000001siW-2MMt; Fri, 20 Nov 2026 14:21:08 +0100
Message-ID: <76156131-651d-450e-ad0d-f29ab8b0aa7f@igalia.com>
Date: Fri, 20 Nov 2026 10:21:04 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Don't free the core's sg_table when PRIME import
 fails
To: Roy <rongh7426@gmail.com>, mwen@igalia.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261120115840.417741-1-rongh7426@gmail.com>
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
In-Reply-To: <20261120115840.417741-1-rongh7426@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Roy,

This is a duplicate of [1].

[1] 
https://lore.kernel.org/dri-devel/20261119144339.43896-1-tsbol@icloud.com/

Best regards,
- Maíra

On 20/11/26 08:58, Roy wrote:
> When v3d_bo_create_finish() fails in v3d_prime_import_sg_table(), for
> example with -ENOSPC because the V3D address space is full, the object
> is freed with drm_gem_shmem_free(). At that point obj->import_attach is
> not set yet, since drm_gem_prime_import_dev() only sets it after the
> driver callback returns. drm_gem_shmem_release() therefore takes the
> non-imported path and treats shmem->sgt as its own: it unmaps it with
> the V3D device, calls sg_free_table() and kfree()s it.
> 
> That sg_table belongs to drm_gem_prime_import_dev(), which then unmaps
> it again through dma_buf_unmap_attachment_unlocked() on its fail_unmap
> path. The exporter's unmap runs on the freed table, and the kernel
> crashes:
> 
>    Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
>    pc : dma_direct_unmap_sg+0x84/0x260
>    lr : dma_unmap_sg_attrs+0x60/0x148
>    Call trace:
>     dma_direct_unmap_sg+0x84/0x260 (P)
>     dma_unmap_sg_attrs+0x60/0x148
>     drm_gem_unmap_dma_buf+0x38/0x68 [drm]
>     dma_buf_unmap_attachment+0x3c/0xa0
>     dma_buf_unmap_attachment_unlocked+0x58/0x98
>     drm_gem_prime_import_dev+0x1a0/0x1e0 [drm]
>     drm_gem_prime_fd_to_handle+0x1a8/0x280 [drm]
>     drm_prime_fd_to_handle_ioctl+0x40/0x58 [drm]
> 
> Users have hit this on Raspberry Pi 5 with Xorg importing vc4 buffers
> into v3d.
> 
> Clear shmem->sgt before freeing the object, so that only the PRIME core
> unmaps it.
> 
> Tested on a Raspberry Pi 5 running 6.18.39 with a small program that
> exports a vc4 dumb buffer, fills the V3D address space with BOs until
> creation fails with -ENOSPC, then imports the dma-buf into v3d. Without
> this patch the import oopses as above. With it, the import fails
> cleanly with -ENOSPC (60 runs), BO stats stay at zero, and imports
> succeed again once BOs are freed. The fix was tested as an out-of-tree
> v3d module built against 6.18.39; this tree was not built for arm64.
> 
> The bug was found and the fix written with the help of an AI coding
> assistant (Claude); I reproduced and tested it on hardware and reviewed
> the change.
> 
> Fixes: 40609d4820b2 ("drm/v3d: Use the new shmem helpers to reduce driver boilerplate.")
> Cc: stable@vger.kernel.org
> Link: https://github.com/raspberrypi/linux/issues/7504
> Signed-off-by: Roy <rongh7426@gmail.com>
> ---
>   drivers/gpu/drm/v3d/v3d_bo.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index db95a2f..d0b672d 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -185,6 +185,13 @@ v3d_prime_import_sg_table(struct drm_device *dev,
>   
>   	ret = v3d_bo_create_finish(obj);
>   	if (ret) {
> +		/*
> +		 * The sg_table still belongs to drm_gem_prime_import_dev(),
> +		 * which unmaps it when we return an error. import_attach is
> +		 * not set yet, so drm_gem_shmem_free() would otherwise unmap
> +		 * and free it as if it were ours.
> +		 */
> +		to_v3d_bo(obj)->base.sgt = NULL;
>   		drm_gem_shmem_free(&to_v3d_bo(obj)->base);
>   		return ERR_PTR(ret);
>   	}

