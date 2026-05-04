Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC60FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 18:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA63210E7ED;
	Mon,  4 May 2026 18:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MBO37Tcu";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4D710E0B6;
 Mon,  4 May 2026 18:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nafy94CaWFyR/dCYy4oVM+Ddt+dPm5L0jyQnLvGEaXRZI1JDNoBOOUUYcoG44p2IzfeQhQdHUrFO2YToVE6WukMZUhugBhfcs38cIA+IBBIibRydhjJ1mbi7SVV2B4i+yZq+1BPzBg2IAobihlEWXDO95FVb60i8HLc4a08g3mRZoEF8uxfPsp6jNchtFOVpnvdRtbWD0OXc4lnHwHCgmzYAceJ9faQVyWfQiofZCsbN+pnAjOlh8ITKocQZ0IG19ffmaPjMB4nkDExGVrEu8RCdf5YtEapjKMLzL9W/X1cZ/yGPEleAskEKbNpsSOJnBNytu4pgu/AQ5Our5/KxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRZ36WuMFdp8nkU1IKgrlxJCY91Aiz2ZtUSwXUVcs5M=;
 b=kBpPq8G2+CS+4IxNc3f6+kFFooDd3G7XZRuETDzWLsA41FOGu6n29j0Gdc4ee0bm8kLDi41wO75YFCoTfJ8q+q+5lzrLmDAcq5HSx0ZraGmJNu6FCDWXDz0M896I9k0OqpsU3FhqxyInTOw8AXY/zLaBva5QN6OQ1IdQrEPpfFo57dmpak4J97nenALd3PUUsWCgJ4c0JWrfM29YJA+0JwMqcJNPZolkRPE61G2Z/FSkiNfLFxzKcigNPg+w4WgIzrjXGqwSMg8y/AiYynHcxh7CIK+cgZmDu+W+ZvSEdulnNS/SHcMcPYavciicambwRnUCSmcor00JpFSbOxjaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRZ36WuMFdp8nkU1IKgrlxJCY91Aiz2ZtUSwXUVcs5M=;
 b=MBO37Tcu176r7e7YqW/mJpHTj1k/GjzR7B3XrS1k/B5uvSAJXt7+9iDCYxjr8UayH/LDmSvpsYVi6IVdqA58npKj03MA9oeBK6S+xWfv0oOjz5l6Ci6jTrrvPe9QJGqH0aTv15XDHBjvyLxpqvF5JN6oeNz7Rd51D+zNiDj/iWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:21:59 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 18:21:59 +0000
Message-ID: <34992e5f-ac4b-4a0a-a8d9-8b6edd8abe0a@amd.com>
Date: Mon, 4 May 2026 13:21:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Add support for a DRM backlight capability
Content-Language: en-US
To: Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org
Cc: harry.wentland@amd.com, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, Mario Limonciello <superm1@kernel.org>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <0f5cf41c-99d5-4427-86fe-18c4f1e2c95e@bootlin.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0f5cf41c-99d5-4427-86fe-18c4f1e2c95e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0034.namprd11.prod.outlook.com
 (2603:10b6:806:d0::9) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 34774b86-1a1b-40c8-8a9a-08deaa0a07f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: dop3ZOgyNOEIOrkcAgiVd9/ujavhy7wz5QLdJXshnzpTOpNUk1GS77zIYN2VGMb/Xj6+UqYjGKltJ5qfvlBmlqOjqy7tOcYe0YwvvqEaXvZSCOKkuct++VxeRVke8xxPE06GAjTIaESw5QE4UZ7Q+Bwk0Br9TlAujpmCXDmMFl3WnkyI5uTnU4rAkWb3x66q3pJBJ9CKdEDEdvo5SEtm8BmgMXiLqY2POhgrxCLXTJ5BItCN33CD/VGSv3sx2Uf6lYwZtS5zYaYdCLSXZR00O1nW1220nMoNQivLjW2buVlz2o9wwlhRkhj09tlBn+a8yjnWQzKEmNT8HswfVoC3maIex9bhEQGAZ0VbEjHO6Djg9ADIwXd9wITtj3zy4YQ3Dcnc+C2S2UsBtYbaPuFpqStdVAYIJZLQ7KVqYc9VYAI1YA8Kz/oobW/TNvnmI1u+nUH4IE/KRa50f8VK23CfPr146p/JBneA7FYsldDGMpyMx5qpl4n9C4n/Vd9SPHPsyfzh42HYDqQGcZtg71MMrHAZlEBNVxIslg+NlIiW+z63mY5zANnGDfeNNuzxQdPOOzehxLOuWmFrllD3SgakmwGESb74W0uH96Q4jHL8z0nE3jnHvJTzEtLJ1CCi5JxCvRLDgfTdGngovawFAx9T0Hp1sK54zbtIQ8685/UU9PrlwChwe28diI9AXeR+QxUe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWVDVDF0VURBdEFLcHE0SHRUcVZTelhINVZnVDZlUk5KckFTZUtlckh0Si9J?=
 =?utf-8?B?L0NURGhQMTdZZzJhQmdwTnhtTUx5TmpCMmxtRzRVT2FvMWt0ZHl3RkFCTVhG?=
 =?utf-8?B?SDQ4YkFzQVNoSUVrMHI5K3NtNDhScmhLMU5GZkJRQ3NWSllrZXJCOHFjMkhu?=
 =?utf-8?B?RnVmNCtJOGR3WGEydmR2Mm5nSFhSYkJaUnJFWXlndndWOHRESExZeGtjUWpC?=
 =?utf-8?B?OU9pZ2oyTFJHb3FNV2NkdW9PN2RZWGVZQk1QZUZabHU5VWJIVzJNU3FFOTZi?=
 =?utf-8?B?VnhxZ1dSL3FWenZaOHp6dUJIc2ltOE13QldiR2hKMkNMYnBTVThoUDBEdEh3?=
 =?utf-8?B?dWpoK3VWdW84S0hKa3AweEhoQkJyQWY1ZklSbGdDMXRwUlRvamhEVDhmZVBz?=
 =?utf-8?B?Qk5icEFOZzRMOVkxeitvRE5pSnFFRGZWdDVtbDRsSVkzd3lTNmZoZ0F2bFRN?=
 =?utf-8?B?Q2hkRXNIV0lycno3c2ZzQTBlZUtoYjRDajM4V2Mva3NFR3VPalowdjlMdkZi?=
 =?utf-8?B?SytXaTBsRWxnWDl5QmxJelQvLzVZMmVyVXpsaTVZK05qWGNNcWtRaC9iZGJK?=
 =?utf-8?B?MHc2V2YyeDJxWENIY2xoU1o3NWY4Y25XdFpnU1lBMXZIem5VaU0yenZkR1ll?=
 =?utf-8?B?M2ZUbk1yMG51VHMrR0x3d2RDM3pwVklsdWV0OGdRSzVVYnAzVld5VmVnd1M1?=
 =?utf-8?B?TjRPSHFUc3k3WWdCWVl3bkxCcVk3SjVhbDFOQzkzblN6anNkRy9hc1pHMm1G?=
 =?utf-8?B?NzJETmNjTHUySWR1Z0dpVy9tcU9pR3RnaXdYUzRIeDcwOUNiT09SZzNOMEJv?=
 =?utf-8?B?OXVSUnEyOCtWTkN1dXIvVzcvY2cvUzZSRnV4N09pam9YZERvays1Rzh2b2Vz?=
 =?utf-8?B?Q3BWUzVJSmc0TldqTmJCMG9LakRGdUd3U09RQ3NvbSt4WXIrKzlhOUlnOHpQ?=
 =?utf-8?B?QjlvWWRqeWFuc1lnZU9PV01RNTlaaEhoakVpenN3R0hqUjBXUW4rMzdhb1pF?=
 =?utf-8?B?Ry8zdCtlU0R3UVJmRWUvVXJDY3NVdTRiSlBnbTFlZmVqMnZYdFFsT1hGZUhX?=
 =?utf-8?B?MDVuc3NGZk1rdHRjbFJGVm80Vk54eTRTMXNtYmF3N1RubUdmdmlOeStPRzdF?=
 =?utf-8?B?NXdLZGdtOWkxV1pidFU2U3pKUFpqNkh4M3VNVkhGcW55b0JRVnpGVU96Z0sr?=
 =?utf-8?B?eG9VRmJRdWdmY0t1TnQyN29QZXExdExFUjgzeGh1QzFVR3IyL2Q1V0I5eDRY?=
 =?utf-8?B?aXlzVDR6emFaZzk5N0ZtVllJTnZxV0tITjYvNmVsLzY0VjVwdTJFMWJoVzVP?=
 =?utf-8?B?QXZEQmZYdDRsUHQ5a0Y4ZThuWlJianc4MXdydkJFbk4zenN0QllqK2ZGUzNj?=
 =?utf-8?B?Z2lvYTVwVmNxNlEvT2hQOTRheWQwU3NhNkVucXczVVBBT3VNMVRqRkhUTzUr?=
 =?utf-8?B?b0FTV2JnNXJTWXhVYktyaEMyd0tzb1JVc0ZWSGsxZmZCZkxva2YwU1lCQWRv?=
 =?utf-8?B?M1owajRnOGVkKzljQks4V2pxNzZoSHJNZnB1ZmdKUnJnVGVrY0JIWnljQVUv?=
 =?utf-8?B?Q3NOVjVIN0MwMkY5VkJjLytEeVpsZnZhVzZyRGEzSG16bEFOT3NoQXVCV1Qz?=
 =?utf-8?B?MjdiUXdMTmFZcUE2bFllREFwNjg5SXpscVJ5eGJ1VlZtOXVhOU5RMEEvQ3oz?=
 =?utf-8?B?M1RWSEduTCt6UmdMamZGZnBzTjVNNTVKRmNRWlk5TVNLbU4vdkFJWElMSVVw?=
 =?utf-8?B?ekFxTjNja2dFTlRtV0pRenhMazdjQk8rd2VwS09QTEtNZWFUa1dRL3BqL1Jm?=
 =?utf-8?B?M0d0KzB5aUppZEgxWDJjZllzeEhFMFB0Q2k1T0xXTXJrdi9TbWswbEpwTUFK?=
 =?utf-8?B?aStNZHJNQzlMTjBuaGhCSnRybU1qTGc5dE5NS0JyZ2Y4VHphd1dEU2dzYzlO?=
 =?utf-8?B?OTdmZmUvdFZNVWx4dGtFUTY0RDljMzZrNkpBenJGWlErdmdQbkFvS2MweFA2?=
 =?utf-8?B?NEJlZ3BZb1p0WHhPVzJDMTMrd25kM2ZZTHltcis5dExyT1BMV1lSRFo3a2R1?=
 =?utf-8?B?aGVEUHFYQ2VaSUNyRFViL2FmMjNMZ0c3bG91VFNJdUNWV280THFod2lUY1Zs?=
 =?utf-8?B?VjN3bDlUNnY0SThNd0xqQi9XalpieVd4VXlsTUxscmtGYU9JamVQWWJCNHlF?=
 =?utf-8?B?dDlFWlNyRFJQazMzaEF3ZVQrQVplZURkWVhRck1lKzRNRWYyZG5uRk5mRENY?=
 =?utf-8?B?YnJDaDlPTi9xNDFaYzk0Nkh2N1NBN0Vab3p5eXpLTTR3R2E5aFk1bmdCSzFK?=
 =?utf-8?B?Ti9heTZrS0JJR1ExWHRuZlZpd0gwM05IMTNNY3lVMjByNERuVW0zZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34774b86-1a1b-40c8-8a9a-08deaa0a07f3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:21:59.4928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Dyq39/G0DeZivxCgRt8kn5eT+O9cApiPvlh/KFjmh6gQmH+EK8+HIVjYV9hPe7E/qL7PVvB5xecb79AYrSuRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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



On 5/4/26 08:55, Louis Chauvet wrote:
> [You don't often get email from louis.chauvet@bootlin.com. Learn why 
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 4/25/26 00:09, Mario Limonciello wrote:
>> From: Mario Limonciello (AMD) <superm1@kernel.org>
>>
>> At Display Next Hackfest 2025 we discussed the renewed need for moving
>> brightness control into the DRM connector properties.  I've taken the
>> previous efforts from David and Marta, rebased and adjusted for the
>> current kernel.
>>
>> The legacy sysfs interface is synchronized with the DRM connector 
>> (although
>> the scale may be different as DRM connector property is u16).
>>
>> Later after this has been adopted by enough userspace, it may make 
>> sense to
>> configure the legacy sysfs interface to be configurable so that only
>> DRM master controls backlight.
>>
>> I've done a first implementation with amdgpu with eDP connectors; but
>> conceivably this can be extended to other connectors like DP for displays
>> that can be controlled via DDC as well later.
>>
>> I have also used DRM review prompts to review this series and fix some 
>> bugs
>> which were caught with two different Claude models.  The fixes are 
>> squashed
>> into the patches.
>>
>> Assisted-by: Claude Opus
>> Assisted-by: Claude Sonnet
>>
>> For ease of testing; this series is also available on this branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/ 
>> log/?h=superm1/backlight-property-v3
> 
> Hello,
> 
> thanks for this work, I am very interested in this progress so I can
> help you to test / implement more features.

Thanks!  I have a few other series I'm juggling in other subsystems, but 
will try to get another spin this cycle.

> 
> I think you forgot to include the revert of "backlight: Remove notifier"
> in your series, it can't be applied without it.
> 

Yes - thanks for catching this.  It's on my tree at 
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/backlight-property-v3 
but I forgot it when I built the series to get that one.

> I will take a look and see if I can create a VKMS implementation of your
> work.

Cool!  Please take a look at the IGT patches I did too if you didn't see 
them.  This should hopefully work once you glue it to VKMS.

https://lore.kernel.org/dri-devel/20260424221021.167179-1-mario.limonciello@amd.com/

> 
> Thanks for this work,
> 
>> David Rheinsberg (1):
>>    backlight: add kernel-internal backlight API
>>
>> Mario Limonciello (6):
>>    drm: link connectors to backlight devices
>>    DRM: Add support for client and driver indicating support for
>>      luminance
>>    drm/amd/display: Pass up errors reading actual brightness
>>    drm/amd: Indicate driver supports luminance
>>    drm/amd/display: Allow backlight registration to fail
>>    drm/amd/display: use drm backlight
>>
>> Marta Lofstedt (1):
>>    backlight: expose the current brightness in the new kernel API
>>
>>   drivers/gpu/drm/Kconfig                       |   1 +
>>   drivers/gpu/drm/Makefile                      |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  88 +++-
>>   drivers/gpu/drm/drm_atomic_uapi.c             |  24 ++
>>   drivers/gpu/drm/drm_backlight.c               | 406 ++++++++++++++++++
>>   drivers/gpu/drm/drm_connector.c               |  12 +
>>   drivers/gpu/drm/drm_drv.c                     |   8 +
>>   drivers/gpu/drm/drm_ioctl.c                   |  10 +
>>   drivers/gpu/drm/drm_mode_config.c             |   7 +
>>   drivers/gpu/drm/drm_mode_object.c             |  66 ++-
>>   drivers/gpu/drm/drm_sysfs.c                   |  54 +++
>>   drivers/video/backlight/backlight.c           |  83 ++++
>>   include/drm/drm_backlight.h                   |  45 ++
>>   include/drm/drm_connector.h                   |   8 +
>>   include/drm/drm_drv.h                         |   7 +
>>   include/drm/drm_file.h                        |   8 +
>>   include/drm/drm_mode_config.h                 |   5 +
>>   include/linux/backlight.h                     |  30 ++
>>   include/uapi/drm/drm.h                        |  10 +
>>   20 files changed, 852 insertions(+), 23 deletions(-)
>>   create mode 100644 drivers/gpu/drm/drm_backlight.c
>>   create mode 100644 include/drm/drm_backlight.h
>>
> 

