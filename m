Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D55606A333
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=oDIiR1xH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A30112C06;
	Fri, 20 Nov 2026 16:29:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E2610E074
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=BCi/61TdV/C0WfAh32EroT79N1Rf48PkOWrUh+PSmpg=; t=1795192171; x=2110552171; 
 b=oDIiR1xHKuE6h47POUmcJG4atLMehUcoUtIeHmPQFdOTJpUMsGB2hhyDDEFPQMoRGwGpi78pbg2
 aX9p5FAd9mjAH0lFKqJyzzGHoqi4e4hJO0cHHrqfp+LmHXGtekZ2oyux2reQY3jgDRtLzgzDbvcku
 Ev4LVQM3umoSquEAkoSFXHeA6GVHao+Ku63BzmHt62an2pHiczv/kTFCYN7dSrlBGl/sfCeQo2Le8
 IF90NSZnSX1wUB/At1ormIHYY+hfHjLRNyoZtD5B89g/OutCow0vIU1dP92fxneXh70kpJYrzTSSL
 QUrnzxB2e7e7Y9Xst2T3CfZz3V/0yI4VYxXQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xURUP-00000001wZO-3GlA; Fri, 20 Nov 2026 17:29:29 +0100
Message-ID: <f3997d67-8d39-4892-b144-d3ee25050d86@igalia.com>
Date: Fri, 20 Nov 2026 13:29:27 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/v3d: Fix double free of the sg_table when a PRIME
 import fails
To: Aleksei Riapolov <tsbol@icloud.com>, mwen@igalia.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261119144339.43896-1-tsbol@icloud.com>
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
In-Reply-To: <20261119144339.43896-1-tsbol@icloud.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aleksei,

On 19/11/26 11:43, Aleksei Riapolov wrote:

[...]

> 
> The error path frees the object with drm_gem_shmem_free(), as
> v3d_bo_create() does, and not with drm_gem_object_put():
> v3d_free_object() expects a BO that v3d_bo_create_finish() completed.
> For one whose node was never inserted it would clear page table entries
> starting at page 0, decrement bo_stats and call drm_mm_remove_node() on
> a node that is not allocated. With drm_gem_object_put() there, the
> failing import oopses in drm_mm_remove_node(), called from
> v3d_free_object().

You don't need to explain what you didn't do, only what you did.

Also, the following paragraphs can be deleted. They are not clarifying
at all.

> 
> v3d_bo_create_finish() now runs after obj->resv has been pointed at the
> reservation object of the dma-buf, so drm_gem_shmem_get_pages_sgt()
> takes that lock instead of the private lock of a new object, and an
> import can return -EINTR if a signal arrives while it waits for it.
>
> With this change, on the same board and kernel:
> 
>   - the failing import returns -ENOSPC in each of three consecutive
>     fills, and after 50 such failures debugfs dma_buf/bufinfo lists no
>     dma-buf;
>   - a v3d BO imported back into v3d through a second file is the same
>     BO at the same offset over 1000 iterations, with bo_stats back at
>     its starting value;
>   - a vc4 dumb buffer imported into v3d can be mapped, written, read
>     and closed;
>   - under labwc, glmark2-es2-wayland runs, and mpv playing 4K HEVC from
>     the hardware decoder imports the decoder's dma-heap buffers into
>     v3d about 2500 times, none of which is left attached afterwards;
>     the time an import takes and the number of dropped frames are the
>     same as with the unpatched module, with and without slub_debug.
> 
> The kernel log stays clean throughout. Other V3D generations were not
> tested.
> 
> A reproducer is available on request.

As a general note, please make this commit message more readable for
humans, not LLMs.

> 
> Fixes: 40609d4820b2 ("drm/v3d: Use the new shmem helpers to reduce driver boilerplate.")
> Cc: stable@vger.kernel.org
> Suggested-by: Maíra Canal <mcanal@igalia.com>
> Signed-off-by: Aleksei Riapolov <tsbol@icloud.com>
> ---
> v2: Allocate the GPU address after the import has completed, in a
>      .gem_prime_import wrapper, instead of clearing shmem->sgt on the
>      error path of the callback (Maíra).
> v1: https://lore.kernel.org/all/20261114164451.9222-1-tsbol@icloud.com/
> 
> For stable: drm_gem_is_imported() was added in v6.15, so earlier trees
> need obj->import_attach in the wrapper.
> 
>   drivers/gpu/drm/v3d/v3d_bo.c  | 17 +++++++++++++----
>   drivers/gpu/drm/v3d/v3d_drv.c |  3 ++-
>   drivers/gpu/drm/v3d/v3d_drv.h |  5 ++---
>   3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index db95a2f..34aca97 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -172,17 +172,26 @@ free_obj:
>   }
>   
>   struct drm_gem_object *
> -v3d_prime_import_sg_table(struct drm_device *dev,
> -			  struct dma_buf_attachment *attach,
> -			  struct sg_table *sgt)
> +v3d_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
>   {
>   	struct drm_gem_object *obj;
>   	int ret;
>   
> -	obj = drm_gem_shmem_prime_import_sg_table(dev, attach, sgt);
> +	obj = drm_gem_prime_import(dev, dma_buf);
>   	if (IS_ERR(obj))
>   		return obj;
>   
> +	/* A dma-buf exported by this device comes back as the BO it was
> +	 * exported from, which already has its GPU address.
> +	 */

How about "/* Self-import returns the native BO, already mapped. */"?

> +	if (!drm_gem_is_imported(obj))
> +		return obj;
> +
> +	/* The GPU address is allocated only now that the core has set
> +	 * obj->import_attach, so that a failure here is torn down as an
> +	 * import: the sg_table is unmapped once and the attachment is
> +	 * detached.
> +	 */

This comment is superfluous. Please, delete it.

Apart from this issues, it looks good to me. I believe we will be able
to merge it in v3.

Best regards,
- Maíra


