Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5C606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3L1A6EoD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954B410FD7E;
	Wed,  4 Nov 2026 17:09:14 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCA110E86F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moYHure8oyMDLkx5K22kCL4FsNl9VjZdmWVOMf35hXVjdsW/S90NUN4mk9QVQvPQPmVK1+zFAAmWmJUs6iEWmFDehHSXg5CtrAtl64uc29k/YXz5t0q7xsWK0wTo2jUm9wuzNMyznxr2v+QVs7uPEKIXlmKAVXg+H8v9soeAILFC39pXY40g85nEg342xkxVVft5feI8pWFwKQwqaO+pLfH6SLfS08UjtNF+hFeLNYWy3wy8HLXRU6GLN0ZjAN/Y6m8k0XmSwoK4Z5q3ZBOJ4xw246Dejy0bGRdfdtjFI9rU1R4YQC9+ZIr1Cy0ajn87KhHQmR3j4eZ1mQZve6WpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftI0UFOdkRAQKb5B4qPO0pM2QbqpAezKgmnOuI2y9Bw=;
 b=UX4ZLqEcT1TjQvdyvorMvNeOj3iH8wD0OkE3VSUps4My8GLAxX3IJCOXCD6ny3T9DVjYlEtKqoLS/dO/W72xjZOTOwEuwDYVRm34tmeRVGpd5dtVgSfvRfFxon9LUhRQQMTWyZzxfc+DLT7ZeOZMgyjMGAHViHvJZkcftYhZcjWgO7hnL7aAZuATLx3iZDltn/rMSTn2kndlwxq1Rtf9zdlDdHaBsrp1TmvyG299kppj7cgDN38yjKj/rhLRNPmT1MjuZh/phy3RFy+5bpueMdTmykuzyTrSYOdUrEo6SD7nt+C3YTU+w1U9I+5j/3Hvb1yMqgudNJzIX/xhG0IV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftI0UFOdkRAQKb5B4qPO0pM2QbqpAezKgmnOuI2y9Bw=;
 b=3L1A6EoDBIytYDkGTkodAFFj2JtiZd12hfUP0GozM5ButOv7xP8hCkxOGb1kBKB3oR5EIThSByAT1UfgBJYJQmkAq/9eeLSKCSQu1VrhaOmVgGJiyNcgObC2PnOzMBV060KY2JPTmQ2Ep08XJYqICISydQTomKUsqq+Jf/1U3tw=
Received: from SJ0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:33a::15)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 17:09:00 +0000
Received: from PH7PEPF00000005.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::c) by SJ0PR03CA0010.outlook.office365.com
 (2603:10b6:a03:33a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 17:09:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000005.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 17:09:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 11:08:59 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 11:08:59 -0600
Received: from [172.19.166.81] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 11:08:59 -0600
Message-ID: <ad484ed4-9b52-4210-99c2-9e035d9f8189@amd.com>
Date: Wed, 4 Nov 2026 09:08:53 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Remap BO pages instead of using
 vm_insert_pages
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20261103190821.2019203-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20261103190821.2019203-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000005:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 51def1ee-cf38-4110-32f5-08df3a9651cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|11063799006|5023799004|261026121527099003|261102130727099003|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: XFHy+1Moqq5Wit//4VPMq02+5k6Vq6FQkw4d3zm0x+mDxpZXg/xL/ANJqdK3XNygT7QvhQitJ2sHtDzor/aOMUyzCd4/BVUyxoOolzu81rqwPHuV2509inh/Sj8LW0eIz0+IDcys1EXjqFyG5jfXrsfc88x8ZLygsZoVcLoRQVTtxMR7wc3NWmJ4FT7ZX4qQGH2xe2ra6+7ZnoA9VWP4ptY02yQV+5DioC3pf8ZMNY8WyhUU0IpDICgibm/BWYsWmJYrZD4QbgBvRQW1PejRLppdLKA323fZ2OY4tY0o+k9w1xA9UpisC5p5QcWCndZz9bnIdNDWjAvS58EN4X6sUTnXrpME4hFC1xjAATqtSeDSJnD1wl0Yjb1Nxwhy/TjN3XikWbmrmS5APr9ptnZIm1lJ1YiidWo/7EqVn8KTqvhyYUwRN2I2G2r+X9tpyNHzU6SEn9W50pddsaoUkgnCVr0zsm1YwZVT07tTTO404TBuCIkBGOyfkFMvVp7+sIVZtxLHkw06bmfhCCZieFrXaeLr+jQppewV2EIRJ8aiGqQGV5JZxNGyLSwroP/cH70BsZMUYfRw0sCCkcJYGEJdjpSsH3XCD91vCq6LIBHiG/IKxkPaDhM3/OMwTh8zfVZWL17I60Pr3ClNjGd745KcBRhGjsW0d02gLz/Bwleem9d2VKtuC7edM4oF8CxrGm8gvWs7ingGo7nyzFEBmzivOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(261026121527099003)(261102130727099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G7Fbc7EsVCIiLAc2XTTpv/AhO4JCrAGdA5t5Zj3P8Vh1iu+J9QOuWff8hSfrznM6gQqriW3pY/6d9LirJTvCafGb+jetaSTWR0hXWyX3iPv2SQh00KhtmgFZwv1tHg+3j3skLX414wbxHD02shMJe7z0pCNNlGj7/bd+3Ct7dAGUMWxr7zE6CtZmOZphqqUWtWZteWDRS0OczPxzP4aa3C4oZJAsl69BUfxiwWWR+ctgvabG7jRmbyiCV8rHAsVrIVSBRGUJK7w8yUhHLbY6r/k5JU1o8IJElYPFoGem5Y1B25v8dqsaQySNqkCcsOLY8JDZ5tSmFeMgtOz89i90ITi0J4G2hI9YgPErKn3uBY+F+MYyEiLKzXRjMKO/Z55u5LNp4TG3ou46gH10U9g8Z5TbMN8kBsbw2uXP8cbKyuYxxIpXQoiv5fOpi1x3f1OB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:09:00.1022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51def1ee-cf38-4110-32f5-08df3a9651cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/2026 Tue 11:08, Lizhi Hou wrote:
> VM_PFNMAP is set for shmem BO to prevent pin_user_pages() from pining BO
> memory. Replacing it with VM_MIXEDMAP breaks this behavior.
> 
> Keep the VM_PFNMAP mapping established by drm_gem_shmem_mmap() and
> populate its page tables with remap_pfn_range() immediately after
> creating the mapping.
> 
> Fixes: df4d5352063a ("accel/amdxdna: Fix unsafe use of handle_mm_fault()")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 157 +++++++++++-----------------
>   1 file changed, 62 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 46b9f6c960d7..09e48c794e1b 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -564,11 +564,51 @@ static void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
>   	up_write(&xdna->notifier_lock);
>   }
>   
> +static int amdxdna_remap_pages(struct amdxdna_gem_obj *abo,
> +			       struct vm_area_struct *vma)
> +{
> +	unsigned long num_pages = vma_pages(vma);
> +	struct page **pages = abo->base.pages;
> +	unsigned long i, nr;
> +	int ret;
> +
> +	for (i = 0; i < num_pages; i += nr) {
> +		unsigned long pfn = page_to_pfn(pages[i]);
> +
> +		for (nr = 1; i + nr < num_pages; nr++) {
> +			if (page_to_pfn(pages[i + nr]) != pfn + nr)
> +				break;
> +		}
> +
> +		ret = remap_pfn_range(vma, vma->vm_start + (i << PAGE_SHIFT), pfn,
> +				      nr << PAGE_SHIFT, vma->vm_page_prot);
> +		if (ret) {
> +			zap_special_vma_range(vma, vma->vm_start, i << PAGE_SHIFT);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * The page tables are populated upfront, thus the CPU never takes a
> +	 * write fault and drm_gem_shmem_vm_ops.pfn_mkwrite() never marks the
> +	 * folios dirty. The device writes to the pages through the IOMMU
> +	 * without any notification either. And the PTEs are special in a
> +	 * VM_PFNMAP VMA, so unmapping does not transfer their dirty bits
> +	 * back to the folios. Mark the pages dirty when they are released,
> +	 * the same way drm_gem_shmem_vmap() does.
> +	 */
> +	dma_resv_lock(to_gobj(abo)->resv, NULL);
> +	abo->base.pages_mark_dirty_on_put = true;
> +	abo->base.pages_mark_accessed_on_put = true;
> +	dma_resv_unlock(to_gobj(abo)->resv);
> +
> +	return 0;
> +}
> +
>   static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>   				struct vm_area_struct *vma)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
> -	unsigned long num_pages = vma_pages(vma);
>   	int ret;
>   
>   	/*
> @@ -587,7 +627,8 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>   			return ret;
>   		}
>   
> -		amdxdna_mark_mapp_invalid(abo, vma);
> +		if (!(vma->vm_flags & VM_PFNMAP))
> +			amdxdna_mark_mapp_invalid(abo, vma);
>   
>   		/* Drop the reference drm_gem_mmap_obj() acquired.*/
>   		drm_gem_object_put(to_gobj(abo));
> @@ -600,10 +641,9 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>   		return ret;
>   	}
>   
> -	vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
> -	ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages, &num_pages);
> +	ret = amdxdna_remap_pages(abo, vma);
>   	if (ret) {
> -		XDNA_ERR(xdna, "Failed to insert pages %d", ret);
> +		XDNA_ERR(xdna, "Failed to remap pages %d", ret);
>   		dma_resv_lock(to_gobj(abo)->resv, NULL);
>   		drm_gem_shmem_put_pages_locked(&abo->base);
>   		dma_resv_unlock(to_gobj(abo)->resv);
> @@ -641,99 +681,21 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
>   	return ret;
>   }
>   
> -/*
> - * VM operations for amdxdna shmem VMAs that use VM_MIXEDMAP.
> - *
> - * drm_gem_shmem_vm_ops cannot be used on VM_MIXEDMAP VMAs because its fault
> - * handler calls vmf_insert_pfn() → vmf_insert_pfn_prot() which contains:
> - *   BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn))
> - * All amdxdna shmem pages are ordinary struct pages so pfn_valid() is always
> - * true, making the combination fatal.
> - *
> - * These ops use vmf_insert_page() (struct-page based) instead, which is the
> - * correct API for VM_MIXEDMAP VMAs backed by real struct pages.  The open and
> - * close handlers replicate drm_gem_shmem_vm_open/close using only exported
> - * symbols.
> - */
> -static vm_fault_t amdxdna_gem_mixedmap_fault(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct drm_gem_object *gobj = vma->vm_private_data;
> -	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
> -	loff_t num_pages = gobj->size >> PAGE_SHIFT;
> -	vm_fault_t ret = VM_FAULT_SIGBUS;
> -	pgoff_t page_offset;
> -	struct page *page;
> -
> -	/*
> -	 * Partial free of vma is unexpected. Otherwise, the wrong page
> -	 * will be faulted in and the user application may crash itself.
> -	 */
> -	page_offset = linear_page_delta(vma, vmf->address);
> -
> -	dma_resv_lock(gobj->resv, NULL);
> -
> -	if (!shmem->pages || shmem->madv < 0 || page_offset >= num_pages)
> -		goto out;
> -
> -	page = shmem->pages[page_offset];
> -	if (WARN_ON_ONCE(!page))
> -		goto out;
> -
> -	/*
> -	 * Use vmf_insert_page() (struct-page path) not vmf_insert_pfn()
> -	 * (PFN path) because this VMA carries VM_MIXEDMAP.
> -	 */
> -	ret = vmf_insert_page(vma, vmf->address, page);
> -	if (ret == VM_FAULT_NOPAGE)
> -		folio_mark_accessed(page_folio(page));
> -
> -out:
> -	dma_resv_unlock(gobj->resv);
> -	return ret;
> -}
> -
> -static void amdxdna_gem_mixedmap_vm_open(struct vm_area_struct *vma)
> -{
> -	struct drm_gem_object *gobj = vma->vm_private_data;
> -	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
> -
> -	/*
> -	 * Bump pages_use_count so the page array stays alive for the new
> -	 * mapping copy created by fork().  Mirrors drm_gem_shmem_vm_open().
> -	 */
> -	dma_resv_lock(gobj->resv, NULL);
> -	drm_WARN_ON_ONCE(gobj->dev, !refcount_inc_not_zero(&shmem->pages_use_count));
> -	dma_resv_unlock(gobj->resv);
> -
> -	drm_gem_vm_open(vma);
> -}
> -
> -static void amdxdna_gem_mixedmap_vm_close(struct vm_area_struct *vma)
> -{
> -	struct drm_gem_object *gobj = vma->vm_private_data;
> -	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
> -
> -	dma_resv_lock(gobj->resv, NULL);
> -	drm_gem_shmem_put_pages_locked(shmem);
> -	dma_resv_unlock(gobj->resv);
> -
> -	drm_gem_vm_close(vma);
> -}
> -
> -static const struct vm_operations_struct amdxdna_gem_mixedmap_vm_ops = {
> -	.fault  = amdxdna_gem_mixedmap_fault,
> -	.open   = amdxdna_gem_mixedmap_vm_open,
> -	.close  = amdxdna_gem_mixedmap_vm_close,
> -};
> -
>   static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma)
>   {
>   	struct drm_gem_object *gobj = dma_buf->priv;
>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>   	int ret;
>   
> -	vma->vm_ops = &amdxdna_gem_mixedmap_vm_ops;
> +	/*
> +	 * vm_pgoff is the page offset within the dma-buf, see dma_buf_mmap().
> +	 * drm_gem_shmem_vm_ops indexes the BO pages by the page offset within
> +	 * the VMA. Thus the mapping has to start at the beginning of the BO.
> +	 */
> +	if (vma->vm_pgoff)
> +		return -EINVAL;
> +
> +	vma->vm_ops = &drm_gem_shmem_vm_ops;
>   	vma->vm_private_data = gobj;
>   
>   	drm_gem_object_get(gobj);
> @@ -741,11 +703,16 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struc
>   	if (ret)
>   		goto put_obj;
>   
> -	/* The buffer is based on memory pages. Fix the flag. */
> -	vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
> +	ret = amdxdna_remap_pages(abo, vma);
> +	if (ret)
> +		goto put_pages;
>   
>   	return 0;
>   
> +put_pages:
> +	dma_resv_lock(gobj->resv, NULL);
> +	drm_gem_shmem_put_pages_locked(&abo->base);
> +	dma_resv_unlock(gobj->resv);
>   put_obj:
>   	drm_gem_object_put(gobj);
>   	return ret;
> @@ -1043,7 +1010,7 @@ static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
>   	.vmap = amdxdna_gem_obj_vmap,
>   	.vunmap = amdxdna_gem_obj_vunmap,
>   	.mmap = amdxdna_gem_obj_mmap,
> -	.vm_ops = &amdxdna_gem_mixedmap_vm_ops,
> +	.vm_ops = &drm_gem_shmem_vm_ops,
>   	.export = amdxdna_gem_prime_export,
>   };
>   

