Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7290BC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE36310E0C9;
	Tue,  7 Jul 2026 15:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ibjojCJM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2727E10E0C9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKOi1ffHpHudLpDI72r74qrStvA+oDWkU0gh5b2ggM2Hb3UjkA33W+ROxSnEqrzlKOXincSq3IwBzrGnX0aT8GP7Dw9MP6N/KAwBeuEgkNCZ2PX6SJK4cFFTCJ7eMKo9RHwtvnYkSraOX5xDbL9WHFJz1tIyOhYGgj8WSanWXWKJIBUeIpKkmUWbq7LjHUlx2l75fImkkYjC6umPN70Oj/x1EDoPfPRcKEegvv1i0TMrI/2xxkuPhJ1K+sVK2Tde33s87u/WHMX/zzvhNtjKiuZr8ogpVM2rrywsp8e9cTvscafXPk2msBef+fmG8Qv3lza1YYYDHJvGVd86pT+5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6xSmgpT5eanKFNrN+N3CHfsOdJyVB/Dj88L+djSXew=;
 b=dTg+Onsf0uITGvV4KNp8v7HcnpJg88wBJuA6faOt8DkaOqjWWui2cknNf2LPSahO2nIlb/p8rDuTysNIvkYVZd7XiP2tPaoQq9PoDSvrqPB4yN9eC+ZjcKBzKdTNthF9vxi/GyzuJK6S5QxilFiR5lI+jD+6ZB39q+FEdkVuMcaH/d5q/0kafAIv7lKLA5RWZAVsHf2ULOJNzD754wgwHHGPB45109MOUMfewKNe/iWOP35E7R6C9Wd+ULNBDmOjPN28mj6iXGlWHVH62JFKvU9MwQDrUq8ddycj+u6dr03nnu0//BTwUyllOXk27qa3dJbAq/MC9e2X7vM3g3O0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6xSmgpT5eanKFNrN+N3CHfsOdJyVB/Dj88L+djSXew=;
 b=ibjojCJMP0nM0qjhyAAiViQh0gqGTPsf4PQhhT7LP9NzImETctwJkhYFIe2WiYAQZllrzewE7TixO5RK9k/g/U24Wh074Ar665Ax5zAlFsRI2zKzcJqrsR8P7vUY5ndvjU64W2bruiYD670UuZu1cJ65Xo7X1W3+S93gM7zaO6I=
Received: from BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 15:35:48 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::17) by BY3PR10CA0025.outlook.office365.com
 (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:35:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:35:46 -0500
Received: from [172.19.70.117] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:35:46 -0500
Message-ID: <1b123fd9-12e5-4ca0-9328-97144af00f66@amd.com>
Date: Tue, 7 Jul 2026 08:35:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix potential amdxdna_umap lifetime race
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260706221228.434099-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260706221228.434099-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d0473a-4071-446a-d887-08dedc3d6a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xMDZcMeqaUPA7kAidnkdNUC3DLeBVIeyl+S2W1WyYK3kKDG6GI4i9It+iMiZrkz0FRtWqlbVGqJ2m35yGRXpSnxUg8V4MuDxDse3cPNKmrb1DhGtJXgaNqMAwQ4gSyp1MnOWstF2Zu6GdLH61+L5JB6Z6HEM/BY5MD1Z/NV8A08e9lH9Mw4cUYyalpRUbmeZm5yyOcHj3gaLXV1AagSAPeJxXWB/hNAeJSII3qzzT3//qxO8wP/Xhs7ynPlFafLVL5h8bSa4kw64H+43zyJXY/XuZzXcyvZTrur1gpIfeLcyYGGrAqXOvZydI2uJkm1pl8hx9LnkjUT1nyUrHDC/vmJHpzvDzjV/p5FcIYfXWRyYF1ObMpjBoxtDgzY61ZpqV5ohWkO0MFDJub6Mbprvn8hANmJ4DeZgDJ6Mebe+7Weoe/06zBLTW2JTGs1tQohG9dedekL/qYHBd0ZNJpCsoaOOT7QdXpW8TexUJV9gLPVe2n/LJMxw01phy6LpzLFVIxOEryGRcqtYU0fCHd1Ez+JcPbvpuumHJRmrd4ZQQOxDPmacDFPr8c+4exUA1SAIh57LDLcd7v+Kkyvl0KjmV4IH5DBuMp5bT51VNlm+kqWRxDX8uJWtalpxpXfziMdlxupOHC04Css/8JwMlH+6aaruqnz1PP7ZKPykX6QAFrgiGHjMVIUnxZwUcOpMj1I6SwQgJFG4h6m4B7JvcLRinw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HnDqPPgsA0UKiZnPovel4MVm+XIZZU9zpBzBPKzioOX7EI6iawTg5zdf0peeh0B+Ul5abpq0n2OZ6TnYnOaa3/+C1s+CHj7ZUnhSHhKJLIzxcUOl9AVrTzohALBqhF1wFjTwzZ6vP+wPIhOS7O1xBtC9i1HG7aVg5xzdyjPVl89KCyYDukdDNnmk3qV0vzALsxm0+VIh5skyvkUu+S8kSZ6cgzrkANDtwea9GHuOWvopD9nNPTUQNAqdXjK3LJDHeTGL+ljOLs9HI21m4mEwFb4M4dKcConfMitWEo6DM4fHLXpY0RlB9q5FpKNZBIofeodYavyVYLb9JF8s0fZFFfbD6AZ9IYqDeCETWmednkfBUFN9zAynJgBNnwFUcPTkkIW/FumvPTnRyMjCclsXQClHYqBFLTax1qWFe75tpairwIdVjH/BpLeMLdCwYkfw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:35:47.0042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d0473a-4071-446a-d887-08dedc3d6a7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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



On 7/6/2026 Mon 15:12, Lizhi Hou wrote:
> amdxdna_umap_release() calls the blocking mmu_interval_notifier_remove()
> before removing the object from abo->mem.umap_list. If
> aie2_populate_range() runs concurrently, it may obtain a reference to an
> amdxdna_umap that is being released, leading to a potential use-after-free.
> 
> Use refcount_inc_not_zero() in aie2_populate_range() when acquiring a
> reference. If the reference count has already dropped to zero, release
> is in progress and the entry is skipped.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>

The patch description mentioned refcount_inc_not_zero(), but the real 
fix calls kref_get_unless_zero() which is a wrapper of 
refcount_inc_not_zero(). It might be better to fix the description to 
match the fix in the code.

Thanks,
Max
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 408ff7e2a272..7bf635634e64 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1039,7 +1039,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>   	found = false;
>   	down_write(&xdna->notifier_lock);
>   	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> -		if (mapp->invalid) {
> +		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
>   			found = true;
>   			break;
>   		}
> @@ -1050,7 +1050,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>   		up_write(&xdna->notifier_lock);
>   		return 0;
>   	}
> -	kref_get(&mapp->refcnt);
> +
>   	up_write(&xdna->notifier_lock);
>   
>   	mm = mapp->notifier.mm;

