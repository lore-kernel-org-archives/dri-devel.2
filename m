Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FC6F9D0EB
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4311A10E636;
	Tue, 14 Apr 2026 17:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gahMZqxS";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8219810E636
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqStRHH+g314KuxSyv+CEUuigD6A/US0tYtYjZVbxHgNqvZKq0TWjtCiFu/Vo1q61kKFJKkP40OeBls6usPYrDJL0FaM/R4bOK5/5HbL/2DVzi1x6wcyzlrAgCrQ7Kz+gFaU8Hqneb64hfUlNW0ptbI/nDlagFMF+K3TwsaabARgBy6CAvHk8LY8wXVsVlOqie2MVEJbeTHYEeNeAik/KOhUGGqQlDLvg+OyGwWg12M2C8UvWewNvLTFS+kKz8mrgtQUacouWtXF+VHc3golmaP8bwiIKPZkVyHBWTvR4BXJJZ/xn32RgbA5bSAKvBj8VQ1N0dSCc3tuqZNxilXK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ocf1jdP/ONzNuOg9fIuquPBip2fYeoGLNcZnsBlKUc=;
 b=uTk+v51j05ovM8sDBCk0UppEoCpCJ4qseObPbA71p6ljA2YzCoc7IIcZFQ1/u6Aa5ss9V+CGlDA9QAX1Q4O3sqYT4DoND9p2BcztD9wkx2ydN4Ms4o+OHwvYyoZGp9v4OW8LUS6Dm3N0vcIirR6k2wiHmnqoRXK12FDjy4aYu8fvAPvqvGYhRijjSmqQpMxUyGw/jndnMmW4AlO/IcTTp8ijtO8rHiNfPqP3pUaENXo1fonspHihmjoTaxVwz4Fi7MSUdKZP8krl4DX68FTYkLRBo+C2Kc05gyX5aSHbi1UKA/OgO+z6cudk8fwW9isQuVvUpK8KlTazX+Gi+9XBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ocf1jdP/ONzNuOg9fIuquPBip2fYeoGLNcZnsBlKUc=;
 b=gahMZqxSO3hzvBQnlNUgf+XJLvVmnhBah5/JWT852Iu4dTBsMC+iCHBmr3gtWudZ7VE7ctMug6kNCXRZz878us+k44y7xUTmehCXGXRdx5IFpORAGs+aSL4zOn/Lsse6AKM3oVmyTgqpSSqefV1QQFNB3tQTfa0t98905NEd1qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 17:17:40 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Tue, 14 Apr 2026
 17:17:39 +0000
Message-ID: <d58e78d3-dd94-4dc5-a80c-5f38836c4495@amd.com>
Date: Tue, 14 Apr 2026 12:17:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Add hardware scheduler time quantum
 support
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260414165602.788811-1-lizhi.hou@amd.com>
 <f233b761-ca66-4790-bdba-8407e696006b@amd.com>
 <54e62560-22a8-7f1b-642e-21042fc1f081@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <54e62560-22a8-7f1b-642e-21042fc1f081@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:610:b3::9) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0744ab-fc91-4d4f-1a0c-08de9a49bb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: RuGZehOukCt9+2EYGhfVjkxdwQGpVz6CVUFEuyBl/MRbAPEVqvWnOrfnw7yAkbtLZPC6T3IXtiMoMGWlkCT7A8aGpP1J0aHOccu6qVzhuiw49EVYsL9R1Oc66VnU9B/yWIFAXIs14YSxET3yg1BuPX/87S3CB1J/iJ0pT0yTMVTGTz46vwMTEldFwQm3WKtSJuSOEwGf2GGMewQCLgDOLtVbgAa/JHkizoHAoNvZkvMw51AeL2wxi7pdpST0zoO9FuKZ5DUVt2Bbwo47sl5+9K1LKwcs14KexTKHjV97C3Gm0vrYoX4wUT6fpqxC6P+CnlwQy82XLkO11aM5C1sRgh7urqox6IQ3puaU+3G2a5E534NliuYJxrCs/6FkXY3gBrOi07bjfY5UdbSNPRDvs7umRiaBbvvuRjZzEb+XBpDuhnOAYUAqcRFcmNL0Gn+/POJjT7o2qUtBpK4qdBvltxhxD0Q7vtRsqkrpRM9cJCex37611CDeFKqYj6Uu1uOQLQsKdCScIlFB1zJPMUPHYvtmLc22c+ez0rr9Oc4p7f+mZJZzGVPqlekj33oKw1bIbJDyx+6+rJiVjb1mutQ7MX0DxAkKxF+QNgvvIAR9Dt1n/mXZVa/vtcGn40vmjkPnm20x3XJtkMYSAgmJYcRzEt5yL6gmf2T/9PlYcrqviqCDmTpV+Ve/R2THyv/1ADwJpLe3EphS6d7s6Ji991azGIr/Ne7IFBMx7s+1eaPvkoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm1OZTZSb05wb2tJUkFSeks2em1nTGJjbXY4Ui92dWQzK2tVMzYzSFY3WEp6?=
 =?utf-8?B?MC96WjU3SjBVSmUzMUF1NlRZZzVaaHZFNWxxWG9PSnZVcVYyd1pkRno3cnlF?=
 =?utf-8?B?L1FVZHRBUHV0L1B6ZTZzenhxcHNrb0h4SlYveUN6V0VVdGZCYTBLN0IrSzcv?=
 =?utf-8?B?OHljRWlDR1I5MjRFa005UzlacUs5dU9YbUlrcG9xMDJpcGVwaDJaZkd1NnRR?=
 =?utf-8?B?UmI1cjhHSVgrbGMvQXlIWUVzMU5hZ0Q0MHhHeWpDWSs0UC9HY1lvc0J0alM2?=
 =?utf-8?B?Tk0vL2tJZ1pDZVZ3ZUVGdGNNUldReHBCTFdRQlIxZ1pmYzRtQ1pObHVZYWw3?=
 =?utf-8?B?cEFrZ1B5MWIvVkl3SU1HOWV0MUZOdGxISHh2L1BYQTdZTmpXZlI3WUo1Ykl3?=
 =?utf-8?B?V1VaUEphU0xZMWZFMFJETzJ1cUZ4TnNJNnFyVXg2MjYvZkRQT1dXVG1xcHJ3?=
 =?utf-8?B?UEF6MndUZUhaNGEzTmtHZnVyNEtsT2VPSkdhSFdiSFZja2w2L3g0UFhkNmJV?=
 =?utf-8?B?M0JUQjBrblRIcnZGdGRXY1hsbnhrTVNuQU1tVXMybnJOQjBIWkVyakMzYnhu?=
 =?utf-8?B?K082djY2VzNLYk1ETkdsOEhXWWFHYkdGNXFBQ3F5MlVtNVJlTzFTWVBQYVdU?=
 =?utf-8?B?WWN2UHVkWTBaN3BRVmpJTFBXOG0vdUhKbnBTTUZlUlhSN1MzTk9uYlpDclVt?=
 =?utf-8?B?V2J2ZTAwb1RHM3FTMWttMDVzc3VESC9PRCtEV1dURDZ5TThQTndBUGRZUEZB?=
 =?utf-8?B?aDBneDlsK25WbXR3bDJHaU1IUStndTc4UmtsbnpvQm5OaG15Z2tvMWh0Q21y?=
 =?utf-8?B?aHpyamNydW1MaU95SW9JOEU1VEkyVnJtY2RZTTJhZFJaMTdyZUV6TW9pWHZk?=
 =?utf-8?B?QnRXTzdoTllENWNlNXhKTkhKejVYdVIvemFFTzNNQTgzMEJ4ajZFWVJka0Vo?=
 =?utf-8?B?c2RMYzdBY1JSa3RlY291UWFhemRUUS8xVGJUUVFSaHdqSzAyM3ExZGVSbXV6?=
 =?utf-8?B?NlRDa0hhZDVLR3hQN0dHbzBtYWViQ2UwOW41VmtjZDZ5eHh6VzNoUE5HZmdv?=
 =?utf-8?B?OFZkbU1wazErajlxOXhzamU5SXVOVzJrMC96NE4waE1jQXkzNE84NitmMG12?=
 =?utf-8?B?aWsrQlQ2cXJRTWdYU2x2WTcvd3VYYi81TjZKaWljc3NhVk9ENjFMTnhYUURu?=
 =?utf-8?B?bVNIbDcwSWYrZC9icXYwS2pCNitzS25tb3ZNN213MUJGL3NnNzk2VkFMODFy?=
 =?utf-8?B?NUFRUXRUbzkxVXNPaXRZTHB4KzN4blJxTDFFOUV3MWcwUHNSTkVPMVVTVm1p?=
 =?utf-8?B?TmFZMnNESFBMOHRMZDdkbHRlLzJwVU9Rd0M2anJPWmtrWVR3UlRVeWR1TDdQ?=
 =?utf-8?B?TFcvMzBJenVDajNIYnVyOWQ4N25sSjBMeWZ4NlZja05rc2lQbFlXc3hFSXhI?=
 =?utf-8?B?bTZZUmNobWZWSmlzK0pBMDJWQmNSbVk4MUNudlFMUW1NQ0FXS0VwaUFyMDU0?=
 =?utf-8?B?YVhyVjNkSmpsMCt1QzRockdaUDZWem1OUG5OSDdEWmp3Y1ZnYlh5NS85V1gv?=
 =?utf-8?B?c1BmTlY3SHZvQkh1YjFqakVUc2RIdHFUdmIwT3RrTHpPRVFkK2VtSTNFT1Ft?=
 =?utf-8?B?Slhzd29KKy9nU25HM2IyTERrcXZyM0Y1dmZRMUlSOE9hRnowUDJPLzVWaXdz?=
 =?utf-8?B?VllHNnh5N1NyS1QvemVhaXBjRUxkVVZGY0lGeUV5ZGQ2eXA0N1pjUGtXS0I2?=
 =?utf-8?B?MjNqYkp3S0R2RWlVcHp1YXVzcDZ5bUh6V09zcEZyT1ZqN2xBc0xpbFRwWll0?=
 =?utf-8?B?Vkp2RDQ4NTlOZkc5dGRnTWlEcVZHWEN3U3BMaWpWbXhpTVNMRHU2Rld5V2tQ?=
 =?utf-8?B?Sm93WEw1YzQ0Y2FZSTUyOHh5M21PRnVsYkFlcC9IV0F4MjJBU2t4dWtCMnJo?=
 =?utf-8?B?bXRrV0tsYlpQbmVXRGllNEtIZTgvRmpQMjhnTkoxTnZNbkRmWmRGcU5jU0wr?=
 =?utf-8?B?alZ2T3NEQzZhYisxdm1zSHdNbUd2aGRyUWxpdVJqOExXRDZoUHRkdGYySVM5?=
 =?utf-8?B?TFZwMUFHWFRRL3NFMVpseCtUdUFvbDJuNnJHcVAwbnZUQlBUM3JxQTl1cjhX?=
 =?utf-8?B?MjBLNU9CSWtRTC9BN3NrZUZ2RUVlMWFwcFJmdU9NdFl5Y25oaTdIWm9sSmxo?=
 =?utf-8?B?Vm0wR0lGV1ZvZnRhMnV0MDhLSUdQNXlveDZZMFhISVluL2M5ZndET0wzbVlr?=
 =?utf-8?B?cldMa25sbXFYTUZPblhnVmRLQWZ0Tk5BdWhoWVVGcThNSldmYjhBbUljdk5N?=
 =?utf-8?B?czgxZTJ2eUZrV3MzYVcwMzFtVXRpTE9HVHIxQVZMWE9Ock5CNk5jZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0744ab-fc91-4d4f-1a0c-08de9a49bb1e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 17:17:39.8311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lKg2xg6JY2L//my1OB/ZD+Gw6MMSzDMxFpBFuVLAHmIOV37nIwbq1s5Yqc9BJ0/7gag6S54rMiotlFkFD9fdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771
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



On 4/14/26 12:16, Lizhi Hou wrote:
> 
> On 4/14/26 09:58, Mario Limonciello wrote:
>>
>>
>> On 4/14/26 11:56, Lizhi Hou wrote:
>>> From: Max Zhen <max.zhen@amd.com>
>>>
>>> Add support for configuring the hardware scheduler time quantum to
>>> improve fairness across concurrent contexts.
>>>
>>> The scheduler enforces a fixed time slice per context, preventing
>>> long-running workloads from monopolizing the device and allowing
>>> other contexts to make forward progress.
>>>
>>> The default time quantum is 30ms and can be configured via the
>>> time_quantum_ms module parameter.
>>
>> Can you talk more about how you want to use it?  Adding new module 
>> parameters is generally frowned upon in lieu of doing something with 
>> debugfs at runtime.
> 
> This is a static setting which is not supposed to change at runtime. So 
> module parameter is used.

But so what happens if user loads driver with default setting and then 
unloads driver and loads with a different setting as module option?

Does this flow fall apart because the driver initially programmed 30ms?

> 
> Lizhi
> 
>>
>> IE if you can export it as a debugfs file that when you write to it 
>> updates the quantum or updates it and restarts the driver this might 
>> be more preferable.
>>
>>>
>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/accel/amdxdna/aie2_message.c  | 44 +++++++++++++++++++++++++++
>>>   drivers/accel/amdxdna/aie2_msg_priv.h | 16 ++++++++++
>>>   drivers/accel/amdxdna/aie2_pci.c      | 16 ++++++++++
>>>   drivers/accel/amdxdna/aie2_pci.h      |  2 ++
>>>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>>>   5 files changed, 80 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/ 
>>> amdxdna/aie2_message.c
>>> index e52dc7ea9fc7..976ad6281078 100644
>>> --- a/drivers/accel/amdxdna/aie2_message.c
>>> +++ b/drivers/accel/amdxdna/aie2_message.c
>>> @@ -1200,3 +1200,47 @@ int aie2_query_app_health(struct 
>>> amdxdna_dev_hdl *ndev, u32 context_id,
>>>       aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
>>>       return ret;
>>>   }
>>> +
>>> +static int
>>> +aie2_runtime_update_ctx_prop(struct amdxdna_dev_hdl *ndev,
>>> +                 struct amdxdna_hwctx *ctx, u32 type, u32 value)
>>> +{
>>> +    DECLARE_AIE_MSG(update_property, MSG_OP_UPDATE_PROPERTY);
>>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>> +    int ret;
>>> +
>>> +    if (!AIE_FEATURE_ON(&ndev->aie, AIE2_UPDATE_PROPERTY))
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    if (ctx)
>>> +        req.context_id = ctx->fw_ctx_id;
>>> +    else
>>> +        req.context_id = AIE2_UPDATE_PROPERTY_ALL_CTX;
>>> +
>>> +    req.time_quota_us = value;
>>> +    req.type = type;
>>> +
>>> +    ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>>> +    if (ret) {
>>> +        XDNA_ERR(xdna, "%s update property failed, type %d ret %d",
>>> +             ctx ? ctx->name : "ctx.all", type, ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us)
>>> +{
>>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>> +    int ret;
>>> +
>>> +    ret = aie2_runtime_update_ctx_prop(ndev, NULL, 
>>> UPDATE_PROPERTY_TIME_QUOTA, us);
>>> +    if (ret == -EOPNOTSUPP) {
>>> +        XDNA_DBG(xdna, "update time quota not support, skipped");
>>> +        ret = 0;
>>> +    } else if (!ret) {
>>> +        XDNA_DBG(xdna, "Ctx exec time quantum updated to %u us", us);
>>> +    }
>>> +    return ret;
>>> +}
>>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/ 
>>> amdxdna/aie2_msg_priv.h
>>> index f18e89a39e35..fc2e99510980 100644
>>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>>> @@ -31,6 +31,7 @@ enum aie2_msg_opcode {
>>>       MSG_OP_SET_RUNTIME_CONFIG          = 0x10A,
>>>       MSG_OP_GET_RUNTIME_CONFIG          = 0x10B,
>>>       MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
>>> +    MSG_OP_UPDATE_PROPERTY             = 0x113,
>>>       MSG_OP_GET_APP_HEALTH              = 0x114,
>>>       MSG_OP_MAX_DRV_OPCODE,
>>>       MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
>>> @@ -503,4 +504,19 @@ struct get_app_health_resp {
>>>       __u32 required_buffer_size;
>>>       __u32 reserved[7];
>>>   } __packed;
>>> +
>>> +struct update_property_req {
>>> +#define UPDATE_PROPERTY_TIME_QUOTA 0
>>> +    __u32 type;
>>> +#define AIE2_UPDATE_PROPERTY_ALL_CTX    0xFF
>>> +    __u8 context_id;
>>> +    __u8 reserved[7];
>>> +    __u32 time_quota_us;
>>> +    __u32 reserved1;
>>> +} __packed;
>>> +
>>> +struct update_property_resp {
>>> +    enum aie2_msg_status status;
>>> +} __packed;
>>> +
>>>   #endif /* _AIE2_MSG_PRIV_H_ */
>>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/ 
>>> amdxdna/aie2_pci.c
>>> index c9c23c889c78..7ed99ea471a9 100644
>>> --- a/drivers/accel/amdxdna/aie2_pci.c
>>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>>> @@ -33,6 +33,11 @@ static int aie2_max_col = XRS_MAX_COL;
>>>   module_param(aie2_max_col, uint, 0600);
>>>   MODULE_PARM_DESC(aie2_max_col, "Maximum column could be used");
>>>   +#define MAX_TIME_QUANTUM_MS 2000 /* milliseconds */
>>> +static uint time_quantum_ms = 30; /* milliseconds */
>>> +module_param(time_quantum_ms, uint, 0400);
>>> +MODULE_PARM_DESC(time_quantum_ms, "Execution time quantum. Default 
>>> 30 ms, MAX 2000 ms");
>>> +
>>>   static char *npu_fw[] = {
>>>       "npu_7.sbin",
>>>       "npu.sbin"
>>> @@ -186,6 +191,17 @@ static int aie2_mgmt_fw_init(struct 
>>> amdxdna_dev_hdl *ndev)
>>>           return ret;
>>>       }
>>>   +    if (time_quantum_ms > MAX_TIME_QUANTUM_MS) {
>>> +        XDNA_ERR(ndev->aie.xdna, "Bad time quantum %u", 
>>> time_quantum_ms);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    ret = aie2_update_prop_time_quota(ndev, time_quantum_ms * 1000);
>>> +    if (ret) {
>>> +        XDNA_ERR(ndev->aie.xdna, "Failed to update execution time 
>>> quantum");
>>> +        return ret;
>>> +    }
>>> +
>>>       ret = aie2_xdna_reset(ndev);
>>>       if (ret) {
>>>           XDNA_ERR(ndev->aie.xdna, "Reset firmware failed");
>>> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/ 
>>> amdxdna/aie2_pci.h
>>> index f83deca2b51a..69b53c7bcb86 100644
>>> --- a/drivers/accel/amdxdna/aie2_pci.h
>>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>>> @@ -222,6 +222,7 @@ enum aie2_fw_feature {
>>>       AIE2_PREEMPT,
>>>       AIE2_TEMPORAL_ONLY,
>>>       AIE2_APP_HEALTH,
>>> +    AIE2_UPDATE_PROPERTY,
>>>       AIE2_FEATURE_MAX
>>>   };
>>>   @@ -308,6 +309,7 @@ int aie2_sync_bo(struct amdxdna_hwctx *hwctx, 
>>> struct amdxdna_sched_job *job,
>>>            int (*notify_cb)(void *, void __iomem *, size_t));
>>>   int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct 
>>> amdxdna_sched_job *job,
>>>                int (*notify_cb)(void *, void __iomem *, size_t));
>>> +int aie2_update_prop_time_quota(struct amdxdna_dev_hdl *ndev, u32 us);
>>>   void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
>>>                   dma_addr_t *dma_addr);
>>>   void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
>>> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/ 
>>> amdxdna/npu4_regs.c
>>> index a3b6df56abd0..6ebf75ad5fb4 100644
>>> --- a/drivers/accel/amdxdna/npu4_regs.c
>>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>>> @@ -93,9 +93,10 @@ const struct dpm_clk_freq npu4_dpm_clk_table[] = {
>>>     const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
>>>       { .major = 6, .min_minor = 12 },
>>> -    { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor 
>>> = 15 },
>>>       { .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 
>>> 12 },
>>>       { .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 
>>> 6, .min_minor = 12 },
>>> +    { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor 
>>> = 15 },
>>> +    { .features = BIT_U64(AIE2_UPDATE_PROPERTY), .major = 
>>> 6, .min_minor = 15 },
>>>       { .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor 
>>> = 18 },
>>>       { .features = AIE2_ALL_FEATURES, .major = 7 },
>>>       { 0 }
>>

