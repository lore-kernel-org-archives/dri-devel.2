Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EF6FF8870
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B68B10E975;
	Tue, 28 Apr 2026 06:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SiTCSpC8";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013033.outbound.protection.outlook.com
 [40.93.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825D610E046;
 Tue, 28 Apr 2026 06:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=da3dOJD3IrqkGsY8dUDG/C4ZIfU9zahFZGdOzpkmzCwFp91DqIGTfJ06oraKprwEx1lGptz3T3rntRHYjWHKYtFzhO2GXCvFccwk7ptT/zJSiO3QorEt9rq+1AuMwHj8hm3AYmjmI6m9osbnWnUZqIGC2vgQi9mIUfGYPucjN/aSvLmWSL7uvSTPjYzRCrDbapX7SSW5iURpKtf3NDiblTE9IiOwmFGma1wzPOQXBOFwhr9KgXIFIOxwHlaO/uDYgYj0iShzcm+ILJDCLKLsKvQnMgx/gJrYCZcmcKDS++82fCa1PK76svvzg6AcEjk3MHPIi++Ku27ytR51gst0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyMTWNjhPyVfUMK2doPHLlihyko1cSXjt3BdqFY5yTo=;
 b=jwP2hOzRBhyu2e+L3E/UNuGh53jHMdlptjr5bBe8T+DRCaSPER/vzGvIj5daN9P8hZNzdsnZwKF+R6khS8xWu/fwSINYlXWtWQS7i1bRz71iwOu3ngZJ0aGsCuaAAFDH6SNf52o64uOa0/DxWazU/9f4tHjp4g657l1fxzkTtN3Ptb8lLEoYAHMi2Kx1+EXjVi8aOp6s0txrGVclQMZGqjyiGc3S3TbIxFKXK7vkXoBzxs/OhKxk3fqEluCz+EeqSIn0Ytn0sqngmoPULBd9dwMoX+auQPi0bfhto+iPyKdwt6UevtUHRID4xCO1ZxVdmN7cNRd6F7KgYJr7yuAUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyMTWNjhPyVfUMK2doPHLlihyko1cSXjt3BdqFY5yTo=;
 b=SiTCSpC8xz9ax1LZj00wJ/RMncqabCieLu0kPJxcgYVFneFuqMb+cXZ77K69/7IwLOs94Z5yv2OFDWY0unRKQ6HvpPPGGV1KIA106jWuDdtsHY28Wi3xp43XHLvkaEtoaqXIzANaV+HnyDgVgK1p33t/ijQcXmKGo1vSIWdkYaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 06:49:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 06:49:40 +0000
Message-ID: <078b3f0f-cb92-4e4f-b863-d454958b690c@amd.com>
Date: Tue, 28 Apr 2026 08:49:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Huang, Honglei1" <honghuan@amd.com>
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
 <67e190b3-deb9-44c0-a3a1-d269de677c21@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <67e190b3-deb9-44c0-a3a1-d269de677c21@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec7d991-3771-4430-59f8-08dea4f25269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: NtykzZRTlw6ijozP0s+x7ofU57ZHLG++TGsYQIzHmEB+XddKwgDOXr82awwr/3TOA3+PkSHKBBpzwN1wct4IsT8u1u715kgjHuAojyFq0PvQnxlA9mB6/0c2orPFmiijXGgfy3VRiOaZF5Dkzda0P25t996oB1kS8x7xvxLckKJBcEJbPNeGe7EmY3zAto2vrkpFf03lFW5+GGWwqPnN4AvIC8+nS46c7ewfDMsHuqFNiHaNsbyLPgq1IG8UtT6ihhNPZ1KfMknjHl+EytX29gqKS0kC0m1phy1wKfJArpk4BJc1a1xUL3gKj3VoHCzclzQVG9sVM8cA1n66W4IF1g46knkq5JKdoPD9mEWj1qlK+IiHJVJ9ewWXUK4GQ8Uay9kSTbGOaCCqcK0kE3Zj1cgKUUxsGt91qzNwscoIl+19ySL6IUcEbG+ohgyaYpMDcmcnNvjcbtpzwXH6UE1dBre0TjM2YDpaYtxAWL2MAKalfAfoEPux5TNHFl3UvoAXwI7JN3SQXQkb79UFkedCz1ymy9Y1XgMlGnnrhlJaIHLWBDR+yJ2u8Z5hOjMmxgli8mTF57SmH2NeywCmD3RknYI6QCp2C6/jew/TnjEtZ1WJNVqYeWVtr7HMj7Dmi8kFyU2J4k32lSJHwt5mkIRFOn20YOCAwCNULWMjevaV72Uwpr0ANL5AtutL9pBkavEPe/sM7O5A1cgeR1ulOQFHZOG5+1dLytjzA9w9gnhPSrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXYzYXY4czgwOGFhK0RMaVpvb3lpWEJwMzRuaTg0UmpMRGhzTzI4Wnc2Z2pC?=
 =?utf-8?B?Zy9XYVVodFgzN1ZCalJ3eC9vT2N6eVJkQ3RaOHpGUHl1MHN3a0N0bXRRb0or?=
 =?utf-8?B?cWdvOUg4bzBLczJsRjhHS2xyWHU1UC9raWdVS2FhOStyK1JnVE9VOTlnU0l4?=
 =?utf-8?B?Q05BNTZkWEU5dVQ0Q0RNTE1FRkxWLzc0N1poL2lOVDRGNkJkdUNuTUZmaHcv?=
 =?utf-8?B?a2hMZGNERGlMemhrOS9xU3ZWeTU5SFJsbEQyUG5wUjRLaUFEaHdtcFJaRGwv?=
 =?utf-8?B?eTlrbllNZ3E2UzlweTYrZVNCZmVzZDBxaUY3eFV4Q0NiZ2xwZWF5akp5MC8z?=
 =?utf-8?B?bmZGMHRtRkp0TThYU3hlcmpaL2dCUUE5SnJxcldOeFZtc0xWVTdWSkRCdGgv?=
 =?utf-8?B?eWtKL0dubVJtYVdhOW9YUmd2emUzUWtFUFVkSzlJQXBSR242cXRwS0NBWkNN?=
 =?utf-8?B?cDdpMDhHYlhLTkhra3FYTEZObCs1cFpudnBVY1dXckhnK015Q29sUTRjdllu?=
 =?utf-8?B?TERwNXdSZ0xJOHN3UWVrT3pldkY2VVdUdlp5Q3FtQjNmaEppSFFoUGsxZVlj?=
 =?utf-8?B?bHU3dGdZak1qcDJ4aXh1RkQrTThkSXZ0YjlZY2ZmU2ZBYzBTV2tKeXQ4QzRU?=
 =?utf-8?B?UVlLUGRFWnBYM3dXYXl4THNkT0hXMWlIaE5SaUw5MzVJNHFreUg3VXY0YjUv?=
 =?utf-8?B?VlNodDJIcUdjcjc4d2FtSVBJaDZrV1ZERzVyWC9rVWJRVEV1Y3BpMmkwMDRT?=
 =?utf-8?B?R3lnQ1NWOHlmN2lPTWUvR1dtcVgwQUM4STVlWlBpdkRNb0xLejgvZ2w3d0hW?=
 =?utf-8?B?MHMyV0VBMUlZUmpVQW9yNTVYR0s3YWxQVFlDOGFCRU1Kb0pNTkpVaExOTmdm?=
 =?utf-8?B?dURTWHVvK0JRK2R3VkpoaFd1ZHM4QWNxSDVJMVpjcWZMbWY5SjgzbGg1bmEr?=
 =?utf-8?B?em12RThHdkMxeG1CYUd6WWszWVhWTTVONnA3Z0E1M0E3cUMzeHQ0MU84TkNr?=
 =?utf-8?B?OFg1MnlyV3lRcmloQ1FEUmNSaXBXWDJDOVpPQ1ppY3FRdmVyWmJNVlJaOVJE?=
 =?utf-8?B?QmNBUFpKZ3NEUjE5UTVDRDRVNWZyTldJeVZrOXExc0FieS9JRnRKOUFucTYr?=
 =?utf-8?B?UmxsSTNjeVFwOG5TeWhvMTNEMDFEZjgwSVdYVXIySTJyNGduVDllOUhzOVlC?=
 =?utf-8?B?UVJpMlJXZDBOcnNUK09NcWlUZHIvOFFoelNMT0tBd1lvSmRxYWRHTzc3Uk9B?=
 =?utf-8?B?U1NocUwzQ3ZLUW51N0VsdUFWSXVjTjM1NDllLzMycWJodngrWGxodzRnRzJL?=
 =?utf-8?B?Y1AxdU8wUUlvajNzcXdkUEMxbzdQYnJVSFB6aFJ3WXJZK0lUK1IxRTRtMXMw?=
 =?utf-8?B?UVlHaWVTWFV3TEJOS3JzMUNzRERZanQzWmI4QlpwbVlZb241d0hlZ0xudy9B?=
 =?utf-8?B?VVdSOUowajN2Q1pwSHJmbUJCeW9xcVlGK01MNHlpK3JCMStKSTFHdW5BRWp1?=
 =?utf-8?B?M21LRERaS1JuQjBqU0ZqalYvRnF6U0dJQXMvWWgzOGZCWkRsUVdMWXhwbm45?=
 =?utf-8?B?NHhJSTFVVDFEU0NRVnc0dlZudUc5UndwSHpMd0d2aFg0a1lwSFd4eml5T2JM?=
 =?utf-8?B?NHdobEgzRXpLb201Wnc5R2w5czBpUUlCYlVyNDAwbWREZk1CVUV6YkFISkV5?=
 =?utf-8?B?ZjFGemNIRFExTEhrclA2V2hHcEIrS25obXRoY1h1WnBpejNoVStucFZnOVpK?=
 =?utf-8?B?akd4YTFqNXluY1lzMVByOUo4N04xTHF2RUxBYXRid0hIaStid3BtUTBLempO?=
 =?utf-8?B?aEI2SUtwclJzTGI0S3NvQVEwNzcyRFMydDk2c256SmxoSEw3amxjVWxvOUF3?=
 =?utf-8?B?RWZRR1o5T3pKeHk5andLOHVpK0Q0andSUUNsV0JNcDZSOEtuZGVuVFBFMDJt?=
 =?utf-8?B?WldZRkd1NlEvaGVCYnprOUJIbUdEeWZXUXdFYWFXOEVIQys5SUZwLzVqL2lt?=
 =?utf-8?B?UHBFaVdqNEhFaUdXNTVQaGhtNHJCM09IUml0NWtzdkdERjZGQjJKandCdVNO?=
 =?utf-8?B?Y081dzZuNGwrOEE3MzZVd3lQNXdaZElrQTY3SDd6WjExbUlGY3B0SEQ5ZHJP?=
 =?utf-8?B?eFBKdUMyMm9nZjMxYkM3dEVST0puekF6SktVdm9vNVpDWFJ5SlZjdXVHMDFN?=
 =?utf-8?B?T2VZV1VmZ0ZaWEFIYnZmdUNsUHNyZ0MrS3JlOHV1eTlQZE9Fa1ltQVRyZXIy?=
 =?utf-8?B?TFV3WjNUeURvSmh3SlBac1FYV3k3VmxieTR0anJHajhsalkzTUpsNkdsbU5a?=
 =?utf-8?Q?ZVLsMcEdh8FGkuw4Ld?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec7d991-3771-4430-59f8-08dea4f25269
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:49:40.6628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNh28BGf8oWVt4tdeaBS2pfemdBdiUufgVHpvHdCqjUtzUF4AAqNk2v0lcxWiPGu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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



On 4/27/26 23:05, Felix Kuehling wrote:
> 
> On 2026-04-24 06:12, Huang, Honglei1 wrote:
>>
>>
>> On 4/23/2026 7:06 PM, Huang, Honglei1 wrote:
>>>
>>>
>>> On 4/23/2026 6:39 PM, Christian König wrote:
>>>> On 4/23/26 08:21, Huang, Honglei1 wrote:
>>>>>
>>>>>
>>>>> On 4/20/2026 11:37 PM, Christian König wrote:
>>>>>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>>>>>> On 4/20/2026 8:15 PM, Christian König wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 4/20/26 14:07, Honglei Huang wrote:
>>>>>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>>>>>>
>>>>>>>>> Add amdgpu drm SVM API definitions built on the
>>>>>>>>> DRM GPUSVM framework.
>>>>>>>>>
>>>>>>>>> This includes:
>>>>>>>>> - DRM_AMDGPU_GEM_SVM ioctl
>>>>>>>>> - AMDGPU_SVM_FLAG_* flags
>>>>>>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>>>>>>>> - AMDGPU_SVM_ATTR_* attribute types
>>>>>>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>>>>>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>>>>>>>
>>>>>>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>>>>>>> ---
>>>>>>>>>     include/uapi/drm/amdgpu_drm.h | 39 ++++++++++++++++++++++++++ +++++++++
>>>>>>>>>     1 file changed, 39 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/ amdgpu_drm.h
>>>>>>>>> index 406a42be4..bed71ed9b 100644
>>>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>>>>>     #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>>>>>     #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>>>>>     #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>>>>>       #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_WAIT DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>>>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>>>>>       /**
>>>>>>>>>      * DOC: memory domains
>>>>>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>>>>>         __u64 matrix[12];
>>>>>>>>>     };
>>>>>>>>>     +#define AMDGPU_SVM_FLAG_HOST_ACCESS 0x00000001
>>>>>>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>>>>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL 0x00000004
>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_RO 0x00000008
>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY 0x00000020
>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED 0x00000040
>>>>>>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT 0x00000080
>>>>>>>>> +
>>>>>>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>>>>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>>>>>>> +
>>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>>>>>>
>>>>>>>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>>>>>>>>
>>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>>>>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>>>>>>
>>>>>>>> Why are those separate attributes? What is the difference between those?
>>>>>>>
>>>>>>> Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
>>>>>>>
>>>>>>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>>>>>>> it can not migrate, GPU only can access it in the initial place.
>>>>>>
>>>>>> Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
>>>>>>
>>>>>> It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.
>>>>>
>>>>> Got it so can I change the UAPI to the following format?
>>>>>
>>>>> enum amdgpu_ioctl_svm_attr_type {
>>>>>      AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_ACCESS,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
>>>>> };
>>>>>
>>>>> enum amdgpu_ioctl_svm_location {
>>>>
>>>> The enum name could probably be improved, but apart from that looks reasonable to me.
>>>
>>> Will improve the name.
>>>>
>>>>>      AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
>>>>>      AMDGPU_SVM_ACCESS_IN_PLACE = 2,
>>>>>      AMDGPU_SVM_ACCESS_MIGRATE = 3,
>>>>> };
>>>>>
>>>>>>
>>>>>>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>>>>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>>>>>>
>>>>>>>> Why is that separated into set and clear flags?
>>>>>>>
>>>>>>> This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
>>>>>>
>>>>>> That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
>>>>>>
>>>>>> As far as I can see just a SET_FLAGS should be sufficient.
>>>>>
>>>>> Accoding to the reply form Felix, CLR_FLAGS provides a convenient method for deleting large-scale flags, do we need to redesign this part?
>>>>
>>>> I think we should expose those flags as individual attributes then.
>>>
>>> Got it will do.
>>>
>>>>
>>>>>>
>>>>>>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>>>>>>> +
>>>>>>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>>>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED 0xffffffff
>>>>>>>>
>>>>>>>> No location for device local memory?
>>>>>>>
>>>>>>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
>>>>>>
>>>>>> Absolute clear NAK for that approach. This interface is per FD!
>>>>>>
>>>>>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
>>>>>>
>>>>>> We also need to make sure that setting attributes for different devices doesn't affect each other.
>>>>>
>>>>>
>>>>> I Totally agreed with your thoughts, but according to the reply from matt, it seems like we need to consider the P2P/multi GPU situation.
>>>>
>>>> When the drm_svm or pagemap component has already code to deal with that then it is probably ok to have the same interface.
>>>>
>>>> When when XE only hacked that together on their own then that is a bit questionable because getting the lifetime right is usually tricky.
>>>>
>>>>>
>>>>> So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need to modify the UAPI to align with xe_svm?
>>>>
>>>> I think we need to full clarify how XE works here. E.g. that you can specify both 0 as well as give the fd to get the memory migrated to the local device sounds odd.
>>>
>>> Got it, for this part maybe require more discussion and time to fully understand, so this part will remain unchanged in the next version.
>>>
>>
>> Hi Christian, Felix,
>>
>> Based on the v3 review, I've reworked the SVM UAPI. Please let me know if anything still looks off before I post v4.
>>
>> Changes with v3 UAPI:
>>   - OP / ATTR_TYPE / ACCESS / LOCATION converted to documented enums.
>>   - Three ACCESS_* attribute types collapsed into a single
>>     AMDGPU_SVM_ATTR_ACCESS carrying enum amdgpu_ioctl_svm_access.
>>   - ACCESS/MIGRATE renamed to ALLOW_MIGRATE to means permitted, not required
>>   - SET_FLAGS / CLR_FLAGS removed; each former flag is now its own
>>     attribute carrying enum amdgpu_ioctl_svm_flag_value: CLR / SET
>>
>>
>>   enum amdgpu_ioctl_svm_op {
>>           AMDGPU_SVM_OP_SET_ATTR = 0,
>>           AMDGPU_SVM_OP_GET_ATTR = 1,
>>   };
>>
>>   enum amdgpu_ioctl_svm_attr_type {
>>           AMDGPU_SVM_ATTR_PREFERRED_LOC           = 0,
>>           AMDGPU_SVM_ATTR_PREFETCH_LOC            = 1,
>>           AMDGPU_SVM_ATTR_ACCESS                  = 2,
>>           AMDGPU_SVM_ATTR_GRANULARITY             = 3,
>>           AMDGPU_SVM_ATTR_HOST_ACCESS             = 4,
>>           AMDGPU_SVM_ATTR_COHERENT                = 5,
>>           AMDGPU_SVM_ATTR_EXT_COHERENT            = 6,
>>           AMDGPU_SVM_ATTR_HIVE_LOCAL              = 7,
>>           AMDGPU_SVM_ATTR_GPU_RO                  = 8,
>>           AMDGPU_SVM_ATTR_GPU_EXEC                = 9,
>>           AMDGPU_SVM_ATTR_GPU_READ_MOSTLY         = 10,
>>           AMDGPU_SVM_ATTR_GPU_ALWAYS_MAPPED       = 11,
>>   };
>>
>>   enum amdgpu_ioctl_svm_access {
>>           AMDGPU_SVM_ACCESS_INACCESSIBLE          = 0,
>>           AMDGPU_SVM_ACCESS_IN_PLACE              = 1,
>>           AMDGPU_SVM_ACCESS_ALLOW_MIGRATE         = 2,
>>   };
>>
>>   enum amdgpu_ioctl_svm_location {
>>           AMDGPU_SVM_LOCATION_SYSMEM              = 0,
>>           AMDGPU_SVM_LOCATION_UNDEFINED           = 0xffffffff,
>>   };
>>
>>   enum amdgpu_ioctl_svm_flag_value {
>>           AMDGPU_SVM_FLAG_CLR                     = 0,
>>           AMDGPU_SVM_FLAG_SET                     = 1,
>>   };
> 
> Looks reasonable to me. But I'm not sure you really need enum amdgpu_ioctl_svm_flag_value. I'd just use 0 and non-zero to mean false and true.

Yeah agree. We also should have true/false in stdbool.h or by the C standard itself.

Apart from that looks good to me as well.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>>
>> Regards,
>> Honglei
>>
>>> Regards,
>>> Honglei
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>> Honglei
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +struct drm_amdgpu_svm_attribute {
>>>>>>>>> +    __u32 type;
>>>>>>>>> +    __u32 value;
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +struct drm_amdgpu_gem_svm {
>>>>>>>>> +    __u64 start_addr;
>>>>>>>>> +    __u64 size;
>>>>>>>>> +    __u32 operation;
>>>>>>>>> +    __u32 nattr;
>>>>>>>>> +    __u64 attrs_ptr;
>>>>>>>>> +};
>>>>>>>>
>>>>>>>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>>>>>>>>
>>>>>>>> And we usually use unions in this header to separate the input from the output parameters.
>>>>>>>
>>>>>>> Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Honglei
>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>>     #if defined(__cplusplus)
>>>>>>>>>     }
>>>>>>>>>     #endif
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>

