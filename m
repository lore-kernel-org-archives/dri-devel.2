Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6AC10F92E6
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D83D10E44F;
	Tue, 31 Mar 2026 17:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ER5PhQKa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED02010E25B
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:52:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B7966406A9;
 Tue, 31 Mar 2026 17:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC93C2BCB0;
 Tue, 31 Mar 2026 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774979542;
 bh=Of0GTXKirglFMgzgF6RRDjzLJyWtAKM0C3vkEsxTDSk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ER5PhQKa9vPKDJrL7fnDEquDv5LA+WfgdYLIvTgiPPoFemxtxQCa3rLFWvV+28oJg
 soF2iUY006pU9tA/cnadpVy75JOOJCY/QzR0oSqBlfwEZ1SZlEeGzMUXVPiYTt9pnC
 oGnQGr8YmELqOv/P/IKW4q++jUumAgysBWBD1bUt4M7NW26xWEmKD/kNRDYNvSHJIy
 sKvUwVZIx3L6rYa+SJjM42pLgfYVMOMzh4KX0hi+VqgwyzsRdioUGmBE6QqQrzdHr9
 fja13eUssJ52rcZtYzrjoxU4xdMaIAC5R5AwGecmkkRaIPBGyRfSVaP5tgmEHybhBI
 x3XZ920CrZ+0w==
Message-ID: <d5032396-21dc-4dd7-813e-cfde40b8a806@kernel.org>
Date: Tue, 31 Mar 2026 12:52:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Support read-only user-pointer BO
 mappings
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260331172635.3275296-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260331172635.3275296-1-lizhi.hou@amd.com>
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



On 3/31/26 12:26, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> Update the amdxdna user-pointer (ubuf) BO path to support creating buffer
> objects from read-only user mappings.
> 
> Detect read-only VMAs by checking VMA permissions across all user virtual
> address ranges associated with the BO. When all entries are read-only, pin
> user pages without FOLL_WRITE and export the resulting dmabuf as read-only
> (O_RDONLY).
> 
> This allows userptr BOs backed by read-only mappings to be safely imported
> and used without requiring write access, which was previously rejected due
> to unconditional FOLL_WRITE usage.
> 
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ubuf.c | 29 ++++++++++++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index 4c0647057759..3769210c55cc 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -125,6 +125,26 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
>   	.vunmap = amdxdna_ubuf_vunmap,
>   };
>   
> +static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	int ret;
> +
> +	mmap_read_lock(mm);
> +
> +	vma = find_vma(mm, va_ent->vaddr);
> +	if (!vma ||
> +	    vma->vm_start > va_ent->vaddr ||
> +	    vma->vm_end - va_ent->vaddr < va_ent->len)
> +		ret = -ENOENT;
> +	else
> +		ret = vma->vm_flags & VM_WRITE ? 0 : 1;
> +
> +	mmap_read_unlock(mm);
> +	return ret;
> +}
> +
>   struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   				 u32 num_entries, void __user *va_entries)
>   {
> @@ -134,6 +154,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   	struct amdxdna_ubuf_priv *ubuf;
>   	u32 npages, start = 0;
>   	struct dma_buf *dbuf;
> +	bool readonly = true;
>   	int i, ret;
>   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>   
> @@ -172,6 +193,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   			ret = -EINVAL;
>   			goto free_ent;
>   		}
> +
> +		/* Pin pages as writable as long as not all entries are read-only. */
> +		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
> +			readonly = false;
>   	}
>   
>   	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
> @@ -194,7 +219,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   		npages = va_ent[i].len >> PAGE_SHIFT;
>   
>   		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
> -					  FOLL_WRITE | FOLL_LONGTERM,
> +					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
>   					  &ubuf->pages[start]);
>   		if (ret >= 0) {
>   			start += ret;
> @@ -211,7 +236,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   
>   	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>   	exp_info.priv = ubuf;
> -	exp_info.flags = O_RDWR | O_CLOEXEC;
> +	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
>   
>   	dbuf = dma_buf_export(&exp_info);
>   	if (IS_ERR(dbuf)) {

