Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3645C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0564210E4F8;
	Thu, 17 Sep 2026 16:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KjjxMsys";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE25010E732
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7HZ9EZT99AE0yJqQHAvkiRjo7hGzlDZ/Q2yY0Npl1xC9TLg5kfqt8b2vpXr9g6hJ2ZJ4rW5p5KZFzaWW2v7yJsBlc+JIfdOmRccrvNKSY7uApGRGtlXqAzmZfpaci+HBsVPKo5K5ccvCeVu+D4FEOPOhQhgZiPADVQd3AUkLTu1oJ4lX0E/RaOi9vVOBrLe+C7cyxMoK51yy4otwbVrV7neEyQgnCFzo4BFrdu8doRlvinwM+wINFvsDDZA09HN9tAykXwNGLyaj7bsUejn+e2E5at81yq+kA+1BcrjHQ92FmK6OW9YhC2/5ZuW/e3M14s8dXBPJGLj5L4/kDJx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvV3fNwkaekFWusQIdnggjphaNEofk1gb/P4ImLA8Hk=;
 b=aH+1t6AubtTGad3mSBsxekV08lW9BMxE7RaqpWQPrXfXHQ9jrQj1XORL0y2DfEVfp8Gb+AAbzAWTB4roytW/Ho6RguRWG6QCLYj/uCEjnO18oNCcTpeYWrn7aSCaLyxLXOZ+3ut/nzCISSJDCxLIe/8nLufufbPq3T9iU5tN9++gJNAweNNzDrY/auKue+6uX7Wf4MSmdO+GE8itBuEJ41cDzrgjWCbPcVUXrkAVkH/KvrofgbjV+7WII9iUVLfbaHmpY3uc0UzZcPBGdb+Ir7ZC+nhShkMbqZ0jg7ckWaAzLcuY6WON0O3RSXUCcUDuqtbOoDTiPw0qc49eCfuiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvV3fNwkaekFWusQIdnggjphaNEofk1gb/P4ImLA8Hk=;
 b=KjjxMsysXAma+DYrScNcVPUTMMU7JOOaNQXWJqwIs3bdp4pfhTG0FoqK2/pNoLlcDygEV5+SfLH2tetITYSxGMfD7I6+zpv3wFk7VR/TddvQFLXmRbPzkhm51p7C8RQ822Ff0xNAXsz5Yv9SeLEN5fQldCqWlTEpSY3swLhUFNU=
Received: from SJ0PR05CA0114.namprd05.prod.outlook.com (2603:10b6:a03:334::29)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 16:11:40 +0000
Received: from BY1PEPF00026965.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::8) by SJ0PR05CA0114.outlook.office365.com
 (2603:10b6:a03:334::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Thu, 17
 Sep 2026 16:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026965.mail.protection.outlook.com (10.167.244.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 16:11:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 11:11:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 11:11:36 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 11:11:35 -0500
Message-ID: <d0157864-cfe6-a4f3-bc62-3338c04e806b@amd.com>
Date: Thu, 17 Sep 2026 09:11:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/5] accel/amdxdna: do not fail a sync for a BO with no
 debug context
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Alex Deucher <alexdeucher@gmail.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
References: <20260819224458.257346-1-taimuraz@kaitmazov.com>
 <20260819224458.257346-6-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260819224458.257346-6-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026965:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6950e6-a195-443e-9698-08df14d659d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|4143699003|10067099003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: 3ybaRtic7gNavBFLhcUIaGVVj+JJqMqjWys+fvOJbEquLA/IygW5CKNqr0OVILlNt8yZcSQ8jkZsEvIzK5R60gHdoVBdFbtySKJplnfc90ey4HiPnMXcr7FZjbJ/nydO/NRGTeJ2IRM1RUSP4UU4NjIeAsSyFm3rd8CqNsMg+Xxm6/2iyl1SJ0vtE7M7Go4WjQci7PV88aTl96WJX1nMSYn9L3vpMyNNCpr0mISqDT43bs2BI2GG2ciPqYCOQpln162W7BZM7ukMGTRsdTCUBdbmbgBJiO6akx/5OY/w4nWORcM1tpZjUiWcT77DFk8YGaRcNMwSxDHbSn2hKE47fFIKtsj4wfbqR0jzx6q38YwK5xDasBoqc5tglX0kG5H0MmdiKdqUKz2jvNasr1gnlmObdXdenYchfUttuBGgc75n3TaHvuKLbzgPKKDN+Tm3slZmWWLXhWp3eWpUgwP1HHdDJD68T9cKYucZAbnho3+YatArbBZox/fxzQ8L/R+knxwmtfHTfaX1Qo1v8rwrv3kASMJzDYheYgAq19Hn8WL3qrWPxFsllQlhgSr/j+2uh2eUk/UfWlfmxdRDrFLmtiFS6yyx15IhlNeRntzQPXEr+GFk4iZFEy7QH70tVxAt40lh+UpuA13Ld4thMeFhMBqFlX5XhAFqdJKCwjsqXhrktgkrhxOOgFx514kjmqR9fZ7u+lLHbil7wiV5DsdghA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(4143699003)(10067099003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DPYUhlS9RDNZmC2MGhpkmhbeDYfwpF93btIcXaxLOFZMotEjSDqDKCa+sMMdZIFCbwHU+lD3WHdw2gGrNiuHW1rsHW/JK/WSI4LzTKLVtOKPJYyay83XYZRp6tP1PqRrKwKEdvp3jqa/DnPVUFY7erJowdLvU8+eLozFok8HJXHkBgkbvq0MOfxoi8bwkJZctDHViiMvoOTOkwi1x83tcNLA3ppROf3tMgBI7K7r2gt6NuD5+jJXwIwjyl+RuiQ71SsGJHTWzEq4hAouKeF54ZwX5YbP5WjZnMBUov9GWN4Wc20D8iZKgHqbPeqa5GVnS8PFhpuNwUJz/ZNwZvF4omFB8O1fsam0eAB6LmLfjtevBajjGhMicWoWNS51ItxqWaBgmgfIGASNvVGXAiVvHmBwoiotZCSaszM1yb+6cX9lBuU1tMz/aPhHq2Cs5rH2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:11:37.1534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6950e6-a195-443e-9698-08df14d659d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026965.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
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


On 8/19/26 15:44, Taimuraz Kaitmazov wrote:
> amdxdna_drm_sync_bo_ioctl() calls amdxdna_hwctx_sync_debug_bo() for every
> FROM_DEVICE sync, which answers -EINVAL when the BO's assigned_hwctx names
> no context. Only a BO attached with ATTACH_DEBUG_BO is ever given one, so
> an ordinary read-back sync reports failure after its flush has already run.
>
> Ask for the debug sync only when the BO has a context. An unattached BO
> carries AMDXDNA_INVALID_CTX_HANDLE and hwctx ids are allocated above it, so
> the test is exact, -EINVAL keeps meaning that the named context is gone,
> and the handle is not resolved twice. The field is written under dev_lock
> and read here without it; the context is still resolved under that lock, so
> a racing attach only decides whether this sync sees the buffer.
>
> Suggested-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 4be5298d1062..2613c94dd842 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1319,7 +1319,8 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   	XDNA_DBG(xdna, "Sync bo %d offset 0x%llx, size 0x%llx\n",
>   		 args->handle, args->offset, args->size);
>   
> -	if (args->direction == SYNC_DIRECT_FROM_DEVICE)
> +	if (abo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE &&
> +	    args->direction == SYNC_DIRECT_FROM_DEVICE)
>   		ret = amdxdna_hwctx_sync_debug_bo(client, args->handle);
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   
>   put_obj:
