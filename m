Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47061CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39E310F06B;
	Wed, 20 May 2026 13:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=igor.torrente@collabora.com header.b="i5FoT1Et";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F1F510EC24
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779282670; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h1A6Ce2M6EN2kc7ddYgHZvZ2kV4zvuk6c/Ej30YjJ05XfA2ra8yAD1svBWSpkgNES50zZiOTcxIHucqcnHbdqOtzSEhKIrjNi1Qw73uf75kjB0/8TgmVoEDUNPjRTq2fBDh1E1zEUrkF6pdX+bNagWn3xq/AG1BWmRAueV+HpbM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779282670;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IjZN7baVUkp//dQnaQw24mVQpih2pOULAojZG2gp0Fo=; 
 b=SMKa67Ad+M3ejKVjzlB07Vr/dXAotzopnF9aGNKocu3HKCu0snvb37fjKDVsy/bPhE9TQDwNzlkp/Koag6wpfQhbR/66o5TmFlEPCMPvn7y2Kt50/OT4YMep9Y/4WMNbCnFbndwJ5kiCdnZz9THt0joTGFXfCLrkEtLzfJTl5fQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
 dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779282670; 
 s=zohomail; d=collabora.com; i=igor.torrente@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=IjZN7baVUkp//dQnaQw24mVQpih2pOULAojZG2gp0Fo=;
 b=i5FoT1EtPfvjXFHCzphk8xuo3GfMtbtQml9yUO5aavwMBi3GrPmaEjF/FABRc3W/
 UTR0EALQxg9Z5AqbPJZn5D3I+1fyuDbxhIci36XKxAKehOaR61EpzUoacy3jlp8wq+9
 u4pyqovSgJ9/Z2Me/fm85JwHN6laJMSaNTiQA7Co=
Received: by mx.zohomail.com with SMTPS id 1779282668370237.5626986578659;
 Wed, 20 May 2026 06:11:08 -0700 (PDT)
Message-ID: <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
Date: Wed, 20 May 2026 10:11:03 -0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
To: Thomas Zimmermann <tzimmermann@suse.de>, boris.brezillon@collabora.com,
 loic.molinari@collabora.com, willy@infradead.org, frank.binns@imgtec.com,
 matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org
References: <20260209133241.238813-1-tzimmermann@suse.de>
 <20260209133241.238813-6-tzimmermann@suse.de>
Content-Language: en-US
From: Igor Torrente <igor.torrente@collabora.com>
In-Reply-To: <20260209133241.238813-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

On 2/9/26 10:27, Thomas Zimmermann wrote:
> Invoke folio_mark_accessed() in mmap page faults to add the folio to
> the memory manager's LRU list. Userspace invokes mmap to get the memory
> for software rendering. Compositors do the same when creating the final
> on-screen image, so keeping the pages in LRU makes sense. Avoids paging
> out graphics buffers when under memory pressure.
>
> In pfn_mkwrite, further invoke the folio_mark_dirty() to add the folio
> for writeback should the underlying file be paged out from system memory.
> This rarely happens in practice, yet it would corrupt the buffer content.
>
> This has little effect on a system's hardware-accelerated rendering, which
> only mmaps for an initial setup of textures, meshes, shaders, etc.
>
> v3:
> - rewrite for VM_PFNMAP
> v2:
> - adapt to changes in drm_gem_shmem_try_mmap_pmd()
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Hi Thomas,

I have and Radxa ROCK 5B+ with Mali-G610 GPU and I'm developing the VDRM 
(native context) driver
for panthor.ko.

Recently I update my kernel from 7.0 to the 7.1-rc3, and qemu started 
freezing with KVM error below
when running any graphical application with Venus or Panthor VDRM. For 
some reason Virgl is not affected.

```
error: kvm run failed Bad address
PC=0000ffffb4a86d70 X00=0000ffffb4be5000 X01=0000ffffb2279bb0
X02=0000000000000600 X03=0000ffffb4be5000 X04=0000ffffb227a1b0
X05=0000ffffb4be5600 X06=0000000000000001 X07=0000aaaaf384fd80
X08=dcc58d0daf897753 X09=0000000000000002 X10=0000ffffb4b96758
X11=000000002533f84b X12=0000000000001060 X13=0000000000000000
X14=0000000000000000 X15=0000000000000010 X16=0000ffffb3880128
X17=0000ffffb4a86c80 X18=0000000000000000 X19=0000aaaaf384f8a0
X20=0000aaaaf37cec80 X21=0000aaaaf37c7210 X22=0000aaaaf37c9550
X23=0000aaaaf37c74e0 X24=0000ffffb3b47fc8 X25=0000ffffb3b47fc8
X26=0000ffffb3b43c78 X27=0000aaaaf37e1840 X28=0000aaaaf37cee50
X29=0000ffffecbf1a60 X30=0000ffffb364b530  SP=0000ffffecbf1a60
PSTATE=0000000020001000 --C- EL0t
```

After bisecting I reach to your commit.

```
28e3918179aa75cfd4490b3b0281496ed91d829a  drm/gem-shmem:
Track folio accessed/dirty status in mmap
```

It still reproducible in the 7.1-rc4 (ab5fce87a778).

Appling the following patch (Boris suggestion) fixes the issue for me.

```
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c 
b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 545933c7f712..1e036f69c1ce 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -696,7 +696,7 @@ const struct vm_operations_struct 
drm_gem_shmem_vm_ops = {
  #endif
         .open = drm_gem_shmem_vm_open,
         .close = drm_gem_shmem_vm_close,
-       .pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
+//     .pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
  };
  EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
```

I'm not familiar with the drm_gem, code so I don't any more insightful 
information
to share.  But hopefully we can find a better fix for this.

BR,
Igor Torrente

> ---
>   drivers/gpu/drm/drm_gem_shmem_helper.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index c3a054899ba3..0c86ad40a049 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -598,6 +598,9 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>   	if (ret != VM_FAULT_NOPAGE)
>   		ret = vmf_insert_pfn(vma, vmf->address, pfn);
>   
> +	if (likely(!(ret & VM_FAULT_ERROR)))
> +		folio_mark_accessed(folio);
> +
>   out:
>   	dma_resv_unlock(obj->resv);
>   
> @@ -638,10 +641,27 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
>   	drm_gem_vm_close(vma);
>   }
>   
> +static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct drm_gem_object *obj = vma->vm_private_data;
> +	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
> +	pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page offset within VMA */
> +	struct page *page = shmem->pages[page_offset];
> +	struct folio *folio = page_folio(page);
> +
> +	file_update_time(vma->vm_file);
> +
> +	folio_mark_dirty(folio);
> +
> +	return 0;
> +}
> +
>   const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>   	.fault = drm_gem_shmem_fault,
>   	.open = drm_gem_shmem_vm_open,
>   	.close = drm_gem_shmem_vm_close,
> +	.pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
>   };
>   EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
>   
