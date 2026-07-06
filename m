Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAEAC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 00:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DCE10E2AA;
	Mon,  6 Jul 2026 00:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e9Aqr8SK";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E558310E235;
 Mon,  6 Jul 2026 00:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDd8KAHcuSN+1b81FQvvV3/CnskDfWxDlLel+17VoT3/Si+/i3S9kuYLtPsCHsYGITeOXJhYlVptPhTnTWth3BCpp/L+/gDT+4+assrGO8Z/x1wwy3qooIu9jKGqZTDe69y/LNzpHWwTKnj9lDB23pZJsS+n0EEIOQ4WFqBmYkru16O9Owx76u8bjjVx6zqJYX8JUGHU2v4s2bXOrWj6mm1dawsgAZKz1gtb9tGLOqsUwC1+UMmdqosHgqJ07SaGjxqxrFNAj8KRO8sEagjRpo6hJDXLBWP4GOqznjycHz5iYf3vb5kH6E0lkKx3qgDZhx1KueprCCHzDoceWrgKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bUzeIGtF/7SR0s+3ncKdu4I1Gbx+HqFCwhfPU9Cveg=;
 b=sh9ks593ldQpsBOFZdodheWtls7dEtzRudvzIWkK7sLsU0HfNxbbdgTqTDwFVXz0Mkt6YoeIOjZmTXblzxcDFy8/GLirF3S4/TU7GwUn1T4Ze2Cn7U5d0+FKFfiYBOCQ77MmDCy6ssvXxVqr3ldo7e6H9EtXM/cdXp6lJAa9c8Mcc5svQiAREfWCEKEPvBcdZYJkYzTll9/agQhJn2MtyAOuHAGefcRWHmhc4STDLjM5uZYIzdtioYuVATmcUL1/IqAuWpog9HynWmqicLlxmnexNYoxgdh7qXu0dEt2Tu6hvZ3TXdQs1neHdQ4fXe+RqkAGWGVJSQLu7c8DtwRGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bUzeIGtF/7SR0s+3ncKdu4I1Gbx+HqFCwhfPU9Cveg=;
 b=e9Aqr8SK6BiWjQV+UVuo2UsUGUNAQqpz07zvvcKtcrG8llHN0/M7VAeqPJ+hhnJd2Vwn10xe+ZLYPdjpS+isvAHk/DjoaYiZOKONuKN/JH2Jz8hWS+6i8lZd8s4wnmkNgpXTN/nYsIFhp19T9qcATgNrkzRlIe97OZ4WXIjBBwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 00:56:28 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 00:56:28 +0000
Content-Type: multipart/mixed; boundary="------------4Fab3eVhd75eoIYFLlBCZHlx"
Message-ID: <bd1f1632-f53d-4bfd-9d28-5b66e466366c@amd.com>
Date: Sun, 5 Jul 2026 19:56:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
To: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
 <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
 <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
X-ClientProxiedBy: BN0PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:408:143::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c22987-379a-4163-27e1-08dedaf9692f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|6049299003|366016|376014|23010399003|4053099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ROcWn1A6DtdfIbTLkkPt0lrP7ErbCrQNbeCKfsz4lp5kCFGsDLj6UoCY3qtGErHtqQxf600vqufBvsM+1rGrV+Zn/Vk5PiN5eXEXdrWjZT08GkOi38LFJRxx6MpJhvBKbjmXYul05RZbRhYYdHxs2jg57EuWsaqXvFxLdWrnrJqPUwoS4g4V8jsmKtWjewhVvZcxI170ykum1ryrchKVmRfL+5jeCtHPWeC/qEJ6vonJDS/zRocOF+l0IGsY4t7D/vmaH8fzkgDp5hhR1oeDqAspZfB46pFWc+o5Wwd9M/yYVcysWwnITkKPZ37qEqgbuM7llcowejqPiLvF8XJG3C6O+Zjj16G/G1x0mGcMtuaHbQu0EErb8CAHXG/ZYh1O2myRFoPVHsxQjki9XdFX7AM6DKuEEvgnM4KE8neQdw3jUOmnqt4qcaDbWYf28N46RxzQMRKKhNAsj074UfXUzJ+0qw7A8HXm0XOIa9Vbtpiy2t3ikCq3f77Au7ur9q5lAIEJ7B6mH7pZ6jZsefpkbocb6Jl4gclsWgk1laKGObmSjKWLJRAJ4Mv4ZmJiJ0Uhfmc/cvzLvflerqRUBq4Ogpytnef25kqyEsMNQ2rABrx9jQzM7dWwdfVOFyNLvZNm+A/zQ2ZUPJCYcjdAN4qYmZU3pzvhp/hdqldoaON4i1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(6049299003)(366016)(376014)(23010399003)(4053099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29uVGhGQ09jWE5pbmRveXRwYzZtdlQ3ZUdpb3ozdVc0K1Zaby9sUmMrcklU?=
 =?utf-8?B?Qk9OZ3ZFd0V1RUdibkNRejdXdDVSd1F0TUlpLzRIdm54Ry9hanhVdjlRRG1v?=
 =?utf-8?B?WlhUT0w4TkZGdUlkZTlESUMyaHF0RktBbFFvWFBkOG1na294cmlhaUNycEo4?=
 =?utf-8?B?dkhzUEdUZ3ZVV3hJcXZDTHZtRXE5d1habmY3cmIyNmp0bGt6am4xNGRiQVBO?=
 =?utf-8?B?TjRKcms4NklDWjNDQkRQOFlJYklKaEdJTU1QMk1yeEhyVkt1UnB6eXdHM1R5?=
 =?utf-8?B?TXdqVkFPSTlVbUNHalluTkVGWkx1bEd1dVFMdVppSzNkWFNDcW1SNlZlWDNo?=
 =?utf-8?B?WElzMzNqZmtjUjFtUlV3OUowaXNqSFM1bk12bEV5WnVNNkc3QitOV3JDUnRl?=
 =?utf-8?B?cUxITWlPakFmelZVaEFJMTA3RUgxVlRJV1VHS3lWdzZmU3k1OWJoOFR5V0li?=
 =?utf-8?B?UTdiU0w5T2hKWVQyS3ZJNkxWZU5OVEl3TGRYVGFOSS9RQkRtWlh5cll1b2Ri?=
 =?utf-8?B?eHRBbjFWQUVZRVl6QkNyWmxYWjR2M2czVzNLMGNPdXcxSnM0QVFDK3F6ZkRZ?=
 =?utf-8?B?eTZQVkpFUGp2N1FpcFNnNzlzTVBtRm0vb0RzellkN2V4Vi9nNVE5UE12Y1Jj?=
 =?utf-8?B?eFdZWjJRZ2FpK21ZdmduZXBQOGlHL2dlMEdUV25FaWlhMmRHNnVlQitaYnEw?=
 =?utf-8?B?OHBUQTEvd2VVaTVHeDJ5b1UvclB1eURpbmNkcjh6MFRMR2VJcHhuSWJLc1JS?=
 =?utf-8?B?UlpNU3VmTUxSUTBtVWZUV1Q1eGI5Zm01OU85TytETlNnNVA5blRISDFMd08v?=
 =?utf-8?B?M3BGVm5oczM0a2VwbHVodHdEUGZFVGZHZm5yRHMybW9tNTU1M2JsdnVqd1My?=
 =?utf-8?B?MmFVUk50MkZsdm8xQ2NJa3YyenpEOGQ5Y3E3bkFOTzhBbGNYNTBqTXpSVXRk?=
 =?utf-8?B?L2FGRDhxbnE1YTV1NDRodksvaU5Qc2pFSWU0VHZNUzhwU0p3VEdBYmZ0SnBB?=
 =?utf-8?B?eEdHTmRFY0xXRlBNemxFUWRnVHYrNjNvdlEyV2FDRmthMjRQWW9vM3pPVjU0?=
 =?utf-8?B?L3hkSDdSSHRaczEyVlVnY29pU1U1TDhyT1VuT0FMdlI1aE1XNnpCbHhqNTNI?=
 =?utf-8?B?RFYxTE5kbGdEY1d0WkFpYk1mRjlrVEhONWI3dzhSaS8zb1AwTkJPTGxSQVBn?=
 =?utf-8?B?QWJvN3AyZ1EwbE0vVlJGQlk2TTdBaXVRRERrOFEvYnppMVBDd3p2QmllWDFX?=
 =?utf-8?B?cEtJQzZHZXM2VEhkcWNnYnlJbGltZDJ0eU1uYUNJV1JLeXhGM3V4UjlSeHA2?=
 =?utf-8?B?OWNGc0pUM1RoQnZ3eEtSUHRiQUFEKzJqL25CelRqeXVUZnZWVHNxczA4MWZM?=
 =?utf-8?B?OHZ0ODMrV0lEZGhlYUV5N0xhaXdpMjFKVHVSbWxBQXhuc0Z2bjRvSjlhb1Bu?=
 =?utf-8?B?TmdXSkJLSFFRY3gyeWVIK2c4V1kyRGM4UllIamJYK3dPcHFSanhwbEVUeEZH?=
 =?utf-8?B?REFvTnhrYnRyNmdCeWJLeE1XdDEwK3QreE1jUEw4TGZ3L216UEtTc1dxZXFE?=
 =?utf-8?B?L0RLS0szaFArcTNaV0JmUEFUSTl3NEFLRDhiZ2lMbWVSUm0vZTdMSDVJWEt3?=
 =?utf-8?B?emNmbGlxcUVRZEdMSGRRczdYOFhma3FOV1RGWjJocUIwN0VzVWFqSWNoM1ZW?=
 =?utf-8?B?ZmNVZ25JRXY0b2Y3dTcwTTY4azZINDZ6TG5ObzBHT1ZTMHF6OGl3ZWhQWEti?=
 =?utf-8?B?KzNQb1YrNGg3dTZ6MHJxZ0x5OEhDUmhUK2NhUlVoeEpMZ2dsZ0U2YWtCeVZJ?=
 =?utf-8?B?ampmdUsvQUh1UHpDVVRqL1VreU1ZOUc5Ukh1YlNqcGdzcUJHNTUvV1lTNVBM?=
 =?utf-8?B?WmRIQlJnTmx2M3JtZzEzRyt2N0pDN2RCZWUxcGVVcnpNQjdXbWlFcWNEM3Qz?=
 =?utf-8?B?aFhoTTl3OGhUS2NRS3VsTjcxNkF3QW1BaGl2c1ljRWxmakU5ck9rOGlSYWlJ?=
 =?utf-8?B?b2hlUXBicDU3aW5Qakxqd0xrUlFWS2ZSS25jMHpnam1Xa2M4enJiRGlWU0xt?=
 =?utf-8?B?dHVCV3BoamRiaVhxNWh2YVBXbHVpaGUrcHVaeEJvaDYyUzJUa29WZ3M3MTFZ?=
 =?utf-8?B?bmtHS2xYd2JYY2F1RmxIYWttT0tkTG9xa3kxZFR4d3p6eGxablpQdHB4WGsv?=
 =?utf-8?B?b3pPSkxPWWtpYjIwSTIvTVdwTG1tU0phSTJQQkpGK0swUWJ4N0d4SnlrV0Ra?=
 =?utf-8?B?YnorVy94cHVaenU0MDZPOWt2Wm1oVUt3K2FUSDhOZ0djaXIzNUtzOGVYeFR1?=
 =?utf-8?Q?Xcve6iFy+pLF1BIE51?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c22987-379a-4163-27e1-08dedaf9692f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 00:56:28.2016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hv5TWuQSDZW8AV9ak8wRx6UtLfb9W2hmtBPpq4auqP1G1x/2L0EYYZi986dk0nTUFT2fwB+EkX1ikVHZdyZprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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

--------------4Fab3eVhd75eoIYFLlBCZHlx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/5/26 14:10, Oz Tiram wrote:
> Hi Mario,
> 
>    To make sure I understand correctly: are you suggesting that the bus
>    number in the VFCT was legitimate at BIOS POST time, and that
>    pci=realloc,assign-busses is what changes it at runtime, causing the
>    mismatch?

That's what it sounds like right now.  You can easily drop all the 
superfluous kernel command line optiosn and see.

> 
>    I'm not familiar enough with the PCI subsystem to know the right way to
>    implement that — could you point me in the right direction?

Well there's a variety of ways to do it.  But how about we start here - 
if we make that specific busnr match optional and instead make a VID/DID 
match.

See if the attached patch helps.

> 
>    Oz
> 
> On 7/5/26 20:37, Mario Limonciello wrote:
>>
>>
>> On 7/5/26 05:04, Oz Tiram wrote:
>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
>>> before giving up:
>>>
>>>    1. ACPI VFCT table
>>>    2. VRAM BAR read
>>>    3. ROM BAR read
>>>    4. platform BIOS
>>>
>>> On some systems all four fail.  The specific case motivating this patch
>>> is a hybrid graphics machine (dGPU + APU) where:
>>>
>>>    - The VFCT table contains the iGPU entry but with a stale PCIBus 
>>> value
>>>      from BIOS POST time (0x6A).  When the kernel boots with
>>>      pci=realloc,assign-busses, PCI bus numbers are reassigned 
>>> dynamically
>>>      and the iGPU lands on bus 0x0B at runtime. amdgpu_acpi_vfct_bios()
>>>      matches entries by bus number, so the entry is never found.
>>>    - The VRAM BAR is unmapped at probe time.
>>>    - The ROM BAR is zero (PCI firmware did not assign it).
>>>    - No platform BIOS mapping exists.
>>>
>>> The UEFI GOP driver initialises the iGPU successfully for early display,
>>> confirming the hardware is functional.  The VBIOS image data embedded in
>>> the VFCT is also valid; only the PCIBus metadata is wrong.
>>
>> So the BIOS on this machine is actually totally fine; it's just when 
>> the kernel is booted to reassign busses there is a problem?
>>
>> In that case; why not detect the kernel was booted this way and keep 
>> track of the original bus number when reassigned to avoid the issue?
>>
>>> The firmware
>>> file can be extracted directly from the VFCT using dd:
>>>
>>>    dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68)) 
>>> count=16896 \
>>>       of=/lib/firmware/amdgpu/1002_1900.bin
>>>
>>> (0x68 is the byte offset of the VBIOS image after the ACPI table header
>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the ImageLength
>>> field in VFCT_IMAGE_HEADER.)
>>>
>>> The driver then prints "Unable to locate a BIOS ROM" and refuses to
>>> bind, leaving the APU completely unusable under Linux.
>>>
>>> Add a fifth fallback: request a firmware file named
>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
>>> request_firmware().  This allows a VBIOS image extracted as above to be
>>> placed in /lib/firmware/ and makes the binding succeed without patching
>>> ACPI tables or BIOS.
>>>
>>> The fallback is only reached if all existing paths have already failed,
>>> so there is no regression risk for boards where VFCT or ROM BAR work.
>>
>> What happens if the VBIOS changes in another way one boot to another? 
>> You might have some other stateful information that isn't updated.
>>
>> The whole thing to me feels like a hack for a behavior we can control 
>> in the kernel when doing reassignments.
>>>
>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
>>> ---
>>> v2: Fix commit message: clarify that VFCT contains the iGPU entry but
>>>      with a stale PCIBus from BIOS POST that mismatches the runtime bus
>>>      number assigned by pci=realloc,assign-busses.  Explain that the 
>>> VBIOS
>>>      image data is valid and document the dd extraction command and byte
>>>      offsets.  Note that the UEFI GOP driver initialises the iGPU
>>>      successfully, confirming the hardware is functional.
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++++++++++++
>>>   1 file changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_bios.c
>>> index aa039e148a5e..86064c753b09 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> @@ -26,6 +26,7 @@
>>>    *          Jerome Glisse
>>>    */
>>>   +#include <linux/firmware.h>
>>>   #include "amdgpu.h"
>>>   #include "atom.h"
>>>   @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct 
>>> amdgpu_device *adev)
>>>           goto success;
>>>       }
>>>   +    {
>>> +        const struct firmware *fw;
>>> +        char fw_name[32];
>>> +        size_t fw_size;
>>> +
>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
>>> +             adev->pdev->vendor, adev->pdev->device);
>>> +        if (request_firmware(&fw, fw_name, adev->dev) == 0) {
>>> +            adev->bios = kmemdup(fw->data, fw->size, GFP_KERNEL);
>>> +            fw_size = fw->size;
>>> +            release_firmware(fw);
>>> +            if (!adev->bios || !check_atom_bios(adev, fw_size)) {
>>> +                amdgpu_bios_release(adev);
>>> +            } else {
>>> +                adev->bios_size = fw_size;
>>> +                dev_info(adev->dev, "Fetched VBIOS from firmware 
>>> file %s\n",
>>> +                     fw_name);
>>> +                goto success;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>>       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>>>       return false;
>>

--------------4Fab3eVhd75eoIYFLlBCZHlx
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amdgpu-radeon-Fix-VFCT-bus-number-matching-with-.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-radeon-Fix-VFCT-bus-number-matching-with-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0MmFjMmZlMzA4NWNjMzU5MzUyM2FjM2U1MTRiYzM2NjE2MDc4YjRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9A
YW1kLmNvbT4KRGF0ZTogU3VuLCA1IEp1bCAyMDI2IDE1OjQ4OjA1IC0wNTAwClN1YmplY3Q6IFtQ
QVRDSF0gZHJtL2FtZGdwdS9yYWRlb246IEZpeCBWRkNUIGJ1cyBudW1iZXIgbWF0Y2hpbmcgd2l0
aCBzb2Z0CiBmaWx0ZXIKCk9uIHN5c3RlbXMgd2hlcmUgUENJIGJ1cyByZW51bWJlcmluZyBvY2N1
cnMgKGUuZy4gcGNpPXJlYWxsb2MsCnJlc291cmNlIGNvbmZsaWN0cyksIHRoZSBydW50aW1lIGJ1
cyBudW1iZXIgbWF5IGRpZmZlciBmcm9tIHRoZQpCSU9TIFBPU1QgYnVzIG51bWJlciByZWNvcmRl
ZCBpbiB0aGUgVkZDVCB0YWJsZS4gVGhpcyBjYXVzZXMKYW1kZ3B1X2FjcGlfdmZjdF9iaW9zKCkg
dG8gZmFpbCBmaW5kaW5nIHRoZSBWQklPUyBldmVuIHRob3VnaAp0aGUgY29ycmVjdCBkZXZpY2Ug
ZW50cnkgZXhpc3RzLgoKSW50cm9kdWNlIGFtZGdwdV9hY3BpX3ZmY3RfbWF0Y2goKSB3aGljaCB0
cmVhdHMgdGhlIGJ1cyBudW1iZXIKYXMgYSBzb2Z0IGZpbHRlcjogdmVuZG9yL2RldmljZS9mdW5j
dGlvbiBpZGVudGl0eSBpcyB0aGUgaGFyZApyZXF1aXJlbWVudCwgd2hpbGUgZXhhY3QgYnVzIG1h
dGNoIGlzIHRoZSBwcmVmZXJyZWQgcGF0aC4gV2hlbgpidXMgbnVtYmVycyBkaXNhZ3JlZSBidXQg
ZGV2aWNlIGlkZW50aXR5IG1hdGNoZXMsIGFjY2VwdCB0aGUKVkZDVCBlbnRyeSBhbmQgbG9nIGEg
ZGV2X25vdGljZSBmb3IgZGlhZ25vc3RpY3MuCgpBcHBseSB0aGUgc2FtZSBmaXggdG8gcmFkZW9u
X2FjcGlfdmZjdF9iaW9zKCkuCgpXaGlsZSB1cGRhdGluZyByYWRlb24sIGFsc28gbW9kZXJuaXpl
IHRoZSBlcnJvciBoYW5kbGluZzoKLSBSZXBsYWNlIERSTV9FUlJPUiB3aXRoIGRldl9pbmZvL2Rl
dl9ub3RpY2UKLSBSZW1vdmUgbGVnYWN5IGdvdG8gb3V0ICsgYWNwaV9wdXRfdGFibGUgcGF0dGVy
biAoYWNwaV9wdXRfdGFibGUKICB3YXMgcmVtb3ZlZCBmcm9tIHRoZSBrZXJuZWwpCi0gVXNlIGVh
cmx5IHJldHVybiBpbnN0ZWFkIG9mIGdvdG8gZm9yIGNsZWFuZXIgY29udHJvbCBmbG93CgpTaWdu
ZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jIHwgNDggKysrKysr
KysrKysrKy0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9iaW9zLmMgICAgIHwgNzgg
KysrKysrKysrKysrKysrKystLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDk5IGluc2VydGlvbnMo
KyksIDI3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9iaW9zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlv
cy5jCmluZGV4IDM1ZDA0ZTY5YWVjMC4uZmE3MzBhZjVlOTc5IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9iaW9zLmMKQEAgLTM3MCw2ICszNzAsNDYgQEAgc3RhdGljIGJvb2wg
YW1kZ3B1X3JlYWRfZGlzYWJsZWRfYmlvcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJ
ZmFsc2UgOiBhbWRncHVfYXNpY19yZWFkX2Rpc2FibGVkX2Jpb3MoYWRldik7CiB9CiAKKy8qKgor
ICogYW1kZ3B1X2FjcGlfdmZjdF9tYXRjaCgpIC0gQ2hlY2sgaWYgYSBWRkNUIGVudHJ5IG1hdGNo
ZXMgdGhlIGRldmljZQorICogQGFkZXY6IEFNREdQVSBkZXZpY2UKKyAqIEB2aGRyOiBWRkNUIGlt
YWdlIGhlYWRlciB0byBjaGVjaworICoKKyAqIFZGQ1QgZW50cmllcyBjb250YWluIHRoZSBQQ0kg
YnVzIG51bWJlciBhcyByZWNvcmRlZCBkdXJpbmcgQklPUyBQT1NULgorICogT24gc3lzdGVtcyB3
aGVyZSB0aGUga2VybmVsIHJlbnVtYmVycyBQQ0kgYnVzZXMgKGUuZy4gcGNpPXJlYWxsb2Mgb3IK
KyAqIHJlc291cmNlIGNvbmZsaWN0cyksIHRoZSBydW50aW1lIGJ1cyBudW1iZXIgbWF5IGRpZmZl
ciBmcm9tIHRoZSBQT1NUCisgKiB2YWx1ZS4gIE1hdGNoIGJ5IGRldmljZSBpZGVudGl0eSAodmVu
ZG9yICsgZGV2aWNlICsgZnVuY3Rpb24pIGFuZCB1c2UKKyAqIHRoZSBidXMgbnVtYmVyIGFzIGEg
cHJlZmVyZW5jZTogZXhhY3QgYnVzIG1hdGNoIGlzIHByZWZlcnJlZCwgYnV0IHdoZW4KKyAqIHRo
ZSBidXMgbnVtYmVycyBkaXNhZ3JlZSB3ZSBhY2NlcHQgdGhlIGVudHJ5IGlmIHRoZSBkZXZpY2Ug
aWRlbnRpdHkKKyAqIG1hdGNoZXMuCisgKgorICogUmV0dXJuczogMCBvbiBtYXRjaCwgLUVOT0RF
ViBvbiBubyBtYXRjaAorICovCitzdGF0aWMgaW50IGFtZGdwdV9hY3BpX3ZmY3RfbWF0Y2goc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQkJICBWRkNUX0lNQUdFX0hFQURFUiAqdmhkcikK
K3sKKwkvKiBWZW5kb3IgYW5kIGRldmljZSBJRHMgbXVzdCBhbHdheXMgbWF0Y2ggKi8KKwlpZiAo
dmhkci0+VmVuZG9ySUQgIT0gYWRldi0+cGRldi0+dmVuZG9yIHx8CisJICAgIHZoZHItPkRldmlj
ZUlEICE9IGFkZXYtPnBkZXYtPmRldmljZSkKKwkJcmV0dXJuIC1FTk9ERVY7CisKKwlpZiAodmhk
ci0+UENJRGV2aWNlICE9IFBDSV9TTE9UKGFkZXYtPnBkZXYtPmRldmZuKSB8fAorCSAgICB2aGRy
LT5QQ0lGdW5jdGlvbiAhPSBQQ0lfRlVOQyhhZGV2LT5wZGV2LT5kZXZmbikpCisJCXJldHVybiAt
RU5PREVWOworCisJLyogRXhhY3QgYnVzIG51bWJlciBtYXRjaCAtIHByZWZlcnJlZCAqLworCWlm
ICh2aGRyLT5QQ0lCdXMgPT0gYWRldi0+cGRldi0+YnVzLT5udW1iZXIpCisJCXJldHVybiAwOwor
CisJLyogQnVzIG1pc21hdGNoIGJ1dCBkZXZpY2UgaWRlbnRpdHkgbWF0Y2hlcyAoUENJIHJlbnVt
YmVyaW5nIGNhc2UpICovCisJZGV2X25vdGljZShhZGV2LT5kZXYsCisJCSAgICJWRkNUIGJ1cyBu
dW1iZXIgbWlzbWF0Y2g6IHRhYmxlICV1ICE9IHJ1bnRpbWUgJXUsICIKKwkJICAgIm1hdGNoaW5n
IGJ5IGRldmljZSBpZGVudGl0eSAodmVuZG9yIDB4JTA0eCBkZXZpY2UgMHglMDR4KVxcbiIsCisJ
CSAgIHZoZHItPlBDSUJ1cywgYWRldi0+cGRldi0+YnVzLT5udW1iZXIsCisJCSAgIGFkZXYtPnBk
ZXYtPnZlbmRvciwgYWRldi0+cGRldi0+ZGV2aWNlKTsKKwlyZXR1cm4gMDsKK30KKwogI2lmZGVm
IENPTkZJR19BQ1BJCiBzdGF0aWMgYm9vbCBhbWRncHVfYWNwaV92ZmN0X2Jpb3Moc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiB7CkBAIC00MDYsMTEgKzQ0Niw3IEBAIHN0YXRpYyBib29sIGFt
ZGdwdV9hY3BpX3ZmY3RfYmlvcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJfQogCiAJ
CWlmICh2aGRyLT5JbWFnZUxlbmd0aCAmJgotCQkgICAgdmhkci0+UENJQnVzID09IGFkZXYtPnBk
ZXYtPmJ1cy0+bnVtYmVyICYmCi0JCSAgICB2aGRyLT5QQ0lEZXZpY2UgPT0gUENJX1NMT1QoYWRl
di0+cGRldi0+ZGV2Zm4pICYmCi0JCSAgICB2aGRyLT5QQ0lGdW5jdGlvbiA9PSBQQ0lfRlVOQyhh
ZGV2LT5wZGV2LT5kZXZmbikgJiYKLQkJICAgIHZoZHItPlZlbmRvcklEID09IGFkZXYtPnBkZXYt
PnZlbmRvciAmJgotCQkgICAgdmhkci0+RGV2aWNlSUQgPT0gYWRldi0+cGRldi0+ZGV2aWNlKSB7
CisJCSAgICAhYW1kZ3B1X2FjcGlfdmZjdF9tYXRjaChhZGV2LCB2aGRyKSkgewogCQkJYWRldi0+
YmlvcyA9IGttZW1kdXAoJnZiaW9zLT5WYmlvc0NvbnRlbnQsCiAJCQkJCSAgICAgdmhkci0+SW1h
Z2VMZW5ndGgsCiAJCQkJCSAgICAgR0ZQX0tFUk5FTCk7CkBAIC00MjQsNyArNDYwLDcgQEAgc3Rh
dGljIGJvb2wgYW1kZ3B1X2FjcGlfdmZjdF9iaW9zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCQl9CiAJfQogCi0JZGV2X2luZm8oYWRldi0+ZGV2LCAiQUNQSSBWRkNUIHRhYmxlIHByZXNl
bnQgYnV0IGJyb2tlbiAodG9vIHNob3J0ICMyKSxza2lwcGluZ1xuIik7CisJZGV2X2luZm8oYWRl
di0+ZGV2LCAiQUNQSSBWRkNUIHRhYmxlIHByZXNlbnQgYnV0IGJyb2tlbiAodG9vIHNob3J0ICMy
KSxza2lwcGluZ1xcbiIpOwogCXJldHVybiBmYWxzZTsKIH0KICNlbHNlCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9iaW9zLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9iaW9zLmMKaW5kZXggM2E4YzUxOTlhMGZlLi41OTM4YThlZDZlNzMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Jpb3MuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9iaW9zLmMKQEAgLTU5NiwyMSArNTk2LDYwIEBAIHN0YXRp
YyBib29sIHJhZGVvbl9yZWFkX2Rpc2FibGVkX2Jpb3Moc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJk
ZXYpCiAJCXJldHVybiBsZWdhY3lfcmVhZF9kaXNhYmxlZF9iaW9zKHJkZXYpOwogfQogCisvKioK
KyAqIHJhZGVvbl9hY3BpX3ZmY3RfbWF0Y2goKSAtIENoZWNrIGlmIGEgVkZDVCBlbnRyeSBtYXRj
aGVzIHRoZSBkZXZpY2UKKyAqIEByZGV2OiBSYWRlb24gZGV2aWNlCisgKiBAdmhkcjogVkZDVCBp
bWFnZSBoZWFkZXIgdG8gY2hlY2sKKyAqCisgKiBWRkNUIGVudHJpZXMgY29udGFpbiB0aGUgUENJ
IGJ1cyBudW1iZXIgYXMgcmVjb3JkZWQgZHVyaW5nIEJJT1MgUE9TVC4KKyAqIE9uIHN5c3RlbXMg
d2hlcmUgdGhlIGtlcm5lbCByZW51bWJlcnMgUENJIGJ1c2VzIChlLmcuIHBjaT1yZWFsbG9jIG9y
CisgKiByZXNvdXJjZSBjb25mbGljdHMpLCB0aGUgcnVudGltZSBidXMgbnVtYmVyIG1heSBkaWZm
ZXIgZnJvbSB0aGUgUE9TVAorICogdmFsdWUuICBNYXRjaCBieSBkZXZpY2UgaWRlbnRpdHkgKHZl
bmRvciArIGRldmljZSArIGZ1bmN0aW9uKSBhbmQgdXNlCisgKiB0aGUgYnVzIG51bWJlciBhcyBh
IHByZWZlcmVuY2U6IGV4YWN0IGJ1cyBtYXRjaCBpcyBwcmVmZXJyZWQsIGJ1dCB3aGVuCisgKiB0
aGUgYnVzIG51bWJlcnMgZGlzYWdyZWUgd2UgYWNjZXB0IHRoZSBlbnRyeSBpZiB0aGUgZGV2aWNl
IGlkZW50aXR5CisgKiBtYXRjaGVzLgorICoKKyAqIFJldHVybnM6IDAgb24gbWF0Y2gsIC1FTk9E
RVYgb24gbm8gbWF0Y2gKKyAqLworc3RhdGljIGludCByYWRlb25fYWNwaV92ZmN0X21hdGNoKHN0
cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LAorCQkJCSAgVkZDVF9JTUFHRV9IRUFERVIgKnZoZHIp
Cit7CisJLyogVmVuZG9yIGFuZCBkZXZpY2UgSURzIG11c3QgYWx3YXlzIG1hdGNoICovCisJaWYg
KHZoZHItPlZlbmRvcklEICE9IHJkZXYtPnBkZXYtPnZlbmRvciB8fAorCSAgICB2aGRyLT5EZXZp
Y2VJRCAhPSByZGV2LT5wZGV2LT5kZXZpY2UpCisJCXJldHVybiAtRU5PREVWOworCisJaWYgKHZo
ZHItPlBDSURldmljZSAhPSBQQ0lfU0xPVChyZGV2LT5wZGV2LT5kZXZmbikgfHwKKwkgICAgdmhk
ci0+UENJRnVuY3Rpb24gIT0gUENJX0ZVTkMocmRldi0+cGRldi0+ZGV2Zm4pKQorCQlyZXR1cm4g
LUVOT0RFVjsKKworCS8qIEV4YWN0IGJ1cyBudW1iZXIgbWF0Y2ggLSBwcmVmZXJyZWQgKi8KKwlp
ZiAodmhkci0+UENJQnVzID09IHJkZXYtPnBkZXYtPmJ1cy0+bnVtYmVyKQorCQlyZXR1cm4gMDsK
KworCS8qIEJ1cyBtaXNtYXRjaCBidXQgZGV2aWNlIGlkZW50aXR5IG1hdGNoZXMgKFBDSSByZW51
bWJlcmluZyBjYXNlKSAqLworCWRldl9ub3RpY2UoJnJkZXYtPnBkZXYtPmRldiwKKwkJICAgIlZG
Q1QgYnVzIG51bWJlciBtaXNtYXRjaDogdGFibGUgJXUgIT0gcnVudGltZSAldSwgIgorCQkgICAi
bWF0Y2hpbmcgYnkgZGV2aWNlIGlkZW50aXR5ICh2ZW5kb3IgMHglMDR4IGRldmljZSAweCUwNHgp
XG4iLAorCQkgICB2aGRyLT5QQ0lCdXMsIHJkZXYtPnBkZXYtPmJ1cy0+bnVtYmVyLAorCQkgICBy
ZGV2LT5wZGV2LT52ZW5kb3IsIHJkZXYtPnBkZXYtPmRldmljZSk7CisJcmV0dXJuIDA7Cit9CisK
ICNpZmRlZiBDT05GSUdfQUNQSQogc3RhdGljIGJvb2wgcmFkZW9uX2FjcGlfdmZjdF9iaW9zKHN0
cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogewogCXN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAq
aGRyOwogCWFjcGlfc2l6ZSB0Ymxfc2l6ZTsKIAlVRUZJX0FDUElfVkZDVCAqdmZjdDsKLQl1bnNp
Z25lZCBvZmZzZXQ7Ci0JYm9vbCByID0gZmFsc2U7CisJdW5zaWduZWQgaW50IG9mZnNldDsKIAog
CWlmICghQUNQSV9TVUNDRVNTKGFjcGlfZ2V0X3RhYmxlKCJWRkNUIiwgMSwgJmhkcikpKQogCQly
ZXR1cm4gZmFsc2U7CiAJdGJsX3NpemUgPSBoZHItPmxlbmd0aDsKIAlpZiAodGJsX3NpemUgPCBz
aXplb2YoVUVGSV9BQ1BJX1ZGQ1QpKSB7Ci0JCURSTV9FUlJPUigiQUNQSSBWRkNUIHRhYmxlIHBy
ZXNlbnQgYnV0IGJyb2tlbiAodG9vIHNob3J0ICMxKVxuIik7Ci0JCWdvdG8gb3V0OworCQlkZXZf
aW5mbygmcmRldi0+cGRldi0+ZGV2LCAiQUNQSSBWRkNUIHRhYmxlIHByZXNlbnQgYnV0IGJyb2tl
biAodG9vIHNob3J0ICMxKSxza2lwcGluZ1xuIik7CisJCXJldHVybiBmYWxzZTsKIAl9CiAKIAl2
ZmN0ID0gKFVFRklfQUNQSV9WRkNUICopaGRyOwpAQCAtNjIyLDM3ICs2NjEsMzQgQEAgc3RhdGlj
IGJvb2wgcmFkZW9uX2FjcGlfdmZjdF9iaW9zKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQog
CiAJCW9mZnNldCArPSBzaXplb2YoVkZDVF9JTUFHRV9IRUFERVIpOwogCQlpZiAob2Zmc2V0ID4g
dGJsX3NpemUpIHsKLQkJCURSTV9FUlJPUigiQUNQSSBWRkNUIGltYWdlIGhlYWRlciB0cnVuY2F0
ZWRcbiIpOwotCQkJZ290byBvdXQ7CisJCQlkZXZfaW5mbygmcmRldi0+cGRldi0+ZGV2LCAiQUNQ
SSBWRkNUIGltYWdlIGhlYWRlciB0cnVuY2F0ZWQsc2tpcHBpbmdcbiIpOworCQkJcmV0dXJuIGZh
bHNlOwogCQl9CiAKIAkJb2Zmc2V0ICs9IHZoZHItPkltYWdlTGVuZ3RoOwogCQlpZiAob2Zmc2V0
ID4gdGJsX3NpemUpIHsKLQkJCURSTV9FUlJPUigiQUNQSSBWRkNUIGltYWdlIHRydW5jYXRlZFxu
Iik7Ci0JCQlnb3RvIG91dDsKKwkJCWRldl9pbmZvKCZyZGV2LT5wZGV2LT5kZXYsICJBQ1BJIFZG
Q1QgaW1hZ2UgdHJ1bmNhdGVkLHNraXBwaW5nXG4iKTsKKwkJCXJldHVybiBmYWxzZTsKIAkJfQog
CiAJCWlmICh2aGRyLT5JbWFnZUxlbmd0aCAmJgotCQkgICAgdmhkci0+UENJQnVzID09IHJkZXYt
PnBkZXYtPmJ1cy0+bnVtYmVyICYmCi0JCSAgICB2aGRyLT5QQ0lEZXZpY2UgPT0gUENJX1NMT1Qo
cmRldi0+cGRldi0+ZGV2Zm4pICYmCi0JCSAgICB2aGRyLT5QQ0lGdW5jdGlvbiA9PSBQQ0lfRlVO
QyhyZGV2LT5wZGV2LT5kZXZmbikgJiYKLQkJICAgIHZoZHItPlZlbmRvcklEID09IHJkZXYtPnBk
ZXYtPnZlbmRvciAmJgotCQkgICAgdmhkci0+RGV2aWNlSUQgPT0gcmRldi0+cGRldi0+ZGV2aWNl
KSB7CisJCSAgICAhcmFkZW9uX2FjcGlfdmZjdF9tYXRjaChyZGV2LCB2aGRyKSkgewogCQkJcmRl
di0+YmlvcyA9IGttZW1kdXAoJnZiaW9zLT5WYmlvc0NvbnRlbnQsCiAJCQkJCSAgICAgdmhkci0+
SW1hZ2VMZW5ndGgsCiAJCQkJCSAgICAgR0ZQX0tFUk5FTCk7Ci0JCQlpZiAocmRldi0+YmlvcykK
LQkJCQlyID0gdHJ1ZTsKIAotCQkJZ290byBvdXQ7CisJCQlpZiAoIXJkZXYtPmJpb3MgfHwKKwkJ
CSAgICByZGV2LT5iaW9zWzBdICE9IDB4NTUgfHwgcmRldi0+Ymlvc1sxXSAhPSAweGFhKSB7CisJ
CQkJa2ZyZWUocmRldi0+Ymlvcyk7CisJCQkJcmRldi0+YmlvcyA9IE5VTEw7CisJCQkJcmV0dXJu
IGZhbHNlOworCQkJfQorCQkJcmV0dXJuIHRydWU7CiAJCX0KIAl9CiAKLQlEUk1fRVJST1IoIkFD
UEkgVkZDVCB0YWJsZSBwcmVzZW50IGJ1dCBicm9rZW4gKHRvbyBzaG9ydCAjMilcbiIpOwotCi1v
dXQ6Ci0JYWNwaV9wdXRfdGFibGUoaGRyKTsKLQlyZXR1cm4gcjsKKwlkZXZfaW5mbygmcmRldi0+
cGRldi0+ZGV2LCAiQUNQSSBWRkNUIHRhYmxlIHByZXNlbnQgYnV0IGJyb2tlbiAodG9vIHNob3J0
ICMyKSxza2lwcGluZ1xuIik7CisJcmV0dXJuIGZhbHNlOwogfQogI2Vsc2UKIHN0YXRpYyBpbmxp
bmUgYm9vbCByYWRlb25fYWNwaV92ZmN0X2Jpb3Moc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYp
Ci0tIAoyLjUzLjAKCg==

--------------4Fab3eVhd75eoIYFLlBCZHlx--
