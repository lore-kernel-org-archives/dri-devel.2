Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1DFCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 23:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D634810E35E;
	Mon, 18 May 2026 23:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WR4OCB0I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8C410E35E
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 23:54:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 02BFE60120;
 Mon, 18 May 2026 23:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EF6C2BCB8;
 Mon, 18 May 2026 23:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779148449;
 bh=ZZernUP6/Hi6KA5O7QXbFZWWf//ctZy3kOMXm/a4ikQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WR4OCB0I7mOtJEjSJu5BrcVnBmtMsjcFskuVZ3m9ZjrRdeX4LbZ21o1mmS6G9m+DD
 KVpI5Pf21t44NZ+ddBVofR/0hF1n+cxokMAdZ1cDXXcmnRvyhUdHe0Ne/gMWqZGEE3
 3dueirwjGNoZdkV2f0PkJxVQ1hF4WD2rQX0pkcGjIdVC70wOiM6MOHOen+r9CdTxx+
 4p+7Kkc7kcvu+Cx6lfUZaJXlq9YAZZpSakXcwKxJ+UIbo/pLy3W8BFyib5CZV+jZdC
 wREcWsPsZ42Npf3O4Uo+XysmbpL9hZTMbtgY10zZWCaNgTYtXEl5f0xmVFoYhUfVrR
 psjrPpVNWwAfw==
Message-ID: <a1d2b178-acac-41ef-ab81-0997a0a19612@kernel.org>
Date: Mon, 18 May 2026 18:54:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Remove mmap and export support for ubuf
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org, christian.koenig@amd.com, simona@ffwll.ch,
 max.zhen@amd.com, sonal.santan@amd.com
References: <20260518155706.937461-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260518155706.937461-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 5/18/26 10:57, Lizhi Hou wrote:
> Ubuf pages should not be mmaped or exported. Remove the ubuf mmap callback
> and return -EOPNOTSUPP when exporting ubuf objects.
> 
> ubuf vmap is also removed for there is not a real use case yet.
> 
> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v2:
>    Remove dead code amdxdna_ubuf_vm_ops structure and amdxdna_ubuf_vm_fault
>    function.
>    Rename Non-exportable buffer flag from 'pri' to 'private_buffer'
> 
>   drivers/accel/amdxdna/amdxdna_gem.c  |  9 ++++-
>   drivers/accel/amdxdna/amdxdna_gem.h  |  2 ++
>   drivers/accel/amdxdna/amdxdna_ubuf.c | 50 ----------------------------
>   3 files changed, 10 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 319d2064fafa..6b9b556de555 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -492,6 +492,9 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>   
> +	if (abo->private_buffer)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>   	if (abo->dma_buf) {
>   		get_dma_buf(abo->dma_buf);
>   		return abo->dma_buf;
> @@ -716,6 +719,7 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(dev);
>   	struct amdxdna_drm_va_tbl va_tbl;
> +	struct amdxdna_gem_obj *abo;
>   	struct drm_gem_object *gobj;
>   	struct dma_buf *dma_buf;
>   
> @@ -742,7 +746,10 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
>   
>   	dma_buf_put(dma_buf);
>   
> -	return to_xdna_obj(gobj);
> +	abo = to_xdna_obj(gobj);
> +	abo->private_buffer = true;
> +
> +	return abo;
>   }
>   
>   static struct amdxdna_gem_obj *
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index 4fc48a1189d2..957305ccb485 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -54,6 +54,8 @@ struct amdxdna_gem_obj {
>   
>   	/* True, if BO is managed by XRT, not application */
>   	bool				internal;
> +	/* True, if BO is not exportable */
> +	bool				private_buffer;
>   };
>   
>   #define to_gobj(obj)    (&(obj)->base.base)
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index 3769210c55cc..bb60fb80467e 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -69,60 +69,10 @@ static void amdxdna_ubuf_release(struct dma_buf *dbuf)
>   	kfree(ubuf);
>   }
>   
> -static vm_fault_t amdxdna_ubuf_vm_fault(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct amdxdna_ubuf_priv *ubuf;
> -	unsigned long pfn;
> -	pgoff_t pgoff;
> -
> -	ubuf = vma->vm_private_data;
> -	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> -
> -	pfn = page_to_pfn(ubuf->pages[pgoff]);
> -	return vmf_insert_pfn(vma, vmf->address, pfn);
> -}
> -
> -static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
> -	.fault = amdxdna_ubuf_vm_fault,
> -};
> -
> -static int amdxdna_ubuf_mmap(struct dma_buf *dbuf, struct vm_area_struct *vma)
> -{
> -	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
> -
> -	vma->vm_ops = &amdxdna_ubuf_vm_ops;
> -	vma->vm_private_data = ubuf;
> -	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> -
> -	return 0;
> -}
> -
> -static int amdxdna_ubuf_vmap(struct dma_buf *dbuf, struct iosys_map *map)
> -{
> -	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
> -	void *kva;
> -
> -	kva = vmap(ubuf->pages, ubuf->nr_pages, VM_MAP, PAGE_KERNEL);
> -	if (!kva)
> -		return -EINVAL;
> -
> -	iosys_map_set_vaddr(map, kva);
> -	return 0;
> -}
> -
> -static void amdxdna_ubuf_vunmap(struct dma_buf *dbuf, struct iosys_map *map)
> -{
> -	vunmap(map->vaddr);
> -}
> -
>   static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
>   	.map_dma_buf = amdxdna_ubuf_map,
>   	.unmap_dma_buf = amdxdna_ubuf_unmap,
>   	.release = amdxdna_ubuf_release,
> -	.mmap = amdxdna_ubuf_mmap,
> -	.vmap = amdxdna_ubuf_vmap,
> -	.vunmap = amdxdna_ubuf_vunmap,
>   };
>   
>   static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)

