Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE48CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B15B10E1AA;
	Mon, 15 Jun 2026 16:15:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="29LyHm4q";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012068.outbound.protection.outlook.com
 [40.107.200.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4AE10E1AA
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 16:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Clk6dHGxuqzrStk3J65r3CGohY47hooUVsSLyHuu4gKSrHJnugpiUT/Tip3FtgdMA7SPDq0oS49WCqJQAkC+K3vZBKM6HVJ+XdjLpXYenaydChcNH9jwfnl2dejw0+hDvJKspOddBHRyMJO3NL/hcJ5KxA2LZPi/z2w0Qsn0Z4OMBXROkokqRCF5lgFbbklj934gnjBy0diLKYmoSftwL55kTjM/Ha0r73WAZfjF2urjZgFCk0qUERw3WT595KKX9t3I9A6sVf/BGBQeOIaDzs3m58lUw1BIhFk1vWtX91esj0gltE+1Jjx7htlkV2g8jOHZmYbMIZS18JhNtB860g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPC+4MLQX8BNz9SC97qcC0JTOO7xVN1Q1p8nJI2E0x8=;
 b=nu6NKEwWEaGhrxjvTr46dHDdOWfvUUqc+NUcENJ8DdmGrRqPML4Ng5wT8+11xoa6g3+HuvXyOTmASXWy9DIxnug6PTGVEGvn24j+4DuWYZft351rqjPWg/evRLOv+nrcB+8xHTGwt7EpY4L5PCpk13BpCD8q4FU4yTlYpYsQgyf5IWapD5SZhxv/TUJBQAuBT3y5Ze0zxsEYRfl2kCnCVoEbWquHmjOvaT77EImnLR1llIfSCtkCqlG7bqgw46BZL52gF/W/v6udQhvvLzM7DnkhiZ0Hb1/lA5KwnRiy2JjWZZOo/K0TSPWvKtngXHCWlm/G52/cr4zaYOCLSmAUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPC+4MLQX8BNz9SC97qcC0JTOO7xVN1Q1p8nJI2E0x8=;
 b=29LyHm4qS3lNXwJ+TwXlyExfsjC4bTNED08wF7N0OI1dbKcTufh0LruCmIKqnRNnmA72M7AYVDJ06rXi/GCxft0uoN3xR0/r4jo4kWLT3c3TM+AFm4Z5aBTU89XG/qC9EuS9lHixgUqzi41uMQdtxGdx7g1y3BSX5BaTQng1ALc=
Received: from CY5PR22CA0004.namprd22.prod.outlook.com (2603:10b6:930:16::29)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 15 Jun
 2026 16:15:19 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:930:16:cafe::51) by CY5PR22CA0004.outlook.office365.com
 (2603:10b6:930:16::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 16:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 16:15:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 11:15:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 11:15:15 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 11:15:14 -0500
Message-ID: <7b505c32-b85e-dfbb-4b12-24d1eb544322@amd.com>
Date: Mon, 15 Jun 2026 09:15:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Validate sync BO range before flushing
Content-Language: en-US
To: Shuvam Pandey <shuvampandey1@gmail.com>, Min Ma <mamin506@gmail.com>, Oded
 Gabbay <ogabbay@kernel.org>
CC: Max Zhen <max.zhen@amd.com>, Mario Limonciello <superm1@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <178138666764.88126.6546036881766614184@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <178138666764.88126.6546036881766614184@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 43da7b54-cad3-4413-128e-08decaf949d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: JJmsfPP+8dlmtIW+0fGy6JG+F3b9qNFVdRxDElgmuykqj2f8WuItNpe9o1lg7a+UY7Z2EiOpbE7K3JqDnCJDrKScwoFYMksyDVLwM/mYp5WoJHJ0PrSOy2WrjYiOaf/Skm/rJbcZ3lvHCL6rEMX/ZbXiDxwyrDm5OZb7wuY53+Aq6s8P8I2qCuDkWvxpdmqAMH2HA5lnCPtdEax8ucbSSBytPjE6txvzE9SQo5XOUcgbm6xuwya4lhd8eg87VKh1MB2UQMxGF254W/F+FXfaBWnDnb/oR0heET6TiaFWaHsQVNF/8Asr99qTiqY3Kvg8OxNT4wAtUJPYOTpw/tv6IynBGEjxLH4gJ8huAlPg0FjsI++wgoscI4pskJqA4TO179jSIlsMqQvEAwm0UlJR7SYpesgJ97qiwYUDcL8YSIE8Ax5GuP8j8YLEwq9cM1Zhv5+QZsPno6Qk79Rh58kEkVPJ1o6kmHAXsuC8ODX1xr21hwVR5l5ntqPh8K4tiZ55vJHzq292GP2CQyhamtH3R12T2jecVuY+Ccbra25wV9AgTIWfzVHddiF+rBaClZjmt4N7FsV59M6IxXamqnK2MH82v07aUl0JaR/fsgOMfzkBDo+yjFDTJcUoLDcSfOYBORcO84qrZeSxP8Hy7meAAO6fAXJvY8X1f21q00WsaMwgxPVIti1pOCcZETRxujCB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0lusB6PXiPBMP3KfE0mhM5sFv9GOnrOme7ewD+3nuO9cWgFjHWBcmaCZm9W2ppR5TURYVpWrta1KuWJcrj1+DgiYif6OWrjezrCNO+EKmiWs16NKHGwWJOQMAdluU6LtmfB1L5bifPWp3uu1PML9fRaGuWQrJ7EsbMFdiGTbA2SzFjSTOJSCw6jVt8bewc+H27irfVnEZk42c4dxdZVMiafDSAfzJsM7af8465KvwvLLjLw3EYiuk3wNA4f1BU7SsfSCiE0zQ8xxWzrFooJ8Ve1tbPRlr9/TX7ez3D2NCzKKZ14BL1xZ8WTNIyOGcGJw0c/qAdchobxHPddA/NcOf6o7IqVO52YTP3U8ERXX8z+8oM2f03e7vwR/wdiTLIyFDHk1uFeqQtyU49E2cyTsVC46vsA+tOdxnD0BmnkjmP2Mmq5DzK7pQSgfNq/BYalW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 16:15:16.7295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43da7b54-cad3-4413-128e-08decaf949d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
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

Hi Shuvam,


Thanks for providing the patch. This is going to be fixed by

https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/dbc8fd7a03cbc0704e8e558a448015f620547a02


Lizhi

On 6/13/26 14:37, Shuvam Pandey wrote:
> amdxdna_drm_sync_bo_ioctl() takes offset and size from userspace and
> uses them to build the address and length passed to
> drm_clflush_virt_range() for BOs that have a kernel mapping. The values
> are not checked against the BO size, so an out-of-range request can pass
> an address outside the BO mapping to cache maintenance.
>
> Reject ranges outside the GEM object. Treat zero-length ranges as a no-op
> before cache maintenance, because drm_clflush_virt_range() still flushes
> end - 1 on x86. Leave the existing SYNC_DIRECT_FROM_DEVICE debug-buffer
> sync behavior unchanged.
>
> Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval")
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 6e367ddb9e1b..c56c8fd86276 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1040,20 +1040,33 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   	}
>   	abo = to_xdna_obj(gobj);
>   
> +	if (args->offset > gobj->size ||
> +	    args->size > gobj->size - args->offset) {
> +		ret = -EINVAL;
> +		goto put_obj;
> +	}
> +
>   	ret = amdxdna_gem_pin(abo);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Pin BO %d failed, ret %d", args->handle, ret);
>   		goto put_obj;
>   	}
>   
> -	if (is_import_bo(abo))
> -		drm_clflush_sg(abo->base.sgt);
> -	else if (amdxdna_gem_vmap(abo))
> -		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + args->offset, args->size);
> -	else if (abo->base.pages)
> -		drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
> -	else
> -		drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
> +	if (args->size) {
> +		if (is_import_bo(abo)) {
> +			drm_clflush_sg(abo->base.sgt);
> +		} else {
> +			void *kva = amdxdna_gem_vmap(abo);
> +
> +			if (kva)
> +				drm_clflush_virt_range(kva + args->offset,
> +						       args->size);
> +			else if (abo->base.pages)
> +				drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
> +			else
> +				drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
> +		}
> +	}
>   
>   	amdxdna_gem_unpin(abo);
>   
