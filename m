Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D173D35159
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD3A710F00B;
	Wed,  1 Apr 2026 08:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W9pM73yj";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA8710F00B;
 Wed,  1 Apr 2026 08:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6BXrsfTBks6pNahFDsg4/+qY1wRDHg4w8SikVYvasDzMvVFaLnZugxOPPtOs7HKakojLRbJ0DSDc6F//ur8+8BW9sIhEtafOqr0wmi40xwo/5iB39aigzh3pdjVDm/wrJcoZNaZbomUxmU01ztxb5dNjzRL0L8vwOu7yrLzn38SgUtYir3hIEab7wnqZruQ146FW1iI6ZVh7BEgKmPcwSZedtt8mLGAIXGuJFBFaiV+Jdho4togweLMCTBnw2TOtriXw8vFt7e3rIvNEl6y9VoP0bHY5lM5sIWkmKZ/Hs7iOOuPnK0f65CtXd7dk5HHtJqC13OK9Nixwwv0MurKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5u0E8yOvJv1OaCVr5kWINkAh0H3nUyiDKcGomhthZjQ=;
 b=PPAU20T0O2AKI9jnhlL/fGzid9iPP0f4i+ErrGqRpWgpn/CEPqQDZZMDmvswQmcLl6R11kkL18gsXmXt5FffqqeXy7itCr797IY9xp43dFwNOYbXH0VYrYvq6QUMEQPN2YcVJ7d40ZXlpuI7Dcu7NDFXh/naM4HTgyFX9UDl9gwuByxAIr1bwSWQotd4GQIIDylJfwAqDX2kT5aP00JrL4qruxX/BPE6YUcRQrlJGAFGOGZfek/rMMrL67zuQDkbxv7LyHAT8Et/AhwxM3U01IpWUmC6aUTO2Zge0yxiLxrJRKJqcv5qoRdZC1twDibC2z45IOtbYV1ESIno1H3L9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u0E8yOvJv1OaCVr5kWINkAh0H3nUyiDKcGomhthZjQ=;
 b=W9pM73yjTUxR8IqIeQ9//7smwM9jfFHKw3L52kBbAq0QhjvsPoUeVq0J6wR2UGwxYh8cwBNMY1sxL9VOTOvrdDZG5RkT/mK2aOpZ5Vr4HoYigIyICWyOTInwsAfb6SqSbf7G5R8GgWVqeVOzMqkp/QO7r3zEIXEeaiWbRBRWcYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 08:21:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 08:21:32 +0000
Message-ID: <162848f7-ee9f-4bac-83e8-84863081dc60@amd.com>
Date: Wed, 1 Apr 2026 10:21:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: deduplicate register access and helper
 routines
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260330224503.548284-1-gabrielsousa230@gmail.com>
 <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
 <CADnq5_N6bzHTQJjS6__-Fmp15fASUw3C5DG1uNvZgkxCRtFkcw@mail.gmail.com>
 <CALsHKmUeB3=H9=Nq=+jOvtmwXxSg=wtHrASZNvVVPQwpyem2ug@mail.gmail.com>
 <CADnq5_Pf841oeJAwhLp=1Y_tOWmEX+gyhDW06Z=qr+FR4x4JEw@mail.gmail.com>
 <11e4daaa-0f1e-4fd4-b435-d2fa9d058869@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <11e4daaa-0f1e-4fd4-b435-d2fa9d058869@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: f603c4fc-b8b4-41b9-e33c-08de8fc7aea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: yPhlli0krTSKooZEA+hV3jwJf89xYWppN3UyDO+eeWyffLSp0njxpgv7h0rue2+IcECVZilfLtlnylsUyp/6xVecnqdmX0AhQfje/Xn9Gg75dKxtVHYQIEMIAY1MmEzQs5++KWTYBnyIrekJroXYr4h3tgIDpe/cgSb7nJfIz3YCQeqZ7cCeX1iesga17lLis9RauXhWChH+2ZBKDWZaZQYPxcAy9PgpPVQB4q9AxBRy2xslHf+A5AAnjmxT8xFQyY+oRdYkMX2B+/rQn8x7XeTb/M7LUyY9ZnSOT+1ixHyD/3auta/TJT5Wc0M1eTEGaF0TmCyXM7HrQ5GHJLVTStMSi0+GbR1wGrkvjaHCqKIon1MBoVeSrtD2TpOf+SJ5iph1BaALG3TX7xJn9d/ODL2Pe7lpQVBlsfMe6UxqKVVlRL2GDLLJBkOXcf8yXpbxVdFnwG6pReXRvEElq16qyo6YPcSN2T2KqDabYTFjloV2FYexjKB/+83vf4q9wmgtBuIYdl+uCxLqykdXcXO7TMoEp4pIraKG2zUcP5tYdf4cG1afME+vvbzaJWxb6kKRQIJcNRObcWlWrGnf3gMH5Nw3OZ0AoTJOsf7PiBfKyuskKKz7Ox4WV4Ove40pOoKPGNxELntDpMYIsl86jZo9tev42/oH5JebqMh9P3IOw8Up7EnD8oJa6Lch+Gg/Gvv+64hjB10P9GuDV2pY+chIGVE1M546HJtUqEHgplqO0DA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BqVThMN3QvcXlQNDFEVCt5WVAwY2NvV1B6V1I2aVU2Y2t1TWJGUTlsOEw4?=
 =?utf-8?B?aGRZaHBUaFJ1SmhqejFNZ1R0eGsyL2tGTUszb0JNcUNZY1d2R243citsclhh?=
 =?utf-8?B?di9zbkhmbzAyVG9sRnZ3NG5EYmthM2ZiTVJDVWowYnQvd05CcnduUEFCSmJi?=
 =?utf-8?B?cXdTVE05Yjk5RWlHaGJMU3pzeGZtVW9yeVF3V0JNZWZjMVgzeTM2dW9XQWMw?=
 =?utf-8?B?Q2pFcEVyVm83VUJkZ0ZlL3NZVFdxZU9xTWZ2UHhaUXZ1SkpLejRmTEs3L1lh?=
 =?utf-8?B?aGlMZUpZTUtmN2RTMEpZUlNyVkhPRyswVklSRWVIbFphUGo5OVYyQUlIOTFU?=
 =?utf-8?B?UDFFUVNlenRxQmpvT2FFbWsxNWhSMFVRMklZR2V0MXAzZTRreXl4Z3lLelZH?=
 =?utf-8?B?YkJHU0lOMkNZRGhiZWxLVnpMazdXaHZoMzh4RmlpZ0UxN1ptVHBjSmxTUkpr?=
 =?utf-8?B?TVNVUTBydytKQjN5bSs2S3lHRlhrbWhEYTVyUkd6NGRZN3Q1RVI4RzBNMGRh?=
 =?utf-8?B?V09ZQWlaenRLVFpXUUpZNlZzWXhRRk9qMEszeEdScUdkKzJXRmVCUjVmdWJN?=
 =?utf-8?B?aWU4SUpxa2pBTFVUNGh2QjVXcytETnZsem1SWkhxK01BWkZPblF4ZFVMTFpl?=
 =?utf-8?B?SElxM0pSSXVycUdpdHJQYmdlWnhhamwxaUlUSHRQbjZseUhXK2JvMFAyVVFa?=
 =?utf-8?B?SUNZOVRCOXYxaDJFZUxJUTFnczY0Si9EcU80T3VYWGZUYUJVZ0p5YmRxb3Zr?=
 =?utf-8?B?WnhJdm9JcGcwZmVKTHVoTnFTTVFKMTJaNHdFY042WExhckRyd0N3WUlrOVVS?=
 =?utf-8?B?RTliSW5QMGlEbzV1Rnp6N2h0cUw5ZHRGaklUbUNHWVJqQmtpdWFLazZaVWZB?=
 =?utf-8?B?VFpTaUc1NnVUMTVuK2Z5Q0lrYlJjREV5b214SURlVTQxQjJyMCtaclRvZmV4?=
 =?utf-8?B?bmFYZTBXenBtdXNLdkZzSHdrRUhvdHllVXZvMTRPVEdwR1JBVk9LQktvcHFy?=
 =?utf-8?B?VGxkeHhZZFpLSkQ3TW1Ea2RmUG80M0crQllQc0lpUndkOU9JTmZ4cHcxQ0lz?=
 =?utf-8?B?SHlrMVVyZGRFYnVjTTNrRHFSVEFkS083MG54bEZzQjAycHRjMWQ4ZkpNY1p4?=
 =?utf-8?B?SERWNFhBZjRNaUFpcGtoRmJScVhKdFlqdURxNHp5SUxqWTBUQmdyall5SlhH?=
 =?utf-8?B?ZlNsNnZVL1FJcGZWUHJjZEdsN3o2N25QU21Zc2VKbXpBNmJienRQUlp4TE1m?=
 =?utf-8?B?NTVCZTVPck04b2FoMGJUMTV0anJLWHlwMEVnbVU1SHlsVW1vMWRaMXJueDgv?=
 =?utf-8?B?TEt6VkRnMUVLRmpOSE1Xb29oNGF1ZVJCbm1WTk1ncW9DdURyVFE2VFAvTng0?=
 =?utf-8?B?V0xOeHpSV0NHanhFazJoV1N2NUlLNkNYMkRoZlVOZ0VCWEVTNklYMUdCOS9T?=
 =?utf-8?B?TFB0OUJsMTMrZ0ZIUE90Q1FRVHZORzBBRk9TR2FxcDBEdGNRbmVvelJZYXFZ?=
 =?utf-8?B?UWJBa01zR0dML1JhTkc0QzR3ajdlbW9pcWovQzZLSndwa1AyRDFnVExvNEVw?=
 =?utf-8?B?N0YyYkpMUkUxVzhTVkhhOUhMckZSU2pDdi80SStHOUxMRHR6R2txN2JkTk9W?=
 =?utf-8?B?Z3kwNW5sR1dHblA1RW04NU9DR1d4UTBYQzNjTzAwOHJuTjJwZklQaTBnTFpi?=
 =?utf-8?B?RCswOE1jbENhM1A0Nyt3bmRNTUllUi9FcXc1ZUhuVUUrUFNHY2FqZG9zOU8z?=
 =?utf-8?B?VGxGM3Rkak80Rm5CUG1TbFkzc0JGWVdwcDVuRG1OS2w0MjM2endXbUVtWjM4?=
 =?utf-8?B?MWhhY0liT1k0MUNDUktsQjlPQ0NOams3Nms5blV4Z2dOeUhlUU9WN3N5cnF1?=
 =?utf-8?B?SFBpVzBXNTZtZjJZRGNWeGdPNWwzbzhDUXdWRm1VS2tEbC90cDJyRVczaE1p?=
 =?utf-8?B?cUJiTmhtUjMvdEZKRmUxWklOTHdoamNxMUd1dTdPMG55ME5pZHJOVTN6TDBv?=
 =?utf-8?B?YkFxdit4Wmd6WlUrTjFNRHFTUlNRWDRWV3pGb0p1WEFxTXRCK3FNdkZVcURI?=
 =?utf-8?B?MUVFYnJjMDZWemRrOXZnTHE1QmdtK2YzZHErTDZjU3dadks3MTdreFdkN1Mx?=
 =?utf-8?B?UlZzNGZHMy90bnpYbE4yMUpSa3l1VFMvTFd2ZXJwRndkNU96akNnSmNhTnFZ?=
 =?utf-8?B?V2FEOFJjUGRpTk9ZKzVuZ3YzUVNDRWxyMGk5T0hUTG02SC9YQ3dxMVg5UXQ0?=
 =?utf-8?B?aTdaUkxkNmVBRmYvNzNTMFhhM2FWWG9COXVrMzVMSWNiQkEyL2czUXduVnFC?=
 =?utf-8?Q?Ovy+4uEFNwB7rZYMXd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f603c4fc-b8b4-41b9-e33c-08de8fc7aea0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 08:21:32.6878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5PV5OeGnp/CFlGXBdiVHmAved6B5EGwL7kHTmv+PI/UMPRBzCrAFz/1AdqByRPm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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

On 4/1/26 08:58, Lazar, Lijo wrote:
> 
> 
> On 01-Apr-26 2:51 AM, Alex Deucher wrote:
>> On Tue, Mar 31, 2026 at 5:07 PM Gabriel Almeida
>> <gabrielsousa230@gmail.com> wrote:
>>>
>>> Hi Christian and Alex,
>>>
>>> Thank you both for your feedback.
>>>
>>> I understand that there can be differences between these functions due to
>>> different macro values across hardware generations. I admit that I didn’t
>>> fully take that into account in this patch.
>>>
>>> Among the functions I modified, `program_aspm` and `common_sw_init` seem
>>> to have identical behavior regardless of those macros, so I thought they
>>> could be good candidates for shared helper functions. That said,
>>> `common_sw_init` is currently only identical across NV, SOC21 and SOC24,
>>> so I’m not sure if you would consider it generic enough for such use.
>>>
>>> Regarding `read_indexed_register`, I’m still uncertain due to the use of
>>> the `RREG32` macro. From what I’ve seen so far, it appears to behave
>>> consistently across these implementations, but I may be missing some
>>> subtleties.
>>
>> You are correct.  the RREG32 and WREG32 macros are the same on all chips.
>>
>>>
>>> Also, when Christian mentioned “move them a layer up”, do you mean moving
>>> these helpers into an existing common file such as `amdgpu_device.c`
>>> instead of introducing a new file like `amdgpu_common.c/h`? I can rework
>>> the patch accordingly and drop the new files if that is the preferred
>>> approach.
>>
>> I think something like  amdgpu_common_helpers.c is fine, although
>> thinking about it more, I think the program_aspm() function should
>> probably end up in amdgpu_nbio.c as something like
>> amdgpu_nbio_program_aspm().  read_indexed_register() could probably go
>> in amdgpu_device.c as amdgpu_device_read_indexed_register_helper().
> 
> For the grbm register access one, consider keeping it in amdgpu_reg_access.c

Yeah I wanted to suggest something similar.

In general the driver code files are mostly organized like this:

* amdgpu_drv.[ch]	Code for the whole driver, e.g. module_init and co.
* amdgpu_device.[ch]	Code for a specific adev instance.
* amdgpu_$ip.[ch]	Code for this specific HW IP which is independent of the HW generation (e.g. amdgpu_sdma.c)
* $ip_$version.[ch]	Code for a specific IP in a specific HW generation (e.g. sdma_v6_0.c)
* $HW_gen.[ch]		Code for a specififc HW generation (e.g. cik.c or soc15.c....)
* $whatever.[ch]	Code for interfacing with kernel subsystem, feature, task, whatever (e.g. amdgpu_ttm.c, amdgpu_cs.c...)

So when you have some common functionality that should either go into amdgpu_device.c or amdgpu_$ip.[ch].

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>> And finally I'm not sure it's worth breaking out common_sw_init() as a
>> separate function.  Maybe drop that change.
>>
>> Alex
>>
>>>
>>> I can also incorporate Alex’s suggestions regarding naming and licensing.
>>>
>>> Given these points, I’d like to better understand which direction you
>>> would prefer for this change.
>>>
>>> Thanks again for your time and guidance.
>>>
>>> Best regards,
>>> Gabriel Almeida
>>>
>>>
>>> Em ter., 31 de mar. de 2026 às 10:31, Alex Deucher
>>> <alexdeucher@gmail.com> escreveu:
>>>>
>>>> On Tue, Mar 31, 2026 at 7:34 AM Christian König
>>>> <christian.koenig@amd.com> wrote:
>>>>>
>>>>> On 3/31/26 00:45, Gabriel Almeida wrote:
>>>>>> Some helper functions are implemented multiple times with identical
>>>>>> logic across different source files.
>>>>>
>>>>> And that is at least sometimes completely intentional.
>>>>>
>>>>> Background is that different headers are included which define macros with different values for each HW generation.
>>>>>
>>>>>>
>>>>>> Extract these implementations into a shared helper file
>>>>>> (amdgpu_common.c) and update existing code to reuse them.
>>>>>
>>>>> Please don't when they are functional identical then move them a layer up instead of messing up the backends.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> This simplifies the codebase and avoids duplication without
>>>>>> changing behavior.
>>>>>>
>>>>>> No functional changes intended.
>>>>>>
>>>>>> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile        |  2 ++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_common.c | 42 ++++++++++++++++++++++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_common.h | 12 +++++++
>>>>
>>>> I think amdgpu_common_helper.c/h would be better.
>>>>
>>>>>>   drivers/gpu/drm/amd/amdgpu/nv.c            | 38 +++-----------------
>>>>>>   drivers/gpu/drm/amd/amdgpu/soc15.c         | 31 ++--------------
>>>>>>   drivers/gpu/drm/amd/amdgpu/soc21.c         | 38 +++-----------------
>>>>>>   drivers/gpu/drm/amd/amdgpu/soc24.c         | 29 ++-------------
>>>>>>   drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      | 21 ++---------
>>>>>>   8 files changed, 72 insertions(+), 141 deletions(-)
>>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
>>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> index 6a7e9bfec..84cce03d7 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> @@ -69,6 +69,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>>>>>>          amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
>>>>>>          amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
>>>>>>
>>>>>> +amdgpu-y += amdgpu_common.o
>>>>>> +
>>>>>>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>>>>
>>>>>>   amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
>>>>>> new file mode 100644
>>>>>> index 000000000..34ade6f63
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
>>>>>> @@ -0,0 +1,42 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>
>>>> This should be MIT
>>>>
>>>>>> +#include <linux/module.h>
>>>>>> +
>>>>>> +#include "amdgpu.h"
>>>>>> +#include "amdgpu_common.h"
>>>>>> +#include "mxgpu_nv.h"
>>>>>> +
>>>>>> +uint32_t read_indexed_register(struct amdgpu_device *adev,
>>>>>> +                              u32 se_num, u32 sh_num, u32 reg_offset)
>>>>>> +{
>>>>>> +       uint32_t val;
>>>>>> +
>>>>>> +       mutex_lock(&adev->grbm_idx_mutex);
>>>>>> +       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>>> +
>>>>>> +       val = RREG32(reg_offset);
>>>>>> +
>>>>>> +       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>>> +       mutex_unlock(&adev->grbm_idx_mutex);
>>>>>> +       return val;
>>>>>> +}
>>>>>> +
>>>>>> +void program_aspm(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +       if (!amdgpu_device_should_use_aspm(adev))
>>>>>> +               return;
>>>>>> +
>>>>>> +       if (adev->nbio.funcs->program_aspm)
>>>>>> +               adev->nbio.funcs->program_aspm(adev);
>>>>>> +}
>>>>>> +
>>>>>> +int common_sw_init(struct amdgpu_ip_block *ip_block)
>>>>
>>>> Please prefix each of these functions with amdgpu_common_helper_
>>>>
>>>>>> +{
>>>>>> +       struct amdgpu_device *adev = ip_block->adev;
>>>>>> +
>>>>>> +       if (amdgpu_sriov_vf(adev))
>>>>>> +               xgpu_nv_mailbox_add_irq_id(adev);
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
>>>>>> new file mode 100644
>>>>>> index 000000000..314b3506b
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
>>>>>> @@ -0,0 +1,12 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>
>>>> This should be MIT
>>>>
>>>> Alex
>>>>
>>>>>> +#ifndef __AMDGPU_COMMON_H__
>>>>>> +#define __AMDGPU_COMMON_H__
>>>>>> +
>>>>>> +uint32_t read_indexed_register(struct amdgpu_device *adev,
>>>>>> +                              u32 se_num, u32 sh_num, u32 reg_offset);
>>>>>> +
>>>>>> +void program_aspm(struct amdgpu_device *adev);
>>>>>> +
>>>>>> +int common_sw_init(struct amdgpu_ip_block *ip_block);
>>>>>> +
>>>>>> +#endif
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>>> index 7ce1a1b95..cf8052c73 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>>> @@ -29,6 +29,7 @@
>>>>>>
>>>>>>   #include "amdgpu.h"
>>>>>>   #include "amdgpu_atombios.h"
>>>>>> +#include "amdgpu_common.h"
>>>>>>   #include "amdgpu_ih.h"
>>>>>>   #include "amdgpu_uvd.h"
>>>>>>   #include "amdgpu_vce.h"
>>>>>> @@ -354,29 +355,13 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
>>>>>>          { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
>>>>>>   };
>>>>>>
>>>>>> -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
>>>>>> -                                        u32 sh_num, u32 reg_offset)
>>>>>> -{
>>>>>> -       uint32_t val;
>>>>>> -
>>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>>> -
>>>>>> -       val = RREG32(reg_offset);
>>>>>> -
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>>> -       return val;
>>>>>> -}
>>>>>>
>>>>>>   static uint32_t nv_get_register_value(struct amdgpu_device *adev,
>>>>>>                                        bool indexed, u32 se_num,
>>>>>>                                        u32 sh_num, u32 reg_offset)
>>>>>>   {
>>>>>>          if (indexed) {
>>>>>> -               return nv_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>>          } else {
>>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
>>>>>>                          return adev->gfx.config.gb_addr_config;
>>>>>> @@ -511,16 +496,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
>>>>>>          return 0;
>>>>>>   }
>>>>>>
>>>>>> -static void nv_program_aspm(struct amdgpu_device *adev)
>>>>>> -{
>>>>>> -       if (!amdgpu_device_should_use_aspm(adev))
>>>>>> -               return;
>>>>>> -
>>>>>> -       if (adev->nbio.funcs->program_aspm)
>>>>>> -               adev->nbio.funcs->program_aspm(adev);
>>>>>> -
>>>>>> -}
>>>>>> -
>>>>>>   const struct amdgpu_ip_block_version nv_common_ip_block = {
>>>>>>          .type = AMD_IP_BLOCK_TYPE_COMMON,
>>>>>>          .major = 1,
>>>>>> @@ -965,12 +940,7 @@ static int nv_common_late_init(struct amdgpu_ip_block *ip_block)
>>>>>>
>>>>>>   static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>>   {
>>>>>> -       struct amdgpu_device *adev = ip_block->adev;
>>>>>> -
>>>>>> -       if (amdgpu_sriov_vf(adev))
>>>>>> -               xgpu_nv_mailbox_add_irq_id(adev);
>>>>>> -
>>>>>> -       return 0;
>>>>>> +       return common_sw_init(ip_block);
>>>>>>   }
>>>>>>
>>>>>>   static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>>> @@ -984,7 +954,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>>>                  adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
>>>>>>
>>>>>>          /* enable aspm */
>>>>>> -       nv_program_aspm(adev);
>>>>>> +       program_aspm(adev);
>>>>>>          /* setup nbio registers */
>>>>>>          adev->nbio.funcs->init_registers(adev);
>>>>>>          /* remap HDP registers to a hole in mmio space,
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>> index b456e4541..a6b91363d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>> @@ -28,6 +28,7 @@
>>>>>>   #include <drm/amdgpu_drm.h>
>>>>>>
>>>>>>   #include "amdgpu.h"
>>>>>> +#include "amdgpu_common.h"
>>>>>>   #include "amdgpu_ih.h"
>>>>>>   #include "amdgpu_uvd.h"
>>>>>>   #include "amdgpu_vce.h"
>>>>>> @@ -401,29 +402,12 @@ static struct soc15_allowed_register_entry soc15_allowed_read_registers[] = {
>>>>>>          { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
>>>>>>   };
>>>>>>
>>>>>> -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
>>>>>> -                                        u32 sh_num, u32 reg_offset)
>>>>>> -{
>>>>>> -       uint32_t val;
>>>>>> -
>>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>>> -
>>>>>> -       val = RREG32(reg_offset);
>>>>>> -
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>>> -       return val;
>>>>>> -}
>>>>>> -
>>>>>>   static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
>>>>>>                                           bool indexed, u32 se_num,
>>>>>>                                           u32 sh_num, u32 reg_offset)
>>>>>>   {
>>>>>>          if (indexed) {
>>>>>> -               return soc15_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>>          } else {
>>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
>>>>>>                          return adev->gfx.config.gb_addr_config;
>>>>>> @@ -695,15 +679,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
>>>>>>          return 0;
>>>>>>   }
>>>>>>
>>>>>> -static void soc15_program_aspm(struct amdgpu_device *adev)
>>>>>> -{
>>>>>> -       if (!amdgpu_device_should_use_aspm(adev))
>>>>>> -               return;
>>>>>> -
>>>>>> -       if (adev->nbio.funcs->program_aspm)
>>>>>> -               adev->nbio.funcs->program_aspm(adev);
>>>>>> -}
>>>>>> -
>>>>>>   const struct amdgpu_ip_block_version vega10_common_ip_block =
>>>>>>   {
>>>>>>          .type = AMD_IP_BLOCK_TYPE_COMMON,
>>>>>> @@ -1284,7 +1259,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>>>          struct amdgpu_device *adev = ip_block->adev;
>>>>>>
>>>>>>          /* enable aspm */
>>>>>> -       soc15_program_aspm(adev);
>>>>>> +       program_aspm(adev);
>>>>>>          /* setup nbio registers */
>>>>>>          adev->nbio.funcs->init_registers(adev);
>>>>>>          /* remap HDP registers to a hole in mmio space,
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>> index fbd1d97f3..586d62202 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>> @@ -27,6 +27,7 @@
>>>>>>
>>>>>>   #include "amdgpu.h"
>>>>>>   #include "amdgpu_atombios.h"
>>>>>> +#include "amdgpu_common.h"
>>>>>>   #include "amdgpu_ih.h"
>>>>>>   #include "amdgpu_uvd.h"
>>>>>>   #include "amdgpu_vce.h"
>>>>>> @@ -306,29 +307,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
>>>>>>          { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>>>>>>   };
>>>>>>
>>>>>> -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
>>>>>> -                                        u32 sh_num, u32 reg_offset)
>>>>>> -{
>>>>>> -       uint32_t val;
>>>>>> -
>>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>>> -
>>>>>> -       val = RREG32(reg_offset);
>>>>>> -
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>>> -       return val;
>>>>>> -}
>>>>>> -
>>>>>>   static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
>>>>>>                                        bool indexed, u32 se_num,
>>>>>>                                        u32 sh_num, u32 reg_offset)
>>>>>>   {
>>>>>>          if (indexed) {
>>>>>> -               return soc21_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>>          } else {
>>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) && adev->gfx.config.gb_addr_config)
>>>>>>                          return adev->gfx.config.gb_addr_config;
>>>>>> @@ -470,15 +454,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
>>>>>>          return 0;
>>>>>>   }
>>>>>>
>>>>>> -static void soc21_program_aspm(struct amdgpu_device *adev)
>>>>>> -{
>>>>>> -       if (!amdgpu_device_should_use_aspm(adev))
>>>>>> -               return;
>>>>>> -
>>>>>> -       if (adev->nbio.funcs->program_aspm)
>>>>>> -               adev->nbio.funcs->program_aspm(adev);
>>>>>> -}
>>>>>> -
>>>>>>   const struct amdgpu_ip_block_version soc21_common_ip_block = {
>>>>>>          .type = AMD_IP_BLOCK_TYPE_COMMON,
>>>>>>          .major = 1,
>>>>>> @@ -912,12 +887,7 @@ static int soc21_common_late_init(struct amdgpu_ip_block *ip_block)
>>>>>>
>>>>>>   static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>>   {
>>>>>> -       struct amdgpu_device *adev = ip_block->adev;
>>>>>> -
>>>>>> -       if (amdgpu_sriov_vf(adev))
>>>>>> -               xgpu_nv_mailbox_add_irq_id(adev);
>>>>>> -
>>>>>> -       return 0;
>>>>>> +       return common_sw_init(ip_block);
>>>>>>   }
>>>>>>
>>>>>>   static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>>> @@ -925,7 +895,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>>>          struct amdgpu_device *adev = ip_block->adev;
>>>>>>
>>>>>>          /* enable aspm */
>>>>>> -       soc21_program_aspm(adev);
>>>>>> +       program_aspm(adev);
>>>>>>          /* setup nbio registers */
>>>>>>          adev->nbio.funcs->init_registers(adev);
>>>>>>          /* remap HDP registers to a hole in mmio space,
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
>>>>>> index d1adf19a5..f9341c0e4 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
>>>>>> @@ -26,6 +26,7 @@
>>>>>>   #include <linux/pci.h>
>>>>>>
>>>>>>   #include "amdgpu.h"
>>>>>> +#include "amdgpu_common.h"
>>>>>>   #include "amdgpu_ih.h"
>>>>>>   #include "amdgpu_uvd.h"
>>>>>>   #include "amdgpu_vce.h"
>>>>>> @@ -132,31 +133,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
>>>>>>          { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>>>>>>   };
>>>>>>
>>>>>> -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
>>>>>> -                                           u32 se_num,
>>>>>> -                                           u32 sh_num,
>>>>>> -                                           u32 reg_offset)
>>>>>> -{
>>>>>> -       uint32_t val;
>>>>>> -
>>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>>> -
>>>>>> -       val = RREG32(reg_offset);
>>>>>> -
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>>> -       return val;
>>>>>> -}
>>>>>> -
>>>>>>   static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
>>>>>>                                           bool indexed, u32 se_num,
>>>>>>                                           u32 sh_num, u32 reg_offset)
>>>>>>   {
>>>>>>          if (indexed) {
>>>>>> -               return soc24_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>>          } else {
>>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) &&
>>>>>>                      adev->gfx.config.gb_addr_config)
>>>>>> @@ -455,12 +437,7 @@ static int soc24_common_late_init(struct amdgpu_ip_block *ip_block)
>>>>>>
>>>>>>   static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>>   {
>>>>>> -       struct amdgpu_device *adev = ip_block->adev;
>>>>>> -
>>>>>> -       if (amdgpu_sriov_vf(adev))
>>>>>> -               xgpu_nv_mailbox_add_irq_id(adev);
>>>>>> -
>>>>>> -       return 0;
>>>>>> +       return common_sw_init(ip_block);
>>>>>>   }
>>>>>>
>>>>>>   static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>>>>>> index 709b1669b..2f77fb0b6 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>>>>>> @@ -21,6 +21,7 @@
>>>>>>    *
>>>>>>    */
>>>>>>   #include "amdgpu.h"
>>>>>> +#include "amdgpu_common.h"
>>>>>>   #include "soc15.h"
>>>>>>   #include "soc15_common.h"
>>>>>>   #include "soc_v1_0.h"
>>>>>> @@ -184,31 +185,13 @@ static struct soc15_allowed_register_entry soc_v1_0_allowed_read_registers[] = {
>>>>>>          { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
>>>>>>   };
>>>>>>
>>>>>> -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *adev,
>>>>>> -                                              u32 se_num,
>>>>>> -                                              u32 sh_num,
>>>>>> -                                              u32 reg_offset)
>>>>>> -{
>>>>>> -       uint32_t val;
>>>>>> -
>>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>>> -
>>>>>> -       val = RREG32(reg_offset);
>>>>>> -
>>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>>> -       return val;
>>>>>> -}
>>>>>>
>>>>>>   static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev,
>>>>>>                                              bool indexed, u32 se_num,
>>>>>>                                              u32 sh_num, u32 reg_offset)
>>>>>>   {
>>>>>>          if (indexed) {
>>>>>> -               return soc_v1_0_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>>          } else {
>>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG_1) &&
>>>>>>                      adev->gfx.config.gb_addr_config)
>>>>>> -- 
>>>>>> 2.43.0
>>>>>>
>>>>>
> 

