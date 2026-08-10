Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015D1C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 17:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F1A10E23C;
	Mon, 10 Aug 2026 17:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kq7uElwp";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A2E10E95E;
 Mon, 10 Aug 2026 17:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngcEeu+wuzFTvM3f2RyBQ7fDruqz9Ibg4DUWhFh81n5MEQyWWgmOJH7J6aqaxuLiOhct6yPFkkzEyUt6FbDjgToGAar3ed+XHl7FpQOIhs8Sn7glbefXOpqZPBUnKezqaq+i31J0WrRQ98UNVl0tEdsWgqV4azRubNPOgVXmvX22o2MYmVYWJvwi3m3HWaNPOrWRDNCNhdUu4WRmXqL+hHluBlR1Ro98+UFIU3eKGKbRvSjmVr5naod/M9jmnBpjtiOOx1hbddO7n8vSSq7Xi2uBibGn19kVVJhfAmiI6o8l+p8WsbzR8QfkSveZNGj68jklVaULSaDxpQTepSTznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADGRhPBJ/ug1Z8Likp6nrKpnEGe3NzxsBXCaw0HLf2s=;
 b=Ytq3K56yGwlMO3u9qdsVjSjBGYvO4uZsH0E3/Ny7v6OJTrChY5q+IPcEdRuPNZoePi7wxBWRAXH3IH9eFNd7P+4qAeJ+Sl8kv5pF9MjeHQFKPw4Hp3OqrHf0O5AIyuxstvsk0bbdRbJBU86i1iuqBHxvhzDIUiMdtKCklIa+Y2+8IWWhHLLxM11eOFRnqqPDNo065kqsRzEGOSCTDYjexg8fgp507jEIaIczB59Wd16hRjx9WuTq5/QCj1C2fPDUzucFicCe0/mh/sk3Fp44iPn4PnFOYJLPmyZ6ezKPq1IAYH8KClYR3CyqsGHnOeK+Dtt0pwvwykLQBoOKmo2qKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADGRhPBJ/ug1Z8Likp6nrKpnEGe3NzxsBXCaw0HLf2s=;
 b=kq7uElwpbaNoC23p4W/N+DS0nXOHCG2KqyCvwqDrh2sVHxcN/49rUzczesP7CBnV7ZDyP+COXcpAizRj1/ZIl9yWUEnHlbeACRS6MshU5kElATuIK3+FzovKR1v9xFVCnMiodnk4lLGqZgMmDxYgE61O1iqkiJhdpPlFyCncib4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 17:47:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 17:47:28 +0000
Message-ID: <ced1aa87-c7d7-492a-8775-6b5ed3444ae1@amd.com>
Date: Mon, 10 Aug 2026 19:47:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/amdgpu: Use drm_timeout_abs_to_jiffies()
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Melissa Wen <mwen@igalia.com>,
 Iago Toral <itoral@igalia.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com>
 <20260809-drm-timeout-helpers-v1-3-2de67405a145@igalia.com>
 <eaba2132-a4ad-4634-b00b-6728364a792c@amd.com>
 <038c825a-aaa3-4bb0-98ae-6f93dce73544@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <038c825a-aaa3-4bb0-98ae-6f93dce73544@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 287a5631-cfa7-45cc-4e4d-08def70771c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|11063799006|4143699003|56012099006|5023799004|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: J86VjZv/JEHLws6w1NkGVlRAeTOgL22ouZ7Fst7cOb++RodP6g4WwmzpykzJ0w73D+wpcvlw9Z8MGhtTFomMp331f0hx818R0dB3VRQPKzRTbAMAFN3SwiIsgA8C0lTUNWUD22P0+M2EbeQhuprxHg5FWaiP5zJ2gPwX+nC16qYUUYDi586ZkNzytBeernhywUwuhPXKjePoR4ekvzExZTrztGXKhVjeKBpQlBaLe0f/NlincXPJqxYrf3YX//sSa0iwna4QfgxDp35P79yvO5L+QRQnw5JIVGz8z93gcVy/F2o2rMjAMvlrJn5hc4OnaM0/kk72YgzwY16st9H/t0w44bSH66RMIR/bgweG9OQroPcY6GTrgtTHPF+PsJIt39QH3+L8jfgugkkQhe0emxvVdVGOyKGsgYmfgEvOv35SlNbXjX0Pl/2Li8EbSg1cwdD3WqnkKF/OvHZS7l0282Fvi4UDFCujl5SuLt691MIFQ8U3pedtVOTT4V3dM5dSiXtLQHjO48pmZFn2jiq6rfRpBtdTGOSMCk6PMq1sCqNDndxyzGHUYnB88nr+Q3UyrAppvVJRIpjx8r588HfVdMLF7bCO56lDKL5TfPFpRFh1ndVBM6YVt/cISgxBwLRPY0W6IK9oilQVI9MkWx+lUGK9vMaGgz/enuu/0SLZGLFlIJkpe1HPmDRhM70WrZVorswp6qiKUnl6V6gJRzcSzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(5023799004)(6133799003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aExaMkV5VFh5dWpjMVh4TW9GYmdDTlRUeHBKcEhsTGRJSlNibEF1OVc3dUdM?=
 =?utf-8?B?eTJ3VjJaMTVCMjU5ZFFzMEs1NUo3MVU0VVBTNXdReXBkNVZtOXFmYUh4ZURk?=
 =?utf-8?B?L2kwa0hXY2NEaHFQTW50cHlJNUpxNEN2MnlmY096SWlSdzNvYXBkQmxmbXF5?=
 =?utf-8?B?QjlXR3B0eFowQWV0RUNDZFpkK0Q4bjEzd0UvaDBFTGhRam1qS2ovTkUzbTJm?=
 =?utf-8?B?S3hoMzlHUDExcW1rSkFRK0NlWHpaZDFtU2JCZ3l0TVUzSDl4cHVlZ1VmOFhC?=
 =?utf-8?B?Z2QzcW1HNmQzM1dScHRLUjI1Ym5BZEs0ZlhQRmpqMHRQMnRVUU5RNnhMaDV2?=
 =?utf-8?B?VGN2SXBPZk1pVnhFNVVzTk1BeVZYdEVFbzhRbEltcWdTK01CWVhVQ3hMM0NE?=
 =?utf-8?B?aXpRKzVuU1FXbEJpRFhPUmptR3EvRlBBTmxldnNjUUdSR0xNN3p4b1A0bVJK?=
 =?utf-8?B?dkZUKzNtUHh0bEtYSU84MVhHSTdYV0xnQ1lPUVlYVzNOUWRuQVNTaCtURy9a?=
 =?utf-8?B?Uk9oUFVOU1ByeTlKaG8zN0tNVVFhb3A5Skt5ZU55c2FDVkJCcE9aaW9XY0FK?=
 =?utf-8?B?RUZYemJMTFlPNjdjQmp6Ym1yTXZFKzlvb2hpaFRZcExlWElCcEZJQm9nWVh4?=
 =?utf-8?B?Y3ZZeHViSlhvdHlMRFMxaiszT2pndmw5alA5V1Bwd2FSQnplUDRqR082bDli?=
 =?utf-8?B?Nll1dktaRmwyQmhMNytyaC9lUUpSdXl6cUtPTDVtV1pkcjBzOEhFUXRaNElX?=
 =?utf-8?B?Zmh2NDRSRzViSGZYVVZzWk8zT1U5N1RnTXhPR0VTL0lTVXQrZlNTOXJaMW1T?=
 =?utf-8?B?ZFE2TkR1RnNhTS9zbXlrZnBlYUpuTkRRcjBCZ3BpNDhjZ3hYTm5SZXRHczFC?=
 =?utf-8?B?RXRIcW51bm11YmxBR1d2Y3ZNc0pNalJ2elh4RTE4eGt1cXRoY21xekFjRTBD?=
 =?utf-8?B?bE55NzgzMENtM29tcTVZdkJkSit6clAxbHBQeW81WGhLYktOMDFUanlNTVM2?=
 =?utf-8?B?LzBYNzVEMGF3SkhRN04rUzd0a1FYYXorOEF3b3ZHay9JMFVTT21RNUJ5Q0hB?=
 =?utf-8?B?akNUZUl2RThEMFNLcThDQU8wRDZlSERYOUxNVHdrcktyRG5jRXhOU3gvNXZS?=
 =?utf-8?B?RlRWUjVwSktRODgvQjZMdHgzR1ErT09CZE85SDZmTnRjZ0xRSnAzbzcweG04?=
 =?utf-8?B?T3J5RmdJZ29UUWJ6RmllcjN6SVZ1bFlCdlcyandiN2ttUE9NNFBLaVEvMUoz?=
 =?utf-8?B?OSs3Ym5UeXY1ei9ScDdoWnB4Ly83RzNvYzhYYmlaTFlROXhzbVJDak5ocWpu?=
 =?utf-8?B?aVlXdy9adUhDb0RFenNoeXFsNEkyZlVEakQ3UGRVb201SlpuckZWNU42K2Nz?=
 =?utf-8?B?Nk5BTHBPU1hBSXIxV1FsVXdmam02ZGVEM3IwZzArbWQyZkxEQzVRenlWbUwx?=
 =?utf-8?B?djNOcnNnV2d1S3NEUTcvTU5zSXd5b3RabzhtVHFpUkd3VHlRQmF4cXJxQXI5?=
 =?utf-8?B?OE5RMHRtRlk5L2x2cFFtRmJyaHFpSVIwZzRmTzBNc2FXUG9LbDlRengzSi9H?=
 =?utf-8?B?bi9icUlNVzJ1MjdOeUlaNG9USUIyaitJdmt4RUwraEtCK2NEeXVwNFY4SmV3?=
 =?utf-8?B?dWpBRjZVQVdnbHU0ekNYN0xrM2hBN2tKYXFSc21ZcURpdDI0OWNqRHdqVjZk?=
 =?utf-8?B?Q3VvelJWLzhIU29uMXVzc1JYWWREOUFnWDlZdEFkWUJRd0ZiS1l4elBDaHZk?=
 =?utf-8?B?bU9kR29JMWxHZ0RvVno5cEJQNjJYb3UzaTlySE5YYWZxNTFMZEJCb3lTMVdB?=
 =?utf-8?B?dmh0aVpXWjJDUmUxdnBzUGZOdVl6L2lmNnlHYURFeVRxSDE5L0NTQ0pTK1J3?=
 =?utf-8?B?cnBscEptREpSaHY3cVluclVyeDA1Z3k1VmF1bGpubitWaktqOThkZ3M1MTZ0?=
 =?utf-8?B?L3FyL2xabXNlaEQvWHRidVdBck4vZzlVWE1mOVgzTzF6bEd1OEZWK3ZuVFJF?=
 =?utf-8?B?c0JJeGoraUY5ZHpyd2t5ZGs4b3VVeG9ZeEFxMSs1RVNoeXZpYXdhT2ZPYjZS?=
 =?utf-8?B?SGpNNGtVcVk2c0NPbThGT2FtUUxJWFNIOFJtRlcxbjBwRHYvaG5xUWoxR3pX?=
 =?utf-8?B?aVFnK2ZIWHRSK0xPUWdKbmNGc29wc2NZU3VhenRyQ2wvL0preGlzVUQwM0ZC?=
 =?utf-8?B?NytsRXVZRWlWd25kV1FFc2ZLYWFpZkE4dFRiTVJTUWF5ODYrUVdncVprUm01?=
 =?utf-8?B?M202eXhCdFBadGxwM2s3TVNOb05yekRLeUgwZlh2TGowbHNBaUV1RU8vYU9I?=
 =?utf-8?Q?DFaW4L0iEovA7JYgl7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287a5631-cfa7-45cc-4e4d-08def70771c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 17:47:28.0403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSDuBSGsilQ+rwZATxfWyoJLZCNYGUvHV4EVPeineJbRxKT4nkgSPIRPU9slrQxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

On 8/10/26 17:32, Maíra Canal wrote:
> Hi Christian,
> 
> On 10/08/26 10:34, Christian König wrote:
>> On 8/9/26 21:23, Maíra Canal wrote:
>>> amdgpu_gem_timeout() converts an absolute deadline in ns into jiffies,
>>> which is what drm_timeout_abs_to_jiffies() already does for the other
>>> drivers whose wait UAPI takes a deadline. Use the shared helper and keep
>>> only the part that is specific to amdgpu.
>>>
>>> Two details change along this conversion: the helper rounds up rather than
>>> truncating, so a deadline less than a tick away now waits for one jiffy
>>> instead of returning 0. It also uses nsecs_to_jiffies64(), so the
>>> conversion no longer truncates on 32-bit, where a large deadline could
>>> previously be reduced to an arbitrary shorter one.
>>>
>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>
>>> ---
>>>
>>> As a note, this patch can be merged independently to the AMD tree
>>> without any dependencies.
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 ++--------------
>>>   1 file changed, 2 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 6a0699746fbc..84b509a484b0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -25,7 +25,6 @@
>>>    *          Alex Deucher
>>>    *          Jerome Glisse
>>>    */
>>> -#include <linux/ktime.h>
>>>   #include <linux/module.h>
>>>   #include <linux/overflow.h>
>>>   #include <linux/pagemap.h>
>>> @@ -40,6 +39,7 @@
>>>   #include <drm/drm_gem_ttm_helper.h>
>>>   #include <drm/ttm/ttm_tt.h>
>>>   #include <drm/drm_syncobj.h>
>>> +#include <drm/drm_utils.h>
>>>     #include "amdgpu.h"
>>>   #include "amdgpu_display.h"
>>> @@ -622,23 +622,11 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
>>>    */
>>>   unsigned long amdgpu_gem_timeout(uint64_t timeout_ns)
>>
>> Please completely nuke that function and replace it with calls to drm_timeout_abs_to_jiffies().
>>
>>>   {
>>> -    unsigned long timeout_jiffies;
>>> -    ktime_t timeout;
>>> -
>>>       /* clamp timeout if it's to large */
>>>       if (((int64_t)timeout_ns) < 0)
>>>           return MAX_SCHEDULE_TIMEOUT;
>>
>> That check was actually never correct at all as far as I can see.
>>
> 
> I'm not sure about that... Taking a look at other UAPIs (like Panfrost),
> I see that they use a s64 timeout_ns, which matches the ktime_t the
> deadline is converted through. Contrary to that, AMD exposes a __u64 in
> the UAPI and defines AMDGPU_TIMEOUT_INFINITE = 0xffffffffffffffffull in
> libdrm. Therefore the check looks correct to me: it detects the values
> above S64_MAX and maps them to an infinite wait.
> 
> Having said that, the comment is quite misleading. How about?
> 
>       /* Map anything that doesn't fit in a s64 to an infinite wait */
> 
> To make it even clearer, we could use `if (timeout_ns > S64_MAX)`.

Yeah that is pretty much what I had in mind as well. That would be much better already.

>> We need to make sure that when timeout_ns is larger than represent-able in long jiffies (especially on 32bit systems) then MAX_SCHEDULE_TIMEOUT is returned by drm_timeout_abs_to_jiffies().
>>
> 
> Actually, what drm_timeout_abs_to_jiffies() does is clamp the
> nsecs_to_jiffies64() return to MAX_SCHEDULE_TIMEOUT - 1, so that a
> finite deadline is never turned into an infinite wait. So it is safe on
> 32-bit, but it's not doing exactly what you described.

Mhm, I'm not sure if that behavior is a good idea.

IIRC MAX_SCHEDULE_TIMEOUT-1 is only ~50 days on 32bit systems, but that is way lower than the potentially requested time here. I mean we basically changing a wait of more than 250 years into a 50 days wait...

Most likely not relevant in practice, but I would still say that returning an infinity wait for timeout_ns > S64_MAX is more defensive.

Regards,
Christian.

> 
> Best regards,
> - Maíra
> 
>> And I hope that drm_timeout_abs_to_jiffies() does that correctly already, if not this seriously needs fixing anyway.
>>
>> Regards,
>> Christian.
>>
>>>   -    timeout = ktime_sub(ns_to_ktime(timeout_ns), ktime_get());
>>> -    if (ktime_to_ns(timeout) < 0)
>>> -        return 0;
>>> -
>>> -    timeout_jiffies = nsecs_to_jiffies(ktime_to_ns(timeout));
>>> -    /*  clamp timeout to avoid unsigned-> signed overflow */
>>> -    if (timeout_jiffies > MAX_SCHEDULE_TIMEOUT)
>>> -        return MAX_SCHEDULE_TIMEOUT - 1;
>>> -
>>> -    return timeout_jiffies;
>>> +    return drm_timeout_abs_to_jiffies(timeout_ns);
>>>   }
>>>     int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
>>>
>>
> 

