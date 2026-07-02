Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6354AC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD5510F4A9;
	Thu,  2 Jul 2026 15:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WwVTEeCv";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9C810F4A0
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXiG7S/1KLIbXRrtRL9G+AsuEfXj5mVEGw4dsEAoMgXoMFDGp2QG8ryh2NvtxMe9x7nKh0sJRFiqdhUiwWmUGcMhMIGqFNv2a8ZVL6Sn5bdhePVbh8reBUeVTuT5PmnkBNbU58q8PPcws7p3GV+9brS4/nrxZ+cNd+zSMldUb9MaJ6J8Qr9oIVjV7ywfUIe9pvbG1BU2Q+irXceOFGEIcKDuxgE3lZAv/Ika/hypE+96vxp7LUHwWIOgwgstbvQrC2rfE9A2crDAaQyjYRA1P8QphQ4U1fKbwf5h9f7VbadwQFqHir+Cm0jShJEa0DAZZcOCmV9xM+NWmpZ2ORIJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BiQSWH91EPXj1hwTH5x/u+FqjQp0NfYXI6LOTiIRGA=;
 b=PPvV4bJmhdxtgj0kebHASAKMaF1r2NSzR1qztpwzb/P5KpSrVjKmeX6VYZo9fanEjYLDAhheA1cJWee0q7n5+pzdb3ET5gRtbDuJTbH+ELlLRpktALLCuUgL2PL25Nf3+QFmz8B7W+K/edZl55b/qEqu2TFpeyYN+wo0OGCR9Rn1LqugGwdw1V2AHRKWEfpHvWUkBx8hLL/1CfIFhm85uFe5mmVnBctyNcmjGEJ/xcEZ/TnMm4Knxnvf9a68EVoLlJ/9bPFwW209JIC/GJbxlhpUux3vBKsQqpP/9tOA7z9HyMAukLytqIWvtYraIglmCA/JPv3W6UADJ73j8NIFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BiQSWH91EPXj1hwTH5x/u+FqjQp0NfYXI6LOTiIRGA=;
 b=WwVTEeCvIYsX+1U0uZdplmUMdNxiRXsDfI4Z90C8sEn44cpsakFsPS24Ub9cX02D2h31ba5y3FcSVGbZYmoNh3BxZUKmm8lIOgpZkOZxizavntebbKWRbrvdu94ZB7jR8OvUmsyJwH1boOfhKALRTUPyNlcvUnU2RN/nn4AmPqc=
Received: from CH2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:610:4e::17)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 15:47:41 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::32) by CH2PR02CA0007.outlook.office365.com
 (2603:10b6:610:4e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Thu, 2
 Jul 2026 15:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 15:47:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 10:47:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 08:47:40 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 10:47:39 -0500
Message-ID: <d0fe2a48-d664-97a6-241e-3107c72de40b@amd.com>
Date: Thu, 2 Jul 2026 08:47:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Fix double drm_gem_object_put() in dma-buf
 mmap error path
Content-Language: en-US
To: Jhonraushan <raushan.jhon@gmail.com>, Min Ma <mamin506@gmail.com>, "Oded
 Gabbay" <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260702072540.2183601-1-raushan.jhon@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260702072540.2183601-1-raushan.jhon@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c99a8f-a1a6-416f-4159-08ded851404c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|13003099007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: iD/eDgxhS0inUTSoz5bZEGQc19pPJnApmt8A2Bh6NnVReS4e8sb3r8LJiTO8Cwg5K4lNRAYseGsNdkEx/lTewlf2i135l6yGY06mB236zjudFCXhNiPlQb+VQLuw5Rlcc2M9D22jUE9jBkET8CM7PAqiSIe8YPcdk2fxvgM4qmo1HFtt4+zsj8sfUYU146KNLBwTOdcfjcc8sXfz0mnigUMBIuxjfWJAGOGFpiCO6M7yB9HerbHqmu+N9q9YB6c1LunQhbknGY3EhS3zqU2Lwu6fIea6Rx2UjGd95TLQAPuTFomZPFNMF9McxzxMtsEYHZMTSIBorYV8cGSVDWpscEsWFBUC2JbKkwIJySjwMQSdOC7paIa5iu+oscPoJ4RqB0BFRfL8Fo84aV1M8NjqwS9qUXPTWLC0z3fuKrwpMYBmm//YQd9f2Gs36l1V7I2YV054x4zK75/m53KFEjxuozH01LOFRDJuD8GcTEsfgp1UxSicJU8K98QEaWajzNCbWrxV8XNAI/KXtupCFgy9NXwtkS/KQHB4wXMUIWAsQafDshhp4TIsQaXjYiqskGUiaQn6QIoRC/gBkJJEO9LlBvoX9Im0ljmB5rJL1R42nCsY/8H4tPgzlv7NeyB0YwIzIiOjlNq76XW9Ke1kZxSm/rVeceOTZYgMHtfqgbrr6kLlWYVvuxBOANzl+8j0PwU2rq55lsYJH3ds6KUu3QEZjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(13003099007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qvh8fgfD5ugZ0ljUWt9eywweYpnE09HENVTD85u8zq7Y1FVDaZnNJ1cdCVt5absJAb6uXmv8OJLug7RVM8cwms++sHDXzhcmBV3J5TGPuKXJMwxeGYkNw0xFeXrwYLzZl/MdVV+lVDsKXcG75QRJXgE8ps+yYUKDbTQNBXDZza9yY/9f1GnlSwILHRWMOOTU0nBc5vfyfYu4mL4Z/jrMgAFTvy8JyRh1ejEHF9XcEFDNKMg+i5v6wXvTr9X03ASjkS1IMV6oc3mkAnkXnn7zEb+3gb0XJMj9j/du9AAFD6NWZ0njfyHr5TSRw0MzM52zAgfN5gHB3ZGfD/4yLUVLu8yTj0MX1KAQS6Cal0lS+gcztn7QFr89xY8PIlp5fEmTyCKKB6n9IPWOYylUPqPleqeMgXZvk9SYD/+iW31mBYPCOXVzQ9ZV3ThPbLThNDz4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:41.5271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c99a8f-a1a6-416f-4159-08ded851404c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
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

Thanks for providing the patch. There was a same patch posted: 
https://lore.kernel.org/all/20260625113239.49764-1-vulab@iscas.ac.cn/

Lizhi

On 7/2/26 00:25, Jhonraushan wrote:
> amdxdna_gem_dmabuf_mmap() takes a reference with drm_gem_object_get()
> and, on the vm_insert_pages() failure path, jumps to close_vma which
> calls vma->vm_ops->close(). For a shmem GEM object vm_ops is
> drm_gem_shmem_vm_ops, whose .close (drm_gem_shmem_vm_close ->
> drm_gem_vm_close) already drops that reference. Execution then falls
> through to put_obj and drops it a second time.
>
> This underflows the GEM object refcount and frees it prematurely while
> the dma-buf still references it, leading to a use-after-free.
>
> Return directly after vm_ops->close() instead of falling through to the
> extra drm_gem_object_put(), matching the sibling amdxdna_insert_pages()
> error path.
>
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jhonraushan <raushan.jhon@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 891112c2cddf..3ac8c345b25b 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -526,7 +526,12 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struc
>   	return 0;
>   
>   close_vma:
> +	/* vm_ops->close() drops the reference taken by drm_gem_object_get()
> +	 * above, so return directly instead of falling through to put_obj
> +	 * and dropping it a second time.
> +	 */
>   	vma->vm_ops->close(vma);
> +	return ret;
>   put_obj:
>   	drm_gem_object_put(gobj);
>   	return ret;
