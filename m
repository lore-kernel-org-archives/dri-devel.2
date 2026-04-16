Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FB3F8D75F
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E86410E8EF;
	Thu, 16 Apr 2026 15:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d94KFnYS";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F0110E8EF
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 15:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKjFjf1D6LMTz/KbyveVnYc0m5kDNtgJUwX9u4S5ffHYQJG7Nlg/xkTrdofxCSpD/+kA54EGehTEHTGTxjqwqmc9LIxi3Q2/NrnRBuqQq/dAzc0NQxIbbB3aVjc1PeidR9z5YjxLcFcPmlnOcH0aBX69HvbF2rra84bOdennX+smXfoNOKrfIxl3nbcrVIML58ipuqjZhv1ROEecI7+V5ExdB+TMKyMEctDT3P8ANxT3QaLZpyzzLyi755zRgUonbNOqVSx64flig7iKkgB+PSk5vrS/AW1f6/g8IV3msBKTJZA3cJA9WzWeh9ts4DrL6nlnb4d9aZv5rmu/yJ6VTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gldoj89DSvE64bQRhhOSVhQB+tkX7JU/e8EMnj6Vft0=;
 b=ZQs8KV9UIT/bM4mEsprUQGj+8WcFlaoSfbOjhns1KadRJkjJVmCOvs8mzaV4BljJTICcjqZWnEGznYoSt7VDG9DJbV3XPoBAHx98PExEA9xvyAl4Tgs98LYJhV1w+9I8w6J8kIljDqhKvtd+Rd2WrvGtAF309/rnVGgcpBZhjDLofaPvm90BXPDybuov52lW6FOgtSU18OigWHh06SxDVk+YGEa4G8wwxpJpdvvr4eGSmoLWdFQuRvfB+1UYgLlIOfo8dbj5Jg3jM8w/rMEdUUmvs5lRuyY//E2cD0Xaio3Xh7xekzrgLh9sTH2b5yLdaWUGaXtNOiDaGm+g0d3HCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gldoj89DSvE64bQRhhOSVhQB+tkX7JU/e8EMnj6Vft0=;
 b=d94KFnYSGDoyj+m80YOFMUBayu+syPyF1n9hchQKR6k4FfTrDKEstA8pt1gkpV86wHZ0A/ZwrL9qpPP+7jbSy85svTZ5Bey1zfC39nxjggYhL+li6EFmbIcSD+reNe2SfVNEMoOCF1IpXnRqZkueeFSoIPzIjFg2DO8rlpZpLuo=
Received: from BYAPR06CA0046.namprd06.prod.outlook.com (2603:10b6:a03:14b::23)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 15:58:42 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:14b:cafe::d5) by BYAPR06CA0046.outlook.office365.com
 (2603:10b6:a03:14b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 15:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 15:58:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 16 Apr
 2026 10:58:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Apr
 2026 10:58:40 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 16 Apr 2026 10:58:40 -0500
Message-ID: <2753aa0d-cc87-2578-1cda-dd0cd3ea7c80@amd.com>
Date: Thu, 16 Apr 2026 08:58:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Add hardware scheduler time quantum
 support
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260415171139.904947-1-lizhi.hou@amd.com>
 <ba510c73-b487-4c97-bf1c-3ae1823c0d79@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ba510c73-b487-4c97-bf1c-3ae1823c0d79@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: ee38ffd3-52a2-4469-2262-08de9bd10812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fKXF55C//VDBcAvqBXJdv7O3+ZCjWV+VGWViTzXp3CnWdNzLatNJ3TjOAzTkDHWZnWr/OaurCPBR2DqFhtEABCMszEZsjQdaDtu+F3CaQIGT2+VrrUfe9Z3Nw9+g6e4ziN8gS2p992hF4UKk/hKFFLR2o06FqDHGOQkE7Ts7akbAynn/YngFPDEoG+sFNxkuMN9o7LtldVlfPlxC42E/4Kb4NQ4IZUUfrwDBzEAbPl4BReTfZXi+WtvxyRfRVHkSy/xHb5T65N7iZq5SNroP992+zy3bHM9IJWJ0qJsTLRtozHhDcZPkCTz6ai6HT7MkV3EzdceTooCeIxFIc2C32QGtg34phu8JAOuoYv7l3bOfI//OJVl7Hf9Z1xcKrrOpKCXVgmM1/x3hBnU3GNPei7HOnQsVJ84QBtf+QLzTbTOpMN7hlcOkZqOk6bBGk6lKWYxo5hp7F88QnX7f2tnY3UGdMz3cISa39ygfJ34nRbpJGDc7FbSYgpZyTacUB/KHTTkbBmGsRIKLECPTV2NC72GVd7nj5cHO1yLvNRZxKzUwEDieTBKjPeGEEgCxiwn3JL5Ltq2lSRE6XqdqCkC7Na+UUS/5X+DdXUyKATlL4c9CE0KHotsS8W1MHj7UubP+z/LmD1vkY9SzKF99MVlTZz6hf5WD5b4OIIEZ9JC2XsqFFrb4hyIkrsxFGSaOouyOu3WHfdViDWECVqmrgXoNNyymTTh9rWiknZBvRxsNprEdA3OW4kEU3FIXnX2Dl3F4Qzlhp1uU07dvtf/ySDyQSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wNDsNFd2MDdN4nEvdv7hEzqZxM3stFOl9VJx4SLOM1bt0NvOOtwEhYtWR0x6KQMmCDF7WCXfDEzX+NPTbmJEK0ZpEYr77bp7oC3fH3LxQ6BgNRA35FnSLnBt0dmkaUrFGPR1o6ul+t1mo0MMfRYQzrWBS9soBrD6p28lvGCfFwL0pm4lfWMB0bOvAffcna/oDNy3y3dxzpox4ZpbErYw7c/298EpXsV8wpiSijTGgIdEeZidlPKJyHUhClrNCLVmqmsppyeAunMZKSjlvNJE0WPCCv6q+MegNPkXj0AindnWadyBn+oKfaCX+p4m1Jqa84RyXlQ5RkPK/RhNtKIYMmRhb4c5n1br7J1uqMf6pGSrCizHU4KeGIBmsXlFqMXjZBtBA5W7EPUo+rBYekrqoKbD/+TefZHTyH4HrBpGSQkEowCRcQ6XDt4fBAqx4jhk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:58:41.7728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee38ffd3-52a2-4469-2262-08de9bd10812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
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

Applied to drm-misc-next.

On 4/15/26 13:10, Mario Limonciello wrote:
>
>
> On 4/15/26 12:11, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> Add support for configuring the hardware scheduler time quantum to
>> improve fairness across concurrent contexts.
>>
>> The scheduler enforces a fixed time slice per context, preventing
>> long-running workloads from monopolizing the device and allowing
>> other contexts to make forward progress.
>>
>> The default time quantum is 30ms and can be configured via the
>> time_quantum_ms module parameter.
>>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/aie2_message.c  | 44 +++++++++++++++++++++++++++
>>   drivers/accel/amdxdna/aie2_msg_priv.h | 16 ++++++++++
>>   drivers/accel/amdxdna/aie2_pci.c      |  8 +++++
>>   drivers/accel/amdxdna/aie2_pci.h      |  2 ++
>>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>>   5 files changed, 72 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index e52dc7ea9fc7..976ad6281078 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -1200,3 +1200,47 @@ int aie2_query_app_health(struct 
>> amdxdna_dev_hdl *ndev, u32 context_id,
>>       aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
>>       return ret;
>>   }
>> +
>> +static int
>> +aie2_runtime_update_ctx_prop(struct amdxdna_dev_hdl *ndev,
>> +                 struct amdxdna_hwctx *ctx, u32 type, u32 value)
>> +{
>> +    DECLARE_AIE_MSG(update_property, MSG_OP_UPDATE_PROPERTY);
>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>> +    int ret;
>> +
>> +    if (!AIE_FEATURE_ON(&ndev->aie, AIE2_UPDATE_PROPERTY))
>> +        return -EOPNOTSUPP;
>> +
>> +    if (ctx)
>> +        req.context_id = ctx->fw_ctx_id;
>> +    else
>> +        req.context_id = AIE2_UPDATE_PROPERTY_ALL_CTX;
>> +
>> +    req.time_quota_us = value;
>> +    req.type = type;
>> +
>> +    ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "%s update property failed, type %d ret %d",
>> +             ctx ? ctx->name : "ctx.all", type, ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us)
>> +{
>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>> +    int ret;
>> +
>> +    ret = aie2_runtime_update_ctx_prop(ndev, NULL, 
>> UPDATE_PROPERTY_TIME_QUOTA, us);
>> +    if (ret == -EOPNOTSUPP) {
>> +        XDNA_DBG(xdna, "update time quota not support, skipped");
>> +        ret = 0;
>> +    } else if (!ret) {
>> +        XDNA_DBG(xdna, "Ctx exec time quantum updated to %u us", us);
>> +    }
>> +    return ret;
>> +}
>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h 
>> b/drivers/accel/amdxdna/aie2_msg_priv.h
>> index f18e89a39e35..fc2e99510980 100644
>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>> @@ -31,6 +31,7 @@ enum aie2_msg_opcode {
>>       MSG_OP_SET_RUNTIME_CONFIG          = 0x10A,
>>       MSG_OP_GET_RUNTIME_CONFIG          = 0x10B,
>>       MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
>> +    MSG_OP_UPDATE_PROPERTY             = 0x113,
>>       MSG_OP_GET_APP_HEALTH              = 0x114,
>>       MSG_OP_MAX_DRV_OPCODE,
>>       MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
>> @@ -503,4 +504,19 @@ struct get_app_health_resp {
>>       __u32 required_buffer_size;
>>       __u32 reserved[7];
>>   } __packed;
>> +
>> +struct update_property_req {
>> +#define UPDATE_PROPERTY_TIME_QUOTA 0
>> +    __u32 type;
>> +#define AIE2_UPDATE_PROPERTY_ALL_CTX    0xFF
>> +    __u8 context_id;
>> +    __u8 reserved[7];
>> +    __u32 time_quota_us;
>> +    __u32 reserved1;
>> +} __packed;
>> +
>> +struct update_property_resp {
>> +    enum aie2_msg_status status;
>> +} __packed;
>> +
>>   #endif /* _AIE2_MSG_PRIV_H_ */
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index c9c23c889c78..afbe3f8f67ce 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -33,6 +33,8 @@ static int aie2_max_col = XRS_MAX_COL;
>>   module_param(aie2_max_col, uint, 0600);
>>   MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");
>>   +#define DEFAULT_TIME_QUANTUM 30000 /* microseconds */
>> +
>>   static char *npu_fw[] = {
>>       "npu_7.sbin",
>>       "npu.sbin"
>> @@ -186,6 +188,12 @@ static int aie2_mgmt_fw_init(struct 
>> amdxdna_dev_hdl *ndev)
>>           return ret;
>>       }
>>   +    ret = aie2_update_prop_time_quota(ndev, DEFAULT_TIME_QUANTUM);
>> +    if (ret) {
>> +        XDNA_ERR(ndev->aie.xdna, "Failed to update execution time 
>> quantum");
>> +        return ret;
>> +    }
>> +
>>       ret = aie2_xdna_reset(ndev);
>>       if (ret) {
>>           XDNA_ERR(ndev->aie.xdna, "Reset firmware failed");
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h 
>> b/drivers/accel/amdxdna/aie2_pci.h
>> index f83deca2b51a..69b53c7bcb86 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -222,6 +222,7 @@ enum aie2_fw_feature {
>>       AIE2_PREEMPT,
>>       AIE2_TEMPORAL_ONLY,
>>       AIE2_APP_HEALTH,
>> +    AIE2_UPDATE_PROPERTY,
>>       AIE2_FEATURE_MAX
>>   };
>>   @@ -308,6 +309,7 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, 
>> struct amdxdna_sched_job *job,
>>            int (*notify_cb)(void *, void __iomem *, size_t));
>>   int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct 
>> amdxdna_sched_job *job,
>>                int (*notify_cb)(void *, void __iomem *, size_t));
>> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us);
>>   void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
>>                   dma_addr_t *dma_addr);
>>   void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
>> diff --git a/drivers/accel/amdxdna/npu4_regs.c 
>> b/drivers/accel/amdxdna/npu4_regs.c
>> index a3b6df56abd0..6ebf75ad5fb4 100644
>> --- a/drivers/accel/amdxdna/npu4_regs.c
>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>> @@ -93,9 +93,10 @@ const struct dpm_clk_freq npu4_dpm_clk_table[] = {
>>     const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
>>       { .major = 6, .min_minor = 12 },
>> -    { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor 
>> = 15 },
>>       { .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 
>> 12 },
>>       { .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 6, 
>> .min_minor = 12 },
>> +    { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor 
>> = 15 },
>> +    { .features = BIT_U64(AIE2_UPDATE_PROPERTY), .major = 6, 
>> .min_minor = 15 },
>>       { .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor 
>> = 18 },
>>       { .features = AIE2_ALL_FEATURES, .major = 7 },
>>       { 0 }
>
