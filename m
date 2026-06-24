Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D69CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5028E10EABE;
	Wed, 24 Jun 2026 15:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IuoLAyjL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5764E10E77C;
 Wed, 24 Jun 2026 15:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgjYpVvVx2tnkbSsmo9HHaylxb0GqGnqV4RMACrhw9VgBbrkpgJqopY9gOuqF+SWNfZsyQDPmcQeuDdx7Hpsq3lrTUaAznt3r4Gkz4Dogp2jjs7Ixsl2M6GTHr5fYMvWxxAn+PDpo9btTTHosbVcwgLnZa78tWbYCzW3mtksuHOnmYkMpI2cyg4OOJDidvc+v8Daj26J4TPq64h4RfuhQFCvKT+zA0YU6rD9YWX71HXNeA8pX7Lvnt/zVaX0dxZBMW02SnBQ2NnU2ZbzMX0rq96x3eSXSXanKQYPCLRqy15/LsV1fRp0bwTbOLCBlYscGwP/GLeXe9lqK4YmD0aBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnDEclY1MBkhCqJjL3pmn1S0sVX5RnzyOePHu/LpQb4=;
 b=u1zq9NkUoYa0CnYDf6FUVS+DdwVdSPEDmHKGJLSLbwCmQWxHCCg4471x6Qh61YiiUYWEw9R0yNGPxNveGbLajQmEUdci0Mflz1jdsk2Z1dZSeFrh3aLeUYz8CFWbn2TjjUY0yWvTNIIwjJ5QpJsmBNknm1VrcMVJP/pa+sI6bpyidrOfyQNvuwyCWQPVnqycI0QIc3czAODVRNPaylkNXZZK5aTuoUIaaC6FOIooOQ/N12L3MMKZusi3LI/0btXSjtzvOu57oNGQknVwhViPXqAO4+ejsFpnpgZqx2F9j3izvyPRHK5Ih0AzyVLzs1qcGjBB0bGPfeyx7Jvel8es1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnDEclY1MBkhCqJjL3pmn1S0sVX5RnzyOePHu/LpQb4=;
 b=IuoLAyjL9Lc1yefh6rqGFbIOu0N9M3X1VfOKPXKsMPi2DDLoWPwLsRo7U7mS5ZklVWOiAI5y9L4OlpQCBsQtMnsT6IWlBxv9M1xP+7M7lMyxbY0h1sPsU6+mOLxnKlupwO5YV6kgUsyNTKbhLRsCz9+UKDxorHkrkG8sjx40fMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 15:30:25 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 15:30:25 +0000
Message-ID: <09a37c38-3f99-40bf-9a87-f88298ce349a@amd.com>
Date: Wed, 24 Jun 2026 11:30:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amd/display: Pin native scanout to VRAM on
 large-carveout APUs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, Melissa Wen
 <mwen@igalia.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, natalie.vock@gmx.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
References: <20260616071037.26718-1-matthew.schwartz@linux.dev>
 <334d4642-a7ce-4d04-ab14-6b95653e6f86@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <334d4642-a7ce-4d04-ab14-6b95653e6f86@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::21) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efd715a-6ff4-4e33-c181-08ded2058323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: bSV9dvscnjD4QiFUEFYuFb1ulJlXsqmUKlZ73a7j4wizEC3AtKW6iy3/fS44JQoe2rUIX8hecakH7LRTOfpyglr6hO6lKx1hNMar7AUChwCm4sMFF/uw4ovNg++5wU03Pdm/oQ27v98QEg7AMFBawYqJUXG6JuyMIdeNa/omh9RwnqV+OH185Ar8TtJ0USaZ0kiaZJNalIZsknXzTSEx7/Ky4aLY5cut4XMyIlXia2Pm7k55q6eH+wvUuFd/+TnYPRxrytvRLMA740qRfjmc/U2EMBzLWaEozH4OQbU5EyZJCeKSiXmfA2ClQgiWA5yYukB18CGTdlAl3D++EBKqB1M8CYcZsO/XI91IQaQxR6nufC9TqfxRjYvoCygN0xCn2UcZEnlMao8mo/KGu/rK2YKfGobUW5b3frok98CRXblr1g5Wx2ToI2MyLpiTQXiwJjXpbnAvgJRrm8+QTLzw9OkYW543C8YP2bed0NrWLz+YbycZ56/BYXBFLSBRNliC/jsGo/SbbowEQlLksT7atbrDvtxvPEFHh+xdAHOt5u5ZAbV0/iqNpivWyyVKTm/kkBWJRig6HuKTW0ZIpBQbPJ6iQkHk+PwsK1MwqLca0gc5tVAHWsnH4/eaSl21u17xDxAJ6b3ilJ/YBN4XAq65qenDBb//1JTsKlTYe5U80Tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWh4UFFDeGFPVHVwU1AwV2hjVnFJVUh1b2p6c2tncUY5R0RkVWY4M2srM0Nw?=
 =?utf-8?B?dHBsei9qeENhbVlCSHJxNkdaaTRobGhRb1pKRjByRGYxbVh5emNkb2tCUXZy?=
 =?utf-8?B?cWR2ZmJKb0hHLzVzZVdaUWJpQTlzaW1GelZoT3VmSHRxclY3SEFiR0ZFK0Na?=
 =?utf-8?B?SDhxbnBxblM1Z1czbVNpOTYyL1daUE1MMlFxU2FuN0V3OWtDSHk4aHBnTkt4?=
 =?utf-8?B?REFmZ2NQS0FsRkNnL3NlbVdrWkZRcThoNXdDb3p3bzRUZEoxL05OMW1Kb1hO?=
 =?utf-8?B?cHZoREZlUm9MMjhkaElva3E3YU1VSTIyUldOSVNUYjRZdUFVbURhSGtMVzVV?=
 =?utf-8?B?bUxYU2c4bzlvVGNsaSs2NHowRGs0SDF0cmxUTnRxNzBaL21ZSm9qLzV3SkhV?=
 =?utf-8?B?ZGdLTlFpNTRmUjZETWxmM0IyeldqZnRKc3ZxSTFDRkN1bmJ1djZUQlZvU0xB?=
 =?utf-8?B?UkJkNW0wZnZ3Y3FpeURaenl5VjFhWUVMVTRIZ1h2R1piSmRRMk02NjNMNFQ3?=
 =?utf-8?B?NzZhQTBQRnNxSTNXWGlWNlJQTFlrTjg2OEFLcElkVlE1QXlsM3ZhN0pPYXlN?=
 =?utf-8?B?N2NKaEUwQlZqd1ZDVE0wWmJYNk1WakIxbEFPaHpSU2R6bmNBaWpJblFKT3M0?=
 =?utf-8?B?Smh2T21kVXpDZm42bWFaY21ReTY4MVRPZ09OMVIwdnc2WFdyNDI0MUszWWdZ?=
 =?utf-8?B?amVtQ1hpK3BxbEk4bFRxa0VDd1VEdXpsdWtzZ1htNi9iY253MUpQY3VlWXpv?=
 =?utf-8?B?UXNJZ3djbzRDalJNMFRZOEd4Q2pDM0VMMHloL0dncU1xWWY4c2dpOTI2NDZX?=
 =?utf-8?B?NEZXVVpDNmJLdHRjcmZXT1Ntejg2c2FzZGtsV1ZqWDBKUzh5MEllVTVZZWkz?=
 =?utf-8?B?MDVVQTczUzR4eHJBTXFVaFgyVmdCQS9OVm9zTW56UkZsVi9SSzRCTFNiZTE4?=
 =?utf-8?B?Z3RwWFI5NlJlakd6ZEV3dkZXVDAxOElML2xWTlBJc3phWmMzS1NUR2d4cFlD?=
 =?utf-8?B?REErL3V2MHlOT3M1OGxCVm1kWDVydU5RTVpyUTd0L1l2N0RDT0U5NmlnY0Vz?=
 =?utf-8?B?RVlmZHZqa0RLNkRRQUVKRHRlbW10K0xScVBqaTJJRDNiYkNPeml0MzNTSjgw?=
 =?utf-8?B?OW9GYjE1enUzWmN3WEpvV3NoaXN4aVBZU21NQzZCaFBJWDJCMlFZQnFDWS82?=
 =?utf-8?B?b3poNGYrcUpyYThiVzZpRm9KN1ZCS0EyVWdDejE3ZFlINFpXSjZORXZmZ3Uw?=
 =?utf-8?B?d1hkUGw4emxNVUowZFkxSm10bEpra2ZOSGE1dlk3cFFQeW9nQ2xQNUVpVXpl?=
 =?utf-8?B?Mlk2aElFVHF4Q3lXMmdOUTNsREs4eTYrNTFob24vZTlYWG1teDBnOExLdlpC?=
 =?utf-8?B?WVBwMUJaMG10MUt4QlByajdHeUM4aGVFbHMxazdXd2N5VXNBdmg2bjRFTTdL?=
 =?utf-8?B?WElJUjB0M3RjN1NVT3NIbTNwZm1nTVdyWDRVVTMxTXRCVHRFTnRJQ1FnWFdZ?=
 =?utf-8?B?NHhIcFdnNmRwUzdyOVJ2TG5TMDlDellqdHVaS01ubUtQTkxRQ3RIaEpMZzl5?=
 =?utf-8?B?d0lYc2dXMU8yMXU4b0NxUDZDWmRDd1B0WVdJNGtJbm55d0pIUjdQY3hWTWl0?=
 =?utf-8?B?eGtyWXZ4WG04eU5oUFdCWkxGcjUvUjNUampMbGl1bFhhTXJ6NUNmU1JxazVq?=
 =?utf-8?B?ZEFBbG8zRVVXRnBzM1F3eURVSzZqWGhmN2JlSDZsLzFnUEVxdENtT2hmVU9F?=
 =?utf-8?B?U1VmRFhPMVM2azZLK0NvcWhlWDluWFJ3NkV0MGhnMTIzcWRtaFpMalBWRjkv?=
 =?utf-8?B?VStwRmQxTkRKbXJvaVdSMVJqazFlUjV4ZjNVS3BXYTE4eWxkRHBFMGg3cmlr?=
 =?utf-8?B?VHlHQlhTMWlGbDVGY1BjWTdzejBROTRCSHVNUGEyVERJVnJCQzd6MU84Qlc1?=
 =?utf-8?B?bGhRc3pUVExGZHlKVkUzUnhzM3BIclE3akFFUXRpaXJpa1Rma0RINEtXMTk1?=
 =?utf-8?B?enJ6R0pwVGk1TVMrWjdESVcwVERoM0FhMmprb0NTOTJ4SHBoU2Z6d1Zjc0xs?=
 =?utf-8?B?blFCZ3A1VVkycWo2SkFrTEc5dGIzeitka0U1NW41MkRka04xVUtLeEF3ZlFx?=
 =?utf-8?B?YkN5bzlLUlNwTFVtSnczTmFkS3dVNUc1UkdPV3lpbFR1L0NoRXQyQ1BEYis3?=
 =?utf-8?B?ZzZTdXJWK2VOc2s1dXgzR3RLTHNQZXhVN1hMZ1RJdXNZWmZxUGs3U0xjNklO?=
 =?utf-8?B?dXQvZXBWSXp5UVVXK0c5eVFoZXBCYW9FWE81RC9vTXJZMld4Q0c3cmVyc3Bk?=
 =?utf-8?B?dElZeWg4S2lFdkhHc0UvNXRySTNPekp1em9OYUFKRU5VOWpmK2pNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efd715a-6ff4-4e33-c181-08ded2058323
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:30:25.1226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GH8VDXkKW/kzxHJ02ZZ6qLxxCMs2X3Uylt7kxf0UAIjbWrH3fV5sr2sT1lC77rKgbpHWY3jGHQ2uRUDfdHMaRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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



On 2026-06-16 03:31, Christian König wrote:
> On 6/16/26 09:10, Matthew Schwartz wrote:
>> Native scanout buffers on APUs are pinned with the VRAM|GTT domain, so
>> under VRAM carveout pressure a swapchain can end up split across VRAM and
>> GTT. The scanout buffer's memory type then changes from one flip to the
>> next, and amdgpu_dm_crtc_mem_type_changed() rejects an async page flip
>> across the change. The result is repeated async page flip failures,
>> observed as choppy updates under carveout pressure, until the buffers
>> reconverge to a single domain.
> 
> That's intentional behavior.
> 
>> Pin native scanout buffers in VRAM only so the swapchain stays in one
>> memory domain. Restrict this to APUs whose carveout is larger than

Above you mention that under VRAM pressure a swapchain can end up split
across VRAM and GTT. Wouldn't restricting the swapchain to VRAM now mean
that in those cases you fail to allocate the swapchain entirely?

Harry

>> AMDGPU_SG_THRESHOLD, so small-carveout parts keep their existing VRAM|GTT
>> placement, and fall back to GTT when the buffer does not fit in VRAM, so
>> the flip still succeeds and the swapchain stays in one domain. Imported
>> buffers may only be pinnable in GTT, so leave those on the default
>> domains.
> 
> The display guys need to take a closer look at that, but it sounds like what we used to have before and that caused problems.
> 
> We somehow need to change the DC stuff to allow switching between VRAM and GTT frame buffers to fully fix this.
> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> ---
>> Hi,
>>
>> This came up while testing my kernel patch to fix mem_type detection for
>> async flips here: https://lore.kernel.org/amd-gfx/20260611154438.571685-1-matthew.schwartz@linux.dev/
>>
>> I found a new issue where splitting a swapchain between VRAM and GTT
>> causes a noticeable stutter in gameplay if gamescope is using direct
>> scanout and tearing is enabled while a game is already running.
>>
>> Once a swapchain is split across the VRAM carveout and GTT, the scanout
>> buffer's mem_type changes from one flip to the next, so
>> amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Under direct
>> scanout with tearing that rejection recurs every time the displayed buffer
>> crosses domains, which is what surfaces as the choppiness. 
>>
>> With this patch, I can enable tearing on top of an already-disabled frame
>> limit mid-game and no longer reproduce the choppiness.
>>
>> amdgpu_gem_info confirms the swapchain converges to a single domain
>> instead of splitting across VRAM and GTT.
>>
>> Before:
>> 0x00000f81:      3981312 byte GTT exported as ino:275 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88248 signalled
>> 0x00000f82:      3981312 byte GTT exported as ino:276 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88224 signalled
>> 0x00000f83:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:277 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 88236 signalled
>>
>> After:
>> 0x00000f82:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:548 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 822258 signalled
>> 0x00000f83:      3981312 byte VRAM VISIBLE exported as ino:549 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822255 signalled
>> 0x00000f84:      3981312 byte VRAM VISIBLE exported as ino:550 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822261 signalled
>>
>> Does this seem like the correct approach to take for fixing the observed
>> issue? I wanted to start with an RFC to make sure I didn't overlook
>> anything obvious or miss any better methods of fixing this.
>>
>> Thanks,
>> Matt
>> ---
>>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++--
>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index 23a9faa2ea89..b99f938e58ec 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> @@ -932,6 +932,7 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>  	struct amdgpu_bo *rbo;
>>  	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
>>  	uint32_t domain;
>> +	bool pin_vram_only;
>>  	int r;
>>  
>>  	if (!new_state->fb) {
>> @@ -958,13 +959,35 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>  	if (r)
>>  		goto error_unlock;
>>  
>> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
>> -		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>> -	else
>> +	/*
>> +	 * Pin native scanout in VRAM on APUs so a swapchain stays in one
>> +	 * memory domain. A VRAM/GTT split changes its mem_type between flips
>> +	 * and amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Skip
>> +	 * small carveouts that may not fit, and imported buffers.
>> +	 */
>> +	pin_vram_only = plane->type != DRM_PLANE_TYPE_CURSOR &&
>> +			(adev->flags & AMD_IS_APU) &&
>> +			!rbo->tbo.base.import_attach &&
>> +			adev->gmc.real_vram_size > AMDGPU_SG_THRESHOLD;
>> +
>> +	if (plane->type == DRM_PLANE_TYPE_CURSOR || pin_vram_only)
>>  		domain = AMDGPU_GEM_DOMAIN_VRAM;
>> +	else
>> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>  
>>  	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>  	r = amdgpu_bo_pin(rbo, domain);
>> +	if (r == -ENOMEM && pin_vram_only) {
>> +		/*
>> +		 * VRAM could not fit the buffer. Fall back to GTT where
>> +		 * allowed so the swapchain stays in one domain.
>> +		 */
>> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>> +		if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>> +			domain = AMDGPU_GEM_DOMAIN_GTT;
>> +			r = amdgpu_bo_pin(rbo, domain);
>> +		}
>> +	}
>>  	if (unlikely(r != 0)) {
>>  		if (r != -ERESTARTSYS)
>>  			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
> 

