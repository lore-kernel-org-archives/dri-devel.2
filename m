Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C278C55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A51810F3F9;
	Fri, 31 Jul 2026 20:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w1doJR3j";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2E710F3E5
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 20:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ5DNNgGwWJ4oxsL2uu4Z2ZxUifbHZa1AtsOH80QhYWOH7yMQYksTqf0X6VFDHA/RJUpHLbMegDgpDMH3KQsqESPwN0+Nnbpqt5hkjQ/7Pqqh3lUQiQFHTd72vNNQ63FFtsyC2/uN7EVASh/eVuUGKQ6ES3Z7xqmNdC8CNEnpHEqh1g5J04D3vtUHs+QQffcGO7C27W9eOsHBlPiGG3yQgtfRZGO8CUM4y17wW5tx/jCj/DY0POGCDZas70iv/FCMn6zPfss1OsoFS6h4dIaY6yk+g148W0pWT1aSpNxWGtUULdEicMuolB3aJEB8U7/x7lBvmVHN+w+wviPVKkjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4YNb8NhQTpAkmHGvobaPAbcGXY+Lcuo5Fd3JaOEyAM=;
 b=VBRElA7jR9ml93fLOtjOYE+PJLH+N6tJdNqIWl0aK2TqTVtGAGv4qgQG7xd/XQKoKJAIlgHtV5W9BF9V0hvPCZienH/nDcoJQ7emDFB9vuxo7bX+koFJRrhsP2izfuVmSSgBdfT3owS59gYSdcrXQ54Vd0aGJTbZw/Mpws75Hqrj1pX4h7WD8xiNvw9UTD+Tg59Jo2xGuhnsU3rHuU7S5sxVFmuKYETP4e3N6LLOhklzvi6G+yToegC82kui0KKAtrJZzbCRyvbUF2SUvk807sw4j3O6a3svYa14bPw62QjKDFupJGcZa2tBz3MP1+QWr/FJGAydMk0/BLr4hKvJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4YNb8NhQTpAkmHGvobaPAbcGXY+Lcuo5Fd3JaOEyAM=;
 b=w1doJR3jWiZl0JAK0OTd7u1yzrW8FYTE+tiGNmrQ4hALAIbcj+QkxTdSIW/Q7KPaRwyJDQ1MCIaV2yqqpJKB/S6cycZ+CodHHmqfl4pMSfWXPf6Z1J5goWbGrATKmJwnpzxJbB2J1hG5fG5DEm6Nft1hp7sG83NzvAgO/ULTbeg=
Received: from SA1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::28)
 by SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 20:59:34 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::95) by SA1P222CA0021.outlook.office365.com
 (2603:10b6:806:22c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 20:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 20:59:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 15:59:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:59:33 -0700
Received: from [172.19.68.215] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 15:59:32 -0500
Message-ID: <2b118f6a-f672-4e91-bb53-30431cfcc0b6@amd.com>
Date: Fri, 31 Jul 2026 13:59:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix locally exploitable BUG_ON in
 amdxdna_insert_pages()
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260731185955.3449311-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260731185955.3449311-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7cc408-9099-4612-4e2e-08deef469fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|3023799007|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mgcLzw2AppLuL+tsKRTGKxjLRG4edNU7n0ed/b7WL8O60DFknnH+SjXIjzOxOy4IEm2rc8+NXJvmx+m97Uyh+7IAvkC+sRX1jDM0ZbFECZwyRtmWmhT9lR9RXpDzQVvva+YYmT3nqrrI+5h7ioc34+dNfPfiBuCgOO4jhkaY+i7H1ha0AMCgKumzj+b5qjBpoUW7TbDcKUIN9uoganse2GPo2ISV4NR0RrrMJxAsUQPCpyLc359MnfHOndFetD6RUqfWdx5NBPyd1Kr+bWJ159gsYdRu6JKoxz++b7mQ7XvS+P2Wicn/sN4wvqM4nM5gRBRn8qf9Y/XpAdDZ6NFLtPke7z3qkaTthm7it8rWPHhZw/XbjZd6/2Zsg1gW4jFdmI4/D4cicOOWsuzDZSCoVn2z1KDneCRpvYtaA/2szcXhju0tfwOnDhY3hmEX1wgNXeRu3GxArkjOcVRNlZbMp9R3cYoweO8jw3zp/GT/5ZTKc73mIdoVcDk1funsYzl3UC2DijOjemQK0M2Rsxuc8ucHNurgOApmJADjxtCvDrNIfwls/snI9Bbv23MTXMogpyoFF/i3tfs3KFpNAiZK9uYpLRSV8UmmJ6EnCNo9fzML2xNeQr+HJBoQQSUUP2OE+TOwnf8wSZ/Fpuod4xgnwRZ6EFK+tN7TqGFhtXDeKQT/UJEl94pDW3XKI31s/G9Zh9tHmLZM2P56+apcXx6/uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(3023799007)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XdjmKdiuP0KsgnHNM2PWjje2GWr3l5jAJ/fPw6e8lCSzwS0Ya36dui1Cyd4L29lNNgO0spCz7pkNAQGUWtTyrpkU+t6v3+iXa5gPgQ406FBKH9QjVodx8G2B2MtRviXAJ8GEYJQWIRruBtc5HdWC9VIsLCAzg5NVXZeGQrr/MUh3nRP+xsQSUKYlWtXqMPYyCm0ccLqsfr3o7QtBTcTXLoGsjitH501FN5oP4Z0gB67nbAi38NXyRp4hWIZ0WcLJ5Tme2FKSPGjYB7ZJc+r2dhXgQTiCQx0AZJq3yRXbS5eiO6HPs3P+FEfc5skgu102wY9puQfotnFT0HKX+ZLaQ8JqQLaeh1XBoseVsSv0gM8uHvZBUyM6QaIidb+f4oUJmGo9WC4BJzl2LeOyh7jsh56yCd6U9occVG356ALd/MP/vB+J4m3DjpQ1NVj2Fttk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 20:59:34.1431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7cc408-9099-4612-4e2e-08deef469fde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035
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



On 7/31/2026 Fri 11:59, Lizhi Hou wrote:
> In amdxdna_insert_pages(), vm_flags_mod() sets VM_MIXEDMAP and clears
> VM_PFNMAP. If an unprivileged userspace process mmaps a non-imported GEM
> object and then calls madvise(MADV_DONTNEED), the PTEs will be
> successfully cleared because VM_MIXEDMAP allows this (unlike VM_PFNMAP).
> 
> When userspace subsequently accesses the memory, drm_gem_shmem_fault()
> handles the page fault and attempts to map the backing shmem page via
> vmf_insert_pfn() which calls vmf_insert_pfn_prot(). Because the backing
> shmem page is normal system memory (pfn_valid(pfn) is true) and the VMA
> now has VM_MIXEDMAP set, won't this predictably trigger the explicit
> assertion BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn))
> 
> Fix by removing the vm_flags_mod() call and replacing the vm_insert_pages()
> pre-population with the handle_mm_fault() loop that was already used for
> the import (dma-buf) path.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 27 ++++++++-------------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index aec69d5f463e..1c63eff0a4a8 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -467,25 +467,17 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>   			XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
>   			return ret;
>   		}
> -
> -		/* The buffer is based on memory pages. Fix the flag. */
> -		vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
> -		ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages,
> -				      &num_pages);
> +	} else {
> +		vma->vm_private_data = NULL;
> +		vma->vm_ops = NULL;
> +		ret = dma_buf_mmap(abo->dma_buf, vma, 0);
>   		if (ret) {
> -			XDNA_ERR(xdna, "Failed insert pages %d", ret);
> -			amdxdna_mark_mapp_invalid(abo, vma);
> +			XDNA_ERR(xdna, "Failed to mmap dma buf %d", ret);
> +			return ret;
>   		}
>   
> -		return 0;
> -	}
> -
> -	vma->vm_private_data = NULL;
> -	vma->vm_ops = NULL;
> -	ret = dma_buf_mmap(abo->dma_buf, vma, 0);
> -	if (ret) {
> -		XDNA_ERR(xdna, "Failed to mmap dma buf %d", ret);
> -		return ret;
> +		/* Drop the reference drm_gem_mmap_obj() acquired.*/
> +		drm_gem_object_put(to_gobj(abo));
>   	}
>   
>   	do {
> @@ -502,9 +494,6 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>   		offset += PAGE_SIZE;
>   	} while (--num_pages);
>   
> -	/* Drop the reference drm_gem_mmap_obj() acquired.*/
> -	drm_gem_object_put(to_gobj(abo));
> -
>   	return 0;
>   }
>   

