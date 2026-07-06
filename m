Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6453C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35AB510E3DA;
	Mon,  6 Jul 2026 22:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qd/W+5D4";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC5B10E3DA
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adIFe+wGwdGwrFZPllt8YtS/ZClEtjZv68qY5eeHtUmUpi/K6FOM/R+PvZ1WzY9loy+3ihZYQv9izstWBmVpqDPE1G5bfCOsQ0YyIoz59Phmyon6FvUWA+rvwPA+o0UiOMTdyfN4XRo+WSU3Kip37N3pIUF1neWZBFBi4vVYHJLuoUCLu0xEUmhQmQUfGvrqcSLpKM05DPRGS/q91Nq+UuGKdBIbbqbOYeHQZ/zt0WoDjZ6pMqQZX9PmbAj6YjH0QMU61Own/HEA8l0ar6zY0ha+A7KHhIKvgzjjZbXJPB8aSr6PgOMm5byhWeAgoHAloyBYpFDR0PWjgd2rw4j+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqbDsOS5VZbK07bkPxaqArgH6+92d9XSeBjIpU2njgc=;
 b=fWSVEJDSYLz0LbMGvP97Xrjz1bGgobkGYnm+8/z04xvWcUPSifvprp4QhLvCikgdXPD7PAMNBjRstd3XdqmMaMaFFXArjL9rZJKr9AFvoWpJwjTSmyZvWi5mbix9bmf8vdk670z6xgC8BfKU9zLOvcXiuNmBT+f/a3Ai6eZ+F5jT5ileNGclBCFgzIfjyz3B4ZF1acucy6sVa6/jJ04p3CDd9uO9Um91Gj+3NAkRvouYGPxLU/fHHfwMl5w1W15xcL+nIQMdo8wQpFkiEIyfMHIcNtVFtBGNHFj5qy91rJq+aHETgjhXYeQyAFfbzrWqOthJqT3/caY+kGksXfH4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqbDsOS5VZbK07bkPxaqArgH6+92d9XSeBjIpU2njgc=;
 b=Qd/W+5D46/apSGjuKz2jj5PQZhM7W8T1XqmQzcBJtsD+emo+xjKWj8ifByB1bWlHtB3xTwNgKzppd6lkOnwrvx7cAUzIeEzRhQRWdac139NvguiPOYTu2W9hqr9LIoLRHMTxuKSkHetVH060BQmlagvNnSDY9aADRg7eQTTZuVo=
Received: from BN9PR03CA0556.namprd03.prod.outlook.com (2603:10b6:408:138::21)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 22:40:44 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::26) by BN9PR03CA0556.outlook.office365.com
 (2603:10b6:408:138::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon, 6
 Jul 2026 22:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 22:40:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 17:40:44 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 17:40:43 -0500
Received: from [172.19.70.117] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 17:40:43 -0500
Message-ID: <6d4b8db5-0212-4af7-9a2a-e8ed73ccdf03@amd.com>
Date: Mon, 6 Jul 2026 15:40:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] accel/amdxdna: Fix VMA access race
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260609011242.2833740-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260609011242.2833740-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: f669fb2a-f4b9-47a6-37eb-08dedbaf9d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hQW9TqEK3NvlCjqhKVuKRAoz9dHfjw3dC8+ou/oPtDw7thN+TT8F3eN77i0CGZZw3lGJFnJESKqPaE9eDVPN5Abdtkyiiv1W3EBHjUENpmVsviOpxd38l6/9ZP3Blg9dfoNsTPfyYP6+cns3cE+5ovJTutqfR2c03XHXN1euSwJCQFlNn/0CvH/qX3Uj8M0MAicKdMDEKN2zrnOisPv1J/A/VbmmnTPOhl6EPTW+Ey29QyH3t6PuSRH3EtN+5QZ52zRXwswnpzFwfq9noEy7TAxmHEHcKrs7IWR2Z5X9Qy4KWUDZbHhXM5/orN3JvV80oz+3rl2WtfkEjZGONgVPWJCYNUIzmhJqSRs70h4goJIyLj8cmng4dfB2j1E1vifZrYAh0qwV0zBjmDIrPxwgcpu2W5Dd04F8Dm33ye+yw5JlU81VXbRlt4Zll/f849AntYi8VluAdQKpjDXQ0t1j2yMkWKTiqbx2SduhqdW7iuGpxVEDs02FEO7+zAeypZPD27l+PP4s2EZexD0wR2Ekv0u1Xbo6hEGWnOwvPAch3znJzEFTCgqg7qS12XBpMx2jPmpRDLT7fd/05C6642JOBG2JfPMSTshnZA1L1V46CwiLL5LU0Jrzvxt0uZoLmGkpnZC/keEq2zcTxOMEsnbwnWqbMPr8ZFN4kyd+49RTG5ZrlYEcsIFUsD21cClp892lBo/nE05kFRWrwxbfoPUCQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OvNpO93HSnmSVBc9XwLaM/m2ThZTTdstqdNt2g77j9P7Hatlt6vtSfMxsIWtl5cNz3hexjBa2bIo+uudEK4y6ydDoWai+Nk5Wv6SlSwZlN5zmF67rxh/LnsFvR4HysJXTQxs1CTn9UJsJHmdEnsP0zLuB1MeMIPk8e9YifNg/uNU157f/EcDqfUfyq2MWHlgbeMs+1LnT4bQwabA0GYv5xTdY9nMfMPAzO1I1UAGN61OwWkYMjlgN5lHjGqj/fSE0sbx0hAEXvJV9nRKZkXnCZdU4x2w78i1B4wiqsafnq9m2hQnGz84Vf8rhAp+6ZaRQk1tBZ9qta7NUAmN692/oP5NoEd6qawNr6b71PeCxe0Y+idX5pl0IYa4ucJLdexdEuIpMIDSmnIrQ8AshxtbIjECTzhb77v90DdCBwEcF8cEMbF0fnc86NJS8eOcHFMZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 22:40:44.2006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f669fb2a-f4b9-47a6-37eb-08dedbaf9d90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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



On 6/8/2026 Mon 18:12, Lizhi Hou wrote:
> aie2_populate_range() and amdxdna_umap_release() access a saved VMA
> pointer that may have already been freed, leading to a potential
> use-after-free.
> 
> Remove the VMA accesses from these functions to avoid the race.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
> V3:
>    fix sashiko comments: error-path cleanup patch race
> V2:
>    fix sashiko comments: Use-after-free on `mapp->vma`
> 
>   drivers/accel/amdxdna/aie2_ctx.c    |  2 --
>   drivers/accel/amdxdna/amdxdna_gem.c | 31 +++++++++++++++++++----------
>   drivers/accel/amdxdna/amdxdna_gem.h |  1 -
>   3 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index da89b3701f5b..3e21e2dabe82 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1023,8 +1023,6 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>   	kref_get(&mapp->refcnt);
>   	up_write(&xdna->notifier_lock);
>   
> -	XDNA_DBG(xdna, "populate memory range %lx %lx",
> -		 mapp->vma->vm_start, mapp->vma->vm_end);
>   	mm = mapp->notifier.mm;
>   	if (!mmget_not_zero(mm)) {
>   		amdxdna_umap_put(mapp);
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 63976c3bcbe0..20ce304b19ef 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -254,7 +254,7 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>   
>   	xdna = to_xdna_dev(to_gobj(abo)->dev);
>   	XDNA_DBG(xdna, "Invalidating range 0x%lx, 0x%lx, type %d",
> -		 mapp->vma->vm_start, mapp->vma->vm_end, abo->type);
> +		 mapp->range.start, mapp->range.end, abo->type);
>   
>   	if (!mmu_notifier_range_blockable(range))
>   		return false;
> @@ -284,15 +284,23 @@ static const struct mmu_interval_notifier_ops amdxdna_hmm_ops = {
>   	.invalidate = amdxdna_hmm_invalidate,
>   };
>   
> +static inline bool compare_range(struct amdxdna_umap *mapp,
> +				 struct mm_struct *mm,
> +				 unsigned long start, unsigned long end)
> +{
> +	return (!mapp->unmapped && mapp->notifier.mm == mm &&
> +		mapp->range.start == start && mapp->range.end == end);
> +}
> +
>   static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
>   				   struct vm_area_struct *vma)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>   	struct amdxdna_umap *mapp;
>   
> -	down_read(&xdna->notifier_lock);
> +	down_write(&xdna->notifier_lock);
>   	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> -		if (!vma || mapp->vma == vma) {
> +		if (!vma || compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end)) {
>   			if (!mapp->unmapped) {
>   				queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);
>   				mapp->unmapped = true;
> @@ -301,19 +309,16 @@ static void amdxdna_hmm_unregister(struct amdxdna_gem_obj *abo,
>   				break;
>   		}
>   	}
> -	up_read(&xdna->notifier_lock);
> +	up_write(&xdna->notifier_lock);
>   }
>   
>   static void amdxdna_umap_release(struct kref *ref)
>   {
>   	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
>   	struct amdxdna_gem_obj *abo = mapp->abo;
> -	struct vm_area_struct *vma = mapp->vma;
>   	struct amdxdna_dev *xdna;
>   
>   	mmu_interval_notifier_remove(&mapp->notifier);
> -	if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
> -		mapping_clear_unevictable(vma->vm_file->f_mapping);
>   
>   	xdna = to_xdna_dev(to_gobj(mapp->abo)->dev);
>   	down_write(&xdna->notifier_lock);
> @@ -355,6 +360,15 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   		return 0;
>   	}
>   
> +	down_read(&xdna->notifier_lock);
> +	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> +		if (compare_range(mapp, current->mm, addr, addr + len)) {
> +			up_read(&xdna->notifier_lock);
> +			return 0;
> +		}
> +	}
> +	up_read(&xdna->notifier_lock);
> +
>   	mapp = kzalloc_obj(*mapp);
>   	if (!mapp)
>   		return -ENOMEM;
> @@ -380,13 +394,10 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	mapp->range.start = vma->vm_start;
>   	mapp->range.end = vma->vm_end;
>   	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
> -	mapp->vma = vma;
>   	mapp->abo = abo;
>   	kref_init(&mapp->refcnt);
>   
>   	INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
> -	if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
> -		mapping_set_unevictable(vma->vm_file->f_mapping);
>   
>   	down_write(&xdna->notifier_lock);
>   	if (list_empty(&abo->mem.umap_list))
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index a3e44c7a2395..a35d2f15d32c 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -12,7 +12,6 @@
>   #include "amdxdna_pci_drv.h"
>   
>   struct amdxdna_umap {
> -	struct vm_area_struct		*vma;
>   	struct mmu_interval_notifier	notifier;
>   	struct hmm_range		range;
>   	struct work_struct		hmm_unreg_work;

