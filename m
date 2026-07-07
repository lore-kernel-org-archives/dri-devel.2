Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5542C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DF8010E093;
	Tue,  7 Jul 2026 15:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIt4bUPg";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5550710E093
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCc+mBATuUDs5hYV5E9/OQhxbX2v9TRPGQUMwhcw2WlFqOxM0NBT6BoNNxMwAfkhvlQbrTLIbqSMpDGfg9vkWfKTLrTAWLocJ5lwgDoIwzCm0sWWCecTSt+tkfX+OfFPrG/C6Jr8imgM/S44NgXrupgKLrA86/MoVOg5FaF2ec3MQs0DHhN5yBYPdBPE0m06f7bn1xAKjwVb6UMIuidZax+254rMEWW6tpVvZLp3YqQaDl10UQKEHWuVaC/TJf/z+/yEaX+1MINp19jihtclZImPcc8qc9mK8JIPMG2q+yP+slSl1tLxNlbWtZ5FgvBHuqyxsNTSNpzUc12o3jmE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLX6MDwdA+kobNNZmcQooNfVtQmTIPTY44/xXQBOPI8=;
 b=o7FBh9LtQLKkfrQ+3IpKKArG7rvqDcSpfu2a4WSSdpditXxkRB3xX+e2xhFU5wqVhu9hTUJdbja5rOmT9IU+tal3nNzMfxK5esb4Aj8uYj8kTqCk/AAcc/yEodLzGwLDEC8384cQRMV9VYSmcAU/VN19L806pjOBbKAz4lDZojBmVYioH8BHQwW6RfW74R18IyiLPJ3Is4SCS/RLGOclILBBabzVK849V6ijIbLSCL4JzksZLydvmdIDpfCy7QpEQGaHegtgwELUyiKZF5GP5mvcwzXymkt7+s/lvS/8TBFFkdILPtW0+6K1aYMO2s2ayCgve+5yqo5TligpMjEPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLX6MDwdA+kobNNZmcQooNfVtQmTIPTY44/xXQBOPI8=;
 b=qIt4bUPgBNUlvV6vFmBkLQ21BklDmBh+ME6XXLxXTN/r6QAJCnjRxXaUrAI2rqvxFCltYC965Fs04CH+li1cBfhedM0kBtJg9fJxHEJY3Zl325oiyqFlENNo8a5l2FVxELzW/mr/IclOkoCyKjQHjCJn9ziAQcCIEBr2AiEFL5Y=
Received: from SJ0PR13CA0233.namprd13.prod.outlook.com (2603:10b6:a03:2c1::28)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:41:02 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::48) by SJ0PR13CA0233.outlook.office365.com
 (2603:10b6:a03:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:41:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:41:01 -0500
Received: from [172.19.70.117] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:41:00 -0500
Message-ID: <87e4fe2b-e1df-48a3-8ffc-8e08c4b785a5@amd.com>
Date: Tue, 7 Jul 2026 08:41:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: explicitely forbid exposing pages from
 get_user_pages()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 <sumit.semwal@linaro.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <lizhi.hou@amd.com>, <Mario.Limonciello@amd.com>, <airlied@gmail.com>,
 <karol.wachowski@linux.intel.com>
CC: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260630080112.1117341-1-christian.koenig@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260630080112.1117341-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe14c8b-3833-4ef1-eb71-08dedc3e2616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pDgybSGLdqpTPhSJIA6pOb25cFXnLrM8TYrP6uYWmSKmILR/y5q15TEKTGP4rICSkLGOra8CnUzTyn+6xWd2bgb0DoZbuHkuKGs3T4lPg493DFxovWss4M0Fn58w/G1nj8+C67+7VuBm4dQwSnVchHMm57zaF9l8jEopBkBvKWrHY5+Yk6x+u5Ogj32puvGPexsRYS7ujoJJIxvWsFgn/IONI882xV3paFQ76LIEOEaih+DZdpN++rSr0RcL0FH8roLTfOtuPnF/IMKEd+8d3fgQmFYDHPakcgkFqdjRPcso3xf2Rktd9vJ0RSRL7zuuUhuSVsuguuZsvW8zTVcREymeKnbvHaSR4phUw0QaltrEtKU/eV1FrqnX3DMDDsldA+R34b5X4UmKWSzL4emDca7ZqrzOE24mXHvLSkhuehchZ0gL+wK86FSux+QKAcQNRDGhkdZGA+3fTsA0xyeEn7OdUd7i8wRZ8aJkVxoD0FgxhyINUULI2kXy3dzpIGRC5axKZkaY7An0/o/5PaB1oaLSh8eQzeTF2RdGa9IjZpzJ5E8ZyjaD11ttZnIvHZ2q0p7L0xZJBB/U7BUuXae0wA+hBTZOknF+DeLcz+npVIMUeTVCdyBpg+/Hl+hbg4zf47r7GwhMilxlMkgatBcjdsONebbbAHHUk7xljHD6aVgbZMcFIpVG28PTk8IfcPYi5koDFXsu/fCWxUb45byVHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IfCLzLSxvJV3+8IPGQqGF15fQsDYegcEjaF2w7kMD60x+AF85FPkXi6ih3PRzFSY22iXoyU5mggqwt3NipM71bvOW+Sf6lbvJTuK5eunImUsRXP5AIJwBIH6vRBvglyw4CerFxsg0jubmPABzGvyeYg8MiKiW/ItqgsmWJQXuB88O4vZ9HGxkBtJN09vxYrCIsInOo7+3tLLMlH0fPCLHSFxZPdn8f9ZU9Xetd9NBu79yf7baMbVjD5zSdgEoBmeJLMDd0urswApDYxRH91TCEbD4Hc9xDFovld5R8rCnshOOmLC9gI/ww3GX2q9KAKXfYdAy4/nrDXPnPjqF4e5VNAfIjpssYcKMes3WgcnDwPwpP030eKT9H8Jh32T5qRtgsZYqZV9tUXvwuijt05Wy37Ck4hC4J3wYZ3LaxDmX/CNzn/fezxmFtGbK9Do1b8S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:41:01.7657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe14c8b-3833-4ef1-eb71-08dedc3e2616
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996
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



On 6/30/2026 Tue 01:01, Christian König wrote:
> We recently had another incident where two drivers put pages they got from
> get_user_pages() into a DMA-buf and cause quite a number of problems.
> 
> Explicitely document that this is not something exporters can do.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/dma-buf/dma-buf.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 71f37544a5c6..aa5af4f439c2 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -685,6 +685,14 @@ static struct file *dma_buf_getfile(size_t size, int flags)
>    *
>    * For the detailed semantics exporters are expected to implement see
>    * &dma_buf_ops.
> + *
> + * It is explicitely forbidden for exporters to expose buffers they don't "own"
> + * as DMA-buf. This includes pages acquired by get_user_pages() or other import
> + * mechanism. Not following this rule can create numerous security problems.
> + *
> + * It is also strongly discouraged to expose the same backing store through
> + * multiple DMA-bufs at the same time. This eventually creates aliasing and
> + * cache coherency problems which are extremely hard to debug and fix.
>    */
>   
>   /**

