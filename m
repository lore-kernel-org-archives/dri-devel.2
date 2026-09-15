Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77751C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961E610E87C;
	Tue, 15 Sep 2026 13:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OCW7UI/v";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D5510E6FB;
 Tue, 15 Sep 2026 13:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHMQL/9+2lJJOf+LiDF7IVGFrwISsNwEm5zwUF9/KrXjba4NELKh3ucm5cl/M9pYnXBVBAhIbklfdR4mfeMUri4EsiAItfUf589kwm3/84NhJEzGv0qQ/bz0YVRooO7ubiADWpGqD19Ov6qqgGkiQBlHv2GrcTCgqBx8LQqhJDrblut31v537Es0EIK+XcdSksvOhOv5ZLbUJv9D2e+xBxKFSGzhyjpHI6DOD2xczPzRxc91PKRLxV+ErkReY2mxL6XHdR/BkrLHL0Y3k+Rhh3NoNatYeyIolIvlYn/153pjIsd+NGo1c50Xj0nYp/S0QbcqAE7CnSa8r5h+LBQ7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0mfqIV7RF9mdU752ZfhBhox2pHlVflpGPDxsl3vCcY=;
 b=BSye8RCRbirBJ2i9OD8soUS2jILYIs7eGy+vXvuILkgzlqLWWVsfQY3gj7pzf2DTLh9agDyIPxap3plQkytX09UDeF+NDFjCfiSV3WE2FsjP2VB3aiElFFW/YzAbrGEhsnW7Qa8h3IHdA9FSCH9cw9zqbZLEiuxZX2++fH73IfZuhOIC2SbA+GUUI3vbB35nyn1L/yUEu0flWMKbUHh9y9vdDMxy1uxTLHB4cXlVJfuiZSILF0iYqeZHM92XvwVLdOq3Pxr8dHgZHQKRfJc5yT/8IkHjHOk8XFKKskioIgz9KuyxTkRFfYTIawzYwdqBP6O+RUaiCfWZVhju7SoXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0mfqIV7RF9mdU752ZfhBhox2pHlVflpGPDxsl3vCcY=;
 b=OCW7UI/vmeU8K/WxlTXk8NnTiAgufhA+Tzcr8OFAegXbixGcv1ApFAvB9d/G3OauZaozB3POSNlS4D98sJq7nYmL643evMfiXcHUjnqX6NH+K9gBoBw6W7Uz6dZwCgyfXnK/6sa/uiUIQ5lGKjdzyNjtXWrt34rqiTxPUbarM0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 13:56:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 13:56:05 +0000
Message-ID: <a59d3421-a241-4497-9890-0b94329b94da@amd.com>
Date: Tue, 15 Sep 2026 15:56:00 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aqktL4Ui1MaIvs_j@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e702aa-d8ad-4672-5ef5-08df13311617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: BbyQKaJnRLuxTaN/uZd0/f8bFjglUHp6h0W0Pfofj7grFN0I23G++nF8tW73nfOv33zfKtU90tXAYRNKFB7XPOB7AwXOeScvgXOJAW3sLopUanS4jvc3Nzwl+HVDZZUVMmsxJc2VuJJnxRlmsT4aLIli3JuSEFBHpkdZVQhWekL3A0uvo/uvWDS55fVTXKK6w8ACVyVqqV9Wo7/5DgsUILmZRYvG5Mn7r+kZ20oYhjTwT/ZwRq27H8jtRjn/91xGT4Nc4Dviho7ZqnISqakg6j2syffaiGaIQOunQDZlyrEfnSjJiIkmReqATJiwBwz3yOp/v8GHlPDKyli9rqlCT5QQj8zy9EqUcXnhlll/z1v9iyBk0ks+dqJYFIOel0RSgyFFzmbPmSHWsU1hGYQEJsKMWrbMyxSTArmlfRsgeokh+bi3xqQePQ4YUl9eRTlSggQnCr7yBwdqOMCmEOAOV4MSqn/dOmVVN8JVy/7a29pYSYWti1flUj4SFxlQ6Yxltg+alO9W7txKldJo6IYlx8sCnW6hDC+3+gffr+HtjdrKfvpnttGObC5smWtbxIX8dWbq/r6OvuUExO9dYwaBWJZIiCDTmIl8QN5RtTvn259Hx1jLQ0Xsyqd9tu/8B0eya1nDd2RC3/hGUSLDbmFKu5Ama9b97yRjjvTe5C5znqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDBRU0RYa1NyeG1aT1R1dktIWE0wVkUvZmFGZW5pcWdUNDQzUnd3NzNRUExP?=
 =?utf-8?B?Ti9lT3VXcFZESDV3UCs3endodTFaRTdrWmZTZ2dyWjA4ZXNjbm9McUZhcUdz?=
 =?utf-8?B?cHlGSXhPTGVpZWJoQnREazZmRXVkdytPc3NscFJtdDBDUUQ4OXhFYWkvNkhp?=
 =?utf-8?B?SWxhbHQ0cjVPZHBrc1ZtNnIyRlNmWHo0eFNpNDFYVlJSNWM3WjhSdlVwN3Rx?=
 =?utf-8?B?S3doQ1RITkZPVWhkOFh1cEs5YVh3cVlrcnc1V1UwU0FsLzZUWUlkVTU5Nlo3?=
 =?utf-8?B?eXJvemVWa0ppTVFwUFhzZ1VWblc3QjZia1hpSFZ1aDF5dDQyay92dDRJejcy?=
 =?utf-8?B?UGNUMCtKNUFySFNLUGcvaUxXb0JuR0NHTHQxQVRLd1pQNHVmWDJPUkhpU21V?=
 =?utf-8?B?NkV4RjJvYWd2bGx0QWRzOUZxbmNzejY5MEdOemVaamFWa1pzb0FpWHFCWkFQ?=
 =?utf-8?B?dWJqeUk5bmVZdGVVRStiWmpYQ2lrdStFTGNjdVJvZVg2T29XalREaTNidTJF?=
 =?utf-8?B?VUgyeDh1SW5VUTlRM2pNUjZKOS9qWGVrMlcyUGwyVmJXYmsrL0pFalE0L1Jz?=
 =?utf-8?B?UWJTMDdDM1gvcFVFZGxqeFgzN2dWSGcwTUFnYXlyMHdNZmJvbHI2R21tS1VC?=
 =?utf-8?B?cTdXUFBvczE1Y09DZTZxVjRXeHk2cG0wSnZRRjRRQW10REJZa2xURVNDOXk4?=
 =?utf-8?B?dzRVOWF0bWNubExlZWx1Ni9HS2FObDlGOE93bWtybW9XemVVWXJyeTNuTDd2?=
 =?utf-8?B?K0x1RDZYTGp2NjF5c1BRUWNWdzBYY0t0MjN6NTdvSHRremdqM1laOGhEM0lC?=
 =?utf-8?B?bEJEbi9xejRmd1ZlZzdJN0NrSVZJOTJHdGZrUThOdDlmajRXTVhhaGNtZm1C?=
 =?utf-8?B?elhCUTdtcHdCMlFxQStFU1Y0RUh4OXNnS2xvTG9UQXNuN1RNTXdjbC9EeExz?=
 =?utf-8?B?LzJxU0NGVE1zQnF1M3gyczlLeFI1Yk0xN1FhYzF2aWdIcHlCY2lWL21CWngz?=
 =?utf-8?B?MGNEZ0xNSWRRQnB2eVNuMjQzamhCVjdQNU1UVjFNNlUxU3JpZGs0UGJSNFoy?=
 =?utf-8?B?M3EwTDVRZjdSR1VZSCtBZ0tkM3IxdDIzK2c1WE9jUEx0bzFiQlNqVW4rZnhk?=
 =?utf-8?B?bnhUZXpsTks2c0F0Q1Q1NGkrdWR4bG1TYnZhWU5MMEFISHB6NEJHT0xubU5G?=
 =?utf-8?B?WEZtcks3ZGxxY1RzT1FrMFErNWJsdXR4WWJkcVFUWmxVMndkdC9DNjRXbUNx?=
 =?utf-8?B?anlMeERFK256ckNxUEMzSTlZbUpJUjcxcERKMkkzYWRNOEUvYzI1SkRGWnlV?=
 =?utf-8?B?TGM0akpDeHdKT2NIZy9XR0hJV3pOdEI1Tll4Mjh5cHUrdnRCUzkwVTBRc1dY?=
 =?utf-8?B?S3FMVlAvdDVpTjEvSkp1TDUwMEg4LzVzQ0JmaksrckIwaVplQUp2UW1UOUMz?=
 =?utf-8?B?dER1RklXaVpuRHBNZXVxS0dMRVdNWHVkNE5DQU93ZERjMXBMZm8wRUpMeWVn?=
 =?utf-8?B?TU8zcWxEenNGU3RqV1NPWGRYRE9iL3NDSGRsUTlWWVhGNjI3Q3FXV2RaZW1Y?=
 =?utf-8?B?aStrMHFrUlR0ODgydDdXdkF5eHhjTEpxTTFMaXBPd1NLUkdLM0RLcllNTnZF?=
 =?utf-8?B?aGZsUDZqa2pxRytHMFZXN3NsRmpRSnBDcHoyWTc0Z29tY0NWRmw0WnVBd1cw?=
 =?utf-8?B?MEx2U3YzVk85bzVUU2NzQzFGSW5kUzdjNktzWWg0bGNNWVdCUDZiYkJtdURl?=
 =?utf-8?B?V3E0TzZNWGNEVEVzdGtXSUxudUY5cHczNmZCV1Q0anhpcDdoMEdLNFlKMisw?=
 =?utf-8?B?ZllLWG9Ma2NOd1RIU1ZOU1ZjbXY2SXg5VkdMS2FUN29RbVhDZ2RoWVdBUDlK?=
 =?utf-8?B?bmVMS0xLRUloZ3pHTmdvQS8xdVpLV0lkZWFkR3NnbmpoUlF6ZDYvYVV3bEE1?=
 =?utf-8?B?V2tpdjR5V0M5Tmlnamw5ZjhIc0hHWmsvN0U5MGpHQm93R0I2VXBjMUxvTnY1?=
 =?utf-8?B?NS8rM2RUVUQ0bVRqUmZSSUlCT3FyUEZhYWNxa2taWG1OdjgyVVdaRU5od3F4?=
 =?utf-8?B?UkJrZFl3U2d3eXBiT2pwSitsdjJ1N3RweXhoTXBIY0tTNms0WGtuRjYzVDls?=
 =?utf-8?B?TjI1TDN2VlpaeHFDUEZFRCtGeWlCdVNqUGZEWS9VT08vNXFKRU16WjBVWUg2?=
 =?utf-8?B?UmVCaVZkOWJlWS9ha28wVEY0L3FLck1LOFh0TEVkNDA5TFE4dERuQS9OMnZE?=
 =?utf-8?B?ZEtWOEFOTzdock5QOEozN3laVVQzc3hoVDlsajZxQ2R6YmVDYUNkcEx3OTZX?=
 =?utf-8?Q?gskgeUB9ndDGyHpuCv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e702aa-d8ad-4672-5ef5-08df13311617
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:56:05.6419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bujYa6Bl6Gb24lKVxQMY5FGlcEh4oMhgzyQN/clkdiRWhAX6/h3zcgonJL3b40Ux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
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

On 9/15/26 13:34, Thadeu Lima de Souza Cascardo wrote:
> On Tue, Sep 15, 2026 at 01:22:48PM +0200, Christian König wrote:
>> On 9/15/26 12:37, Thadeu Lima de Souza Cascardo wrote:
>>> On Tue, Sep 15, 2026 at 10:53:43AM +0200, Natalie Vock wrote:
>>>> On 9/15/26 10:33, Christian König wrote:
>>>>> On 9/14/26 22:25, Thadeu Lima de Souza Cascardo wrote:
>>>>>> If amdgpu_vm_update_range fails when called by amdgpu_vm_clear_freed,
>>>>>> the clearing of that mapping will not be attempted again. Later on, when
>>>>>> an IB tries to read that mapping, the read succeeds, leading to a
>>>>>> potential info leak, or even data corruption, if it attempts to write to
>>>>>> it.
>>>>>>
>>>>>> If the mapping is left in the freed list, then clearing will be
>>>>>> attempted again during amdgpu_cs_ioctl, which will either fail and not
>>>>>> submit the job or will succeed in clearing the mapping, preventing the
>>>>>> invalid access.
>>>>>
>>>>> Same as I replied to oushinnyo <oushinnyo@163.com>, absolutely clear NAK to that.
>>>>>
>>>>> amdgpu_vm_update_range() can only fail when the device is hot removed and we don't care about clearing page tables in that case.
>>>>
>>>> Actually, how so? The SDMA update path has lots of allocations that happen
>>>> at random points throughout the update process (think the SDMA IB being
>>>> exhausted, then vm_funcs->update() will allocate a new one and can fail on
>>>> that, or various fence allocations. Some paths allocate from the delayed IB
>>>> pool which is just regular GFP_KERNEL, why couldn't these allocations fail?
>>>>
>>>> Aside from that, the more trivial failure path that I think Thadeu is also
>>>> talking about here is that amdgpu_vm_ptes_update will call
>>>> amdgpu_vm_pt_alloc (so that happens in the middle of VM updates) and these
>>>> allocations can fail. I'm not even sure if drm_exec can save this one
>>>> because we need to be ready to drop locks and retry.
>>>>
>>>> I get that failing is unacceptable for the cases inside a pagefault handler
>>>> (though I'm not sure if anything of what I mentioned applies here, pagefault
>>>> VM updates are immediate so they get GFP_ATOMIC, but maybe the pagefault
>>>> handler could still allocate PTs?) but for anything else, failure seems like
>>>> a possibility and maybe we should think about handling it in some way.
>>>>
>>>> I'm not sure I see a problem in keeping BOs invalidated and backing off
>>>> later, since new submissions should be rejected unless the VM manages to
>>>> complete all updates successfully.
>>>>
>>>> Best,
>>>> Natalie
>>>>
>>>
>>> Thanks, Natalie, those are exactly the possible scenarios here:
>>> amdgpu_job_alloc and amdgpu_vm_pt_alloc might fail.
>>>
>>> Christian,
>>>
>>> I have started this investigation once I observed the kmemleak that is
>>> fixed by the other 3 patches. Natalie brings up the exact case where this
>>> might happen: amdgpu_vm_pt_alloc fails as all other VRAM BOs are locked as
>>> they are either ALWAYS_VALID BOs or PT BOs, thus sharing the same dma_resv.
>>
>> Yeah and on a clear there is never a single page table allocated. What could be is that temporary memory allocations fail, but we need to make sure that never happens by using the emergency reserves and/or pools.
>>> Here is a log showing up that something failed during the update:
>>> [ 3839.556311] [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-12)
>>
>> That is failed memory allocation while trying to map something which we also ignore and delegate to the next CS.
>>
> 
> Yep, that is a possibility as well and amdgpu_vm_bo_update is not ignoring
> the failure here and leaves the mappings in the invalids list, which the
> next CS will try to map.
> 
>>>
>>> The investigation then led to a reproducer, which is able to trigger the
>>> list corruption that is mentioned in patch 4.
>>>
>>> And given the kmemleak stack trace shows amdgpu_vm_clear_freed in the stack
>>> trace, that should clearly be where the failure has happened. Looking at
>>> the function, then I noticed it ignores the return code and still removes
>>> the mappings from the list. I was able to write a second reproducer that
>>> triggers the failure, then releases some memory and demonstrate that
>>> amdgpu_cs_ioctl does not clear the freed page tables as the freed list is
>>> empty.
>>
>> Unmap/clear operations are also used in MMU notifiers who can't give an error back to higher levels but rather need to unmap the area no matter what.
>>
>> So basically that is an operation which can never fail in the first place (except for device is completely gone and then we don't care any more).
>>
>> I'm about to split the map/unmap into separate functions to make it clear that unmap operations can't fail.
>>
>> When you have a reproducer and can pinpoint where exactly the memory allocation fails that would be rather helpful here.
>>
> 
> What I understand that happens in the case of clear_freed is that we are
> breaking a PDB/hugepage and descending, as the clear happened in the middle
> of the hugepage. With the specific reproducer I had to go through lengths
> of making sure that the original mapping landed on a hugepage-aligned
> address, then used CLEAR/amdgpu_vm_clear_mappings to unmap a single page in
> the middle of it.

Yeah that is exactly the broken case I'm already working on.

In that case the clear should just unmap the whole hugepage and not allocate new PDs.

Re-mapping the two fragments before and after the unmapped area is supposed to allocate the new PDs.

Without that we run into tons of problems with userptrs and MMU notifiers.

I will CC you on the patches I have so far.

Regards,
Christian.

> 
> The other reproducer that I have required that I used REPLACE instead of
> MAP in order to trigger the tlb_flush_waitlist issue. REPLACE does call
> amdgpu_vm_clear_mappings too. Notice that RADV Mesa driver uses REPLACE,
> instead of MAP, so that explains that we can see this in production.
> 
> Regards.
> Cascardo.
> 
>> Regards,
>> Christian.
>>
>>>
>>> Regards.
>>> Cascardo.
>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>>>>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> index 09037df76400..5bde36754607 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> @@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>>>>   	while (!list_empty(&vm->freed)) {
>>>>>>   		mapping = list_first_entry(&vm->freed,
>>>>>>   			struct amdgpu_bo_va_mapping, list);
>>>>>> -		list_del(&mapping->list);
>>>>>>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>>>>>>   					   &sync, mapping->start, mapping->last,
>>>>>>   					   0, 0, 0, NULL, NULL, &f);
>>>>>> -		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>>>   		if (r) {
>>>>>>   			dma_fence_put(f);
>>>>>>   			goto error_free;
>>>>>>   		}
>>>>>> +		list_del(&mapping->list);
>>>>>> +		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>>>   	}
>>>>>>   	if (fence && f) {
>>>>>>
>>>>>
>>>>
>>

