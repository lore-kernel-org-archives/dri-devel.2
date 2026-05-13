Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6283ACD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAEB410EF29;
	Wed, 13 May 2026 15:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q6T1B3Mx";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC26910EF27;
 Wed, 13 May 2026 15:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfyyXpKepG62ecnDNdi2JFUQNR1kPQwWmkby5qebvh87v+DZ4TPpH4zoUC2yFM9PP5Y4vwyFOvCIf02BJZ6i8L3uGreAgpNmbeh7Ptdn9B2HzpMD2Tm/h9fkmw1h1ZG3IlYJLlWwoaSvWrXaBBg02zwFTustB77EsT9QTMya28AakoVfpXYdYzynJzlEdYvvZkl/FF5a2ozslxZOO476AWv38Dr84cjVQTon/O60y6hxahnP2ahIT97/7cdTmcLXsOpCjPis8GCjkwTfhJ1y0fKmL7/uCtTfsLRFvEZJFpGzkXAI+wp5iU4inTIjbJLds1N/GHa8gMYM1n3ASpJiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I9jnhZIU/mZTue2/ct2bcdz7K2ON52a0aFj75Z/6Wg=;
 b=TJtMGZsEXU7ObfNvBcesV7/VrHuRVmZr5ml1PvilLTEGonoscPpUuwcQCFPBCoddxeyXppwjlZxOEH3IqkKmJckRNkm4HVqaaEKbeowmn2cS6z7OApkbMykvlauvjER+234QTh7/Rv2GhLVWFUWcGk9CwgmiqMUvoyrcjrWZMEqlsoeDmlKgZqGF8uckLSeomHcQxSyaoY7FyMX6Rb/gpj/WU4AXH5gK2PloUvkI3ezk36ebnNhw+oXz+FM/yFskLGJSoPTtrNXIhnbu8FNMBL2LLz6igK+sDmNDjgV8H9uOFH03j/xBlN88Y1xC79eTvnLyzfzJOVGss/JyZ6Lapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I9jnhZIU/mZTue2/ct2bcdz7K2ON52a0aFj75Z/6Wg=;
 b=q6T1B3MxRgZ4CLVmITpfw32kd2bV0vxmRn4OzMos9ztzRbRI9gy2oxcVamIs2BrObkasEUF0Up75Xv0kAFz9UxSG5/XXlpJ3D/4rWdd0Ld3ugtciO/SaSjDh/Of17aIjqzl8BLUmwgvYqh3pVpdDHESGD0vYdFn/yR2bZVyPvig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 15:32:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 15:32:27 +0000
Message-ID: <7eab78a1-ab10-4b8b-8d63-35de502bed5c@amd.com>
Date: Wed, 13 May 2026 17:32:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Support 52-bit PAs in ttm_place
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260513141253.20410-1-felix.kuehling@amd.com>
 <a059d1e9-e356-41b0-8336-8b25ea24e7e1@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a059d1e9-e356-41b0-8336-8b25ea24e7e1@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 806b64fe-2199-4451-08b8-08deb104d67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: TPw+pBbFtjGXFXQR1+9jFtIHAHB3gNcENyZUr2tfK2UvXAQ2CoJlci2pq7FWk5FOgFekfocmlrhR1ChT1j8IdBQ2ciXVEtDQdZPUf6ztWT7mMz1UTQC8qVR5OD5qQycQE22af7ffUWlmYNevxgMB64a7QI7uAc8G9P37TT0g44o/5R2XStcJo3l05p3cy1Sv/l4UGhIDKsacd+1roW5ajc0ZUeOzsfu16HqO+6BGQGch/+WXX/qpJgq2MT+29+rU4tAgFpMqT2rluRI54q2lj8OSVwIz6gHeLG1OB9TyQ5eTDPOoAiQIDZ56kwstlq11u8dISTYDigXsb7tvHKQAiWmOUfFnMiSFlNonP+MbGTp3vKfCSxl6779SDWiZphzpQEVqfY/XjKjIStwhwYgiRbhYGBGHN8GNa8BB7FgO+DiycBDaK+IvdS9wbgiaWFCK+spbtGY3Tqj9iFXsNgoP5xX8AtcMXQBc2qMKWchu9x3QKOK8azJkqhN2iwwwtzzYSe+DISHH0XOmjgBdEcNnoJqrcSPW29e4HI0CuftaE9eMcOkGJilcvaRwVNmm/f3IHPjtw9fCEBW0vP3/GFETQMQvJAxvijJipx0e9x445fU2TVMOGR669ci3Lslj9+UoOsXCb2h9n7yy8w8zzcQzQQ7QPH6QhenCIQ6oBiNYaYxKr8o1ARcZoP+/0faHImLv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlgrandEZG9mY1FzSmhrUW15dmREV0I1RDB0UUI1QW9aNXhnbkNhYWFLVjM4?=
 =?utf-8?B?TnpWb0tOdTgzSzJlTWFwbGZHZGVXUXQ1aXF4aVVDVGhTMTF2YjBhRDhhcFox?=
 =?utf-8?B?MHB1bzR6VEZhKzYzT1lNQjJEb1hhNG43bkNBZGIyQ1NJbmdvYTBnbHhEM0tq?=
 =?utf-8?B?ZGpSZkdNL3RKeVp5cmNJRnNPNTVuVytLcHIvUzZHa1hjakJzTFd2OXdIRHhC?=
 =?utf-8?B?WTRvNHBVc1QxZ1IydnVWWkxIdnVwQXUwTU1oQWNLNEpOMkszTERxTGowSmNL?=
 =?utf-8?B?YTBnSlU5WXk4K2RXUGRUYWxEbGR4bkkxK2E3TVRHR3pTYVh4R0E1c3JnL0ND?=
 =?utf-8?B?eFNGek1qajhDU3RsQ3J4cGgzM2VwL3ZBeldtKyt5QW5XTHFTK2RWWmVhSUps?=
 =?utf-8?B?QnZzaTlGemtsZVo5Z0tRV3UrRnpTZFhic1p2d2VRQjA1dXdmcE1IeFJWYzZx?=
 =?utf-8?B?cUcyT2d3ekg5TnV2YlFiK1FNbVZHWGlTWGIvT1N4THVPbDIrRmNOeExYOHV3?=
 =?utf-8?B?NGVuL1oyckhkOVR1a3FuTkNiNlFWbkRBdi9FSWxZaXA2dmdGWXlYcWVJU2hx?=
 =?utf-8?B?ZGRPUytwV1RDbDFSdCtMWnNlUGQyZkZ6Qyt0MWtrTUV2b1ZSdG1aTWVOaU1Z?=
 =?utf-8?B?VFk4ZHJsUkQvYVpGdGhjS3NVUzU1eUg2K3g1ZXpRU09tTE16cHdNQjRhc3RO?=
 =?utf-8?B?VVNkUVJQeCt0bmZkRnJ1a1JHK1BUcGJXSWN5UkRCNjFyNUhaWmRIVllMVk1K?=
 =?utf-8?B?dlNQQkpGWWhaMFRqNTBNK0dVQTFtNnlWNGpGb2pkc3BQM0hRRkRDTW9zbElB?=
 =?utf-8?B?WDJDbW11emZEaGdRWFZCS2lmYWZRWVBtOWQ5ZVZlNnI2NDFmWlRmbjZQSHpx?=
 =?utf-8?B?d1kzU3VCRFBPSFlLaEVRbTFtYSttSW9ENWdVOG0xZDRpY2xIUTVSNG9LczFO?=
 =?utf-8?B?RDlWeUVqZW5odzh6dVpMVzZOUFN1NjYxeVhLd3pmVGQ2VTNiSHJOS3FmemNQ?=
 =?utf-8?B?bm1KYktiODJxRGV5dlY5MXVHb2dvYkVpUVN3b29ZdXQwVU84RzBaUmNmeE9x?=
 =?utf-8?B?ZEt1dVdDdkFkc3BGMVNFU3ovM1FMWFljTlF2VGk3RkpiQ24rODl2MTVyV29y?=
 =?utf-8?B?dE8rTFo2TVluOEVVTE5uQnY2U0xpbWVSQTlPSFhoaGhkamZRWVFVR1ljWGtv?=
 =?utf-8?B?aXVQVlIrcDBya2E2VVMwMVVES3hQWlhPSkRpQ1g3aVJIY1g4c2N3ZjJBa2R3?=
 =?utf-8?B?eEJiS05IZ0hKdHJpTHlHMU9QdTE0L0tpNnJPK0dhMzA1dE9YQ0NtRGtlTG80?=
 =?utf-8?B?WEZ0SW9kdzN5cHhoNDVEYlVNYnd3UXo4UXF5WkVyY3pZNXVScEdITlBoUUZj?=
 =?utf-8?B?MDduaVQ0eUFwb09ZZ25EQ0V2Ny9qVXFWRGErUlRkOEpUY3pDNDBDWkkyR0kx?=
 =?utf-8?B?SnQ5dXlEa2t1eGt4OEhHSmVWTFk4bHJHSy9pMEZhK1hHVys2eFVUMnEzQVAy?=
 =?utf-8?B?ckVBeTV1Lzd6UytIU1lmaU5qbEhCWXJENWJyLzZqWnUydnU4S255L1l4MFAz?=
 =?utf-8?B?L01ySVU0b0FnbEg4eVdHeXc1c1pSekFOaEVkL0JpRCtkY0ZRVm0yTzc0Z2xQ?=
 =?utf-8?B?OXp6YWVtQkxiV1V0cWhFNWZmSCtwanFVdVl0Njg1ZXgwdjFaaUZucnFEUU1y?=
 =?utf-8?B?VHdWekg5djgydkVXVWt6OEg1UkJ4aWhXT1ZmcndWWHlwMmRLa3h3cHZjUlBP?=
 =?utf-8?B?b3hFMnFVZW0ySzlaRWRZbWpoMGpnaWhHdWI3Qmlia2NlTW9CUU1JRWRzUnBD?=
 =?utf-8?B?S0Jtc1VKeWJvZmVWVnplN1NtbkZOMEluQ0FpQWIwcFdXdWFtUWJRSXZtdlU5?=
 =?utf-8?B?M0h5QUIxQlBYUHVlRFNYMHFDWHA3Ti9DUThEN0VmWExUYWlIcUkrbmpqRjNX?=
 =?utf-8?B?WFh4RkVwVU9JR3IzbzNLUzZRQ21HQUpRSmZiZ2JwNDhXSDZoSFNITWd4UjNT?=
 =?utf-8?B?cWdWQjhOYkU0dGRNaFBJcU8xa1E0TkhYSDFZUEdkUW1xR2RDOE5lV1g0RS9o?=
 =?utf-8?B?UllxeC80VFFNblh1M1R2ZEVETU9IRGZ4d2hZcllYUTI5eStmNmp0ZGZsK09x?=
 =?utf-8?B?VGNIdEhaenlheENsYnoxaFRVSzNlV2lzMSsvWTQ3c1QrRm5hNGNOeTl2WUg1?=
 =?utf-8?B?RnRlWGxoaHZyeUY5cjEybGNGNFFwNkRPa0RlVS9RMnpVUnpqaDh1SlZRbCtK?=
 =?utf-8?B?ZTBRSTdCdEFOSUZmemtmQk5qOE9hK3NsV2hzN0QrZlVkUTNGalhtVmw1elJQ?=
 =?utf-8?Q?rl2J8I5N3MZVgQjRry?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806b64fe-2199-4451-08b8-08deb104d67b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:32:27.2229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6e8H6kOOEXP6Py7qiKT7US5DP8PSE+67C7miFsvfOnswVZyW1M+OKN4uXRttgwZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
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

On 5/13/26 16:50, Tvrtko Ursulin wrote:
> On 13/05/2026 15:12, Felix Kuehling wrote:
>> fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB page
>> size this can support up to 44-bit physical addressing. Grow these to
>> unsigned long to support larger physical addresses.
>>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> ---
>>   include/drm/ttm/ttm_placement.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
>> index b510a4812609..ab2639e42c54 100644
>> --- a/include/drm/ttm/ttm_placement.h
>> +++ b/include/drm/ttm/ttm_placement.h
>> @@ -81,8 +81,8 @@
>>    * Structure indicating a possible place to put an object.
>>    */
>>   struct ttm_place {
>> -    unsigned    fpfn;
>> -    unsigned    lpfn;
>> +    uint64_t    fpfn;
>> +    uint64_t    lpfn;
>>       uint32_t    mem_type;
>>       uint32_t    flags;
>>   };
> 
> Maybe audit of usage sites is required to make sure no compiler warnings on 32-bit builds if nothing else. Things like:
> 
> amdgpu_vram_mgr_intersects()
> ...
>         if (place->fpfn < lpfn &&
>             (!place->lpfn || place->lpfn > fpfn))
>             return true;
> 
> Etc. Probably are all best adjusted to match the new type.
> 
> There is also:
> 
> struct ttm_resource {
>     unsigned long start;
> 
> Which also may need aligning. I know no one cares about 32-bit builds but some automated systems will probably test it and send reports.

Yeah I have been trying to remove ttm_resource.start exactly for that reason for a very very long time now.

Drivers shouldn't use that and instead rely on their own backends to give the actual placement.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 

