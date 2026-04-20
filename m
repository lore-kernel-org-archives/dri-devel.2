Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38969F588C4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A0710E642;
	Mon, 20 Apr 2026 13:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uteaJHAw";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DCA10E642;
 Mon, 20 Apr 2026 13:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0ncuuHX0dXMZlK1ICdqurywAUsY5qwCQEEqqh7TU5ZgnyAItmn8xM87Bb8AqvNfpx/8asWqfByHLxZMDYERrvtx8obGYp9Dxn3Sf/1Mj2JZXKa1WvoIxgHs40bbSTfHEgh5+4VUOQavh/TF21/5+E54zdaQVmnoEN0ayFE/doD61gyZ8Jilr3PO2NwwedroAVx00lklVd2OZQq5kKcY/lXVVrdLtLVknc9nLgVqcwAOTuDN4khffWRWJW+gOhdGdP877jD+k/hbkAxspnKW4oeHZtX4VIbAznRlLPgiinVnkwr7pyfH/G3PfzGxkvNoi6Q1cDRg4hlGZcbw0IyeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSR4Dt0DMbjTiBcQuhyG6YL0SMSyFZpks+YxFuV0rOk=;
 b=VmIaacZp7zv2MGnEA51YQG3EUJlQraE2vXXfp8ZfAF3RdT2adumCxlYCjdpaF1GcQnuKPyWSmtu7OxgI998AP0/FOIKXHBWvCKNRE5fwAUgRzFYqK75iN2/zecFARAXlDdb+MlCaCjrjXQFuNZeAgLiSguASMhWZ6npi4xeSv66yHLIjJpp7fqhLaHg0TZd4/4LPYWnkvjc62KDva5W3Z4UzP9hU7KUWbxIKTY4X+/OobcUJ1kQSBmSIsQdabnc8KMthvRfXmER493q3zKeTcSpz0VT96a/SIsLoW81iUvdMo9yPFAGYkM84n4MO5/+rvkqWXosE2rlfk+XTe5tzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSR4Dt0DMbjTiBcQuhyG6YL0SMSyFZpks+YxFuV0rOk=;
 b=uteaJHAwR0cPQ1QBynYwoxf8IRos7uRSVqYGuS6vOkZyh2zSaoI5P3bgrRtdWq6C8nUWhKz+c7P5GLLzlYTCYlX1YrQH/WJAluuYyXb29fTD5opud8X1FwmuiKCb7aC/v18j/EzMnRpyTddIMGytcCOdpmeZQuidOY5DaQGfhQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 13:30:38 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.007; Mon, 20 Apr 2026
 13:30:38 +0000
Message-ID: <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
Date: Mon, 20 Apr 2026 21:30:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 matthew.brost@intel.com, rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, dakr@kernel.org, aliceryhl@google.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: a59f9ea2-2867-4857-9e1b-08de9ee10291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 5tlzkJ90JzCZ8BG3N3v3mDN4HetcBga9uNhvfn91CmZseCzipLGBaZ3gKH7t8DlfD3gtaOOPJnbK9jdWImP5j1CFcBln00KnF/S+J2Sd9po9Hpt5IgQTpgrJKL+vCjReyRHGKiXiLSs3QW4Sw6/HM1+mcHSMli8hACV6hf58FFrHqvTfqSHLyi87J6MJlDSTNa1/vvTDGvCIuvS+a03FbFgDhcIGxJlyd6fdN4LkfYUMX5etrkMCLLprguSJA3W7Wej8O1yIBk8rpOdUPC7478XUUN/0Fs6Y437SA55R2QFA4EwhAIvf0ajvEJAp/H+cRbG+udz98YtjbWY/I8nrAmF0SEHtFYtGAJvAq7df0hqAxIjzNexkfxBrEGE3s+M5Db97nb0YqPJOlL5uVEYS0lotoGkel0k4QghT61zqJ8ZC0JE7jWwwKSqbjRqY8uDVRufkuBHZacopjmISebmfdgrPOt8qiI6NsjeYefeSw0z48Ryj5yHTVnzmVolovCysn2QoZIAG8z3k1jJFc5Qn/UTytA16Fv+XhZXZ1o4LkUnMLUrDZYW/dIOi1q0jUuNZoV9UEgUI+lXZT/5BWZdYvwGhWadkgV3jVoWlZddE2uOzLlExpc72WsMfajbJTCEey+7IQZsQeH7xBvPILgwcuGo9F/Gowg4lj/8NMY5lJMI7jX32raAkN2C6vKaHi0gPUYGzwRl4eEG8n4VVo+pQpUchc/atPYP2hyNnMeqdNE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTFFaWE4MVdqR2xUcjRFbC85MUgvVHpmOFFjU0VuY3FkTlJKdFkwZnFab29G?=
 =?utf-8?B?N1BNalduNjFPbEppd0lraGx3RGljZXlVNmNOckx4LzBtNnBRbk5xdGpRQWZO?=
 =?utf-8?B?YVlWd0NBL3NvT0VCUGtjSmRtVjZOUVJVM0JTQWpmZXJmQnN1Sks5eUNNVkxK?=
 =?utf-8?B?U2x3SDJKdFhOdEtJYzRDR3RON2NDd3ZZWTJqNmVyRElQTjhUSG5kWlkxQTlG?=
 =?utf-8?B?Vy9KT05Wc2hwaGdhYmdkVXpONEt5NS96MmRGU1I5VHB1aUYzZTA3amlMcG1H?=
 =?utf-8?B?UjdhaDJYSFN6Q0xuZ2xDMFdJQ21Beno4dFVRRFA0cTdta2ZTYjQzaFV0VGZE?=
 =?utf-8?B?MzRjZk1EWkx4UU05Q1ZZRnB3ZG9DazlyZytUOXJUKyt0WXZBRDFnc0U3SzMr?=
 =?utf-8?B?RzV3ZmVoV1BBRkF4MEtoaStmcU95VXR3QU5pMnc2UGNQSzFrdE5LbXA0OHJi?=
 =?utf-8?B?dnhObWlWK1E2S2ZNMmRxYzFwZ0ZHTWp6UHNEck9QcWRMekwvb09XdVhvZnBp?=
 =?utf-8?B?MXF5bDl1MnB6b2RHSTJ4RW1VcERUNU8zSmRkdTNuYnVkZVVRYy84Q21tdFVC?=
 =?utf-8?B?cHpoNm1FdUFsdkovbEVPUXljejFVTllLWDJ5SXE5dmpjTnE5NG1yTnVpcXkr?=
 =?utf-8?B?dW5Ra0N6MFgrQXJiRXJYbkpEVnRTZXJJTFlTOU91QlBHWm1sUjk5aEVLTFZB?=
 =?utf-8?B?YXpKTlc4aVJoU1FuSFFBc25pSDdxbzNKcmw4d0ovL0JPTklFZ1puMkZpbVVE?=
 =?utf-8?B?ekd3dXFiSGpMSWJ4Vlk3ajBKc3Vld25tUmliRGEvWFhIMUlQQ3BuRS8vY0pu?=
 =?utf-8?B?aUV2M0docm9GbXpEb2RXcDkxNG5SbS9Dc1dVN283NnpqTTUrQUp2VGFEM1RR?=
 =?utf-8?B?RGxlVUhHMXNyaGR0dnBvTXB2VjZhdDJNRzdGSURiZGp2L3RhSE4xaUsrY1Z0?=
 =?utf-8?B?MTNtcmwrYkVLeEVXQzJCZVlhR0NZVlpzMkdMOU9MN2l2bEx3SmljdUtwUzVa?=
 =?utf-8?B?eHpoVWFySWtkMTZhcTNuQ2gwZDk2ejZVV1JZQ2pBNE8wL3lmeXBnYUFpQ05i?=
 =?utf-8?B?V0NEaFFGNUlJeEl5R2ExRFEzWTRTVVJnSWlGSUszU0VsQmNWZzd1WUVnRWIy?=
 =?utf-8?B?Y3NOUWhocndwUTNWVWpCSnY2czQ2bmtYYXhJeWZ2akxjZndSc1hBdWR5K0Fj?=
 =?utf-8?B?RmJpbmVUbStpbzdyNjIySlVlS2NzNXJXbVB4cjM0WGc1RzFXS3RtTFg1bEpT?=
 =?utf-8?B?UTkxSFp6dmdlSmRRRzdibElBbzBDRjladDBWcUoxRWUrdmNCMlFabVNBZSs5?=
 =?utf-8?B?UXpKUXV0bHp3YlZwblBUVng3ejZIK05Pa2RCTVFJcm02a081MXRPWXdROUhk?=
 =?utf-8?B?a05od2N6VFJNNGxoU2pnRlgwdjMyQmFIR253aFlCNGJHb242Y3BqNERoWWs4?=
 =?utf-8?B?YnR0UFRIV2gydzhOaHQ4SkpWYktRc1FMcldFYy9DVUl3dngyenRxUkhWOTFz?=
 =?utf-8?B?QkltZTVtblZ2VEgxRXN3VEVlZDlIWXdsdE5pOFc3U2lnaVczQTBBZjdkTmxm?=
 =?utf-8?B?SFNlVzUxaXFVc2VwM0lnNDRKcG5qUmhyZTJ1a2FwNTVlVCtMSEJlK2libnFo?=
 =?utf-8?B?czJrdDRDSXA3UmtiS0t4VXNuS3dWZ1JzUU1ET3hjaE9FOFZValI0enVKdHk3?=
 =?utf-8?B?NnowTjRkZjh6T0g5eEtURFhpdGtZZXNrcVNVR1hZUVJRb2hTTHFKWkZaYlV6?=
 =?utf-8?B?OE1zWU1VWnZRM1YyR3JjQ3lJc0I3RWw2RzFqbW1WbUR5emN2aldzdzhIWnV4?=
 =?utf-8?B?ei8xVFhUOGNzOS9TVEpQRjk3U1NoUldqaHZnUnBLTUZQRFNHZDIwN0JoS2hy?=
 =?utf-8?B?aFZxdCtBNmxweklUOGpPTVJORzVrazhxUGFveXJCaHhmMGYvaHc5RDB1aFRi?=
 =?utf-8?B?eVN2VEpjN0xJa2h3OXlSdTMrMGtEMGtzcjEyeS9PWFVQUHBMODNpK2Z1Rkw5?=
 =?utf-8?B?d3FFTHBkS3JCMDlJOG1xSXlBSTJRSEppbi9TYWVoZ1Bta21DYXBSMGw2SFMr?=
 =?utf-8?B?RUlxN1dxWWRPRzhkNEpKWThQWHF6OU5vc1daZ1NHcE9EbndPOUEyY2c5OUtX?=
 =?utf-8?B?Zmg4NDdZQ0FIZStvTk5JNzI1K1NYN25GQUJJYUozUjhNZmJMMDVXMGduNUJ1?=
 =?utf-8?B?OWs2YlMyeDNzbXRScDFzbDBtVE5LS3QyYTExT0ZYVVh4VllwNS9ETG5ya2Ux?=
 =?utf-8?B?TEs0Yy9rdkhYUWpZeVVzdXRlUm85bmI5cFdIVVNyZEN3N0F1OWJROGpUVURC?=
 =?utf-8?Q?+mlZizd8QMwMkoHNai?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59f9ea2-2867-4857-9e1b-08de9ee10291
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:30:38.3625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VP5WJKt/OglnyPxAwhHBB0jouzHh3YO0ut4aoS9yRyGN/aEDshsIZDx29NjnIQjk7+GdGGZqBckEecRigLH/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
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



On 4/20/2026 8:15 PM, Christian König wrote:
> 
> 
> On 4/20/26 14:07, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add amdgpu drm SVM API definitions built on the
>> DRM GPUSVM framework.
>>
>> This includes:
>> - DRM_AMDGPU_GEM_SVM ioctl
>> - AMDGPU_SVM_FLAG_* flags
>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>> - AMDGPU_SVM_ATTR_* attribute types
>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 406a42be4..bed71ed9b 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -58,6 +58,7 @@ extern "C" {
>>   #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>>   #define DRM_AMDGPU_USERQ_WAIT		0x18
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>> +#define DRM_AMDGPU_GEM_SVM		0x1a
>>   
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -79,6 +80,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>> +#define DRM_IOCTL_AMDGPU_GEM_SVM	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>   
>>   /**
>>    * DOC: memory domains
>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>   	__u64 matrix[12];
>>   };
>>   
>> +#define AMDGPU_SVM_FLAG_HOST_ACCESS		0x00000001
>> +#define AMDGPU_SVM_FLAG_COHERENT		0x00000002
>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL		0x00000004
>> +#define AMDGPU_SVM_FLAG_GPU_RO			0x00000008
>> +#define AMDGPU_SVM_FLAG_GPU_EXEC		0x00000010
>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY		0x00000020
>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED	0x00000040
>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT		0x00000080
>> +
>> +#define AMDGPU_SVM_OP_SET_ATTR		0
>> +#define AMDGPU_SVM_OP_GET_ATTR		1
>> +
>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC		0
>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC		1
> 
> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
> 
>> +#define AMDGPU_SVM_ATTR_ACCESS			2
>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE		3
>> +#define AMDGPU_SVM_ATTR_NO_ACCESS		4
> 
> Why are those separate attributes? What is the difference between those?

Really thanks for the comments, I have some content mistaken in V2, so I 
updated the V3 to fix that. For the header they are same. for other 
content please review the V3, sorry about that. And will fix the concern 
you raised in next version.

So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS 
are clear, GPU can access it or not, and the SVM can set the preferred 
location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can 
be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
it can not migrate, GPU only can access it in the initial place.

> 
>> +#define AMDGPU_SVM_ATTR_SET_FLAGS		5
>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS		6
> 
> Why is that separated into set and clear flags?

This method inherits from KFD and is also designed to be compatible with 
upper layer applications such as ROCR.


> 
>> +#define AMDGPU_SVM_ATTR_GRANULARITY		7
>> +
>> +#define AMDGPU_SVM_LOCATION_SYSMEM		0
>> +#define AMDGPU_SVM_LOCATION_UNDEFINED		0xffffffff
> 
> No location for device local memory?

Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd 
for device local memory.

> 
>> +
>> +struct drm_amdgpu_svm_attribute {
>> +	__u32 type;
>> +	__u32 value;
>> +};
>> +
>> +struct drm_amdgpu_gem_svm {
>> +	__u64 start_addr;
>> +	__u64 size;
>> +	__u32 operation;
>> +	__u32 nattr;
>> +	__u64 attrs_ptr;
>> +};
> 
> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
> 
> And we usually use unions in this header to separate the input from the output parameters.

Got it will add documentation for it and will use unions in next 
version. Really thanks for the comments.

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>> +
>>   #if defined(__cplusplus)
>>   }
>>   #endif
> 

