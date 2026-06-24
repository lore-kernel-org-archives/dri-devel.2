Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BD2CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9551710E0C6;
	Wed, 24 Jun 2026 17:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AL53kXPD";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A075C10E0C6;
 Wed, 24 Jun 2026 17:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7tZ/btR1sG40Pz9DFriTUGyS7TgYmi4EasQlhxJAR2cpu+5cJgPq+gKBI0fIWaW5aw7vc8aok5496TU/Jj0ndmMISEbbLXwThyq2/dUmBDr0c1eSUFuLqpuFU7OenOKewPC338jsqxqnGoVo7RTF8k7l2SPc8NpAeKG+gJ4vC9acCIrzos9pNnr5KDDE9eJxpjuy51f1tc1MIsxpzIu7a1XS7prhSheB+WOH6TKM4PPaXOY5yF9gw6UaCTA+qOtkgbV9cqjIVX/aXtfV3OzDXFK0Q5Io5Jz/6m39ipPFlY8pWJVFfMapEr9z5G1D1pPanvOiCfXWHN6+6IS5yFZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0j10DBz6sMFGFR+1nvmsXMB450XWQZmX/qeMY/ZF+0=;
 b=t985mA6hWUftXtzkFqcBZUfvAtjRSLBUiVH/8fuznay2ooZepbGWp9JB0vdDmhnZPDH+g9X49zy1sjyAq+R8RGBrKnvsLuWqO4EVFr9OhVy3XnTl5eI8A9QLAzCfN/Y2bD4J88Tn89MUCSYPCHLu7xVvsveJiYcnVgXRm31FTTvEuGgu6hKHRmTn9u1Lj16/Ue07gKtOrxkV2o7C5wRcwiZtMlCHYrYfhRel45plPeW7a+tNimcBCCNPahdlzXixt2f0SY8d7FmWlrk7GYvuG2q35VIcX0KmGmgeH4xNMj6USna5YtLTQa+33dWtZTv+kTu7ZbJgmTiUhzsypgld0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0j10DBz6sMFGFR+1nvmsXMB450XWQZmX/qeMY/ZF+0=;
 b=AL53kXPDnKH4N2zVtAPjZ38kAoZD9ObHrLjh2ZJzPKPtDXaER/4D2gRsZliA/YsDxQYyjYYJO9TCY8C0H15KAjgTGpYrxQ5D22Q0dwpXeUIRqzuas2NjAl08ItN7H0DuuhsO334BK7+mJ8pCekYq59nNXf142bQBV+vDY0bl/G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 17:55:31 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 17:55:30 +0000
Message-ID: <faa1c424-2282-4e70-9934-e29f437f8bbb@amd.com>
Date: Wed, 24 Jun 2026 13:55:26 -0400
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
 <09a37c38-3f99-40bf-9a87-f88298ce349a@amd.com>
 <9b96d6a5-7c3c-4bd5-8785-76c9642bc933@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <9b96d6a5-7c3c-4bd5-8785-76c9642bc933@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::25) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d9b742-f743-4316-9179-08ded219c80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 8b1pGfGBCZgTo6nh4GX/1LkJl6C9x1GiIkvS3zLy536dHQgyXSmo8wko+8RDaB1GgVW+dY+uGiIspe72xJxjPYABSlnQuVJHDgRFcfdyDW2LAxujlxa0GAbSoqW0kIY6dnvr2/he7n26HT5dry/RKXQ/1I5dGg5PZxsuO6d0I3ewIll37dQiJ6X8IEPIgFKtk9PeC5U4KohoVbD3zOKNZvjYxn2oEoEC/v/X7DrJH93LAhPr4Kgfe8uXW5y3NhTbsStErfLUDOA8c8S6K3CS1bako34c50YlInFLCkS8/3AVerGbALU08NLM6aGNDBnx0h4mZkD0SuQuQlygjUiov4J8Le0prFw+kMNEijBlQ1/MfH1Mrhqag3vOkcRR4wUtsw9LHgBGpMhT7hyRT7Bf/Ekw+I2oNm8+ydBkjjLJsbg134nM6iiKb0xI+NkZ8WqEH/xeCTvJSDt5TaqPIVikP/6XJvNVosiHEo1rrkbxRVXrg5/c9RqzlVEVh3O11zDL3xmej4QKnsD3LlbxZb2uPVykxFbLniVrq7NPkuGRRyZEYOLM81KNpKq8GI/N/ua33QbmCr9QisKOhQN9BvMb/2i7Nc4z42lmyQ2Yr3HGvwl5h5TopMvwfr4vX5+ODX4zceaxDhiZK5oBU9kxb5vxrGFML/wWJL/gMCcxHPBuxzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bytwV1FJblVIaERZZ2xRTFNYazMzcDl1VnF6aVFPa3FKT1BEK3F4SjhUUkxP?=
 =?utf-8?B?V2JDa1RleHZkOHBuUGxiL1llVjdPbEVvYVRSVnFIa3Rlck9NUnA4cmNXV3cr?=
 =?utf-8?B?bmdBSDhLTllwVUdSRE5FVTZkaW51R2VyeTFhWWxWNWVzMlh5VHhueXhLRlU2?=
 =?utf-8?B?c2FhbkZMMmx0N2J6T01HMUZoWWZQWjE2cGdxeE55c2F6ZjBDblp4L0IyV2Q2?=
 =?utf-8?B?Y1lyMjRPKytIZlEvSUxKbDZRc1J6ZzcrNHNhSjNnazkreXhzNnF6S28zNW9N?=
 =?utf-8?B?RmhwRnRXaWp6U014RzNBVzNSRU9qVDJROUJFWitjc0dweE5MTDBaVVBtYzQz?=
 =?utf-8?B?RWNLRmNMS3laS2lYRDZnT1M2djRQc3FSMXpmWVN6bm85RktjRWpLaS85eDI2?=
 =?utf-8?B?M3J4akVLSGdaUHJ2ckRBb2w2R1QvME9EUVZSek5WM0lxcWJmbGdVZ05adTd2?=
 =?utf-8?B?VW5IUzlKNjFONUpDUGsrZTlBRWpiMFFvaXZobGtEYm1rMFM0OVl0R01KQnFm?=
 =?utf-8?B?cG9oU2lrbzJMM0g1aXFTUXE5UlVKcm1laXdSQ25ZcTNUSWJUNkQwZ2pxS0pa?=
 =?utf-8?B?ejFUdjJ2cUFCc3hQNG5OY0RMbVU3UDdvQVFYSlEydnNMMWdabTVEVitYem9P?=
 =?utf-8?B?aXA3OUJRdVh1K1FnVVMvRnY0cFZYS1Rwa0JvNURpQWVic2Y3NWdFR3JyTjRT?=
 =?utf-8?B?ZkN5di9vbWdabzdNVE84Ny9lY0U0WTEyeTdGL2Z2QmhzSjNvMW9UQmlpelYy?=
 =?utf-8?B?UXNwWFVJU0VNdVBxbm5FVmFyaTdzNEJNSW5vU3BYNFB3dGQ5NGtqQ0hCMXdn?=
 =?utf-8?B?ZDJwLzJnUGQ1RzJhS3BKUHRhRnpFRHdCaHlvbTloQ3BaRktGTmI4Y0Q5TC8v?=
 =?utf-8?B?Yjd3QlB1MFVJQmtaL2o5eHMwQWJVVmhscTE0LzkrTmpZcEhtZnBuVVM3VVNJ?=
 =?utf-8?B?eXJ5cE8ya1IvMGd5c3pvd3dXd3h5MDRybDNkd2ZqMzVUZHozSG5GRjZUSDZw?=
 =?utf-8?B?TlZLUzNqSW5TSjJNUzU4dzBFN2Y2LzZqNjRDbll5OHhLRjlqUkVtMmxNd0xB?=
 =?utf-8?B?UmxNNC9MWXFXdW5ZaHc0YTRBeVN5LzZhYUZHMUUwYW9JUnpITkJXVXduVFQ2?=
 =?utf-8?B?aFgvRjZ6MG43MjN4UytoZ2FobzdDd2dNdjcrbi9nakJHSTFYWVNpdWptUlRW?=
 =?utf-8?B?M1FwaVNLYUp5SXk5WGMwUUdPUENUVm5NYXEvUXJVdFcydXpXWWN4VmhPeng1?=
 =?utf-8?B?NXE5eExmejI0NTJyd0UzRk1vRlFxdS9OR0pVQjVPZ2ZYT3FlQmg1MGtEellr?=
 =?utf-8?B?SHR6OFRCZU43WEtoaGxidUMrb3FhcUlIOU81Q0kwRG94bEdZbklaWktjdHgx?=
 =?utf-8?B?VnJBRkE1VzFIVjd6elJiKzQydGQrUGNoeGNQMDdrZlo1VXNTMWc3QVNBZTBv?=
 =?utf-8?B?Nm9sYktlMDQ1N3Y4N3ZNNnU3dXFweVU2dldKemZocXY0WG5kWlNxRWUzcmhj?=
 =?utf-8?B?NlkyTklvYXFOdm1VZWxLd2c4c05QbFFacEY5QlZRMTJzcEZqTklBY0plNVFj?=
 =?utf-8?B?Q2Z4SkVWTUJmOCtRT2tPY0NiOGJLL3dXdkMwSk8rYmlzUDdUZ1JrSStlOEdE?=
 =?utf-8?B?eTNYQ1JYVXlCL3BMaDlBM2U5VjdyNktZWlJDZFJFRU9wZm1nT3llOGJ4SFhm?=
 =?utf-8?B?aTVjUWt2dVlmaXZLSytRV0FJMnkzbXFmc2Z4RWpHSTJPcEcycEhKQkp3b0d0?=
 =?utf-8?B?MUZkN1hPQUZkVGZWRUV4N0lWeTFDVUl1eVZrRGxNRFl1SG1PM3ZYYWF6NWJI?=
 =?utf-8?B?UUlyWSs5d0VySXBjTTVGcnVJOERvWHZlTC9UTStlelZtNTFPdnk5NTd3aVJM?=
 =?utf-8?B?dXB3RnRWTXRKVU5OaThhL2llQ21uZFdWMUoySEhSOUpRcTNRVG8zSXVtUThy?=
 =?utf-8?B?YWNBaHRqK3lYVk5JY0RPYjhBSFZkM1JWem1BMldXOGJSQVdwY1E1QmswMCtE?=
 =?utf-8?B?R1djdkhpUzFWT2VBUTRwN1lXcXM2c0F3Mi9hSndpajBwUzhyeHBvRjFpclU0?=
 =?utf-8?B?dUlCT3dLNDJyT1hJV1BzdjQ5d1VBL1FuVkJzRCtSWWRSa1NsYmhJdXduY2Rm?=
 =?utf-8?B?MGtEYUlBb2VrVFczYVJMSFZMRmo4d0xPdmkvUjMrUjdFTG43MmhZcG5kWVFE?=
 =?utf-8?B?QjUvVUxNZmJSdm9NeStoKzQ3Unk3Wnd0cTcxS2FrbUJjbTE4V0VncDJMaGxa?=
 =?utf-8?B?eTNzL1NrVjFiUXA1RnJSNnQzNnRYWFQ2N1ZyNUdqRllkSzB1UWlycUtQQkRM?=
 =?utf-8?Q?zGdLmz8WQ23qAecp20?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d9b742-f743-4316-9179-08ded219c80e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:55:30.7245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiR+rUEDwQMe4G9ft8WBT+nGBQ0y2SsUJiWjU1siygoQWVijW09MZ1VWr1RUFZYeSQqKJrJroBt48MPyKJ59tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
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



On 2026-06-24 11:52, Christian König wrote:
> On 6/24/26 17:30, Harry Wentland wrote:
>> On 2026-06-16 03:31, Christian König wrote:
>>> On 6/16/26 09:10, Matthew Schwartz wrote:
>>>> Native scanout buffers on APUs are pinned with the VRAM|GTT domain, so
>>>> under VRAM carveout pressure a swapchain can end up split across VRAM and
>>>> GTT. The scanout buffer's memory type then changes from one flip to the
>>>> next, and amdgpu_dm_crtc_mem_type_changed() rejects an async page flip
>>>> across the change. The result is repeated async page flip failures,
>>>> observed as choppy updates under carveout pressure, until the buffers
>>>> reconverge to a single domain.
>>>
>>> That's intentional behavior.
>>>
>>>> Pin native scanout buffers in VRAM only so the swapchain stays in one
>>>> memory domain. Restrict this to APUs whose carveout is larger than
>>
>> Above you mention that under VRAM pressure a swapchain can end up split
>> across VRAM and GTT. Wouldn't restricting the swapchain to VRAM now mean
>> that in those cases you fail to allocate the swapchain entirely?
> 
> Yes, exactly that.
> 
> My educated guess is that the display server then falls back to using a copy instead of a flip and that helps saving memory somehow (e.g. less scanout buffers alocated concurrently).
> 
> Would it somehow be possible to get DC to dynamically switch between VRAM and GTT?
> 

DCN can't switch between mapped and unmapped memory. I'm not a memory
management expert but wouldn't GTT be in GART (mapped) and VRAM in
the (unmapped) FB aperture?

From DCHUB HW doc:
"No change from mapped to unmapped or unmapped to mapped is 
allowed for immediate f lip"

If so, we can't async flip between them.

Harry

> Regards,
> Christian
> 
>>
>> Harry
>>
>>>> AMDGPU_SG_THRESHOLD, so small-carveout parts keep their existing VRAM|GTT
>>>> placement, and fall back to GTT when the buffer does not fit in VRAM, so
>>>> the flip still succeeds and the swapchain stays in one domain. Imported
>>>> buffers may only be pinnable in GTT, so leave those on the default
>>>> domains.
>>>
>>> The display guys need to take a closer look at that, but it sounds like what we used to have before and that caused problems.
>>>
>>> We somehow need to change the DC stuff to allow switching between VRAM and GTT frame buffers to fully fix this.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>> ---
>>>> Hi,
>>>>
>>>> This came up while testing my kernel patch to fix mem_type detection for
>>>> async flips here: https://lore.kernel.org/amd-gfx/20260611154438.571685-1-matthew.schwartz@linux.dev/
>>>>
>>>> I found a new issue where splitting a swapchain between VRAM and GTT
>>>> causes a noticeable stutter in gameplay if gamescope is using direct
>>>> scanout and tearing is enabled while a game is already running.
>>>>
>>>> Once a swapchain is split across the VRAM carveout and GTT, the scanout
>>>> buffer's mem_type changes from one flip to the next, so
>>>> amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Under direct
>>>> scanout with tearing that rejection recurs every time the displayed buffer
>>>> crosses domains, which is what surfaces as the choppiness. 
>>>>
>>>> With this patch, I can enable tearing on top of an already-disabled frame
>>>> limit mid-game and no longer reproduce the choppiness.
>>>>
>>>> amdgpu_gem_info confirms the swapchain converges to a single domain
>>>> instead of splitting across VRAM and GTT.
>>>>
>>>> Before:
>>>> 0x00000f81:      3981312 byte GTT exported as ino:275 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88248 signalled
>>>> 0x00000f82:      3981312 byte GTT exported as ino:276 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88224 signalled
>>>> 0x00000f83:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:277 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 88236 signalled
>>>>
>>>> After:
>>>> 0x00000f82:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:548 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 822258 signalled
>>>> 0x00000f83:      3981312 byte VRAM VISIBLE exported as ino:549 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822255 signalled
>>>> 0x00000f84:      3981312 byte VRAM VISIBLE exported as ino:550 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822261 signalled
>>>>
>>>> Does this seem like the correct approach to take for fixing the observed
>>>> issue? I wanted to start with an RFC to make sure I didn't overlook
>>>> anything obvious or miss any better methods of fixing this.
>>>>
>>>> Thanks,
>>>> Matt
>>>> ---
>>>>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++--
>>>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>> index 23a9faa2ea89..b99f938e58ec 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>> @@ -932,6 +932,7 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>>>  	struct amdgpu_bo *rbo;
>>>>  	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
>>>>  	uint32_t domain;
>>>> +	bool pin_vram_only;
>>>>  	int r;
>>>>  
>>>>  	if (!new_state->fb) {
>>>> @@ -958,13 +959,35 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>>>  	if (r)
>>>>  		goto error_unlock;
>>>>  
>>>> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
>>>> -		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>>> -	else
>>>> +	/*
>>>> +	 * Pin native scanout in VRAM on APUs so a swapchain stays in one
>>>> +	 * memory domain. A VRAM/GTT split changes its mem_type between flips
>>>> +	 * and amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Skip
>>>> +	 * small carveouts that may not fit, and imported buffers.
>>>> +	 */
>>>> +	pin_vram_only = plane->type != DRM_PLANE_TYPE_CURSOR &&
>>>> +			(adev->flags & AMD_IS_APU) &&
>>>> +			!rbo->tbo.base.import_attach &&
>>>> +			adev->gmc.real_vram_size > AMDGPU_SG_THRESHOLD;
>>>> +
>>>> +	if (plane->type == DRM_PLANE_TYPE_CURSOR || pin_vram_only)
>>>>  		domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>> +	else
>>>> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>>>  
>>>>  	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>  	r = amdgpu_bo_pin(rbo, domain);
>>>> +	if (r == -ENOMEM && pin_vram_only) {
>>>> +		/*
>>>> +		 * VRAM could not fit the buffer. Fall back to GTT where
>>>> +		 * allowed so the swapchain stays in one domain.
>>>> +		 */
>>>> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>>> +		if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>> +			domain = AMDGPU_GEM_DOMAIN_GTT;
>>>> +			r = amdgpu_bo_pin(rbo, domain);
>>>> +		}
>>>> +	}
>>>>  	if (unlikely(r != 0)) {
>>>>  		if (r != -ERESTARTSYS)
>>>>  			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>>>
>>
> 

