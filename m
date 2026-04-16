Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F332CF8D753
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A1B10E908;
	Thu, 16 Apr 2026 15:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TrYOwCmQ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A46F10E8FE
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 15:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nixYgatQRROQPLNGNov9sGUtHi1ji2hUTztJRzoBsW3abWP6R7xFBxiSLoNHcoLSa66pFdjWWOiioE2bwxd9uQ72haMIUzVCdHND4GeHcYmoSbB9k1KL1ArPytP07RSlv9irgtrKYw6HG2kN7c3WuIa8VtHZUbbsCPRqexQ1mb61W9p8EZ/LClpqIChe7KyWoU7yKviFAjeST11LOgqWAMWjnBTuxviqV2iuv4fvOZeYaC6UKw9mC6Xc+P2BgkqYYXvWaQGqAtRjy08gpQcgmRpsVxAXFCqhTlpU3hueL4gS51+Tu+9h1e3eAhGmwkplSkcm1VlkbHZrjmo97VUnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z1lzkg6ITJQ//qr2pUXBKQj5GtBUCUJdesbQJIskwg=;
 b=J/+0/mNdKOzPWdmix/fLz7ATj0/25s2LmK/ejE6Z34WpKnM1co1AAHzLcNKWAODh28eQdJOi1loIUd71+CDZNPcplBHtPnGn34B5WQVJdUhNiPX/hgFWvhvYi0+XyWURrC25RX3Xv0gbTqVBb9/uAB+LTmUthQ5NAxzb4UuLkkk0taab9ZmYI/81VA3OXWJbYFwQDZDTsEjkkFAyATzsOdwNZFUF9yweDB+9B73sZKLLIdr1I012SbLPbkFMUuavOt94D5l3BQOSn+cDFs2Gi3IeWrwjRn2AMXnlh4LGcDf9jOuWTX5wwtoJPU1hRG2tuaqcoVfaEIwAd26PErJsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z1lzkg6ITJQ//qr2pUXBKQj5GtBUCUJdesbQJIskwg=;
 b=TrYOwCmQkwiME8GszG7AZZHdk2hWtXkT9OcE8yIq+o5/I3LfP8YmlxuS8ZkBtm/OExoi+BLBAdgrBTi7+nTcJJIwNLVLbDBZ29IvFfJ21WUqKF4b4gPaGs0CppD96D6VE3XYv1Bh0MK51RN/r8tzTBjhCV9iWrNpE16zb9srob8=
Received: from BYAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:a02:a8::27)
 by CY1PR12MB9584.namprd12.prod.outlook.com (2603:10b6:930:fe::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 15:58:20 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::f8) by BYAPR03CA0014.outlook.office365.com
 (2603:10b6:a02:a8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 15:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 15:58:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 16 Apr
 2026 10:58:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Apr
 2026 10:58:17 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 16 Apr 2026 10:58:16 -0500
Message-ID: <a44e8da0-289e-bd13-db30-d2a614da368e@amd.com>
Date: Thu, 16 Apr 2026 08:58:11 -0700
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|CY1PR12MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: b31d6e3b-556e-4b6c-3bfb-08de9bd0fb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CI4mTcQSSo0O7xthqFbN6QFHWvyS4mLufS19oZzQ95kR9y3yO0mCxFTkcnnjzv8n1W4CxyFyGxNE9dsuBWzx/brP/hxO0YJiUMnSL1Iaq2UrHa8U7WyVxMMMjoyXAp+ggC0UUXbF01ET8iaR0LkVEaqmkoSMfn8B95rJPWGZuxws30XXhy9IdAtAtYypvNaMLDKVxAEClcQsrNmEHkuuhbYAQuZF6JkEhMBmiUeeoWQj7QCOkXTCNuquvzGmUA0w52kq1e8SX685G7bJUndScH30zY32lVPe2nR3bxOU/O+aayN0+J1CFlvcw6/zOQBoPV5aAnRDhfkL58WASs2fGdtVRNiDLehVeRHwg7a8BKYY3K4rDaCiWfy/pGXFKDQCOiQUc9xcBvhiLqB0tZxHR0sjvst1qGj8k6yPRrzsVepSdGQRtkazvlqlVRBT82mwWjT7EPNRt4RlgdHUNAE+1nqC8jQX6UwCw32vmHnd5WgIc/VlDv3JsmOdws1PI/SZQl5PxIRO8ba4U2wmTIwouU/zASYeQcHenCPyEGlsKAyTF+p/yNwVdmQWEqXSSenB/pEWxt8ZJxtYQPZptVm91YkCQlDUMqpVfLqCfAeWKGlC/+olEfIc4n6FtDpG+4LKXA+3Gd/9ZJn04NoLWz1LHi02gmDQgU0X6xNn42eU9MvvE0SnsJSfK7vdeMjG1/1SquF18D9tUJZoWiGOnu+mCEeDyeYy87T7C+ZiClhnLNH+idQ0PFfWwFHrZBY3vpwqWQ8DGu3Q7tJEIBl+jAy2Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lcJXIqxIHn7vM7vjJslgKohDV5gu19isRhe1xy1Iv5CUiYKKuOHBfQzywYkyy7odPtU6ASWL/8cuv+skOcMCMFrtWn0P42MAucjcFPstZwdoZEX+cZep6fSKVl3+eF9UK2tqMY0KTzAhc/PaqyKg6iO01EddxaRkHfZKpyon0jL7+S/trMyy921hvvTubMn6bwHjoqKKwS1RaXCkvQ1FkA4FX6X+4kQ+nJFXmHpZCA7AWOOD3az6Fnio6hRlUUDujFNP9Tu0YT8xj7O1gZztHkBYZ0b+WMr9Yl8kXJQrMRZ+QKSf4OmB3WxHBb5QRLUZw2eUym9QehioXxl8w6q6wXkYE2Wu157VBnK3ERvl07GB7r0Zqg9ftT7YE3/dWtE1/dha+E5plA+Aq1e6Bem/SDBpoJhJGToujy+wVP7tigV0fOcpmI5Eh2fTkgqsGX8/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:58:20.3269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31d6e3b-556e-4b6c-3bfb-08de9bd0fb46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9584
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

Applied to drm-misc-next

On 4/16/26 06:37, Felix Gu wrote:
> [You don't often get email from ustc.gu@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
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
