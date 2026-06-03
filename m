Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE89CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194E31120AE;
	Wed,  3 Jun 2026 16:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xal3Rz/n";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1A11120AE
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 16:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFRDm3R0oZbFAS553HWJbobaxppT5pP7aLmrpZiG6Br05fh2S+NxykTNk4FeG18rH6RvfJKSKgHIsd7q2Sv9ln0Kb68ag3umgMWs3w+hSM06GKJu/VVEzfhwJGtebUQ24V8u3QlHV76QH4Sn4dMnXvu1RI2TTBTVv4K1zRG+thXxP83qkzE3PK9bhVxfljbFUTZqUXAd+ryxRUmvrzMAVsTs1zFNUgvwnmQoD7re84TdbkD1SnI2hReob6wqI1Q33FenLwvvZySWnL5YbibEjIm8Y8H4f4OW+VCBDGvOu5qhMRhGbUmOH4d3GWMIZlKejkWb/eUH0CVqs2XTuN3GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ6Hbz1lh+GYWCy9DWhsADd57agsPUblKJqU0s3SHPc=;
 b=QDpoJUSCxGQI8DoItlXj+YWaXaynuYtHKa/dHqNeYa2/W5roA2OrhdJs8QedWRcHxKPB2PwePalUUnwTSE2UPmUythaw3nVETkUiFy4fpYDOJZJmOouwWXZrv9fWnwXYzn+HBzMHqDdPhfgL5aeRYFJq7pfR9401hyAx2kLlSi74fkx+TzWfA1Av+XhkKBcPTlqdi/17OdBpbpUSGDQBSedqz8QQhknsIlujF+anVuyek7vu4cD8fCPE2LUqN+qgVHqrgfCxtjhUfRrRMybg3rBeeM3jJD6GvMVCPpuh4VASFs5nbeLVWtJjBlECYefmmP1IlcFP3cq6estKRbi1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ6Hbz1lh+GYWCy9DWhsADd57agsPUblKJqU0s3SHPc=;
 b=Xal3Rz/nHU8MdI8JsXGldG332KObJPu9u2N3Bo32g9ujbMnBBTVIxTdazIWoacP4/Prm815a7YPTWUfzdLDuez0S+Rv5IXWl+G8E9J7XcowBf12tu7NJXjlGVKZPAq6OANU83oei/MJhUzAE3YLeXrxs6Mc6mqmz7CxkBjvi/6Q=
Received: from BY3PR10CA0018.namprd10.prod.outlook.com (2603:10b6:a03:255::23)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 16:29:14 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::8a) by BY3PR10CA0018.outlook.office365.com
 (2603:10b6:a03:255::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:29:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 11:29:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 09:29:12 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 11:29:12 -0500
Message-ID: <9af8e500-d5ca-cc15-05b2-4a5cbf703410@amd.com>
Date: Wed, 3 Jun 2026 09:29:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] accel/amdxdna: fix memory leak in
 amdxdna_iommu_alloc() when iommu_map() fails
Content-Language: en-US
To: Jackie Liu <liu.yun@linux.dev>, <mamin506@gmail.com>
CC: <dri-devel@lists.freedesktop.org>
References: <20260603013543.94835-1-liu.yun@linux.dev>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260603013543.94835-1-liu.yun@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4efb86-031f-4265-7344-08dec18d3fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|13003099007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: E1RpRdrN4AS+sKqDvD0CuYwQIXV0NPny2OXycNPpC5gX9l85YQOXYUbi9Ob3jxVMZnfE8EO9XiVpc+Rav7te0j3r9qL3wXkLL5u4M48hAQ3zv3ocJtPJVVvESSgOy4On9oMVANR00yfFOJ+hgLDVG94FqpC6Lw46/PE+2euET+HGwGPHykzk51K/am9x3/pxETPVmohtzEeRmhPfiq1/aqCXH6jHL+TE/ERbhWax+vFVbcShLxL8uTYbppMW7k7+pJATmZBDVUiTdrvQ6McOaCGIanHXBvdXYg9QKiWdlIm5SHeBRKfulsgsmmGUaChRvh192XSMyzZ1Vt4uQQTZi1N3ngc6MBiknl0p2tgvmjojm2o3gfLiEStU2Zjcd+RmaMe0K+XiC5hs2NcwAnD5kjI6YQwIfaZlWPX1h/u9wtuVx8/8I0RzE5cjOwrO2txuPxMNU77+8K+PbDebjN4d10QbnZYqv3baPPczS0D8lOgcoXvawtH/SXUHduf8rFX62jS4lyVOhfeOE79ASmX2vCYHTS5IxXu1SoyoEdHE+h+UtcnEQLc2e76LJFlUFBmOm5bD2m0X93qflmNHgmKfZ3NwBAmEi5kCHN0eH92SE5Rsl+boIJkV1bre26ohCWs6iEVAdwgZGwSX14xaHEdF+HZt10+EVjKcmNlfxD5oTfgTbWCxFkj4m46JEAyozNjf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(13003099007)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iI68gtXUDhLiMGocVy1JuxN+3NOs9XNNfJJ7A6LlA4dXlvMn3wCJQHkvpbfOvuBsJ0DDIgQNqO6qqsX+PebwMyfyxDMj/RChYlJV5Qbuz7NaC0+c+F/cCuLy16ZiBYcKJPr/rI6b6xLp/XhZwXwUjRz9lt4YQG2pytGbe6wDl6crlM5n95QhqYK4blGkzoeA6XkYg7AnngOatYqNw4oU17zuTrLJNmeAWfwfkYFySTeqfPJnWCqf0cF1AGqGXQY7EsRrgkB4s6yr5Y50TgYJS3S4r2MvcciGN2jC8ZPf7tq0sGojf3LXZxprwt9WrYLnOWBINuc1Q4Ib5PpAioc3OrjqdKKT4DUl2JXLrpVnYQhYKN4DzVo8/pBh29VWzg5NyJcv8qKTP3Ukq+PhKj5mLl9p2dXIYuk/uvZM4Jv15Iwmcoy+QFtpVWc512/GHpvU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:29:13.4397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4efb86-031f-4265-7344-08dec18d3fa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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

Hi Jackie,

Thanks for providing the patch. This is a known bug and the fix is on 
the way.

https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/432fafdc9a3122a7bee5b2bfd23dcf2dc262a3d7

Lizhi

On 6/2/26 18:35, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
>
> When iommu_map() fails in amdxdna_iommu_alloc(), the code jumps to
> the 'free_iova' label which only frees the IOVA allocation. The
> physical pages allocated by __get_free_pages() are not freed, causing
> a memory leak.
>
> Add a 'free_pages' intermediate label to properly release the pages
> before freeing the IOVA, matching the cleanup order in
> amdxdna_iommu_free().
>
> Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   drivers/accel/amdxdna/amdxdna_iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
> index 4626434d4180..af67e059d599 100644
> --- a/drivers/accel/amdxdna/amdxdna_iommu.c
> +++ b/drivers/accel/amdxdna/amdxdna_iommu.c
> @@ -110,10 +110,12 @@ void *amdxdna_iommu_alloc(struct amdxdna_dev *xdna, size_t size, dma_addr_t *dma
>   			iova_align(&xdna->iovad, size),
>   			IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
>   	if (ret)
> -		goto free_iova;
> +		goto free_pages;
>   
>   	return cpu_addr;
>   
> +free_pages:
> +	free_pages((unsigned long)cpu_addr, get_order(size));
>   free_iova:
>   	__free_iova(&xdna->iovad, iova);
>   	return ERR_PTR(ret);
