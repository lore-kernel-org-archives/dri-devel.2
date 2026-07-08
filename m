Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF30C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7023C10E5F7;
	Wed,  8 Jul 2026 12:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I/cTJ6l/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F0D10E5F5;
 Wed,  8 Jul 2026 12:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad0GT7LD3UC0T79r+VhTC5vUduEiAqEE4XqWgp5jQO6dRcPJHl1XB3d/fHOhcnXI2whsAdiQj87CzcB2KjUXe6Aty8QMWa7LSud+Id8lnJUNbwBj6IATMrnk4kqOWUysDuBXqR6ABdyMGd5Ov3cR8Qb6jiZykyASJ5IfIqvWLZ/jnXfdZ3cwzUA0SV83t1VqBLqEaDZNaKjC/apspMScIS+NkjXKQJMZhlS1T4htBqEelUQbTIflTUP4GngVs8xKCE5/9QpFBWArj8BlbwhLlwByeVe42EAoVsNOEyKr1ZgVdCsqAJakALfb0YcGcBnESmsK3DR+K5CR9gGzNR0pnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9HGuin6SMFpIT71Wa0L5XLX4Q7zbbqetjVgd2UBB0g=;
 b=GVMQtAOJzU11t1rhEtx/5weDP3OwoDS8tbH8pWGrA2xhwp97Gh7TfTyfWzLz2uOhODtbdZju/DWCrgLTQB+Nr1XRuUeSrVSYKXZ/aTLTyEDCkzqYOPeIsjtc7S1jpCibx+7xjQl9j5laX0JcJPUlJtPa8NIBCGxmzFhlNSVH6/zNn3hySQgQKOPBxOWj0rtVKTgrN1WMpmDGaBgD7/1zAPhMqgGddJkPZSHq7WWsBRyxYsYiYgIw7NNLflMLOw4ArBalgpsDUrDSRJOiuJ05QNLThxJ3CbFEH6OgiDHJgAYaRbUjnesB7etBZ2Do35wga8uYIb7608P4pZF0EXwomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9HGuin6SMFpIT71Wa0L5XLX4Q7zbbqetjVgd2UBB0g=;
 b=I/cTJ6l/OBvFPwc+CoUg95/GZ9Yr2nGsb09wRNqI5XYNKUEuZxeDViLepqFh5FYAxhzAnP9DlPeQAnBNAJ9RqB7DgYenJlLBZ2PYVbilrTb610qtm4bXTVjyjSVPStNDz/0ek6g32EwR1LTL4qIUj891KE5IqM2NQNSpOFH9ONI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 12:55:20 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 12:55:20 +0000
Message-ID: <8dd56d76-e46d-43b6-831d-27e66fa2879a@amd.com>
Date: Wed, 8 Jul 2026 07:55:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
Content-Language: en-US
To: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
 <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
 <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
 <bd1f1632-f53d-4bfd-9d28-5b66e466366c@amd.com>
 <80f34509-9781-421e-b60f-1b8c772a01a9@shift-computing.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <80f34509-9781-421e-b60f-1b8c772a01a9@shift-computing.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf0b775-62da-42af-c77e-08dedcf02ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pwX0lfT2gCkK6q3rEvV+0YtW5NCkjP0kly3KKrcFMtgBzWxIJEkLozy/9iPlgnT9AkV4G3SHNgVQLbyJl4XY4JXO+2+I/lJ7GhANcEKdA932v++pU09QCOVM8ZlyyEnb0ZuBIl1aSRG4UBOwIGyAB7KKhBX0l9LI5UpYKAOleKyV7DLW51SRC+z1SIBbKa2/zS9hOm/991IVbZtMIyODQrqKaEA/3ZPJnB5PO9JOqUf4oVp67t4BgiwUaSeoSOr/trOm9wz4o50FUsZgsQH4eLBEZVTFoNmsQrWBg09MP9fRmt7pzkA5h8MOMRS5n08yPo1wehDswprbL2WEDiiOF2Qb/c9UKF3W2IlKNI7li2TCUEmzsiQgPQt34pzhvJUGTKAROLeTeVjvw3TZSVPoRGI0AlSoCQDOjNVIwjO+a4bgl09CgEW8KRIshI93fczcaYr15ZzBriQ277y5EHMiLm5KjJW2vBtxqiOBsGj7wStKGzCsk6MUvuwrA26sNLb/kTEB3xhvMcAcxAapnaNE0LOc9L6zUvS+6oPKuUX4KgTi2e2hrPG1JfOmMxV3O3jvOynNOfoB/png8siw9hoLm+KY19LkzWLOyDn/2zyQmrTOWfT96E1yR6ZxeTFOwnU5q2Ka+yEvMZXPIC/6oHX/8UxPpQjeDyn86Qi4ph9G984=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFN5QmRQclUzMCtHK09KalBaUW8yd3F2elNkMS9xbmk0V05NYndkSVoyWXpv?=
 =?utf-8?B?MmNUTTFoUWlOclpMeDgxUEJaTUpnTTZ2YVZLZWpOODNhV2xoa1hNSGIwdW1X?=
 =?utf-8?B?YitUUmEvZXNYMUJNRUtVRkZrdVZvUkVJT05PUnMzSDAxanlDUXloWDg3WWlm?=
 =?utf-8?B?VUtuSnZmbk1mWjVybGUxMnVNK0dNRG9FS0pFSkxRVG9wUUNRUWVQeWV1ODZP?=
 =?utf-8?B?NkM0K2RLbjhwK1pNSHlrRlFTNG9heW1WS1hBOXI1aFE4cjBieVB0eVhWRHox?=
 =?utf-8?B?ck9OKzV3b2RNT2ZmL3p5VjNYcisyOFl0UjZYNk5EZjk0OXEwUkhnUFNDZjBw?=
 =?utf-8?B?N0tob0ZiM001S0M0Y3RnaC9rTHBpV0Q3T2lteFFwVUxNaVY3Mmt1U0xPWUl0?=
 =?utf-8?B?Wm5JT3lxQWRlR3g5UHNqOFg1YVQ4VzNqYldMWmNEYVJJOFRpZzRyOHRQLzNl?=
 =?utf-8?B?ckp6b0VxeGs3R1ZrbDV0dk91NW9uNG12ZlJmQ1FkaHdmWFZlMEJsdUtITDVv?=
 =?utf-8?B?NUI4NFB1Zm5YWURPUHRiTll2YWNoeVlUSlFDUzZlMG02alUydU9PbG9vODVU?=
 =?utf-8?B?bjljZklscDZEak1tWGdWWTEvK3c3bGxuZWkrWUJYN0htaHBzNVUvQUN4ZEsy?=
 =?utf-8?B?bEx1RTI4WFZGOHZIbTBOcHBLbE1oMHVmdGZ4dTI3U2hCOVdRU25uZWZaR25S?=
 =?utf-8?B?cnFNcS9HanoxTmNqZDhTM1M5ZDE2ejloMXMxMkJIZ2hyd2hWSHQyUGN5SVdt?=
 =?utf-8?B?UWJ1RS92TWRTdkczakd4TUdUWTlzU3pOLzMxREc4TVh6Mm1VYlpKY1B2Tno4?=
 =?utf-8?B?TnpjMDF2ZDVNclpVQ0RaQW1UL2JLdlNlWHpaRHZiK0NxVFJwY1BMQVdzODhu?=
 =?utf-8?B?RDhITFBtWlFlWCtjdVZFYVBIV3dJZiswUk9TMTE3NC9ETGd3TnpvRTQvaHNB?=
 =?utf-8?B?V0ZGTzNUN2NmNUF4V080cHRZOTZzU0M0VkZVMEI4dlFHS05YVUNBRzVnU05y?=
 =?utf-8?B?dDV0OUVHS3VySUdNK2NLZ1JDU0IzSHB5WW16aitza2NwS0NXeGZZbThsOFBQ?=
 =?utf-8?B?VjZESzZRd3dSYTBaNGd4OHJTYzh1eXpCcEExOXphVFBIc3VNc1N2UnMySkRs?=
 =?utf-8?B?b0g4N05UUUdkcHdxQ0pDNk5MbHFBS3VMY0xyVCt0RFBUbGJJK29ZYzlQMysx?=
 =?utf-8?B?UmJjM1RIclJmR094NlRaZVI1MjdWMXRtRHNJSFd3YkZ6cjFWYlR4Wm5NdlM4?=
 =?utf-8?B?SGVFcktyVEFiUURzUmVGc1REaHlqYjJ3OFlmMDRFamZFQzFvSjdVY0duSE44?=
 =?utf-8?B?cWtsLzZYRFZJYUU4aFk4eExpTk11cHVxZEZLQ3MxTm5xaE9pcUlWUnFVRGF2?=
 =?utf-8?B?QzJnUHJ4dFFqWmRIL0VoSHBwZm5vUDJieVlkOEh6bmNOdnZidDNiQldpV1Mx?=
 =?utf-8?B?blVnYmQ5aVYwUFJIYlIxaTE1MmM4Q1Rzd0NpSmUwVWxqV0FRWWloSEZqZExT?=
 =?utf-8?B?MUNIcFJNOUE1ZFRLTHBCenU5elg5VSs3MUEreGxZcjhwVXB5WjBmU1NKK0Zr?=
 =?utf-8?B?cG1SekVhSjBucHNMSndnVEdRa0FKVmZXTDJKelgzRTNNblFlNGhTeUJHUDFU?=
 =?utf-8?B?ZnNOanFtbEpyWnViUmE5YzhQbmRLYWkzME9NZ3JlMzVoeTFJYjM0bS94K0ZZ?=
 =?utf-8?B?QWRkMG1HS1EyOUhwNVZUOVVtcGtEbS9hSzFDWFM1Ti9JN0xSWm1SWmNKbysx?=
 =?utf-8?B?Ulo3ZFVLMGtIMXdqOEVLeTNoWVFteS9xbnZ2Y2VXem5PUHRBb0pwLzVEZEcy?=
 =?utf-8?B?eTRyMVdDVEVDWDYwR2hObDJmZFFKTTFwSHlCb0xGUHZvck5wR3c3Y25aakJo?=
 =?utf-8?B?RE9VMzI3ZWJFVjRnVGNnTE5MYzhWY2lUeFVFc3hKc0xpOFQxaTh5T29kOFQ3?=
 =?utf-8?B?MHhWUTdRamhMZ2dEemJpOEJlR1owMXdpWjE2RFlsT1h0UEV3Z2RJanM0ZzI4?=
 =?utf-8?B?WHgxNGlnZVErbDVhOEEvT2x4OHVMWnJiV2lMUDg3em1CMWNCanQ2Vy90ZVg2?=
 =?utf-8?B?cmsvTkZLeUROSXRaUTJlQXVwTnNnVmU4bnJvU1JML3gzY0tkd2J5TGxiOVpx?=
 =?utf-8?B?c2Z4Z3M5aDMxaUZjeFRqL2pVZVR1QS9pOEQrVjVzTVdKVXY5TWYvc0g1cURM?=
 =?utf-8?B?WC9mdnFld1dYcjFrNjlHVCtWK2s5bnhKQnpKZUhuUElEaHloc0IwQ1V2NWVR?=
 =?utf-8?B?TTZQcGJkNzJKZlQ3QTZkbmNkYVZhMGRaZjdzeitMV1QyMGJRNVZFUnRGaFBZ?=
 =?utf-8?B?UDhKT2Z3RzZmZ3pJaWoxN1dpOW9EcmRLMkM3Z01WTXFWME8vTndKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf0b775-62da-42af-c77e-08dedcf02ab0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:55:20.2469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUqtnEDZCF4cQAEMzD7dBO8Jfz2qQ5rAEPtaO6faeq0W9lqKbf4RZj6icTBOzk75tAl/+e8ptVFRd528k6dsVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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

Hi Oz,

On 7/8/26 07:36, Oz Tiram wrote:
> Hi Mario,
> 
> Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro 8845HS / 
> Radeon 780M iGPU) with pci=realloc,assign-busses.
> 
> The VFCT entry for the iGPU has PCIBus=106 (0x6A, recorded at POST) 
> while the
> runtime bus is 11 (0x0B). Your patch fires exactly as expected:
> 
>    amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: table 106 != 
> runtime 11,
>        matching by device identity (vendor 0x1002 device 0x1900)
>    amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
> 
> The iGPU initialises fully and drives the framebuffer.
> 
> One minor nit: the dev_notice format string ends with \\n (two 
> characters) rather
> than \n. The resulting kernel message has a literal "\n" at the end. 
> Same issue
> exists in the nearby "too short #2" dev_info -- not introduced by your 
> patch, but
> might be worth cleaning up.
> 
> Tested-by: Oz Tiram <oz@shift-computing.de>
> 

Thanks for confirming.  Before I split up this patch and post it in 
smaller logical pieces can you confirm my proposed root cause is right 
that this issue happens because "pci=realloc,assign-busses" was on your 
kernel command line?

If you drop that - does this notice still come up?

Thanks,

> On 7/6/26 02:56, Mario Limonciello wrote:
>>
>>
>> On 7/5/26 14:10, Oz Tiram wrote:
>>> Hi Mario,
>>>
>>>    To make sure I understand correctly: are you suggesting that the bus
>>>    number in the VFCT was legitimate at BIOS POST time, and that
>>>    pci=realloc,assign-busses is what changes it at runtime, causing the
>>>    mismatch?
>>
>> That's what it sounds like right now.  You can easily drop all the 
>> superfluous kernel command line optiosn and see.
>>
>>>
>>>    I'm not familiar enough with the PCI subsystem to know the right 
>>> way to
>>>    implement that — could you point me in the right direction?
>>
>> Well there's a variety of ways to do it.  But how about we start here 
>> - if we make that specific busnr match optional and instead make a 
>> VID/DID match.
>>
>> See if the attached patch helps.
>>
>>>
>>>    Oz
>>>
>>> On 7/5/26 20:37, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 7/5/26 05:04, Oz Tiram wrote:
>>>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
>>>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
>>>>> before giving up:
>>>>>
>>>>>    1. ACPI VFCT table
>>>>>    2. VRAM BAR read
>>>>>    3. ROM BAR read
>>>>>    4. platform BIOS
>>>>>
>>>>> On some systems all four fail.  The specific case motivating this 
>>>>> patch
>>>>> is a hybrid graphics machine (dGPU + APU) where:
>>>>>
>>>>>    - The VFCT table contains the iGPU entry but with a stale PCIBus 
>>>>> value
>>>>>      from BIOS POST time (0x6A).  When the kernel boots with
>>>>>      pci=realloc,assign-busses, PCI bus numbers are reassigned 
>>>>> dynamically
>>>>>      and the iGPU lands on bus 0x0B at runtime. 
>>>>> amdgpu_acpi_vfct_bios()
>>>>>      matches entries by bus number, so the entry is never found.
>>>>>    - The VRAM BAR is unmapped at probe time.
>>>>>    - The ROM BAR is zero (PCI firmware did not assign it).
>>>>>    - No platform BIOS mapping exists.
>>>>>
>>>>> The UEFI GOP driver initialises the iGPU successfully for early 
>>>>> display,
>>>>> confirming the hardware is functional.  The VBIOS image data 
>>>>> embedded in
>>>>> the VFCT is also valid; only the PCIBus metadata is wrong.
>>>>
>>>> So the BIOS on this machine is actually totally fine; it's just when 
>>>> the kernel is booted to reassign busses there is a problem?
>>>>
>>>> In that case; why not detect the kernel was booted this way and keep 
>>>> track of the original bus number when reassigned to avoid the issue?
>>>>
>>>>> The firmware
>>>>> file can be extracted directly from the VFCT using dd:
>>>>>
>>>>>    dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68)) 
>>>>> count=16896 \
>>>>>       of=/lib/firmware/amdgpu/1002_1900.bin
>>>>>
>>>>> (0x68 is the byte offset of the VBIOS image after the ACPI table 
>>>>> header
>>>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the 
>>>>> ImageLength
>>>>> field in VFCT_IMAGE_HEADER.)
>>>>>
>>>>> The driver then prints "Unable to locate a BIOS ROM" and refuses to
>>>>> bind, leaving the APU completely unusable under Linux.
>>>>>
>>>>> Add a fifth fallback: request a firmware file named
>>>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
>>>>> request_firmware().  This allows a VBIOS image extracted as above 
>>>>> to be
>>>>> placed in /lib/firmware/ and makes the binding succeed without 
>>>>> patching
>>>>> ACPI tables or BIOS.
>>>>>
>>>>> The fallback is only reached if all existing paths have already 
>>>>> failed,
>>>>> so there is no regression risk for boards where VFCT or ROM BAR work.
>>>>
>>>> What happens if the VBIOS changes in another way one boot to 
>>>> another? You might have some other stateful information that isn't 
>>>> updated.
>>>>
>>>> The whole thing to me feels like a hack for a behavior we can 
>>>> control in the kernel when doing reassignments.
>>>>>
>>>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
>>>>> ---
>>>>> v2: Fix commit message: clarify that VFCT contains the iGPU entry but
>>>>>      with a stale PCIBus from BIOS POST that mismatches the runtime 
>>>>> bus
>>>>>      number assigned by pci=realloc,assign-busses.  Explain that 
>>>>> the VBIOS
>>>>>      image data is valid and document the dd extraction command and 
>>>>> byte
>>>>>      offsets.  Note that the UEFI GOP driver initialises the iGPU
>>>>>      successfully, confirming the hardware is functional.
>>>>>
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++++++++ 
>>>>> ++++
>>>>>   1 file changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/ 
>>>>> gpu/ drm/amd/amdgpu/amdgpu_bios.c
>>>>> index aa039e148a5e..86064c753b09 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>> @@ -26,6 +26,7 @@
>>>>>    *          Jerome Glisse
>>>>>    */
>>>>>   +#include <linux/firmware.h>
>>>>>   #include "amdgpu.h"
>>>>>   #include "atom.h"
>>>>>   @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct 
>>>>> amdgpu_device *adev)
>>>>>           goto success;
>>>>>       }
>>>>>   +    {
>>>>> +        const struct firmware *fw;
>>>>> +        char fw_name[32];
>>>>> +        size_t fw_size;
>>>>> +
>>>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
>>>>> +             adev->pdev->vendor, adev->pdev->device);
>>>>> +        if (request_firmware(&fw, fw_name, adev->dev) == 0) {
>>>>> +            adev->bios = kmemdup(fw->data, fw->size, GFP_KERNEL);
>>>>> +            fw_size = fw->size;
>>>>> +            release_firmware(fw);
>>>>> +            if (!adev->bios || !check_atom_bios(adev, fw_size)) {
>>>>> +                amdgpu_bios_release(adev);
>>>>> +            } else {
>>>>> +                adev->bios_size = fw_size;
>>>>> +                dev_info(adev->dev, "Fetched VBIOS from firmware 
>>>>> file %s\n",
>>>>> +                     fw_name);
>>>>> +                goto success;
>>>>> +            }
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>>       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>>>>>       return false;
>>>>

