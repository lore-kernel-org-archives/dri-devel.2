Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B411AFF887E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 02:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8DD10E033;
	Thu, 30 Apr 2026 02:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E5XiTwvq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9BC10E084;
 Thu, 30 Apr 2026 02:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXKOYtFsy+TcDEAIWBbwbA0zsMh1D1JhhSYUGS7SC3FCECkVtC07eJgBQ23KSOOEuYVLdTZnSpA+PHj733PHMVDJkEBVOrSFv944/8yYO7LnzZTFOFoDAv8H6BaCv40J5ETdFDdHNv+hj79sPAkHF+z7eoPZNRNyU4xBG9FanFFiZMT5TJxU+xGVZDD0ZAaDLutqMb3tuXn5T7uwTp3pJGufRjUnXzN7cF5cP3qwM9OojZr4ZsxsovMMdXwvs+TkaE6stVaH2x8JCVgBN+nM6R/qDGRuII1UL8ajyAC5ZQhrd9n21h9eopgdHSuxNaPxsP6knrocf5Olmx51zl51kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nw7adUFgzFwMSS/qdKdC4XmySbM5Uyz5pqcydjRpyQ=;
 b=WHi4RCkFAiL/d2C7T89o7iattbqsE15onX4ot9msQF+StbSvrJ2GKuvoqBuXJDhfa22rdi2z9gCYBxuEBnTbBh2cLeTQzB5jxmvDiUuOtO5lHy7WeuDqIUEr8gNsTTZP9MkakQ+X6pkKnUPUMwPvMs8RuN9+C/ZrfnhlH9TxdKreS+FskXPRAHLg7HZSsvTjmMiwgnqR+8XXgLuQDiu5NiCBy/dKnqqXZ01gDYNBC8R5RPrCfG+Yuo1ms0dRMS/BLYfDAbCTROEMggfR925TctSK53AsiEWEsmEgX1/k8+f6qiMhIgT7zEzpBAuGgRcg8NA+WMW9r7pbXF2cNwSglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nw7adUFgzFwMSS/qdKdC4XmySbM5Uyz5pqcydjRpyQ=;
 b=E5XiTwvqOE6QL6fnSoRmO4GxuQh5Ih+kUk5DSxc1hbQJuiSdjNkZWlr9Jvde1ji4TRtwJByQYVOMOkZni1HICSkUXYRDVstS5P3o5u6OSnHsAYoTmjS2wRBaR7cAocpRgoUVXF0yaEVK5BZt0D1hxXXlGFFiuJ2NSB2yqoPHv5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 02:56:53 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:56:52 +0000
Message-ID: <02ded343-38bd-4621-83fd-78a027eb96e2@amd.com>
Date: Thu, 30 Apr 2026 10:56:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
From: "Huang, Honglei1" <honghuan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zeng, Oak"
 <Oak.Zeng@amd.com>, "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Zhu, Lingshan" <Lingshan.Zhu@amd.com>, "Shen, Junhua"
 <Junhua.Shen@amd.com>, yiru.ma@amd.com, "sima@ffwll.ch" <sima@ffwll.ch>,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "dakr@kernel.org" <dakr@kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
 <e21e8e1a-4d2e-40e9-bbb7-2764cf33e760@amd.com>
 <ae5fe946-4756-43b4-848f-3b545ac61ba7@amd.com>
 <abuE0KBPtAZM9Bo0@lstrano-desk.jf.intel.com>
 <098d5d68-f218-4cee-8b73-201e7012a287@amd.com>
 <acDeRhCTh/ehOUyu@lstrano-desk.jf.intel.com>
 <a9d979e7-6ff1-47c5-87c5-b905e5c84ded@amd.com>
 <aenBy61U66DkSZUl@gsse-cloud1.jf.intel.com>
 <7a1ba278-1201-4585-b35b-3fb2cec6035f@amd.com>
 <5e44f013-a1c1-4621-9eea-e4f2459f223e@amd.com>
Content-Language: en-US
In-Reply-To: <5e44f013-a1c1-4621-9eea-e4f2459f223e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 92395980-47c0-4eb4-6c72-08dea66421c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: WY3vTYxrsK5s8BEWJCJTAaLhY4w2PrYJc+e9UWYWutHajouz/VKs3loxmlyQ+vZ02a0DVXDuN7ftvmNMucGLaYt11MdMmxx1Aqx/CEQicEOBmYNEBr39+XD30v5Y0ld/lqiRcyZ84FxH5TTBI+jQ+usPY1DqS+AaOrO0ExuudgtRMgAlOPSUYt6JSj3aSebgk1zPPcR+JCwc01wqo2P3zO9o/nxlCYvp/2BVatYXO1Fy6lxP4gGmVaJP/zbdl/nYrOVToEkRZ8vU3eF+npbgC675fr4iXUV+RPEuAUByiPsoKyq9Lr9Gf0UUo2Vbrwj67KHLPI2bX/7uoZ2pbjougENn2VrDz0gfVz/JBqeaH4k66ENT6RjALsXCs0anaklugKzQYEGEi0PdrPDL6HUMfkkXSBmFUu1xdnsm1oUpKgVBAUzmHUyqnP37jQ7otAVLE30Y+Mk05ZQ4bCPZCnwcfJO5aO88Ai0GkZ+uMWM2Z1y3g/8Mm4C/vONnGX3MP2sfv2/DxYkjK2ip9PpRVKdmiGxtuemNlZOAgF4VVwDn/HrPdCLrY3NPY134aLsVDKTsdCzc5Sd7TJyjAHgjSPOk/6klwbzWGOqXLAiSkkhmX+wRyScAcGPhJeXLB4TXYRca4J6Veh5tR7B11l6FR9nvrEu4cnw5UFJt5umW3ogbeEtWu1sRFxi7dMLGfPJukMOdiCCcQ/JviITvrrnTN2o2bWZLm2LkRAa+WCZMSXp4nxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhSd1FaN0ZuWmpGc3c2QlZYdmd5Y2JITnllOHVzRld5cU5IZG1VSDNjRlh0?=
 =?utf-8?B?Mk4yU0t3K3YxMkNiMHZldlBpVkRtcTFUbmd6dGM2eHdVM1JENlJIM2ZtTnVB?=
 =?utf-8?B?cCs3UzM0Q2UraVpTMEQxTWRwQzF3VW5xck5mNGtqSmRRblQvTnFmNXkwT0RD?=
 =?utf-8?B?ZjlXeTBNRDhIcWZTdm5YQ25qNFVCQm9SSWIwck1Ma1VDcmNyWUV0NlpoelNq?=
 =?utf-8?B?NWdXb1p3L3lodkhGNDNsWEdLRit5VzJid29URStad281dEF4aUVJZWg0ZnA2?=
 =?utf-8?B?alFuRVhveXNtV3FsSW16RFpnbHVvaGdBaFdaUDEwcGJma3B0Rk1KZHRIR2dv?=
 =?utf-8?B?ZVUxRHRrNmdxeW8rTVh4Y3Rpb2xsVUt5ZFY2QmEzRVdnekhVbElzb2pTSWVO?=
 =?utf-8?B?am4rUS9qMWFzSmplWnNtZk85aGhGWW42QVN5SDhiR3FXcXZCblJDakV2R29u?=
 =?utf-8?B?SmxtaFlmYi9wSXdTRUh5UG1mSWtqWUZuczdReXhrU0JLUWl2VFFvbTlScklz?=
 =?utf-8?B?RnlGNitYaVpsL1NvOUFzb1B2THhDMFQ1ZlpMZ3pyR2xPRTRqVytUb2pEWXQy?=
 =?utf-8?B?cVM5bis0alFKLytwR2V1UXZnNC9TOWViVEVNbVRjV0F2Q1JoNitqcXJDcTQr?=
 =?utf-8?B?QWgrQkJrQ2Z4OUVDdk1qdjZ4MklveGdCYzlWRkd1S1FWWENaMFdHeTBGeGFr?=
 =?utf-8?B?MTlUNTVueHFyVVc1L0t0em00a2hIQytGcGdWeXJoQjA0QjZBeE42NmtkL2JY?=
 =?utf-8?B?b296K0N5cU1VNW5zN1pNc2MzK1ZEVXVvYTlXZytET1c4Vm9kUFQ1ai9JTk1P?=
 =?utf-8?B?TGRoSjRnWlhLeUczcE9BVEQ3OWJXVTNaWmticDFDNzByZ3h0Ulp2K0RzNXRX?=
 =?utf-8?B?emdobEV6WWFUcFFEbllOLzhlK2NnQmFkWDJ6UDY5dklRMkZ1eUlVVWZMWnc4?=
 =?utf-8?B?STNpZ0FpdEJsNTZQZ2l6SUNBUSs2S3B6ZVJHK2VvbEUvby9IMVpBYTF6T0F5?=
 =?utf-8?B?Sy9SaWhZdHZZdzVaSFV4bE9oVDRBL3lndEc1T211UlNybHZTV28vNDZBckZr?=
 =?utf-8?B?a2hYWnZBeHVveURjK1g3OWtVdUNLMmxYcUhhZEhBQ01sZ29ZQTNUVW5nREkz?=
 =?utf-8?B?dnRlVzFNckFWeUVZV1Vsem1va2tRZFpqc3J6SHVmNkx6MkZHclV6cEgrSGNX?=
 =?utf-8?B?WVRMRVpkaGtHM1UrbkhLMFo1SElxNWJJTWpHQ3E5WTBKNUUrNUYwTnJHblBK?=
 =?utf-8?B?MVNFcndaUXRQdE1MaTFjVE03NFBqOVhldTVUUE1jZHZWTm1pdHlZWjNDS1N6?=
 =?utf-8?B?K2lPQ05RNk5ScVpDc2YweWkxL2dwcnlDOG9sdlVYTUNOZ2M2WCtEbk9HTDRB?=
 =?utf-8?B?UG4xQ0tPZXg3SGU1eTRUVVAyNWZ3Mlc5VmVySm5NeXVSZjIrZlVMVE56TTlI?=
 =?utf-8?B?MWhMN3Flb0xYWi9VWWdPM0J0NDh3UnhFWitEV3diVXRBRTBrVlo3b2tsL0lx?=
 =?utf-8?B?SEEya0o0MTE2NDMxSHR4U0tkRGliZmlMeENGS2RqSEhsRENlSXB4eDN2QUJM?=
 =?utf-8?B?TUEzbDdJQXNaZG8xeTVKcFU3MEpiaWVEdHIzNFlzOHc2Z1hmcjRrV1hjTWha?=
 =?utf-8?B?UjBmWlV0b2QzZ1NITVBpNTlUdjBYY3FWMkUxZEU5bXB1cVE2Ny9hc0tMTURU?=
 =?utf-8?B?dE1rK1djMGExU1NXa0F5OG41dTgrbTlRUzlLWEJrUGRUbTJMblhVSE53WW1v?=
 =?utf-8?B?YVkzWUlSNXFkVStvTWlXZnkrMlRqaGt6QkgrSXpMa0d0Z1RFWkMzZ1pyYXFV?=
 =?utf-8?B?aWNYVGxMT1d4dVNQRlhQa2NnZHc5OG5HQ0w5b1F2bCt6RG1KbmdpMXZFOVNL?=
 =?utf-8?B?V1FoNUZ0VW10T09xUUJHeUFMMUFnL2FranAwMUptNFAwWStIdHhwOCt4aDZF?=
 =?utf-8?B?YWtvc0xPaGIxQ3pjU0ZEanU2ajhZdFZxaXVjZnpuRFR1dTNqeXJxb29KTlJD?=
 =?utf-8?B?OTdyemMvNE5jOWlKdE1SbUVEdmFWY1RTZHQ3elJuLzRwNENrN1E1UjVkdDRM?=
 =?utf-8?B?djRxWURIRC8xK0Z2WkxQVG9jY3RxRURGQW91R2lodmdJSzVhSEF0MWIvSm1l?=
 =?utf-8?B?S0dvbThFcmZEUll5RWp0V0p3OGk1NXVEdG56NGwzbW1vS1RUeUloc2tMS2My?=
 =?utf-8?B?S3R6SE1QUEV2b2tMUDVtU2xJYm1qMngvWUViL2RsK2JkK1dUWHIrQ1IyK3hW?=
 =?utf-8?B?ajRIRUdab0pvdUYwL2VUbUNCVGUyei9CdWJTTGZpT3Q4OThKdVM2TTlVa2gz?=
 =?utf-8?B?WjNUc1YyTE40ZVV0akFsTGNjRlRhYkdUYlNZcmIrM1l2NFdTM2JQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92395980-47c0-4eb4-6c72-08dea66421c4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:56:52.8061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzXBaHpzWyhkdsCsp1bfzqzuRYbqnWJQRiWzXX/BKiN/B4ngGA/nnfpsXHyNRJZWbprBZE/mJmcb13LmbJbOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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



On 4/29/2026 5:56 PM, Huang, Honglei1 wrote:
> 
> 
> On 4/23/2026 4:22 PM, Huang, Honglei1 wrote:
> ...
>>>>>>>>>>
>>>>>>>>>> This patch series implements basic SVM support with the 
>>>>>>>>>> following features:
>>>>>>>>>>
>>>>>>>>>>       1. attributes sepatarated from physical page management:
>>>>>>>>>>
>>>>>>>>>>         - Attribute layer (amdgpu_svm_attr_tree): a driver 
>>>>>>>>>> side interval
>>>>>>>>>>           tree that stores SVM attributes. Managed through the 
>>>>>>>>>> SET_ATTR,
>>>>>>>>>>           and mmu notifier callback.
>>>>>>>
>>>>>>> Can you explain the mmu notifier callback interaction here? See 
>>>>>>> below in
>>>>>>> Xe the attribute tree is existing VMA tree (gpuvm).
>>>>>>>
>>>>>>
>>>>>> Let me try to explain, apologies if the description is not fully
>>>>>> precise.
>>>>>>
>>>>>> In current implementation, the MMU notifier callback interacts 
>>>>>> with the attr
>>>>>> tree only in the munmap path remove the corresponding attribute
>>>>>> entries from the attr tree so that stale attributes do not persist 
>>>>>> for
>>>>>> freed address space.
>>>>>>
>>>>>
>>>>> Ah, yes. We reset our attributes upon munmap too. We actually don't 
>>>>> this
>>>>> 100% correct quite either and series in flight to fix [1].
>>>>>
>>>>> [1] https://patchwork.freedesktop.org/series/161815/
>>>>
>>>> Hi matt,
>>>>
>>>> It seems like you are tring to modify the implementation into remove 
>>>> the
>>>> attributes when munmap.
>>>>
>>>> Actuall we have a discussion internally that does the driver need to 
>>>> remove
>>>> the attributes when munmap.
>>>>
>>>> So there servel ideas:
>>>>
>>>> 1. attribute need keep: attributes may be needed again when a new VMA
>>>> appears or on subsequent faults.
>>>> 2.attribute need keep: attributes can be set independent of whether 
>>>> memory
>>>> is currently mapped; attributes persist and are modified explicitly via
>>>> ioctl, not implicitly by notifier callbacks.
>>>> 3. attribute need remove: casue VMA is gone, driver can do nothing 
>>>> without
>>>> VMA.
>>>>
>>>> and I saw xe_svm set default attribute in the previous version, this 
>>>> is also
>>>> a option.
>>>>
>>>> Can you please help to give some information that why xe_svm is 
>>>> turing to
>>>> remove the attribute when munmap? And does keeping attribute is a 
>>>> valid way?
>>>>
>>>
>>> This is a semantic choice, and we’re trying to match the semantics of
>>> CPU madvise. I believe any semantic an individual driver stack wants to
>>> define is valid, but if vendors mismatch sematics this will create a
>>> level of vendor lock in which may (cough Nvidia, CUDA) or may not (open
>>> source) be desired.
>>>
>>> AFAIK, if you do something like this in C (a CPU-only program):
>>>
>>> mmap(addr_range);
>>> madvise(addr_range, some_flags);
>>> munmap(addr_range);
>>>
>>> mmap(addr_range); /* Here the madvise attributes are reset */
>>>
>>> Also, AFAIK, the CUDA GPU madvise API works this way as well.
>>>
>>> That said, making this work 100% reliably is quite difficult, especially
>>> with a rude user.
>>>
>>> For example:
>>>
>>> mmap(addr_range);
>>> gpu_madvise(addr_range, some_flags);
>>> /* GPU never actually touches memory */
>>> munmap(addr_range);
>>>
>>> So we have an opt-in VM bind flag,
>>> DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET, which we’re working on to mostly
>>> handle the “rude” case above. Maybe we can reach 100% correctness, but
>>> again, this is a difficult problem is WIP.
>>>
>>
>> I think the current amdgpu SVM draft version also has the issue for 
>> the rude user situlation. Maybe this is caused by the separation of 
>> attribute layer and physical layer. Seems like KFD_SVM doesn't have 
>> this issue.
>>
>> Maybe driver can find_or_insert in madvise ioctl path, to add a MMU 
>> notifier but do not to get_page, and then clean the attribyte in mmu 
>> notifier callback instead of GC. This is just my thought.
>>
>> And really thanks for the information, and waiting for other's comments.
>>
> 
> Hi Matt,
> 
> I'd like to share a concrete bug we hit in the amdgpu SVM 
> implementation/tests about stale attributes.
> 
> In short it is stale attr_range overlaps with VM_PFNMAP VMA
> 
> 1: User allocates memory and sets GPU attributes but never use/fault it.
> 
>     CPU VMA (anonymous):
>     |<── 0x1000 ── 0x5000 ──>|
> 
>     attr_range:
>     |<── 0x1000 ── 0x5000 ──>|
> 
> 2: User munmaps the region, attr_range is NOT cleaned up
> 
>     CPU VMA: (gone)
> 
>     attr_range:           stale
>     |<── 0x1000 ── 0x5000  ─>|
> 
>     No gpusvm_range existed, No MMU notifier, No GC, No cleanup
> 
> 
> 3: User mmaps new memory for device pfn remap  partially overlapping the 
> old range,
> and new memory for GPU set attribute
> 
> 
>     CPU VMAs:
>     |<── 0x1000 ── 0x2000 ──>|<── 0x2000 ── 0x4000 ──>|
>     |   VM_PFNMAP                  |   anonymous (new alloc)      |
> 
>     attr_range:              STILL STALE
>     |<────── 0x1000 ─── 0x5000 ─────────────>|
> 
> 
> 4: GPU faults at address 0x3000
> 
>     Fault handler finds the stale attr_range [0x1000, 0x5000):
>       gpuva_start = 0x1000  (from stale attr_range)
>       gpuva_end   = 0x5000  (from stale attr_range)
> 
>     drm_gpusvm_range_chunk_size()  find the  chunk: 0x0000-0x5000 cover 
> the VM_PFNMAP area
> 
>     |<── 0x1000 ── 0x2000 ──>|<── 0x2000 ──── 0x4000 ───>|
>     |   VM_PFNMAP                  |                                    |
>      hmm_range_fault fails
>      or vma check:
>      VM_PFNMAP -> -EOPNOTSUPP
> 
> I think it is caused by of the stale attribute.
> Or is this considered as an invalid userspace behavior?

Hi all,

After internal discussion, I'd like to summary some conclusions from team.

It is decided that default behavior will be to keep attributes on munmap 
for behavioral consistency, advantages of explicit interfaces, safety 
and extensibility.
And provide an opt-in flag similar to Xe's 
DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET.

There is a concern about behavioral consistency from Felix. In 
userspace, whether free() actually triggers a munmap is outside the 
user's control, the C library allocator may retain pages internally 
rather than returning them to the OS. As It is said: "when you call 
malloc and then free, that doesn't necessarily result in unmapping the 
pages it may result in unmapping pages if you are freeing something big 
that was allocated with mmap under the hood, but it may also just stick 
around. From a user's point of view who just uses malloc/free and sets 
some attributes, they have no way of knowing whether their attributes 
will stick or not. I think if the attributes always stick, that would 
give you a more consistent behavior."

And it is from Christian that explicit interfaces are better than 
implicit ones auto-removing attributes on munmap is an implicit kernel 
reaction that users may not even be aware of. As it is said: "Explicit 
interfaces which say 'hey kernel, do something' are usually better than 
implicit interfaces where the kernel is doing something on its own and 
we are just reacting to it." And it is also noted that we can always add 
a flag for auto-removal later if needed, but the reverse would be a UAPI 
breaking change.

Based on the above, the next steps are:

1. Change the logic to keep the attribute as default in current 
implementation.
2. Maybe need adding a new ioctl op to explicitly delete attribute? 
Currently the UAPI can only overwrite attributes to not to map/default 
but not truly remove them.
3. Add a new UAPI flag similar to DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET.
4. For the auto reset path, need to address the "never-faulted" issue.
     Maybe we can register a lightweight MMU notifier at madvise ioctl 
time to observe munmap and clean up attr_range, even if the GPU never 
touches the range.

Please correct me if I'm wrong on any of the above assumptions. Would be 
interested to hear thoughts on this direction.

Regards,
Honglei

> Regards,
> Honglei
> 
>> Regards,
>> Honglei
>>
>>
>>> Matt
>>>
>>>>
>>>> Regards,
>>>> Honglei...

