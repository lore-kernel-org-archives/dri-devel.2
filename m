Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E495F9D0DA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D83110E63A;
	Tue, 14 Apr 2026 17:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jhgy2ULO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D9210E63A
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8goTZ0AIz3t7HsnOEaz7J3OlbKmmOGQKA4A1fRniKzYoBn9H//mnn5dzMVAS6s4CKd8JkjQBM03yCWO3pRMDZF9e+fuaUWsbC5OTQ0ZNSKQrUkSzoOSkG0KwdpWw2wgiXfS7drqmQ52IKcB1ILO5bJFXukMo6CSbOpgC139U7EFrh98vL4VGcYm7yam9iojxPjllndmjMtGDLVIPjjSbh9xMF4dQScN6Z3ONk5xqBIo5RnRj7QIy2/rGfhTyhCu/FCTlNvjtYnp2E30cRDtFqnVuJwlsqW5yLEioHnts8mQEPyG/2UYVAjG+hufjssvyXgEEBpyiNcuBxYwybJrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCmKO4425CHYtLM67oGuiP2Js33boEBYe4JM5BbF8zM=;
 b=WaRVninvWg47lNHFx/DXJOc6nutjqvdDVJ+bBm+qaUzeWofun5r2fx0gy/0jXHlbpuVA58wZuGCveAfoaqdr5iWXUSXePAe85QGa0BDhW4DTvhhw1g7yUbKGj5/lv3gYDaWVCA6Z0saALpy1luXelRKinoBmVhGBVb+L+o0IKdAUFfxugBAKiy4FEpcRUGlltKCmF/7yJ8kftDl9tE2TbfFsOay8pc3b32djXXW9xDMBmZOg570UOsIIsCNP3AOgnMsyRQIZTcrsnCVKwCd/VfKvt0Yer4QQVfQ8AkUGW23RWyJcDKnHBFSayFAR0cjNxaTxhevZsYE4ZCHj2Eq+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCmKO4425CHYtLM67oGuiP2Js33boEBYe4JM5BbF8zM=;
 b=Jhgy2ULOhRw2KQvPyAoPOdYuca6TnRKwl5DPTv+cZO7samQ1JqRwt25RqxiBIHTduaIkjbys61n0p60zfOj1GVG8mGe26jYEYvWN2f8GTqx0J4CPSjWd/HyDKSTH9HQSgYfz1kFrqiGqAV7eGhrEVZuektXsuSHCVKDVRNf6wdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH1PPF946CC24FA.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 17:32:22 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Tue, 14 Apr 2026
 17:32:22 +0000
Message-ID: <1be1c328-f807-45a7-9b54-a265c627e890@amd.com>
Date: Tue, 14 Apr 2026 12:32:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Add hardware scheduler time quantum
 support
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com, gregkh@linuxfoundation.org
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260414165602.788811-1-lizhi.hou@amd.com>
 <f233b761-ca66-4790-bdba-8407e696006b@amd.com>
 <54e62560-22a8-7f1b-642e-21042fc1f081@amd.com>
 <d58e78d3-dd94-4dc5-a80c-5f38836c4495@amd.com>
 <295f2c5c-1c16-96ab-b9b7-c465cc6ee16e@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <295f2c5c-1c16-96ab-b9b7-c465cc6ee16e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:610:b0::35) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH1PPF946CC24FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 15063a42-004e-4374-16ab-08de9a4bc966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: N58KHGxyf8Wki8DMG38EhETfSCWwrgILwv77QY4N17++TGtWjCndeYX9YIAXWX/7vbElHyS4dQYjYAGJ+IP8BAqqby8DqtB6KDIo4MRkydNRQuzm2XN5/v+Kvf+VoALDsAGuwsZnWvR8OnN3XG1CRMAP8doJ/G+44CchlADTLuxJwxzEwLIGOPIDYBBCLyeZn2qi9h2IH/Vj8dGQ10pwgFdFHXC73oS3YZmp9Cn2d90imESIJq/BZZ64F+iuWfHcEaQQZQ1tOWp41N1Zh94QVpkKGnsJHbQTUktiz1kVlyUoBqixgaBxRYmJcjuT+bxhtw8IVHA0e0umsF1RQbkbmXlhUs1WRERAwoTsPhovlG4o+DNfs+EmwhzVUJRWC0lK0Rb6lKusZHrZ3MDhX080gaPQDyWsF2aAHftjzecWRlgKGqBOVjBilJchN1Vj0YInpL2fC6oGWIquFA6TVFFuuwKMbMybo6A5VGi/7e3bb93XduKwiuLUXNxl2S7OlYV1inqA5bHVQWzoy2KWJ+ihzaAV8OdYBgHYo16+teAKfbGVk2swuohoFjQBSwsudptv3q2fpMKPuHBRsq9B9tJgts1nq8dnmlMBRjxtBRiXimIcRkFiYpeKskt+/x9H+2LuVsbezhTqXhuprFnHFTinjt42vyxAW0B5zg5FTQ/9z+bk/dafa9Kv+6VgirNI9ixsCzwjA9OR4RPluZXLX7WrojY+aAvBvtJczuKnZ5VUk1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUNvR1BQN2ZMWk5GUmZUQUllNjFLUjZuczJVOGlhTmNsSTFKMXhSVzZ1NEps?=
 =?utf-8?B?R3dON3JWR2l3UTZoeFlpZmluNmF6cmdUZW9TQWp1bGZEWXNyRjVoM1Y2TTVm?=
 =?utf-8?B?dUxOUmJMbE1RaEVjck5OaDQrWlV6dnpTMjgyL0xTRC9aS1pac2MrV2NFWlZF?=
 =?utf-8?B?MGhRVDlNS2lMQTZ0a1IxbGQ5eEdrVXp5M2dQb0xFdEJURFU0TWZ2N0R2L3Y2?=
 =?utf-8?B?NGFxclpYZzlnSkFmRDgrQmpkb2U0amJrZWE5akRRbys2VjFUTUxsS3JUcHJ2?=
 =?utf-8?B?VFBjUW5yUDJjZE9oSlNsZ3A1VjYvVEZQN2RQdUVIUGpKRVlIejV2aGtUNHRk?=
 =?utf-8?B?aXRGZVZITVJKY2hGd0JkUE9walF2bmdlU2l6RGs4aDM1Z3RoTXZlemE4VFlL?=
 =?utf-8?B?emp0WTdNSkc2TlNLVXVIOUFsRE5odVBmdmRscklSc1VOczVvK0V5cVNuZzJ0?=
 =?utf-8?B?MjhmWkphWVkxbVBaY0JVOFlLM1V0L0loUG1HWmxYTmxTMHQ0ZDZweitSNDhJ?=
 =?utf-8?B?aS9QVXREb0t5cVZwejQvOU1xZXh1S3d6SU0rNURTc3VYWU4rdnNyNHJneGhI?=
 =?utf-8?B?WWloZEZsbUtqRG1yMmJLckVOQk1qeld3ZjN3TWxmakpER2JMTGZyRi9OcTB0?=
 =?utf-8?B?T3NUd3ROQmhLaVdkcFoxZDFLVllaai8yL0l4a0tqYzZ6NkZVYzZOd2Y2a3hH?=
 =?utf-8?B?QVhjVzR4cUZNUzkrY1NuL2Jwajl3bTVmOWlPN2VucHBNSWV0N25CZWFNL1hw?=
 =?utf-8?B?bGNDZUJMcTIvUmJtSXlwQXpkWjBjWTJ4MmhnUjVmNGFoL0IwWkNWNnh0U3Rx?=
 =?utf-8?B?SUtTTGpYWGNMOFlQZ1QrbmM1M3M0c2liL1lselB1R1V4OWJEZUpBQ05mRm0y?=
 =?utf-8?B?ZlhoSlVncU1QREZ1TURwMzlHaTZnREhXUUcxaTVoSXJRemRwcC9lbjNHTzdx?=
 =?utf-8?B?TVJuNFVDTzNaQSsrRUFrbjd2MWV5aE9BbjZiTlQrYzZJUmVYK1NpUjVPTWZu?=
 =?utf-8?B?MTBTaXRpRGo0TXM1Rm5uYnBsY01VV2pJbGsvRHFLRUlRSlRqOFA0WEVqRzYy?=
 =?utf-8?B?eE1DVGE0c0ljMVcwUUFheElwaEFrMWZtUWJCSFZIblFpQXcweFFUV3BWUW8y?=
 =?utf-8?B?WWtaYmZvQ3BZWXFoYTUrdUJZL3VwUjQycnVVQ3REVDRWQnBTaGZ2dUlVaW1C?=
 =?utf-8?B?cmFKT0RoOWluVWROSXR5Vmg3RWxkeTdUd3FYb3l6VFNqNXZTL3IvZ0NCNE85?=
 =?utf-8?B?TitCMDhVOGtJTjRHNkxoUG1LOGdTbFZXM2lIdU9XK2hQTDJvMTU4QXQvbEla?=
 =?utf-8?B?clFLYm1LRjg5aDJmcXV3REJ6UGxLVWVXZGZEOXFXNkRLdnF0aFZqQ1ZRMVp6?=
 =?utf-8?B?aGNxZmN0OTFMUGZ0SFRGbUx4UEYxOERDM3FnSlZxS1crM3M0RmUrNEt2V1M1?=
 =?utf-8?B?OGc5UksxTnNQVGkyZmtLTDZocURSZ08vRWREb2dsUWloOThKbVI1d3JmTnF0?=
 =?utf-8?B?anMvMTFhZFB6N2d3ZEhhaDBQOUI2Vnk1OXA2M0N0WTMxeUpIcEFDY1JtWmFD?=
 =?utf-8?B?NEVicFJGb09mODd1cmQ2NnFXRjF2TlQ1dUJGMk5HVW0xQjJtNVNMdEhQdE1j?=
 =?utf-8?B?c1BBcEx6djV4YXJFTXZESXQ4aU15Mzc4V2FEOWNIaUQzYUt3bVloQWdvWHA5?=
 =?utf-8?B?NEIxOW0zNWdYVHVic0dzdnNTMGxncGhuR3RIV3l5cnBHZytJaW1INXM1akdw?=
 =?utf-8?B?aGNsbnROSXd6YTVWTDZMQkdUSWl3S0NMZlJNOEpNRnJ6VnB1QXdBWTZYNm82?=
 =?utf-8?B?VEVQTllyNWdxMTl0L3RiYWtEQmNWNWtPNWpzMXRqQ2t5RzVIc25DWVc5cG8z?=
 =?utf-8?B?c09wUEtKM2s1MmJzaTZOMHdadWc0cnlMaWZIc3RTNStRQ285QkVKZmgwbUZJ?=
 =?utf-8?B?cUJTd0RCTnlKSTVnMjR2aEVmOFpldjNyME8vUWJhTktxZG5mamJUZ2ptNTNM?=
 =?utf-8?B?dnVMV0NLTGZwZG54VFNkOTE3enhqdlpiY0dJb0QxbUlZN1cyb0dESGZtaFRj?=
 =?utf-8?B?OVJzbkFFOHc4UVd6UG9RUE10M21PVExTRzNabTYyVThIUU1KVHFwN296dnJR?=
 =?utf-8?B?OU5zT295OVBtZGdSZ3FNMyswajRydGoyYS84eURZWHJtU2FzUWhXUTE0c2VZ?=
 =?utf-8?B?KzQ5U2ZjM0M1NDRSeURrV1N5dmgxQk1zOUdCS0RnNWdOSERaMWtpaEtCSXFT?=
 =?utf-8?B?OERZMnhGU1RTekdrK0RQRFlTSWdMSG9xTW5kcEhxZlI4ZXVOZHArQXo5L0hL?=
 =?utf-8?B?UEYzZUI4Y2lja2RtdStFQUdUKzNsYy9LU3NQWU1abCs2dms4czhrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15063a42-004e-4374-16ab-08de9a4bc966
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 17:32:22.7092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvR5LuVe0ICvq/bm3Na+rW3Jm4zmYOh6bG4r/qUbxMr8eKJLkt/Ja2cI94oopE8brdnXyue0h8M95x69g2OCOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF946CC24FA
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



On 4/14/26 12:28, Lizhi Hou wrote:
> 
> On 4/14/26 10:17, Mario Limonciello wrote:
>>
>>
>> On 4/14/26 12:16, Lizhi Hou wrote:
>>>
>>> On 4/14/26 09:58, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 4/14/26 11:56, Lizhi Hou wrote:
>>>>> From: Max Zhen <max.zhen@amd.com>
>>>>>
>>>>> Add support for configuring the hardware scheduler time quantum to
>>>>> improve fairness across concurrent contexts.
>>>>>
>>>>> The scheduler enforces a fixed time slice per context, preventing
>>>>> long-running workloads from monopolizing the device and allowing
>>>>> other contexts to make forward progress.
>>>>>
>>>>> The default time quantum is 30ms and can be configured via the
>>>>> time_quantum_ms module parameter.
>>>>
>>>> Can you talk more about how you want to use it?  Adding new module 
>>>> parameters is generally frowned upon in lieu of doing something with 
>>>> debugfs at runtime.
>>>
>>> This is a static setting which is not supposed to change at runtime. 
>>> So module parameter is used.
>>
>> But so what happens if user loads driver with default setting and then 
>> unloads driver and loads with a different setting as module option?
>>
>> Does this flow fall apart because the driver initially programmed 30ms?
> 
> Reloading with new setting will overwrite the default setting. After the 
> module is loaded, it is not supposed to change before unloading the module.
> 

+ Greg

Greg,

How do you feel about a module parameter for this purpose?  Any other 
suggestions if you don't like it?

I was thinking a debugfs file still makes sense, but either the debugfs 
file can do unbind/rebind internally or user using debugfs file can do 
the unbind/bind sequence in sysfs after touching the debugfs file.

Here is full thread in case you don't have:

https://lore.kernel.org/dri-devel/20260414165602.788811-1-lizhi.hou@amd.com/

> 
> Lizhi
> 
>>
>>>
>>> Lizhi
>>>
>>>>
>>>> IE if you can export it as a debugfs file that when you write to it 
>>>> updates the quantum or updates it and restarts the driver this might 
>>>> be more preferable.
>>>>
>>>>>
>>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>>> ---
>>>>>   drivers/accel/amdxdna/aie2_message.c  | 44 ++++++++++++++++++++++ 
>>>>> +++++
>>>>>   drivers/accel/amdxdna/aie2_msg_priv.h | 16 ++++++++++
>>>>>   drivers/accel/amdxdna/aie2_pci.c      | 16 ++++++++++
>>>>>   drivers/accel/amdxdna/aie2_pci.h      |  2 ++
>>>>>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>>>>>   5 files changed, 80 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/ 
>>>>> amdxdna/aie2_message.c
>>>>> index e52dc7ea9fc7..976ad6281078 100644
>>>>> --- a/drivers/accel/amdxdna/aie2_message.c
>>>>> +++ b/drivers/accel/amdxdna/aie2_message.c
>>>>> @@ -1200,3 +1200,47 @@ int aie2_query_app_health(struct 
>>>>> amdxdna_dev_hdl *ndev, u32 context_id,
>>>>>       aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
>>>>>       return ret;
>>>>>   }
>>>>> +
>>>>> +static int
>>>>> +aie2_runtime_update_ctx_prop(struct amdxdna_dev_hdl *ndev,
>>>>> +                 struct amdxdna_hwctx *ctx, u32 type, u32 value)
>>>>> +{
>>>>> +    DECLARE_AIE_MSG(update_property, MSG_OP_UPDATE_PROPERTY);
>>>>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (!AIE_FEATURE_ON(&ndev->aie, AIE2_UPDATE_PROPERTY))
>>>>> +        return -EOPNOTSUPP;
>>>>> +
>>>>> +    if (ctx)
>>>>> +        req.context_id = ctx->fw_ctx_id;
>>>>> +    else
>>>>> +        req.context_id = AIE2_UPDATE_PROPERTY_ALL_CTX;
>>>>> +
>>>>> +    req.time_quota_us = value;
>>>>> +    req.type = type;
>>>>> +
>>>>> +    ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>>>>> +    if (ret) {
>>>>> +        XDNA_ERR(xdna, "%s update property failed, type %d ret %d",
>>>>> +             ctx ? ctx->name : "ctx.all", type, ret);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us)
>>>>> +{
>>>>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = aie2_runtime_update_ctx_prop(ndev, NULL, 
>>>>> UPDATE_PROPERTY_TIME_QUOTA, us);
>>>>> +    if (ret == -EOPNOTSUPP) {
>>>>> +        XDNA_DBG(xdna, "update time quota not support, skipped");
>>>>> +        ret = 0;
>>>>> +    } else if (!ret) {
>>>>> +        XDNA_DBG(xdna, "Ctx exec time quantum updated to %u us", us);
>>>>> +    }
>>>>> +    return ret;
>>>>> +}
>>>>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/ 
>>>>> amdxdna/aie2_msg_priv.h
>>>>> index f18e89a39e35..fc2e99510980 100644
>>>>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>>>>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>>>>> @@ -31,6 +31,7 @@ enum aie2_msg_opcode {
>>>>>       MSG_OP_SET_RUNTIME_CONFIG          = 0x10A,
>>>>>       MSG_OP_GET_RUNTIME_CONFIG          = 0x10B,
>>>>>       MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
>>>>> +    MSG_OP_UPDATE_PROPERTY             = 0x113,
>>>>>       MSG_OP_GET_APP_HEALTH              = 0x114,
>>>>>       MSG_OP_MAX_DRV_OPCODE,
>>>>>       MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
>>>>> @@ -503,4 +504,19 @@ struct get_app_health_resp {
>>>>>       __u32 required_buffer_size;
>>>>>       __u32 reserved[7];
>>>>>   } __packed;
>>>>> +
>>>>> +struct update_property_req {
>>>>> +#define UPDATE_PROPERTY_TIME_QUOTA 0
>>>>> +    __u32 type;
>>>>> +#define AIE2_UPDATE_PROPERTY_ALL_CTX    0xFF
>>>>> +    __u8 context_id;
>>>>> +    __u8 reserved[7];
>>>>> +    __u32 time_quota_us;
>>>>> +    __u32 reserved1;
>>>>> +} __packed;
>>>>> +
>>>>> +struct update_property_resp {
>>>>> +    enum aie2_msg_status status;
>>>>> +} __packed;
>>>>> +
>>>>>   #endif /* _AIE2_MSG_PRIV_H_ */
>>>>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/ 
>>>>> amdxdna/aie2_pci.c
>>>>> index c9c23c889c78..7ed99ea471a9 100644
>>>>> --- a/drivers/accel/amdxdna/aie2_pci.c
>>>>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>>>>> @@ -33,6 +33,11 @@ static int aie2_max_col = XRS_MAX_COL;
>>>>>   module_param(aie2_max_col, uint, 0600);
>>>>>   MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");
>>>>>   +#define MAX_TIME_QUANTUM_MS 2000 /* milliseconds */
>>>>> +static uint time_quantum_ms = 30; /* milliseconds */
>>>>> +module_param(time_quantum_ms, uint, 0400);
>>>>> +MODULE_PARM_DESC(time_quantum_ms, "Execution time quantum. Default 
>>>>> 30 ms, MAX 2000 ms");
>>>>> +
>>>>>   static char *npu_fw[] = {
>>>>>       "npu_7.sbin",
>>>>>       "npu.sbin"
>>>>> @@ -186,6 +191,17 @@ static int aie2_mgmt_fw_init(struct 
>>>>> amdxdna_dev_hdl *ndev)
>>>>>           return ret;
>>>>>       }
>>>>>   +    if (time_quantum_ms > MAX_TIME_QUANTUM_MS) {
>>>>> +        XDNA_ERR(ndev->aie.xdna, "Bad time quantum %u", 
>>>>> time_quantum_ms);
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    ret = aie2_update_prop_time_quota(ndev, time_quantum_ms * 1000);
>>>>> +    if (ret) {
>>>>> +        XDNA_ERR(ndev->aie.xdna, "Failed to update execution time 
>>>>> quantum");
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>>       ret = aie2_xdna_reset(ndev);
>>>>>       if (ret) {
>>>>>           XDNA_ERR(ndev->aie.xdna, "Reset firmware failed");
>>>>> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/ 
>>>>> amdxdna/aie2_pci.h
>>>>> index f83deca2b51a..69b53c7bcb86 100644
>>>>> --- a/drivers/accel/amdxdna/aie2_pci.h
>>>>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>>>>> @@ -222,6 +222,7 @@ enum aie2_fw_feature {
>>>>>       AIE2_PREEMPT,
>>>>>       AIE2_TEMPORAL_ONLY,
>>>>>       AIE2_APP_HEALTH,
>>>>> +    AIE2_UPDATE_PROPERTY,
>>>>>       AIE2_FEATURE_MAX
>>>>>   };
>>>>>   @@ -308,6 +309,7 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, 
>>>>> struct amdxdna_sched_job *job,
>>>>>            int (*notify_cb)(void *, void __iomem *, size_t));
>>>>>   int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct 
>>>>> amdxdna_sched_job *job,
>>>>>                int (*notify_cb)(void *, void __iomem *, size_t));
>>>>> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 
>>>>> us);
>>>>>   void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
>>>>>                   dma_addr_t *dma_addr);
>>>>>   void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
>>>>> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/ 
>>>>> amdxdna/npu4_regs.c
>>>>> index a3b6df56abd0..6ebf75ad5fb4 100644
>>>>> --- a/drivers/accel/amdxdna/npu4_regs.c
>>>>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>>>>> @@ -93,9 +93,10 @@ const struct dpm_clk_freq npu4_dpm_clk_table[] = {
>>>>>     const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
>>>>>       { .major = 6, .min_minor = 12 },
>>>>> -    { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 
>>>>> 6, .min_minor = 15 },
>>>>>       { .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 
>>>>> 12 },
>>>>>       { .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 
>>>>> 6, .min_minor = 12 },
>>>>> +    { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 
>>>>> 6, .min_minor = 15 },
>>>>> +    { .features = BIT_U64(AIE2_UPDATE_PROPERTY), .major = 
>>>>> 6, .min_minor = 15 },
>>>>>       { .features = BIT_U64(AIE2_APP_HEALTH), .major = 
>>>>> 6, .min_minor = 18 },
>>>>>       { .features = AIE2_ALL_FEATURES, .major = 7 },
>>>>>       { 0 }
>>>>
>>

