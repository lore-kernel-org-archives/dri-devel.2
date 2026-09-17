Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D80AC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA2E10E3B6;
	Thu, 17 Sep 2026 17:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Km9GTO/C";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2871510E3B6
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWNpOe+J+9CZ62YVZtD3V1SHzYqkmMPRWJbLVAy3jXadIQkrpDrNIBgvZwFzoH7AdbNx27N8nmYHU/FT0lx92IPdWESJNKPk61mQw/Bvp1O6ecyprslPg78IFOos+GGOW39kQIuCzDTezawU5EPQqVw/nnEMlwmbHy2hZpHvJC6xCRPWXI6bAjCRUKmiRIuV+w+N+2R6ErxUHVGEguVMzttdpsEilK3Cmur260rl79fXQv1nCftuoNHbXWIFqVUwYDNTRjXsLAwinNV21gWw5vk55oHwfc23xt4zrrmKpvlNaFSzftu3B15h75FX6uHFKwBpJYO57fUIs9Mgr3OMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncQbpxFHiAsLl3hah/bHdk2hQkJJCg5bBW513Ei0e1w=;
 b=Qe/64y8vIXVsIMU0TYj3ZSc0rvEYFjVyXfX+jrTvGpKNBaSCPKqLtRdGhsKxU7l+YjVK1fEXPehfYcPGyh7DPj5/t+8cNBzRPEvyURD5C186nooHeiS8h+Mtl1oUEgfmE8chiPK0zbZCuFNLpZfCTiO1jvuuPIqYO0ut24Zi9hG9JeknJ9YLI2jr/pvO52tp7SsYATwcF0kTSFmynhoVypMHBXpOI5PDFx3wXzRGJWO0zG8fuatrV4yFsf36H8qLOKfWfPTohfpXL9ge86wrV7HSAX6AyH1BJZkRmESudeBphSx7oPnLHdYGlZ/s5CltG92hZlZS8CHPvk4Dca2I5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncQbpxFHiAsLl3hah/bHdk2hQkJJCg5bBW513Ei0e1w=;
 b=Km9GTO/C7WjtZjfnl+jycpexAXJynMMlAIB5iKdtLOYM70wjx0AZVLP4mrnr8+c9FU3e6HJdNOWrmMSv3u2XiN81N7eT7FqF1xyRU2bJUzSQqtqaJRXSuaPP8BPHr6URVRmRZCk6A6waoJ/OSush+OuLDafJfqRcjOu7zKZ3qHw=
Received: from BN0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:408:141::24)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 17:47:37 +0000
Received: from BN3PEPF00022BD6.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::30) by BN0PR07CA0007.outlook.office365.com
 (2603:10b6:408:141::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 17:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD6.mail.protection.outlook.com (10.167.248.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 17:47:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 12:47:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 12:47:33 -0500
Received: from [172.19.69.116] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 12:47:32 -0500
Message-ID: <df2d1b7a-5dc6-4139-9fc8-43b92e78bd75@amd.com>
Date: Thu, 17 Sep 2026 10:47:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO
 faults
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260917171952.1883974-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260917171952.1883974-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD6:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 597a5e65-c812-42b2-8872-08df14e3c0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LyXCBUhz18VfAEI4ooXbMECoX16BIqn9TQmaV4kosDTLtsmydJE7alychwAKZawe7Kc0lDFrBp72gur7qaIBhywO5Flrl8EZkfl2O0XmXGCvJbYLA88Trs9mKcq7rNLZX0P5ijz+CP7pSANnRKq9fiyN+cpNWomxgSzz5muVreG/DaqP5YVf6evbXlb+SCECf0a916aOL5O1BSqvgKZRgZMinaNQfk016JIQgbyby9rtKCX6FCLgE6N7Dx5jOCdnaz/2uHlC4FsG0k6VokeQttBX/Z1/6koUcQY6JR28lllcoT+QEIsak5w3VqG3hLdtcUiSN33KHicKC1PuEOdJ7xmY/lbt98TEvMQEx6qhempqZcWAqJGJd3Zb7tcl4381R8enn0DxPzCZiKgNfp0hPeJby/lFtrv6Ba8KEA00QbkBJj1o64dVfug721IOOMSy34vkPgv4vJb3ZtdJ0T7mmeCZxg/T2KfCoP5eAb6RYT4wjHy0oZ97KOO3TeOrppnTr1F+fKDvSy47gMbDs5P8I0rR8/sXuOTYVSuJprh+ha2ujrAUicpnyxvmfxlj34EcK6F4ksPfQcfucuuGLh57LLIzrmtnzic89cSAWQPHiRyRDsp2Hu7Z+01flfNBXK3NaNrSIZjY4FSSufmvaX+XJ9RwI082BGFw+RGykb8m/uFePqtKMw8GtzQ71aFYZ+fJ3VcYOjoM710r2KEvHXfpvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ixzkX2Ne4Dh6VlSiwT3HJl8Du/9YL6lM6X1fFz93ZFmRszzBjAdycvYdnSxlsb/oPNFjrvoyabTBuMdRaVLuvebSwWqUjawn8xPrr/ZdpyynaIYMv475dOXJWIHp7oZVlJTCfSaYgh2FedpbRTvprz5XxIPuchcfAVC7TeHWGFwfbdk+zN+APtlCVgiyn521P+QNPW5MlIrtV29vREz7gZm3yrmEgmC6nAvTE+0L2eVEhVVtWg+XoDc+8jYksvQ+jz2kE0gW4sM2PoGdL0xD02++33lhoVw8BfEjgGnXVwxryOeo+7rmvoVrjtcZN/dsRAzCI7IiH8yDX6DGc8YFi6tYDuprDO4aX1OPugD8J2YeRZM1dQouq4c9N/8u6/dE/4vVwqT+cP9SHiZSm34qugRzZQ02qVfA/uJ+dcvDQxGbZP7AP+Pf+dFFMqk/+mbk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:47:33.5246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597a5e65-c812-42b2-8872-08df14e3c0db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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



On 9/17/2026 Thu 10:19, Lizhi Hou wrote:
> When aie2_populate_range() faults in pages, it only sets
> HMM_PFN_REQ_FAULT. Without HMM_PFN_REQ_WRITE, handle_mm_fault() does not
> request write permissions and may populate the CPU page tables with
> read-only PTEs.
> 
> Check the VMA flags and set HMM_PFN_REQ_WRITE when the VMA has VM_WRITE.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
> V3:
>    Revert the V2 change. Instead, add comment to describe why it is not
> an issue.
> V2:
>    Fix sashiko comment.
> 
>   drivers/accel/amdxdna/amdxdna_gem.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index e861db6f9369..a5e30855c8a1 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -418,7 +418,15 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	mapp->range.notifier = &mapp->notifier;
>   	mapp->range.start = vma->vm_start;
>   	mapp->range.end = vma->vm_end;
> +	/*
> +	 * Access permissions are fixed at mmap() time. Changing them later
> +	 * with mprotect() is not supported: the range keeps requesting the
> +	 * original permissions, so the application may see a fault failure
> +	 * or an IOMMU fault.
> +	 */
>   	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
> +	if (vma->vm_flags & VM_WRITE)
> +		mapp->range.default_flags |= HMM_PFN_REQ_WRITE;
>   	mapp->abo = abo;
>   	kref_init(&mapp->refcnt);
>   

