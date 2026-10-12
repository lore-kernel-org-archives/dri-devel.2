Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B3DCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE6C10E676;
	Mon, 12 Oct 2026 20:41:21 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6963710E676
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZkURGO+PHsQHlTmsa5gaoLXPdIV50v+tK6XDcMUqAVu+pIGzmd/IIX8LYtyOtqQeFrr2lbFSfvrbRhxAMfTqcKCXR+vrlHscP4K+nzBSme7LUPX9s/LXQ16jCnAWedu+WxZkjCCS1EypZJyEV0wphb1v0rfkIr1iz4+1HvQTvLwTh8dtNuB/++BLtUSRz0rvJlUwCKiv/C3b3dgrkxfZukt4aikWE4TU2fTZmAN4uJqkRKBWpOAOywmucwVApm7D1Ka61P/7KFdPWY/Zgv/ocPou1GwULX1QzuOmKy4DDKe86pkdzv5a7mbr8PSd5pHBCtN6P6rG2T1spvM6FyTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiSYV76NVGOkMDaUu1ZBVgkwafaHBTtw5T/g9SE8Ibw=;
 b=yp7QWn441s54r1+kXxip3xZgBaG3UcKtemkazieHnsiaVa7dnp/8TwON12TQr39QrcoaBYqWZNDiDUxVlvYKouFXgKcHofL2xTpFuLEXNfFMXS99wQgk4d+cQKyQnCACtcALq0ZJfLkZQm8DtXfBjLSO2vyzpi79ywUVxAbMzo+CShajTvf27HhSeZYGtuEjluhT/wBtzMecwAnQ5XRAG/XgET3bReeJjVgwJBfxFOyle22pnWsDp+mh0e7YpJwtiej+uH59fDExXcJWgx4RFzSJExlkU4zrTEQ9fiszrpVP9kCqJgYAS1pb59oMTdV1J4dRwUhfECbqzGN69SVq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiSYV76NVGOkMDaUu1ZBVgkwafaHBTtw5T/g9SE8Ibw=;
 b=HCZh+AK82ipgjdDxiKCQheeYRs4z+l0J9T+mxcNcJUcENtZeKXQxHY8ORBr5HI0bEfdl5SKEKoiZATDc4C+k8IBrEJUeDZAcRDuKDNnMhpLu2ut/z8yg7t6YS1ZF4xaFSKg2qh6Xw37mwiu4mEQFRvLN7vilFcMCvQtrRsDBdEI=
Received: from MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::32)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 20:41:10 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::78) by MW4P223CA0027.outlook.office365.com
 (2603:10b6:303:80::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 20:41:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 20:41:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:41:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:41:03 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 15:41:03 -0500
Message-ID: <a1fd9b85-f01d-a016-f097-0cbd7bbf4da4@amd.com>
Date: Mon, 12 Oct 2026 13:41:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 04/19] accel/amdxdna: Support firmware 6.0
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-5-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-5-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2c2d60-8089-40e5-f2ce-08df28a125fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|4143699003|11063799006|261009223027099003|22082099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 69Zo2y4cZdmTMcHy30giObXGA54rZSfvwA6ZvDwG9T1OrqOYu15hSkH/vELqCxkYRyXjuJzGJUAO8ly2FlmiQPI+oqSd2KunMvzBu6JEhP+OMIcgFstyv3OHhL9fz4/PnGJ0qwF4pyF3gtF+0SdDO1Ilneq/Jb4Wvf7qi7hGIIZ/UHYgTytm56MSfcrTpJM0XVesUpARcFFb3fiIyHdVlhbM5yiMzuDvinrlZeYlPhYSwpdmNCkhH5ptMfqblXVup1wa//FfvmO6zteW+SDy7WmKD/Uwdp6a2N4iLSDn6JNxFdcESeqq+XWsvgnAlrbsqfeolA5OzTbLn7Xt8sm3bNXM2G7dz73fhZ0MOxnOgi5P0fj7M3zJD59W6KvjZwZOXAPS8n+bRmdBVwRq+E3rHIwvpxN8Evv96D1pO9A5ceWqSqzdmpaXAyx1eBufFxNBEjWkka0AzG2gSRkzNDr34u506HHWetvdQeTV9BVfC7UcqGFE3SD6/JXrlwwCyznty6XtvjAg1PaExVqacHJM6XojsA23zQF/T7If6xWnXKBnEewD/PZLYMJNaeUdprHciNoqqDoEsEHlhigvJCcbWFd3X3QI5xixpJDlHLsaRvhnxQQoFyr8dBUSizwAnENAg7mDqiFprZXsO6EMcbyiQGkVbWdqjrn6lTTZFn/hWriLI2nUWxuCuRSh1BEtUFbfBXl31ndwdJNJcO2nHr8Q0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(4143699003)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SYfBbw8nH+pn3aZ/q6tFIUCAvwIcztZ9TUqu0JKU+iYfi9er8JCoj5Idz51XFcvDC/ZMQSUl1/hoi1SpDHhmr+ApLi5FgJStwiGMcKPeR7ZzkCV2pOuZYzQ7kt0lj4GUmza9e4qYkyun61eJV8DUq+lgIXXo+5SVkFLefzxwcSZALxKdAdKDCqdUA4tMvjWNfvHu7Dr6GV0OgFQGnv5z0P5YrrRh0PVrLhI/8BBsuSqZpvSbguTy1chBDQL2msj3lQTgCZYbzu2eZJBCSScmXUd3MKm1HAPRiEn2k3MJNw6zhXH9qYLoYYLgE++N+QEK0fQYs/NtPFBHInBBtNUZ1l7QW83/25vQzstAxUYsSP+omZFBJXgSC9FkYHAbXcLWRc9wItAUXJvLg/Ub7XHponXxyAx7HBTJnfQD2+tL1KPdbbpZBpe0vZAwqWhPjuZz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:41:10.0650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2c2d60-8089-40e5-f2ce-08df28a125fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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


On 10/9/26 15:53, David Zhang wrote:
> Support firmware interface version 6.0. Update host queue layout,
> opcode definitions, and context creation/destruction request structures.
> Parse priority band and PASID for hardware context creation. Protocol
> compatibility for this queue layout is validated against the CERT
> firmware protocol version.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_ctx.c        | 23 ++++++++++++++++++++---
>   drivers/accel/amdxdna/aie4_host_queue.h |  7 +++++--
>   drivers/accel/amdxdna/aie4_message.c    | 11 +++++++++++
>   drivers/accel/amdxdna/aie4_msg_priv.h   | 20 +++++++++++++++++---
>   drivers/accel/amdxdna/aie4_pci.h        |  1 +
>   drivers/accel/amdxdna/npu3_regs.c       |  2 +-
>   6 files changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> index 8157f2a6fd10..5eb918e1d58c 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -9,6 +9,7 @@
>   #include <drm/drm_gem_shmem_helper.h>
>   #include <drm/drm_print.h>
>   #include <drm/gpu_scheduler.h>
> +#include <linux/iommu.h>
>   #include <linux/types.h>
>   
>   #include "aie.h"
> @@ -110,6 +111,22 @@ static int aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_context
>   	return aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>   }
>   
> +static u8 aie4_parse_priority_to_dev(u32 priority)
> +{
> +	switch (priority) {
> +	case AMDXDNA_QOS_LOW_PRIORITY:
> +		return AIE4_CONTEXT_PRIORITY_BAND_IDLE;
> +	case AMDXDNA_QOS_NORMAL_PRIORITY:
> +		return AIE4_CONTEXT_PRIORITY_BAND_NORMAL;
> +	case AMDXDNA_QOS_HIGH_PRIORITY:
> +		return AIE4_CONTEXT_PRIORITY_BAND_FOCUS;
> +	case AMDXDNA_QOS_REALTIME_PRIORITY:
> +		return AIE4_CONTEXT_PRIORITY_BAND_REAL_TIME;
> +	default:
> +		return AIE4_CONTEXT_PRIORITY_BAND_NORMAL;
> +	}
> +}
> +
>   static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
>   {
>   	DECLARE_AIE_MSG(aie4_msg_create_hw_context, AIE4_MSG_OP_CREATE_HW_CONTEXT);
> @@ -129,9 +146,9 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
>   
>   	req.partition_id = ndev->partition_id;
>   	req.request_num_tiles = hwctx->num_tiles;
> -	req.pasid = FIELD_PREP(AIE4_MSG_PASID, client->pasid) |
> -		FIELD_PREP(AIE4_MSG_PASID_VLD, 1);
> -	req.priority_band = hwctx->qos.priority;
> +	req.pasid = aie4_msg_pasid(client);
> +	req.pasid = req.pasid == IOMMU_PASID_INVALID ? 0 : req.pasid;
> +	req.priority_band = aie4_parse_priority_to_dev(hwctx->qos.priority);
>   
>   	req.hsa_addr_high = upper_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
>   	req.hsa_addr_low = lower_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
> diff --git a/drivers/accel/amdxdna/aie4_host_queue.h b/drivers/accel/amdxdna/aie4_host_queue.h
> index 1b33eda3f727..95ebbb714c6f 100644
> --- a/drivers/accel/amdxdna/aie4_host_queue.h
> +++ b/drivers/accel/amdxdna/aie4_host_queue.h
> @@ -10,6 +10,7 @@
>   
>   #define CTX_MAX_CMDS                    32
>   
> +/* Host queue header layout. */
>   struct host_queue_header {
>   	__u64 read_index;
>   	struct {
> @@ -17,8 +18,10 @@ struct host_queue_header {
>   		__u16 minor;
>   	} version;
>   	__u32 capacity; /* Queue capacity, must be power of two. */
> -	__u64 write_index;
> +	__u64 padding0[6];
> +	__u64 write_index; /* different cacheline from read_index to avoid false sharing */
> +	__u64 padding1[6];
>   	__u64 data_address; /* The xdna dev addr for payload. */
> -};
> +} __packed;
>   
>   #endif /* _AIE4_HOST_QUEUE_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index 53f8e366b66c..f67aa8ba943c 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -5,6 +5,8 @@
>   
>   #include <drm/amdxdna_accel.h>
>   #include <drm/drm_print.h>
> +#include <linux/bitfield.h>
> +#include <linux/iommu.h>
>   #include <linux/mutex.h>
>   
>   #include "aie.h"
> @@ -14,6 +16,15 @@
>   #include "amdxdna_mailbox_helper.h"
>   #include "amdxdna_pci_drv.h"
>   
> +u32 aie4_msg_pasid(struct amdxdna_client *client)
> +{
> +	if (!amdxdna_pasid_on(client))
> +		return IOMMU_PASID_INVALID;
> +
> +	return FIELD_PREP(AIE4_MSG_PASID, client->pasid) |
> +	       FIELD_PREP(AIE4_MSG_PASID_VLD, 1);
> +}
> +
>   int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev)
>   {
>   	DECLARE_AIE_MSG(aie4_msg_suspend, AIE4_MSG_OP_SUSPEND);
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index 5b97c8057de0..b9f7c61f36e3 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -12,7 +12,6 @@
>   enum aie4_msg_opcode {
>   	AIE4_MSG_OP_IDENTIFY                         = 0x10002,
>   	AIE4_MSG_OP_SUSPEND                          = 0x10003,
> -	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x1000D,
>   	AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION      = 0x1000F,
>   
>   	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
> @@ -23,6 +22,8 @@ enum aie4_msg_opcode {
>   	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
>   	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
>   	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
> +
> +	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
>   };
>   
>   enum aie4_msg_status {
> @@ -32,6 +33,14 @@ enum aie4_msg_status {
>   	MAX_AIE4_MSG_STATUS_CODE = 0x4,
>   };
>   
> +enum aie4_msg_context_priority_band {
> +	AIE4_CONTEXT_PRIORITY_BAND_IDLE = 0,
> +	AIE4_CONTEXT_PRIORITY_BAND_NORMAL,
> +	AIE4_CONTEXT_PRIORITY_BAND_FOCUS,
> +	AIE4_CONTEXT_PRIORITY_BAND_REAL_TIME,
> +	AIE4_CONTEXT_PRIORITY_BAND_COUNT
> +};
> +
>   struct aie4_msg_identify_req {
>   	__u32 rsvd;
>   } __packed;
> @@ -94,7 +103,9 @@ struct aie4_msg_create_hw_context_req {
>   #define AIE4_MSG_PASID GENMASK(19, 0)
>   #define AIE4_MSG_PASID_VLD GENMASK(31, 31)
>   	__u32 pasid;
> -	__u32 priority_band;
> +	__u8 priority_band;
> +	__u8 priority_level;
> +	__u16 restore_id;
>   } __packed;
>   
>   struct aie4_msg_create_hw_context_resp {
> @@ -106,11 +117,14 @@ struct aie4_msg_create_hw_context_resp {
>   
>   struct aie4_msg_destroy_hw_context_req {
>   	__u32 hw_context_id;
> -	__u32 resvd1;
> +#define AIE4_MSG_GRACEFUL_FLAG GENMASK(0, 0)
> +	__u32 graceful_flag;
>   } __packed;
>   
>   struct aie4_msg_destroy_hw_context_resp {
>   	enum aie4_msg_status status;
> +	__u16 restore_id;
> +	__u16 resvd;
>   } __packed;
>   
>   struct aie4_tile_info {
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 8c62ee6a9b23..bdbb2d7cf0e7 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -75,6 +75,7 @@ int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				    struct amdxdna_drm_query_firmware_version *fw_version);
>   int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				     struct amdxdna_drm_query_firmware_version *cert_version);
> +u32 aie4_msg_pasid(struct amdxdna_client *client);
>   
>   /* aie4_ctx.c */
>   int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> index e82bc0a4f597..93f749acb5d5 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -38,7 +38,7 @@
>   #define MP1_C2PMSG_60_ALT_1     0x3B109F0
>   
>   static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
> -	{ .major = 5, .min_minor = 10 },
> +	{ .major = 6, .min_minor = 0 },
>   	{ 0 }
>   };
>   
