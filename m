Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B5606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0vKqDI1Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C8110E17B;
	Mon, 23 Nov 2026 06:45:41 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4294010E17B;
 Mon, 23 Nov 2026 06:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXE9XKNX7xRUAvUj+gSRMj/6IzGkxRSKdNmOWNFoZ/x73EDIrmPWaPyCHlOtaxNHlBntFn64d5LPnmCa7t5lvsQufz3R+NAfKMYlo9A00zWMZw/XOhhZ8AAp4Mkl+fByooneEiABShmVjZ1sfZWbyy2aKJdxasT2FEqq61nyB19lGmI4oR6z8ChTMwvQFSiRqfZroBvLc52qddGHIVdWM2wZ+KZNmP6rG12HpiDLAEw/7X8iA0QSeRYWAr+XXRrMRYn255lPb1aXYRcnS1GhQJFQNV1MEbTM+h3/bqgQUV++v2maXJbbM8PEnko9ar7aPHb/8jpBLvXM25/YFVe3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVJC4ZSxaiDrEMIn5STNkFvDrygOikaL+fZ5MgaZFKQ=;
 b=uBKP9PT2wRMWGjZbrLiGIJiY02kQrVUcfyQoNQKAVQgoXH9pZLc/JGfqhYmJI/eIIsME+5cQQa5LJueind2XG4Vf5V6L5OqsyIgJF1zJnQ7fBxhHX+WULKYD7T6Ox6lMVXsNgNYbocCUZ00mEKFLrI6VeAuc0qTX8dQIUEhGee++r1/mToniPWtMDga218h4EyGeelBnNAuIrgnaSni9AhGTMPszcas5iVQ6KRtmwFJynQJjqFTp1EpHwAnas1cW/sntsZ0+WzjZExtb3/bsPCT+IOJrmTHKXEvNdZj/3yzJ7D4yYnsp+worx5FYr4vY6K+qVtB5cCE/mUaOuQo4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVJC4ZSxaiDrEMIn5STNkFvDrygOikaL+fZ5MgaZFKQ=;
 b=0vKqDI1Qh7AvkFPaoUg4nQkGBez36Y2ufkvXibK8YTEB386atnHJCN9bDl8h7LobGs+dFiWT0H5Q1cNRLQQesu3uh63vpia7UjS7kVn69OeAu0odeAWmSxEVE1Oh1oelVOmM2M6IZXvgCMSbH0FLXn/xhavR/6tjS+DQoNkfjtE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 06:45:30 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 06:45:25 +0000
Message-ID: <1c8f5979-e8ac-4819-9f1e-702188b0448f@amd.com>
Date: Mon, 23 Nov 2026 14:45:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/22] drm/amdgpu: add SVM core header and VM
 integration
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-3-ray.huang@amd.com>
 <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
 <101922f3-d918-4429-a7c8-c96f72474993@amd.com>
 <1bf6fd84-9ea5-49fd-b906-7b2c9692c018@amd.com>
 <61bec126-d855-4b14-a8bf-80cfdcea66fd@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <61bec126-d855-4b14-a8bf-80cfdcea66fd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: f240fd9d-65a0-4214-767e-08df492d5a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|4143699003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: D9DATIg49xAqv3m+/W488KEKm27a/MMeX7cQ0e13SiGBirdUnth96bltA5GGYK/3z08eOMoc3HnpINMU7WmvZEffX9KUD+MYC2k6K3XXySobLZd8BILA4n2RBx9UTlAN2/hX4DLNOSn/Wa2BLEy6b0UvxWpXfjXoBX5qhlsbuuTscFTqF0RbE0t07sPFY749sWjyAoTCM1961jv6MFWNDsZGFGnp7CfhyeoNtmQkuDXTVkMlmQu0MOSfh+sKaeIWfzEdO0S5a2GWdwM3UN9rGsb3vB1BgBnKjJjKvIEuqYtDhHsTF0pxp6Ea6OeoEuHRGg5abZPIv+j5Adn+hU7Ae0F6NbP7sDXxJRGWM8eB5LwTB1vBlRVflJXCEXnclii30tKQsi1q3I8YjrMs303TAZQ5YzHfpswvL9giTz6/RRSdGe+b84CFOb13hM2tICEOJzUeISD3OfNEQ5oX2qR3K0HJmwJiXpwpqINTGR+2tXLbpI1jHxZlj2OMmzaAyOVCEWy9l6xtXeppGhmd7Qudm1SPB7c9zCRlL/jHRHi2UAhyNjksYqiCaXkJBmxJGxGLZcuSCSOpq0HAeZAsy4Cxo9oZrF7V4GEh7b2FrrsNG7dKIRzL4veHJjD5UYqo2rKPEjacIcOcqd3qSb7+7ZuD75Rm0G85rnccUSW8e1BGuIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3BUbjU2UFJyV010SW02Ui9aZnJHajBZSmdyUG4yRXZtZG9IWUNJNU5zSllY?=
 =?utf-8?B?MmRzbmcwdzFrM1AzcHl1akROc3B0MStJTVB5U3pzKy8yYjR6cldnTVVnbmFZ?=
 =?utf-8?B?OXJmUllXaWZ0MDluYkFSbkg5RTVwU0NhcFNMZjFpSjNTWDBGTzVYeHhZMlAr?=
 =?utf-8?B?a1YyZUt6QitqZ2EvZjFPS1hOY2pSTTQvY3FJeE9STThETGVSUGlCdCtCcmw0?=
 =?utf-8?B?bjBtandOYk1UL1NJY3FUaEM0MUFWNEZ5OGs3Sk9OaWY3U2VmREZyVkFnZzVt?=
 =?utf-8?B?STgvSlR4ZWJEaExYRmJUNnorUStiVlBBU2ZUUW56N1Y0ZDV1Q1RuaGxjZzBu?=
 =?utf-8?B?ZXpNbGlXRUtId0YrSVN1TENLcFYxSXdCUGdDU28zNllLOEhMV1l1T2IzbDh0?=
 =?utf-8?B?cWlKRzF4bm9rVlVjYUNVVVFaUTlFQWpXcDNjRDZEQ3QzUEpZY3RxNXV3ZjFP?=
 =?utf-8?B?dEtpOHZQQy91TitTelp6cVl6QW1sMkNIZUFDaVBsRzhlR0RvZXpwZitNbDZL?=
 =?utf-8?B?Mk81MWNyc3U3K3NUNnFtT2hKQzJodlA5VitWTDBud2lkeDFsWHE1WjFzczM1?=
 =?utf-8?B?YnY5WXVoWFdIWFMrMGZDOS9sUkFNenFQZGVYR3A2THhXdS9Xa3hlNzNjTU15?=
 =?utf-8?B?ejRaR21LUkNEVHZ4MzRzZVlaQ2pWNGRFR0J5OGRENTUzdG13c1pKSm9UeFlr?=
 =?utf-8?B?SUdhcVpZZGFjN1lPRG5IRzZIVEx6OEJyUktFaUV4cGk5czR3MGM5elNzQThh?=
 =?utf-8?B?OWNnRENqbUo1MVp2ZjE5Z1BjN0FPQWtRb0ZuTVIwSnNTRTJQaUJGOHpQenY4?=
 =?utf-8?B?bFBDeDZnV3M5SjcyRDJYTW9oWDVvK2hFTEYzb3F5WEg2Y08ySTNZZ2RuVHg0?=
 =?utf-8?B?STYwL1dkV3pnR1BHZlVGTU5hRDB6QlhqT21NVVdEQkVjVHhFMFNYbkluYTYw?=
 =?utf-8?B?SFRLS3FIUXprZVhsYVpnSlBlY2J1NUt5Q3JvNG1sYU9JYXpJZ3lBcnloU1J3?=
 =?utf-8?B?OExlYlBtcG9VRnNRU2FMM2JRSGFjMFlmSHdlVHpUSk9RdWM2dktRL2pvNEZB?=
 =?utf-8?B?UDd4VnlHb1NTNms5OVRFT2IvMGczZmxDMmxqZDNiUE1jRVZxL2pZdmV1RWxM?=
 =?utf-8?B?a2lJN1NTQ3UrdUMyMVNEeUYzYk9wdmV3TjRrZ3NEeE9TcnZrSUJTVi81cDRl?=
 =?utf-8?B?ZndZdjB3Wm9ZTXYxbEhBL3A0STZzZ2NROEVkcDl4eXpuVS9GQnQ3cVFkbGUz?=
 =?utf-8?B?UFF6RFJ1dk1NWWNlaHZjSFJSSFlmL1NFbXE2enk5QXZpREFVdEFqYitqTkpm?=
 =?utf-8?B?dUxidGhETnQwR3N0b3ZIeEVOUHBrbmR0TXBpbUpVeDV3Ym5nM01xcTNSTWFF?=
 =?utf-8?B?a01xQ0thWW9iVFJwSjl4SlVEdXdrd1YzazJORldFSzVVYm5JVHl0aVpmTEtZ?=
 =?utf-8?B?QW5aYWtqeitJaS9ZWkxQemJqUDJ6U1U4Yll3SlZxamM1bWViZkljcStUKzVl?=
 =?utf-8?B?ZENIaGVISXljY3lmNlIyN1FMNUNHaHg4TkJhVGRUSHNLcFpXcXhxTHY3dU5j?=
 =?utf-8?B?OFo0RjYxZUlUZ1ovRnh1SFd4c0Q2M0tNY3k5dm1hcUZmTFNIT1Zvdm9mblJo?=
 =?utf-8?B?dGZCS0YwY1k4cGg0NWo3cThsYkxWa2lKN3RFcVozMUJsNGlkdDR5dGVyWC9T?=
 =?utf-8?B?SngzZW13RlpOZnR4REJKRHNDNUtyUjZrcE5kSzQ2dFdVUFN0VTlHZDZJbnlK?=
 =?utf-8?B?NDNOejNJeFZZVnNZRVpqZ0NGdzIxMUlEWjlIZk5lUHVNdkJMOXk0RWtRbWwy?=
 =?utf-8?B?c3h1RVlSeWw0ZFJLQ3d1YmFORkxlSXhla09ncit3RWg1KzVLY285NlpCNFZZ?=
 =?utf-8?B?Qm0waGZrOG5hTlBLLzBMSXBOczV1QlBaU2p3aSs1SFhQZmtYSTNHS2ZIVUtH?=
 =?utf-8?B?d0NvY3NBVkt5L3ZaaE83Nk1HNGFndjV1R2xjUWVoSS8rNkJ2dEhveGIxdUtu?=
 =?utf-8?B?eXUxNWVMb3poR0FOMzZiT0wxVGxGbWN3Mkx0bm9PNEJGZWY4T05BNVRiaUtF?=
 =?utf-8?B?NEk0MU5KZVhRenl1MWVrSm9rN1BLYkM1VHYyclZmV0xoajI4WFJCc0VGREx1?=
 =?utf-8?B?ZnRPazdLRWFIdEpNZGIrK3pCYVBKdHpjSWtwczRVZUFSSUIzN3B4RzRLOSsx?=
 =?utf-8?B?RGVNekVRTFk1c2JLUlF0ZjEyY25xeHJNbzFWd3hxY1VMblM0UTYyR1Riem5i?=
 =?utf-8?B?RVJweVY3bVRoNWdyaWN1aGo2M0VieHRXeXhJTmpES3hrUHZaVmpJWXZpS3VZ?=
 =?utf-8?Q?qN109fKh+LwNgRvX1/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f240fd9d-65a0-4214-767e-08df492d5a28
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 06:45:24.9069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Et6NA9A29oUzhHaVKNPfz8PxankBM8YPZfx5l+r1TWxHwK90EZCpLjvnP0WXR/t3EQhA5u3XsP8kGU4Q96ZxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/21/2026 7:31 AM, Kuehling, Felix wrote:
> 
> On 2026-11-16 00:18, Honglei Huang wrote:
>> On 11/10/2026 10:46 PM, Kuehling, Felix wrote:
>>
>> ...
>>
>> >>> + * @checkpoint_ts: IH ring timestamp captured on unmap, used to drop
>> >>> stale
>> >>> + *                 faults.
>> >>> + * @default_granularity: Default range granularity.
>> >>> + * @xnack_enabled: Whether retry (XNACK) faults are enabled.
>> >>> + * @invalidate_ranges: Callback of the MMU notifier invalidate 
>> event.
>> >>> + */
>> >>> +struct amdgpu_svm {
>> >>> +    struct drm_gpusvm gpusvm;
>> >>> +    struct kref refcount;
>> >>> +    struct amdgpu_device *adev;
>> >>> +    struct amdgpu_vm *vm;
>> >>> +    struct amdgpu_svm_attr_tree *attr_tree;
>> >>> +    struct rw_semaphore svm_lock;
>> >>> +    spinlock_t work_lock;
>> >>> +    struct amdgpu_svm_gc gc;
>> >>> +    atomic_t exiting;
>> >>> +    uint64_t checkpoint_ts;
>> >> By now we have figured out that TS in faults are not useable for fault
>> >> handling.
>> >>
>> >> Background is that they reset from time to time because of GFXOFF and
>> >> may vary depending on the engine who sends the fault.
>> >>
>> >> Adding Timur from Valve on CC, he send out a patch to completely
>> >> remove the existing timestamp handling from the fault filter.
>> >>
>> >> We need to come up with a different approach here.
>> >
>> > At least for the fault filter that shouldn't be a big problem. We don't
>> > need the SW fault filter on any GPU that has a CAM. That should be any
>> > GPU that supports retry faults starting with Vega20. AFAIK the only 
>> GPUs
>> > that still need the SW fault filter are Vega10 and Raven. If the
>> > timestamps work on those, we're fine. If there are any newer GPUs left
>> > that don't enable the CAM for whatever reason, let's fix that instead.
>> >
>> > Regards,
>> >    Felix
>>
>> Hi Christian and Felix,
>>
>> I totally remoed the ts check in amdgpu drm svm fault, following is 
>> diff, is that looks valid for you?
>>
>> diff:
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/ 
>> gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
>> index d95ac3651..15d8da7ea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
>> @@ -31,7 +31,6 @@
>>  #include "amdgpu.h"
>>  #include "amdgpu_vm.h"
>>  #include "amdgpu_gmc.h"
>> -#include "amdgpu_ih.h"
>>  #include "amdgpu_trace.h"
>>
>>  #include <drm/drm_exec.h>
>> @@ -358,18 +357,16 @@ static int fault_map_range(struct amdgpu_svm *svm,
>>   * @adev: The amdgpu device.
>>   * @pasid: PASID of the faulting context.
>>   * @fault_page: Faulting page index.
>> - * @ts: IH ring timestamp of the fault.
>>   * @write_fault: True if the fault was caused by a write.
>>   *
>>   * Entry point from the VM fault path. Look up the SVM context, drop the
>> - * fault if the context is gone/exiting or the mm is dying, filter stale
>> - * retry faults using the checkpoint timestamp, then resolve the 
>> covering
>> + * fault if the context is gone/exiting or the mm is dying, then 
>> resolve the covering
>>   * attribute range (creating a default one if needed) and map it.
>>   *
>>   * Return: 0 on success or a dropped fault, negative error code on 
>> failure.
>>   */
>>  int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>> -                uint64_t fault_page, uint64_t ts,
>> +                uint64_t fault_page,
>>                  bool write_fault)
>>  {
>>      struct amdgpu_svm *svm;
>> @@ -378,7 +375,6 @@ int amdgpu_svm_handle_fault(struct amdgpu_device 
>> *adev, uint32_t pasid,
>>      unsigned long attr_start_page, attr_last_page;
>>      uint64_t fault_addr = fault_page << PAGE_SHIFT;
>>      struct mm_struct *mm = NULL;
>> -    uint64_t ckpt;
>>      int ret;
>>
>>      if (amdgpu_in_reset(adev))
>> @@ -414,21 +410,6 @@ int amdgpu_svm_handle_fault(struct amdgpu_device 
>> *adev, uint32_t pasid,
>>          goto out_put;
>>      }
>>
>> -    ckpt = READ_ONCE(svm->checkpoint_ts);
>> -    if (ckpt != 0) {
>> -        if (amdgpu_ih_ts_after_or_equal(ts, ckpt)) {
>> -            pr_debug(
>> -                "draining stale retry fault, drop fault 0x%llx 
>> ts=%llu checkpoint=%llu\n",
>> -                fault_addr, ts, ckpt);
>> -            amdgpu_gmc_filter_faults_remove(
>> -                adev, fault_page, pasid);
>> -            ret = 0;
>> -            goto out_put;
>> -        } else {
>> -            WRITE_ONCE(svm->checkpoint_ts, 0);
>> -        }
>> -    }
> 
> You can't just remove this. The reason this is here is to drain stale 
> page faults for ranges that were unmapped. If you remove this, those 
> stale faults will cause correct applications to crash.
> 
> You'll need to replace this with some other method. E.g. a sequence 
> number that doesn't wrap when he IH ring wraps around.
> 

Ok got it, will use the seq number in next verison.
But it seems like if we want to use the seq, then there will be
a refactor in ts/seq record in some public paths like
the process_interrupt  or amdgpu_vm_handle_fault or someplaces else.

Do we have those base feature change? A draft or a patchseries, or they 
have been merged?

Regards,
Honglei


> Regards,
>    Felix
> 
> 
>> -
>>      amdgpu_svm_lock(svm);
>>
>>      mutex_lock(&svm->attr_tree->lock);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h b/drivers/ 
>> gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
>> index c169a9660..15c3915bd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
>> @@ -33,7 +33,7 @@ struct amdgpu_svm_attr_range;
>>  struct amdgpu_svm_attrs;
>>
>>  int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>> -                uint64_t fault_page, uint64_t ts,
>> +                uint64_t fault_page,
>>                  bool write_fault);
>>
>>  #endif /* __AMDGPU_SVM_FAULT_H__ */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/ 
>> gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>> index 627b61c7e..f552725f9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>> @@ -758,39 +758,6 @@ void amdgpu_svm_range_unqueue(struct amdgpu_svm 
>> *svm,
>>          drm_gpusvm_range_put(&range->base);
>>  }
>>
>> -/**
>> - * amdgpu_svm_capture_checkpoint_ts() - Record the IH ring write 
>> pointer time
>> - * @svm: The SVM context.
>> - *
>> - * Capture the timestamp of the most recent interrupt handler write 
>> pointer
>> - * into @svm->checkpoint_ts. Retry faults whose timestamp predates this
>> - * checkpoint are stale and are dropped by the fault handler.
>> - */
>> -void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm)
>> -{
>> -    struct amdgpu_device *adev = svm->adev;
>> -    struct amdgpu_ih_ring *ih;
>> -    uint32_t checkpoint_wptr;
>> -
>> -    if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
>> -        ih = &adev->irq.ih1;
>> -        checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> -        if (ih->rptr != checkpoint_wptr) {
>> -            WRITE_ONCE(svm->checkpoint_ts,
>> -                   amdgpu_ih_decode_iv_ts(adev, ih,
>> -                              checkpoint_wptr, -1));
>> -            return;
>> -        }
>> -    }
>> -
>> -    ih = &adev->irq.ih_soft;
>> -    checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> -    if (ih->rptr != checkpoint_wptr)
>> -        WRITE_ONCE(svm->checkpoint_ts,
>> -               amdgpu_ih_decode_iv_ts(adev, ih,
>> -                          checkpoint_wptr, -1));
>> -}
>> -
>>  /**
>>   * amdgpu_svm_range_invalidate() - MMU notifier invalidate_ranges 
>> callback
>>   * @svm: The SVM context.
>> @@ -802,8 +769,7 @@ void amdgpu_svm_capture_checkpoint_ts(struct 
>> amdgpu_svm *svm)
>>   *
>>   * Dispatch the two phase notifier handling across every range in
>>   * [@adj_start, @adj_end): run the begin phase for all ranges, then
>> - * the end phase. On an unmap event, also capture a checkpoint timestamp
>> - * so stale retry faults can be filtered.
>> + * the end phase.
>>   */
>>  void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
>>                   struct drm_gpusvm_notifier *notifier,
>> @@ -814,9 +780,6 @@ void amdgpu_svm_range_invalidate(struct amdgpu_svm 
>> *svm,
>>      struct drm_gpusvm_range *r;
>>      bool needs_flush = false;
>>
>> -    if (mmu_range->event == MMU_NOTIFY_UNMAP)
>> -        amdgpu_svm_capture_checkpoint_ts(svm);
>> -
>>      r = first;
>>      drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
>>          needs_flush |= amdgpu_svm_range_notifier_event_begin(svm, r,
>>
>> Regards,
>> Honglei
>>
>> >
>> >
>> >>
>> >>> +    u8 default_granularity;
>> >>> +    bool xnack_enabled;
>> >> It's probably ok to have that here for now, but that will become a VM
>> >> property in the future I think.
>> >>
>> >>> +    void (*invalidate_ranges)(struct amdgpu_svm *svm,
>> >>> +                  struct drm_gpusvm_notifier *notifier,
>> >>> +                  const struct mmu_notifier_range *mmu_range,
>> >>> +                  struct drm_gpusvm_range *first,
>> >>> +                  uint64_t adj_start, uint64_t adj_end);
>> >> That looks a bit questionable. Why is that a pointer inside the
>> >> amdgpu_svm structure?
>> >>
>> >> Apart from those questions that looks rather reasonable.
>> >>
>> >> Regards,
>> >> Christian.
>> ...

