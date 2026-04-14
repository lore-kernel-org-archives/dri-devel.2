Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AC1F9D0E8
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6CB10E634;
	Tue, 14 Apr 2026 17:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vnjVbR8C";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA7B10E634
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBiWygDHRZJ7Lmq1FyrS450EW6+LTaR4FFlEuws/4iKnP5zW6Oh7T3EUh+Xj+SE68yXccm8laS3aF3+yWd7WDAA2ctS+ptKcmQwarBi4/JMVThsBgqdORyureX2TjbgSPoMNXqENbG4BxvacW2gWA6g7zHocOwzFyeRXfomh54TdU8h8vHLiM+pwocLC+XwVW61g3JFY+CWJ9AnY/Oc8SJ0lftdwaUU1F3qGUKCl+HfklMMrQXgBEtdQMJtg5ey5KzC9sYlMjq+hn0xjQF/4SxOGHoR3no1UpqdT54Gw19W1Je2a9m2ShUmT3fY3z4UPofSIlHoz6pCJBnz+eQ11JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXTCPhrHn+imgWXHoZwE5j03FScgSlQysZmgl+itojs=;
 b=mcuRlCTCDItcehn8ZvvFmFMBb9OW1vvZRpMoW3CEXqjgzwq7/dH8absK2OCqZEBcHUgoC14h37aecGtwDd6AdAxeQ2cLq3aGZZ5gvIM4uoRPZxY05DcGo9n+VIIrHARCWoKEJ/LBU5EArdQDkQcaUMl80y7xnhaTJRvYqzm1bMIpzEtmN/6RORtrrnwU22mnMUdvJfU2gqzKAFkBKd01qAfphleqGUouQ62N0VxxOYeVEn1Il8hWNPIk9kFPz1GeAfS3JZKxaQyw7v72ELi0TOFdUWCOZWK23zi2ASPNlLbmGiXvuxdWgANTX75HTaBp5818TuIayFES8nr14F/mWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXTCPhrHn+imgWXHoZwE5j03FScgSlQysZmgl+itojs=;
 b=vnjVbR8CD0HON/TgHQzBIzEf9XKH0yh9Yf0P/hp3JKCUVFEmO2qNlL895WCoGpfSxzhh2YzgdH6EtskoZ5ln//7MHT/Qr3X4EabxXHgdBbGwgsbLturkJDtcl7Cbmf17OXhGhyxDbawFloA6Ti13R+GlQG7c5HbDAC96uITmiC8=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 17:16:10 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::2) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 17:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 17:16:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 12:16:09 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 12:16:09 -0500
Message-ID: <54e62560-22a8-7f1b-642e-21042fc1f081@amd.com>
Date: Tue, 14 Apr 2026 10:16:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Add hardware scheduler time quantum
 support
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260414165602.788811-1-lizhi.hou@amd.com>
 <f233b761-ca66-4790-bdba-8407e696006b@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <f233b761-ca66-4790-bdba-8407e696006b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab7373d-9560-44b5-c652-08de9a498602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: A27vF+5371Pi1wLStJS8Y7me2xEqgJ/j3sdoAOsmYd/yHGf/yYSq7Rgu6oMLKJIPZJ+K2gBYJ7ICP3D2SkdW3buWhrh7iWcIkdw5sYxNAkHWP8kwqTw2eTuRXVcaBeX0/vby9ZwSXk6cw+3yhgwr942FDw3ppMhIcL9136rpdifBsPH4Rvvih/FSiZE8yaH4Rqod8NSP/9ovJWClYrrmNMoIn0YoEIYsrZpdVuFN9C/G8MhsuUo0KAv1vgvIPc4cIAe6s+CN8aaRyuQ4hV3ge1NaF5Xh3Y9QZGE3kxmAmvba2QMpAH0GpQcAvIZ6ZWa43gnJ6JDBaax04OX451MDAbsm4BuI2UcgvvGYaRhI8qEeY/vkq4Mq6BBeV5AgzoyqW4CRt2fIynYkIHf5ieWgqKoGXi4AhoJKa2yjtSDN5eaqM8bjCnY2/PVDhAVU1FEKCR0YJ2jDAmbRRpD7SiI2EePh7t62utjxluJS+rxsGJlqSS53UPozn/N/EORPiybCYMmt6GY6ujxMIqc7+9nKNnFl9RVIzjirN5lRXCSHGBbxWRvcDhJk04oDomwlVEikPj9s0xf1xmLhfb0rernuRiGQ4V6/FMlZzlGPioGvNOoYlX95aeW1Ud9XyISfuNMn2b0hN3FASSo6aAgAl6q5yt7rEdPX3/tVAMFz0//7D+NIh3urYZbfzHVF14TO1OulDOTL+4Ox5hkOTPvMDVbwj8k93Jj3vti+oNeJQceo7cMfWOrpEt7ZiRu24+Zye5WTuOxWgmMWORSnmvzrQwIlag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T7O1u60WEm74+DsciLtDdd6Fz5ztt1cOHsmM1p8HATC7Dn65wZsH8Z7LuFHiZw5FiCVIH7qDgaBLLqvyH5Gwvrm/OhteqDlik/JUHdPBoaWcgsIixNbFfkC6TlWzkSrfGr4WllfL4DBWLfHBagwbtnM+EDG9y3h0OQTxk8IqdINSEOqC8xw+2Cvd27zfmSsGcrBN83XY2MpEungRl9aXPzNJGDStovrEIRw8o74MQVXdmVh8nj3X1gtzj92Of+g0gUwLDwdPJNPUjVSQou+EsVZPbcPPfohJUL/fQ9wSffXNjSNR04VXWFjl5izLE02Uor7K/aTmpAyXRkP5/6V1NjhN/ExC51okDvazCKH5/i29rVFaa4zB+R8IE250ughCZwLT1Vq5Kq3S1jGssZNxegZfqb32HBgAgmE52dmvlnk4NrBsPcsH+hNJzQNS62Mk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 17:16:10.3728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab7373d-9560-44b5-c652-08de9a498602
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
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


On 4/14/26 09:58, Mario Limonciello wrote:
>
>
> On 4/14/26 11:56, Lizhi Hou wrote:
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
>
> Can you talk more about how you want to use it?  Adding new module 
> parameters is generally frowned upon in lieu of doing something with 
> debugfs at runtime.

This is a static setting which is not supposed to change at runtime. So 
module parameter is used.

Lizhi

>
> IE if you can export it as a debugfs file that when you write to it 
> updates the quantum or updates it and restarts the driver this might 
> be more preferable.
>
>>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_message.c  | 44 +++++++++++++++++++++++++++
>>   drivers/accel/amdxdna/aie2_msg_priv.h | 16 ++++++++++
>>   drivers/accel/amdxdna/aie2_pci.c      | 16 ++++++++++
>>   drivers/accel/amdxdna/aie2_pci.h      |  2 ++
>>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>>   5 files changed, 80 insertions(+), 1 deletion(-)
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
>> index c9c23c889c78..7ed99ea471a9 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -33,6 +33,11 @@ static int aie2_max_col = XRS_MAX_COL;
>>   module_param(aie2_max_col, uint, 0600);
>>   MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");
>>   +#define MAX_TIME_QUANTUM_MS 2000 /* milliseconds */
>> +static uint time_quantum_ms = 30; /* milliseconds */
>> +module_param(time_quantum_ms, uint, 0400);
>> +MODULE_PARM_DESC(time_quantum_ms, "Execution time quantum. Default 
>> 30 ms, MAX 2000 ms");
>> +
>>   static char *npu_fw[] = {
>>       "npu_7.sbin",
>>       "npu.sbin"
>> @@ -186,6 +191,17 @@ static int aie2_mgmt_fw_init(struct 
>> amdxdna_dev_hdl *ndev)
>>           return ret;
>>       }
>>   +    if (time_quantum_ms > MAX_TIME_QUANTUM_MS) {
>> +        XDNA_ERR(ndev->aie.xdna, "Bad time quantum %u", 
>> time_quantum_ms);
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = aie2_update_prop_time_quota(ndev, time_quantum_ms * 1000);
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
