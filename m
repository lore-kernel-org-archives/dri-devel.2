Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639D1F9D0EB
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A471310E004;
	Tue, 14 Apr 2026 17:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ThwPaYL+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6959D10E004
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssX/ViusCtnCGBCWf44FFd8w2x7Qnx5/fJmAm6/AQXvNANYhb4PgDvGTSoKhNS5J7OBFNj2+Vr1zUddkCpNXRhs44Du90N7+6LUqR7IyLNQ+fUidSwieJRNf/oHHAXgJ71y1EK5tG57eHtB5DM1AohPvQnf/5YEnAts9lfaCmfgzpVeKPI08W6snvscPi0pzJ7vVW52ZAZiMd7MOLcHoEH7obawAdOwLgah+qnvMzxsLbvG81bMHl1iB5G7A9SFQlHMDXf7PzU7FyQwzlPLD+kj8lsa373gKQp2bscWZ32ExFn3cc1+oEtIzwCjzWZ8OI4qRD16Z+CKvzMUiO1k0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPkPbzZrFYd6AnvJk4ScdBVY9VIYKbxD33UiJZml2m4=;
 b=Gz6xl75SGStQuxnwBma7xdJ3NtYaxdsNLhrX1VWZ/pTs63G/CLnPB8zyOSQuHVyWD5VtPfKuiz2YeOjeW9oEz+h/tBuGEN897wJHuHVqOUDzJscKESUbzXkvOHaSZr9jcXZ8bRIM6DrMGwbdmPmOLeOgOSaflZ8WlyEtrLGpFmS/E3d204q6p5+ZxWh093ymblRLmK6nZYbvfsAnzkmRpNiNT95SNmZYr5EeRwn4TbIX9zlIcfU9OYYfvuBZH5YPE9iyMIOUKB/7hiWMCG6tJzLbWf2wIBq+T0/IgTFM1D8+1g1K1BxIO98dK5pONiWVuCdlHBgjEfzGQ6l2qTAutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPkPbzZrFYd6AnvJk4ScdBVY9VIYKbxD33UiJZml2m4=;
 b=ThwPaYL+rVIlDhJsc+GQZXetMw1ifWLL84cC4kmn+af9+hT/YsKFfwzU+E5HoFTVrDq9etHd1mRcOTxHQCDHB2sb1rcE1nWOdY3v/ggVRCHZiFKIZkR1RQYVmTl9cqoiwSX36+qozD36zp5cFwQAYupvx0DMuF/eY8rRR1vxeL8=
Received: from BL1PR13CA0166.namprd13.prod.outlook.com (2603:10b6:208:2bd::21)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 17:28:30 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::af) by BL1PR13CA0166.outlook.office365.com
 (2603:10b6:208:2bd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 17:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 17:28:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 12:28:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 10:28:29 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 12:28:28 -0500
Message-ID: <295f2c5c-1c16-96ab-b9b7-c465cc6ee16e@amd.com>
Date: Tue, 14 Apr 2026 10:28:28 -0700
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
 <54e62560-22a8-7f1b-642e-21042fc1f081@amd.com>
 <d58e78d3-dd94-4dc5-a80c-5f38836c4495@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <d58e78d3-dd94-4dc5-a80c-5f38836c4495@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f6f8bb-b315-4b90-d346-08de9a4b3eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /mhZCkDYJkdlytZGv/aq8JKfiCczNemn+Uq0MeveGvMUpvX31LwUPFeAOZ5IPVwbRJ/FW6Lad3UZTSKW476upkf0ZNVv8fKO7LFXKjZP21mVnea0Liv8Hw5wYS8q3G5penbnUfNedZ0W8kgNTrTGJqTdKZiAheYgXrERxcAuaF+HEKUioF+u1wee4MhtM1fMWXRQ/8qjM5QaH98+JrdYohGJv7Pn/Gh0figuB8FqWBQVXjEqNqHFHYzo5mUnixcnrSADSbQLys2tBUzunYskvCV0h35stOsMJuw9u1f0QsgSMAe5EstvAMhHAMQaGKK5YUBVnBnxEqq0zuua5o2hZlhyE2TB6rrXwZpSqXY7YHsDpAT88HfleMc/30uj+ZSrYi7YImrQ/4Ytm5OowwtCIufxqG2m2WAD9TdvGaTHZ3DQbAaBbKZ7ZZ8g8QV3QPLBrh8TPsN3x8OToYbPGeYdEWsLTHmbE+XkuajP0pX1wIPcx9mxHxlUT/J34a9CXsyq4XaPY1rYuQwFNxCttewTfxH+r/NgxWcQDYYW/5q2pVubopkxfhLGzSXbGi5eXfNNv/ApT6+W6gb0vP53nvhAo4xl+qIWCMQuhynIK8q3wrTnuAXcGvBE09tvMqdEOntJalSN+EQml8Ju7FdyjNUgxbqCIMzwX6gcBLKchhfOfYnZh0NhDtflhaZIrjeWsI5sSZhOZDxQjA00tfoSJf00IgzrF/OQDEEOXjQujXA3mjJvgJch48HlyRqjFVQ+M/cI5/L8YxvBhHNt1hGHoh3hxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p3mcZTaCyxiubfiAYyYL/POCrjShUnE5fHU1DJnevt9i0Eh5brHGavA6BXi24gAoXm7EPu+2qFjxHUKoKx3WyK8AjB2/r3agnbCTj0tXbjUzAGYmhmwEvnlwHKjvYv6xQxikik/k6RQD23HBUXOt130RpYjLUQP3wxRLEjNkFh4kFae55HQGaqNkeWwwclP+ELYQjGQ+ShPCxRHCkMP/HnknIMiIo6QtL7Dhk0l+7Syf1DmfvbLRSnwmtt3Bi1sDP96bUKl+37gHCIz6lhEyuMqNXrrNDuqWNWDqTrrWB1zeVIWKz+bnCujoYeuytR2r2YybqlGetsgn5oSVMacpaQgux/D/7aGbOsy0nFHUyyfiXc3KArtXETgdlYB1wDg9g8drzNo9JcTvGU63ysjjBzKxKVNrge2ti0MASyesX7ykuWjalig+rxkmc7MwNwD7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 17:28:29.7390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f6f8bb-b315-4b90-d346-08de9a4b3eab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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


On 4/14/26 10:17, Mario Limonciello wrote:
>
>
> On 4/14/26 12:16, Lizhi Hou wrote:
>>
>> On 4/14/26 09:58, Mario Limonciello wrote:
>>>
>>>
>>> On 4/14/26 11:56, Lizhi Hou wrote:
>>>> From: Max Zhen <max.zhen@amd.com>
>>>>
>>>> Add support for configuring the hardware scheduler time quantum to
>>>> improve fairness across concurrent contexts.
>>>>
>>>> The scheduler enforces a fixed time slice per context, preventing
>>>> long-running workloads from monopolizing the device and allowing
>>>> other contexts to make forward progress.
>>>>
>>>> The default time quantum is 30ms and can be configured via the
>>>> time_quantum_ms module parameter.
>>>
>>> Can you talk more about how you want to use it?  Adding new module 
>>> parameters is generally frowned upon in lieu of doing something with 
>>> debugfs at runtime.
>>
>> This is a static setting which is not supposed to change at runtime. 
>> So module parameter is used.
>
> But so what happens if user loads driver with default setting and then 
> unloads driver and loads with a different setting as module option?
>
> Does this flow fall apart because the driver initially programmed 30ms?

Reloading with new setting will overwrite the default setting. After the 
module is loaded, it is not supposed to change before unloading the module.


Lizhi

>
>>
>> Lizhi
>>
>>>
>>> IE if you can export it as a debugfs file that when you write to it 
>>> updates the quantum or updates it and restarts the driver this might 
>>> be more preferable.
>>>
>>>>
>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>> ---
>>>>   drivers/accel/amdxdna/aie2_message.c  | 44 
>>>> +++++++++++++++++++++++++++
>>>>   drivers/accel/amdxdna/aie2_msg_priv.h | 16 ++++++++++
>>>>   drivers/accel/amdxdna/aie2_pci.c      | 16 ++++++++++
>>>>   drivers/accel/amdxdna/aie2_pci.h      |  2 ++
>>>>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>>>>   5 files changed, 80 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/ 
>>>> amdxdna/aie2_message.c
>>>> index e52dc7ea9fc7..976ad6281078 100644
>>>> --- a/drivers/accel/amdxdna/aie2_message.c
>>>> +++ b/drivers/accel/amdxdna/aie2_message.c
>>>> @@ -1200,3 +1200,47 @@ int aie2_query_app_health(struct 
>>>> amdxdna_dev_hdl *ndev, u32 context_id,
>>>>       aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
>>>>       return ret;
>>>>   }
>>>> +
>>>> +static int
>>>> +aie2_runtime_update_ctx_prop(struct amdxdna_dev_hdl *ndev,
>>>> +                 struct amdxdna_hwctx *ctx, u32 type, u32 value)
>>>> +{
>>>> +    DECLARE_AIE_MSG(update_property, MSG_OP_UPDATE_PROPERTY);
>>>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>>> +    int ret;
>>>> +
>>>> +    if (!AIE_FEATURE_ON(&ndev->aie, AIE2_UPDATE_PROPERTY))
>>>> +        return -EOPNOTSUPP;
>>>> +
>>>> +    if (ctx)
>>>> +        req.context_id = ctx->fw_ctx_id;
>>>> +    else
>>>> +        req.context_id = AIE2_UPDATE_PROPERTY_ALL_CTX;
>>>> +
>>>> +    req.time_quota_us = value;
>>>> +    req.type = type;
>>>> +
>>>> +    ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>>>> +    if (ret) {
>>>> +        XDNA_ERR(xdna, "%s update property failed, type %d ret %d",
>>>> +             ctx ? ctx->name : "ctx.all", type, ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us)
>>>> +{
>>>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>>> +    int ret;
>>>> +
>>>> +    ret = aie2_runtime_update_ctx_prop(ndev, NULL, 
>>>> UPDATE_PROPERTY_TIME_QUOTA, us);
>>>> +    if (ret == -EOPNOTSUPP) {
>>>> +        XDNA_DBG(xdna, "update time quota not support, skipped");
>>>> +        ret = 0;
>>>> +    } else if (!ret) {
>>>> +        XDNA_DBG(xdna, "Ctx exec time quantum updated to %u us", us);
>>>> +    }
>>>> +    return ret;
>>>> +}
>>>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/ 
>>>> amdxdna/aie2_msg_priv.h
>>>> index f18e89a39e35..fc2e99510980 100644
>>>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>>>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>>>> @@ -31,6 +31,7 @@ enum aie2_msg_opcode {
>>>>       MSG_OP_SET_RUNTIME_CONFIG          = 0x10A,
>>>>       MSG_OP_GET_RUNTIME_CONFIG          = 0x10B,
>>>>       MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
>>>> +    MSG_OP_UPDATE_PROPERTY             = 0x113,
>>>>       MSG_OP_GET_APP_HEALTH              = 0x114,
>>>>       MSG_OP_MAX_DRV_OPCODE,
>>>>       MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
>>>> @@ -503,4 +504,19 @@ struct get_app_health_resp {
>>>>       __u32 required_buffer_size;
>>>>       __u32 reserved[7];
>>>>   } __packed;
>>>> +
>>>> +struct update_property_req {
>>>> +#define UPDATE_PROPERTY_TIME_QUOTA 0
>>>> +    __u32 type;
>>>> +#define AIE2_UPDATE_PROPERTY_ALL_CTX    0xFF
>>>> +    __u8 context_id;
>>>> +    __u8 reserved[7];
>>>> +    __u32 time_quota_us;
>>>> +    __u32 reserved1;
>>>> +} __packed;
>>>> +
>>>> +struct update_property_resp {
>>>> +    enum aie2_msg_status status;
>>>> +} __packed;
>>>> +
>>>>   #endif /* _AIE2_MSG_PRIV_H_ */
>>>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/ 
>>>> amdxdna/aie2_pci.c
>>>> index c9c23c889c78..7ed99ea471a9 100644
>>>> --- a/drivers/accel/amdxdna/aie2_pci.c
>>>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>>>> @@ -33,6 +33,11 @@ static int aie2_max_col = XRS_MAX_COL;
>>>>   module_param(aie2_max_col, uint, 0600);
>>>>   MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");
>>>>   +#define MAX_TIME_QUANTUM_MS 2000 /* milliseconds */
>>>> +static uint time_quantum_ms = 30; /* milliseconds */
>>>> +module_param(time_quantum_ms, uint, 0400);
>>>> +MODULE_PARM_DESC(time_quantum_ms, "Execution time quantum. Default 
>>>> 30 ms, MAX 2000 ms");
>>>> +
>>>>   static char *npu_fw[] = {
>>>>       "npu_7.sbin",
>>>>       "npu.sbin"
>>>> @@ -186,6 +191,17 @@ static int aie2_mgmt_fw_init(struct 
>>>> amdxdna_dev_hdl *ndev)
>>>>           return ret;
>>>>       }
>>>>   +    if (time_quantum_ms > MAX_TIME_QUANTUM_MS) {
>>>> +        XDNA_ERR(ndev->aie.xdna, "Bad time quantum %u", 
>>>> time_quantum_ms);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    ret = aie2_update_prop_time_quota(ndev, time_quantum_ms * 1000);
>>>> +    if (ret) {
>>>> +        XDNA_ERR(ndev->aie.xdna, "Failed to update execution time 
>>>> quantum");
>>>> +        return ret;
>>>> +    }
>>>> +
>>>>       ret = aie2_xdna_reset(ndev);
>>>>       if (ret) {
>>>>           XDNA_ERR(ndev->aie.xdna, "Reset firmware failed");
>>>> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/ 
>>>> amdxdna/aie2_pci.h
>>>> index f83deca2b51a..69b53c7bcb86 100644
>>>> --- a/drivers/accel/amdxdna/aie2_pci.h
>>>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>>>> @@ -222,6 +222,7 @@ enum aie2_fw_feature {
>>>>       AIE2_PREEMPT,
>>>>       AIE2_TEMPORAL_ONLY,
>>>>       AIE2_APP_HEALTH,
>>>> +    AIE2_UPDATE_PROPERTY,
>>>>       AIE2_FEATURE_MAX
>>>>   };
>>>>   @@ -308,6 +309,7 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, 
>>>> struct amdxdna_sched_job *job,
>>>>            int (*notify_cb)(void *, void __iomem *, size_t));
>>>>   int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct 
>>>> amdxdna_sched_job *job,
>>>>                int (*notify_cb)(void *, void __iomem *, size_t));
>>>> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 
>>>> us);
>>>>   void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
>>>>                   dma_addr_t *dma_addr);
>>>>   void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
>>>> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/ 
>>>> amdxdna/npu4_regs.c
>>>> index a3b6df56abd0..6ebf75ad5fb4 100644
>>>> --- a/drivers/accel/amdxdna/npu4_regs.c
>>>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>>>> @@ -93,9 +93,10 @@ const struct dpm_clk_freq npu4_dpm_clk_table[] = {
>>>>     const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
>>>>       { .major = 6, .min_minor = 12 },
>>>> -    { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, 
>>>> .min_minor = 15 },
>>>>       { .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 
>>>> 12 },
>>>>       { .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 6, 
>>>> .min_minor = 12 },
>>>> +    { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, 
>>>> .min_minor = 15 },
>>>> +    { .features = BIT_U64(AIE2_UPDATE_PROPERTY), .major = 6, 
>>>> .min_minor = 15 },
>>>>       { .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, 
>>>> .min_minor = 18 },
>>>>       { .features = AIE2_ALL_FEATURES, .major = 7 },
>>>>       { 0 }
>>>
>
