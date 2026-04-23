Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FC1FAD3E3
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 06:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C289210EF55;
	Thu, 23 Apr 2026 06:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gr73+IDO";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AB210E06A;
 Thu, 23 Apr 2026 06:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqIs40TsUCNIjzcX7M4Ejn7k4MORjLMF90Se6wXQr2/SUpUF/P/N6b4oQgexI8rrNzaR8EDfjNwcknqu+9urHZSmmRTsEZCwJIrUOcyA6tEQPMwvFwb2U72pXWisiCTyG5XihxhL1iFxoLnYSE5dxz0XUm6NMzBVZXAbfCpQ7Nt8b/jFD+NNrXiuECpMhV1THlG0naVXPs7elOf/tzslD+kdDD3EddP8V3gi6pp7k993CptGIO+eC1HpKt3uQzyfF3U4RMRY96+NgBfBRBaFgslDjcdOKPzBxEjDtYMMDtg24ycl94xf+876q8Jv6wyyVes5ZMNAa4wGbBuapprMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb8PSV5BtqPKr2jjMvPI1lLPG4l9haM0Rs55C+b5q44=;
 b=ckqNJtHQzeVmmcYJbqQBQo4f0ux/Y4GkGssfJWCdYOAG9wIBsvEbKyXqZVq3MM/EnpB0B410qc/bZTRpuPq+iZbs/Il/E9iR6yXOsU1qO0oihtA51Ue9zywRhdufxP4Jn2DU+98pTUqLW4IJUnt1d0KLFsY5j/M39qDw7PdO1/SVTnbdaG1655nFp9Pbd4P1Mr0zYjLv4A3XBbcED7eWQ1k3Ihh7SioE+Pp2S2kNVXky9x96pvm2BhplX3c2Br9hqHFkk8IEjhq2d3WrZc20HYM4PzN4vU6SGTvsVeGZSVhTbITY7B8DH/QIne7R7TMaTn3OXly1Otpeg9RiY2rvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb8PSV5BtqPKr2jjMvPI1lLPG4l9haM0Rs55C+b5q44=;
 b=gr73+IDO5Cbmmubj2W+qttWLGh2Ef6PfFkMeUmHtpJIe6lnA4sfukdCllSX2efuS0k8m/TDKx8/xymABA2a4zEtCLE2x5uK+TjbZJvadnW+vsp/phkAiUYVLRomJLPSJqrfuL+eYmPQ0iVNSvRh6abKi4VzTmGkZEueWVdirF6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Thu, 23 Apr
 2026 06:22:00 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 06:21:59 +0000
Message-ID: <9e2bee93-306a-4ef0-80be-daed33c8bbb5@amd.com>
Date: Thu, 23 Apr 2026 14:21:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix.Kuehling@amd.com
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
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 121dde75-f1b9-498b-e0aa-08dea1009fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: wqwvNPAlnTM3I3qqsauq5PSr+JxCilDpY3fDBLMg6PGm+Sruuxm9IY2lU74VYqWCDEhZgiYW0kfTbEehiprQm6Gq/WdSlf1oWu8QvPSpde4RevfsRIh1hya+piDoFYuvWdCw5g8uaVfSaf+osO1TT9OQlsimakS42JXEHdamZiZafA29TUitWCJsqPF38oVHhsV+3ArvHya8FpjrEUTqWuYnJfLcf0I/a61aUm57vEOqSorCCiaR6jq/sZG09WHXNKfRfY3FLzkFr+miM+n69CxzGVYMX2VW3+6nCnETJGI3s9JhwOM1Z8r3vYnelGA4D3UCZR51SHr2LL8gdXbe3sqvFy76g60H/0Z0yVk88qYcwwZxgr0m3W7ubXVLchCx+8eVqERdA3LnduFVTXDlazy2m52fTsF71egZieSkJoSYIEPHrUAj3YHmtas5wgqi9b34quiNyB9+Lx3HSejUdniDx0f7jf3Q5cWt36PZoi9prSQmKnkiYRV2YM+uxGk8OoMECPsvse5lEZjChDil8u0v2DwdsHYLzgX6xtvMHj9oj6QKMwDC/QxuQTpqQ5QrzkfxzfCzlp+NR5jyJt5eomgUYOjRFv5yRqRxADiZ0ngXM4C/C3S6vaEOGmPPsl2bBFmq29o8HlI5BTulzPoEamrZBJGd2Xxe1eRW6/2fNI+tHFg2TPSqZyYBweVa3Rgm8fyguHB/rb/QA6WufxZ+s9YqE5MmYQWjRjeFTHikq4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDdPbWpqN1ZueVJWK0oyWjRTSFR3K1NxNDRONENaa3RQRzY2T2V6eFB0U0Yz?=
 =?utf-8?B?TlJxNDRMd1VhaWVnMk9VWENQT0F4alhLaDg0bjBDLy92dllEbExJT2pWZzh4?=
 =?utf-8?B?MGh0eGUxck43bFdTa3hmaXExUG9vNTBRdUYySVFEbm9jeTRCcFl0NURiT1E2?=
 =?utf-8?B?RHlVYUYyeFEzUk54QmFGc0cxZCszVlpLazlsOVVscFVrdXZxaWIrMEQ2VUZH?=
 =?utf-8?B?Mzh2NGV1ZWxVN01KK3NxemlGZTBDbE9YR2JxaFAwdDRMOXFUMm5IQXZTdUxr?=
 =?utf-8?B?QkFORXhOR0c4cjBNV21oNDhUTkJGQUx1QjdNUW1qK2JZcWlJd0FJVUpSSndW?=
 =?utf-8?B?K1dod2J3RXVGTTVxSHNzN3BEeDRYWVJsMFRoZWJKM2JqRzh3Ty9zNVZJM1A1?=
 =?utf-8?B?em95QmVkSkFUN1Z2dEdHenYySm85ek1JT2RhSmZoL0N0ZVZHMjVySzdiK2tQ?=
 =?utf-8?B?OEVVYlhxeDJKMlZiNG1DQXU2QzhUalpsc2RtcHlVSlNXRU9rQ3VmQ3NvRDZG?=
 =?utf-8?B?S1o3WlBDcFNmV2RhMFRmUC83K2lMelB1YXJwTjRuL1dKVWtnVGIrbDZzWXBn?=
 =?utf-8?B?ak4wakdnT1dvVHRNODJKbUZsY1FzVDV1eVczUTRBOVRCQTRaYkcvNkU0SnVE?=
 =?utf-8?B?QURrNkNGOXlHSTJvYk1CaXRHdXhmTGR1Q3BOTXpERlVtTEdEUzROWXJGZG02?=
 =?utf-8?B?NEZOZmVMZlpuYzVrVk5DWHFZRUllL3MvTXJmZ0ZCTVE5bDF0eGJ4YkVqYW5y?=
 =?utf-8?B?cXMyUE5UOWp4U1J3ZnU2TGN0ZGxJdjkrQUo1ME5UOWY3b1MxMkRQUHV4MHdI?=
 =?utf-8?B?cE9mdk1XYlEwa2x5NjlmSW4xWXRXWm1kMmVJR3NNY0NJRVZQZjRPMWZlODlN?=
 =?utf-8?B?Q21LbUc1Qm8zVFQ2M1RxWWRWY2t4Q3pCZVE5K3J0ZHBSc0tja0N1RVJSdlh4?=
 =?utf-8?B?Yk55YnpyTlArejdhMUxSQkZ4bThDbFR2TGhOWmg3MEVtQVAxREROck5lWmQ4?=
 =?utf-8?B?N3BTb0ZKTUphMWxrTkVmKytCSnZnQlhuSTY2SW50c0twUzk5SXFSOGc0aXA4?=
 =?utf-8?B?dTAzTWlWbzk3U1pobEdFTnhzcXcyVHR2NER1QktuSEZnY1dFQTdNckEzZXdO?=
 =?utf-8?B?Z3pGN2diOHFzUlRBV0ZwQUJ6ZlM5NGNtYjA5R2dmWmp4R3R4blNBNHJVNC9p?=
 =?utf-8?B?YVFhTkpKV05KYjduSVY3bzZ6UW1PbUFKY1M1ODFrVitseDY4TWdGUGlMSVJG?=
 =?utf-8?B?NHF1SFhpWVpNMTdleUU5LzA2TkozZDRpbGtvVzBqdG1QZHBFOW54eENId0dM?=
 =?utf-8?B?MmhCbVBXUTVDN3RtYXZaeUp4NG1rVEZjMmNqMDBYMFRnNmozZFhmQnVtWXVT?=
 =?utf-8?B?Um45NTRPLzVibGw1a0YvOHUyVDNMU0VVc1ZxVnhvaWNYdFNlQXZOSnFTSTlI?=
 =?utf-8?B?cGRpcWVNU3NpbHhxRUVyWFlndk1oalZnc2lPWWJ6cW42QVVMNjNaSDZVZTE0?=
 =?utf-8?B?cDAwQ21OZGU4N1F1dFpySWlIRVpIZS9pMUlReS8rSVYyNTQ0WE1lZEt4SFVt?=
 =?utf-8?B?RUpnc1MwUG83WUhWdks0MzlldHlGUWJHV1RQU1AzY0EvOWNlN1BFVm1hNU5v?=
 =?utf-8?B?YzV5eTIvakFOdjA2OHBiTVlmQlhjOEprRDJFNnJZVGtsY1lqV3JWc3BybXpN?=
 =?utf-8?B?OElnVW5sUXhkakNiV084NVhpb3pxUlUrbVpTVnpwNjhraG9pTm4xdEN4MDZG?=
 =?utf-8?B?eldFekFxZ0RyeWRZQTVBWXFDVGtMelpsOExWVWZqV3N3OUpIdXJyL2ZnTDFL?=
 =?utf-8?B?SW5kQ1M1Ry96bUtGY3JLV3ZhcEtRSFZOSTdtdzh3THJiejNKdHlRV0ZZWmYw?=
 =?utf-8?B?czBtMnJucWIrRWpYVnMxcGc4dm9tdEo0SThMQ1dBRWdtUFE0RWZNUllsYUMv?=
 =?utf-8?B?ZXJ0YXUwdUFtMEhlcEwxOUFGY1ZsY0dqZFdnYlFORkNjbTN1K2Y4ekV6SlBx?=
 =?utf-8?B?bEtnYU5BUUFnNHpONEJhZXQ1ZGxWb2NpdEo3VU4xNUhqQW11Q0hFNGV5K0hZ?=
 =?utf-8?B?K2gvc21iTnk4eWlMTXBORE9PaVZLVStHbTlIYlVUbmZ6K3NXWkxSZ0lYQW1K?=
 =?utf-8?B?Y3VwN1UzdE44aFBYYUFMYWhyYzRwUXNHemRHSkgyejREem8yWGtkbVRNeDk2?=
 =?utf-8?B?UFVRNWdxRWp0QnNjbTdScWZQb08yRTU1K2RHaFFHR0thbnl1cmFqa2doU1k1?=
 =?utf-8?B?ZXk5bVAzOFlza1hjWEQrb0lmcWtXMmRCRC8zMmtvT2RaK05KSjFzMUJ1aVNC?=
 =?utf-8?Q?o9KmyIN7918rttoUrN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121dde75-f1b9-498b-e0aa-08dea1009fc8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 06:21:58.8234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wg5ULwCkz8fB+I4Q3CPNmG7lE97dnl7tj+kQlZQ0tkUbQPvBLb7Il65A+mPvcywBVQYHOBA9SgaHW8q/ImT54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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



On 4/20/2026 11:37 PM, Christian König wrote:
> On 4/20/26 15:30, Huang, Honglei1 wrote:
>> On 4/20/2026 8:15 PM, Christian König wrote:
>>>
>>>
>>> On 4/20/26 14:07, Honglei Huang wrote:
>>>> From: Honglei Huang <honghuan@amd.com>
>>>>
>>>> Add amdgpu drm SVM API definitions built on the
>>>> DRM GPUSVM framework.
>>>>
>>>> This includes:
>>>> - DRM_AMDGPU_GEM_SVM ioctl
>>>> - AMDGPU_SVM_FLAG_* flags
>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>>> - AMDGPU_SVM_ATTR_* attribute types
>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>>
>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>> ---
>>>>    include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 39 insertions(+)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>> index 406a42be4..bed71ed9b 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>    #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>    #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>    #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>      #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>    #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>    #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>>    #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>      /**
>>>>     * DOC: memory domains
>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>        __u64 matrix[12];
>>>>    };
>>>>    +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
>>>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
>>>> +
>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>> +
>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>
>>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>>>
>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>
>>> Why are those separate attributes? What is the difference between those?
>>
>> Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
>>
>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>> it can not migrate, GPU only can access it in the initial place.
> 
> Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
> 
> It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.

Got it so can I change the UAPI to the following format?

enum amdgpu_ioctl_svm_attr_type {
     AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
     AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
     AMDGPU_IOCTL_SVM_ATTR_ACCESS,
     AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
     AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
     AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
};

enum amdgpu_ioctl_svm_location {
     AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
     AMDGPU_SVM_ACCESS_IN_PLACE = 2,
     AMDGPU_SVM_ACCESS_MIGRATE = 3,
};

> 
>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>
>>> Why is that separated into set and clear flags?
>>
>> This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
> 
> That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
> 
> As far as I can see just a SET_FLAGS should be sufficient.

Accoding to the reply form Felix, CLR_FLAGS provides a convenient method 
for deleting large-scale flags, do we need to redesign this part?


> 
>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>> +
>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
>>>
>>> No location for device local memory?
>>
>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
> 
> Absolute clear NAK for that approach. This interface is per FD!
> 
> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
> 
> We also need to make sure that setting attributes for different devices doesn't affect each other.


I Totally agreed with your thoughts, but according to the reply from 
matt, it seems like we need to consider the P2P/multi GPU situation.

So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need to 
modify the UAPI to align with xe_svm?

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>>
>>>
>>>> +
>>>> +struct drm_amdgpu_svm_attribute {
>>>> +    __u32 type;
>>>> +    __u32 value;
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_gem_svm {
>>>> +    __u64 start_addr;
>>>> +    __u64 size;
>>>> +    __u32 operation;
>>>> +    __u32 nattr;
>>>> +    __u64 attrs_ptr;
>>>> +};
>>>
>>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>>>
>>> And we usually use unions in this header to separate the input from the output parameters.
>>
>> Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
>>
>> Regards,
>> Honglei
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>> +
>>>>    #if defined(__cplusplus)
>>>>    }
>>>>    #endif
>>>
>>
> 

