Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A155606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JjQomqj9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E6110F4EF;
	Tue, 27 Oct 2026 13:16:35 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE79310F4D5;
 Tue, 27 Oct 2026 13:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyTahnugnOnegtFGOcrIhKim7BBhmDTg1bsUfyYUunBogDUvsrVw2eVSiZA62QSWeFbbe5k6L/q1gotDJZsIg11GG48ADFexhZ0rSaX8Tvx+ri03cKofub0NjTVWdEuX8jmIeEI6tjDBg0gw6RDtBV8U2a9qZk12HSfMz+JplK55scHIm8l8fxzxuNIAhMAfmuVfSfV+9RJ3PrdvYTpXyMK1Ct80hikB2BLCteZtaHDR1M1yrqDXTz5UskNuLwNnU3PQwzyJimUwTqDaswHNr+WLGjv43SWmnONBEciVWVkRXxjm8BCM26+HZ9oVxEyDfYbQcecDWfM3bdDcYqPhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0/R4qOeV34mhh+r+kRBcgH2lrSIxGk2zS7HWrtL1xE=;
 b=tXjQKNo5/uLdOx70MIt8M9h146YVkDF8PihrwA/K09ScIf0MuFQ5Bt1sv8zZ294JK1RQk7c/MbfBAok259YPPTMSpT6AdjDwMqzPVpoiMJVu0LmlIZIzld8W3TudctAHACfLi+Jmfac0lAtIBcWJt1bLk2+xG1hjsLMveEdemWwFDj6KxF4hyu4t1hJCQsXHf7Ja97VrDAj7b/ehw7b/fYmK6tEgXDGaSusn83ki4ofIPth/p+IlnB+MkSTYY5vnVYxv7spLOT8+kIM+8BTQm7Mf5SucHuPrLWq9IsVvSHeLewZVuGAiojlYyU+yTa0KqWd/MO4Qq8vlEZv7zm67AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0/R4qOeV34mhh+r+kRBcgH2lrSIxGk2zS7HWrtL1xE=;
 b=JjQomqj91i64R2UoDEizJ35kLha9/GdatibND1V6lQHJjQNeO3Z6Ijh/6NsedV9CZ7OXjbIDGMCe84oedU4QOHUSy8emRntOC9jCvy+/cSL816RAniLZsaENJQt1AFk6yzAOPjUcyKbjpTtyhqtpYQnkddxUGFRU0V8t3TSiVX4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by SA3PR12MB626779.namprd12.prod.outlook.com (2603:10b6:806:590::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:16:26 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:16:26 +0000
Message-ID: <6f79a3e2-5510-4018-aabd-45fcdf5dcbb3@amd.com>
Date: Tue, 27 Oct 2026 08:16:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: reserve 64M stolen memory for Apple 5K
 iMac
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Richard Lane <richardlanedev@gmail.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <a826b32d-597a-4c01-8b30-218cbca8627a@gmail.com>
 <e0573e72-dcc1-4ff2-8cf2-53aefde912cb@amd.com>
 <CADnq5_M8f2Hgs06n9EXUaihGsr6YEm6G4YFVQmPfQbGU08XkBg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_M8f2Hgs06n9EXUaihGsr6YEm6G4YFVQmPfQbGU08XkBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:208:32f::29) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|SA3PR12MB626779:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d79dd9a-a74b-442c-e340-08df342c812c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261026140227099003|11063799006|4143699003|56012099006|261026121527099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: se1QyKKV9uYG7hSQ77wzPMRwdREHW3KyE6NccMBem7bIBiKD5NiaNJAVtauzqniqcYVkPOrUmMnUKzdHB/xfWs095O0Sh1Nzw7duvkNFBUJJU27VB1d9srKv4wl5Y3pfSwVPlb1aiauqvMcZw+j3matJbdc4oz10dFgTKaNdUX2XnkCHDhaJTrIoC4oyektJQlThkNwxXWVHKt3VqGMDTOLoXMpFuV7OGoaplgewnE/XcGXdSZ1VYUBkhHMmLx72ctd5jXrly8wGV4d5MZtmSWoOo+GHKVvAuQEgKyzvO7ds41mOhL83pbdIAsxEF1xi7Mli8ZYoxsmpdQ8EoDMQVxNC/851ytfeHOBFxPIplNEr798OMwwMT7tcSJOIHAd/fjmUnA4cpY3/1fN71eYpY6SWgN9Pq4RTKWT8Tou25NLf7Ap5rUWLTZWQX0rjvCM6ZJgRjV0ySIhIm/P5Gzp7Natr8+kQ/X//EItMbZzfDIJGe6ybup8ZD3moZo+pnwvCeFHQ7NYsGT6NgUODh9goErPeSrwyQfHRgBhpPr6lDD/N0HlZ7qm/lJuAaqi4BcRPLQ8NO3/ytggL1noFcicI9EDB/jjO5wjcNUD/Ex6hgz9ngT9uNHQ9EuXQCO9pfRlcloEs4csDGCNZATEvY8weUN3HC+H6cLxT0d+lLGsbjjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261026140227099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXl3L2lkNjA2TXNNeXFEMmhwNWl4Vk4vUGxtSy9uamRZcndhR0hjb0JHZUR6?=
 =?utf-8?B?STBJZ0lCKzV1WEUzSzJyV2xOOWk0dFFSTHRkc2l4b1QzV2FaVmZMcjZpTXl0?=
 =?utf-8?B?WGFSMmRpRWtDVDdmZjh4VEIvSEdjY3RMeDlraHpVSHJCM0xMSS92UWowd2Vq?=
 =?utf-8?B?UVpZUXZWTGhScloxQXJvODB5UGtEM2hPa3h6eUVRdUJBemFIa291emlHR3V0?=
 =?utf-8?B?KzBJQVVhY1B3Mm1HQWJxbk9tVHdHcTdWQ2hHa0tOSGZtWWpCdzFMcEhVUmFy?=
 =?utf-8?B?NTJCbDZnVHFjM2FlUk5Eei93Ry8zUlhIRTllSkY5emRIV1dOT08xT3FNeHRj?=
 =?utf-8?B?RUo5U1dTVmR5U3RERVZ4ekVPaXdOMzdDc2RVTHZReTkyUFJ5SjYvWWg2dU1J?=
 =?utf-8?B?YTdrN2dMdGdieEVGYTRKZDg3NHUzL1pBa1hJbkhKQ3dJTHBDam5oMy9aMmgw?=
 =?utf-8?B?SjhaTVlIMUs0T3JwcldtdC9WYXBZdnJUOTZrZzVGcmIrV09ucGlzRjVXUG9s?=
 =?utf-8?B?VjlnSjMwVVJQLytUY3BFMWZWYmN3VlF0bmw5ZVQ1MWdTZ1hzVitPdnc2a2Ny?=
 =?utf-8?B?endkS3I1ZldscjJ5MElGNm0vMm4yNVlwUFVBLzJaZjk4WEp1bUIvbnpxSjVF?=
 =?utf-8?B?czBFNVJaSFZTbktvRlV5S1MzMWxFU0R2R0JiVmJDYXZCUjlvaVRoMTFHak5t?=
 =?utf-8?B?UEpXV1FoUFV3bExuK2YwZUdSZnAwMzRsL0F1Uy9aRzcwajRYVVpGMGVFUm85?=
 =?utf-8?B?SlVuazFhYnBJdnRxaUgzU3d3L292bUVhUzF4ZkZpOEFaM0pYajZYZVcwMDlT?=
 =?utf-8?B?OHA0Y0ZxRXhNLzk5Q2JKWjN2RDZFTnd2cHFnYndIc0VhVCt6amcwcDdBOVE5?=
 =?utf-8?B?K0hGejYyUDB0aWtIUmkwUE9TM3Q5cnc0NStRRmQ0K1ZjMit0U0VmcjFrMDFL?=
 =?utf-8?B?WWp4TzNMU3BaaGhEQWlsS3dqa21EUGJGQUhaTWhUaVh5NXB3WERDdXBSOWdy?=
 =?utf-8?B?VFExc0hjU2hEcUNTNkxEMSt3bTl6T0VNN29wNGMvV29wMGw2Wk5TNkhFdThV?=
 =?utf-8?B?Y3Vhb1d1b1lXaStwZkFSd2xDaU9PVnNyUGlUaVo4V2F2REptV2lBcHFKK1RD?=
 =?utf-8?B?OFNlZndQYTUwaWQ0WkRibjBBU2pVVlU5bHBXeHZ3aXhuMytpZ3REaEgxSmJ6?=
 =?utf-8?B?U0ZOcW1NN0FnaFlLZkVPS3dSaWpmR0ROVXFqRlNtOGsxYndEOTJydUI2MGhh?=
 =?utf-8?B?VEtuektRb3VmR0dmUWFibTRDM3U1MEFCdjlsTW5ORm9CZTg2VHcvY3lJemVX?=
 =?utf-8?B?UysxZDNWdHB6dWtZdjVobUJtSld5bmdjeHc1SG5FUjBpbXdOOUlUZ0Nob2sy?=
 =?utf-8?B?d2VKcDhqMTU3a0Z0d09XZWdzcTI2bE00M1VhcU8vcG9sQUYvY0FBZWVIL09W?=
 =?utf-8?B?WUxiMmNhTlZ0UkdQL0Q4czZ4RHhYdmpqVFIxK2xDUVRZZ2VTVU45NVV0SHFa?=
 =?utf-8?B?WnlOV1pKenh2Z0NiT0VTeFk4ZDNEdVRIb05KdWR4TmZnSjBXUnFrUzdaVjNZ?=
 =?utf-8?B?MVB3aVZVb0Qrak1KaWJybGxlMnBSc3hvZHdtR3p6RXEyRmtVeUx6SFZTOGds?=
 =?utf-8?B?TDBWTEl2VTVuVC9DYUNsTk9oMlF1Y1JaSmxUNEpCVU9JTXpRSExOVGxKTTI4?=
 =?utf-8?B?cXl4L2RwcFBJT3JQcFdNYzhGeGtGUzRoWVJLU2pOc2prREozaStLcXBEMkFQ?=
 =?utf-8?B?T2k5RnZQQUF6aHBxaXVmK2hWaG9kYVBzYTB3d1VHSHRWMEkvbTBKRm9ZZ0Ja?=
 =?utf-8?B?RVRZcXhxQVRLV2Z1RlVieEVuUlR6d1RtVTF0cTNlMDNGSXQyMVdMZVNhVU1U?=
 =?utf-8?B?NkNOZm1PSUsyKzdOVWsyYlA4MTdKUlF5U28wMnRGOE9SaTNWM1lXaEhLZ0NS?=
 =?utf-8?B?NytZa1d0c0ZLZm40Zzdmc1p2VmJsRkwvUDc2eC9NT2pVaUFPRkEzMU1uNXdv?=
 =?utf-8?B?b3RsREhlWkZqbUNCYm4zcGl1WFc0K0NzQlRCUWkwNlhtUjZicjlnN1VIUFBF?=
 =?utf-8?B?eDBOTC8rVE1ocEZpNXI1R0xFWElhWmR4MWpEVFJJK1gwQWRBUVdjVU1KeWEx?=
 =?utf-8?B?SStjdnNuNWRySEdReW1KMXVaVVBPOWJJM2p0ZHJVdXRwVE5pUmcyVXdkbDdK?=
 =?utf-8?B?cW9wZVpUYnVuVkhmRXlJcWZiUzRDemwvWXc3T1RzOUE1SG4wSUNyR1lQZ1Ix?=
 =?utf-8?B?eXNPYXRWUFFCSE9UZGRvNG5NTGhzWlRKMXUvaDRWeGdzNXl0eXppS2lXRnhh?=
 =?utf-8?B?dExWOGJYZDJxSVZMdmsyR1d0a2E1aUFXaU50RVB5THVTbnlPdkwyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d79dd9a-a74b-442c-e340-08df342c812c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:16:26.1952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuYPVUtdFGraG8rxaflGWHKt1icrPEJIAgroDLnGx2RAj/EoWyw4BF4SHr25LMo8yfsS1JKdIfX/T374OAD92Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB626779
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/26 07:57, Alex Deucher wrote:
> On Tue, Oct 27, 2026 at 8:21 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 10/26/26 23:46, Richard Lane wrote:
>>> Apple 27" 5K iMacs report a single 2560x2880 tile (28.125 MiB) in
>>> VIEWPORT_SIZE while scanning out up to 64 MiB across the relocated EFI
>>> framebuffer.
>>>
>>> Override the stolen VGA memory allocation size to 64 MiB when matching
>>> PCI_VENDOR_ID_APPLE with a 2560x2880x4 viewport size to prevent
>>> framebuffer corruption during boot handover.
>>
>> Hacks like those are usually a big no-go.
>>
>> Why is that framebuffer handling not working with DC out of the box?
> 
> The GMC IP code reserves the memory used by the display hardware from
> the pre-OS console.  The gmc get_vbios_fb_size() callback looks to see
> what display viewport was set by the pre-OS environment.  If the Macs
> need a workaround, that's where it should go.  Since these displays
> require multiple display pipes, my guess is you need to double the
> allocation in that case since the current code just checks the first
> pipe.


Could this also be a logic error in that callback?  Would it be worth 
double checking all the register values in that callback for this system?

I know for example there are a few different IP specific implementations 
in gmc_v9_0_get_vbios_fb_size().

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index 4204c3c750a8..8b196fbfa724 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -1232,7 +1232,15 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
>>>          } else {
>>>                  size = amdgpu_gmc_get_vbios_fb_size(adev);
>>>
>>> -               if (adev->mman.keep_stolen_vga_memory)
>>> +               /*
>>> +                * Apple 5K iMacs report one 2560x2880 tile in VIEWPORT_SIZE
>>> +                * while scanning out up to 64M across the relocated EFI
>>> +                * framebuffer.
>>> +                */
>>> +               if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
>>> +                   size == (2560 * 2880 * 4))
>>> +                       size = 64U * 1024 * 1024;
>>> +               else if (adev->mman.keep_stolen_vga_memory)
>>>                          size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
>>>          }
>>>
>>> --
>>> 2.55.0
>>

