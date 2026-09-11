Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE424C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A7A610F6E5;
	Fri, 11 Sep 2026 19:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="B3Fods4B";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17A310F6E2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789154233; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Oo1xpzXRZBoW/ohEal9JzMxLBfyTeSmhlO/NtRI0IxaQkgd2fhgi/RTUSREiz702C11veNTPDPstYErsQqNaYkAmZlQ7Y4NBINCOEEmbousvO4+K2naZmVbwWx9n0zMDJTjDSSK3T9Nkq5olUDqoqiGoMNn/n3L7zj8JbP5P9ow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789154233;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+v9ar8wPBD0xHuf/zTdqOyqjdltZ2NhVgxC47rIZ6iM=; 
 b=EPGxE9ChslyVa02BCZ2KiOrFxf2veW+fSAMFeznAyOkw6E0dVQRPHfgLXDxKNQgl8GAvcyof1ZCXeVBevYFa6yzucL01CWb3/La6swOb4cHDicrTmpFG00/PQ/Y9caT31yyPokDgieQVwBtk2zzaEK5NsGmw7kdlsTP/UMGuFmk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789154233; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=+v9ar8wPBD0xHuf/zTdqOyqjdltZ2NhVgxC47rIZ6iM=;
 b=B3Fods4B7PIKs7oRpHmHsZWlC7Gn5nkjVWiwBJzYE8JPcs+ZADIEDjYotTPnRAkH
 vscd2d2DsQaupxRMv2R9Sbx4aWR7OUDkmrkaKxijunrg0vzAkkSaIHeLGdae5JXrtmB
 TnC/W1KgUw/nknpMSP4XcUTP9f9mwbfoRm8J0jBg=
Received: by mx.zohomail.com with SMTPS id 1789154231098208.1192348446799;
 Fri, 11 Sep 2026 12:17:11 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:17:07 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/18] drm/panthor: Track user owned VMs
Message-ID: <aqQTkeakkiMdTfcE@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-15-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-15-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.144.59
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 26.08.2026 16:56, Boris Brezillon wrote:
> We will soon need this to fix the unplug logic and make sure panthor_vm
> objects are not left behind after an unplug.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 47c57b39bd12..6368bf57b8f5 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -117,12 +117,15 @@ struct panthor_mmu {
>  
>  	/** @vm: VMs management fields */
>  	struct {
> -		/** @vm.lock: Lock protecting access to list. */
> +		/** @vm.lock: Lock protecting access to list and user_owned. */
>  		struct mutex lock;
>  
>  		/** @vm.list: List containing all VMs. */
>  		struct list_head list;
>  
> +		/** @vm.list: List containing VMs with a valid handle. */
> +		struct list_head user_owned;
> +
>  		/** @vm.reset_in_progress: True if a reset is in progress. */
>  		bool reset_in_progress;
>  
> @@ -447,6 +450,9 @@ struct panthor_vm {
>  	/** @node: Used to insert the VM in the panthor_mmu::vm::list. */
>  	struct list_head node;
>  
> +	/* @user_node: Used to insert the VM in the panthor_mmu::vm::user_owned list. */
> +	struct list_head user_node;
> +
>  	/** @for_mcu: True if this is the MCU VM. */
>  	bool for_mcu;
>  
> @@ -1681,10 +1687,19 @@ int panthor_vm_pool_create_vm(struct panthor_device *ptdev,
>  	drm_gem_object_get(&pool->dummy->base);
>  	vm->dummy = pool->dummy;
>  
> +	/* Insert in the list before xa_alloc() so we can't race with
> +	 * panthor_vm_pool_destroy_vm() have the VM inserted in the
> +	 * user_owned list after it's been destroyed.
> +	 */
> +	scoped_guard(mutex, &ptdev->mmu->vm.lock)
> +		list_add_tail(&vm->user_node, &ptdev->mmu->vm.user_owned);
> +
>  	ret = xa_alloc(&pool->xa, &id, vm,
>  		       XA_LIMIT(1, PANTHOR_MAX_VMS_PER_FILE), GFP_KERNEL);
>  
>  	if (ret) {
> +		scoped_guard(mutex, &ptdev->mmu->vm.lock)
> +			list_del_init(&vm->user_node);
>  		panthor_vm_put(vm);
>  		return ret;
>  	}
> @@ -1739,13 +1754,19 @@ static void panthor_vm_destroy(struct panthor_vm *vm)
>   */
>  int panthor_vm_pool_destroy_vm(struct panthor_vm_pool *pool, u32 handle)
>  {
> +	struct panthor_device *ptdev;
>  	struct panthor_vm *vm;
>  
>  	vm = xa_erase(&pool->xa, handle);
> +	if (!vm)
> +		return -EINVAL;
> +
> +	ptdev = container_of(vm->as->base.drm, struct panthor_device, base);
> +	scoped_guard(mutex, &ptdev->mmu->vm.lock)
> +		list_del_init(&vm->user_node);
>  
>  	panthor_vm_destroy(vm);
> -
> -	return vm ? 0 : -EINVAL;
> +	return 0;
>  }
>  
>  /**
> @@ -1785,7 +1806,7 @@ void panthor_vm_pool_destroy(struct panthor_file *pfile)
>  		return;
>  
>  	xa_for_each(&pfile->vms->xa, i, vm)
> -		panthor_vm_destroy(vm);
> +		panthor_vm_pool_destroy_vm(pfile->vms, i);
>  
>  	if (pfile->vms->dummy)
>  		drm_gem_object_put(&pfile->vms->dummy->base);
> @@ -3182,6 +3203,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
>  		goto err_put_as;
>  	}
>  
> +	INIT_LIST_HEAD(&vm->user_node);
>  	vm->user_va_range = kernel_va_start;
>  	vm->as = as;
>  	mutex_init(&vm->heaps.lock);
> @@ -3707,6 +3729,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  		return ret;
>  
>  	INIT_LIST_HEAD(&mmu->vm.list);
> +	INIT_LIST_HEAD(&mmu->vm.user_owned);
>  	ret = drmm_mutex_init(&ptdev->base, &mmu->vm.lock);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.55.0


Adrian Larumbe
