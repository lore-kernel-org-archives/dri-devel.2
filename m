Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EEECDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D1810EF96;
	Wed, 24 Jun 2026 15:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="17ltFgkW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC6510EF96;
 Wed, 24 Jun 2026 15:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7qpBOsmzTD680+Xu2Q2MvncrgSKg8QcyVq/k4vYcxRBlZ22pNgfPWhlM9lYMKkmmk0wmOWNtB/AEmfsPZisMDTAn+YimYBWuBDDUYMXBj+9ADW4Ylp+V2RMEnE5ndE2HUlNpTpk3FvHv+2tkyl3ifrN0ZDeZmnMLil3WqBS13kUJjqbEGZ9cDcXMSQtC+0bbWSyHUai3SF7yH/s63eWzo0yS/JpnWjobBuEfm9nAhWDKlgveP8nd8XkjvusaNg5oxMq//2B44jev5rc1vnQi5GJaNycMInJqiG6cxVZU8hi5HYYxMwsOTZwdhRuf6FTJm9v3dK/MURB1JqrdNpdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0EdsKF06k6a/jCcGHMzn1bjX9EOJMvuw0+4DUxjRjM=;
 b=u797wfWOx2q1Cky6IwU/gHfZl98vy6klWr4dkQ7ORY7XiR9wdRKSRBI4lM+i98RtFzufLGtCEhaS6ydX8ArVSH1g9WJjmDj8Lu2U6D+DU3kqq2cFwO7EPajc8YO9Cu7aGDr5920ob+S73Ac6gZkSPQs1eFIIAvX7/yGjYFqilG/N2Sehe3PJTirQ8qAvGOf994WqwyWaJLXuicZ/An7OG0dvA6O5g/mpKe9QSu+glHCFg0uZPS+vIwh2hkKUiK+T5W2Spzzm79vZbWON+oqLwSzD4DDh1RVPRHGkMlI1NzZJ9aHZrt9whdphxACGUAG/Mdyv3ZxyrrIs0RsEgxI1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0EdsKF06k6a/jCcGHMzn1bjX9EOJMvuw0+4DUxjRjM=;
 b=17ltFgkWhXj+WbyyzRAoMTFSZZE3pDdlUjMA2+4GLwszbiZt65UcpDWEkAOTwmZwbqaR+u5eScz+PW5IjXrKf4iUtzYpwt4SPSqA00KNv95CG3bD7fYAZWNTgYjQk5NLR1Pj1NGPi8jylauZAYXIwE04yh+8XFccAlOckvvbnUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Wed, 24 Jun
 2026 15:52:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 15:52:52 +0000
Message-ID: <9b96d6a5-7c3c-4bd5-8785-76c9642bc933@amd.com>
Date: Wed, 24 Jun 2026 17:52:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amd/display: Pin native scanout to VRAM on
 large-carveout APUs
To: Harry Wentland <harry.wentland@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, Melissa Wen
 <mwen@igalia.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, natalie.vock@gmx.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
References: <20260616071037.26718-1-matthew.schwartz@linux.dev>
 <334d4642-a7ce-4d04-ab14-6b95653e6f86@amd.com>
 <09a37c38-3f99-40bf-9a87-f88298ce349a@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <09a37c38-3f99-40bf-9a87-f88298ce349a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa8a2f4-18f1-490d-2d61-08ded208a62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: iqMfZU8CD5lac+6+03VU1ukHa/t/r68e4BDchJi7bFCz0uHGRSlwuPck+CMw9ucnjfan+eNUpbLwocrRGa55Bm5H7vCm49Meuhcg1SabGteID+wQHA0Ds2V7Ls51FzLmGTG/KUGDeOdqFPJIFU24LvT+icg6bHaxnfu+Ia6iB0BT82Y0RzaHSlEmMWC952MwWL2PKfDqI/WFl3Znb1yPaWSNMHAm0TT4RsKtscrZhwrOQ6n3jOGl23QSdM96uPCndmSs1Aw58/4KBdaYfRWbZZ0Pv4zwRXxJhiQrsy0RY3pvkCTrIeb+vmrerS83uLEQLWuuJ8PFcaK10UD/zGTilvAcVuYKksEaKF0YKqzlnKjsu/askd5HiBKJ9dqqZJTebMFIqWAlFzUQ8BqhgdcofGgXunWvumu61oRPvQQFaOROXAlKTFsdnwAtcM2FoskmepkwQ13xFdy+3Rx+Fvb9hNHLuNsTHlPyQaerJCmDsJHKgqr8Z+Wqkld5nxIp6At9sUZ1ZCjb7mp4NLRjI93xadfTZt1r0sgw1aysL6/rB7t4Da3YSYF546p87cuCj4pBgHOhfjd1TUUdzC/haUHCLXtoahf+PIcvBw0M+tb4EXL5adwFeTfN3j488rcJ+uZv6watA6SAStehDCF+fUj+B4eTvXUH6o8IiiLdMtVg82E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alM5SVE2L3JpQStmdEs0WnJHSEUvbTg3aWRqVExCVm5WRG5aSGhKd25RbUtS?=
 =?utf-8?B?ZEJHRzk5dzlXT1ZQV29WMC9NUk9iMDhBMzBqNUhaTGh6dStqSldkQzB1Vjcr?=
 =?utf-8?B?V2xJR1BoRGppQmFkNlFuQmhJVzdxMHJrNTFhQXpiRy9PRmkzdm5hWlg0eUNs?=
 =?utf-8?B?OGRNdlUvVXdSdjZwYnlMK2NKZkMvRzJ5aENxclFGMnB2ODJpRjAwUGt6NjBY?=
 =?utf-8?B?bFI5SW53SlFMMFUvTXRSNDlUSW8xUmVHaWRUR1hGbUxmNmxrN0c1dmRLWXZW?=
 =?utf-8?B?eTM1U1pKTnZvaXc0bkE4dkVEUGFkNEllL2xFWjNLMDJiUlVtQ3hHb1g4NGZa?=
 =?utf-8?B?YUpreHNHYW9PYUhwYmxQYnBOUWxENEVvaHhVTVJkRFJIZXlYeDRnUkZSVmoy?=
 =?utf-8?B?V0xHSVIxSUFrRVA4Y2pvMlN6cHFOQ2cwVEc1WU5mQ0QyYS8xTStXUkZXZWlJ?=
 =?utf-8?B?azVmcWN2OGlDVTEvdkZZR1FXRVdnSytNL2NaV21VOG5Wb3MyR3dHbWtiY2hL?=
 =?utf-8?B?Z2xlOUw3cC8vQnpWTzFSMHlZRHd3MzV1WDBmV2R3U1N3dHNscFd3U3F6WEEy?=
 =?utf-8?B?alVoQ2N5RUZkUUluNldnSG1SNXVBa0J3K0M2RXg5aFpOWS9icmRETXYweFNN?=
 =?utf-8?B?R0k2blVRaDBMeVhUOHd4QzZlVEJOWFlCTEFkSi9qRzYvekhCQ3hWcmhRNSsv?=
 =?utf-8?B?TkhhVkhtZ01ZREtHUVRFNkMwWTFGaDdFMDRQK09jakhlOE5ydk5VdFR4bGVU?=
 =?utf-8?B?R2xEVVFjY01KYzBZa0VEcENYaFFoakc4ZW10UXhDWTBvSEthR0RhbklmWVQz?=
 =?utf-8?B?NzRqK25pZENzT1hoSEFWS05yQ0k0YnlZU0xDMXZHV2lyNTlDaHRtTWl5REpP?=
 =?utf-8?B?NTAzL29BSDdEQW80dUhPK3RxYnpkTCtMRk0xdUg1V1pjdmZWUWZkeHc4Q0tu?=
 =?utf-8?B?Qzh5WFF3OUw4SE1ibXpidE1aTkFuMENiMnVWUmlPYmhPMzN4Ri8zVkdOZll2?=
 =?utf-8?B?R0JXc1NoRTdyZHlTQkZNdTNNYUhuVGZBdENnQUVxdEJXZXhZanVIKzZ4SGxj?=
 =?utf-8?B?YUJjbmRlSTN2VHg2MHB4RHNQLzh5aXpkOVlkQ2dqbTl1VmdaODQ1MTFiNndM?=
 =?utf-8?B?cWRLK3BrTSs1WFlDa1Yzb3Z1R3VVRUdSMU1LVk94TzBmR2RCbkttZmIyV1dH?=
 =?utf-8?B?b2o2MHBtVENDSDdxalBoL1dTYnVzMlBOSkRMTm9Ja2ZUU3kzSmQwRU1DZi9L?=
 =?utf-8?B?T3U0b0xMeFdnV0UvZ250SWtIVmxZYXFYV3JBZW5JRXZISVdiYmQ4d00rZVhi?=
 =?utf-8?B?TWFTeFY2a2NzRHcrcGt5cWZUNms3dEZSZlBoQkpvOUFvYVU2MUt5TXF4MjJz?=
 =?utf-8?B?MnkyaWN4MURNV1Zkd1FYOGJ5eE9nalloaFNWbGdyRmZWendCR2M3NS9VUkNZ?=
 =?utf-8?B?MWdtOXZhMDhUWFdraWZkQnRpekV0WGUzaXUvQ0xGNlpZZldsL2tIWG5zajd1?=
 =?utf-8?B?cnJrZEQyWGlJa3JFbnJFNUo0YUxkV1FWQjU3UzN0akpkZk1vNEJoV3h6YWJh?=
 =?utf-8?B?R0tBTmdobU42NnF3MkUrbzFGQnpzamtyL2FpKzhGT0xnamxPcjRwYkFEcXA4?=
 =?utf-8?B?L3VsemR6MEdJRUUvZXd2ZkpvczRLVEU5VWM4cy81MXI4NGpaSWF2WGRMMGwx?=
 =?utf-8?B?VjYzV2ZLcXE4YUN2ZThwcjRvRUJaWHdOd1B4akpJcFJrSWVOSWMvUGVEajV6?=
 =?utf-8?B?S0hvcFl3QVdlRTF2eDNLeHg3Q2NubktxRUpHc04zaUgwUitka2d4dFdiVzVQ?=
 =?utf-8?B?YkVQK0MrUTI2a0RBVm0wdE1Bdm1vNTdEbkxaaGZPdEVpd29rRUlCZ3ZNdVdn?=
 =?utf-8?B?OHlrZ243VEZvUUlXd3FBUGRiOUIwSSswMkFEL2h1ZmJISWJWTDZrYVRoZGxY?=
 =?utf-8?B?andqTGtmVElKdkVZeDFabHhiR2VCUlRuVkpjbnp5ZUlmdGZUUnBmM0hBRnhU?=
 =?utf-8?B?NTJ4dHk5S0NQVWNvRDVmTGw0b2lpbEtGempZMEFySm95bXFjc0wyZzJoMnBz?=
 =?utf-8?B?MzBXUEN1ZUY4Z3BGUThSbWhldVFNcEQvZ0kxRjErQWVUL0Yxb2FuRzhZTlAr?=
 =?utf-8?B?UHNpdkhGSU9aaUlmT29lS09jT2ExZVNsU2FmYU1JeTQ1STYvdkRKL202N1NB?=
 =?utf-8?B?c2pBSlhSVDU5ZUxzVUIxN1l4RXdHS0p5VzJUU3VrYVh6aDhKM2FVaklQZGxZ?=
 =?utf-8?B?aFVFQnhuTVliUUZKZk1FMXpsR0dtSU1WT0svcXlDbGdXM3ZqNFFMczlpK3VV?=
 =?utf-8?Q?j5fFYxIx8YC7P2PqYO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa8a2f4-18f1-490d-2d61-08ded208a62d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:52:52.4644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfgvAnCMf2N+aJioFWc0KF8dZe+YOjj7MwDTOOkyGBkprteSYuLr+/oZJjGip9GI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

On 6/24/26 17:30, Harry Wentland wrote:
> On 2026-06-16 03:31, Christian König wrote:
>> On 6/16/26 09:10, Matthew Schwartz wrote:
>>> Native scanout buffers on APUs are pinned with the VRAM|GTT domain, so
>>> under VRAM carveout pressure a swapchain can end up split across VRAM and
>>> GTT. The scanout buffer's memory type then changes from one flip to the
>>> next, and amdgpu_dm_crtc_mem_type_changed() rejects an async page flip
>>> across the change. The result is repeated async page flip failures,
>>> observed as choppy updates under carveout pressure, until the buffers
>>> reconverge to a single domain.
>>
>> That's intentional behavior.
>>
>>> Pin native scanout buffers in VRAM only so the swapchain stays in one
>>> memory domain. Restrict this to APUs whose carveout is larger than
> 
> Above you mention that under VRAM pressure a swapchain can end up split
> across VRAM and GTT. Wouldn't restricting the swapchain to VRAM now mean
> that in those cases you fail to allocate the swapchain entirely?

Yes, exactly that.

My educated guess is that the display server then falls back to using a copy instead of a flip and that helps saving memory somehow (e.g. less scanout buffers alocated concurrently).

Would it somehow be possible to get DC to dynamically switch between VRAM and GTT?

Regards,
Christian

> 
> Harry
> 
>>> AMDGPU_SG_THRESHOLD, so small-carveout parts keep their existing VRAM|GTT
>>> placement, and fall back to GTT when the buffer does not fit in VRAM, so
>>> the flip still succeeds and the swapchain stays in one domain. Imported
>>> buffers may only be pinnable in GTT, so leave those on the default
>>> domains.
>>
>> The display guys need to take a closer look at that, but it sounds like what we used to have before and that caused problems.
>>
>> We somehow need to change the DC stuff to allow switching between VRAM and GTT frame buffers to fully fix this.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> ---
>>> Hi,
>>>
>>> This came up while testing my kernel patch to fix mem_type detection for
>>> async flips here: https://lore.kernel.org/amd-gfx/20260611154438.571685-1-matthew.schwartz@linux.dev/
>>>
>>> I found a new issue where splitting a swapchain between VRAM and GTT
>>> causes a noticeable stutter in gameplay if gamescope is using direct
>>> scanout and tearing is enabled while a game is already running.
>>>
>>> Once a swapchain is split across the VRAM carveout and GTT, the scanout
>>> buffer's mem_type changes from one flip to the next, so
>>> amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Under direct
>>> scanout with tearing that rejection recurs every time the displayed buffer
>>> crosses domains, which is what surfaces as the choppiness. 
>>>
>>> With this patch, I can enable tearing on top of an already-disabled frame
>>> limit mid-game and no longer reproduce the choppiness.
>>>
>>> amdgpu_gem_info confirms the swapchain converges to a single domain
>>> instead of splitting across VRAM and GTT.
>>>
>>> Before:
>>> 0x00000f81:      3981312 byte GTT exported as ino:275 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88248 signalled
>>> 0x00000f82:      3981312 byte GTT exported as ino:276 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88224 signalled
>>> 0x00000f83:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:277 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 88236 signalled
>>>
>>> After:
>>> 0x00000f82:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:548 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 822258 signalled
>>> 0x00000f83:      3981312 byte VRAM VISIBLE exported as ino:549 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822255 signalled
>>> 0x00000f84:      3981312 byte VRAM VISIBLE exported as ino:550 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822261 signalled
>>>
>>> Does this seem like the correct approach to take for fixing the observed
>>> issue? I wanted to start with an RFC to make sure I didn't overlook
>>> anything obvious or miss any better methods of fixing this.
>>>
>>> Thanks,
>>> Matt
>>> ---
>>>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++--
>>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>> index 23a9faa2ea89..b99f938e58ec 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>> @@ -932,6 +932,7 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>>  	struct amdgpu_bo *rbo;
>>>  	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
>>>  	uint32_t domain;
>>> +	bool pin_vram_only;
>>>  	int r;
>>>  
>>>  	if (!new_state->fb) {
>>> @@ -958,13 +959,35 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>>  	if (r)
>>>  		goto error_unlock;
>>>  
>>> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
>>> -		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>> -	else
>>> +	/*
>>> +	 * Pin native scanout in VRAM on APUs so a swapchain stays in one
>>> +	 * memory domain. A VRAM/GTT split changes its mem_type between flips
>>> +	 * and amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Skip
>>> +	 * small carveouts that may not fit, and imported buffers.
>>> +	 */
>>> +	pin_vram_only = plane->type != DRM_PLANE_TYPE_CURSOR &&
>>> +			(adev->flags & AMD_IS_APU) &&
>>> +			!rbo->tbo.base.import_attach &&
>>> +			adev->gmc.real_vram_size > AMDGPU_SG_THRESHOLD;
>>> +
>>> +	if (plane->type == DRM_PLANE_TYPE_CURSOR || pin_vram_only)
>>>  		domain = AMDGPU_GEM_DOMAIN_VRAM;
>>> +	else
>>> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>>  
>>>  	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>  	r = amdgpu_bo_pin(rbo, domain);
>>> +	if (r == -ENOMEM && pin_vram_only) {
>>> +		/*
>>> +		 * VRAM could not fit the buffer. Fall back to GTT where
>>> +		 * allowed so the swapchain stays in one domain.
>>> +		 */
>>> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>> +		if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>> +			domain = AMDGPU_GEM_DOMAIN_GTT;
>>> +			r = amdgpu_bo_pin(rbo, domain);
>>> +		}
>>> +	}
>>>  	if (unlikely(r != 0)) {
>>>  		if (r != -ERESTARTSYS)
>>>  			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>>
> 

