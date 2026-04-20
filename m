Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B800BF588E5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9131610E6AB;
	Mon, 20 Apr 2026 15:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lOfBrK4j";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1E510E38F;
 Mon, 20 Apr 2026 15:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9Q3wzQihS5d+rYu1sgPv4Lw5/ZoPr3bsj2LAvLrPMGAdnV9dxBjZvsl/iNThpSczyhG/PnupVjzVISoXyfJeARxEl9LR9B4pDzejS4hVe3COYgQDgVfUUzBIG2FPIO8Q+W4cx7JfjZjdZnXgOJsu9W7e3kpYIdSw/E9YloCn0T3SLgVmvFhzk3uMgn/mRSQ7yo0ZZK7U7NVii5bdDGOSbJx9evnF/BALJKpUsgGe4rtPN4h7U61w2aIgR3qowyjFpF9+lWP5c4sCE9bYnkK0TKsoE3tOyRskhPOCnCS9nsIs0zhogf9updlxVDOp8AWMBnwX8SoZrcO4Z90/QEw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRwagvkUfE6VuRm1N3gAtkGZjvdLXZqXtPG36YtfVys=;
 b=BTERwYwmSmKbpP8Rim1hGMl+cIWZtmXbxhcNxj15itB7vzG9tpV62r6/9OFOpRrDPMtQGU64PPcxJ42uIa5mGp8Xh9DjK/NzAHDyFe/mevE8Ap+tZ47LTzHQuLxTNUYD/d1POw96pgFmHLH7pMzUUMnnPWWv+bPQdPVLgwRSzR5PmlvFnTRx4oTtQNMaIHyRGheKAYUMKIfdPX2PxCZZz7nnHEKW9TM3TVF2BQr746l+6cNubkFu3/km8bXiLXl1kA74zyqPwYgo1fIE8R7yb9/3LxMP7dUVefyXUXqe5Uj0emUxZ3BHkIG0ZWuG/E0TU3KJVHRoijn9mxtyddPzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRwagvkUfE6VuRm1N3gAtkGZjvdLXZqXtPG36YtfVys=;
 b=lOfBrK4jm+NMj2vUF+/wXhUIklEAM0Vcv/+VpHb3KyULKNi8uhDZC1QPa6P4pEkuVOzDV+TEDyRLW6mJ9z2FeZu6SlLjirfzQRLjItZo69xCgYkb+zCoFtSq/HFras/Z4YCTTdRgVAluW4KeHSHmHRx9OVqmYoSxfXAaNJ9Tv0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 15:37:49 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 15:37:49 +0000
Message-ID: <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
Date: Mon, 20 Apr 2026 17:37:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: "Huang, Honglei1" <honghuan@amd.com>
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 matthew.brost@intel.com, rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, dakr@kernel.org, aliceryhl@google.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:32b::17) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b66af26-d6f7-466b-5139-08de9ef2c6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: qFJP/bjh5xqLctuMhVqyqLkxb/tsZh5cMrN4P35mu2wyoMXgcb+WGX5fRChvECjXLc6bljdobML+gd5MsO+GufKRl9P6zH+hnlM9HBlPoOolBPoqWmq3jvAvscoXUbprxLhrvUrJ+UZj+5Q7lWVWxWpwdmElJNxRZO7OnlhpgkL14nCuagl9ctH9oRopybvX5ZQOT6eMitzMrSHdcSJG9lWNu3QzwqFW28SbU7KssXQauKypyhpZjqpBbh8gRlhG/s4kt2lTqdxiAVYSXowXPUHxecvGEqqfDpk5zS6KGVSVvXr0aNtS7I1ZW0ZM+ihFX9RAQ44RC/KZZVKziFHugVTXq5bxsUbVUjP+K52tk3vM2h5hBqn1ohlvDs2kpfK0XgMtiBvs+3g1oQUcHQ5s2ofCBK/IjkW/vySl8eXd6BTtEWSsXI+kqvCS2CVG8y3gT0lsMyJRjDPh2Y8irni/RQLz/OfLWjRRYR9HY0SZrqPr7r4/NoYaBzUPz9lp6pAvHwbj+/9B89gvUwsxfJGKj0cHa9YII7E98v0MjwAlTPzDLS8bizYWB3vorzaFCRANuwtncjRNIgYo7I6KsDsqXVTCsnIUVvtcpB5BoAn10UQi8Fni+dDj3JNm78dCPji+sj5KFYEqKFbmVZYKjVlUIDwVjHw5yCViqTceGtPK6qjetsMUBzN4F4q4HjRZXQzGZxLtGIcepVWvnYJcQa/6rwhdppAo/CVnYGcROzfYWy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZMMzB3ZjhZYjBHTGZqdmdOWmNBTExHUUJ2MGFPeFY4dmI2TEZwWXllTk9T?=
 =?utf-8?B?RWFJL0hBclQ2R21CYVFNNHhRTU9lYVFDMk5IUGFVWjc0MXpObkZvYjN6d3Q0?=
 =?utf-8?B?NUZvTnZEa0ZzWEs2UDZ0Z1dGVmFDdGYvZlE0RXN6UEFZMjRITG5IeEczd0Yv?=
 =?utf-8?B?T0xyNHN0Nk5JdEJRRG5VMG1Oc01VZXNyTTJveUMrNUM1TnEvYXpwc1Y2cVVT?=
 =?utf-8?B?Y1FTc2hTb2FmR0QvVVJzU0Rad3ZmTEpTdFBZZ2NIRkltY2RHQjZTaU9GTGg4?=
 =?utf-8?B?YmxNRVdKT2l1WEUvL2Fhc2pIVlk3WVVnS2dVbFRDdnNmNVE2WFk0YWRjRm85?=
 =?utf-8?B?d3BtTy9Yb0IyeVQvT0Z1MHFMQjFqV29UYWJxRTVqdWVwSUpJU0ZXM21lVGoy?=
 =?utf-8?B?SFZJajRjLzFuNGoyeW1BMDkvUE1Yb0dNSVdobmdPN0FUekdzRU1zYWpRUXZ0?=
 =?utf-8?B?RG8xdVVuNDI3TUlzbFVueHF4OWQzaUVNczNCZXI2Z211K3lCZ3VQeGNJaVJ2?=
 =?utf-8?B?Vy9xQ0ZWRVkvYlN1dHhIa1ZaRmZMT2dIaUI3ZlZQM3NpbU1rV0xTVDljTkVw?=
 =?utf-8?B?eEl4TVR2NTJUSHZGa0dyODBkWlUrcVEvTzdMTTdLN2VMMFAzY0pJVnRQQVZr?=
 =?utf-8?B?WVZoQ2ZwWncrRE5aR2JYMGplRnMxTlRrWDdXTW1lMzRRNno5QUQ5SStSVldD?=
 =?utf-8?B?MTVKZitheVRrMFJWRlFFMktHbEtOTmhiTC9tNWJmWVdVazU2R1BpT1F5N0g5?=
 =?utf-8?B?RWI2cmFUbHlHMkJBd0pQUTNwUGlDUS8ycUQwbnI5YUFXLy95S0l0enlPS0lC?=
 =?utf-8?B?Y2tzTjUzQUVLaFAwUDU2djBzcUp6ZWtQLzVIYTVsL2gvSG9QaERKQk1HVVZL?=
 =?utf-8?B?cksrcmpjV3J3L2JFNEtYUkVmb01JSlNDSmFJdExQSndaWTA3Y01iT09SaHRu?=
 =?utf-8?B?aDU1YnRCZElsU0QwV1JIeWt5RnF5RExneGcreXp4UGxUTVo3Q3BOOE1iMzM4?=
 =?utf-8?B?UXpOeWx4V0VkNEQ1WCtwRStieDk1Snp0NDhlNHZtS1hSREw1ZGpPcXV6eHl5?=
 =?utf-8?B?Sm5pNmJWbnYyb29iMHZUeHZnRWdobzFvTFY4TUh3WGZMOEdQR2dsRlYzZVhG?=
 =?utf-8?B?dmlmSHBOTiszY2RaVFpSSkxkd3I1MkhSSTIyWkhRaFY0cFRHUUREbXhVdHRV?=
 =?utf-8?B?Vnd4TkVIVTNnM1puSnQzU0Zsa2lwZjY5RUQwdzl2b2J1UjZ0UE9SVDdqdmlF?=
 =?utf-8?B?L290MlZlUEZOcURWa0IrNSt0RG85Tm10Rkg2aHQ0TERGUXc2NGRES1VmRFZy?=
 =?utf-8?B?ckRsZjNHM3dJUk5PNEtMaUtyWTEzY2llaDEyTXc5QUw2T0orZkxJcHdjd0Ro?=
 =?utf-8?B?L0pyNzN4bHhkSjRGT21QbEczVW85RVAxMUMzRUdjTSt6eFRMNmt6RmpJdm0y?=
 =?utf-8?B?Z1dNUU0zeGdlUXNNeHUrZXpRZWJ5cTd2OEdZVkUyTGhiWG52bk4ra0RiK2Iz?=
 =?utf-8?B?eldZWHR1WTVTcDBoZGRSbmJ4WXpDbEtiSDNQeTc2WnJPeWtrcFBIbGQwYW1m?=
 =?utf-8?B?QW5uSlh6SGRMczBLL3NvaVNXSiswUzBIOFRGRy9HMW5HcndhWDBlSVFOcDNz?=
 =?utf-8?B?UGxXTEFUWGZReVMvellnanVYbDlLM2FBVGowUWRyWWk0NzZtdTBPSEVJcHI1?=
 =?utf-8?B?dW1VK2dkL0FJVisxcjUwOHdlQVJFTFN4TlZHandTUG5ESGFOdFUxaDhERXlZ?=
 =?utf-8?B?VVBkL3BFbjZIODdySjBUWDFUQVBFRFlkaDhaVlNHSGhCMUZLUHJ0SGNtY2g1?=
 =?utf-8?B?SW4wdWxFU3RvUzVJSFU2TUw0TEZUK1dmOVg2eGZEWEh6M3gyd2d3eHpCSElO?=
 =?utf-8?B?NFNjZ2kyaEZpaWxpVWI5QWlLTlFyV1U5UUNVNElnNm9ZVk9WSFdoSzBOeWNB?=
 =?utf-8?B?cmYvWmd6WGVObHNJVmZhMkYzSytZUkRiL3Vzb1VLck1kSzRhR2htMVN1VHds?=
 =?utf-8?B?UnNCVTQ5d2I0eHdtUnVxUGJrZGFKeS9lTEpSRkMwSmF1TkN5c01va1UxYkVB?=
 =?utf-8?B?L1c5d290OVloU1ZwK3lTUklmVTdnaDZUWDVHSVZCb1Erc0VmL3orNk9lZEJN?=
 =?utf-8?B?WUVjYkd5ZlFBSFJiUUxIOU4wY01GTGUrQmJhN3V1akpyT1UrQ0tkUXorQVcx?=
 =?utf-8?B?VHAySklJcWpqSkNmTVRWeThkeHl2T2hRcW8xWWxXN1VPQ3Q0aGl4dmxWMlR4?=
 =?utf-8?B?N0hlYnplNkhFeTBOS3NxSHRFL1NjV2xqZTdLRTBsOHowNEtaeGdibGhHYVll?=
 =?utf-8?Q?kS8Q8Ia8RU5TqSBBmJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b66af26-d6f7-466b-5139-08de9ef2c6db
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 15:37:49.1122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08icVh4c/17E93CZIn4zeNNONDjzNceERrdtxl4a3AZn+O1IfFdY90YS6Ns3CqZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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

On 4/20/26 15:30, Huang, Honglei1 wrote:
> On 4/20/2026 8:15 PM, Christian König wrote:
>>
>>
>> On 4/20/26 14:07, Honglei Huang wrote:
>>> From: Honglei Huang <honghuan@amd.com>
>>>
>>> Add amdgpu drm SVM API definitions built on the
>>> DRM GPUSVM framework.
>>>
>>> This includes:
>>> - DRM_AMDGPU_GEM_SVM ioctl
>>> - AMDGPU_SVM_FLAG_* flags
>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>> - AMDGPU_SVM_ATTR_* attribute types
>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>
>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>> ---
>>>   include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 39 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>> index 406a42be4..bed71ed9b 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -58,6 +58,7 @@ extern "C" {
>>>   #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>   #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>> @@ -79,6 +80,7 @@ extern "C" {
>>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>     /**
>>>    * DOC: memory domains
>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>       __u64 matrix[12];
>>>   };
>>>   +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
>>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
>>> +
>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>> +
>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>
>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>>
>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>
>> Why are those separate attributes? What is the difference between those?
> 
> Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
> 
> So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
> it can not migrate, GPU only can access it in the initial place.

Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.

It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.

>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>
>> Why is that separated into set and clear flags?
> 
> This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.

That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.

As far as I can see just a SET_FLAGS should be sufficient.

>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>> +
>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
>>
>> No location for device local memory?
> 
> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.

Absolute clear NAK for that approach. This interface is per FD!

We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.

We also need to make sure that setting attributes for different devices doesn't affect each other.

Regards,
Christian.

> 
>>
>>> +
>>> +struct drm_amdgpu_svm_attribute {
>>> +    __u32 type;
>>> +    __u32 value;
>>> +};
>>> +
>>> +struct drm_amdgpu_gem_svm {
>>> +    __u64 start_addr;
>>> +    __u64 size;
>>> +    __u32 operation;
>>> +    __u32 nattr;
>>> +    __u64 attrs_ptr;
>>> +};
>>
>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>>
>> And we usually use unions in this header to separate the input from the output parameters.
> 
> Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
> 
> Regards,
> Honglei
> 
>>
>> Regards,
>> Christian.
>>
>>> +
>>>   #if defined(__cplusplus)
>>>   }
>>>   #endif
>>
> 

