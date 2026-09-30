Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2B4CA5FAD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 00:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B25110E535;
	Wed, 30 Sep 2026 00:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xF46vTuS";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA90410E535
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXpjgQyVqBYPWR9pCfcCFeND+uAMhlnEcQsCSj7gZshElm9PyPbKxyrFOxO56WYdpd9zXmUbTUWZEjQtNXYh1RuWtYEIjMnMkRuSd21lY9OnKY4riBBnbJNlWmekfKnDnSqmlAjL49qkD5JURTYpSsTEB1dTQKOCWf4fKo9y45TvDJe/5cNEfDim3hgOrImlVroMANJyKjwjqrdo+pJUiEHUw4n27gyUMYwMRUaFX+qtgKf5xjetRItjV46FyY7yTnBEt4UjOlej7GxCuBh8NhDQ/YsTyXUxt/aJvSEmi3vZPZB70ZKaFMEd0/Yt2gHvsBu+jQAg6Svc2j+gmqnf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E6SZgQWf29lNgUdSSlX9bD58CnfIvNlhB8EpnifMyo=;
 b=lrsMtu6lRDsG2MfWYjZiieVPCoit9nWWE6EMcUC+aXSU2mgP519T6Dop2LxK2mBFmdibYIiOlaK1/dReV6XSpb/lw+Iars/w9xaLFODcLJ86DxUMbsmqn3tjfmM285YVlahtzRyidZCnVEQZrykdZuTbo1Vb5gC6JeKZlAPyuxmwsK8OoAmxsI2bRtuaheJKkh+gqTLqWnkfJqXjzeAr+vNFbtEFbGG6moykSGP89sQUi4cd4OhKMEYDSAue46o6wHzpk1egvAaQYXLgRWDVSk9+dwGX6CKoYNLBqs+oiMbIAelWNxPh3V6jf4LDuRcI8jdSC0Ef/1Jph2rB31QF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E6SZgQWf29lNgUdSSlX9bD58CnfIvNlhB8EpnifMyo=;
 b=xF46vTuSZafv6bPsvtbVwK+WEsb7QN9jX9iuf6Ex9uruVOH/VN2CCthmoadJ0TRJQtOoGgo5EYIJYa1sxNtx9m4r0zFlRVMaEooa66k6+w2chLObtkQOl9Lzo8oWFBzywuZ7CL2w6JLFrRPu4JFz7/W9MxizaWJXnf1qRsU0i/I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 00:20:42 +0000
Received: from IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257]) by IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 00:20:40 +0000
Message-ID: <906d1899-26af-4829-8a4b-9d451ff13917@amd.com>
Date: Tue, 29 Sep 2026 17:20:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V0 14/21] accel/amdxdna: Fix fence timeline name and
 context allocation
To: Lizhi Hou <lizhi.hou@amd.com>, quic_jhugo@quicinc.com,
 karol.wachowski@linux.intel.com, max.zhen@amd.com, ogabbay@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: sonal.santan@amd.com, mario.limonciello@amd.com
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
 <20260926013448.3840921-15-yidong.zhang@amd.com>
 <c5da23b0-1552-b601-78e9-602e4140297d@amd.com>
Content-Language: en-US
From: "Zhang, Yidong (David)" <yidong.zhang@amd.com>
In-Reply-To: <c5da23b0-1552-b601-78e9-602e4140297d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To IA1PR12MB9062.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9062:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ac9979-f982-4c0c-7e4b-08df1e88a873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|3023799007|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zSg3TeV7IoSeJO7IgtV3nzPNDeW1NsKat2Aagp5OusmEBWZH8W47p6LYcZEJ72eFdXg5VYr8sUguKrDwfqf/6brQI36sIZ3g76D+CY4cwICr7Ffg9FZGuIYS7s3l3y2I6SmC1NSF8LPeTFbqCnmKjElywn8LMaHiFGJU+U2f8Te6F1H/dtGepJ28wFhlQ4nxrshPNodfd0C+yfa6PXv6hjmg3hp94cceLn2f7uLjkKsy20JKBn6UrFjuOoiRaQlhsCF7ClxM3Ntpq2AZ2sA/ufD4Hwf2AGdeYSTAkX2G6p7ykVHiOMg1kdXG9FgREH57+NjSWrAzZVlmdciCkhLpaC0MlwJ8zOFL9i9nx9ZIsmafYk6ukS1FxEal3Vcg5kL7+GRaFVg2fETDhJrBm5c0Ncl/Ro2bmnXDJEmNq2t+TOYlRPru3pnEzV8NW0dL00VHVAPtGRyvmEqygB6yH5PO9SZWeMNjtiF+XI5/gx3X5qxmfsVTPNA6iflKvefCv5V8V6CuAfNRkIkPfKcJlYLddDoPiL7TCtnbZ92OLdT/QRBZsS2Hk6tXDm7AG0Ly7akUB2d/L6gysmtEn/+dVFw4fORnBiPN2/vZaSBbTbPRagNoEQwf24+awXd54VP2rVg1t+zgCXI8AxpqQOPGr4z0HnCzUcOT/QzWxsBIw8Kfgb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(3023799007)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzkwcCtjY2NiQlp1d0huRkpoQVZaQ0kwT3h4RGc3cExnMXQ0bDIySGlWdytl?=
 =?utf-8?B?allpelFZMHV1aGVJRHZVcEt5VnpISitFb2k1R0dIaVJkWkJDcWFxNktHblQ5?=
 =?utf-8?B?ZVducENrLzZ4aUtmVFZCa1c4Q1E0VW9xdTBQU0tiS3oxaDF6ZlFCc2pIOWhT?=
 =?utf-8?B?OGVja1dYbU15MW13azFINWhZWTB3OEExdlpvbmwrcFYrc3RrcjBOSmNMV3ZD?=
 =?utf-8?B?NG5mbi9zcndqUjhxZyt0UnlJUVBVc2ptSG9RWEhVNUI1dFdNWjhuck9YYWZs?=
 =?utf-8?B?RjIrUWE4OVc3ZHhScHN3QnBBeHpJZi9HQk1HSklNNkxvbWJMdHFBSGlzL2hP?=
 =?utf-8?B?WlhWalVFSHg0RGx0R3dYTmo5ZElLMnRUOVEyZFBVNjJvdEZwQitmcDcyNTJH?=
 =?utf-8?B?L2lWVjNxdEFHY3RWYnRReElKa05JSzhBSndSMkZYTGo3a1pzU2Z6eWZ5Vkpm?=
 =?utf-8?B?RVVuSWY4VXkrUVFKbkdNdy9PL0xHNUtlVDN2bDAxcHkwRzBKWlE1WlB2dEt6?=
 =?utf-8?B?azYrdWZSdGJlSk5ydFVIR2ptVjc0SmYwZk55WlQxNThDTXc2VUFJMWRmc2F3?=
 =?utf-8?B?RlN4bGhtN3NmNllYWG9mbGNONGJaRWU0Rmo5QWFNeU1LYUxBOVNlNWpFNFNw?=
 =?utf-8?B?R2xHS1kwWlh1dHdWYlpWSThLTUtvQ1V5WVg0V3BHVGsrdTZoVm8zSXZTazBE?=
 =?utf-8?B?M2hGYmR2VGtNMm0yN3FjNHVHbkZjM1RsTHR6aEZzWkNTYnpFekpjK1dlUDJV?=
 =?utf-8?B?VXBCTzJwcnRGZldjQ3pwQzFHMzU2YmpnTmxiTVBmWEJ6UjhWNC9CaWQ1ZmZq?=
 =?utf-8?B?eDNESGJnNjNQUmNPaE4wZVhkWkh6VXByMkFVVmRCVGVreFMvQ1QwcFFZdDEv?=
 =?utf-8?B?dTRzK21nc25SQmxWZmowZHE0dHZDVVRPSG5mWlZhMmVlNU4xSkVhdHljRkx2?=
 =?utf-8?B?UHVrcnZVNTYzbldGdW1CeGhibW9YVWI2MjJ2TDNPY0dtOVFhaS81TWtDOER3?=
 =?utf-8?B?ZkluSFduWEZ0NGp4YlNtMVNiWWRDdVY1Uk1VbHRPckJ6YXozY2EySTRGbnNO?=
 =?utf-8?B?dUZQaHUxd1J1UXJxc2psUlBqMVQ1Nk1hUUZjV3FTc3FTSkwvbzNHWDJXdlZJ?=
 =?utf-8?B?aURsSXJ6Ui96c0MySnlqWDdYQnU3L2pUam5aRy9KTzhGMHR6YlRVbXdXOE9p?=
 =?utf-8?B?aGl2NWkxamNZa09ZYlRWY0gxU08xMy9JVWFqUnkvdzQ1cjVhUEZlOVBvOVBv?=
 =?utf-8?B?MDF1SUhiZ0xYWmsxMTNvWVkzRGxKd1htSjNFM1ZKR2ZYZVV5ZUxjT3ZxOWRX?=
 =?utf-8?B?VVloY3QxN1dIdWozNjlXOUxXV2RiQzBuVUdpNkN4a3hzblZYT05PSWdTWDBi?=
 =?utf-8?B?Z3dQMjR4Z0Vac3FSTEhQQlRacnZkeVpma05JcnF6Y1J6bE8zV0Vua0VqdEd5?=
 =?utf-8?B?S1B0L3BsRjhsU3ptWDFzakZGVVNNdndJUThIby83c25xRHg2WmFXZ2RyRHAx?=
 =?utf-8?B?SHU2OXVBUENXZnplY2hXTUs4eFBiU1B1dlhoU09GcGZNc045dGZPRFNqZFBT?=
 =?utf-8?B?Wm94R1FGMncxd2o2WjlkcFEwZWZDSTdzZ0R5VzYvblJDV0xQK3ZEYVJtMU1B?=
 =?utf-8?B?NWlhUWNLZmdWc2FZRUxudmFHUW50WjF3RXUrMGVCcmxoOGc2Q0trbDN4emdJ?=
 =?utf-8?B?NFRMM1ZpOUFhSGtQTUNac1ZsZ1E5Vk9PSzlzR1ZEVDRWd1NDSmxjNXZsZTAx?=
 =?utf-8?B?cTl3cDRpbUJYYWl5ZS9DQkhIYUlxRVlYa1U0OTBLTzk2UVo2TVZEdEJURnNF?=
 =?utf-8?B?dDBNb3hBWlArOHlFbWNRdDFVZitrOUkxNEEyWEl3U3B3MGQrU3hQR0UrYnZs?=
 =?utf-8?B?WTUyTnoyZkl6MmJOV2lsVzZJTjgreWYrQmUyUjMraGpkZHhQcmNrNklFb0M0?=
 =?utf-8?B?WnkvZGUxUDVsT2NFZUJ4YzhlNTlDSFZtclUvOVdGYXJrMDlxUlFMZG1mUHFZ?=
 =?utf-8?B?QVZ3TkVIVFp4TmVoS0RwTFVTdWZFbVRqRTg2eDBLS0c3TkNXWWQxd3YwemJZ?=
 =?utf-8?B?MnFrMmI1bHU0aHhDQ0dMUnFZZ0JPYTkwNXo2Z3pOdUxhK09MVGpOc3BqUUlC?=
 =?utf-8?B?RnpEZ2pyV0JnQzcvS1ZDWUt6WnowTDhmMll2OE9ONjdQdG1GN1VTcDQ2dW8w?=
 =?utf-8?B?OTExK1Z4MDBYVnZJRFE2TVVjdWREdWU0d3liT0wxVHp5ekdidW93Z1h0VVhv?=
 =?utf-8?B?all4RldDVW1ISlVFbjBxczBzZy9yM3B0L2s0ZCtUeFM3SFpHY21md3RDOG11?=
 =?utf-8?B?OW1KcTBoeGN4eTVYVWFUOWNGTHB6a20vUVdNWjlDek9JRmVpSHJYdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ac9979-f982-4c0c-7e4b-08df1e88a873
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 00:20:40.4590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXFP3z+wzYxgrGCuqc1fFeTK0gYE2ZMoTS3f1XaE4xv+ZUF9+S15/JmMFlcngKmrMqIy/Vp/ZCzt5RD++BZT4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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


On 9/28/2026 2:06 PM, Lizhi Hou wrote:
>
> On 9/25/26 18:34, David Zhang wrote:
>> This is part of the fix to align BO reservation locking and fence
>> management with aie2.
>>
>> Fences published into BO reservation objects via dma_resv_add_fence()
>> can outlive the hardware context (e.g. when a BO is exported as a
>> dma-buf and imported by another process). Using hwctx->name for the 
>> fence
>> timeline name risks a use-after-free once the hwctx is destroyed.
>> Switch timeline name to dev_name() which is backed by the device that
>> outlives any individual context.
>>
>> Additionally, allocate a unique fence context via
>> dma_fence_context_alloc(1) for each job fence so that 
>> dma_resv_add_fence()
>> does not evict a prior in-flight job's fence from a shared BO's
>> reservation object when multiple jobs touch the same BO. Also guard
>> hwctx_fini call in amdxdna_hwctx_destroy_rcu() against NULL ops.
>
> Is this aie4 kernel submission specific? aie2 does not publish this 
> fence.
>
> If it does not fix any existing issue, please describe it clearly.

I have addressed your comments with a newer PATCH V1. This change is 
merged with KMQ patches.

It is AIE4 specific.


>
>>
>> The corresponding AIE4 command submission BO locking and fence
>> attachment logic is implemented in a subsequent patch ("accel/amdxdna:
>> Implement AIE4 command packet building and submission").
>>
>> Co-developed-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: David Zhang <yidong.zhang@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_ctx.c | 29 ++++++++++++++++++++++-------
>>   1 file changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index 888e857ec558..6ca7774150d5 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -25,7 +25,7 @@
>>   struct amdxdna_fence {
>>       struct dma_fence    base;
>>       spinlock_t        lock; /* for base */
>> -    struct amdxdna_hwctx    *hwctx;
>> +    struct device        *dev;
>>   };
>>     static const char *amdxdna_fence_get_driver_name(struct dma_fence 
>> *fence)
>> @@ -39,7 +39,14 @@ static const char 
>> *amdxdna_fence_get_timeline_name(struct dma_fence *fence)
>>         xdna_fence = container_of(fence, struct amdxdna_fence, base);
>>   -    return xdna_fence->hwctx->name;
>> +    /*
>> +     * Use device name rather than hwctx name: the fence is 
>> published into
>> +     * BO reservation objects via dma_resv_add_fence() and can 
>> outlive the
>> +     * hwctx (e.g. when a BO is exported as a dma-buf and imported by
>> +     * another process). The device outlives any individual context, so
>> +     * dev_name() is safe to call at any point during the fence's 
>> lifetime.
>> +     */
>> +    return dev_name(xdna_fence->dev);
>>   }
>>     static const struct dma_fence_ops fence_ops = {
>> @@ -55,9 +62,17 @@ static struct dma_fence 
>> *amdxdna_fence_create(struct amdxdna_hwctx *hwctx)
>>       if (!fence)
>>           return NULL;
>>   -    fence->hwctx = hwctx;
>> +    fence->dev = hwctx->client->xdna->ddev.dev;
>>       spin_lock_init(&fence->lock);
>> -    dma_fence_init(&fence->base, &fence_ops, &fence->lock, 
>> hwctx->id, 0);
>> +    /*
>> +     * Part of the fix to align BO reservation locking and fence
>> +     * management with AIE2: each job fence needs a unique context so
>> +     * dma_resv_add_fence() does not evict a prior job's fence from a
>> +     * shared BO's reservation object when two in-flight jobs touch
>> +     * the same BO. The corresponding AIE4 command submission locking
>> +     * and fence attachment is implemented in aie4_cmd_submit().
>> +     */
>> +    dma_fence_init(&fence->base, &fence_ops, &fence->lock, 
>> dma_fence_context_alloc(1), 0);
>>       return &fence->base;
>>   }
>>   @@ -81,13 +96,13 @@ static void 
>> amdxdna_hwctx_release_expanded_heap(struct amdxdna_hwctx *hwctx)
>>   static void amdxdna_hwctx_destroy_rcu(struct amdxdna_hwctx *hwctx,
>>                         struct srcu_struct *ss)
>>   {
>> -    struct amdxdna_client *client = hwctx->client;
>> -    struct amdxdna_dev *xdna = client->xdna;
>> +    struct amdxdna_dev *xdna = hwctx->client->xdna;
>>         synchronize_srcu(ss);
>>         /* At this point, user is not able to submit new commands */
>> -    xdna->dev_info->ops->hwctx_fini(hwctx);
>> +    if (xdna->dev_info->ops->hwctx_fini)
>> +        xdna->dev_info->ops->hwctx_fini(hwctx);
>
> This seems unrelated. Please remove from the patch.

Removed.

David

>
> Lizhi
>
>> amdxdna_hwctx_release_expanded_heap(hwctx);
>>       kfree(hwctx->name);
