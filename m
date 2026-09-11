Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA81C88E41
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 03:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855EF10E030;
	Fri, 11 Sep 2026 03:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HuY46CYB";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF6610E030
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY0W+J8RQ1gEtpNz/d5D1DrYh3vgCF9IUjPVZJbwIld1I43hsAL5OGQgBF/xEeZD8QleKIZLCeYJ8YB05mZkdlAxgMMOSl6oHaTexJYlo6RdbVvtSiUcoHV0Z1mq1KoTUFmD96Md6z6UA93Pq8yrokksoxxbFrZJcEMNfTy3WQ/0pquxSUrgEQvyWuyTMRgwWn8l+7YDkjX3LfMZFPc+xSXSJtSkn3GKoD336AsdM/dd7JmVYSNKBg6EcE9IjEuQwEOmlwz369fXehZAcH8OkxQrnc3kMevxvFZlo0m+ZqExqeOhL8W0gB3l1gTir3sLNn7gJB0/byY1vP3qNyaslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcB2ztgKCVpqFBLO1H2pVRlM8mAJo4LrgM4iIbsbOIA=;
 b=Ya3oko0tEvEfAmGuvfdcP2MPodJEwCqpaysiV8QCw0Gc83OmAuMTvYx6+yYIXIo5bp4yvzdasjz9CbMVY58hyhE56YFKRMUHho+7nU0NtiJgE+83BbmLbpmcPxZGDWcmWYfY8DpqPtFhyZk0ZlomSe7EcaR8Tc/ckCXquqa8trszoq9NlxOxbYpTcrcAXdPJmrJFleJBIdlGPSQ66ZHS5UVDbJ68j/Ead2VvrxijhlPRlVVwEMd5TUQfDowMICI0quXTbYDDIl9Gl5iG1SH8vaGuNnfzqCiN2p3Ki28DPyHA+FFLL6okd5FbZ4wO1VOiM+8pM3LKY2IQRAPXet6FBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcB2ztgKCVpqFBLO1H2pVRlM8mAJo4LrgM4iIbsbOIA=;
 b=HuY46CYBnEtTrcSpdyRgqsRDV+PGyjBhX/sxMVtn3xnQsw3at0I7XJbf2ofnXlOrEGbyAuk8RdtA05BVEPWi3S13yQvm1OlNrKqEHCbljPLuVy5ormPBuWDoZkyDWCvwl9UmBU6bTl1xJhZMiB1E6RWmNFVLGNwl+TeS2Cd2y00=
Received: from SJ0PR13CA0121.namprd13.prod.outlook.com (2603:10b6:a03:2c6::6)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 03:24:14 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::27) by SJ0PR13CA0121.outlook.office365.com
 (2603:10b6:a03:2c6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Fri, 11
 Sep 2026 03:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 03:24:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 22:24:13 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 22:24:12 -0500
Message-ID: <b1966a10-5f9b-a13a-2e76-38f602608ccd@amd.com>
Date: Thu, 10 Sep 2026 20:24:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3] accel/amdxdna: Fix unsafe use of handle_mm_fault()
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
CC: <dri-devel@lists.freedesktop.org>
References: <20260910211338.1102315-1-lizhi.hou@amd.com>
 <20260910213345.01F4C1F000FF@smtp.kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260910213345.01F4C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a31247-5627-4828-2e6f-08df0fb42719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Jt7/lXbA8fLQEM+r4WlTgw6Xe9TILuE1UNpHnIwJJF5tu45mbCxuvATAvLdstf6C2MLfTK51vDFAGYy6Y2leYipc3H6wIMPWGctq/poHJ/pLAEguafTpntoHFrYHJRDnySSc73FJLy1vRVqwSL0MsJvRjEi+x6DrAvsXnuYj6Szkx8qbu1B9mKpx8h+Eec0S6TJGCKHt/NFesBkk2O+cYEEKlzDJolNa70AhOxEKm4S6zIXTAxOEPCzSAcxIgRNgDNB6QZvHuCBsxdycKHGp6FOjuGEqZSSSx4CL17EhY9VPqVt7S6FkaBvclfZWMVrbsGwUd653AGrXe7PZpmf89QMSYRbFmH7nKpzJ2ePk7PZdii670q4ONhUoYcb6kIzWXq2nGFudR+sOpbkr8egnALfKRKmTVW9EK6GwyusPE/ItxK4EntiSBrT6D+CJEy+Qp8r6a2MC79lXRRHuUnWL5uoC4jtBbUMxv7f/AGKfXUOXbdnR+BVfB9T2YkxyFHzOVk0+QbxIRJ5wbuJiFaxVhzzXVtXW6ugDEshFzwE+f6y0v+K2tLxdCT1fB9ekAcd9e0BiolYB0fLWPwSThTFFuQT0TMVlDSuRNTCujPEY252+JdiQrqyw20oZQ5RIfC9Y49raVsKkYSmenkyL/cT66ffMe+3QJPLMr1qj9iD5U3uvw1I+vR3VWjtsMNpM0rgI4rl8IS51TpVwfzR+7iEyBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BGIV+yhYQ8jtSMUs/3yssvHcOiyNmuooxzN3LPsxRTNniBw2x9LwHRXIjD/NGMXiONkLYEcEm2x/Pj1u77816lKM82Q5kNDENmMOBbtiyUPpV1Kl/8wjp6oAXxmNgCuDkQTIFNPyVxfm8kr8kc/Xkmzr2wrFycT32RNjHB+MILk3GydSIzf9pWhAOlyU7/r5L7a5MJebNMJ29ArLy7W6v6p5xWeYhdft9QyrxX7uhQYSVDN5PGlupPoLJIQla71kHkEOe0f5o5GkkGShMcE2mtUhWelZs7i5htWj9V+5S57XABdvSnwIJPMT+jSfIAkTx0MmeZHTzX0E/jWkLFrQ4nTbh4kXBFD165r9yCLAbYXbGVsy3xV5BMRzQocVI5WsF0NZ0U9Cg7Gl8iNgNMp2RX4va2uSuoy0iqNT8cO0XZnZvqQNMmZbzTWEI/Ak3NOg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 03:24:13.3049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a31247-5627-4828-2e6f-08df0fb42719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519
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


On 9/10/26 14:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Flawed VMA offset calculation in amdxdna_gem_mixedmap_fault causes data corruption on VMA splits and DMA-buf mmaps.
>
> Pre-existing issues:
> - [High] DMA-buf mmaps bypass HMM notifier registration, causing missing pre-faulting and unsafe page table teardown.
> --
>
> commit 5de79a60bd0ef403c4515e6d277ad3386e515ac9
> Author: Lizhi Hou <lizhi.hou@amd.com>
>
> accel/amdxdna: Fix unsafe use of handle_mm_fault()
>
> This commit removes handle_mm_fault() from the mmap callback because the
> VMA is not yet linked. For imported BOs, it marks the mapping invalid and
> relies on the first command submission to fault in the pages. For shmem
> BOs, it sets VM_MIXEDMAP and implements amdxdna_gem_mixed_vm_ops to handle
> the page faults.
>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 3f05fa8811af1..f07f63a194537 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> [ ... ]
>
>> +static vm_fault_t amdxdna_gem_mixedmap_fault(struct vm_fault *vmf)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	struct drm_gem_object *gobj = vma->vm_private_data;
>> +	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
>> +	loff_t num_pages = gobj->size >> PAGE_SHIFT;
>> +	vm_fault_t ret = VM_FAULT_SIGBUS;
>> +	pgoff_t page_offset;
>> +	struct page *page;
>> +
>> +	/*
>> +	 * Partial free of vma is unexpected. Otherwise, the wrong page
>> +	 * will be faulted in and the user application may crash itself.
>> +	 */
>> +	page_offset = vmf->pgoff - vma->vm_pgoff;

This should not be a bug. When I merge, I will replace this line as 
other drivers do:

     page_offset = linear_page_delta(vma, vmf->address);


Lizhi

> [Severity: High]
> Will this calculation cause the wrong pages to be mapped on VMA splits or
> non-zero offset DMA-buf mmaps?
>
> Because the core MM computes vmf->pgoff as:
> vmf->pgoff = vma->vm_pgoff + ((vmf->address - vma->vm_start) >> PAGE_SHIFT)
>
> The subtraction here cancels out the VMA's logical offset, causing it to
> always yield the offset relative to the current VMA start. If a user mmaps a
> GEM object, unmaps the first half to split the VMA, and then triggers a page
> fault on the second half (e.g., after MADV_DONTNEED), could this erroneously
> map pages[0] into the middle of the object?
>
>> +
>> +	dma_resv_lock(gobj->resv, NULL);
> [ ... ]
>
>>   static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma)
>>   {
>>   	struct drm_gem_object *gobj = dma_buf->priv;
>>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>> -	unsigned long num_pages = vma_pages(vma);
>>   	int ret;
> [Severity: High]
> This is a pre-existing issue, but does amdxdna_gem_dmabuf_mmap() need to
> call amdxdna_hmm_register() here?
>
> Without this call, the VMA is not added to the HMM tracking list. If a user
> exports a BO to a DMA-buf, mmaps the DMA-buf, and passes the virtual address
> to the NPU, the driver might fail to pre-fault the pages before execution.
>
> Additionally, if the user unmaps the VMA while the NPU is active, could the
> lack of an MMU interval notifier bypass the driver's teardown stall
> (dma_resv_wait_timeout()), allowing the CPU to tear down page tables while
> the NPU is still executing and causing IOMMU translation faults?
>
