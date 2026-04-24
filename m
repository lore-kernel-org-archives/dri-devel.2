Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055FCFE51FF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555BB89811;
	Fri, 24 Apr 2026 10:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4yCC82pN";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552A389811;
 Fri, 24 Apr 2026 10:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3gsMvLIFErVUD7ahupM6pP9oHSJZie5TaTNidFyzA5tKNDnVBnLu1yU3Qe9urRtZjFeueVk9B/8IQSlADIIvsxMrX/5BR0LVHvwB9p5GoXbJAWD6Vf3z1djxtD5MaqsBR3YyGLTXgf6WURsOiRAQ6TJ6V6gLb4zvFyM0v4AtjOPSXzv9rErvGudiQkJoXqiB67DuSKyw3q32k4Pba4RrNenmX1yChW1Q1HgsgQIBNsUjEnvhQDPzcJ0Sq+pjSCocOOXMJoKB37xVdHtIaqtvZ3OlKgUHhgoa0F/tVCfe4vhEyAhBnUJrJzpVMt8Zkh0XG+IixSbFlz6fKCs6N3VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaL49EWKSxnpWHCESXM86GgLPS9BrUYZdxgrE59z7zE=;
 b=I9qp5YRKMt4wiwcYK0PjCHcx80kAodjIT/+XDE38j15mod8TCPpN4hezSY/FsvhtBqF7TPPa5s3PF/qBXYc0Y763LYHAq4hZiPD1MBzaev5TrqqK+CWrI7x0g4xVChIU2ZHawiff54+F6qUXZUu6GpmH8158Y6FC7NNOWPytAewsRlk8bitqfqS1QEOrDFdxcJFOMbX6ieqHGd6WKWKG2pjOtcpnTexW0yRCY8yWZ/jiRu0m2r4WM3jzTrIDQFrlYQIyscQWcH1JNk2qQSfUkAz6UKFnsZQljerieXbMnCrq9SsS4gqj9wSBmTWK2lHvySCL6r7/xJ0c0D4uj1HMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaL49EWKSxnpWHCESXM86GgLPS9BrUYZdxgrE59z7zE=;
 b=4yCC82pNivfuyomKnBEUCqNiQBjMVzWVy2tFbwW4WCHgvpqucmow/aId58xX9oQQOL8CNwjBTt8ZUmt63PUqH1MyLT5TI0kXYg8T1Cp7m/8EgVmKsp8Jocbchu3ULQLpmlS3jH789GvIGEa9a43TvWF5BX6m2hqj/kp5YxApEcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Fri, 24 Apr
 2026 10:21:00 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:21:00 +0000
Message-ID: <a60f3e6f-70ba-4649-a120-1d9c3a7279a8@amd.com>
Date: Fri, 24 Apr 2026 18:20:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: Matthew Brost <matthew.brost@intel.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, dakr@kernel.org, aliceryhl@google.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <9e2bee93-306a-4ef0-80be-daed33c8bbb5@amd.com>
 <7a3ebad2-839a-4a88-911f-c9bb7be3b00e@amd.com>
 <daa7239f-7fc9-492d-849f-2d46bd84999b@amd.com>
 <aep67Z1YrJBtf+27@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <aep67Z1YrJBtf+27@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0088.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::17) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: c061bb52-393e-43c4-7f21-08dea1eb2e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|18096099003;
X-Microsoft-Antispam-Message-Info: o/tuX3Hy32FsXiI8fIlhu/Co5tMfRg1hMVPpByg7CzUH64s9UFOyHA1jCs9m5LbvsRjx1GrtTYXbKJ0raoAZjkRO8mhqx2fNJSpDVEC/WPnHOAvehYknR4zJSMxRhBaQnUb7wRAPDZP88Y26xjtLuPp7L9vpa/Ss1aqK6oczVlpom/2S/Ea6onJINWKlhyNZthl/0BErCBr3/ssBDBB1sa7lU4xUzblqeHfQbSEvngxx05yeTQnVO5QDj7/rL4SaJ5wDWlWIQxKSw2pr0QX5A0JMTxz+Eg2guE56/3SqhylYCNzxgybB1vyL5H+NIh+ngXdW/IdIYLqfM9uFM4jIWDVYvfe9acbmyw+xb538Nny56dNirDzrse+cnBPrvjhEgQtJ3KO+JkH3IAoX1VPC5bllAGNPdEJp2cUHnCjuXPwoPSCuvtcxoryME9FIBmJXzBOhSrYdEQDubrx8MAuybMRxRl8EkJ98NLKzxKasLMUTMNIgftGfNLk5NRa2umFfln+muJAN/J8VqHriJLaN6UG25rCttPiuqE3fY7jwb0sRzAeZ79+1mfytT0wj7llXgp6aovbKawpySO4rdkv91JD9GnuuO856TtY7YjYJ7LE7j55OY9BZDu6/f7f1uqBUjY0TzVjIc3szWUdkVDZaMc1MBEQHNIVdb+X9ux0uOaodcTrsEn7qA1yhTLbNW8Wr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(18096099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDVlVExNb0xFWlZ5TVpGb3dHWUphNmJaSFpsRmg1a2x4aExDNVlLM1ZzMzVN?=
 =?utf-8?B?S2owM1E4TlZGcndqeThEUU1lOTRPd29hb2JXVlljWVFxR1ZxakxuN1VydjFo?=
 =?utf-8?B?ajJpTTArWEdNSTZaU0tDZzlSajhzazVNYXpneE9TNEhuUUozVE9HK0Fnb3k5?=
 =?utf-8?B?YmpOSmIvK3VHVFlLQy9VMWlYZFhNOXFpd3RZSzB5SHBXaHhXekZtZHcrWWhx?=
 =?utf-8?B?SDlneXhuTGpUSFRPZ0RHU2xiQXQwa1h2T05zb0ZMRzhzSzJoT2d5cE91cmRI?=
 =?utf-8?B?a3U3WTE1ZTJ6NFNGOVdTVzVJNTl1Y3djUGhQSFQxOWhhZklhaU1CaWEwd0pW?=
 =?utf-8?B?MWlYcFNRcUtnTWZUR2NIZlFjZWFabjB3NUQ3RXgyRnQ2VzZnVDBaY21nbG9z?=
 =?utf-8?B?NFJkYlpGQnJubWFVMzZMcW00cldQTFRLUmFTYUxNV0xyUFM4QWZPeU5EUG9S?=
 =?utf-8?B?ZmlwczVOSEJJSkVETGJVMlZDYjRZNDB1ZkxOS2pBTEhmenNiZVo2azlsMGRh?=
 =?utf-8?B?emhGelg3MStXUTNZY0I4SmdEcTFvYnFXUDNRSmd0NnpSUEIxWkNYT2Q2U0tv?=
 =?utf-8?B?ZmRmSDFLRFdOMmpaVW5xaUlicjhvK1RhMWtEVmVqdCtDMUdFNm9BcVRJSmxa?=
 =?utf-8?B?WldBQXVHUHhIRTVuWVVXT01OaThGRUI5YktxTGdQMDNCeFdYQkRZc0JXQUVs?=
 =?utf-8?B?TUNHTndLNTFSc2xqS3FCQTBCRjl2U1h6WGorMmZLSGw5V1g1VnY2Mmtzc1Qr?=
 =?utf-8?B?TzRsUmlScUZPY2cyeTNDZE9qenJzMUw0OVd4NFF5cWE3bTBuM1ZMdEJxZVh2?=
 =?utf-8?B?bWV3YjRRYmRKNHduM1VKMjNzRWIvWmljRnhMemVydmFxN0xJU25rYkJlZjEz?=
 =?utf-8?B?Z3AvQWs4cTJlSmdqbTYzWjhYb0hKVmZEQUtoYzJOUG8xZ2U1YktMNUpUWUV2?=
 =?utf-8?B?cmZWVHM1dURVV3I5VXhXUFNvd3ViWWptanU5VjBEVzduTmVseFJUTmRXTXly?=
 =?utf-8?B?SFZuaWZTOVFVaTJTTStPTjlzU3hSRXZ3QjNtcktVS3ZOOGlJazN0bU5sMFJT?=
 =?utf-8?B?b000TTZzUFgrZHc2U25tRzhvUnJhMXFrNndSMzd1azJvek40WEN0T1d6cDNO?=
 =?utf-8?B?NUQxT3ZXQS9wTDVjV3R3ZnBOT1g5cE90eERVbm9RM3hucTlOMWlGSXRQdWZK?=
 =?utf-8?B?VnZvZnJobi9JMDJJM3A4RUx5U1hXSmRUeWhVL1htUHA4STdnaVhZTFAxVG8x?=
 =?utf-8?B?V2Q3VmtJSFhQMmVhODlZTW5aMFliWTdpWGZYdlovdk82cXZLTEdDSWtQcjNi?=
 =?utf-8?B?NWpwR2c1NU5uK21uK0dJQWpoS0MwYk93Y3RKOU45SXA4Z2JLaWRBRnpEREFU?=
 =?utf-8?B?elNHTGNraDdSdnhlVkhrM1FGMmw3ZkYyaUtUL05vQmEvdFlFSXNGY2pQYXF4?=
 =?utf-8?B?YWgzM1JpV2hLRUI2NVAxYm9pdlpseXlPOWJOMUFWb0tpcTcrWXpsZHlheitu?=
 =?utf-8?B?UmN1bU9HeDlIajd0SCtCUitWRXVzUmkxeUFmZVFqUU9lWWxWdllBV2ZKWVdM?=
 =?utf-8?B?SVJCSHBsZWEydmVPcFhxZThCTDIvODcrWTJ1cFRPMTVBNVdtc2pVNGVlVlNE?=
 =?utf-8?B?OG5jSHA2M3VzU2pxODg0a05HRzN2eC9uUHkzd3VkdWZhdncyQ2tvQlJPVGVE?=
 =?utf-8?B?SmwrVjM1SXZHVjNPQ1B6a1ZZajhMWjBzVERHMUNLOGMyMVdnaVloZEhOM25o?=
 =?utf-8?B?aG1ReGV2QzlVQWxyb0dEeUVNRUlkdHk4Q1J5dmpYbWdrQ1Jpbmo4V3FEbGpK?=
 =?utf-8?B?cmMwOUxhVjh2RUVrTGlaVVZxUm1yYkg0cTJHazFPTVAwR2tXRHlFWThtVUpm?=
 =?utf-8?B?Q2xvRGJ0K0QvM1JoT1g4UE55OEVhK1ZLazRvWXNScWlWUUhPQ0lzWjNETkcr?=
 =?utf-8?B?WGUzaXBzbko0OC81RDBoWUN3L0RhMnNsZCt0bFpmWHFaUTZmWkhzaW9UQytR?=
 =?utf-8?B?UWZLaUpVTnNMNEVaMFBOZHdVNzV1bFR6YUJwTllrRmdvSDVzcTNHVHpVZFFP?=
 =?utf-8?B?S3lJUC9qTUJPVDBNTHdob3RVWGl1OFluYURIalR0TFdEdW8zeXhueU0zbjFo?=
 =?utf-8?B?eWNqQzNQSDlibmQxaFF1czA1L3JQQTAranQ1QzNpNWIzRHVIamhBNTN3WmdJ?=
 =?utf-8?B?czlmOEtWT1lCR0tOeWNkZmN4OGgwNlNFMEloUmQ1WjRsSkJKVFJxbVFjOVR3?=
 =?utf-8?B?aURVbGxCWHJCL2RJd0FKVndWT1FST1RvMkFKakpEQnhrSExTTUVzKzV1N2tl?=
 =?utf-8?Q?yODxnEQAcTbwC/tq3S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c061bb52-393e-43c4-7f21-08dea1eb2e23
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:21:00.0305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQfwpfJPxAyOIVhffiVceG9KhIUyLhG9X8XbcDCeCaf054VQPIUST/0a8fzXxYN+IuKFNoNEfgsAn0kpSd9Fmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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



On 4/24/2026 4:02 AM, Matthew Brost wrote:
> On Thu, Apr 23, 2026 at 07:06:43PM +0800, Huang, Honglei1 wrote:
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
>>>>>>>>      include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>>>>>>>      1 file changed, 39 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>>>>>> index 406a42be4..bed71ed9b 100644
>>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>>>>      #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>>>>      #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>>>>      #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>>>>        #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>>>>      #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>>>>      #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>>>>>      #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>>>>>>      #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>>>>        /**
>>>>>>>>       * DOC: memory domains
>>>>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>>>>          __u64 matrix[12];
>>>>>>>>      };
>>>>>>>>      +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
>>>>>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>>>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
>>>>>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
>>>>>>>> +
>>>>>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>>>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>>>>>> +
>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>>>>>
>>>>>>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>>>>>>>
>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>>>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>>>>>
>>>>>>> Why are those separate attributes? What is the difference between those?
>>>>>>
>>>>>> Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
>>>>>>
>>>>>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>>>>>> it can not migrate, GPU only can access it in the initial place.
>>>>>
>>>>> Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
>>>>>
>>>>> It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.
>>>>
>>>> Got it so can I change the UAPI to the following format?
>>>>
>>>> enum amdgpu_ioctl_svm_attr_type {
>>>>       AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
>>>>       AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
>>>>       AMDGPU_IOCTL_SVM_ATTR_ACCESS,
>>>>       AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
>>>>       AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
>>>>       AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
>>>> };
>>>>
>>>> enum amdgpu_ioctl_svm_location {
>>>
>>> The enum name could probably be improved, but apart from that looks reasonable to me.
>>
>> Will improve the name.
>>>
>>>>       AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
>>>>       AMDGPU_SVM_ACCESS_IN_PLACE = 2,
>>>>       AMDGPU_SVM_ACCESS_MIGRATE = 3,
>>>> };
>>>>
>>>>>
>>>>>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>>>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>>>>>
>>>>>>> Why is that separated into set and clear flags?
>>>>>>
>>>>>> This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
>>>>>
>>>>> That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
>>>>>
>>>>> As far as I can see just a SET_FLAGS should be sufficient.
>>>>
>>>> Accoding to the reply form Felix, CLR_FLAGS provides a convenient method for deleting large-scale flags, do we need to redesign this part?
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
>>>>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
>>>>>>>
>>>>>>> No location for device local memory?
>>>>>>
>>>>>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
>>>>>
>>>>> Absolute clear NAK for that approach. This interface is per FD!
>>>>>
>>>>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
>>>>>
>>>>> We also need to make sure that setting attributes for different devices doesn't affect each other.
>>>>
>>>>
>>>> I Totally agreed with your thoughts, but according to the reply from matt, it seems like we need to consider the P2P/multi GPU situation.
>>>
>>> When the drm_svm or pagemap component has already code to deal with that then it is probably ok to have the same interface.
>>>
>>> When when XE only hacked that together on their own then that is a bit questionable because getting the lifetime right is usually tricky.
>>>
> 
> The drm_pagemap has a refcount which prevents it from disapearing. The
> refcounting is a little tricky but Thomas wrote it down here [1].
> 
> A shrinker is wired to drm_pagemap which when refcount is zero the
> drm_pagemap can reclaimed (i.e., free all device pages) as this is a
> non-trivial amount of memory (1/64 of VRAM size).
> 
> If drm_pagemap doesn't exist or has been reclaimed, next use (e.g.,
> create a VM on a device, madvise on pagemap on a report device, etc..)
> the drm_pagemap will be created.
> 
> [1] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/xe/xe_svm.c#L32
>   
>>>>
>>>> So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need to modify the UAPI to align with xe_svm?
>>>
>>> I think we need to full clarify how XE works here. E.g. that you can specify both 0 as well as give the fd to get the memory migrated to the local device sounds odd.
> 
> Yes, the oddity is partly because madvise / multi-gpu landed out of
> order and the pushback on exporting drm_pagemaps as FDs. Making
> everything FDs is a completely reasonable uAPI IMO. You'd have to have
> system memory FD though but that seems possible.
> 

Thanks Matt, this is very helpful.

I agree with your direction here. For the location part, I will run an 
experiment in AMDGPU following the approach you suggested.

After I have concrete results, I will return to you.

Regards,
Honglei

> Matt
> 
>>
>> Got it, for this part maybe require more discussion and time to fully
>> understand, so this part will remain unchanged in the next version.
>>
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
>>>>>>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>>>>>>>
>>>>>>> And we usually use unions in this header to separate the input from the output parameters.
>>>>>>
>>>>>> Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
>>>>>>
>>>>>> Regards,
>>>>>> Honglei
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> +
>>>>>>>>      #if defined(__cplusplus)
>>>>>>>>      }
>>>>>>>>      #endif
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>

