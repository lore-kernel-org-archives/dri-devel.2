Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168C2C9830C
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3518E10F06E;
	Wed, 23 Sep 2026 13:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXvcFPvh";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 685E810F06C;
 Wed, 23 Sep 2026 13:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC9X6UpRcMt45ttOIAfzCCPT2DuWyrOShczjazYyzvU5GShHnx4oIwqvOlfMgZHLRG6/iHA9qePsb1/WnTGid/nDb0pnbXXeeHr+68sz8XC6b70JaLNbNM/fx9a0SCzjdsWEt6pHM3SM/EZM5u3R5FrkWTnKSCLf4OnaNDchtqZJ755bL6lLXG4AZYwm7dXcZuOAcPoxxknO7OG3UrocZc69uSvya/fobvA8k+GDRR0yHDe/lVIT+mLQyS9/EVrc9xBVnF+CBhyh/fRLhWyg5KPuu0FS/X23B99iNz1DtSARQdLnMIIEH1CshdD2tX1bC8w4jy/mHcjA2+0KqnnzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2GETZbOejNT/CtWFH/qG3lIPP7bVqE4+Wlzb4ZE5Dg=;
 b=tlvPgJYp+z8v+BPyHBmg5T5dkGDpIhdQhQ2pQ1laXbh5E/4QNEbwbKLvM5PN9xXO+6Ob8pryGjEsVdZ5TI9NqZWcu2Wm/ArRv8zJpY4gjYrlFCf2dT7Jn6qT9vZprzXeAn0utbEccdGZqRtCLDVB25nNHEM3mfbV89w807ntB6hERv2uXNCK2V8xLEYIYUYtDMlKCw8J2ER9mcrRcJ/RE68siO2oVvrL4FPQKKBxbmqAwARaUvSe6ihADtRizJ2WgH+hS5om80V3z8jSDWH4g2YkGsuAvYnBcpmkHfk7j71IF4IsKHL4v15rwLFCOWtxhlRDnL/ndoimdmisbHj8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2GETZbOejNT/CtWFH/qG3lIPP7bVqE4+Wlzb4ZE5Dg=;
 b=pXvcFPvhJM/GX7GHYU+oKR7ujPTMokFJEErvkAvZapMoRATLL/a5peZ1LSVR7uCop9HZnkWhX+6qP1QZAXSN6UkJ+WnbKCxNotRPbvsgcA+W+kwbVEDXlaLWAaIBJvk7w1A4cby+FJx1/Wree0bxMCknnRFMIKYE+lno8op8xE4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 13:58:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 13:58:33 +0000
Message-ID: <f4c3bdb7-3b6e-49f1-9baf-36ab069faac0@amd.com>
Date: Wed, 23 Sep 2026 15:58:27 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <arPakAXXW1TdfF0Z@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: f221a1f9-11b9-469a-cae4-08df197ac142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: BwQedPr0QZU3dYh4E/ftcXxo0FjaYgUPRdV8tAJu4PL/IFkMwoteerWklpfSbyTnfd9XA6CZBASOfdDfXyY/nfw8YSwkbfseVhsJlgeNj2ufMRqfQ9SbEB9i2kQ1Z4f3nosOVePZgs2omNjfvEco+tq920gQxiqRuYv3bnPb+xIkz0lmbdwe6Zo5Bi86AhXbAGx6/5C1entA5Ej9Rtr5aOGQt9cDXAnlNui1VbFwHXsXUMGzlR5uSLOTeTl3TTrpgX9D1qZZOWQeG+0jfIPP2kzH9BQctMdxq4MQ1pEOJ3QLnw1U7z35h/FJMJUcydjfO9WKzCW5IRavPQ3ubBKu8YnsBp5UHsiNGNWbZLQF7r3QHTJToXPaWFjzpaHeirV/jvF3m2IsFZc+xs/qDytDpz4PU6eUKGgwTNn76wZsLhUjHVlMkTDE9uA5UtDer/HIVCMOtvxwSt5U6AYuTX2QA4hS/1ovl2E4dt+rs++B5tOXJgh/YHfQuoimbDieO9ezSqQRtlgBF/MSDATlXzon33u6bdzZwyQv0kfnHxO1yChcJgRALRdOlW+I2V3hrC0WbQNZztdwVk4iRw98H23V7z8KFDBvw33+nKR9ZqLBf5aePCzrMEyYTmUOZsubAdl2WuJ7q7k/uXHQjHZ22P0HQM9gczcQ/T4NUI7GTmVVgg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VhT1BTU0tWVXpJdHNEa3RPTlZ1K2l2bFhJcGlXVXlLeDlHMldlNk9URXk0?=
 =?utf-8?B?U2xGN1BmalBZRENoNy9ER05JMjFjRlJRWW1UUDd2SDQxd3RWcm1PdFFHL21Y?=
 =?utf-8?B?RXFPMXI1RHk0NDc2YmVkS252eTVZUjYvalFpVzRPWlV5d01vc1hSMDdDd1dw?=
 =?utf-8?B?cHJxaFpIemdPRzg0NWx5L3cwLzVkSlA3eXozRXFDOFovWVB2OWFvWUY1Q2hC?=
 =?utf-8?B?aXdmWjJBbGNLelVNeVpsQkQzRiswU1N1d0s0VjhldHA2c0d0cmZKM2dSNnoz?=
 =?utf-8?B?VXpMMURYQXlBbHpuREdrOGlCRjg4dUM0MkJkeThwNFRoTmxGaC9Ld0dlcWlW?=
 =?utf-8?B?eUJCeHMxa3A2b2hMUGREdHVEMDRLT2ZTTkZYRGhCbHJNWExPWFg4ZTlxZ0pZ?=
 =?utf-8?B?cTVObFZ0R0FiWktGcmE5RUcwcitMK1JtWTExemx5U2dYTE11TmJLU1h6dTlR?=
 =?utf-8?B?RnBRTWs1ZDRjcmFORWsxOTh1QWNhYTBDUitYTlUxZ2hiK0NYQTQ3VkFFTFFk?=
 =?utf-8?B?RjFSK2VtcmNIdm5TV1o0eTB4NE9INXAxUjJONDczd0tXbjdLRHFuS0hFZjNM?=
 =?utf-8?B?NkpJMGFHckRxM3pWYm5vNWNLU0IzZWRkaVRJbWxWODliRXUwWHVFUjF2MlF4?=
 =?utf-8?B?UFcydm1OcU1TZk5lUjZjS3Q3TVFuVWJ6eDJkRTVrSFJSckhlVFNyWGhGSTZ5?=
 =?utf-8?B?TWFhT2JtdGM5WkZ0eFNSYjBUM3J5RW1hd2dQcHJSYS9SWFlDUmx5MVExYzNr?=
 =?utf-8?B?TXVEbWZYSXZJaWpmOTEvVEpTdDBqaUVEMzVlY3gzNXI0KzBFWkdCdVQwTUxx?=
 =?utf-8?B?eW8yWDhrV1hONCt1TGpUWGtROG9VNlBqYkp1K1loYVZYRjVKVjBYeDlUdm0w?=
 =?utf-8?B?dnorN21pQjBXdDA3dHFBZmluZlVMY1ROVUYrZ3ptcGcrMy9BbmNyNER3ckpz?=
 =?utf-8?B?L2UrbFhPSG5UVUk1R3pobEFLMFhyU09Rcm9HOTA1elVPK3JzRjkzalV4b0M3?=
 =?utf-8?B?VTVkclUyNXBCTjM1SjhZZFNEdUFvckZTalhqRVhvQlA4Uyt5bFFOV3N0Z3Vr?=
 =?utf-8?B?cXFaekxnaXZsV1EvSytzZTIyWFB1aktwVGxTS0cyYzFGV3dtaDJ4eHhxd2Z1?=
 =?utf-8?B?OVF5em9ST044Qno3Q0xVYlloTWZ3L3B3dkEwZnVVeHpaSnF1aHlsNkFSc3JW?=
 =?utf-8?B?M2h4NGhpYlhvSmdRNGhMWTN4a25KdFRpNXM3UkI4ZVU4dWlXcHZLYVZ6MnJ5?=
 =?utf-8?B?emV5OGJXMFpHUlhCTUNzblk1ZnRuMWxyUmF4NWRaUER3czNIUTNnYmpCd1hh?=
 =?utf-8?B?SThXbzRmd0Z6M0tHQXEzZVJvOFNINHFsS0lqRGwrekRNNEhoV0xVNUNPOE1v?=
 =?utf-8?B?WnNIYmkrVUhQMWdMMzVCZ2dyUDB6dEdJMHoreVBBQXJsanprbzB2LzI2b0ZX?=
 =?utf-8?B?Nkt2ai9Xcm9PcnUrenAzWjJ4a1plaVFYNjZRdDNuMk9HT0hwQ2cwcU5ySU9l?=
 =?utf-8?B?bGRpc3NwRHNwWVhoaVlHZFRYb1NhblF6a2FiNitnQ3ZobUQ1T1BIenc1cS9T?=
 =?utf-8?B?V3pYWitLTW1pYmtxektXVEhDaTJnU1k4eGtHQTBDRDk1MEc0ME9qK0V1NXli?=
 =?utf-8?B?RmhFdTdQeVlTcGQwZGFicFNldmJXNjZDWHQxVEVnTStMbmhCcisyWUJaNlp5?=
 =?utf-8?B?Nlc3M3ZFdzBUSTFWZExGU2xqZWF1UEJLYnQ2dHowMjNlNElyL0xsdDY4UjEy?=
 =?utf-8?B?OXlvSmNiOW1PblFTL0dPcWhwamZLdnpiWGVlaFRnWjZYa25EZ2xFaHRhMWts?=
 =?utf-8?B?dzNnVStHaldtWjhTSE9ENzEwYncyQWhuNi9IZS95UU50VGQ3aWNqTS85OFNs?=
 =?utf-8?B?MnJmWWFJVGIwOU54ZjErb0V2MU04UlNxSWowS1BpN3doOHV4R3NmYzBhSDY5?=
 =?utf-8?B?NGp1U2ozay9ZSnZFaGFWVmJuK2xZTGlrUWdhZ3NEZnBqb2s4NW9rdW1qSVRy?=
 =?utf-8?B?RjJ3ZU1pdE9qUkFmR1UwSmFQMkhNQysydmpIT0s2bzY0anhucmlLVzY4Wmhp?=
 =?utf-8?B?WStqdDFxclVhOTRWU2xpTFRtdU50YXoyR0VHM3I3bTNtNzhXRXFqbkZmYTlP?=
 =?utf-8?B?T2d5RmhjVk8vQzNyV2o2L3JJNWtoajBWZ3JtaWpCWUI3VG1oNVM2dG10dzQ0?=
 =?utf-8?B?UWVzc04rOGdzUnowd0FHd0V1QUFWVThjQXZLWG5YOUl3dTRrS2pCQStGMmZC?=
 =?utf-8?B?Sm95OU41eUIxNVM5V3lrYVNsQW5xM0N1T2hwWVBlQ0ZCanF5SndjeE1XTjhx?=
 =?utf-8?Q?xSKWXa3Hs52uRfdpbF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f221a1f9-11b9-469a-cae4-08df197ac142
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 13:58:33.0313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgzDzEGG2Cp713RncjH8EgOvWgWfRLDL5nE1K8OgHktUPNiu8kc5UkPDbrxdJUG9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

On 9/23/26 15:56, Thadeu Lima de Souza Cascardo wrote:
> On Tue, Sep 15, 2026 at 03:56:00PM +0200, Christian König wrote:
>> On 9/15/26 13:34, Thadeu Lima de Souza Cascardo wrote:
>>> On Tue, Sep 15, 2026 at 01:22:48PM +0200, Christian König wrote:
>>>> On 9/15/26 12:37, Thadeu Lima de Souza Cascardo wrote:
>>>>> On Tue, Sep 15, 2026 at 10:53:43AM +0200, Natalie Vock wrote:
>>>>>> On 9/15/26 10:33, Christian König wrote:
>>>>>>> On 9/14/26 22:25, Thadeu Lima de Souza Cascardo wrote:
>>>>>>>> If amdgpu_vm_update_range fails when called by amdgpu_vm_clear_freed,
>>>>>>>> the clearing of that mapping will not be attempted again. Later on, when
>>>>>>>> an IB tries to read that mapping, the read succeeds, leading to a
>>>>>>>> potential info leak, or even data corruption, if it attempts to write to
>>>>>>>> it.
>>>>>>>>
>>>>>>>> If the mapping is left in the freed list, then clearing will be
>>>>>>>> attempted again during amdgpu_cs_ioctl, which will either fail and not
>>>>>>>> submit the job or will succeed in clearing the mapping, preventing the
>>>>>>>> invalid access.
>>>>>>>
>>>>>>> Same as I replied to oushinnyo <oushinnyo@163.com>, absolutely clear NAK to that.
>>>>>>>
>>>>>>> amdgpu_vm_update_range() can only fail when the device is hot removed and we don't care about clearing page tables in that case.
>>>>>>
>>>>>> Actually, how so? The SDMA update path has lots of allocations that happen
>>>>>> at random points throughout the update process (think the SDMA IB being
>>>>>> exhausted, then vm_funcs->update() will allocate a new one and can fail on
>>>>>> that, or various fence allocations. Some paths allocate from the delayed IB
>>>>>> pool which is just regular GFP_KERNEL, why couldn't these allocations fail?
>>>>>>
>>>>>> Aside from that, the more trivial failure path that I think Thadeu is also
>>>>>> talking about here is that amdgpu_vm_ptes_update will call
>>>>>> amdgpu_vm_pt_alloc (so that happens in the middle of VM updates) and these
>>>>>> allocations can fail. I'm not even sure if drm_exec can save this one
>>>>>> because we need to be ready to drop locks and retry.
>>>>>>
>>>>>> I get that failing is unacceptable for the cases inside a pagefault handler
>>>>>> (though I'm not sure if anything of what I mentioned applies here, pagefault
>>>>>> VM updates are immediate so they get GFP_ATOMIC, but maybe the pagefault
>>>>>> handler could still allocate PTs?) but for anything else, failure seems like
>>>>>> a possibility and maybe we should think about handling it in some way.
>>>>>>
>>>>>> I'm not sure I see a problem in keeping BOs invalidated and backing off
>>>>>> later, since new submissions should be rejected unless the VM manages to
>>>>>> complete all updates successfully.
>>>>>>
>>>>>> Best,
>>>>>> Natalie
>>>>>>
>>>>>
>>>>> Thanks, Natalie, those are exactly the possible scenarios here:
>>>>> amdgpu_job_alloc and amdgpu_vm_pt_alloc might fail.
>>>>>
>>>>> Christian,
>>>>>
>>>>> I have started this investigation once I observed the kmemleak that is
>>>>> fixed by the other 3 patches. Natalie brings up the exact case where this
>>>>> might happen: amdgpu_vm_pt_alloc fails as all other VRAM BOs are locked as
>>>>> they are either ALWAYS_VALID BOs or PT BOs, thus sharing the same dma_resv.
>>>>
>>>> Yeah and on a clear there is never a single page table allocated. What could be is that temporary memory allocations fail, but we need to make sure that never happens by using the emergency reserves and/or pools.
>>>>> Here is a log showing up that something failed during the update:
>>>>> [ 3839.556311] [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-12)
>>>>
>>>> That is failed memory allocation while trying to map something which we also ignore and delegate to the next CS.
>>>>
>>>
>>> Yep, that is a possibility as well and amdgpu_vm_bo_update is not ignoring
>>> the failure here and leaves the mappings in the invalids list, which the
>>> next CS will try to map.
>>>
>>>>>
>>>>> The investigation then led to a reproducer, which is able to trigger the
>>>>> list corruption that is mentioned in patch 4.
>>>>>
>>>>> And given the kmemleak stack trace shows amdgpu_vm_clear_freed in the stack
>>>>> trace, that should clearly be where the failure has happened. Looking at
>>>>> the function, then I noticed it ignores the return code and still removes
>>>>> the mappings from the list. I was able to write a second reproducer that
>>>>> triggers the failure, then releases some memory and demonstrate that
>>>>> amdgpu_cs_ioctl does not clear the freed page tables as the freed list is
>>>>> empty.
>>>>
>>>> Unmap/clear operations are also used in MMU notifiers who can't give an error back to higher levels but rather need to unmap the area no matter what.
>>>>
>>>> So basically that is an operation which can never fail in the first place (except for device is completely gone and then we don't care any more).
>>>>
>>>> I'm about to split the map/unmap into separate functions to make it clear that unmap operations can't fail.
>>>>
>>>> When you have a reproducer and can pinpoint where exactly the memory allocation fails that would be rather helpful here.
>>>>
>>>
>>> What I understand that happens in the case of clear_freed is that we are
>>> breaking a PDB/hugepage and descending, as the clear happened in the middle
>>> of the hugepage. With the specific reproducer I had to go through lengths
>>> of making sure that the original mapping landed on a hugepage-aligned
>>> address, then used CLEAR/amdgpu_vm_clear_mappings to unmap a single page in
>>> the middle of it.
>>
>> Yeah that is exactly the broken case I'm already working on.
>>
>> In that case the clear should just unmap the whole hugepage and not allocate new PDs.
>>
> 
> Agreed that we should also do this. Because my patchset does not prevent
> the issue and if there is no relief on memory pressure, the failure will
> end up in amdgpu_cs_ioctl, resulting in a submission failure.
> 
> In any case, given that other causes could still result in the similar
> symptoms (memory leak, list corruption), would you consider applying this
> patchset?

No, the code changed by this patch here at least is actually fully correct.

Regards,
Christian.

> 
>> Re-mapping the two fragments before and after the unmapped area is supposed to allocate the new PDs.
>>
>> Without that we run into tons of problems with userptrs and MMU notifiers.
>>
>> I will CC you on the patches I have so far.
>>
> 
> Please, do. I will be happy to test it and review it.
> 
> Thanks.
> Cascardo.
> 
>> Regards,
>> Christian.
>>
>>>
>>> The other reproducer that I have required that I used REPLACE instead of
>>> MAP in order to trigger the tlb_flush_waitlist issue. REPLACE does call
>>> amdgpu_vm_clear_mappings too. Notice that RADV Mesa driver uses REPLACE,
>>> instead of MAP, so that explains that we can see this in production.
>>>
>>> Regards.
>>> Cascardo.
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards.
>>>>> Cascardo.
>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>>>>>>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>> index 09037df76400..5bde36754607 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>>> @@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>>>>>>   	while (!list_empty(&vm->freed)) {
>>>>>>>>   		mapping = list_first_entry(&vm->freed,
>>>>>>>>   			struct amdgpu_bo_va_mapping, list);
>>>>>>>> -		list_del(&mapping->list);
>>>>>>>>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>>>>>>>>   					   &sync, mapping->start, mapping->last,
>>>>>>>>   					   0, 0, 0, NULL, NULL, &f);
>>>>>>>> -		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>>>>>   		if (r) {
>>>>>>>>   			dma_fence_put(f);
>>>>>>>>   			goto error_free;
>>>>>>>>   		}
>>>>>>>> +		list_del(&mapping->list);
>>>>>>>> +		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>>>>>   	}
>>>>>>>>   	if (fence && f) {
>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>

