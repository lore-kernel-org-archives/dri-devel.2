Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E0CC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164ED10EDAE;
	Tue,  7 Jul 2026 15:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+LasTBe";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0D610EDB1
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6jnM6gK42Cyd0tuRcVzIWTmQt0Z76gInNBgWHGKYBxixJZ8CHfzQwJm6gxOr9ttAodfvuWUtIpR2DuzjZmjkpFJd/3rWnC4zlz6hYKBErcWfbvKWkCMRZLzuMsS39Nr4hvRIO6kQAobzMRnwDgAbZKKym/NrTCBxJK8RvYsx/OM51lyRTEUR1kj7mhQw9A6Gs8vTWFN9iKSg138qAWJTlYi8OYqEjxArXPpG/n5Yp7yG6r0QRfMBF5Q0Si4OQvUYohf/rDnWzKYgHIUMH9r6dCKQxItgroIqc5wuQ2/x+Qhr0aGwFtl00ZqIlWHYxV+5Dq/EO67iQWNTqH8aHyhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBCc9blYqkUVV9Oxfbt4Y5xCyZTM/yNU3yJvgKt/dAU=;
 b=eK1+b4heyiW/fsHyDw2nSJtgW2taUHvggMUe5Vkm86Hp73VD3muPwvnnfICA2KKcOLtT4C9OSIQUZX5KSp//82mZk6OovMCifl46KM4W/Mn4vHyD1X+o+XEfD7KPaRBp+x6KQ00h8Rjomp6SGVrMPVXdN7PpE+/nz4cK/CJs5veQaGAW2188SnBA4cW072EFarTeioTG6XyCWeD+yebB/DY1DLySn0J25i05i7ZCDt/do8FfbXtoqfQuO74Dbzgxau3IIFh3NvfgZgkzjSoaOSP+7IBJ2HffLrGqcoOzFBknuf/ksCuKTqoPF3fcJkC3DXoUhCMjwoO2ahJPxDpJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBCc9blYqkUVV9Oxfbt4Y5xCyZTM/yNU3yJvgKt/dAU=;
 b=h+LasTBeStoxgZxAcn6aAE5elrsXLrpPAX1kmMNUG2/A6uguhMvLr5gscoG/aEep/PDXeImjeXWlMIJnQ0kF1br+bC+p9gv3rgu0lbqjLkMgqs38ZiqER54fVqirE8YHekzKBMf6remZMAg9RpubB3+lp49CsbzCWIIXc1LjfL4=
Received: from BN0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:408:ec::24)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 15:09:15 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::62) by BN0PR04CA0109.outlook.office365.com
 (2603:10b6:408:ec::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 15:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:09:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:09:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:09:13 -0700
Received: from [172.19.70.117] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:09:12 -0500
Message-ID: <79627c5e-7ae4-40a6-8181-a611da01256d@amd.com>
Date: Tue, 7 Jul 2026 08:09:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: fix open_ref leak and stale client
 pointer on dma map failure
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707055658.479049-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260707055658.479049-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a41dd34-fad2-4bbb-0978-08dedc39b4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CL0lZHSTbDHGrzA44BrLIdE1+W67ax0fScR8xuL0yQI17URj9P8WPWQoyRJadIPu+TEUAdMxLzbwhbMV93UP0qGhwVsJHrl8SgSU3fa8t6Ov/2VYVHSzaRnnIx0BtO7EZpOm2oBqHOWnptzV6ezq6vpoU33vfz41c/Pj72WC8WKT43FJVUOaLqfUvNk+S+MEpaVvMxTpzrDi3iE7j/i1AbDmc2BiB0HHGkr5N3f9sDGQoTMOj683k7nuzaZPuRZzi3MbVME/1WArioWtr3adCQX9cpaJdqo8AIjcLtIlXAqnYfS/ZZZsYaj3kyuKJcngHPtE/SBCmvTBACF5xocO40Q4Vjx6O+ZxSxmlbDwOdoXJEBu6iZm0cXhXxeLt2LdLlcFJu4ibdLGcyQj3KRlxac5onnnWBe3KHebjewihtm5DJEg6Ings8CQaOJPRXP9Lc76I2myL/yefm8he1n6NtdN9TUgy6RCUM4CIrj3qANMvtOBhKodZVSLDaa24+8Gm83P6edbYcnGwySkMdwfncEkWy8wYiHJNtw4QkR5b8UZEOfzNdVWccPmVyodGD6QGF497fTOEs2KIrrlmDZ4A06casOFaNVm/PU0G/7wTLGHWHM2rxLXEjqbWjgmpB54O9lXpn8UyJuNJHOxXS3+aVrIWKOmUjkNaOZ2d5ogC6NSxZIKNPvB4dE6gMyCnZg+h1ie0tASuJe0tEZj1bwDBSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bkZCJ9MMo5I/Cim06yF+6PkLVBBJHlrGE5F3s4mJXbv+woIb+tzqby3wXfGWCKsGmWdy2pW2p6mUNLe6CSBYeMk4goOw3oS0nvkgdn3Tzq0jexs6SvBU8NTWIrEEwkq7zxjal0Da8Co4M876naERjZhK04VfG/WCvGwdhFqpZqaUsTFCwvo9H0YG2raKTTDT7F0HbrZw02+pCPOyZHYH82y0NTq5txQ6qEUUznkLrrqxCdBOybKDNnoG6cxyGu6eggEcvHnXpVKhikn9bEYm3DL44ntm7mYYRMX7MmmFdWWJhnaetQN2Var9X2jrkF40wAyBaD9x0vkeVpFKpSrLgX81KPV/CdANTvzlLi18Wf3SA9nD9DYji1Accu4/KWzLEeF4MlKWXnLuFr+x6hpjiWAC2+nDgP4CKtnyV0mhniBfsFMqAuV6UbUidyT+P99P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:09:13.7949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a41dd34-fad2-4bbb-0978-08dedc39b4d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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



On 7/6/2026 Mon 22:56, Lizhi Hou wrote:
> amdxdna_gem_obj_open() increments open_ref before attempting to set up
> the DMA address mapping.  When amdxdna_dma_map_bo() fails, the function
> returned immediately without rolling back either change made on the first
> open (open_ref == 1 path).
> 
> Fix it by decrementing open_ref and clearing abo->client on the error path.
> 
> Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index a4bd9e86bc8d..3f03d2db1603 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -663,8 +663,11 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
>   	/* No need to set up dma addr mapping in PASID mode. */
>   	if (!amdxdna_pasid_on(abo->client)) {
>   		ret = amdxdna_dma_map_bo(xdna, abo);
> -		if (ret)
> +		if (ret) {
> +			abo->open_ref--;
> +			abo->client = NULL;
>   			return ret;
> +		}
>   	}
>   
>   	amdxdna_gem_add_bo_usage(abo);

