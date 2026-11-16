Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67D606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1WDDNhjU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375D310E201;
	Mon, 16 Nov 2026 05:37:17 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D28110E164;
 Mon, 16 Nov 2026 05:37:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JowRNzXM4D+OzSeVGwTuxrbkS0SzrgJTGVMaSFckakxbNmgnfnm0ur3s4tXyjF5MJmcYvL5+MxvWMder+sbXpUIUGsL0Y1Y4UERsd6cHc8NYSqUrknQbSe3t+qtWG6d4Y4vgoWI1tSZoXZWHMfEfq/OMWJ/ssVTrT7aS1ScuMxsIkE4qUoQi8i+YIdmlunrY2413kKD7V78/x+tZm9BCUDvSwHxvNAKfL1NkHhNHRSqe26XItVYcgIlo9q/CPLN+B8xabxOh3UgIV0bPn+CwUSKGwXabHFPb+2RVyTwMv7eWIZ913e70VmGvl3ri7VXoofnrDdcRHhFMyVJ+7fAr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVJU/xNeaiI6sKP76aBmAV00ry2u5vuKr0iQ+0y6r8U=;
 b=jzHuguRx38/lfwNCPtjqdAbU7CKIwFrzc1U5Nv3wBbdgTIEUxDR9OxuKPjzMuuXoG52NU1XDRxIk4oc27F7gOtI6+Vt+Tku+UfERtMY5Mj02f/suSjuuP4989IpLZZffBFPeM9wH/LdMRHVelLNI+V0dqg5dFmEr28IZ7Ktfmnl04WLGwKEl5MptGqPNG9ikww+X/HqF+WcfLGOe6g8XlzMY1cXCRwCIMd/6akVyBWJ1PkcrU4pxTwsYQ3LrrGjEC6z+N7tCqOAfbd2aYrzZ4YZZkT2uyBOYhAANPhQK8+/WQFM5Ug1dWr89x7NIpXEjtsy8zUZamYrLHOwdiSitvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVJU/xNeaiI6sKP76aBmAV00ry2u5vuKr0iQ+0y6r8U=;
 b=1WDDNhjUvwegaf0TJwYCxO5RW+oX+74CsEtLcuwZOxxXVr1SON59D20gYtntqcDPDYR21TgKGVc9Fmje0399Be4JyjbWZqSMP2veEoMMAdjUPcFXuITa56papd2/iYItFYLxVDL7Ca7EcEujTeTJrT7lSA/SQy4m98lQN6lnSVs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DS6PR12MB186998.namprd12.prod.outlook.com (2603:10b6:8:52a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 05:37:06 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 05:37:06 +0000
Message-ID: <77e9d65b-d051-42ce-b350-9e7631c6a527@amd.com>
Date: Mon, 16 Nov 2026 13:36:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/22] drm/amdgpu: add SVM core header and VM
 integration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-3-ray.huang@amd.com>
 <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DS6PR12MB186998:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6993d5-fef5-4434-6cb1-08df43a3a677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: lsvTw2kxLxdXXupjDNDkZ6jKEOEI3f0m81m2zx4Fwlg1IVjNI0IQjuvG+ZCZ6ZPv/vjogtRyd/rqflX+Q4w3GEVY9HYnGanRIyuDecbVAEjxzmsqQSmPRDPg6GNTRmZub8WhZRQ/cPee9Na+lJKMBO+TthE4e6be2/2bphfMx5ZahDm/GPkryyfRUWXsUu0QSH8FAZgUvnBOgKWNfIwYtFW3pVhpcWdMaLAcdnUp6qtFZYJtoijtqtFFri2NQqKiOTqRfpQ/Y4PW4c7YJ0Bjs/+1YbKLmqwBRovnC9YcZ7BLVXfJGQzFAEYZUYnvKVJHGWjZRQB8GyTvK76EqPphANldUSrG9leU7o6RmaHawZBG03MfG0woxjPAzOnW6YG9i5UgSjLBhQVRaSNQyAvPZ8bHqw8W5VRiWKuEs0mdxTEEzyBrezbizKq/z+c98SZRIzFvGaIAfOZifwRcfrKgbeE2Lv9aA5arNQ4GqQ0rj9/Q+vppkw7vx6cEpNhnY9PXP8nuVng0/rXcVJD1VWpl1iB9NSsm7plZRj1g4dd7OsarQ99+rznQFoy9H+jvcBhjzt+4QE8WLOg4UWbv6Ro6bTuuhIhoGlHncH/fdiu6LT+9FyAhU9zzYkqJ1fD5jAPT4736cq2Y2asgX6Kg/PeyjRxijefz06YAudRP95IH3dM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEdCcE90OXpUMmRBdzJMOEdWbjdQYmt6ak1mYUEzRm5PNkpLTnlRL0FYM3VK?=
 =?utf-8?B?d2NCSXdoTE9XU1dYbmRBd0p0OGtmZS9RWmpuMTFTNjFWVCtDOXErSUxlSnRs?=
 =?utf-8?B?UG5ubGtBUWdXTTlkekVSbCtiTzJMUUFQQ2k5QVA4ZTJTL3RyQlpUY09DUDVs?=
 =?utf-8?B?VWhxWC9iM1lyRUljYTJWTEsyU0p4cWNJU1FTSzd6M3VFM2dCdWc1cVJHRHNZ?=
 =?utf-8?B?RGJSbnZTY3BKbUdkaXIrclhaUHZySVFVRDJER0pRMzVZRkJWdVppbTYyanU3?=
 =?utf-8?B?MHpIRzN4UXpWMmxGV1ZaV1krMHpmSkh3TTRCQm1LS29RclBLZmw1RGpwSTA5?=
 =?utf-8?B?blZXbVlVUXI0ZkdiTWpHL1NGUlgweFVwWXZzdW5iNnpxUmVxOHgrN1llTzQz?=
 =?utf-8?B?eG1BSEtIVzdsWjBld2xFODI1NS9NeXBvNm9Pb2xYYlhIZFpQN2ZOMEplcS9C?=
 =?utf-8?B?Nkk2Mk9Mb3o2bUpMWkcvbitFZzFHcjREa2JXOHE0ZWd4WFF0eUs2T095eFRr?=
 =?utf-8?B?a0d1QkpVRDFaRVJreFJ2SHloZmk1cXozRk1xRGRiTU8xazBiN0Z3cUlaSTk5?=
 =?utf-8?B?VnUwbUJyN0U0QnBpVmxoTndEV045N2dRTEExQXVlcHBiUlNnRXlMSEd0Y0lQ?=
 =?utf-8?B?UENnUGJqeS9VVXE0dTgwS2U1YmtQcjJpZEhNbXJxMm91emFkVEVRQWlqWGxm?=
 =?utf-8?B?MXJIc014bUdVRjhKY21PNWlHelpyQ1pmaEs4eGZ0RXhwVzdoSFozcG9IaG5l?=
 =?utf-8?B?VFpOSFhURzlzTjZ6SkQ0Ri9XRWVwMzVCTHdUdUUzeFhXWldvaHNEeENsVlU4?=
 =?utf-8?B?TE9qV3EzZkkyU3ZpOFJEQ05hV09oWHErdFkzeDJjWGdzNUVrcEtnTTRSbXVX?=
 =?utf-8?B?dHFhWFV5VzlNSlJBOEdWbDNUbmZRRkNsWiszSWJFOHJqMElET21LYjg4UFpB?=
 =?utf-8?B?ZmJBU3QyZUhEUFp6cWlxUWIwVHBwa2wzZzRJVzhPbS9ueTJJTU5WWHFVeHV4?=
 =?utf-8?B?QXdHQWhiQW5ZR3hHeGpGNjlHdCtyWHZqN3lxbHpNOFZCa1J2d1hJMEQ1UW9K?=
 =?utf-8?B?Yi80MFN3NmxnVlUzVDVkRWdsZFdNeTJIcVdjcDVaQU9DTWtvTXBhTlBmdXNC?=
 =?utf-8?B?UjBCejM1dTdPendmUEhvSHFsZjFLQ2JRSHE4QTRqOTh1K3dRRW5EZnRkUHNP?=
 =?utf-8?B?OXRHVXd2NTFQRms3blhKZXV3VlhJa2VzbXFhYWFMVzRvWDI3TjZMeEpxMVpk?=
 =?utf-8?B?UUgwWFU4c1I0N3I3bW5hdVlHTkcyaGZVcC9ReGp1ek9GTk8xUHV2aFRnbnFS?=
 =?utf-8?B?L1kyVWlGYkRMNVJBYlAyTi8zNHZjV3BvRmJLaHdyWnRQMUk4dVhjaE1LNHh6?=
 =?utf-8?B?Q3hRaDBpOEx0UEoycm9OV1Y2dFYvd25naFVvbWh0NGhRN09hVCtFRlZmQjRV?=
 =?utf-8?B?UGl1K0IxRzh1QlR4RWgvWXVzU3pOdWpWTG9rSitHdWRsMlJVOWRobUVHRFE3?=
 =?utf-8?B?S2NOUytHSEljdHN6ZFI2UEsxSklIbno2cWxjVjRGbS9hNHhzTXFnaVhjRmJL?=
 =?utf-8?B?L1huaHFSdVhWYXJIS29zWjJaVHdkWHg2bkR1dzhXTDIzOWJxMTAweG1heHhk?=
 =?utf-8?B?Rm5Cc0FmK09qZEx0UmY0Z1hVY3pwWjQ1K1lyOWkvL3JZTlgvYWRPTjQxYUlk?=
 =?utf-8?B?SThERmswOWJYbzR5Witsa2Z4dzB5bGtGYlpVNlQ0dU1WVWthaDlBYlIvTHBm?=
 =?utf-8?B?dmw1N2MwWnBhYUIzMnZneTgxZGtRK2R1bkM0cC91aEhDZFpFMEVzWnhKZm9K?=
 =?utf-8?B?QThKbzcwbWZqZlNQSDlsQ0JUd3huenhaQVNVMzRZUkpPNnM5UzlNWGpaWkpp?=
 =?utf-8?B?b29FVGp6L0dHQmlHZFNBOTdtZiszcnFZczVmV2t3UTBCMHN5Ym95UTJ3MFdk?=
 =?utf-8?B?ODN6NWsvY1YwcFlXOFlNbnVpL3VlMHpvUzVYQUVMU0xQQ0pwa3FPb2lIbGZu?=
 =?utf-8?B?VVlEa1VoYUJudnFqN2daYU1KNWhhTzQ1SytqQ3dSVDV2ZmtCQVYzSTlKMWt2?=
 =?utf-8?B?bFZKanI0NkN1c25wRmFKOGNwRTI3ZSs1emx5bTZnWkVrUlM3Mkl2ZzJJdXJZ?=
 =?utf-8?B?U0RwRHdQUVY0aE9NVG1pSkNiclhWVGpDSkJXMnFFeFRLSFZ3UlRvcnFnbzd3?=
 =?utf-8?B?U0pNWjZOeXRybDk2RVZYQnlMaFFacEZtMHpKSXhxVUd2ZVVhTzRFdlZJZzJt?=
 =?utf-8?B?WTFYaXBtOWhxUTQzNGNlb2l4eTcvMlpxSkRka3NWbDR6cXZMTDdrU3ZjZEN5?=
 =?utf-8?Q?qdHxJk4HL5q/oux9fN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6993d5-fef5-4434-6cb1-08df43a3a677
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:37:06.5510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKTHv1f3iZSdnAeMwvmLdf3e8nj+svT4ufv2Qzpy2qb9V5BThh16UoyGKZdsOfsqavxKXPKSdZSuodDnpWlrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB186998
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/2026 8:33 PM, Christian König wrote:
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
> 
>> +	uint64_t checkpoint_ts;
> 
> By now we have figured out that TS in faults are not useable for fault handling.
> 
> Background is that they reset from time to time because of GFXOFF and may vary depending on the engine who sends the fault.
> 
> Adding Timur from Valve on CC, he send out a patch to completely remove the existing timestamp handling from the fault filter.
> 
> We need to come up with a different approach here.
> 
>> +	u8 default_granularity;
> 
>> +	bool xnack_enabled;
> 
> It's probably ok to have that here for now, but that will become a VM property in the future I think.


Still put the xnack mode in svm structure in next version, putting the 
xnack on/off needs a design input, casue it may affect other 
components's behaviour, waiting for someone who has the full picture of 
this reqirements to do this task.

Or you can give us the requirements, then maybe we can give a draft 
version about this, that will be an another standalone patch series.

Regards,
Honglei


> 
>> +	void (*invalidate_ranges)(struct amdgpu_svm *svm,
>> +				  struct drm_gpusvm_notifier *notifier,
>> +				  const struct mmu_notifier_range *mmu_range,
>> +				  struct drm_gpusvm_range *first,
>> +				  uint64_t adj_start, uint64_t adj_end);
> 
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
> 

