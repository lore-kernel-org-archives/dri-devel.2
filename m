Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31C7CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619EE10E103;
	Mon, 28 Sep 2026 17:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OVZF2cYm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D60A10E103
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 17:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/wbuq9RX3fAlY6AbvBMNub3s7FBDPozRIWJvdYa9wTnvmxG1gD4wXKv4mvFZOGcOrfvbdl/KOXST+YS1OLPg/xNwCQWFSdDPewhEVkY+O8yQGLkjbU0xf/3caPUIu4jvsrSQiOLW8PIsW2cPGViMNOKB5HgiBoeb32EC+pyugMmn2xbdg3r5ZotllwAchPOULzhIxVKGz5hKr2UmMaBcqNYPdx6GUJr2Y22POe7dD+r/hvwY1kOA3TXr1T0dDiGHOOPsMKZxCT1d4mNx8LYxWzinlJeWn5z8053qaautFsmSYyeuUmZzsnmBXYd0QgmaoG/jv6i/1cYvxmJmv9n+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jgt2df9UmPJTMkL3wt0hHKqzn9dpZV+x9YIYxktxBI=;
 b=kyy6C+l2hu9XnTg2KaaZGtNq9MlPvYP7/bC1AvGsWPOYTX7PlKYkBjCL08dZcHJmqe+QqEJ9Qf8A3OQtPnQ60PNypk1GsRhyNNXADPwLWKvgHoE5/pU24tAY8uxb3mDH7u5fG+vOhrfu5cQcFcx+xMGOxvEHPOUJwzfBLk82V/dwN0JNwwEXQjDiH/EuU6t6FKmKHSJUK2eOxujHx9z/zvz9B3PVrhkuBZCM3mc+nnvRjsVQmIbZ0aRXqfK355qOhUTzorOHXGl2Jb14VbsrQFSp+3eRejKwAl1shXondTv0AXNEcE8lrvU7Vq8+0TefYN6Uwjwm3L+yiIje+eVSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jgt2df9UmPJTMkL3wt0hHKqzn9dpZV+x9YIYxktxBI=;
 b=OVZF2cYm2p1fTQtJsIlWDCtXQv3o8gvrldjd9u5tO57AFGle+l8GNVtiJoL3lDozWnE626XBosdWjSoiy242C3UcImrc1nI1gUia9MkBxL3G2AjR+IvTKwolOexD/kCMIgUxwMWZgFanxtg9wJwgjcnjCackyLhT0Av9Bw2YZpE=
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 17:08:39 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::a0) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 17:08:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 17:08:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 12:08:35 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 12:08:35 -0500
Message-ID: <d65c9328-04f7-2f06-1265-4a5d7f3a8698@amd.com>
Date: Mon, 28 Sep 2026 10:08:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V0 04/21] accel/amdxdna: Upgrade firmware version to 6.0
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
 <20260926013448.3840921-5-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260926013448.3840921-5-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bfd756-bedd-42fd-7a4c-08df1d832288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|3023799007|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9TiubtMlG4zLQX02jyWF7NfLOvrw4CtNKVknnFMWviP8o+B+fhN9rw77O9QPdyjxVJ/VHFx7RLwA5iWcvAxXLe6vuZHIaFmiQSbgTn3la32fskHHdmZ6rvVcW+2lx56nMmQOWgdU84tkYkNoAk0g9zaNKd9pnUW4uMyHhFnS9fvkjZ4fZfwyk1EB8HrFPabdQqNVute6BQUtjmq4OLaLMOAS58oSQ9T85Ulrx6rm6qTOTUFbiTblb/Bbu00ne4od5mSWp/CpfKLjdnbcMnuT4mlN7yxz3YBoJXTsvrlXjuvYgJgsr6K1oJLV4moheJtmqS7J3BbHRJQcQEYvv+bA7Ep8qfRJfGbL9C68CwGrVWN6qvnj9Swr5snL0ontzDnwev7khoAKAg5ksReOM4rVCGSxNDPlzLEFVlETv4HJWgrt3P5RgxFFTeh7VdR+SDEpBdb/UmcHqtRInivNzh7GQPIg8CUQD06ni8EZmMQryCQSfoOmBhX/0OT0hOyvqj1MgtETgk9t3/H/pFhMgtraLVtovCX1i4K+9dcV7Bhh0cEE9ZKoUg2eQQxLFF5+L08wLEaqaafAkF/3Sl+n6yY51MzsUeQJpXJbRbqce4xVrxLOH1nh+XBJl0PwXXt3PaEfyktuVqKTuGLtEVdoPNmcqtjrPQU0Vmt9HoEgfp/ZXcKbZzJIqyLo2CX/7zsgmT0VoGm6RQPphREqGkiyfhRrig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wuKD7ydUcpKYsSGMjVR0OP6vTfA0kOSSmCJgHSXvuwXrbQsCG3UhIhkgDEnXkh3B/2eNoiCAwDE6prKA9xbXAuc9Sy7y3Pc2M5V6QR2kZTkM0lhHdLfc17InlL2qpx9xkWKFMYp2kEG2apVU4EQ7nCh3pz3qwtqUGe8Zypqs/04zncTWOT55xDF0usoBvhnEq0HB6iE/bWD91kGVGiln7oIn6oMdV3EIiKsYBG9JondgVyidJYcyg+7mKd+JoMvIiYUJapQq67ZqAgv2VRbCG5AgeoQu5Tms8rh4lDA1T+bhhMGx1WF3WZFYx6fF7/LChW/a3ks7pRjLWa+ESKpTLjC6pZW6BRSamfNCC3sHtm5TGUC5eIGoKoDqiAg4yiKSffJJY8vk1hJFYWQjbo/05pNwF6z9AhrmJn5qT7uNSUqGgVQ4usjCE9N4xjwCZoVQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 17:08:36.6746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bfd756-bedd-42fd-7a4c-08df1d832288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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


On 9/25/26 18:34, David Zhang wrote:
> Upgrade firmware interface version to 6.0. Update host queue layout,
> opcode definitions, and context creation/destruction request structures.
> Parse priority band and PASID for hardware context creation.
>
> Note on host queue layout and version validation:
> The host queue header layout moves write_index from offset 16 to offset 64
> and data_address from offset 24 to offset 120. Protocol compatibility for
> this queue layout is validated against the CERT firmware protocol version
> (host_queue_major/minor via aie_check_cert_protocol()), which was
> introduced in the preceding patch ("accel/amdxdna: Add CERT firmware
> version support").
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_ctx.c        | 21 ++++++++++++++++++---
>   drivers/accel/amdxdna/aie4_host_queue.h | 14 ++++++++++++--
>   drivers/accel/amdxdna/aie4_message.c    | 10 ++++++++++
>   drivers/accel/amdxdna/aie4_msg_priv.h   | 20 +++++++++++++++++---
>   drivers/accel/amdxdna/aie4_pci.h        |  1 +
>   drivers/accel/amdxdna/npu3_regs.c       |  2 +-
>   6 files changed, 59 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> index 8157f2a6fd10..90da4e8c4f54 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -110,6 +110,22 @@ static int aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_context
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
> @@ -129,9 +145,8 @@ static int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
>   
>   	req.partition_id = ndev->partition_id;
>   	req.request_num_tiles = hwctx->num_tiles;
> -	req.pasid = FIELD_PREP(AIE4_MSG_PASID, client->pasid) |
> -		FIELD_PREP(AIE4_MSG_PASID_VLD, 1);
> -	req.priority_band = hwctx->qos.priority;
> +	req.pasid = aie4_msg_pasid(client);
> +	req.priority_band = aie4_parse_priority_to_dev(hwctx->qos.priority);
>   
>   	req.hsa_addr_high = upper_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
>   	req.hsa_addr_low = lower_32_bits(amdxdna_gem_dev_addr(priv->umq_bo));
> diff --git a/drivers/accel/amdxdna/aie4_host_queue.h b/drivers/accel/amdxdna/aie4_host_queue.h
> index 1b33eda3f727..97e535939b32 100644
> --- a/drivers/accel/amdxdna/aie4_host_queue.h
> +++ b/drivers/accel/amdxdna/aie4_host_queue.h
> @@ -10,6 +10,14 @@
>   
>   #define CTX_MAX_CMDS                    32
>   
> +/*
> + * Host queue header layout.
> + *
> + * Note: Compatibility for this layout is checked against the CERT firmware
> + * protocol version (host_queue_major/minor) via aie_check_cert_protocol(),
> + * introduced in the preceding patch ("accel/amdxdna: Add CERT firmware
> + * version support").
> + */
>   struct host_queue_header {
>   	__u64 read_index;
>   	struct {
> @@ -17,8 +25,10 @@ struct host_queue_header {
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
> index b137a2a40b34..0bb1d18df027 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -5,6 +5,7 @@
>   
>   #include <drm/amdxdna_accel.h>
>   #include <drm/drm_print.h>
> +#include <linux/bitfield.h>
>   #include <linux/mutex.h>
>   
>   #include "aie.h"
> @@ -14,6 +15,15 @@
>   #include "amdxdna_mailbox_helper.h"
>   #include "amdxdna_pci_drv.h"
>   
> +u32 aie4_msg_pasid(struct amdxdna_client *client)
> +{
> +	if (!amdxdna_pasid_on(client))
> +		return 0;

Should it return IOMMU_PASID_INVALID which is actually -1?

Lizhi

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
> index 31208c42ad5f..891c5f243ae5 100644
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
