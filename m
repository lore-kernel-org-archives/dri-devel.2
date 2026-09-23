Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A969C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C850D10EF68;
	Wed, 23 Sep 2026 14:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dIpJtubC";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE1510E8FD;
 Wed, 23 Sep 2026 14:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZW6PtCYvGsd35yY6mX2kCyvbw6pSPHsc/Qk/p/pNFeJVnjvFqVOJlYRTkfTUMTZk0Viil/uQZIVv1f2QHO9AQvBRJgdoBvxA6PlNXs8X4Vqu48uvAN9rZCQ1KCEEMbtoTaOG4PKVKRUYuRC5EkQMNPtPFiI4Ht+P0wFMHEwdR++AoRB/LqeSuiTJsn5DnKsski4h24aQYX993BIaU7YhDJIFOesJ0lbzl+rN5B3l5QprHm7tinc/YoLQX1alj0BesVMjngoTyNh0oG4kkFGjvQPH+VKOHKOuTgDHmRro/ZRjjo55ROzAh4ngQAcpXCVcg5ERc3eMofkG+dg6OKerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmGy7ip0/alvIQtD509sdDQW28Zdc5u8ftmiEMs73/Q=;
 b=mx0SZEy9GQk54DitYCP2pK4oAigMIgUQa1RBmDyvceZkBcxa/aWJP8Ra+iFKuwYGYN0lWX0oOqcXmpsB9h1nRYUwNGeZCGMKe4w6Tqjjro0Hs9ZZZ7zlaAJlg7QDX3J/rB7Wn9ZDLVezR3kNuqaeDRRzp9waK2CG7e18XNHPqw0UNQm8xfFlzzZgI6cEmdhvKMgfcn0CeSORENN+blt/fKZ6G/2lVOT5mn3Nq7m6av7YEvzwyqXOQwEttKpzGr4bNs9zkeObkuFjzaKx8Kq249DqASy/X/63Bu8jEjX7CY4Iil7wtGplFW1+btxCAR8fwq1ffB+t5ALQdM46ljRzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmGy7ip0/alvIQtD509sdDQW28Zdc5u8ftmiEMs73/Q=;
 b=dIpJtubCVsV9/+F34WArWCFyxgJb/k/Fq4KNRtPEipvaeJQ/CmU8bxcT9292YFeK0QJN3MA/K6ogT3EyJTx7wrXkoSQWBNMqbUkkc0FiggTMgg/CLcDG6a1krPtFyg5+2GGkPP0/eK1Fe8C1wZf65+cNyDIJFrbJdhWYmMEwJfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 14:52:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:52:00 +0000
Message-ID: <911fab90-0e42-4dbd-972b-f0e5afbec2e3@amd.com>
Date: Wed, 23 Sep 2026 16:51:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: don't free mapping when
 amdgpu_vm_update_range fails
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Natalie Vock <nat@pixelcluster.dev>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 kernel-dev@igalia.com
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
 <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
 <9c507259-f65c-4f18-8fc7-8e03de0c4f87@amd.com>
 <acc1e3eb-264c-4591-9f66-5fe93b96f97f@pixelcluster.dev>
 <aqkf0LE51mObdEJc@quatroqueijos.cascardo.eti.br>
 <fb733813-9e4d-494a-ba60-469261340e74@amd.com>
 <aqktL4Ui1MaIvs_j@quatroqueijos.cascardo.eti.br>
 <a59d3421-a241-4497-9890-0b94329b94da@amd.com>
 <arPakAXXW1TdfF0Z@quatroqueijos.cascardo.eti.br>
 <f4c3bdb7-3b6e-49f1-9baf-36ab069faac0@amd.com>
 <arPfyosqiB-uzL-e@quatroqueijos.cascardo.eti.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <arPfyosqiB-uzL-e@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af7064a-a261-49bb-3cc4-08df198238ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: KSNlrIzsPKNbunUER+al2FFrCPOrllcVMMWXytLiwGCGUZASTvYI8JbvCgjlQBA2lm+h+pCUx7wu2cTxfhBfVBGaCUrzZE1xZJWUCVQempJxUB20mtvOFwGi5nMVydXmnaBVcTo946KjQXSJyg06HIO7sdQFgDGscIirSWmkQVYY48Pt/8xAuCSolvBGT7D84xPiGaXqTzn+Vet5kT96e9/+xGyr7ihC794PsQIYJ7xHotUKtwQTsaErExDtg2L4TJUCUm7QCX/oVFWoiTzzjWIiMakiGrH09BnrFuXUa6QVeqw9lK9eJhEb+ix5QKRT/T5NIzrY9CU3yavjhaOGxaNLBZzo3sBpvG4sQtwh54IYIqUO6z0xd2X/jJR94hs+oB3ivWa3E1NwiE4YsnlZzLQF0GF9ojmLdVxaE1vSHB4Ihr8B97nj8kNaCI6YE6E7tJ7dQp1tjU/r+zIMTizsIYfzK5D2Z7lys9qGqQGJ8HPHAMEV+9xX2T+jdhyXbVZa6mibV3DmrqdkuZ2aS3bKWCw+DXorxYEVFToOOcz71gEPFxSEKa1TGHtI7rFgVvwnL72lOuh+/IuUOPzfqTCbd1OSle18soZ8Qzg2lpwtkpfifN27r0Gqm1xzK4bC8s2xA8yJQgwWOeMhl5v1YuMBoAbgvQiVNC4Ad8dfNzLedGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUdPRkNGM3E4L29kaktRbWVjWlNTb21JTzdLT3hrdnUwNkVWaXdNS1hqL1Uv?=
 =?utf-8?B?dkJKQzZMUnNCdGJrSmh4ZDVrajBJdDRmZE9FOVg0M2V6dXdETXB3elFpa2Vx?=
 =?utf-8?B?eXo1RmZRQWVsaHhUVjRWdkttbFlLZmNOc1pyK0RjQ2tRT0IySTRCK0I2b08y?=
 =?utf-8?B?M1pOcUlxaDgwUVhZMHl0Tm44RkJ2MlBTYmhhUitQQjE4QmJGa3FFYXpWQ2dt?=
 =?utf-8?B?NWpNaEhDMlBmc2RKbkllOXZjT3R0N05iL1h2NUs2RHkvQUlWcmlTSm1Rd2oy?=
 =?utf-8?B?TVY0UkN1dkkzWFdYd2hrNjIxTVlRblJNYzFQTk83aEljVmJDdzBERlhnOWVJ?=
 =?utf-8?B?ajRjNWZoakdvLy9EaEdjMDhubjluR25uVFh3cDZsaDdaUCtyZFZKcVF4dEYz?=
 =?utf-8?B?VXE4T0o4MlE3NnA3Z1NrZ0xscS95aW9JVVJkUmxHOS9WcnRyOVk2d0xjZ1pu?=
 =?utf-8?B?WXJIeTEzaDFQenBTdmQwK2J1RTNPelFMTmluK2pNbnJxVUdpNklHdFJMOStI?=
 =?utf-8?B?VmdIU1NWV0owUFlzUjBZbCs3Ym0zZGNvY2pQYkpsUm50b0RTTmc1NDZkeGlq?=
 =?utf-8?B?UU5kU3IvbDRyQVJwMU8xRGZIYXkxWjUyRGdUMUpFblpFOW9VTzJQVWIvSWpp?=
 =?utf-8?B?dUM1ek1VZm0reXVpaENTalRXTjBvTVgyenVrVWRiOTFHSnYzQVVOd3hXRXdP?=
 =?utf-8?B?SE9hY2pHcXZvUzJKdXdVbmVQOGpJakJPTGJsWGI1cGs4alpXakR6ZC8wR04y?=
 =?utf-8?B?b0I5M0tGSEVCWllmWkVia21oYlp3RFdWdnU3VFJzdEhKamR6WWpTSWx3ZUtL?=
 =?utf-8?B?VUhlZVVSeml3R3ZFTDh3UXR0dHVHVjJYZE94WmFDS2ZMeGVPcmpTSGQ4MEVr?=
 =?utf-8?B?Z214a3lSeE52OXBrUGR5eG42RWgxdFpFeU8yYVFZSmxVVjNVYU1jZ1lheVI5?=
 =?utf-8?B?OEg5T1ZZT2p4VmdoSDdhT0ZiREtJVnZLeHJ2dXFFcnBwTjFkS01kQWx0NUli?=
 =?utf-8?B?UDM0bHB1bThIb1Jya0JIRHFhNFJaRmU3OS9abFVqREhkbURRaFdxdWhTcE9y?=
 =?utf-8?B?NHhpWElDZUIzTFh5QUhmY1lTREdGL0tTTkNUMGtQY3BkdWdjZ1JFZllRLzBk?=
 =?utf-8?B?UzY4cnBDR1plMUwyT0hjQnRGNDVZTHZQTW42STE5V3RZM2x3TEZGN3ZNZWJV?=
 =?utf-8?B?YWJ2OTJGRk14NnBoT3cvbjhsdnJCOG5sZk8rVml4dXBBQ0F1OEE0aDVrTWFJ?=
 =?utf-8?B?NVptN1BXbGxNdmI3Zmx6cFYyTzlTZW10OFliZ1BEY0hBdjcxQkt0SUZNYlZC?=
 =?utf-8?B?ZXhTdzY0QjVBL2VPb05qVVMvU2hjTnNMeWtiSk9vUFpMYUNuazQzZlFGeFc2?=
 =?utf-8?B?RVJ5T0EzR2hwME1QUEwrZzhuQVBqc1FtTjV2dW9SbzVhK3Q0RXd3dGQ0ZVZm?=
 =?utf-8?B?UFFZOEJkNHVrWkg5eW5DQTdHZmVYbkxwSjNkRHFBWDlVMjVtZTI0cjB6dFdI?=
 =?utf-8?B?cHhCVkR2cWdVS2Y5WFFFeUJRUlQzd2UvRkE1R3NzYnRLQldubGZCOFhFWEtO?=
 =?utf-8?B?SFFaVWFoalc0eDgyNjFGcTBZdkxwR0xjVTRYWmc0d0ZPeVBiWUMxZ1lPZ0pP?=
 =?utf-8?B?cVBNUVNxZ213MG9lL2hTUUxQTDJWVlpOT28yY0tuQkJuV0dONkFMY2IxNXhG?=
 =?utf-8?B?MFowQW9TZ1dNWHAzWUpGQk9iWlJqOTNXbzh6YUhpa0pQVWY4NkFFbTIzWFJq?=
 =?utf-8?B?N0h5RE90b08wUS9Vb1FGZFVHUm9wbGQ2aEZ6S3NNSDVPN21jNDczdEVZYVNC?=
 =?utf-8?B?YUNsUjZDTnhrQkJ3S1ZKckxzdTRvMUw1eStoUTZzaXhnTkJ6SWlwQy9wbGpC?=
 =?utf-8?B?cEZteXZSYmRuWHcwU1ZUOXU1YXEzbWtQQStiRXFoZnJNZW8vWDFyTlhUVGxD?=
 =?utf-8?B?eHpSZEQ3bWJlQ0dVR2FiQ05VNllGL1NvN29LYVUvZFlWaUJDT1VRRmRrV2kw?=
 =?utf-8?B?ZXNLQ1JoYi9tRzg5eDdWRlZwekorblFac0d0SDVQbHRBdklKalB6bGRoYUI3?=
 =?utf-8?B?VmZjNWpzb0RRUDZWQzc1bkROM1EyVVdENGZpTUtJcHpMQ3NXVkRUNzFMOWdG?=
 =?utf-8?B?cDY1REFUdWIxTWlTWE1XeEV1ZW9xMWZJaEI5Szk4ZXFyY2VxMTV0VE5PVGdO?=
 =?utf-8?B?MkVIYmMwK0RZZW91a3NZWFFFNEkybmRCMG45YkJRZ0RtK05BRnA1WnpSWEpm?=
 =?utf-8?B?MFVzOVVUVVBoRmdQZUxNdnZ5OXN2Q0tNUTNmY1FvNXBGTFVpUG9rd3RvZGMw?=
 =?utf-8?Q?NlolpIWzQUPuyC2wl5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af7064a-a261-49bb-3cc4-08df198238ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:52:00.5156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zego6OQiqTW/CS0qvXtY0ZFh03fcH3U1fGPmstdkUlyF7BbhPyrULEBoVFDbRM60
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
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

On 9/23/26 16:18, Thadeu Lima de Souza Cascardo wrote:
...
>>
> 
> What about the other 3 patches? If there is less controversy around them, I
> can submit them as a new patchset version.

Patch #1 is simply not the right direction we need, but see comments on patch #4 as well.

Patch #2 is a good cleanup, that could potentially be applied immediately.

Patch #3 is what I'm already working on. We actually need to change the code so that failures simply can't occur (except for device hot plug).

If any failure occurs here the only real doable recovery is to kill all ongoing work and disconnect the device.

Patch #4 is an absolute no-go, committing partial page table update can cause tons of problems.

Essentially we need to rework the code so that page table allocation happens before we kick of any HW update.

I already discussed that with Natalie quite a while ago on our weekly meeting, you are basically the third or forth person to stumble over that problem already.

Regards,
Christian.

> 
> Thanks.
> Cascardo.
> 
>>>
>>>> Re-mapping the two fragments before and after the unmapped area is supposed to allocate the new PDs.
>>>>
>>>> Without that we run into tons of problems with userptrs and MMU notifiers.
>>>>
>>>> I will CC you on the patches I have so far.
>>>>
>>>
>>> Please, do. I will be happy to test it and review it.
>>>
>>> Thanks.
>>> Cascardo.
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> The other reproducer that I have required that I used REPLACE instead of
>>>>> MAP in order to trigger the tlb_flush_waitlist issue. REPLACE does call
>>>>> amdgpu_vm_clear_mappings too. Notice that RADV Mesa driver uses REPLACE,
>>>>> instead of MAP, so that explains that we can see this in production.
>>>>>
>>>>> Regards.
>>>>> Cascardo.
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Regards.
>>>>>>> Cascardo.
>>>>>>>
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>>>>>>>>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>>>>>>>>>> ---
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>>>>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>>>> index 09037df76400..5bde36754607 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>>>> @@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>>>>>>>>   	while (!list_empty(&vm->freed)) {
>>>>>>>>>>   		mapping = list_first_entry(&vm->freed,
>>>>>>>>>>   			struct amdgpu_bo_va_mapping, list);
>>>>>>>>>> -		list_del(&mapping->list);
>>>>>>>>>>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>>>>>>>>>>   					   &sync, mapping->start, mapping->last,
>>>>>>>>>>   					   0, 0, 0, NULL, NULL, &f);
>>>>>>>>>> -		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>>>>>>>   		if (r) {
>>>>>>>>>>   			dma_fence_put(f);
>>>>>>>>>>   			goto error_free;
>>>>>>>>>>   		}
>>>>>>>>>> +		list_del(&mapping->list);
>>>>>>>>>> +		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>>>>>>>   	}
>>>>>>>>>>   	if (fence && f) {
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>

