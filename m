Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C86CA6011
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B469010E16E;
	Thu,  8 Oct 2026 17:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sLT8s0Ji";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEF810E16E
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ei336h801CKxoO72dcPZd9U04WLodDN/Vvyq64yuKbb4nUbuP3dAkbxB5n+Hr35fQ+d55WS0RsvSR4hVpkUEigdzJSuib3f0qgu4GUzKVM/1dZtIk6JdWZ3okBeDiiv+dlmUb6FfPIxZEhuONH27jEbwZ9lb+dHdsrtzJrEZA6QJSHNAjz/wMc0aDF70dUqkI/4FYTbhkIu+UpCpH/DFQXzVpimYXKyFT6loMSiD1skQCxb+3JMYOt2XFEgXRWf8WF3/VUQfcUqkSB8mERmQ833ULlN4jXsRi7MpuBbTxGIoEUZDXM07SRN3u4OhEClKA7KEH3QCRiOmF7QUaSCWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayLJL7deR/RkfbFu4ZXISzPOLgDiRJVP/MnhM2jodbs=;
 b=cakTnHS6l0Vk2h/Sgrb26M2JmHUw2VJ/1DDHNh5wQEFUzTCB+a+46zgHFk4Gi2Qv0rYn6/fAJ5bs7Y+Q5CsWdQ9rwASmk6r9gPtPjEigZ+ajqEOjr4A8iEpHQuf1xkhaBQsHbwmo26SquT+lcGEHTK53V/d2aI9myttWO+lpryF+7AU1YjBhwcHSSwaaNPiIaOOQscaHvu7pJ5w93rEYFlUFViUoJaVGBYyhE4OIacUDomphmKLeDdc2WftfRyOlB8hnJjhhDWoifRXfSAYMrXnGGhvGmoQoww5BZD4svyLYTIs63soumVVyb2d+Ku0KINlPQGbbNz6ZsnumaaZJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayLJL7deR/RkfbFu4ZXISzPOLgDiRJVP/MnhM2jodbs=;
 b=sLT8s0Ji0q9suuVOup+r4wakHixlKjPX2LxoiqbnzuRLrLUWQjYsMJNrlBYWDLPZh9WIIslbp7kt4eTLb/A43w3g7hk5meAkPoqPnW8LtQEGCRotr+3NmprZ/w1nXAzdA8g6Vz54ywhHo48mBwXP/S1bcQieU0LxkTo8S8/S0XI=
Received: from CH0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:610:119::25)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Thu, 8 Oct
 2026 17:15:42 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::32) by CH0PR03CA0375.outlook.office365.com
 (2603:10b6:610:119::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 17:15:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 17:15:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 12:15:36 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 12:15:35 -0500
Message-ID: <7c3628d9-6cfb-2cf2-d0c3-034d73f61210@amd.com>
Date: Thu, 8 Oct 2026 10:15:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 04/19] accel/amdxdna: Upgrade firmware version to 6.0
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-5-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261008032348.2044667-5-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d149f98-a465-4652-aeb8-08df255fc7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|4143699003|10067099003|11063799006|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: h/GLWQQLqzUZveugqYc/TKXBlL4EHbPXHshTOzJGufX+ee3sQyOg5vSDeoa380JENhWjCXk70WyfN3ONeYTJXipjiDCF/7ELG3ZVAOYhzdx/Pzl49pgJxEpV21nLEiyvp09uvyPHoUomM7T6x6wdaK1EgxoYKrpiO8V75W3z772pGwy3pLVLXlYkWE1jLS0bVtiLMYuchglh+oVstBNh3oSklGSsKrLVZK2NMcEzyHim5+CPLylPN9IatM14J2WdCCeiLLPGIGK2jNSiVVicM2vCIbV/Xm6YyVrlFwvuDNiT7/mbpUAR4KliG3iGsoP0TbHW1lnuPF2OtvPKZgz9nbLPuQBGGLtNcnYGupOUWdInSnZR+oIZS5FmKVrrvT0PpYqr2zrbBBfCKwgD9vqKNHQpPIK/TIl4n232DrvrBAP0oMHH0l7tqsW+qY1PN0SqLAlIa0zoQN6qcoONuxAADaOtlpp+RwJ8GnJtsTZQAYjugVQqFU4XQAh1sn6MzCGnYZIetM96p29F4naVQKc0M2OmfDeraqa5OdCXxmQKIaZqC0c+RPKo1rm4hx1c+LUDKKeYboTrOerX8WR3Cw7qtBngYZ4lcuTgJw9YYlhdPmTgOIzwyLj1e6P4WCeWLH238ecDJ+ta33LEiWy3Nxr36bMNkcrY0z8p+Ewo3Z0jcici4as8e7FIvpFj8qi2GJViny+0FWjGC0QhYMLmokjm/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VAk2nMMl425P12GKW2PrbXH/3lH2wry+PLt21pJVtL3JpfiXADDwJUqZgt27aU3w4gVRNrpbdbY9PKK8jTpCLzfhkZ2IetQ2usszpJoP+bC/7asp0uElVQNoIyVzPE1BX363/3T7R2Z3+YqzL+SjkUXUG583QSbYgtAlx+KbjHOaAXcu0nGPnDF9q0Qui3bbXp5hiweABW1/ktI6DSjLDxBGB3+wzoda6dr3em2/J10WyIRKLPs2uWbnOwRWjLrsGrayFEPV1GHMLbTD9ft1uWpfnVGyxmfNnhZHr+ZP3dFgr/gL+8qSxPLPKkZj0wm7ZY+DRCd9toMsqe0JLmyi4YBw2V2QLVneiy4dRwu3dwGpqd1mq2UEL2pBKg9n0wTXPpPQPe8taUIfJ8YBdw5dFgH/EDWn5FG0jv6BP/lQkOMXQ7fZw1CQsDtdL3UsN0un
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:15:41.3841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d149f98-a465-4652-aeb8-08df255fc7d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
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


On 10/7/26 20:23, David Zhang wrote:
> Upgrade firmware interface version to 6.0. Update host queue layout,
> opcode definitions, and context creation/destruction request structures.
> Parse priority band and PASID for hardware context creation. Protocol
> compatibility for this queue layout is validated against the CERT
> firmware protocol version.

Maybe the patch should be "Support firmware 6.0?" and mention fw 5.0 is 
obsoleted and will not be released.

Lizhi

>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
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
> index b137a2a40b34..bdbd1d116b61 100644
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
