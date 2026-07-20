Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B9DC44512
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 01:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2689810E0E3;
	Mon, 20 Jul 2026 01:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r6fHh7k6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A6510E0E3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 01:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnXoB/VdGR69/G5oFg1f0h8Q5jjcns+XQ4IajT3FedaL/DTX1zfv+AF8yP4hXfKaa66sXqwtQfvgp4BUGtGobJITbC+80HYTNT6ii+sahwMkQnWE/Lbi6Sa+XmL8dlw9dFRokexbfBi0xmWifPLu3ri/ByTb9x6ROLzyp0EGsPGYNH+nh2G58MmQD72FeUfPO18ElE0yfKZD+S6yx3ZpIOvF8jrAmyUF9/zaBq2h6mjtQK9F4a7uEAF3qNTk606TgldGh5cjIAazwo5S9PYTcbTwNdX8bxGB88rLYDlzHh1ueBPusyxDmJ+1Aum7+mul2L2t+p2IKlWXQxX3rlbY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9YnghcrzNTWh0rUfuezjDPTxI0BNU+TpaSg6vIEhCE=;
 b=n8BZ+sAeg+wO9tQiRLDajSYgmLzGOhMqL40CTv7IjSnenkbNkIObBnj88creu4tRtk+SQe7A8w6Xsw9hXvA+b/K5cm52a3RvQ7XDjIWPa/rKkm5Iot7zScqP8QIMv98X+L5fKcv6y95rJmgqvX/ZrjPF63/z1fka5Y8FAnTnt0UPlYCrEXFFLCG+ENKJ6zXNq3Oa1XTjwnN7Ho4SKUkkss7G32ndW63lTavVc8ONnkcwZxHre3620twUAFhbFJznlGqYOGyzcFrh2r13KJzyfhdVmf6XQpi5p6fmnbGnpqzbYEoI9oVf1flNpFKK+hi1cdVcJl2QbwW9gCVFvJoYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9YnghcrzNTWh0rUfuezjDPTxI0BNU+TpaSg6vIEhCE=;
 b=r6fHh7k6jZ+BAFYxLr8X8lYP5RriP662cwLjzCYqJfbzhnCedAIrVk8tRUTMIb61qP+WM3xjeevp/WEuGi0oKBk1LdvG53/35mFSjBduUT5jLCmVXgsapZdvUt/hhx+sXQsolDW5rTTFfp22icEkbNn1vAUzfHwaA96hkv5pyGM=
Received: from SN7PR04CA0022.namprd04.prod.outlook.com (2603:10b6:806:f2::27)
 by LV2PR12MB999074.namprd12.prod.outlook.com (2603:10b6:408:351::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 01:35:08 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::a) by SN7PR04CA0022.outlook.office365.com
 (2603:10b6:806:f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 01:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 01:35:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 19 Jul
 2026 20:35:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 19 Jul
 2026 20:35:06 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 19 Jul 2026 20:35:06 -0500
Message-ID: <215a5b1b-7acc-08f3-8db4-1b46db1d66ec@amd.com>
Date: Sun, 19 Jul 2026 18:35:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix command timeout race
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: Wendy Liang <wendy.liang@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260718083409.1825940-1-lizhi.hou@amd.com>
 <5ed0acbc-ec50-4055-9e03-cc4aa730c293@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <5ed0acbc-ec50-4055-9e03-cc4aa730c293@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|LV2PR12MB999074:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bcd8c6-e220-4eb7-6333-08dee5ff215b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|56012099006|4143699003|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: 7JqWR28aCR7H+MXl6A9yXEmrhRcoReiZXQJTFMJ8yLnDKqZyM/OFBT06VibpROzjqwjXkKDqrOMMLip+9E48PBZKk+VOUfi0kJ6eiE7zRERfzW1pU1UkV+qQrvnKtz++dna8afSrvmlDS8sy5SASLX1EZ4WZC3QvBRcCWfmqSlcMGn4pM0L2EeecYuxY6Ebaq0KgS/WjuxrEsw93HUlWpa64CxvYYfjuKBbSdQkZI7cTmf6eB6kUxawoyqRuBRUih3cLM024ld00/3Yb2E0gP7bckO83RB2I8Lq8jHE3X2tD7KFMq0cmz0HaZlk079u7RM9pA2T5kcnMh1bfCwmIrsivctwfREQZfX2CWVUjHVbn063oykBWYcRw6UMdKZEDSFz/nqq7+68pmWPFZXmGA+nBZFLVSyvN8NSzxJIWMMpqmZ7KIWE0BPyYbI9SIMLHXtkDn8sRv3eegC64F/AHJlxfnGGcoW04E097OMyKXOBa8hJWFrr93X0f+Fde5fgvj/0pj96+2z1WRILEYHe1NdXg/JD3HtQFk+gytmZAHk0P1mQReGOfFR2CO0eA4zFeOAFIi2G5MkcQekTn5tqyQF/Rbp8hqTUBX1JerkchdLFdOeJNL+71OkIXYnzdJukKml9YP1sMJKlpEiq3Ni4HXUgjBxHt6UYuN00SBDHn1W6dMCtbxex8I9Z0uVN+G5hSHUTpEfCtXQT+LA8VeQQuTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OYQX7IPrgKKEQoRvL3l9ZqdSt1lbI1w+/nMk20PcPiM++Xm8nfmaAcB8DZ4m19MXG6vnrbzULeFXMm0yT2YWE879VGsxMzKn9JNMP7NP5njJH6I9s044rhQFIBnZyV0mXZAjOHhVnD3IrqwYMTyXr6a6o6z5KiyyQCiC2UL39wZoFGMRwpbOcZSi6+BRr3TnmX7XY3NN2vHLWcLkIyJpXwZFtQp4Xe4ES2+NkisqmB4eZI1JJMnAIvgKWROOAHwKXyPjvuVXpsbgsj27YCRUovTgXQyD2tt9FmoPUFz3idjCRhWVw5hswrHDF9TNj3eqNY9GteuebrCfHNQ3ZGCWLlychzv1Te6z9jFRMsGXGO9RV6eajkyKrl4axjLTXcJhcqDfFmn6IH92unXjnKfPbjMnqMxIwDxpSKriGcDMyy9oT3BOTmCxhB9ZJB0iojV/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 01:35:07.1604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bcd8c6-e220-4eb7-6333-08dee5ff215b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999074
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

On 7/19/26 15:29, Max Zhen wrote:
>
>
> On 7/18/2026 Sat 01:34, Lizhi Hou wrote:
>> From: Wendy Liang <wendy.liang@amd.com>
>>
>> When two commands enter aie2_sched_job_timedout() concurrently, both
>> check the timeout detection state. The first scheduler thread observes
>> tdr_status as SIGNALED and updates it to WAIT. The second thread then
>> observes the updated state instead of the original SIGNALED state, which
>> may cause the command timeout to be handled incorrectly.
>>
>> Replace tdr_status with last_signal_ts, which records the timestamp of
>> the last driver signal. Timeout detection now only reads
>> last_signal_ts and never modifies it, allowing multiple serialized
>> detect() calls under dev_lock to evaluate the same signal timestamp
>> independently. If there is not any new job scheduled or completed
>> within tdr_timeout_ms, the command will timeout.
>>
>> Fixes: 9022f010977f ("accel/amdxdna: Check for device hang on job 
>> timeout")
>> Signed-off-by: Wendy Liang <wendy.liang@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 22 +++++++++++++++-------
>>   drivers/accel/amdxdna/aie2_pci.c |  1 +
>>   drivers/accel/amdxdna/aie2_pci.h |  7 +------
>>   3 files changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 101f324ee178..94dfee7263bd 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -43,20 +43,22 @@ struct aie2_ctx_health {
>>     static inline void aie2_tdr_signal(struct amdxdna_dev *xdna)
>>   {
>> -    WRITE_ONCE(xdna->dev_handle->tdr_status, AIE2_TDR_SIGNALED);
>> +    WRITE_ONCE(xdna->dev_handle->last_signal_ts, jiffies);
>>   }
>>     static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
>>   {
>>       struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>> +    unsigned long last = READ_ONCE(ndev->last_signal_ts);
>>   -    if (READ_ONCE(ndev->tdr_status) == AIE2_TDR_WAIT) {
>> -        XDNA_ERR(xdna, "TDR timeout detected");
>> -        return true;
>> -    }
>> +    if (!tdr_timeout_ms)
>> +        return false;
>> +
>> +    if (!time_after(jiffies, last + msecs_to_jiffies(tdr_timeout_ms)))
>> +        return false;
>>   -    WRITE_ONCE(ndev->tdr_status, AIE2_TDR_WAIT);
>> -    return false;
>> +    XDNA_ERR(xdna, "TDR timeout detected");
>> +    return true;
>>   }
>>     static void aie2_cmd_release(struct kref *ref)
>> @@ -434,6 +436,12 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>>           mmput(job->mm);
>>           fence = ERR_PTR(ret);
>>       } else {
>> +        /*
>> +         * Command is successfully posted to hardware, update the
>> +         * tdr timestamp. The total pending commands are limited.
>> +         * So there will not be a case that driver keeps posting
>> +         * commands without getting any hardware respond.
>> +         */
>>           aie2_tdr_signal(hwctx->client->xdna);
>>       }
>>       trace_xdna_job(sched_job, hwctx->name, "sent to device",
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index 22f66c7f534d..daec1f6b4907 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -420,6 +420,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>>           goto stop_fw;
>>       }
>>   +    WRITE_ONCE(ndev->last_signal_ts, jiffies);
>>       ndev->dev_status = AIE2_DEV_START;
>>         return 0;
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h 
>> b/drivers/accel/amdxdna/aie2_pci.h
>> index 77648cc548b6..ea1dac106400 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -143,11 +143,6 @@ struct aie2_exec_msg_ops {
>>       u32 (*get_chain_msg_op)(u32 cmd_op);
>>   };
>>   -enum aie2_tdr_status {
>> -    AIE2_TDR_WAIT,
>> -    AIE2_TDR_SIGNALED,
>> -};
>> -
>>   struct amdxdna_dev_hdl {
>>       struct aie_device        aie;
>>       const struct amdxdna_dev_priv    *priv;
>> @@ -179,7 +174,7 @@ struct amdxdna_dev_hdl {
>>       u32                hwctx_num;
>>         struct amdxdna_async_error    last_async_err;
>> -    enum aie2_tdr_status        tdr_status;
>> +    unsigned long            last_signal_ts;
>>   };
>>     struct aie2_hw_ops {
>
