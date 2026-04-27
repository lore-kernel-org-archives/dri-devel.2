Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DB6FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596E810E933;
	Mon, 27 Apr 2026 21:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WHWe1nQQ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013042.outbound.protection.outlook.com
 [40.93.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C8310E933;
 Mon, 27 Apr 2026 21:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkW8x4nCs54ww5TJSHNj0cDQW8LByj3aKUeHfRhqE3xsBKhLFvilRRNSQ7H7/R/2iH4QcW3kzkddU1wcHUtiNjd0hWVMBoqqMy8bQ0uFl8GRJCzZ/MkL9dE7W08FY7EQY+a+zHpbW0teyXltqDv2Ny8/q9vhnBiLRze4QQfFVtrIwM1zCk0Hy9m0koxRxVrRXZSekJHa7IkJqPXaYPjqt11Hza3Ogr40YAg8VAQ9ffphDgeIdv0G0Vcb/fAtaT2MSiQleq/PV5MFPZdWpg62pM0HDrL/L4wgUCY3o7JoZDvs9kp+g8gqyewHSgyakOoAdiOd+AhQkGJteGl+zS9XdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLOGAUp5VuNuZMFX8y1lcSOiRQMu9ywRllnavtH2gJw=;
 b=kfF/H9JNm3wfmDK1KWIfHOaK201S2egif9jJrdXYp3pCeXwzdDX1CKkQne1uY1+hskZ+tiXskfyGDhgYqJrLYRlf2xvtp8iua0Z7yQh5iCguHwAf7uyGw/GHOQGuM78UZMlrnD9DqeU1oPy7Ebxh7eHf9TRuPPs7cU47gFAtgN9dRXI1qX7ffJR5P9F9K4dZLS8VJwWbWSRy9CiUdRL7YrjzoCh2GFnOdwD8J6jh6fmEQa3qnsUCSw8j8AiWlwGKcT2J7mSqzRumqzgDsNlvG0VifJFrBuENE/Nu6QSY8GXxnDwSzeXtF6rbBQYxYyNUZnUogEyh1xdaWNgzUCF5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLOGAUp5VuNuZMFX8y1lcSOiRQMu9ywRllnavtH2gJw=;
 b=WHWe1nQQ+Jm5JJ360U7EvEyGUBR65E454Pq3oj6zq263QGEeB9NS3eFsbN5QdLmfUB2D1Kvmu3h3XUuEfl6GZhYvDTD5XbiRzy70zuK0OntbRnoF1R2QiWfnaDCI5iVYn3enGCp5p6/wodYLZJJw5IO4bS2x8XSzBm18wfrBIUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 21:05:05 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:05:05 +0000
Message-ID: <67e190b3-deb9-44c0-a3a1-d269de677c21@amd.com>
Date: Mon, 27 Apr 2026 17:05:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: "Huang, Honglei1" <honghuan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alexander.Deucher@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, matthew.brost@intel.com,
 rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 aliceryhl@google.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <9e2bee93-306a-4ef0-80be-daed33c8bbb5@amd.com>
 <7a3ebad2-839a-4a88-911f-c9bb7be3b00e@amd.com>
 <daa7239f-7fc9-492d-849f-2d46bd84999b@amd.com>
 <9c5afd4b-f9f0-445a-9b39-35f56fa2bea4@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <9c5afd4b-f9f0-445a-9b39-35f56fa2bea4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::24) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: fa57bbe2-c0f8-439c-fe31-08dea4a0a7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: KhuLqiUdhW5ftRIHkJytdJ99ayoaZx/C3Vn8MFBdLPAfYdbXYYYBwViLfOqwU/fml1ZqAdN1ib5GLvAmDe9xCO+w/YQu/7fGMw7zVl96+23n5lNY/NKnlD+7M3XCgYB8+a9PIeH2D5KzFsRsFdCp3Yqr4S1wKa3LOzbAirMbjjc+HqNHXqYex4dlfBQcNuP0HO8iJxDsrJflpA9XeC2/Ua+nh0Tl8gfuNWx7ykEoW2ElX9Z/XRJpfec+tyhtRS5R7s7GAKnXPj30xQLVgyiXu1CnDeJXXeM6POG12tY3H3fOBxKmd4Jh9z3LkGjnGKYBydmeafu8RuqyANH4XPseHS+noz8InhKSz3SxFhEfPOP+Jj21kGIsuSzJnB2fJMud57sRFskJISIql4OSiWp8UwdRlUdafnC8XCIS7auxZZf5JPKYZK/69HKr/O2Br3PPt+Zf/cof1Wc0yDpkH9dAXJGXRTiwh5bBBMz6dQZSHGy5Qh7XvitZvZs9MTEwGtTpif2FPlgPNhOxNtcIwD15oqaznQqJN2L/iHj0FASflk+KIJtHV0kEwSO9quEiU8m3wGH4or/QrsNCMl0c9GAIzIsyXEyGCTI0d0wULHjd4L0IaEh7/o681TkRhoFrSBmaiokp6P2K7FegTyfOns+ZpqNxZhCspsV90mileR8I0jGf6D6/K2xU5n6GETcaQsFEsY6s++u/zNKICvUCEev8uj4qQQcq2J2ZkAG7Bu9h/NY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHF0OTd5eUZLZ1NjMlEvcFF4QTZqRlU4Qm0vNmlHNW5uT2xCK052djBZSUtS?=
 =?utf-8?B?M0M3MEw1ZFRmS3dPYUN6Nk1qTERpdFhia3lYaEt6UWU2Z3lQM0FJeGM4a1No?=
 =?utf-8?B?TGdiNk0rS3VXbUJkMk9GcEhBUWE4VExxa0J0L1E3U05DQmdKRXdVTWU2Y0Ri?=
 =?utf-8?B?amU0S3lTbDluS0ZBSGJraDVMTXhnYkxaUHdXUU81dThHcjZzUmFnWHJpeTNQ?=
 =?utf-8?B?N3dqNWt2dnIzR2xxZTlhWWZHU0QvN0orOHNiV2wzakdpaHNwM0hheTNvY0tV?=
 =?utf-8?B?L3RSVEwzRm54eWh1UVpJSElSelc4OXJ2NEQ2aXplaHlzTFZzWHN3OHl2eXBo?=
 =?utf-8?B?RFFBSHJ5Vm5RM1dmeE1odFRQZW10alNCRGxUUStUeTYyWW9wWUxlWW1nNkJy?=
 =?utf-8?B?RDYxMEdPd1NvWWVzQ3V5MUtVVENrUlcxNDEvYU1QYngyN1dXd1FwOEpkNE1H?=
 =?utf-8?B?a1RabTBuaVlxRXVHRGZkYU9GaVowMkZnS1krbVh1VEdoQ0ZZeXBSbWRuejNY?=
 =?utf-8?B?VFRnVWFVUWtocnhHZEZnaUo3dXZkM2VKcVZza3NlUFh6RjVBUlU1S3R0S3NI?=
 =?utf-8?B?ZWtmZG9WNks2QU5LL2VLVHM4dUlxUzBtYVVvbnh0SUlhRDJFWkxjVFdwZ0hi?=
 =?utf-8?B?YXhjMHN4cmF4bEw4Y3NySEZrNjZTcHVmNGNIN3NlU3paNWo0ZkRPUjhDUSsw?=
 =?utf-8?B?OXlsRVNsdERscTI2QW1qUUp1YVQrclUvbXNUTmM4bGtaaDhWTkF2czI3L2ll?=
 =?utf-8?B?WVErZElwVmVXVVJLVmc1ZTU1ajloVklIT2hzYkNjcnNPWjd5eitWaGZXaVNZ?=
 =?utf-8?B?R1EyOHg0ZXV4U2hjWnc2MC8vSHVRQmdKTm5jdHd5SExNUWE4Zm5WMlBpdkRv?=
 =?utf-8?B?ZWE1V05MM0NTd2NESGNLZ3VrdXE2YXUzREIxc3NmUjFrb3dTblpweWtoV2hJ?=
 =?utf-8?B?TXZUUEtMWTlHcGptMkl1eGVBWXBJYXAyMG1yRGQrSUh4TG9GdHdpQjFJb2lK?=
 =?utf-8?B?ZGQ4WEhzL3FrUm92NVUyd0dudDFKV09QSFEwemlPTXNNR2dML2hLYk5NdzdC?=
 =?utf-8?B?cmNMRDR1ZzRlM245VW90ZnZUQ2pXRTlFV1JaWi9xZkc0eERtczRtYjU4dEJa?=
 =?utf-8?B?ZGhSNlBpN2M3cDRsVlg1U0g1Si9INjZSWmw1RVlHZHdxQ2Q5ODZ2dXFCS3Jt?=
 =?utf-8?B?K0NyVkNGa3MxZXYzM2xHYThOZzZSMmg0aFRSb1d6S0dkUnpuckZFQ2I5emo3?=
 =?utf-8?B?WWo0cStmSmVTR01tVmV5YXlKS01VbFhidHRrMXJJQmdBL2VkcTF3ZnJITjc4?=
 =?utf-8?B?eHhXdDg1cjVmaGJNY2dZK00wbnRRdTVpTlExNzRWbjNDNlV2dGdqeTYvS0VW?=
 =?utf-8?B?djFqQnZITmtJVmNyL09la1dvcjR5ZkRNeHBsM2k5ZC81aUxCYi82b01EMzU0?=
 =?utf-8?B?WDBvSXBSaGVHREI3Znl1eDI3eXZDZ2NOUUdEUFBZVm55dUZJVDF5L1JxTElr?=
 =?utf-8?B?WDk3NjVxYmlMd1RUcW5lQnNGTVB0MUN0ZEZJdnJIR2RZYUVQdC96UUR1Vnd2?=
 =?utf-8?B?SHd1Zmo2dG5nclgrWUV1UEZCZHdpL2JVNkJVQnRlVkhrNm5TWVp5Wlp1OGxk?=
 =?utf-8?B?TmNzZFVLNC9FeWZ4S1FFekt4MzdJR3BHSGdadnNLRUViYi8wM3M0VDFZbUM1?=
 =?utf-8?B?cHBzYVpzVFNIVllNbVZJK1RsNTRYV00yUnhvVVZHamRGQ0sxdkIrK29rUW56?=
 =?utf-8?B?WndURHl5U2NFOHBEaDFvMm44NytaT05pUk9IZ0JjRXM4UTZoUkVzTjd1NGlQ?=
 =?utf-8?B?UTVJSjBwYy8yZ09JamJlOGp5TVorSGdPWWVrc3Z4SWRHRTlxK3NJSWFKTVo3?=
 =?utf-8?B?eHFaeER1VlU0M0pOSXRNak5yQUpPdTNCdFVOdVZPVTM0V2RGOTFlaktUbmRO?=
 =?utf-8?B?endoMW5SejBQNjNMTzhmcUdaUGFVKzRjNXVDVGY0aVY2aXdlZkJCNFMwNGhp?=
 =?utf-8?B?NG9haHNVc0tybjJiZWJaL3IwTmgrNEpHQklUbmFUZHZGUGdpcjd2cnB1aTNr?=
 =?utf-8?B?Uzc2VXEyZ2pMdytTcFI5VWFSeThuWWRNT2RXLzFYbVdpcjVrZmZkUnhLRFA2?=
 =?utf-8?B?SFJjMnYrbWNLUlB1VFJRc3VxQkNmeE1rMXlIQmZ6REhIenhFVE5aOUJXS3ly?=
 =?utf-8?B?bDArbkY0aVhHcFVxblozVGZwZitmM29rQUN0clBLZjdyWGgwdXY3TzVtNm5M?=
 =?utf-8?B?akx0cXI1a3lrZXJ1M0NZRTlYNDRIaHZPNnNzeDNCS0VOUThUTVJyVFI1bVpI?=
 =?utf-8?B?SDZlWU9FcVRHdGpnSUFDbTVnSWlSYWNNTjRKTEJZRnRVSFJyK3R3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa57bbe2-c0f8-439c-fe31-08dea4a0a7a6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:05:05.0431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xqCVPeIEm7OSuMFiTDKKyG5ms9oBPsVo2B9Fw6JbQzJnfwejaE32bmHfVXk/tuS8ASoE98WeXe7b1WJALsV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332
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


On 2026-04-24 06:12, Huang, Honglei1 wrote:
>
>
> On 4/23/2026 7:06 PM, Huang, Honglei1 wrote:
>>
>>
>> On 4/23/2026 6:39 PM, Christian König wrote:
>>> On 4/23/26 08:21, Huang, Honglei1 wrote:
>>>>
>>>>
>>>> On 4/20/2026 11:37 PM, Christian König wrote:
>>>>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>>>>> On 4/20/2026 8:15 PM, Christian König wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 4/20/26 14:07, Honglei Huang wrote:
>>>>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>>>>>
>>>>>>>> Add amdgpu drm SVM API definitions built on the
>>>>>>>> DRM GPUSVM framework.
>>>>>>>>
>>>>>>>> This includes:
>>>>>>>> - DRM_AMDGPU_GEM_SVM ioctl
>>>>>>>> - AMDGPU_SVM_FLAG_* flags
>>>>>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>>>>>>> - AMDGPU_SVM_ATTR_* attribute types
>>>>>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>>>>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>>>>>>
>>>>>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>>>>>> ---
>>>>>>>>     include/uapi/drm/amdgpu_drm.h | 39 
>>>>>>>> ++++++++++++++++++++++++++ +++++++++
>>>>>>>>     1 file changed, 39 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/ 
>>>>>>>> amdgpu_drm.h
>>>>>>>> index 406a42be4..bed71ed9b 100644
>>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>>>>     #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>>>>     #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>>>>     #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>>>>       #define DRM_IOCTL_AMDGPU_GEM_CREATE 
>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union 
>>>>>>>> drm_amdgpu_gem_create)
>>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE 
>>>>>>>> + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL 
>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct 
>>>>>>>> drm_amdgpu_userq_signal)
>>>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_WAIT 
>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct 
>>>>>>>> drm_amdgpu_userq_wait)
>>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES 
>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct 
>>>>>>>> drm_amdgpu_gem_list_handles)
>>>>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>>>> DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>>>>       /**
>>>>>>>>      * DOC: memory domains
>>>>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>>>>         __u64 matrix[12];
>>>>>>>>     };
>>>>>>>>     +#define AMDGPU_SVM_FLAG_HOST_ACCESS 0x00000001
>>>>>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>>>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL 0x00000004
>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_RO 0x00000008
>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY 0x00000020
>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED 0x00000040
>>>>>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT 0x00000080
>>>>>>>> +
>>>>>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>>>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>>>>>> +
>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>>>>>
>>>>>>> Up till here the interface makes perfect sense, but then it 
>>>>>>> becomes a bit fuzzy.
>>>>>>>
>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>>>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>>>>>
>>>>>>> Why are those separate attributes? What is the difference 
>>>>>>> between those?
>>>>>>
>>>>>> Really thanks for the comments, I have some content mistaken in 
>>>>>> V2, so I updated the V3 to fix that. For the header they are 
>>>>>> same. for other content please review the V3, sorry about that. 
>>>>>> And will fix the concern you raised in next version.
>>>>>>
>>>>>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and 
>>>>>> AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, 
>>>>>> and the SVM can set the preferred location, it can be in VRAM or 
>>>>>> system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM 
>>>>>> and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>>>>>> it can not migrate, GPU only can access it in the initial place.
>>>>>
>>>>> Yeah but that doesn't then the interface doesn't seem to make 
>>>>> sense since such states are mutual exclusive.
>>>>>
>>>>> It would make sense when you have some attribute which is named 
>>>>> (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values 
>>>>> INACCESSIBLE, IN_PLACE, MIGRATE.
>>>>
>>>> Got it so can I change the UAPI to the following format?
>>>>
>>>> enum amdgpu_ioctl_svm_attr_type {
>>>>      AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
>>>>      AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
>>>>      AMDGPU_IOCTL_SVM_ATTR_ACCESS,
>>>>      AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
>>>>      AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
>>>>      AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
>>>> };
>>>>
>>>> enum amdgpu_ioctl_svm_location {
>>>
>>> The enum name could probably be improved, but apart from that looks 
>>> reasonable to me.
>>
>> Will improve the name.
>>>
>>>>      AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
>>>>      AMDGPU_SVM_ACCESS_IN_PLACE = 2,
>>>>      AMDGPU_SVM_ACCESS_MIGRATE = 3,
>>>> };
>>>>
>>>>>
>>>>>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>>>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>>>>>
>>>>>>> Why is that separated into set and clear flags?
>>>>>>
>>>>>> This method inherits from KFD and is also designed to be 
>>>>>> compatible with upper layer applications such as ROCR.
>>>>>
>>>>> That is *not* sufficient as justification. We need to document why 
>>>>> that is necessary and *not* just say ROCR works that way.
>>>>>
>>>>> As far as I can see just a SET_FLAGS should be sufficient.
>>>>
>>>> Accoding to the reply form Felix, CLR_FLAGS provides a convenient 
>>>> method for deleting large-scale flags, do we need to redesign this 
>>>> part?
>>>
>>> I think we should expose those flags as individual attributes then.
>>
>> Got it will do.
>>
>>>
>>>>>
>>>>>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>>>>>> +
>>>>>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED 0xffffffff
>>>>>>>
>>>>>>> No location for device local memory?
>>>>>>
>>>>>> Vaule > 0 means for device memory, in xe_svm, it seems like it 
>>>>>> uses fd for device local memory.
>>>>>
>>>>> Absolute clear NAK for that approach. This interface is per FD!
>>>>>
>>>>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the 
>>>>> memory should be migrated to the current device.
>>>>>
>>>>> We also need to make sure that setting attributes for different 
>>>>> devices doesn't affect each other.
>>>>
>>>>
>>>> I Totally agreed with your thoughts, but according to the reply 
>>>> from matt, it seems like we need to consider the P2P/multi GPU 
>>>> situation.
>>>
>>> When the drm_svm or pagemap component has already code to deal with 
>>> that then it is probably ok to have the same interface.
>>>
>>> When when XE only hacked that together on their own then that is a 
>>> bit questionable because getting the lifetime right is usually tricky.
>>>
>>>>
>>>> So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need 
>>>> to modify the UAPI to align with xe_svm?
>>>
>>> I think we need to full clarify how XE works here. E.g. that you can 
>>> specify both 0 as well as give the fd to get the memory migrated to 
>>> the local device sounds odd.
>>
>> Got it, for this part maybe require more discussion and time to fully 
>> understand, so this part will remain unchanged in the next version.
>>
>
> Hi Christian, Felix,
>
> Based on the v3 review, I've reworked the SVM UAPI. Please let me know 
> if anything still looks off before I post v4.
>
> Changes with v3 UAPI:
>   - OP / ATTR_TYPE / ACCESS / LOCATION converted to documented enums.
>   - Three ACCESS_* attribute types collapsed into a single
>     AMDGPU_SVM_ATTR_ACCESS carrying enum amdgpu_ioctl_svm_access.
>   - ACCESS/MIGRATE renamed to ALLOW_MIGRATE to means permitted, not 
> required
>   - SET_FLAGS / CLR_FLAGS removed; each former flag is now its own
>     attribute carrying enum amdgpu_ioctl_svm_flag_value: CLR / SET
>
>
>   enum amdgpu_ioctl_svm_op {
>           AMDGPU_SVM_OP_SET_ATTR = 0,
>           AMDGPU_SVM_OP_GET_ATTR = 1,
>   };
>
>   enum amdgpu_ioctl_svm_attr_type {
>           AMDGPU_SVM_ATTR_PREFERRED_LOC           = 0,
>           AMDGPU_SVM_ATTR_PREFETCH_LOC            = 1,
>           AMDGPU_SVM_ATTR_ACCESS                  = 2,
>           AMDGPU_SVM_ATTR_GRANULARITY             = 3,
>           AMDGPU_SVM_ATTR_HOST_ACCESS             = 4,
>           AMDGPU_SVM_ATTR_COHERENT                = 5,
>           AMDGPU_SVM_ATTR_EXT_COHERENT            = 6,
>           AMDGPU_SVM_ATTR_HIVE_LOCAL              = 7,
>           AMDGPU_SVM_ATTR_GPU_RO                  = 8,
>           AMDGPU_SVM_ATTR_GPU_EXEC                = 9,
>           AMDGPU_SVM_ATTR_GPU_READ_MOSTLY         = 10,
>           AMDGPU_SVM_ATTR_GPU_ALWAYS_MAPPED       = 11,
>   };
>
>   enum amdgpu_ioctl_svm_access {
>           AMDGPU_SVM_ACCESS_INACCESSIBLE          = 0,
>           AMDGPU_SVM_ACCESS_IN_PLACE              = 1,
>           AMDGPU_SVM_ACCESS_ALLOW_MIGRATE         = 2,
>   };
>
>   enum amdgpu_ioctl_svm_location {
>           AMDGPU_SVM_LOCATION_SYSMEM              = 0,
>           AMDGPU_SVM_LOCATION_UNDEFINED           = 0xffffffff,
>   };
>
>   enum amdgpu_ioctl_svm_flag_value {
>           AMDGPU_SVM_FLAG_CLR                     = 0,
>           AMDGPU_SVM_FLAG_SET                     = 1,
>   };

Looks reasonable to me. But I'm not sure you really need enum 
amdgpu_ioctl_svm_flag_value. I'd just use 0 and non-zero to mean false 
and true.

Regards,
   Felix


>
>
> Regards,
> Honglei
>
>> Regards,
>> Honglei
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>> Honglei
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>> +struct drm_amdgpu_svm_attribute {
>>>>>>>> +    __u32 type;
>>>>>>>> +    __u32 value;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +struct drm_amdgpu_gem_svm {
>>>>>>>> +    __u64 start_addr;
>>>>>>>> +    __u64 size;
>>>>>>>> +    __u32 operation;
>>>>>>>> +    __u32 nattr;
>>>>>>>> +    __u64 attrs_ptr;
>>>>>>>> +};
>>>>>>>
>>>>>>> Those struct make perfect sense but clearly need documentation. 
>>>>>>> Preferable as kerneldoc.
>>>>>>>
>>>>>>> And we usually use unions in this header to separate the input 
>>>>>>> from the output parameters.
>>>>>>
>>>>>> Got it will add documentation for it and will use unions in next 
>>>>>> version. Really thanks for the comments.
>>>>>>
>>>>>> Regards,
>>>>>> Honglei
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> +
>>>>>>>>     #if defined(__cplusplus)
>>>>>>>>     }
>>>>>>>>     #endif
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>
