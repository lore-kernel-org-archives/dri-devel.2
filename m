Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9D5C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F05410F1A0;
	Thu, 23 Jul 2026 18:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JI+plypv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D5C10E076
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 18:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyP8B636RZCukl2fhP18o15CkfndW2mUmyBHOVIkCzONl7bSErnuWsJdCZLRlGCcU+CpIJqbey/ZLkE9BcFLnM3v5qRk9Xb6d7m+keo5N/KLcaUf6gwV+LAsu+rupuhz3KKxpiqA56b7ZmKnDuL3Dw3HMyO8eTxMR8jkIlDO6nJogmsICui/Mjp0BXlzdKS1dLwa67w64m7UQZyAloIS1vo25Z92BK6wp2/fk5UfUK1IYGaeLpVIETCQjUPriRcYJYXFSy/jvF9ry50GWYTqg0HLAYGDjHFP15LwnBbrrbUVCwIJW/WDehoNMkCoA0IvQI6ojVgAiaPc7sYnWhhacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vZpXDZ5MfFvJHa6z78WBMi3wKS3rhPCTxRSU013eU0=;
 b=ArYV67aRc4J8ZjFfjrlZICaMu7o3FHEPVd3MxnyzVqmB+HdtLVZYlHhGXet2aOXuG+Wb117HjB9JbFD7xw6ZPe/qvxkUBiljmR7NNcrEEO+/4i1nd4Vv6yJSyeYR+mPgZlMxF7Vp5dRXfRJDUL6qli3sFexgvrxibJTe+op9C9b8jtS+9wb4Y157w63zYzTANsVPFX+TIxZz6tQogyawIsJZZP3XNSRb9A04ksKIePw4WJx/l+IKsc1gdcRJMAyNPXefdhFfbPoC3SdPg1mGwTHFs6APfOa9DWCkRmeP1khurBAqTafrR1S0PdRb/M4ufHsHHbFOs/G7je8vOz8j0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vZpXDZ5MfFvJHa6z78WBMi3wKS3rhPCTxRSU013eU0=;
 b=JI+plypvuLAsx2LDFFRGNFKhmCesa86pRztDthmLIxd46X92rBjmcz86DsWI3o+WSAhOKxS79nfUg2w4QGR/BzNQbiisSfJTRYpFAkKJmcArcAmiZ7wYzf5aglbymInw77oSCzsweRLQCuGiy2wJ41gFPvfC7PdP90co5+54FpQ=
Received: from BL1PR13CA0442.namprd13.prod.outlook.com (2603:10b6:208:2c3::27)
 by CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 18:03:02 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::33) by BL1PR13CA0442.outlook.office365.com
 (2603:10b6:208:2c3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 18:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 18:03:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 13:03:01 -0500
Received: from [172.19.70.105] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 13:03:00 -0500
Message-ID: <b414f3d5-b88d-4bb1-9d28-917348506e57@amd.com>
Date: Thu, 23 Jul 2026 11:03:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amxdna: fix page-insertion errors in
 amdxdna_insert_pages()
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260723074256.2435143-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260723074256.2435143-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 0baf9e1c-6d7a-4fe0-4b54-08dee8e4a303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: h/lqqNBSyuXEjZ5p//T6XBxIn9daube20a2wpQO/cidmS2pzoQVJXM2fmXY5KK0MjT5zBuhEVOcJbPKEKIHtk/4WIC1aykRuVBOPAgTBD9E6YB0scXHLo2SQ0HxamJ4uaiPAsthyhNb5TwOR8Pdg0usDB48U9FYSKF3O1hfQd/yeVtUPuRnDWZxNRFTy3EWdtUzbr7MBQQty0u3gDOkLIathLj03ogpVrvKBzkL0c6/EOKAIuWNNxWC7hwvJ3FxKLVX9kFVhpLasoFNBcXwm7e0NNE8aHkt71BENhxdYeH/SuN8gn2EXgqBzlhpLsdbuatpsAZUAJMIzCSY6FSaKg27FC+V1AlI3DtJ9aiSgpV4uKlptcCySx4vEAmq/VRWvJj1toEMtEOXzzQcU2Th9/2fKBM/uQRUg2EJBflfM3fQiE40hSEZk9v/hT9G9CdKOO5EBfCWz0DT3v8O4ls5uGjxXHPWuMPbMGQ+mE9bb0QZ+M31LPl+SxZgmyRrKn+4gbkEklroIqqqADWE8+f4INcAm0xqcG2fTnrDqpMohXjnKjRN440RNGvSdZQjpQThTO38KL4jryb4YRSGBwjMKByg+PyluCFf0ubNn3knhIa7su33X3rjDscaRMYWoJGVYBzXY+106J2mDKleGKS3OmEWeu5zbF7uMsM9MxPMETp72FIKBs2NqwSKjztaq3X5FH3qdMqIO2XC60ovYkIXABQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d1sBrA36NXVwKeGid5/pr0kAv5r8VcdFdogFIKjzlklKp5JMz8V+o9DJ9qN+L38DLq8i0UiX4yibGsnejjRgeAPMwWlZ4qgkAe1uc2ffIw44g0RMCJeUNn7SukMya77Hv4YSko6NUaTtWL3hLMRcVGmutXzmumLZ7jWmPcA4GGqOhd0EvR68YBqPhsLWP4i9BpNczRSLV3sfNGFIT0TiXQERxYIJM162YmSW+/Se0coE2FvLWGfoiEZcRYItY4w5b6imXoJcayv6YKHDM+Ac8RcaL3ap64vBQhpqDjHCXNtQpCAufq9yPyR7taKQYQ8zayhQUfcSywwgFHGImLVc8xUZc8dSiB93op8yxDXT3UDPM1XVOMOiu+bhp7njwEd+LFjlYCc+THfDe2gHsnWNyPESVS/OjMfG+zltl2UV7sLiESvppz5UwQGhJfT8/HAu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 18:03:01.7835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baf9e1c-6d7a-4fe0-4b54-08dee8e4a303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603
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



On 7/23/2026 Thu 00:42, Lizhi Hou wrote:
> Two error paths in amdxdna_insert_pages() called vma->vm_ops->close(vma)
> before returning an error code to the caller.  This is incorrect:
> amdxdna_gem_obj_mmap() registers an HMM interval notifier before calling
> amdxdna_insert_pages(), and on a hard error it jumps to hmm_unreg to undo
> that registration.  Calling vm_ops->close() manually — which drops the
> shmem pages_pin_count and the GEM object reference that backs the VMA —
> before the mmap syscall has even returned causes those resources to be
> released while the VMA is still alive.  The kernel VMA teardown will call
> vm_ops->close() a second time when the process later unmaps the range,
> producing a reference count underflow.
> 
> Replace both hard-error returns with a deferred-fault approach that keeps
> the VMA alive and retries page insertion through the HMM range-fault path.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index d6fe6fb41286..aed110ad1c1e 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -435,6 +435,23 @@ static void amdxdna_gem_dev_obj_free(struct drm_gem_object *gobj)
>   	amdxdna_gem_destroy_obj(abo);
>   }
>   
> +static void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
> +				      struct vm_area_struct *vma)
> +{
> +	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
> +	struct amdxdna_umap *mapp;
> +
> +	down_write(&xdna->notifier_lock);
> +	abo->mem.map_invalid = true;
> +	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> +		if (compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end)) {
> +			mapp->invalid = true;
> +			break;
> +		}
> +	}
> +	up_write(&xdna->notifier_lock);
> +}
> +
>   static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>   				struct vm_area_struct *vma)
>   {
> @@ -456,8 +473,7 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>   				      &num_pages);
>   		if (ret) {
>   			XDNA_ERR(xdna, "Failed insert pages %d", ret);
> -			vma->vm_ops->close(vma);
> -			return ret;
> +			amdxdna_mark_mapp_invalid(abo, vma);
>   		}
>   
>   		return 0;
> @@ -477,9 +493,9 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
>   		fault_ret = handle_mm_fault(vma, vma->vm_start + offset,
>   					    FAULT_FLAG_WRITE, NULL);
>   		if (fault_ret & VM_FAULT_ERROR) {
> -			vma->vm_ops->close(vma);
>   			XDNA_ERR(xdna, "Fault in page failed");
> -			return -EFAULT;
> +			amdxdna_mark_mapp_invalid(abo, vma);
> +			break;
>   		}
>   
>   		offset += PAGE_SIZE;

