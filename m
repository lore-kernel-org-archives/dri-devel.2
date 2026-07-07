Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F23C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB8810EF04;
	Tue,  7 Jul 2026 21:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QM0W4fFC";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013038.outbound.protection.outlook.com
 [40.107.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0910B10EF04
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 21:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAnsgnTjjxajSsOp0m40umIZvMNwlVCoryPUUiF7Mf9U8OLpwo6daeIwlfPH5xCaNhZQ2dJD2nqvyYcdRttKJJDxdAsMhRGeDuWsiDqcpqttU7vjXWVtZdS9EY0oLhgGZcL1RgOUl8bCJEGERcXZFX+ggZO6ICUj9RH9lAWWCdqTHqZDTP12cKZnxIiBuBLTHc8nMe72GY6lyS3bmJiT7q6dru0Iu1bvJ8z0twIXtUVhlJaP0U4nAwB1QcvCsbIGdNQUmQaV9meHbyoZY2xihKMJ1xljBzk3tKYFw9Lf7sEAcYVMthjJdVNcH5VfT8lCyWCyPCwEgPQ/ClTmYeCh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymKTaY9dlgmsRZI8bITCI6R+SETsrzqh1peeDHv/dRw=;
 b=RzbYeF6lIAwC/LDeqIoeIGlmeyDuLUHStuO8MQdmp5P7pRJ+wJ3a3W221ohnHbUgTX7Wl/ujMl53DGJMvZItWWol4qZdylVbxClWkrblYPJ7m+/xja1CyrUO7qu5XEgxTD2uRpd3eX7b/mpfF466qUWgmV9csvHH/OSDIXH/J6MiVipPBSAPLYKk7AYPrPC1UXeYIjenh3XTY3wVX4HeOT9/8TuUV5fMStwiZNmsEZ0GwMelhHST0e/EdVs9MHBS4c/dzyyjsysRO8vlPen2M9XN5F5YLlQ7wredJLasuVoBNFH1nJ6J0r4K+hqF/+hUz8BLqni/EVt7AKXS7Jrkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymKTaY9dlgmsRZI8bITCI6R+SETsrzqh1peeDHv/dRw=;
 b=QM0W4fFCTR2vyCouB/uCgGtDAIY3FKfxkcE4UtfiYMe1tmMPFFUNQyk8tXlqHmtfm8MCCrGPTO4SesUEHH/A+bvgBc6eA/Nvt7VyeKBjL3+87hBVTGz4qa0iBiCGrxV9MQcmCvMGRrwVPLMJWGwuPxkzdO047p4TjTI50XlvC4Q=
Received: from PH0PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:e::10)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 21:38:27 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::7f) by PH0PR07CA0035.outlook.office365.com
 (2603:10b6:510:e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 21:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 21:38:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 16:38:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 16:38:26 -0500
Received: from [172.19.70.117] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 16:38:25 -0500
Message-ID: <403b4318-bcfa-4a7f-9c82-98c1bbbe5fb3@amd.com>
Date: Tue, 7 Jul 2026 14:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Fix potential NULL pointer dereference
 of abo->client
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707201556.562191-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260707201556.562191-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: c04c1f1e-bf59-4a3c-99f8-08dedc701453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: GTOQWb3Z0/6xtvWdTdc9T7nM7AR+wGeyAMbY/QUsQCFbdp3jt/l3LqXtEjIHoAzd61IDnQDs9q3iJa/0t2A51EbM8rPu8mK5nNaFy1sKWC+ttqUB+G8wB2BYsxiEgMcW1u4MhebdfwOw3g3Vg5sNf2fNXA7iKW1RaxluwB3Rix+tpooGPvZrcXVAbLblD9fKpbm0lIkV5XWik1FiKCIqJNNySHaIYnjEGo3K1kipSdVYnsbBBjr5eCZ9R5GRNkEnlODrlapY+Yo/rOwe29/8ZBU7PY23ds4j5ISVn2YlyGZXat9jVBSK498iEmqGRtX/0EXix9oswXgq+bhDgbknCY6+Skc+3hxQvTU6TFcf2fW5HwtUobSye09Zt5AS7YOHBuoKo3nGDEEr2IFQdJ3oqQLKLuC+0MSxBOJ3mWmo6meBok2IwOY4cKoyH0kp5MA70Tq8fnXLlYiFXzUYLOzVoJFlhi4hyGFTEeNBQPDtwxyM1UoWeIIInIdBHngpymsm9zfvXbkKbDQXE0BiRQ0KFYmppxbPOei0MgB089zK1OIBWKnk4d+6zDtGSEku/2sqf6/26CNlocfkcw35m53/YntGUSIg4LwCvB4MWa2ofxsdSUeDXXRxBrcSRJKhW+y1NEXcfpu6DW63jwuHmbLHyXPxMF3hvbEdqXxjPZtp4crhDErZ7lJiBSCd+AANHtBhfF/+PYy/+e3n8ijDAuTYWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9AA8PqpcchrDfDzQ+FmAmi9S51IdY18QQBhU4/8V4ygSmZrv14o4LtYDmvtZ1iYY0jhXlIBcbkK0/XX99YSuwis/OzlF9M8aKbsBHy3LEeFAmWWL3XjaJE9RRUTUycwr58M0UA3acRsnOUBmL+tmoofzUeDKbCaAVC1Wz5/htT5mq7riQyaTxSZLKyloqxQr0NRuSxHHDnpgcvkOLRxkuPsa84+3VqXo5pWPugEDclbTQfGA063m7SIX+Qaip3HGxfJtx+71g1ASTXBbNnS1LWjOd2NINxKsLyEJBSqSESkI/d7kDt0egSBb0cVFDY0qndRSaydLujHCs8RJAjhVwqwD6CV23n0rsEKWgTy765u0hx9spChMoHRGu7UApEDrDRmYZpm+q7NzYE6C60yDEQj3MA4xMmZkteY0onLYV2elXemJ65+T7YfkQSHRJM7W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 21:38:26.8050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04c1f1e-bf59-4a3c-99f8-08dedc701453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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



On 7/7/2026 Tue 13:15, Lizhi Hou wrote:
> Closing a BO handle clears abo->client, while the underlying GEM object
> may remain alive due to internal kernel references. As a result, code
> executed after the BO handle is closed may dereference a NULL abo->client
> pointer.
> 
> Remove accesses to abo->client from code paths that may execute after the
> BO handle has been closed.
> 
> Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_message.c |  4 ++--
>   drivers/accel/amdxdna/amdxdna_gem.c  | 11 +++++++++--
>   drivers/accel/amdxdna/amdxdna_gem.h  | 11 +++++++++--
>   3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index c4b364801cc0..dfe0fbdf066d 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -840,7 +840,7 @@ static struct aie2_exec_msg_ops npu_exec_message_ops = {
>   static int aie2_init_exec_req(void *req, struct amdxdna_gem_obj *cmd_abo,
>   			      size_t *size, u32 *msg_op)
>   {
> -	struct amdxdna_dev *xdna = cmd_abo->client->xdna;
> +	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(cmd_abo)->dev);
>   	int ret;
>   	u32 op;
>   
> @@ -874,7 +874,7 @@ static int
>   aie2_cmdlist_fill_slot(void *slot, struct amdxdna_gem_obj *cmd_abo,
>   		       size_t *size, u32 *cmd_op)
>   {
> -	struct amdxdna_dev *xdna = cmd_abo->client->xdna;
> +	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(cmd_abo)->dev);
>   	int ret;
>   	u32 op;
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 1275f91ca705..4628a2787265 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -198,6 +198,7 @@ amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
>    */
>   void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
>   {
> +	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>   	struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
>   	int ret;
>   
> @@ -210,7 +211,7 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
>   	if (!abo->mem.kva) {
>   		ret = drm_gem_vmap(to_gobj(abo), &map);
>   		if (ret)
> -			XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
> +			XDNA_ERR(xdna, "Vmap bo failed, ret %d", ret);
>   		else
>   			abo->mem.kva = map.vaddr;
>   	}
> @@ -354,7 +355,13 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	unsigned long nr_pages;
>   	int ret;
>   
> -	if (!amdxdna_pasid_on(abo->client)) {
> +	/*
> +	 * When PASID is off, amdxdna_gem_obj_open() called amdxdna_dma_map_bo()
> +	 * and mem.dma_addr is valid; use the DMA address directly and skip HMM.
> +	 * Avoid dereferencing abo->client which may be NULL (cleared in close())
> +	 * while internal kernel references are still held.
> +	 */
> +	if (abo->mem.dma_addr != AMDXDNA_INVALID_ADDR) {
>   		/* Need to set uva for heap uva validation */
>   		abo->mem.uva = addr;
>   		return 0;
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index a35d2f15d32c..1e90e32bf3cd 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -88,12 +88,19 @@ u64 amdxdna_gem_dev_addr(struct amdxdna_gem_obj *abo);
>   
>   static inline u64 amdxdna_dev_bo_offset(struct amdxdna_gem_obj *abo)
>   {
> -	return amdxdna_gem_dev_addr(abo) - abo->client->xdna->dev_info->dev_mem_base;
> +	return amdxdna_gem_dev_addr(abo) - to_xdna_dev(to_gobj(abo)->dev)->dev_info->dev_mem_base;
>   }
>   
>   static inline u64 amdxdna_obj_dma_addr(struct amdxdna_gem_obj *abo)
>   {
> -	return amdxdna_pasid_on(abo->client) ? amdxdna_gem_uva(abo) : abo->mem.dma_addr;
> +	/*
> +	 * amdxdna_gem_obj_open() calls amdxdna_dma_map_bo() only when PASID is
> +	 * off, leaving mem.dma_addr at AMDXDNA_INVALID_ADDR when PASID is on.
> +	 * Avoid dereferencing abo->client, which is cleared to NULL by
> +	 * amdxdna_gem_obj_close() while internal kernel references remain.
> +	 */
> +	return (abo->mem.dma_addr != AMDXDNA_INVALID_ADDR) ?
> +		abo->mem.dma_addr : amdxdna_gem_uva(abo);
>   }
>   
>   void amdxdna_umap_put(struct amdxdna_umap *mapp);

