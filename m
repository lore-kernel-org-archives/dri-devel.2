Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64CCC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0407910E1C2;
	Wed, 19 Aug 2026 21:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4ItQ+HG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAD410E1C2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 21:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tacTjMY/8uMbppdjemC8Z9fb4aDMNlDFQa/iDHYu2Rk/p5aZVoTTa/Y5+DNbbgn9C1jW6UocqFw0vIA423ByM4sjSvVgZq9PJKdmt7MDGxaCOQe1Ohla+0G2GtErxQS2sxtFXLYvvX9YMv9ZJ6G+bbiI67kkqOKWgO7Ey8D250xg57tBXD/O6KNSnM40M9TP/NW/kRXbNksgMUQxa/jqsn6XAtaAlwKKt2ZMKgdaTtUVErmefs37i9y9fn9eNq3+sxeyRFVRA6wWmOVDw5Eq+JKsWkMwqwWZSpHerFZSCZOBqi9o6s/3H/Q8rG9u9BQ5gl7h1b5B7G5gHeLeevyMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLBZ3rqLG5cIsrj7bkheoshrdr0DqukcEKxoZTru0uY=;
 b=LZDKRup0P378/RWAH7K7RkTIVbEDzrXNqdy0iMShCNcjjoO4SSNLkwby8qAnZQEOwC9MAO4fginotNKM3ZbpGX/8TV3C1+hMysPToly0teLabYAJ5ol65b/Cbz3GCuoxyoNz/8TKqZPK+NmFRUhJc6vIoRXD+6y81thu1u3+W1QUxzTZbpc2A29T3AmYExqUaM+KUYbUD/xZv2DBYwR+TOYDGhOfQVzfX5/JgvzzFbXT8aK5tzNnWzZmHVF4fOZVSStHBdcXASdQscZ5ouAuFUv6E5rL30uFVt8AsVtxxoo45qWK5OnozmmXZdalz5+FSQze3CyBMYkgV/5j1c1IoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLBZ3rqLG5cIsrj7bkheoshrdr0DqukcEKxoZTru0uY=;
 b=P4ItQ+HGrZMxf4FP5/EdksDOQ9Ucjv2kGpp/a8vdf4nj9NOn7ghqpSZk/oTX2YSlDTQxB22OzEO0225Pdx2pGGmNBKqxy9X6PNTU/FBzwDPNjLsVAIzWuZ4yD/YizGocA+H7+b59YOgideZ4YrsfjLeRebEiO+IBbtExs+04Iao=
Received: from MN0P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::33)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 21:00:07 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:52b:cafe::1) by MN0P223CA0030.outlook.office365.com
 (2603:10b6:208:52b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 21:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Wed, 19 Aug 2026 21:00:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 16:00:02 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 16:00:01 -0500
Message-ID: <910192e2-5615-afe5-5129-701a0664a816@amd.com>
Date: Wed, 19 Aug 2026 14:00:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 4/5] accel/amdxdna: refuse to flush an imported BO
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
 <alexdeucher@gmail.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
References: <20260817230707.356828-1-taimuraz@kaitmazov.com>
 <20260817230707.356828-5-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260817230707.356828-5-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: dd54712b-3b4f-4546-578b-08defe34d89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9sqd0UIgzntdxzTdP+xjscPjDO2S2EwrbPjLtK2MtJqFviB7h7uDjvHrdwT+YHXZEh/+e2yBxWdUx5DCFXyTnIKnoQhE1v6mjCd1J6IfGXISOeeyQPVI61SnLvk/KCxqvm9uokCSk56q9Qvvk9v8E6jnoMOM7vlr+XCj9KYTCJGkteBXJd3eKcydh7hj5d130jAuY7bsiOE7zE7h9hX7Ulw7XGeHrVi0ztxuvjmBf8NRhsZK2mlCfHylshDhpIu+mtSQfJFFoUeZB3NRVzG/6E8ediUiNh5ZYDLvELeGOLb9hoo2s+1z+DNDzslL/RFEaepUnNrQ6Rw5AYItVl/bLDxQ2EwH//RIFNhsxayXS3CMfr+p1ktKfhA60vTjm/b0lDWjuMg6Uiuq0WL7FerUr2FTJ+GUFZuIR+73VPoJ8LkXObK9/P39jOA1pEBb1H7/gxOZCrnrjoTDrSEkK7wrKyyeAixL2naVrVYghXn5zWVBBypi4BPu6v++mFCSNTOTKGeccQDQaNhOtyRqH4ZwSyZuNcOyXyI9I40FmEwKAhKv1rMVhiqIC//ILy0aStkwJzJ4q9fYzb6nHAD1HKjz8Z3B3woUaAUAxHUJEZRW0SojDzNMQSuIxHwUVqtn74xbDLDutllIeaxsYkxMVIBUid/Hab1x4Ohq9uS+/JteakgHjqTWUajMpOJjuGeVtYmnJUh5nCDGQiXEfdHGMaLijA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8sdsoHzEXuVjpz6bl9yAEgmNsRBlQkuKkxXgfjs3536ak8WWBRqVXo3wPgLjV9ITCiafDbw7LVTe7aIFHJ2s58qvF+3iAZkpmyi31EM3kk33dfufcfaoU1KF2XVEW7Cvg/eQJQWxkfr+7xYXCQN1niVrBl11rI1lQYO0JIxYZJDeBBkxXcKQzEPYZGf1yWvCv0L+FzeYB9AbGErbQmV6uZAPi10GEk0bALea1V42QFMtUG8ck9xt9zWcsNpVfmayV+Mkmsb/MbI2TFG5f4SHby8hjWgpNCyOQYh5PzsrgqZimf+zBwy0AK1ID49yWMW1/3zTc5N7MUxc1tEiGEtegufYRfkjVDABYGzy8Qfyy39NjjPZGoUBRBiPo6Q0SvAlBNrTObIAD3ufvsXpi+3wVeO9mF2puKQ0nFEUC/8VrdXx98emJnNK65Ts6WqwTBqI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 21:00:05.8670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd54712b-3b4f-4546-578b-08defe34d89c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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


On 8/17/26 16:07, Taimuraz Kaitmazov wrote:
> SYNC_BO clflushes an imported BO's scatterlist. An importer may not do
> that: the memory belongs to the exporter, and dma-buf gives the importer
> no interface to ask for maintenance on it. Refuse the request instead.
>
> is_import_bo() is (obj)->attach, which covers more than foreign buffers.
> A userptr BO arrives through a ubuf, and on a carveout device every share
> BO and the device heap arrive through a cbuf, so SYNC_BO answers
> -EOPNOTSUPP for those too, including the AMDXDNA_BO_DEV path that flushes
> through its heap.
>
> Only the ubuf case gives up maintenance it was getting: on a 64 MiB
> userptr BO a 4 KiB sync and a full sync both cost 659 us, this arm having
> ignored the range. amdxdna_cbuf_map() fills in only the DMA address and
> length, so drm_clflush_sg() already walks zero pages on carveout memory.
> Userspace maintains these through the mapping it already holds, as XRT's
> buffer::sync() does unless it is told to sync through the driver.
>
> Suggested-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 4f38f985c74e..a713a9982d34 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1224,6 +1224,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
>   {
>   	u64 end;
>   
> +	if (is_import_bo(abo))
> +		return -EOPNOTSUPP;
> +
>   	if (offset >= abo->mem.size)
>   		return -EINVAL;
>   
> @@ -1234,9 +1237,7 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
>   	if (!size)
>   		return 0;
>   
> -	if (is_import_bo(abo))
> -		drm_clflush_sg(abo->base.sgt);
> -	else if (amdxdna_gem_vmap(abo))
> +	if (amdxdna_gem_vmap(abo))
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
>   	else if (abo->base.pages)
>   		drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);
