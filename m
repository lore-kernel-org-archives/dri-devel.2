Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC348D35144
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C0610ED28;
	Wed,  1 Apr 2026 06:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aCST89Q0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C87410EC45;
 Wed,  1 Apr 2026 06:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cERja+nDBbLAT8Omg0I4v62s9shOG3Pq0DeAzVqdTekh1vTZOSRba6nuLZymldPmhszZrBsW6cJhMUfLGH6mB6iEjZbZFXv2yGId/XDE2Y6RY6Zd1wwwTV5YWndjoUmc+Wa5nndD9XqJaVa9xpChP8lAJ2XrIiCcz5ZcwyFK8s/dJhV++3tIJ/V8JmuvyLsuN3D4Hs9crP7aXnm8Y2sxGOM8fWuvyE28Ur9BgcEqAgJruBbvjt3HMsbKqDXbeAH+SWFNIuQbbVmK2tTMycyr1oTCa8rv7xSls6pxihc/S37d10S7sPNnvfZuESv7MpKv+3P6/iWOpJ8zFwAKG4uVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQTw2PINn5BlyXaIFgRSway5r0aHy1OSYZYRYdiT5Hs=;
 b=mWfmgS0Vh9lT7914VHHc7oiCHeSySWm+r/lGwjv6BdBRwW5FVBtQeQO8SQPhoSZEzW11kJoq9Eruola01NeouyrmT+rJmd9X4g7IaKjHz6H/mbB202lXqj5LERVdUZyBWx6XT3qAdJfRwJxXJcu1h1jrZikloCJYxorsm1sZIHQH87xDBuWMK3uiD/4uC9D2bW4LwGcMBv9gFAMI238dAL3Ce37NMS7Dxvwg41zNaQBj5u7XXG1YeRudDU8FLrnNUita9ITrEiNaxi5jHm8mHQd5tVtvVnFWYrWnZp5cwmPrUG56hNcpP7CrBoOEQ824ftI5tA8zqRyUYMwK/Wp6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQTw2PINn5BlyXaIFgRSway5r0aHy1OSYZYRYdiT5Hs=;
 b=aCST89Q0wwZINbE2gt1BGc8UCLdjKXYdPwF5mKbObYeKbX7kP/c0KXao7jVrVc3pHTvw3Ck4U4WZl8ZPTrZPbOoiL8+fzUIsnOR/EQXgi3m4cRIwbWnnNZzCL9Oto9sioMN01oYd4cggx9HqzSKBsq87eTVv8r+zPSy0paDP6J0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Wed, 1 Apr
 2026 06:58:17 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 06:58:17 +0000
Message-ID: <11e4daaa-0f1e-4fd4-b435-d2fa9d058869@amd.com>
Date: Wed, 1 Apr 2026 12:28:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: deduplicate register access and helper
 routines
To: Alex Deucher <alexdeucher@gmail.com>,
 Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260330224503.548284-1-gabrielsousa230@gmail.com>
 <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
 <CADnq5_N6bzHTQJjS6__-Fmp15fASUw3C5DG1uNvZgkxCRtFkcw@mail.gmail.com>
 <CALsHKmUeB3=H9=Nq=+jOvtmwXxSg=wtHrASZNvVVPQwpyem2ug@mail.gmail.com>
 <CADnq5_Pf841oeJAwhLp=1Y_tOWmEX+gyhDW06Z=qr+FR4x4JEw@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_Pf841oeJAwhLp=1Y_tOWmEX+gyhDW06Z=qr+FR4x4JEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fffe23-d40a-4f29-3b9f-08de8fbc0cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: CtN2Md/Ur7C+tfrmA2SXNJ2SXY4tPAqWO6+vSAZ9eapUEdVXqWn3UAxIBgBK58ZzXYRJX7wYtVn82IpuJ+ID9Qsc3RvM7chwRe/MtyUFfA2zzyOSu1mqYZRigqQxkz7jfVf4pMUJqYBU8xO+CesY6eUMHVtZnw3gXnn43f5aTOdGXRNEtvvMaXQikX83Uvh2S7OK9IDk9YgN8MZlNZTNw7f3Hxo5p6GJNA026WlGVLxnbWDBP0bVAamEEcHRVzKxJHAIZf5kHibQ0GUIXupUYRCjnOUlcLc5krfjx0J4sS8yEJsS1Symd/aP6/jVD7cBjQowHuS74iFXF93TNPmlSaesDN6c+XqxglfvrmnC2014nWWIofVGWB+tQmcrXvpudTkYoyrIybGrgTOR5FfJ+bUvSdxGtDHRNU8H5sVGW7aRWIhszZCZIr5gOlnDOPM4zEkxEBnOHNhseXPo0CrbsfrYuQ6a/EldWfw76wtIDBsgYJAeUgF8Okf0rrTlpiv+MomSDJWlXGTalJuIfVnbcw4q4lIWMKTiqJPoQc7/GBWypqyMHSKCqL0qFFt411Vndu0whrY4T9ZgZDIKkAAAeJUlxCJ48XDLfguy/q5qISd+iF157UwXA8WGMj6FOWb5PzN8i8r3xkYdhfQip4zzj2vj+zp0ny//ACZ8Y4PBwhzrco9Ght540HyGMDIRwpvt7V03SubRgAKs4BSY2AezMC6mDMSG/Zt1G9IyHXnK0nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUdkNGtGZjlrNnpBRFIycVZJVlpReFJ2Y3ErOS9mb2QwR2dvT011YzNTU3dP?=
 =?utf-8?B?NmNkbG1vRncrbXlHZjVZUFo3b2pMZWMzbHY0UlJCbTR3V29GVFA3N0VSYml1?=
 =?utf-8?B?eDhXZmRpWFUrc0drbDg5aEYzODNRaHh0aGM1YTQzMkxWYzhUWW1paEJzZ2Ir?=
 =?utf-8?B?eEVhN1ZlQ1dHam5RRzZVUWZpZUdOdzlSaXQ4eWRKOVFoZWJSRWJwbDNUVTVG?=
 =?utf-8?B?WlpCOG9HbWc1MU0wR0NtdUsrS3AvN0JzL1d3MHQvOEo4THIxVGQwRXA3ZVhm?=
 =?utf-8?B?QUs0MXl3OSs0UVFxeE1GMlZYMlUyMzN0NlFvK1grQWt5RmtvbXZabDJYSUNn?=
 =?utf-8?B?eTZtMmZCSFBkRE15UXVyNXNQdFg2a3RzMFAzNHV2MkR5Z3BCNEN6bzBpNklr?=
 =?utf-8?B?N1YxUkdLVWlNaHVJL2VoMVpubzhuZjNLQXU5WFg0ZVhZaGJGTGpWdk1DMFRF?=
 =?utf-8?B?TzBuRDIyZDdtR20yWHM0T01jTGNsYVIvNUNuZDFwL2s0WjZlWGJLZ0lpMGM3?=
 =?utf-8?B?bjNjc3BtUzdvSDBqRHg3c1BTam1mM2RsQW43UXVjdUdZb3M5emNHeTVxL0lu?=
 =?utf-8?B?SUFWMmxsYUxSVjI2Q0hYYWZjMTFKbFVrMlNRVXBkR2UxZUJrQmJEVkdzdmdq?=
 =?utf-8?B?VzM5Z0l5aFZybWZnY3pXUDRnbnNML0htWFdvc0pjVW5ldnZXL0FETUtPSkZT?=
 =?utf-8?B?Nkt6RG5jY1Izd3k5NWZXZGI4czJsTkVpN3I1TUNzMllWanJOcU8zNWJXNkts?=
 =?utf-8?B?V3g0WlBsUWllK3RpSmZGK1lrbnAvSUdveDZmWk4zU2I5NWhhdEl6VTNiMUFa?=
 =?utf-8?B?UDVaenVTY1h1bWF6ZjR2b2pvY2VIRk15WHdBd1FtVVlwWWM5MTZkUzVJZHZ0?=
 =?utf-8?B?UFBJaVZsdDVGcDFHWXVOQk45dUZSa1lPc2oydEFKM1dOOXo2MHdjTVl4TE9p?=
 =?utf-8?B?bUpGZTk2Q3VyN3p4SlNXcUNEUEtlUXlqVHY4UDlSaGNOSkMxejFlQ3E2eWpL?=
 =?utf-8?B?b0J2dVp5b08reDhZSjZFME9lM0tyQ3llTDg1bklCRmt5eWNCTVp1VjVacnJN?=
 =?utf-8?B?dmlHNzNuQ0syU05jRTNxRVloa0FUYWp0RUJ0bGorOE5tQXNnZ0VoYXNmNFdG?=
 =?utf-8?B?b1JZdzZaTWo5VXg5QnE1K0FkY2dTK3ZFaWdSa2MwSE9PMndXSnNFTm5XbW5h?=
 =?utf-8?B?eFltWXJoRDJFYzVTSmhRbE1MRXN4ekliN2E3a1F5OXEwUHRJYnErSDYvRGVS?=
 =?utf-8?B?cERHeTh5ZWpJWDVwMUlnbmtMbFFFYTNoeExnWGFQdmxBckc5ejQvNEtZU2N3?=
 =?utf-8?B?QXdlTFhjTWxQZGVrQzNmcDZpeUIrNktKckxnVVRoYXNFYjhkMWpSVCt6SXBk?=
 =?utf-8?B?Y3lyNHBxVGNqYXovS1c4WVVGT1JJUlhGS3FBTzRjNmw2UkZjYnEvbmdYQUVt?=
 =?utf-8?B?YTZwQ2xjMVhpZndVSGNoUTVmeXNPOXF5eTBPRFdHMlpoQnNNQnExb2ZzNkNm?=
 =?utf-8?B?NHI4ditXVjh6cDJ5eGdEcmVuR1U4eHptU3NiN2xJNDRpOTFiSEJOWTRsZDA4?=
 =?utf-8?B?dWRtNXpjblJEcUhBYmhGbUxQNHFWeDRvWU8rZW9GZldRdndxcldwUE5ZZW8z?=
 =?utf-8?B?MUFlbW9JdjMyQzlOY1luYVlUV21qb2wwNENFMXBkWGRTb2hjMHhQWXpmS2JF?=
 =?utf-8?B?dE91TXp0WDhWVkMzZUFhRUNRUDlMaUdjbkJQRXViNUlQVUZDYlFNQlJTdG9D?=
 =?utf-8?B?MXdFcWZ6K2xXM1FGcXNkVXJmZWhLTjNWdFoxVW0xcnJwYzJFd0RyMDl4RytD?=
 =?utf-8?B?Z3dqbXBNU0dmc3hRaDZMWCthNUNGdkFWT0JRYjA1MFVObGpIZXNNK0dmdWRM?=
 =?utf-8?B?Nzh4alVaWkVoemo5WFpvTHYrZExRQnFVNHN6NFpLeU44d0NFV09NaUM3dFZh?=
 =?utf-8?B?Q0NRQSt3bFhSWXFvNmlnTHlDYk1jUVZlcFdnSEUvemJ6RFliM1kya0hNRlNT?=
 =?utf-8?B?ZjVhNXFyQStwcmZYaW0wWk0wL3lkUjNCMG5YbXEyR0J5NlYvWTFrWTNFdU0x?=
 =?utf-8?B?RkZCY2NXSkNsR256ODZxSDRXQlF3S1pHU0l2aUQyK05CRlZJT2ZoL0cwQ082?=
 =?utf-8?B?R3owUnpHQUtnYnZKYk92ellMMHFKQWZTM3MvUXJ2L2xQU240cXpqdVlGU3Uv?=
 =?utf-8?B?alIvUnlWL0dNNGdXdHd2eHVrd1M3VEFvWGFrSnF0R1lUdU11Mm9OOVltdG51?=
 =?utf-8?B?YmxzclNldkhVNWVkOXBETHdPNjZiTldLRSsyVDAvRi9aSE51V2JIWmxtR1Uv?=
 =?utf-8?B?MEJvRTJkREtpMGhMbk5USzEwd1BLdFV3RkZDVGdvVSttdWxGQ1Z5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fffe23-d40a-4f29-3b9f-08de8fbc0cdf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:58:16.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WdyLxIl7Mg8+RdIiDD5PI+YSxAhWtdAzeR6576lzWSLnaCqCT4L/4TIHsbKiI1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931
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



On 01-Apr-26 2:51 AM, Alex Deucher wrote:
> On Tue, Mar 31, 2026 at 5:07 PM Gabriel Almeida
> <gabrielsousa230@gmail.com> wrote:
>>
>> Hi Christian and Alex,
>>
>> Thank you both for your feedback.
>>
>> I understand that there can be differences between these functions due to
>> different macro values across hardware generations. I admit that I didn’t
>> fully take that into account in this patch.
>>
>> Among the functions I modified, `program_aspm` and `common_sw_init` seem
>> to have identical behavior regardless of those macros, so I thought they
>> could be good candidates for shared helper functions. That said,
>> `common_sw_init` is currently only identical across NV, SOC21 and SOC24,
>> so I’m not sure if you would consider it generic enough for such use.
>>
>> Regarding `read_indexed_register`, I’m still uncertain due to the use of
>> the `RREG32` macro. From what I’ve seen so far, it appears to behave
>> consistently across these implementations, but I may be missing some
>> subtleties.
> 
> You are correct.  the RREG32 and WREG32 macros are the same on all chips.
> 
>>
>> Also, when Christian mentioned “move them a layer up”, do you mean moving
>> these helpers into an existing common file such as `amdgpu_device.c`
>> instead of introducing a new file like `amdgpu_common.c/h`? I can rework
>> the patch accordingly and drop the new files if that is the preferred
>> approach.
> 
> I think something like  amdgpu_common_helpers.c is fine, although
> thinking about it more, I think the program_aspm() function should
> probably end up in amdgpu_nbio.c as something like
> amdgpu_nbio_program_aspm().  read_indexed_register() could probably go
> in amdgpu_device.c as amdgpu_device_read_indexed_register_helper().

For the grbm register access one, consider keeping it in amdgpu_reg_access.c

Thanks,
Lijo

> And finally I'm not sure it's worth breaking out common_sw_init() as a
> separate function.  Maybe drop that change.
> 
> Alex
> 
>>
>> I can also incorporate Alex’s suggestions regarding naming and licensing.
>>
>> Given these points, I’d like to better understand which direction you
>> would prefer for this change.
>>
>> Thanks again for your time and guidance.
>>
>> Best regards,
>> Gabriel Almeida
>>
>>
>> Em ter., 31 de mar. de 2026 às 10:31, Alex Deucher
>> <alexdeucher@gmail.com> escreveu:
>>>
>>> On Tue, Mar 31, 2026 at 7:34 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> On 3/31/26 00:45, Gabriel Almeida wrote:
>>>>> Some helper functions are implemented multiple times with identical
>>>>> logic across different source files.
>>>>
>>>> And that is at least sometimes completely intentional.
>>>>
>>>> Background is that different headers are included which define macros with different values for each HW generation.
>>>>
>>>>>
>>>>> Extract these implementations into a shared helper file
>>>>> (amdgpu_common.c) and update existing code to reuse them.
>>>>
>>>> Please don't when they are functional identical then move them a layer up instead of messing up the backends.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> This simplifies the codebase and avoids duplication without
>>>>> changing behavior.
>>>>>
>>>>> No functional changes intended.
>>>>>
>>>>> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile        |  2 ++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_common.c | 42 ++++++++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_common.h | 12 +++++++
>>>
>>> I think amdgpu_common_helper.c/h would be better.
>>>
>>>>>   drivers/gpu/drm/amd/amdgpu/nv.c            | 38 +++-----------------
>>>>>   drivers/gpu/drm/amd/amdgpu/soc15.c         | 31 ++--------------
>>>>>   drivers/gpu/drm/amd/amdgpu/soc21.c         | 38 +++-----------------
>>>>>   drivers/gpu/drm/amd/amdgpu/soc24.c         | 29 ++-------------
>>>>>   drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      | 21 ++---------
>>>>>   8 files changed, 72 insertions(+), 141 deletions(-)
>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>> index 6a7e9bfec..84cce03d7 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>> @@ -69,6 +69,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>>>>>          amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
>>>>>          amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
>>>>>
>>>>> +amdgpu-y += amdgpu_common.o
>>>>> +
>>>>>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>>>
>>>>>   amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
>>>>> new file mode 100644
>>>>> index 000000000..34ade6f63
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
>>>>> @@ -0,0 +1,42 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>
>>> This should be MIT
>>>
>>>>> +#include <linux/module.h>
>>>>> +
>>>>> +#include "amdgpu.h"
>>>>> +#include "amdgpu_common.h"
>>>>> +#include "mxgpu_nv.h"
>>>>> +
>>>>> +uint32_t read_indexed_register(struct amdgpu_device *adev,
>>>>> +                              u32 se_num, u32 sh_num, u32 reg_offset)
>>>>> +{
>>>>> +       uint32_t val;
>>>>> +
>>>>> +       mutex_lock(&adev->grbm_idx_mutex);
>>>>> +       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>> +
>>>>> +       val = RREG32(reg_offset);
>>>>> +
>>>>> +       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>> +       mutex_unlock(&adev->grbm_idx_mutex);
>>>>> +       return val;
>>>>> +}
>>>>> +
>>>>> +void program_aspm(struct amdgpu_device *adev)
>>>>> +{
>>>>> +       if (!amdgpu_device_should_use_aspm(adev))
>>>>> +               return;
>>>>> +
>>>>> +       if (adev->nbio.funcs->program_aspm)
>>>>> +               adev->nbio.funcs->program_aspm(adev);
>>>>> +}
>>>>> +
>>>>> +int common_sw_init(struct amdgpu_ip_block *ip_block)
>>>
>>> Please prefix each of these functions with amdgpu_common_helper_
>>>
>>>>> +{
>>>>> +       struct amdgpu_device *adev = ip_block->adev;
>>>>> +
>>>>> +       if (amdgpu_sriov_vf(adev))
>>>>> +               xgpu_nv_mailbox_add_irq_id(adev);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
>>>>> new file mode 100644
>>>>> index 000000000..314b3506b
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
>>>>> @@ -0,0 +1,12 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>
>>> This should be MIT
>>>
>>> Alex
>>>
>>>>> +#ifndef __AMDGPU_COMMON_H__
>>>>> +#define __AMDGPU_COMMON_H__
>>>>> +
>>>>> +uint32_t read_indexed_register(struct amdgpu_device *adev,
>>>>> +                              u32 se_num, u32 sh_num, u32 reg_offset);
>>>>> +
>>>>> +void program_aspm(struct amdgpu_device *adev);
>>>>> +
>>>>> +int common_sw_init(struct amdgpu_ip_block *ip_block);
>>>>> +
>>>>> +#endif
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>> index 7ce1a1b95..cf8052c73 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>> @@ -29,6 +29,7 @@
>>>>>
>>>>>   #include "amdgpu.h"
>>>>>   #include "amdgpu_atombios.h"
>>>>> +#include "amdgpu_common.h"
>>>>>   #include "amdgpu_ih.h"
>>>>>   #include "amdgpu_uvd.h"
>>>>>   #include "amdgpu_vce.h"
>>>>> @@ -354,29 +355,13 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
>>>>>          { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
>>>>>   };
>>>>>
>>>>> -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
>>>>> -                                        u32 sh_num, u32 reg_offset)
>>>>> -{
>>>>> -       uint32_t val;
>>>>> -
>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>> -
>>>>> -       val = RREG32(reg_offset);
>>>>> -
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>> -       return val;
>>>>> -}
>>>>>
>>>>>   static uint32_t nv_get_register_value(struct amdgpu_device *adev,
>>>>>                                        bool indexed, u32 se_num,
>>>>>                                        u32 sh_num, u32 reg_offset)
>>>>>   {
>>>>>          if (indexed) {
>>>>> -               return nv_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>          } else {
>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
>>>>>                          return adev->gfx.config.gb_addr_config;
>>>>> @@ -511,16 +496,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> -static void nv_program_aspm(struct amdgpu_device *adev)
>>>>> -{
>>>>> -       if (!amdgpu_device_should_use_aspm(adev))
>>>>> -               return;
>>>>> -
>>>>> -       if (adev->nbio.funcs->program_aspm)
>>>>> -               adev->nbio.funcs->program_aspm(adev);
>>>>> -
>>>>> -}
>>>>> -
>>>>>   const struct amdgpu_ip_block_version nv_common_ip_block = {
>>>>>          .type = AMD_IP_BLOCK_TYPE_COMMON,
>>>>>          .major = 1,
>>>>> @@ -965,12 +940,7 @@ static int nv_common_late_init(struct amdgpu_ip_block *ip_block)
>>>>>
>>>>>   static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>   {
>>>>> -       struct amdgpu_device *adev = ip_block->adev;
>>>>> -
>>>>> -       if (amdgpu_sriov_vf(adev))
>>>>> -               xgpu_nv_mailbox_add_irq_id(adev);
>>>>> -
>>>>> -       return 0;
>>>>> +       return common_sw_init(ip_block);
>>>>>   }
>>>>>
>>>>>   static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>> @@ -984,7 +954,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>>                  adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
>>>>>
>>>>>          /* enable aspm */
>>>>> -       nv_program_aspm(adev);
>>>>> +       program_aspm(adev);
>>>>>          /* setup nbio registers */
>>>>>          adev->nbio.funcs->init_registers(adev);
>>>>>          /* remap HDP registers to a hole in mmio space,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> index b456e4541..a6b91363d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> @@ -28,6 +28,7 @@
>>>>>   #include <drm/amdgpu_drm.h>
>>>>>
>>>>>   #include "amdgpu.h"
>>>>> +#include "amdgpu_common.h"
>>>>>   #include "amdgpu_ih.h"
>>>>>   #include "amdgpu_uvd.h"
>>>>>   #include "amdgpu_vce.h"
>>>>> @@ -401,29 +402,12 @@ static struct soc15_allowed_register_entry soc15_allowed_read_registers[] = {
>>>>>          { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
>>>>>   };
>>>>>
>>>>> -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
>>>>> -                                        u32 sh_num, u32 reg_offset)
>>>>> -{
>>>>> -       uint32_t val;
>>>>> -
>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>> -
>>>>> -       val = RREG32(reg_offset);
>>>>> -
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>> -       return val;
>>>>> -}
>>>>> -
>>>>>   static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
>>>>>                                           bool indexed, u32 se_num,
>>>>>                                           u32 sh_num, u32 reg_offset)
>>>>>   {
>>>>>          if (indexed) {
>>>>> -               return soc15_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>          } else {
>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
>>>>>                          return adev->gfx.config.gb_addr_config;
>>>>> @@ -695,15 +679,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> -static void soc15_program_aspm(struct amdgpu_device *adev)
>>>>> -{
>>>>> -       if (!amdgpu_device_should_use_aspm(adev))
>>>>> -               return;
>>>>> -
>>>>> -       if (adev->nbio.funcs->program_aspm)
>>>>> -               adev->nbio.funcs->program_aspm(adev);
>>>>> -}
>>>>> -
>>>>>   const struct amdgpu_ip_block_version vega10_common_ip_block =
>>>>>   {
>>>>>          .type = AMD_IP_BLOCK_TYPE_COMMON,
>>>>> @@ -1284,7 +1259,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>>          struct amdgpu_device *adev = ip_block->adev;
>>>>>
>>>>>          /* enable aspm */
>>>>> -       soc15_program_aspm(adev);
>>>>> +       program_aspm(adev);
>>>>>          /* setup nbio registers */
>>>>>          adev->nbio.funcs->init_registers(adev);
>>>>>          /* remap HDP registers to a hole in mmio space,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>> index fbd1d97f3..586d62202 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>> @@ -27,6 +27,7 @@
>>>>>
>>>>>   #include "amdgpu.h"
>>>>>   #include "amdgpu_atombios.h"
>>>>> +#include "amdgpu_common.h"
>>>>>   #include "amdgpu_ih.h"
>>>>>   #include "amdgpu_uvd.h"
>>>>>   #include "amdgpu_vce.h"
>>>>> @@ -306,29 +307,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
>>>>>          { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>>>>>   };
>>>>>
>>>>> -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
>>>>> -                                        u32 sh_num, u32 reg_offset)
>>>>> -{
>>>>> -       uint32_t val;
>>>>> -
>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>> -
>>>>> -       val = RREG32(reg_offset);
>>>>> -
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>> -       return val;
>>>>> -}
>>>>> -
>>>>>   static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
>>>>>                                        bool indexed, u32 se_num,
>>>>>                                        u32 sh_num, u32 reg_offset)
>>>>>   {
>>>>>          if (indexed) {
>>>>> -               return soc21_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>          } else {
>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) && adev->gfx.config.gb_addr_config)
>>>>>                          return adev->gfx.config.gb_addr_config;
>>>>> @@ -470,15 +454,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> -static void soc21_program_aspm(struct amdgpu_device *adev)
>>>>> -{
>>>>> -       if (!amdgpu_device_should_use_aspm(adev))
>>>>> -               return;
>>>>> -
>>>>> -       if (adev->nbio.funcs->program_aspm)
>>>>> -               adev->nbio.funcs->program_aspm(adev);
>>>>> -}
>>>>> -
>>>>>   const struct amdgpu_ip_block_version soc21_common_ip_block = {
>>>>>          .type = AMD_IP_BLOCK_TYPE_COMMON,
>>>>>          .major = 1,
>>>>> @@ -912,12 +887,7 @@ static int soc21_common_late_init(struct amdgpu_ip_block *ip_block)
>>>>>
>>>>>   static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>   {
>>>>> -       struct amdgpu_device *adev = ip_block->adev;
>>>>> -
>>>>> -       if (amdgpu_sriov_vf(adev))
>>>>> -               xgpu_nv_mailbox_add_irq_id(adev);
>>>>> -
>>>>> -       return 0;
>>>>> +       return common_sw_init(ip_block);
>>>>>   }
>>>>>
>>>>>   static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>> @@ -925,7 +895,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>>          struct amdgpu_device *adev = ip_block->adev;
>>>>>
>>>>>          /* enable aspm */
>>>>> -       soc21_program_aspm(adev);
>>>>> +       program_aspm(adev);
>>>>>          /* setup nbio registers */
>>>>>          adev->nbio.funcs->init_registers(adev);
>>>>>          /* remap HDP registers to a hole in mmio space,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
>>>>> index d1adf19a5..f9341c0e4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
>>>>> @@ -26,6 +26,7 @@
>>>>>   #include <linux/pci.h>
>>>>>
>>>>>   #include "amdgpu.h"
>>>>> +#include "amdgpu_common.h"
>>>>>   #include "amdgpu_ih.h"
>>>>>   #include "amdgpu_uvd.h"
>>>>>   #include "amdgpu_vce.h"
>>>>> @@ -132,31 +133,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
>>>>>          { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>>>>>   };
>>>>>
>>>>> -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
>>>>> -                                           u32 se_num,
>>>>> -                                           u32 sh_num,
>>>>> -                                           u32 reg_offset)
>>>>> -{
>>>>> -       uint32_t val;
>>>>> -
>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>> -
>>>>> -       val = RREG32(reg_offset);
>>>>> -
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>> -       return val;
>>>>> -}
>>>>> -
>>>>>   static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
>>>>>                                           bool indexed, u32 se_num,
>>>>>                                           u32 sh_num, u32 reg_offset)
>>>>>   {
>>>>>          if (indexed) {
>>>>> -               return soc24_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>          } else {
>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) &&
>>>>>                      adev->gfx.config.gb_addr_config)
>>>>> @@ -455,12 +437,7 @@ static int soc24_common_late_init(struct amdgpu_ip_block *ip_block)
>>>>>
>>>>>   static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>   {
>>>>> -       struct amdgpu_device *adev = ip_block->adev;
>>>>> -
>>>>> -       if (amdgpu_sriov_vf(adev))
>>>>> -               xgpu_nv_mailbox_add_irq_id(adev);
>>>>> -
>>>>> -       return 0;
>>>>> +       return common_sw_init(ip_block);
>>>>>   }
>>>>>
>>>>>   static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>>>>> index 709b1669b..2f77fb0b6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>>>>> @@ -21,6 +21,7 @@
>>>>>    *
>>>>>    */
>>>>>   #include "amdgpu.h"
>>>>> +#include "amdgpu_common.h"
>>>>>   #include "soc15.h"
>>>>>   #include "soc15_common.h"
>>>>>   #include "soc_v1_0.h"
>>>>> @@ -184,31 +185,13 @@ static struct soc15_allowed_register_entry soc_v1_0_allowed_read_registers[] = {
>>>>>          { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
>>>>>   };
>>>>>
>>>>> -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *adev,
>>>>> -                                              u32 se_num,
>>>>> -                                              u32 sh_num,
>>>>> -                                              u32 reg_offset)
>>>>> -{
>>>>> -       uint32_t val;
>>>>> -
>>>>> -       mutex_lock(&adev->grbm_idx_mutex);
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
>>>>> -
>>>>> -       val = RREG32(reg_offset);
>>>>> -
>>>>> -       if (se_num != 0xffffffff || sh_num != 0xffffffff)
>>>>> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>>> -       mutex_unlock(&adev->grbm_idx_mutex);
>>>>> -       return val;
>>>>> -}
>>>>>
>>>>>   static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev,
>>>>>                                              bool indexed, u32 se_num,
>>>>>                                              u32 sh_num, u32 reg_offset)
>>>>>   {
>>>>>          if (indexed) {
>>>>> -               return soc_v1_0_read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>> +               return read_indexed_register(adev, se_num, sh_num, reg_offset);
>>>>>          } else {
>>>>>                  if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG_1) &&
>>>>>                      adev->gfx.config.gb_addr_config)
>>>>> --
>>>>> 2.43.0
>>>>>
>>>>

