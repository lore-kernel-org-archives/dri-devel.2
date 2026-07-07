Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714DBC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8A310E429;
	Tue,  7 Jul 2026 05:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EZLjACiD";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE46910E429
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 05:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS8zQUfxK0yUEI/XfBC/Ci3f9bCkl5hi4PTuu9599fkyzxBQiL1vQH7nvOnvpZtCZyEkBuSH0b8yrmvNrG0pZvn8TK7ughPqx/nH/oX245U8VmRqDT5k7kiB4rWEkdzf9rHVp2grnm5RAxl709/feAMp/pbHvWsV7/gpos8wWfViDWO2SZrbnbL6lF5yQ9YU1C2C9QyPAkUtFpLbU7FEoIV1CJ2MRrzJU9IXdFWIF8bDW4c1vsXlPlS3bYQZ4rntYJh3pn6o4TiINFemeosXNVrcHVsrGBuUGrASsZYClz5V8r9zlIIKGnmLtwfpYxRas/MeOHZmwboDPgW1f4Gj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ot7YTJm4QOmH1e1hoG30iFnw8IzBYPDKsX9yAftA5E=;
 b=k2EwT5elHGOiPZlc1Xfa5MH8CK/FvcJmomE3An4SarrMCt1Tacm45wu0dH84+ILuFuauKsqxDIOIzT4y334ibHmmTyzoYtZa+CfyQTrtqVHZksVu+Zumia43ylx+mrFVLZvQg6pUg4SzGzDS4g8o8wrevLHruhEuqofma8oZbZtVJwS7ySMx1aHxk9P5slegnY2/RDVBp499/QZpGPFUTa0a39pRpfENDJZQKxoQ73p4uw+3kpAJpCPbmJpB0SAxDXxI3Ohx1SVmdZyXAWfHLx27Fui1P0aVVK/RGd4u/luOfpVGq+PmbJtHqYA+5DlMSIqmzRibpx7aChUEY/YtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ot7YTJm4QOmH1e1hoG30iFnw8IzBYPDKsX9yAftA5E=;
 b=EZLjACiDZFduxklx6po9hzOnHaVnVJsG+OvyHIRZABXx+BOtyDpJ0QOGV3Q7ZjHfzzLQ4oftWLAjS7hrmJTf3nopFAH2PwnB36eO1HIXj9ia4uSu9eqsB6P/4j3RyFbqBExGYn6BzeXHmA4L2vW5k9TQ//WEXrs+wQS/CZmZpLA=
Received: from PH0PR07CA0117.namprd07.prod.outlook.com (2603:10b6:510:4::32)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 05:47:03 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::f) by PH0PR07CA0117.outlook.office365.com
 (2603:10b6:510:4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 05:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 05:47:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 00:47:02 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 00:47:01 -0500
Message-ID: <b7a03b23-2218-4d39-f6ab-8bb0fb8b6999@amd.com>
Date: Mon, 6 Jul 2026 22:47:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3] accel/amdxdna: Prevent PM resume deadlock in
 hwctx_sync_debug_bo()
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <shuvampandey1@gmail.com>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260616212429.3620645-1-lizhi.hou@amd.com>
 <ff4847cb-90ce-48fb-bb3a-bdffe8ccdf72@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ff4847cb-90ce-48fb-bb3a-bdffe8ccdf72@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: f83b1105-fcfb-4480-24f4-08dedbeb2b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|5023799004|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lo2ZSjSwt591OzEbmR+kYRTwvDqYI5wg6vZ+QPDs6fgKDNQKXLyHcjDb5KSvvzecZRUZqUJdioEXtTvDP7jGk1P5EHrD0FqR0vwnv7RzFb7hPPY6mary7sfcNndUwpqjG7CQAO/B3Mq/ThJUFvbvWs05QCCDtd1E+/E2SnYpt2t0DS54qdfEKfPJESMt/2Z3zjD9D5bJ8vc1WmPbji99RLvPXNHOCNpxP0RDn3mTHT1SxQ0jV+AxQtFgYzbVblYFoDKpUUF7F9hO7dcaLOEIbxFuTdj2y5a+UbDJh8VGRsaq+DXM0RNFHIhktIjLjQGysibxVo17dF57PKlubdNzCdsfZQZHk3pxQBYjUO5nJKs26087POKIpICk7oeV8i90qoz86qIH4JnrZPuP7HqiBm9hEbPsjlaLvrN2bwDHLkP7bHE4FRGtIhQCpiIknCOw73/ZWftvy23xwWVGpqv/EN2oR+XggMNi9rZjXuZAl/0g0AxUlLQwR2xEPRPdLv9wNEZM10jZTmhnFQQK7uKwQLBI8Gr7eLlpB8G5aUviJcmKBpW0UopbXMU87dCFfZqRkQx7R00s7WaoL8EaxuKXYV6HOo0Qy8LyEfCasK8NWn2OSbq2ppGgRzzcZhMcbsUiArWQbHz44TOqybAoZFNnWfEwQ6QA91TMD1ji63wxp5QNdR3pgijhONSTZnKI1QuL4BatgxhmY7FH+uMXuu0wCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(5023799004)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xoU1kpj8Z+aj62PiZn9G25E14ahfX1IrZVXuDtv/beAKZt9UNZVPUj7xZkikkfEP37ZuznoKAcrLAHLwtdGfV2qVGJN+0AsySPsR+4rYJEr5i/I7HRT8cPcWvk/S+cyjut6wp2NYifLPncHceSxozACfW6T2Ld5T18qf4qfI+/A5RRBq5N/qi7WSViiYkOo8XwyFsu1pKFFqKb3TCLth1VbmVEver0jKRTekghxWX9VS1IKwBe+g6odFEhsxPL8W/Ku7SA8f/+vH8TtXlPc/4H20u6kCNbUhryjkLnuFyrtMPfzlmqPkn3C52e95yhTUsGj9oDPFkALoRd6AOn1l871mwHJWqE3IOgonS+IyHO7sK211EevnbtFIqo3ap1MxsLLhmrn1UoFW/p0pC87HMNuad+ZCxbapiyHK4kaYHNlpDwno+bdrcTDO5hsUcR3h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:47:02.7488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83b1105-fcfb-4480-24f4-08dedbeb2b91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252
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

Applied to drm-misc-fixes

On 7/6/26 15:34, Max Zhen wrote:
>
>
> On 6/16/2026 Tue 14:24, Lizhi Hou wrote:
>> amdxdna_hwctx_sync_debug_bo() invokes the hardware hwctx_sync_debug_bo()
>> callback while holding xdna->dev_lock.
>>
>> The callback may call amdxdna_cmd_submit(), which in turn calls
>> amdxdna_pm_resume_get(). If the device is suspended,
>> amdxdna_pm_resume_get() may synchronously execute amdxdna_pm_resume(),
>> which also acquires xdna->dev_lock, resulting in a deadlock.
>>
>> Avoid the deadlock by calling amdxdna_pm_resume_get() before holding
>> xdna->dev_lock in both amdxdna_hwctx_sync_debug_bo() and
>> amdxdna_drm_config_hwctx_ioctl()
>>
>> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>
>> ---
>> V2:
>>    Fix jumping forward over the guard(mutex) declaration.
>> V3:
>>    Fix the same in amdxdna_drm_config_hwctx_ioctl().
>>
>>   drivers/accel/amdxdna/amdxdna_ctx.c | 26 ++++++++++++++++++++++----
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index ff6c3e8e5a15..2ab4443e7094 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -356,16 +356,25 @@ int amdxdna_drm_config_hwctx_ioctl(struct 
>> drm_device *dev, void *data, struct dr
>>           return -EINVAL;
>>       }
>>   -    guard(mutex)(&xdna->dev_lock);
>> +    ret = amdxdna_pm_resume_get(xdna);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "Resume failed, ret %d", ret);
>> +        goto free_buf;
>> +    }
>> +
>> +    mutex_lock(&xdna->dev_lock);
>>       hwctx = xa_load(&client->hwctx_xa, args->handle);
>>       if (!hwctx) {
>>           XDNA_DBG(xdna, "PID %d failed to get hwctx %d", 
>> client->pid, args->handle);
>>           ret = -EINVAL;
>> -        goto free_buf;
>> +        goto unlock;
>>       }
>>         ret = xdna->dev_info->ops->hwctx_config(hwctx, 
>> args->param_type, val, buf, buf_size);
>>   +unlock:
>> +    mutex_unlock(&xdna->dev_lock);
>> +    amdxdna_pm_suspend_put(xdna);
>>   free_buf:
>>       kfree(buf);
>>       return ret;
>> @@ -386,16 +395,25 @@ int amdxdna_hwctx_sync_debug_bo(struct 
>> amdxdna_client *client, u32 debug_bo_hdl)
>>       if (!gobj)
>>           return -EINVAL;
>>   +    ret = amdxdna_pm_resume_get(xdna);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "Resume failed, ret %d", ret);
>> +        goto put_obj;
>> +    }
>> +
>>       abo = to_xdna_obj(gobj);
>> -    guard(mutex)(&xdna->dev_lock);
>> +    mutex_lock(&xdna->dev_lock);
>>       hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
>>       if (!hwctx) {
>>           ret = -EINVAL;
>> -        goto put_obj;
>> +        goto unlock;
>>       }
>>         ret = xdna->dev_info->ops->hwctx_sync_debug_bo(hwctx, 
>> debug_bo_hdl);
>>   +unlock:
>> +    mutex_unlock(&xdna->dev_lock);
>> +    amdxdna_pm_suspend_put(xdna);
>>   put_obj:
>>       drm_gem_object_put(gobj);
>>       return ret;
>
