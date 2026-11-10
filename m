Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E19606A321
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HR8pTqLf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D7C10F759;
	Tue, 10 Nov 2026 14:47:10 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013001.outbound.protection.outlook.com
 [40.107.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B8B10E219;
 Tue, 10 Nov 2026 14:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkKXE7J+Eg3w8tTkZCmeObGq5gXs3+DHqMWGyNtWGQaoUtuVIbUMqqOiAg5+OujxANvlVUGpEZXJjAK/oqnYF6T+OinrAbh9IWtBqThou/L8jK6GIwjlBSO5V/qsBS57NYt04RBjrvykiwby5FmREqtWTgM22DAEOmwExvaK4unYgQcRRCouuBzcLvjPpWaTF4WpCWmaJ67EQTyNyzfalADjglz8zehj73KUcmsfBiwtX/qvq9eOVwCnQYMjs+ZNArTwgdNVjRifSd9mQJWcuJ6lzG25CFP7hihwo0dbK6VEsVR6wmEnFTGBT5k+bME5HJr8U7F6WEY6Mr5s7RdkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1L2b588dvnDsGZYZRysyR4XN80z7wzeHrPhT8yX6FE=;
 b=tBmoabAi9kgh9srFr1u611pcW+NCgrQwH6KeRQjG68ISA8/j7Thl8llQdGun3oK3t4dh+vYjVWxPvg/dg4Q5kuqoPDMsR1dP5C+7/9D2Cjf2ccGFm5QJ4ZbNWq6buZCP8kWmX3HMJoXogqv3rkysN5Wt/hNHqkQaYWgh8YRO2+OE9LZFzbVrIQB7tqsdzKDJGFGRSrT+afihPIRY4anHqMXBCJqXkXfNQ/8phg1L1zd80sIktPmQ98tAsUU4C/PcUX6swHtEgMXl8tXySz4EVJxyF9IyjDqEp8le9+lXCgWSxXhV7EHkuHwwd9pzQ6uZiBZBM7OGm6svbZOPGp6nWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1L2b588dvnDsGZYZRysyR4XN80z7wzeHrPhT8yX6FE=;
 b=HR8pTqLf9nf8G//Yh0P1aEmJlRy38Pq/xK/T+tClKjBYpcjpe8J9tpTRRo/w6AHTLGHX8chUN1vn+oUgZU1eoiF+RjRSVqlNEczzrSOXOtX4jSu1ea1MQ1z3uU8Cb4kxt8wFoDovtgtnz8FDguBsP5tnS5hUkILbN7oBanmbRFI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by EAYPR12MB272970.namprd12.prod.outlook.com
 (2603:10b6:303:2fb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:47:01 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:47:01 +0000
Message-ID: <101922f3-d918-4429-a7c8-c96f72474993@amd.com>
Date: Tue, 10 Nov 2026 09:46:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/22] drm/amdgpu: add SVM core header and VM
 integration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-3-ray.huang@amd.com>
 <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::11) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|EAYPR12MB272970:EE_
X-MS-Office365-Filtering-Correlation-Id: f841b24f-c405-4252-0406-08df3f397a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|3023799007|261026140227099003|261026121527099003|261021121427099003|261028144727099003|261022115727099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261022113327099003|261022105027099003|261022075727099003|261102123227099003|10067099003|11063799006|4143699003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6K22wOMTtEfdo6tbPIWH+teiK9i+nqsnCzQH2JbJjBQkUUmD9xjWTuWbtMT0u8iAXQkqzOIKlOGEgdVycJjsp0Jtq1XMRTjsIXbxn1unAZ96u8ONOiqLwGX0O+33NZUnZ/viJL1vU+BqdC9DwTVTEN+pk5DkhbqYBc5YxD0iTCPsu0zYVT38b4BQQNcgloXf5GeTerq6QM+bK6PIdTY+KoyKnQXmt/h2x/FYGeIMnuy9xS0WClpZFWZMRmjJSRs6rJ0gwAv0euXAAIs5tW8PzsqkZWQSqn07kL7PqrtzW5kjj/cx18s98mc9ybXR2DSoexty6KOuwVhZR3q4udBeU3yjO5CThd57waCkerOmUTWGwjgqHIsfT3RIaPeMjHKCw+96st84V9TApTrfb+7E3iOcoMegQkQAzvddMWqO/ZNKQ2/YGUrV0GHEC/PTYxnos7laG1/bmygtLrETiflMzLcxQEk2a/FldlWJ2x9acYbEhWdEMuaM9ielRF+cO5lOzVb0RXzQJAf1JcBxC2OGgPa4IbD9gQL523aprHYgdbFbHNj6Hv0t4L4f/Q+moegIz3QNrazzhhdJhiApBelgWuoBSv7IP3l4BNp4oahBZ54C4JddNMblZ0aVBBRtbu3C/pKLGF/v3zrcW+As+tnZla2ElzYRotIb9lPUIEUj8gbQx1srI4Ve4bEGoM5ktn1Nzagzx6ZZW46X7UGUv1vNhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(3023799007)(261026140227099003)(261026121527099003)(261021121427099003)(261028144727099003)(261022115727099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261102123227099003)(10067099003)(11063799006)(4143699003)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1dRTWNkbVdQTFd1WFovRkFhNFRxSUJxWWY5UDdPamlpdWIzZVBEcjRib2FK?=
 =?utf-8?B?ZXU4aEE4ODJvRXJkVGkxamptTnViNWZqUGswUUMyOGlNdXhEWklzZmdvTzY0?=
 =?utf-8?B?VnBYYzAwRVQzRWdpOUJlOERYY3pqYjVDVDJXTEprUVMvNTRHTUFSb1R2cEwv?=
 =?utf-8?B?U1pxbDhsL0VMU1QxRTQxYzA4dGMzQTRCOHNmRnN1K1hpcktaUmdzdkhvOFlt?=
 =?utf-8?B?Tkh5a01QMFEyM2wrVjhVazljOXFNeVlROTRSMWZDV3d1VW1qQ3YzUUdkYUxO?=
 =?utf-8?B?QS9lQXNUVnpCTmxsbmxxQkZsZ0ZhK05uZkNEUU83Tmg3UStSNTNkY0s2VGNT?=
 =?utf-8?B?Z0VXUVVTeXZhUkRTWjRWRDk2am5PUWttNHhFbWNwWlhUN2UwQjNpc0I0aElr?=
 =?utf-8?B?aEpEdFN0M1MzclFjTVpwbUFsaHNiMFJUYlQxVitUaE1EcURwOXZFRVZCVENh?=
 =?utf-8?B?OEdXWVlrVTQ0emlheDQwZU5OWWtIZjVXNGljcnBYdmRjb05xc3hzNElhRVhr?=
 =?utf-8?B?aEJnMmFvQ2RnNzErNlVhVndlVkJOTXVYaVIwcjZES3JyZGNsVUhheS9ZcGZY?=
 =?utf-8?B?dk5oQ3l3dXhEZ3M1NjdWb25VTFArVC9RWEp6MDgySXlrU1lpQTllTXNxVkg2?=
 =?utf-8?B?eHVncXgweTBRcFB1bDFCRnJNRlRUaGt6SWsvSzNnY1pOREMzRGNUR2wyck5Q?=
 =?utf-8?B?OHdwOEZjWjNZZmdnUTVYY3ExQVI0OWdDd1FoOFJENEhyQU12WmJRV2l6MWRM?=
 =?utf-8?B?ZXZPdWVRaE1LODduOWtvbVJBbDdIMGpoL25Ya0ZrKzNRNC9qaUhjWnpMTDUz?=
 =?utf-8?B?QU9TckpsV3JGRmdiRmowVC96d2FtL05EOS9IQXBpakd1VFJqcUJSbEd5V0sw?=
 =?utf-8?B?R2JMTkZ6dUlrUUVyLzgxdElxN2Evc1ZwM3p0dzExdnVJZmF0RFVwcGxhMnVD?=
 =?utf-8?B?cERvUUI4R0Rrc3F1WDJFVGY3d3BtK0ZFUGxaNkZNMUNvaWhEMGZ6c2YrRW5n?=
 =?utf-8?B?UCtmaTUvSmFQeUlQc3A2RThRWmNGT0ZOZEZISUFVbkRRcG9WRjZzYWQ5djh0?=
 =?utf-8?B?Sy84WGx6elNDQmR6RXRLa2pVWUpBMFF3R0NLRHdCUEZoU014NDl1bjJmYk5X?=
 =?utf-8?B?bTB3d2lTVHF2UlBpTHBvenFoenBBdDNsV01pRGxmZXNKNDZQa0RuVVFsbVdp?=
 =?utf-8?B?MDNTcFROYXE5eFBDOU43MkxQa0p5RnBTckducnBickpCZllMVWVxNXdoR3Vw?=
 =?utf-8?B?eXFUU1FXa0kxNDhVRjZ1U0dlZzQxQmRRVk9SKzVwYmZjaWZSNjYxeGNhU203?=
 =?utf-8?B?WktvTFNPNHdmY1pEZGM3NThSZC9XYnNrSkxFT29PQmdQSGw4YVRHUzYyVm0r?=
 =?utf-8?B?VGFjSTlxYVBtSFA4NDR1QVpyY3QyOU9ETmNHdUhCNytMZEZqbGNUbk5VbXRE?=
 =?utf-8?B?RUQ3cGtJTTc2S0MvOE5ZS3hhdisvYlIvY3pDd2NnUkc0NXR1dUprZTBiNFlo?=
 =?utf-8?B?VnI4eGdxRnBFeEZYZE9FbHF6UDZiQXFQVE9aMWROd0dPU0ZsdWdxM2lOMkNt?=
 =?utf-8?B?WVJUMTEzWkk3SUFpU3RMWDVkWC9XWnBLcXArZ0pXMzJYSXROREF6Vkw1dER3?=
 =?utf-8?B?YnpLYkptQUFac2c1bGc2TUQ3T0tVM29RaXFyZ3F3eVE5Q1NYUEUxMi96VVJK?=
 =?utf-8?B?a1BYa1VRcVNvNE8xVlJmQUlrOVJEclVUK3hUeCtMcFp0TCtlUnp3NWNNNFN6?=
 =?utf-8?B?TjRDMS9zOWRBMnFwdkNMVUw2Ums5QXRqbkRUUCtSMFNWdkJQWWE1OFVad1Yw?=
 =?utf-8?B?aTVMaFFNWU4rSGlVNFVGVTVMN2Y4TTR0Y09XbTdDbURjVmVVN2grTVlSNTJ2?=
 =?utf-8?B?K281bjVXOTExQW9MYU5zU1ZKZnVRajR0ZkZHUlhLazkyYjg0R2lYUXlTVXg2?=
 =?utf-8?B?ejhKQXhIcmxDR1MrNmpDZXlPaW9iTS9KcW5tSVJTNFFSajI4TWF3Z0dkSk0z?=
 =?utf-8?B?SmFZS05pRXMxWGRzNnY2a20vZ0pHQ1o1d1A5TXg0UlVsYXBJNG5DbVFqY0Yr?=
 =?utf-8?B?SjV3QnVGRkErU0xiVkJwWmRVWEhRUzdLOUVESnphZUQ5VnZrcmdxQUxxY0px?=
 =?utf-8?B?WnMvLzhuVGdMZzNxN1FmU1JEWkpuYUxjbVJ3aXFoNm1ueDB3TjI1YStnd1pk?=
 =?utf-8?B?VjhvQUw2dEMvNkJYMlB1bHlGK2V2QjZJOWkvVTRHKzNiYkxmeExEK3hub1Ry?=
 =?utf-8?B?RkI4WVY4UE1SUXVBSS9jcmpkazBPamIrcVZBSzM1a1VoOWF6QTVHczdYTkxD?=
 =?utf-8?B?eC93RlBHL2ZiTlFyVGo3NDBYblcrSEJVL1o2NG1lNTdudHNoanIrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f841b24f-c405-4252-0406-08df3f397a65
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:47:01.0659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4w0CkWdeY/88CMy5Y2CApQmCUzndehJna0+kqvmPHagGgLbjktt5N2y9x7fH4XGjcHtaQ21cagXYH85qrMPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB272970
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-09 07:33, Christian König wrote:
> On 10/21/26 04:58, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add amdgpu_svm.h with SVM data structures and public API:
>> - enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
>> - struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
>>    attribute tree, rw_semaphore, GC workqueue, xnack state.
>> - struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
>> - Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
>> - Locking helpers: amdgpu_svm_lock/unlock/assert_locked
>> - Public API declarations (including clean_queue, sync_work)
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 195 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
>>   2 files changed, 199 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> new file mode 100644
>> index 0000000000000..72f954d2df39e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> @@ -0,0 +1,195 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>> +/*
>> + * Copyright 2026 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_SVM_H__
>> +#define __AMDGPU_SVM_H__
>> +
>> +#include <drm/amdgpu_drm.h>
>> +#include <drm/drm_gpusvm.h>
>> +#include <linux/atomic.h>
>> +#include <linux/kref.h>
>> +#include <linux/list.h>
>> +#include <linux/printk.h>
>> +#include <linux/rwsem.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/types.h>
>> +#include <linux/workqueue.h>
>> +
>> +struct amdgpu_device;
>> +struct amdgpu_vm;
>> +struct amdgpu_svm_attr_tree;
>> +struct amdgpu_svm_attrs;
>> +struct drm_device;
>> +struct drm_file;
>> +
>> +enum amdgpu_svm_xnack_mode {
>> +	AMDGPU_SVM_XNACK_OFF,
>> +	AMDGPU_SVM_XNACK_ON,
>> +	AMDGPU_SVM_XNACK_DEFAULT,
>> +};
>> +
>> +#define amdgpu_svm_assert_in_notifier(svm__) \
>> +	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
>> +
>> +/**
>> + * struct amdgpu_svm_gc - SVM range garbage collector used for unmapping
>> + * SVM ranges in response to mmu_notifier events.
>> + * @wq: Workqueue where @work runs on.
>> + * @list: Ranges list in garbage collector. Protected by amdgpu_svm.work_lock.
>> + * @work: Drains @list under amdgpu_svm.svm_lock.
>> + */
>> +struct amdgpu_svm_gc {
>> +	struct workqueue_struct *wq;
>> +	struct list_head list;
>> +	struct work_struct work;
>> +};
>> +
>> +/**
>> + * struct amdgpu_svm - shared virtual memory context
>> + * @gpusvm: Embedded drm_gpusvm base, manages the range/notifier trees.
>> + * @refcount: Reference count guarding the lifetime of this instance.
>> + * @adev: The amdgpu device this SVM context belongs to.
>> + * @vm: Back pointer to the owning amdgpu_vm.
>> + * @attr_tree: Interval tree of SVM attributes.
>> + * @svm_lock: The driver_svm_lock described in the GPU SVM locking section.
>> + *            registered by drm_gpusvm_driver_set_lock().
>> + * @work_lock: Protects the deferred work queues such as @gc.list.
>> + * @gc: garbage collector for ranges queued for destruction.
>> + * @exiting: Set once when the context starts tearing down.
>> + * @checkpoint_ts: IH ring timestamp captured on unmap, used to drop stale
>> + *                 faults.
>> + * @default_granularity: Default range granularity.
>> + * @xnack_enabled: Whether retry (XNACK) faults are enabled.
>> + * @invalidate_ranges: Callback of the MMU notifier invalidate event.
>> + */
>> +struct amdgpu_svm {
>> +	struct drm_gpusvm gpusvm;
>> +	struct kref refcount;
>> +	struct amdgpu_device *adev;
>> +	struct amdgpu_vm *vm;
>> +	struct amdgpu_svm_attr_tree *attr_tree;
>> +	struct rw_semaphore svm_lock;
>> +	spinlock_t work_lock;
>> +	struct amdgpu_svm_gc gc;
>> +	atomic_t exiting;
>> +	uint64_t checkpoint_ts;
> By now we have figured out that TS in faults are not useable for fault handling.
>
> Background is that they reset from time to time because of GFXOFF and may vary depending on the engine who sends the fault.
>
> Adding Timur from Valve on CC, he send out a patch to completely remove the existing timestamp handling from the fault filter.
>
> We need to come up with a different approach here.

At least for the fault filter that shouldn't be a big problem. We don't 
need the SW fault filter on any GPU that has a CAM. That should be any 
GPU that supports retry faults starting with Vega20. AFAIK the only GPUs 
that still need the SW fault filter are Vega10 and Raven. If the 
timestamps work on those, we're fine. If there are any newer GPUs left 
that don't enable the CAM for whatever reason, let's fix that instead.

Regards,
   Felix


>
>> +	u8 default_granularity;
>> +	bool xnack_enabled;
> It's probably ok to have that here for now, but that will become a VM property in the future I think.
>
>> +	void (*invalidate_ranges)(struct amdgpu_svm *svm,
>> +				  struct drm_gpusvm_notifier *notifier,
>> +				  const struct mmu_notifier_range *mmu_range,
>> +				  struct drm_gpusvm_range *first,
>> +				  uint64_t adj_start, uint64_t adj_end);
> That looks a bit questionable. Why is that a pointer inside the amdgpu_svm structure?
>
> Apart from those questions that looks rather reasonable.
>
> Regards,
> Christian.
>
>> +};
>> +
>> +static inline struct amdgpu_svm *to_amdgpu_svm(struct drm_gpusvm *gpusvm)
>> +{
>> +	return container_of(gpusvm, struct amdgpu_svm, gpusvm);
>> +}
>> +
>> +/*
>> + * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
>> + * Hold it in write mode around structural GPU SVM updates, including
>> + * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
>> + */
>> +static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
>> +{
>> +	down_write(&svm->svm_lock);
>> +}
>> +
>> +static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
>> +{
>> +	up_write(&svm->svm_lock);
>> +}
>> +
>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>> +{
>> +	lockdep_assert_held_write(&svm->svm_lock);
>> +}
>> +
>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
>> +
>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
>> +
>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
>> +					       uint32_t pasid);
>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>> +			    uint64_t fault_page, uint64_t ts,
>> +			    bool write_fault);
>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
>> +
>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>> +			 struct drm_file *filp);
>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
>> +			    struct list_head *work_list);
>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
>> +				 const struct amdgpu_svm_attrs *old_attrs,
>> +				 const struct amdgpu_svm_attrs *new_attrs,
>> +				 unsigned long start_page,
>> +				 unsigned long last_page);
>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
>> +#else
>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
>> +				  struct amdgpu_vm *vm)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
>> +{
>> +}
>> +
>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
>> +{
>> +}
>> +
>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
>> +					  uint32_t pasid,
>> +					  uint64_t fault_page,
>> +					  uint64_t ts,
>> +					  bool write_fault)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>> +				       struct drm_file *filp)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>> +
>> +#endif /* __AMDGPU_SVM_H__ */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9b07df5a2b816..b435e393be154 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>>   struct amdgpu_job;
>>   struct amdgpu_bo_list_entry;
>>   struct amdgpu_bo_vm;
>> +struct amdgpu_svm;
>>   
>>   /*
>>    * GPUVM handling
>> @@ -381,6 +382,9 @@ struct amdgpu_vm {
>>   
>>   	/* cached fault info */
>>   	struct amdgpu_vm_fault_info fault_info;
>> +
>> +	/* SVM experimental implementation */
>> +	struct amdgpu_svm *svm;
>>   };
>>   
>>   struct amdgpu_vm_manager {
