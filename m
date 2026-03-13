Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B671F107BCE2
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 21:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E5610E039;
	Fri, 13 Mar 2026 21:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vFGOV8ON";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A7F10E039
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 21:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FutbzePRMVKGJNrdV65P0NwwiY8xBsTJoegC5Ey959FK8fbP2y4rKjzptWmfvPgrqiku9oof2IGMbySXoeAgvg0RqrA5MWMt41lFcFUPH1ZGJB4U+TSqvfr5KkzSJL9gevkyMoCuz/koHoqKNBMCgVrRa7ANVcGI9lJdTpwmjRslnuy1RYTVppZtyWfIyga0N43ntWfJ+irseJD28O1z7UE9hxyX9bTJ6byBoQ+biraRiuXscAjghWkc0EYEs5l4f7dAwn1oNDj+f0pZV0ZPZ5iRCemk5DzlK92YhnE72+DE6hm+82OWtA/nCRv8YzkTdVngkbesCF84pNc/6wS8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srCINQaF624fsDAmORAUJk4rBtR+NBmpWyRSYQPSlVg=;
 b=QzP/+ZzsJX9RKruYRjzu5u8HAnFBS+ZATdnul+nBpd9L8OCwpnpUyDHbPrqliO1auVuOu7Z16u44Zp49+O+Uum6+D+Jrkn8KeotcdVaRh+Sgfawd2jzHKPBOdyEcCO0roCIjbDcE6tAYbQw02V6BdwO/lT8EW7EERPIaomKodo6GlThTppLFvwgX1/P089RDW9aq1Vb1ldA9+RMznEVnWHCqWT6ToP77N/ebmeMlUsrIP3+8lNj1Oh6UJdVAm3rk9QLmtxQ89eOtxSa05k6yM8rJxSL+D+e8WHXY7Xcmjx5tA/MSWi6FB883WvDKj7dGg8GOqI13xekxHDIBzDYTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srCINQaF624fsDAmORAUJk4rBtR+NBmpWyRSYQPSlVg=;
 b=vFGOV8ON5cul1+UDoTfa3GjIxUjJBJ2S2fkWR6Vrfipcu2QcPvj0SHwizCLJv0VomtoE4qk+MBPdt92pmdfWpuybRtsIdPpBaOuUgDvpQfwTeotYupKn/mKGmR6UIgTldRDkvARPlzC3OpNH6Z7bUGJfTw4TVhfuwb01eq0znB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.4; Fri, 13 Mar 2026 21:50:48 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 21:50:48 +0000
Message-ID: <8a01763a-bbe1-4bae-991f-98c8f6ebbd96@amd.com>
Date: Fri, 13 Mar 2026 16:50:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Support retrieving hardware context
 debug information
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260313181413.1108841-1-lizhi.hou@amd.com>
 <5f7213f8-3daf-4cc0-9422-9ad2de814c8e@amd.com>
 <c488a68b-9c36-1167-3f3c-349970c61a38@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c488a68b-9c36-1167-3f3c-349970c61a38@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:52::16) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 7defd41a-198a-4405-4880-08de814a9631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: z4c80xXPcQfRBxV3WsJzxYbJzeW1H5Y9q2wYkzSr/fWUWgNOVCVFjk1D6/7m0ckK1UHPvblYeVhxymVe4YAVOZKMBMUNPnU7UeiLkCZWaf5ewsafD9xJbyq8LO6HeBWX1RZiCdxO3zeuAcyhbqqRVZp7sH+UhmDXhEeQlYbWcUTtMttosDhXR0wuDFYk8lIpUzOSOV+STtNdlaS35v7Z8MnK1HNtSiE6iSCB5+70BOk/wnTNrV7NkDSd7hdKuNHDAo5kPr4MQ1d5XDSdtoNZRlUBPIc4TL9+3Uqn+7HgyjMm6Xs929VXyhCvNIft/RFvFU00h0K18VN6usliuBX0uKm9E3ViRuLeZNxabQV2n32fmnsbCnOlS2ZE/awmDJiolfsvUcSIalFMQkNJ3Yc/ARP43fc1/k339SqmfwECgJb0KAVXibyCXlLr851ytEn8ShYadw2hW7lgGGqCUtCCulHw+edscsxeLAqDJhxTQa+BqW+irLbvUBo6mNYL4KRIeZeTZAXw8ghXaiZtNSDLyW1j4wRwJuP0V8ppLWMRRBkJX9GhlzbVYJ6J/dJOVRFDtrRlsunIu+ZB/lBOLTX9KppEplISjLn9hTviflgkwvq2U/lOjpF0bu1DSs+3wz28GTsFJqrthdhqqiAHj54LT1l4Tlpqy9dP30T+jlKRCdICDE0SU7/A92sORsvTFqlLbeGYf1i5u1Ky1PR3iutgmvSpXbnykhcRXgDdjFy1Gv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnVQamVOaUFtYzNvaGZvaWw4NjJYMW56SmFQcy9rejVSNHZidUNvZXIrekRt?=
 =?utf-8?B?RjJwY1dBN3dkK3dCcnZtMlJudUNyZWd3VWZRZG14c3hIUDgvNnFRZHBVdnkw?=
 =?utf-8?B?Qmt1U1RBQ3A5RWl4VlAwTzNIZHphZWQ5TzlORHFQZWlrbkJpcmNHdTZ4TGJO?=
 =?utf-8?B?ZE4ya0s0eCtHYlhHc1dpZXRQOXhzMjUxT3c2UGYzUFV5VzRXK3hId1dFOGhB?=
 =?utf-8?B?bld5YUZZYnJTc1dKOC81RWZEM3dSbms5WkpXZDlXL3dmNGUyVDZsQWFXUmhz?=
 =?utf-8?B?d0pacEZRV3NJL21WRWtNWWFJUFdFbVNVWVdLUDVVSVdKSFk3UGIwSzRqektH?=
 =?utf-8?B?NVlsSEtkMEUrUGkrNFhETnBhOHNXT1ZXTEt0MXlKNlVGTEkxYWdqR1ZYNUxu?=
 =?utf-8?B?dWROMVBCcFB0Y2NuUlN5VG1sZm83QjRUM2JNNzRTRkJHZno3b0lERmdzbklp?=
 =?utf-8?B?K3pIbncrUEZkU0tSSnZYVXQ1M1VHcEs0REwxaUdXOFZJQU5xaWt0cU1rYU0v?=
 =?utf-8?B?S3NEVkdabkM1Ky9zVkdDN1BTQWNvQzBONy9PamFuS1pLOVY2YUVkc1ZMMSs0?=
 =?utf-8?B?TVVBdHFJckxXelJSWis2aS9VekNvT0FXRTFIeVNGa041S216UGVQVUZaN1pv?=
 =?utf-8?B?T1dUWXl0TUo5S0lNWWo3RStxUXRROWg0Y1dROVlseEwxVzF1bzM0OXorUDRP?=
 =?utf-8?B?ZVhDY2M5UWQ2YTFjMnA5WENkN1ZOTjEzcXdzZFZkUVRsVWdKTHpSbzdDWng2?=
 =?utf-8?B?UDdTZTB0VlhYanZnZWtEdnAzckFlUWQ2S1oySGZlU1NhNDl1RC9PUTZoOFJi?=
 =?utf-8?B?V28zaDdlKzlyUkZLbnZ6NjhLVlBYdXI4MGRsSGNWYWVUNzl5eEhGSElMeTZW?=
 =?utf-8?B?S1pVbWVQUUIrdWRnQVluMVdnV25JVytkVUJwYUMrMnhDRlFVTWY4ZmJzWjVD?=
 =?utf-8?B?Q1V6c0FQRWZyT0w5TVd3RllqaHQrMXFjdHpITFh6RHl0c3o3aHV1ZlJqUjlX?=
 =?utf-8?B?cFFDRWV2ZnlXZEgwRXpPKzNuazQ5aytSOXRENWZOSVFTOEZ6a2FaQnptdW9n?=
 =?utf-8?B?cDUrVmVta1I2THpMVzFiWEFhdWxEUkFGTmluODNLZXpHZ1JLdm1DTzlYUGtS?=
 =?utf-8?B?bjlWdzVVTW90V0RTKy9idXNMLzFpaWtIeXJyeWtsand6b1Zqb2Z1czJWQ3FO?=
 =?utf-8?B?L2xnRXkzTXIxSWN6bXdjbWJyM2VPSWRjQkdNcXNiN3prZmozNEgrWkRMOUR5?=
 =?utf-8?B?Z0JCYW9va2QyOVBvY3RYaGYzdmZVTlllTURYR1gzOGlkQnZmaUVtVTR1cXkz?=
 =?utf-8?B?elBDWEFyVGx2S3ROdVJoRGdtWk9OdGhXckFFcjBiVDFETHFTZjVDWVgrbC9B?=
 =?utf-8?B?d2JTVWxtVm9za2IxcktjZjMyR0hHb0pRZDNlaEFIazNwMHdDYXhzZGF3ajQ3?=
 =?utf-8?B?akVzZkpvL2lUZGhTZ0FCVGFxUkswOE5LMzhra0IvaHg5b0hYUE8vTHl4Qzd2?=
 =?utf-8?B?OXQvWDR5RFNhdHJlNmJVRkY2SEJhR09mWlJEcFNrYTRnOEpmSU1McEYzNERZ?=
 =?utf-8?B?bm9IWFBEdGp5SFZSa3B6MmxDUWhpOHdIbXpMRnNOdVhPenYyNFBzL3VBVUdo?=
 =?utf-8?B?QkJSN3VrMlJMQkxObGhneWI3ZDlpZzIxVXlsTUY4bTRwaUFJak1WTFp6L2xl?=
 =?utf-8?B?ZVNuaEdLZFhMeENsZ243b3NaYXdEaklyK1doVTRkZ0tqZzd2Wmk2ZjdhNjRw?=
 =?utf-8?B?d0FkTnpuVklycjgwZklpY0tDWGtmTjJrMUo3bUVMMEx6U0JDY2w3VHVMaTdj?=
 =?utf-8?B?M1ptK3QxVjJOeEJtaUdBNjg4c3hEREtuQkJOdlgxMnhnaDI2N3VXM3hOTkZx?=
 =?utf-8?B?cmFUcnFNVHBvbnphbVlCOThiNG1CNXR5bGNlR3JoY01Ib1ZRZ214cFM2UEkx?=
 =?utf-8?B?R3VtazhLblZ0dm1LWEJkMkkxT3lpUzE3YnBUdnJnL0JaeDlKZUI5SnpvdnYx?=
 =?utf-8?B?MCszbFBGSlNLWlV0WVNhRkEycXQyNkZycmtOaUxmd2lSTTR2bVJ1Umd1MkhL?=
 =?utf-8?B?RnZXTkRXUkxhZ2JLbFRLOUNOTnRHZEE2a0tmTWI5R1BTZmk2WHRZZENxK245?=
 =?utf-8?B?T0ZRU2VEZzlRNVNMYUEyQ1hiU2JxVWV6bHhzZXVEZmhWTW9jbS9hMy81aExC?=
 =?utf-8?B?SjlMRWZZUmtnMG5UM3EzWEcweDNmMXk2N2N1U3hwRG9sNzhxbzFiWG03NXBH?=
 =?utf-8?B?b0o3ZzFrUStZQ1M5QkNMTnNkNmhzSzJkbWV3Z1pQWkJsUC9MQlRrZnlLdmlG?=
 =?utf-8?B?RFBwbmtXQU4vY1lsR2lCdWozK3AzMVloSS9WekdVUy9hSzlCYVZ0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7defd41a-198a-4405-4880-08de814a9631
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 21:50:48.2782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQ7lp66RWzoVpleRDB/DLnE2B29pXHxWegDcdl9Q8zOfSEq/C63nfFG4sOKG5GtvoLzUwUYeFgi4qz6ZsTE+iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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



On 3/13/2026 3:26 PM, Lizhi Hou wrote:
> 
> On 3/13/26 11:30, Mario Limonciello wrote:
>> On 3/13/2026 1:14 PM, Lizhi Hou wrote:
>>> The firmware implements the GET_APP_HEALTH command to collect debug
>>> information for a specific hardware context.
>>>
>>> When a command times out, the driver issues this command to collect the
>>> relevant debug information. User space tools can also retrieve this
>>> information through the hardware context query IOCTL.
>>
>> A few thoughts about this.
>>
>> 1) Depending upon the reason the command timed out, it's possible the 
>> get app health command also fails.
> The timed out command means the IO command sent through IO mailbox 
> channel. The get app health command is sent through management channel. 
> It should not fail unless there is firmware bug.

Got it; thanks for clarification.

>>
>> 2) I think it would make sense to put this information into 
>> devcoredump.  Then you don't /need/ a tool to read it.
> The error information is return to the application through the payload 
> of the same command. So the application needs to decide how to interpret 
> and deal with the information. It just like an application calls API and 
> get an error information buffer returned. There is nothing wrong with 
> the driver, firmware or hardware.

Ah I see.

>>
>>>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/accel/amdxdna/aie2_ctx.c      | 85 ++++++++++++++++++++++++---
>>>   drivers/accel/amdxdna/aie2_message.c  | 41 +++++++++++++
>>>   drivers/accel/amdxdna/aie2_msg_priv.h | 52 ++++++++++++++++
>>>   drivers/accel/amdxdna/aie2_pci.c      | 14 +++++
>>>   drivers/accel/amdxdna/aie2_pci.h      |  4 ++
>>>   drivers/accel/amdxdna/amdxdna_ctx.c   |  6 +-
>>>   drivers/accel/amdxdna/amdxdna_ctx.h   | 11 +++-
>>>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>>>   8 files changed, 205 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/ 
>>> amdxdna/aie2_ctx.c
>>> index 779ac70d62d7..8b7375d13e28 100644
>>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>>> @@ -29,6 +29,16 @@ MODULE_PARM_DESC(force_cmdlist, "Force use command 
>>> list (Default true)");
>>>     #define HWCTX_MAX_TIMEOUT    60000 /* milliseconds */
>>>   +struct aie2_ctx_health {
>>> +    struct amdxdna_ctx_health header;
>>> +    u32 txn_op_idx;
>>> +    u32 ctx_pc;
>>> +    u32 fatal_error_type;
>>> +    u32 fatal_error_exception_type;
>>> +    u32 fatal_error_exception_pc;
>>> +    u32 fatal_error_app_module;
>>> +};
>>> +
>>>   static void aie2_job_release(struct kref *ref)
>>>   {
>>>       struct amdxdna_sched_job *job;
>>> @@ -39,6 +49,7 @@ static void aie2_job_release(struct kref *ref)
>>>       wake_up(&job->hwctx->priv->job_free_wq);
>>>       if (job->out_fence)
>>>           dma_fence_put(job->out_fence);
>>> +    kfree(job->priv);
>>>       kfree(job);
>>>   }
>>>   @@ -176,6 +187,50 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>>>       aie2_job_put(job);
>>>   }
>>>   +static void aie2_set_cmd_timeout(struct amdxdna_sched_job *job)
>>> +{
>>> +    struct aie2_ctx_health *aie2_health __free(kfree) = NULL;
>>> +    struct amdxdna_dev *xdna = job->hwctx->client->xdna;
>>> +    struct amdxdna_gem_obj *cmd_abo = job->cmd_bo;
>>> +    struct app_health_report *report = job->priv;
>>> +    u32 fail_cmd_idx = 0;
>>> +
>>> +    if (!report)
>>> +        goto set_timeout;
>>> +
>>> +    XDNA_ERR(xdna, "Firmware timeout state capture:");
>>> +    XDNA_ERR(xdna, "\tVersion: %d.%d", report->major, report->minor);
>>> +    XDNA_ERR(xdna, "\tReport size: 0x%x", report->size);
>>> +    XDNA_ERR(xdna, "\tContext ID: %d", report->context_id);
>>> +    XDNA_ERR(xdna, "\tDPU PC: 0x%x", report->dpu_pc);
>>> +    XDNA_ERR(xdna, "\tTXN OP ID: 0x%x", report->txn_op_id);
>>> +    XDNA_ERR(xdna, "\tContext PC: 0x%x", report->ctx_pc);
>>> +    XDNA_ERR(xdna, "\tFatal error type: 0x%x", report- 
>>> >fatal_info.fatal_type);
>>> +    XDNA_ERR(xdna, "\tFatal error exception type: 0x%x", report- 
>>> >fatal_info.exception_type);
>>> +    XDNA_ERR(xdna, "\tFatal error exception PC: 0x%x", report- 
>>> >fatal_info.exception_pc);
>>> +    XDNA_ERR(xdna, "\tFatal error app module: 0x%x", report- 
>>> >fatal_info.app_module);
>>> +    XDNA_ERR(xdna, "\tFatal error task ID: %d", report- 
>>> >fatal_info.task_index);
>>> +    XDNA_ERR(xdna, "\tTimed out sub command ID: %d", report- 
>>> >run_list_id);
>>
>> Basically all of this information -> devcoredump instead
>>
>> You can reference how amdgpu does it.  Basically it says there is an 
>> error, and here's where the devcoredump with all the info for the 
>> error is stored.
>>
>> Then a process in userspace can monitor (inotify?) and 
>> (automatically?) evict information from devcoredump.
> Currently, the dmesg is a place to observe it if application itself 
> ignores the error detail. It reminds there is an error with the 
> application running on hardware and it helps a lot. I will look into 
> devcoredump. I feel it could be a separated patch if we would add it.
>>

Yeah it could be a separate patch if you decide it makes sense.

>>> +
>>> +    fail_cmd_idx = report->run_list_id;
>>> +    aie2_health = kzalloc_obj(*aie2_health);
>>> +    if (!aie2_health)
>>> +        goto set_timeout;
>>> +
>>> +    aie2_health->header.version = AMDXDNA_CMD_CTX_HEALTH_V1;
>>> +    aie2_health->header.npu_gen = AMDXDNA_CMD_CTX_HEALTH_AIE2;
>>> +    aie2_health->txn_op_idx = report->txn_op_id;
>>> +    aie2_health->ctx_pc = report->ctx_pc;
>>> +    aie2_health->fatal_error_type = report->fatal_info.fatal_type;
>>> +    aie2_health->fatal_error_exception_type = report- 
>>> >fatal_info.exception_type;
>>> +    aie2_health->fatal_error_exception_pc = report- 
>>> >fatal_info.exception_pc;
>>> +    aie2_health->fatal_error_app_module = report- 
>>> >fatal_info.app_module;
>>> +
>>> +set_timeout:
>>> +    amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, 
>>> ERT_CMD_STATE_TIMEOUT,
>>> +                  aie2_health, sizeof(*aie2_health));
>>> +}
>>> +
>>>   static int
>>>   aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
>>>   {
>>> @@ -187,13 +242,13 @@ aie2_sched_resp_handler(void *handle, void 
>>> __iomem *data, size_t size)
>>>       cmd_abo = job->cmd_bo;
>>>         if (unlikely(job->job_timeout)) {
>>> -        amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_TIMEOUT);
>>> +        aie2_set_cmd_timeout(job);
>>>           ret = -EINVAL;
>>>           goto out;
>>>       }
>>>         if (unlikely(!data) || unlikely(size != sizeof(u32))) {
>>> -        amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT);
>>> +        amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT, 
>>> NULL, 0);
>>>           ret = -EINVAL;
>>>           goto out;
>>>       }
>>> @@ -203,7 +258,7 @@ aie2_sched_resp_handler(void *handle, void 
>>> __iomem *data, size_t size)
>>>       if (status == AIE2_STATUS_SUCCESS)
>>>           amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_COMPLETED);
>>>       else
>>> -        amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ERROR);
>>> +        amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ERROR, 
>>> NULL, 0);
>>>     out:
>>>       aie2_sched_notify(job);
>>> @@ -237,21 +292,21 @@ aie2_sched_cmdlist_resp_handler(void *handle, 
>>> void __iomem *data, size_t size)
>>>       struct amdxdna_sched_job *job = handle;
>>>       struct amdxdna_gem_obj *cmd_abo;
>>>       struct amdxdna_dev *xdna;
>>> +    u32 fail_cmd_idx = 0;
>>>       u32 fail_cmd_status;
>>> -    u32 fail_cmd_idx;
>>>       u32 cmd_status;
>>>       int ret = 0;
>>>         cmd_abo = job->cmd_bo;
>>>         if (unlikely(job->job_timeout)) {
>>> -        amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_TIMEOUT);
>>> +        aie2_set_cmd_timeout(job);
>>>           ret = -EINVAL;
>>>           goto out;
>>>       }
>>>         if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {
>>> -        amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT);
>>> +        amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT, 
>>> NULL, 0);
>>>           ret = -EINVAL;
>>>           goto out;
>>>       }
>>> @@ -271,10 +326,10 @@ aie2_sched_cmdlist_resp_handler(void *handle, 
>>> void __iomem *data, size_t size)
>>>            fail_cmd_idx, fail_cmd_status);
>>>         if (fail_cmd_status == AIE2_STATUS_SUCCESS) {
>>> -        amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, 
>>> ERT_CMD_STATE_ABORT);
>>> +        amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, 
>>> ERT_CMD_STATE_ABORT, NULL, 0);
>>>           ret = -EINVAL;
>>>       } else {
>>> -        amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, 
>>> ERT_CMD_STATE_ERROR);
>>> +        amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, 
>>> ERT_CMD_STATE_ERROR, NULL, 0);
>>>       }
>>>     out:
>>> @@ -363,12 +418,26 @@ aie2_sched_job_timedout(struct drm_sched_job 
>>> *sched_job)
>>>   {
>>>       struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>>>       struct amdxdna_hwctx *hwctx = job->hwctx;
>>> +    struct app_health_report *report;
>>>       struct amdxdna_dev *xdna;
>>> +    int ret;
>>>         xdna = hwctx->client->xdna;
>>>       trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
>>>       job->job_timeout = true;
>>> +
>>>       mutex_lock(&xdna->dev_lock);
>>
>> AFAICT you never unlock this mutex.
> The unlock is not in the patch but before the function exits.

OK.

>>
>>> +    report = kzalloc_obj(*report);
>>> +    if (!report)
>>> +        goto reset_hwctx;
>>> +
>>> +    ret = aie2_query_app_health(xdna->dev_handle, hwctx->fw_ctx_id, 
>>> report);
>>> +    if (ret)
>>> +        kfree(report);
>>> +    else
>>> +        job->priv = report;
>>> +
>>> +reset_hwctx:
>>>       aie2_hwctx_stop(xdna, hwctx, sched_job);
>>>         aie2_hwctx_restart(xdna, hwctx);
>>> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/ 
>>> amdxdna/aie2_message.c
>>> index fa2f33c322d4..b764c7e8816a 100644
>>> --- a/drivers/accel/amdxdna/aie2_message.c
>>> +++ b/drivers/accel/amdxdna/aie2_message.c
>>> @@ -1161,3 +1161,44 @@ int aie2_config_debug_bo(struct amdxdna_hwctx 
>>> *hwctx, struct amdxdna_sched_job *
>>>         return xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
>>>   }
>>> +
>>> +int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
>>> +              struct app_health_report *report)
>>> +{
>>> +    DECLARE_AIE2_MSG(get_app_health, MSG_OP_GET_APP_HEALTH);
>>> +    struct amdxdna_dev *xdna = ndev->xdna;
>>> +    struct app_health_report *buf;
>>> +    dma_addr_t dma_addr;
>>> +    u32 buf_size;
>>> +    int ret;
>>> +
>>> +    if (!AIE2_FEATURE_ON(ndev, AIE2_APP_HEALTH)) {
>>> +        XDNA_DBG(xdna, "App health feature not supported");
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +
>>> +    buf_size = sizeof(*report);
>>> +    buf = aie2_alloc_msg_buffer(ndev, &buf_size, &dma_addr);
>>> +    if (IS_ERR(buf)) {
>>> +        XDNA_ERR(xdna, "Failed to allocate buffer for app health");
>>> +        return PTR_ERR(buf);
>>> +    }
>>> +
>>> +    req.buf_addr = dma_addr;
>>> +    req.context_id = context_id;
>>> +    req.buf_size = buf_size;
>>> +
>>> +    drm_clflush_virt_range(buf, sizeof(*report));
>>> +    ret = aie2_send_mgmt_msg_wait(ndev, &msg);
>>> +    if (ret) {
>>> +        XDNA_ERR(xdna, "Get app health failed, ret %d status 0x%x", 
>>> ret, resp.status);
>>> +        goto free_buf;
>>> +    }
>>> +
>>> +    /* Copy the report to caller's buffer */
>>> +    memcpy(report, buf, sizeof(*report));
>>> +
>>> +free_buf:
>>> +    aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
>>> +    return ret;
>>> +}
>>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/ 
>>> amdxdna/aie2_msg_priv.h
>>> index 728ef56f7f0a..f18e89a39e35 100644
>>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>>> @@ -31,6 +31,7 @@ enum aie2_msg_opcode {
>>>       MSG_OP_SET_RUNTIME_CONFIG          = 0x10A,
>>>       MSG_OP_GET_RUNTIME_CONFIG          = 0x10B,
>>>       MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
>>> +    MSG_OP_GET_APP_HEALTH              = 0x114,
>>>       MSG_OP_MAX_DRV_OPCODE,
>>>       MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
>>>       MSG_OP_MAX_OPCODE
>>> @@ -451,4 +452,55 @@ struct config_debug_bo_req {
>>>   struct config_debug_bo_resp {
>>>       enum aie2_msg_status    status;
>>>   } __packed;
>>> +
>>> +struct fatal_error_info {
>>> +    __u32 fatal_type;         /* Fatal error type */
>>> +    __u32 exception_type;     /* Only valid if fatal_type is a 
>>> specific value */
>>> +    __u32 exception_argument; /* Argument based on exception type */
>>> +    __u32 exception_pc;       /* Program Counter at the time of the 
>>> exception */
>>> +    __u32 app_module;         /* Error module name */
>>> +    __u32 task_index;         /* Index of the task in which the 
>>> error occurred */
>>> +    __u32 reserved[128];
>>> +};
>>> +
>>> +struct app_health_report {
>>> +    __u16 major;
>>> +    __u16 minor;
>>> +    __u32 size;
>>> +    __u32 context_id;
>>> +    /*
>>> +     * Program Counter (PC) of the last initiated DPU opcode, as 
>>> reported by the ERT
>>> +     * application. Before execution begins or after successful 
>>> completion, the value is set
>>> +     * to UINT_MAX. If execution halts prematurely due to an error, 
>>> this field retains the
>>> +     * opcode's PC value.
>>> +     * Note: To optimize performance, the ERT may simplify certain 
>>> aspects of reporting.
>>> +     * Proper interpretation requires familiarity with the 
>>> implementation details.
>>> +     */
>>> +    __u32 dpu_pc;
>>> +    /*
>>> +     * Index of the last initiated TXN opcode.
>>> +     * Before execution starts or after successful completion, the 
>>> value is set to UINT_MAX.
>>> +     * If execution halts prematurely due to an error, this field 
>>> retains the opcode's ID.
>>> +     * Note: To optimize performance, the ERT may simplify certain 
>>> aspects of reporting.
>>> +     * Proper interpretation requires familiarity with the 
>>> implementation details.
>>> +     */
>>> +    __u32 txn_op_id;
>>> +    /* The PC of the context at the time of the report */
>>> +    __u32 ctx_pc;
>>> +    struct fatal_error_info        fatal_info;
>>> +    /* Index of the most recently executed run list entry. */
>>> +    __u32 run_list_id;
>>> +};
>>> +
>>> +struct get_app_health_req {
>>> +    __u32 context_id;
>>> +    __u32 buf_size;
>>> +    __u64 buf_addr;
>>> +} __packed;
>>> +
>>> +struct get_app_health_resp {
>>> +    enum aie2_msg_status status;
>>> +    __u32 required_buffer_size;
>>> +    __u32 reserved[7];
>>> +} __packed;
>>>   #endif /* _AIE2_MSG_PRIV_H_ */
>>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/ 
>>> amdxdna/aie2_pci.c
>>> index ddd3d82f3426..9e39bfe75971 100644
>>> --- a/drivers/accel/amdxdna/aie2_pci.c
>>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>>> @@ -846,7 +846,10 @@ static int aie2_hwctx_status_cb(struct 
>>> amdxdna_hwctx *hwctx, void *arg)
>>>       struct amdxdna_drm_hwctx_entry *tmp __free(kfree) = NULL;
>>>       struct amdxdna_drm_get_array *array_args = arg;
>>>       struct amdxdna_drm_hwctx_entry __user *buf;
>>> +    struct app_health_report report;
>>> +    struct amdxdna_dev_hdl *ndev;
>>>       u32 size;
>>> +    int ret;
>>>         if (!array_args->num_element)
>>>           return -EINVAL;
>>> @@ -869,6 +872,17 @@ static int aie2_hwctx_status_cb(struct 
>>> amdxdna_hwctx *hwctx, void *arg)
>>>       tmp->latency = hwctx->qos.latency;
>>>       tmp->frame_exec_time = hwctx->qos.frame_exec_time;
>>>       tmp->state = AMDXDNA_HWCTX_STATE_ACTIVE;
>>> +    ndev = hwctx->client->xdna->dev_handle;
>>> +    ret = aie2_query_app_health(ndev, hwctx->fw_ctx_id, &report);
>>> +    if (!ret) {
>>> +        /* Fill in app health report fields */
>>> +        tmp->txn_op_idx = report.txn_op_id;
>>> +        tmp->ctx_pc = report.ctx_pc;
>>> +        tmp->fatal_error_type = report.fatal_info.fatal_type;
>>> +        tmp->fatal_error_exception_type = 
>>> report.fatal_info.exception_type;
>>> +        tmp->fatal_error_exception_pc = report.fatal_info.exception_pc;
>>> +        tmp->fatal_error_app_module = report.fatal_info.app_module;
>>> +    }
>>>         buf = u64_to_user_ptr(array_args->buffer);
>>>       size = min(sizeof(*tmp), array_args->element_size);
>>> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/ 
>>> amdxdna/aie2_pci.h
>>> index 885ae7e6bfc7..6cced8ab936b 100644
>>> --- a/drivers/accel/amdxdna/aie2_pci.h
>>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/limits.h>
>>>   #include <linux/semaphore.h>
>>>   +#include "aie2_msg_priv.h"
>>>   #include "amdxdna_mailbox.h"
>>>     #define AIE2_INTERVAL    20000    /* us */
>>> @@ -261,6 +262,7 @@ enum aie2_fw_feature {
>>>       AIE2_NPU_COMMAND,
>>>       AIE2_PREEMPT,
>>>       AIE2_TEMPORAL_ONLY,
>>> +    AIE2_APP_HEALTH,
>>>       AIE2_FEATURE_MAX
>>>   };
>>>   @@ -341,6 +343,8 @@ int aie2_query_aie_version(struct 
>>> amdxdna_dev_hdl *ndev, struct aie_version *ver
>>>   int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct 
>>> aie_metadata *metadata);
>>>   int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
>>>                   struct amdxdna_fw_ver *fw_ver);
>>> +int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
>>> +              struct app_health_report *report);
>>>   int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct 
>>> amdxdna_hwctx *hwctx);
>>>   int aie2_destroy_context(struct amdxdna_dev_hdl *ndev, struct 
>>> amdxdna_hwctx *hwctx);
>>>   int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, 
>>> u64 addr, u64 size);
>>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/ 
>>> amdxdna/amdxdna_ctx.c
>>> index 666dfd7b2a80..4b921715176d 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>>> @@ -137,7 +137,8 @@ u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj 
>>> *abo)
>>>     int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>>>                 struct amdxdna_sched_job *job, u32 cmd_idx,
>>> -              enum ert_cmd_state error_state)
>>> +              enum ert_cmd_state error_state,
>>> +              void *err_data, size_t size)
>>>   {
>>>       struct amdxdna_client *client = job->hwctx->client;
>>>       struct amdxdna_cmd *cmd = abo->mem.kva;
>>> @@ -156,6 +157,9 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj 
>>> *abo,
>>>       }
>>>         memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
>>> +    if (err_data)
>>> +        memcpy(cmd->data, err_data, min(size, abo->mem.size - 
>>> sizeof(*cmd)));
>>> +
>>>       if (cc)
>>>           amdxdna_gem_put_obj(abo);
>>>   diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/ 
>>> amdxdna/amdxdna_ctx.h
>>> index fbdf9d000871..c067688755af 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>>> @@ -72,6 +72,13 @@ struct amdxdna_cmd_preempt_data {
>>>       u32 prop_args[];    /* properties and regular kernel arguments */
>>>   };
>>>   +#define AMDXDNA_CMD_CTX_HEALTH_V1    1
>>> +#define AMDXDNA_CMD_CTX_HEALTH_AIE2    0
>>> +struct amdxdna_ctx_health {
>>> +    u32 version;
>>> +    u32 npu_gen;
>>> +};
>>> +
>>>   /* Exec buffer command header format */
>>>   #define AMDXDNA_CMD_STATE        GENMASK(3, 0)
>>>   #define AMDXDNA_CMD_EXTRA_CU_MASK    GENMASK(11, 10)
>>> @@ -136,6 +143,7 @@ struct amdxdna_sched_job {
>>>       u64            seq;
>>>       struct amdxdna_drv_cmd    *drv_cmd;
>>>       struct amdxdna_gem_obj    *cmd_bo;
>>> +    void            *priv;
>>
>> Are you envisioning overloading the purpose of this member in the 
>> future?  If not, I think you should explicitly set it as
> Yes. it could be used differently for other platforms. It is used for 
> app_health data for AIE2 which other platforms may not have.

What about if you had a struct?

Sometihng like:

struct xdna_sched_job_priv
{
	struct app_health_report *health;
	struct foo_bar_purpose *purpose;
};

Then you can still only populate the parts that are needed for each 
platform?

>>
>> struct app_health_report *health_report;
>>
>> That will make the code a lot easier to follow.
>>
>>>       size_t            bo_cnt;
>>>       struct drm_gem_object    *bos[] __counted_by(bo_cnt);
>>>   };
>>> @@ -169,7 +177,8 @@ void *amdxdna_cmd_get_payload(struct 
>>> amdxdna_gem_obj *abo, u32 *size);
>>>   u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo);
>>>   int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>>>                 struct amdxdna_sched_job *job, u32 cmd_idx,
>>> -              enum ert_cmd_state error_state);
>>> +              enum ert_cmd_state error_state,
>>> +              void *err_data, size_t size);
>>>     void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job);
>>>   void amdxdna_hwctx_remove_all(struct amdxdna_client *client);
>>> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/ 
>>> amdxdna/npu4_regs.c
>>> index ce25eef5fc34..d44fe8fd6cb0 100644
>>> --- a/drivers/accel/amdxdna/npu4_regs.c
>>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>>> @@ -93,7 +93,8 @@ const struct aie2_fw_feature_tbl 
>>> npu4_fw_feature_table[] = {
>>>       { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor 
>>> = 15 },
>>>       { .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 
>>> 12 },
>>>       { .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 
>>> 6, .min_minor = 12 },
>>> -    { .features = GENMASK_ULL(AIE2_TEMPORAL_ONLY, 
>>> AIE2_NPU_COMMAND), .major = 7 },
>>
>> To avoid bit banging this line in the future, what if you used:
>>
>> GENMASK_ULL(AIE2_FEATURE_MAX-1)
> 
> Good point. Thanks.
> 
> Lizhi
> 
>>
>>> +    { .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor = 
>>> 18 },
>>> +    { .features = GENMASK_ULL(AIE2_APP_HEALTH, 
>>> AIE2_NPU_COMMAND), .major = 7 },
>>>       { 0 }
>>>   };
>>

