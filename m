Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904E8F8D757
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3B110E211;
	Thu, 16 Apr 2026 15:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Od82E/jY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E215110E211
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 15:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYpL/zb3nHxwK+nXxWYiIXmCPZoh+Qu+fg1TU3CrZ9AyqQDkwziGSHzvsn73hqowbEvO0C/np3wr2yKHzN5Wn7I/o32oXDfHUJZ37BhA2DaqnpPQQQ8uuDiiW+biK4uCh0LMEW5ATEXH+4OaNSniW7Mb6egzwmQrOKJSlMAJ7K0Cr7LbLVHsHJAsgviZfkccglfueOo4PHfeFwL6RnQjYcBj1UUcwkyLkfKjo/9b5nEC2FP/j1am0SgMUhJnYdp1oorlONd8fD3P0ABAUxqi1YxtTUuxX8983qyn4YsrmCsSHTy2qeCxHnKB43sbhoYGhzVe8FXcJx7HAwE6gyoEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5qfIRH92uPZHNy2cV3p1oyr6aArr3b27mqbzuyTuMY=;
 b=q4Dcm5iqECSyBY/eu48QqyNwjha+vNnuNqxO+YV09N8JU3v6YbTOpLwe6rYuEjjyY3bIe/W1cVBKIiC3MiPusIaXbn1ygKrYCaLWq+DjPlAb5RuhOJD0V9gylATKlC7F2mwLiZmRBOIxT1AoEIQ86eckggdb/86DavwydyUKVJmnph/jLrMmcR5Dx5eI3cOYCiljGF6Y7gs9XE4VoBVoER2KXM7RSnQaodheYtmYU3mqILZlWvQ7/VBtQLErAiWsyDF6eRU4douojppc888afzXGgJA+u/dU3CjuRUggYQ31AIzBZjUOg7I4DGqQh/UoK11xwZ+blZn2XZayMajYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5qfIRH92uPZHNy2cV3p1oyr6aArr3b27mqbzuyTuMY=;
 b=Od82E/jYuuMofhFNWfDTdLlXBCBZ0q/t6iZ3Y4P7EwVkIMyM9ddlckpvcuksxXgJRXsYyNoNvmj8BuBzQx8h0euFAZLGlskI0ulLmLehdVmfawPAY9cE3D7A8gr8B3gBTOsfphqiHdG4kLeycl9xepk+FN4gO59dpHIpGXdFRtY=
Received: from SN1PR12CA0096.namprd12.prod.outlook.com (2603:10b6:802:21::31)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 15:24:48 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::27) by SN1PR12CA0096.outlook.office365.com
 (2603:10b6:802:21::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 15:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 15:24:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 16 Apr
 2026 10:24:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Apr
 2026 10:24:47 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 16 Apr 2026 10:24:47 -0500
Message-ID: <e309036e-9485-ee66-2e67-f7f71c99b723@amd.com>
Date: Thu, 16 Apr 2026 08:24:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Fix memory leak in amdxdna_iommu_alloc()
Content-Language: en-US
To: Felix Gu <ustc.gu@gmail.com>, Min Ma <mamin506@gmail.com>, Oded Gabbay
 <ogabbay@kernel.org>, "Mario Limonciello (AMD)" <superm1@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260416-amdxdna-v1-1-30c13008365c@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260416-amdxdna-v1-1-30c13008365c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: bf933329-fdf2-4f94-a0c4-08de9bcc4bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hNJrb2EkDCHCYnwJA5H3v4PQdneNp6L6KhQRCwgxuzPO50lgChQosMZ5yKEMjje5+Ap50oWIW4ylTRzRQZTvzUH4Nj2zkjMK0fX4YIphOiztnTuZg0SLx0H1z2o3Q0RW87d+qiWOjd27IjQSGRgly9LZaThznX+ZkarW5NvKnAXtsIhsocFiaab+yRHkXXgMko8Q7/4t6DH0Dq/suGn3JpdsfUqt68cd/GGF4IKxq5bpUen8+yrJKgIHkpyYsZVXGrBHHDEhkck43+RL3y9vwCs7lVZHoVzqwQf9gTvWXY7LbjUWgiV5UJznr6fd7LPCRzhbxraM8YqPTT1QVjMxnsTQFj0g+UYeJPveC5xsQsRhISygfo7zFfdwAdkcHxA3A/+l/4LjYoz72667SAnRnhVXa0v6fYD6rSUJ/TD34p0THpGIgRVQU+8irorgzzCfBtifqKNErE1fLjj3oU+Q28K9LKcP9ccPc5tIYuJGdJ+sNO3jMAoCE9zjnB3lZ1YHRoh2Nc2QOt1na0wapfPxaAcEQnCH7OX9o99aSRYs+yynwGsoKlj4J/FgW4L4FiYIqtfx1ngAp47Jbd17qhRDHo4DF9hsgUxOQJgSzikDxkV+rTSTmjE62GIdL8Tdtt+jSeFpFlGsLbMigKYAdbV9cCNO+J0BzB7I3cEdsA3UbzEvFA2DNHxRTX9dJs1ZCM95Rh4IsdcNqOSBK/KuP7f31LiIVEp1ULmeqhK+/H/ihkv2Sa2fgZZMffd/5K6OixdhZE/2xHZu0G7epXpTTGFMPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1FGXPKv6LIUi/qEHuWkEcmLNtX7fUCkrZU9cNYHVSgIra9D/rwfEyI4+7/eX8gWkKPozWffEzFazn9dVrowBVPv9OdsdrLoFOttmby7Wku8Sn5oFO/dpF2WL90Y886I/NLuUfG5qg1PQscNf1s6tsu2kdAYSsnYQat8g+6UprnKbGngPVofpKKNL5QF9BxM1O6yuOTvOTTILAR9BHqzISRBBu/wUaDHAkgO3Ecvsw6CBUzb2VJv7reprhY001a8sDYmAfGg4qn2CuYfgCZhzmrcDe65aKCs9c4ZQgJv1E1KBDRUxGb0nb+7zj3x7gXbY7XIcX6hASAQfgIBCepLcSjqUewkpPlbXrgflf77rOSrp3htblMJ80rXGWGZwOzixV+sQP5y23VH03ZY0q+94j/+FFP5fbWJ4zd3jmIzTuydVzDil7eoONotHEaI8UbF6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:24:48.2694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf933329-fdf2-4f94-a0c4-08de9bcc4bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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


On 4/16/26 06:37, Felix Gu wrote:
> In amdxdna_iommu_alloc(), if iommu_map() fails after successfully
> allocating both iova and cpu_addr, the code jumps to free_iova
> which only frees the iova, leaking the allocated pages.
>
> Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
> index 4626434d4180..a2e8d8ac0901 100644
> --- a/drivers/accel/amdxdna/amdxdna_iommu.c
> +++ b/drivers/accel/amdxdna/amdxdna_iommu.c
> @@ -110,10 +110,12 @@ void *amdxdna_iommu_alloc(struct amdxdna_dev *xdna, size_t size, dma_addr_t *dma
>                          iova_align(&xdna->iovad, size),
>                          IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
>          if (ret)
> -               goto free_iova;
> +               goto free_cpu_addr;
>
>          return cpu_addr;
>
> +free_cpu_addr:
> +       free_pages((unsigned long)cpu_addr, get_order(size));
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   free_iova:
>          __free_iova(&xdna->iovad, iova);
>          return ERR_PTR(ret);
>
> ---
> base-commit: 936c21068d7ade00325e40d82bfd2f3f29d9f659
> change-id: 20260416-amdxdna-f46d045130aa
>
> Best regards,
> --
> Felix Gu <ustc.gu@gmail.com>
>
