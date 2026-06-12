Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF42CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84E210F56F;
	Fri, 12 Jun 2026 14:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OFj9yjaH";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0C310EA5C;
 Fri, 12 Jun 2026 14:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeBdtoTKU2cEuH4IDTW3J/uIDa9V1/plyOrxS5+4VWuk9jREmSMU4b3g/+oVS3oTXJABBEmqBV2n++da1E6iBfi/7RSKrxaKxw5qlDuXQGseNzquFf/NVzYHxn/81YwbvA3JyM5BN9HMEdg9cehD0yMR1IpAcjVi++an2GKFcMFHU2B9W/+EtRfdyxQ4Zu1sghh3wrDmi+xGBO27h786eQoj8NamIEpPaotsPyhi21w3stvGBYdodO1tFDOxf3saVA7TrJXKlFfYSzfHFA8/l9h/lujHP3WA3ALOBzdtUXWyltd+UxVObO7NPoi2gZJQ71cuqK7rfOJK54j2ICsVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9wCwiuhvfavwKlYsHGVjixViw3x/6P50JbSJGlqq7E=;
 b=JKhuimFtWtI/hlkl5yPFvaKZ68s5rCArHNYQaQ30HKhMFyLgRncwCkeJNkq30jXyGSpZyPn9ic+5Fa9fUoeb8oUUanm44dm/CVClGXREXoaTTiPz/nUPAVwWWBntEEpoEZ4diGanlJ7H+ttnP2O7ik0/J3Ma6bhdy3XFwuGWRpxN4WOlRhOFuvx/MeuPj52lkZLnURen5kQXHTEaYltWnIKeWTSujsBbVEwCcEC1qhhx7Lw0u7NhOKG2rFNM3qIKa2U3dJe0ejwT90yf5TqHFNj7K1ie4m8EugopNBxy97htnx2RtB1hEcpkpSew632Uw8cxBKj7L9BHCYdjDC5urQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9wCwiuhvfavwKlYsHGVjixViw3x/6P50JbSJGlqq7E=;
 b=OFj9yjaHgGtCQMCK2O0JuZmIH6U5tHpkUBqmRb0D7kHVRn8Bh2dIyw9s0zLaYtiPqp/ynkN4Y3+eXKPrX8haSq3OIyE6jClh/sKC11au/olyeBG82XwC4yYmOwmNNdEZ04xgAm92FfKo/4zWK5YBTjbADbGI63wipd0JBTfbRhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 14:44:13 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 14:44:13 +0000
Message-ID: <6e928a65-90ba-4c57-8ad2-c6b00874c6c7@amd.com>
Date: Fri, 12 Jun 2026 22:44:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/18] drm/amdgpu: add SVM range types and work queue
 interface
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-7-ray.huang@amd.com>
 <d1646a51-2c28-489c-8ae3-8b8da52be42a@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <d1646a51-2c28-489c-8ae3-8b8da52be42a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::19) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c162f47-9c88-46bd-ad1e-08dec891113d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|3023799007|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1OO8rnxIEwtftiwpTBS4AI6EZyWNJ9VyiqRA8k7Wk6hTrfjOPdyZcVmzuTyspKqfOtDd6dA/ZAsvP5bu1ZyNg9ZgKI9OSpOFnC/obg8RbvFoHMYnqRawCDGoj7Kj3oVDG/gcfmW9WcU7cO22d96w2mAZXzOkdYWKS7aiSual/ig25WCp+e1HMUSk0vcOrpGb+NlFc3x1MDk+K8puiIW4OlnWWKS68sL2CyCvamoJo8bW9ZFWtX2Gs02e/Dskr/rzNJvRqCRpVUgXCnj7vMYmsuD2mu9s3gqceI2UJxYXPCeBfnuSrAa6V+SiKpl1CIOYX7GainPAvy56QZMLBGgGy+9mPoG61YeABJscm5HcO0LvkaD6VjECTWm4NKlw1J/zSdqSdc+d1yO3UMySd6ONvpcpuwdhnh4sSqOJV9B3fcSa1Po1LYMijn6m00jxpwBpLweVTW5B8GpNJYUbukgFuTI8FJnRZarplQa+2yQ8lmFF86QMjoNYTqKrSjCa07hL64NSNisWEmilf4Jcza6eiuqVVxmVLcxVzdGhTk+c/YwL8kv7yTetLR13S+rkhLIUcgxHCeRnXA2KMcVv/LGCBA46PLtFB0lDrPxwc+5Db+KoRtksObsAheRMlurvds0jUCdR94I+dP6d9DdolByZnW7+ncwEDFmp9WHXO2Sm1nZV71numn6pYWveL1xM9jgo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak1ZRVM5SmZVTENwblNYZWNIVG9NdzJqYmo5bFhGZXlKZ2FHeHcxWXpuQisy?=
 =?utf-8?B?QjBRei9abnlVVWN0UmVvUTh2Rm5RNHRpeW5odkxKL3U2MnJNa25sblNMUkFq?=
 =?utf-8?B?VEk3Z2VWSDFZK0FtQS9uWHNBQ044SkViZ0ZSZkhvZGZDNno3b3FpOWZaUSs5?=
 =?utf-8?B?VDJZL1ExaHQ1SzZURjdNWVdYTlhjMEpIdGovR0hORDJXdEhsWUFTRC84MFVW?=
 =?utf-8?B?b0RzdUtVZGNISXY1cFdwUlpmUlJXK3orV2o0L1FuU1R6K044eEJKR0JYaHov?=
 =?utf-8?B?ZkRwaW0zQWtZUUJ2SXpGNXlCNEVLSXdLQVl1cFZvUGUxZTMzTlZoeEtNd3Na?=
 =?utf-8?B?d3Rja0dqYUdvS1dDTGJ1dE02alVjV0FtaFJ1TjloYlhHMmtzUCsrQ2QyREow?=
 =?utf-8?B?UUw3TTJzUVh6VFk3RzFydzRYZUZNcU9WOFcrR3d4Q1FDOWtwb3pqRWxnVzNK?=
 =?utf-8?B?UXJhT29sRlVOZy9odUxNdVd6N0VrenJ0MWlQZnZadUxNN1h3STArRVRZc3JP?=
 =?utf-8?B?b0hUQlUzSWRoMEJOSkN1NUVvcTZpc21Yei81cHRKVk5HRlVTeGRNdUYrQ0hX?=
 =?utf-8?B?dk5VUTgyNytabTNKVTkxcks5WlhkM3N6bXNSa2djUFdDU2t4SXNKbTEvbWpK?=
 =?utf-8?B?MmVIYUwvcGxMYmlrQjl2ZFFBaS9lSlB2NjVrRDhxcWZCYmUxMFJMemQ0cW5z?=
 =?utf-8?B?Z3o3NmNvZExISTVpNm9lRGZuelVQeEpka2ZNdURIRHpvUkRKa21Ybzgzc0JK?=
 =?utf-8?B?b0JYd3A2WVVHZ2E1M1haNmFPOEgyUk9Kd3BxL3YxZ1lQRGVOZVpneVdPYjhu?=
 =?utf-8?B?WmY4azZDYVlBK3Nkc09LM3ZkYVF0Z243d1dhc3oxcVhvRzJzcGRjSFRoWU1V?=
 =?utf-8?B?eHE2MUJCS1A1enB6a0FsSFJSS0ZTNzlxd2JjZGV6ZzkwVitDa1Q2dExHVjdB?=
 =?utf-8?B?V0VkeGtleWg5aW9NUm8veWh0NEpUUjhHcE03ODFrODB2NlRrNDFmdzVyc3pM?=
 =?utf-8?B?UEw2Qk1sU2d1U3Nhd2RJd0ZyQUpjbWE1Z3gwZU53TkRpa1F1TEJMZXBzdk5a?=
 =?utf-8?B?cENVc0orMzM1TkFOdkVQRksxRWFjeE1VMmk5THJ4OVBpZXpkTXd6a3NGVlRa?=
 =?utf-8?B?bU9TWklNOXllQVdnWVJDbDJGclBXVVQ3SU05NkN2eTJUZ0R0Z0F1WWVYcEhl?=
 =?utf-8?B?cTI1bjFncGtoV092dGVLcnFQbEVKTlpQN0NLczYwQURwcU5NbVVIWkw4T1BH?=
 =?utf-8?B?R1Z1VUxJY3JZaW05RnU4WXNsZmtOQVhSYVJZaVhZQVZ2aVM2TUs5UG5kRTZw?=
 =?utf-8?B?RmYrenFFcW5lbHBrYXI2ZHBTaTlhRE16c2hCL2RkV1h0N3FaZ3FFc3FzSHFK?=
 =?utf-8?B?TGdhODVvazBkdEljWG9STEhDOVdkR3F4b1RiUFlUbHFpMWpncjlWNHRSMVBj?=
 =?utf-8?B?RE9RWnZmUml0Y005YkNJRlZTajJJK1I1N3Z4UnNXM0s3Zlg1dUpRbzJkUUFQ?=
 =?utf-8?B?L01md09CenZ2cTVjT015Vyt3ZTN1U0VqYmQwM0MzNEtDb2p0bG02dEE2bzVK?=
 =?utf-8?B?akxVaExGdVVvSFIyMUlISEVhZERjNEZIWlNpU2M4dFpIWVppN1lFbVlGWFUz?=
 =?utf-8?B?N0VIQVgvakVnOW5ZZU5GYWtpTWI2T3dpSlM2ZkpmUzhXZDNRYjR4WkUrRmI3?=
 =?utf-8?B?WjBBOGpvc2NTV3hxanh3VDJFZHpxRjVxNGdlMmF3akhTaGxwZW5NU3FndVEv?=
 =?utf-8?B?YkZyYytiK201d3NhQm1EYWlBMVF3VHRtSWl1VkJod0p1SVcyRlh0d245TU1D?=
 =?utf-8?B?enlUMmI1dXJNSFUxOVB5S0ZrYUllRHdYOXZsQ3pFQnVvK0FlcVRqdE5rd0ky?=
 =?utf-8?B?UTFacWk5SFBIQkFPaU1IYjM4MmdtWW8yYXU3anJTemtwUFpMZEtRWHB1cTFu?=
 =?utf-8?B?elNHK2swYk85bUV3SVZJc0I3NHIxT3dyRXcyT0VySHdleEpURWFnTkZKeU5D?=
 =?utf-8?B?Tm1GNWhqaXhWZDVjVXcyOUZFalRZNHJIU3RTemJ2Q1BNNVArd3NCd3VtL01S?=
 =?utf-8?B?RnF1c2puQlAydnVONTJLYWNhMWpkRnV6anhlaWRpS1VtbThMOEdVbnBYVlFB?=
 =?utf-8?B?Q2hENWVjenVyNWJwMWNmOTlWRlljbTJJVnJDRUFZUUJ2NlN0R3hKak5maTEw?=
 =?utf-8?B?YXNHcTVFcE0zSzNHeCtKTThXNE9aeS9RM2V5TThDK0NkaWk4ODhEUHg0UDRC?=
 =?utf-8?B?dGF5c2NBREg5QjlXMnhTNjhEaUEzRmpvaVlhbmVyTyswU0FrMDlPb1kvbTBM?=
 =?utf-8?Q?eZ0IBe1r7wGehCx9YP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c162f47-9c88-46bd-ad1e-08dec891113d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 14:44:12.9416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1eALPR5rLhnLtZSOmF15cuIpeeOh5ba8nMG7PpWbyxsTkWlVOwUInZmwVgcsCnQcKC92TvQhwY4OGCOR1NZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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



On 6/12/2026 8:13 PM, Christian König wrote:
> 
> 
> On 6/12/26 11:09, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add amdgpu_svm_range.h with GPU mapped range types and interfaces:
>> - enum amdgpu_svm_range_queue_state: NOT_QUEUED, IN_GC, PROCESSING
>>    states for queue work
>> - struct amdgpu_svm_range: extends drm_gpusvm_range with gpu_mapped
>>    state, queue_state, attribute flags, work queue node, pending
>>    ops/pages, and validation timestamp
>> - enum amdgpu_svm_range_op: NONE, UNMAP operation types
>> - struct amdgpu_svm_range_op_ctx: dequeue context for GC processing
>> - Inline helper: amdgpu_svm_range_invalidate_gpu_mapping
>> - Range operations API declarations: find_or_insert, get_pages,
>>    update_mapping, update_gpu_range, invalidate
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 165 ++++++++++++++++++
>>   1 file changed, 165 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>> new file mode 100644
>> index 0000000000000..a079eff86020e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>> @@ -0,0 +1,165 @@
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
>> +#ifndef __AMDGPU_SVM_RANGE_H__
>> +#define __AMDGPU_SVM_RANGE_H__
>> +
>> +#include <drm/drm_gpusvm.h>
>> +#include <drm/drm_pagemap.h>
>> +
>> +#include "amdgpu_svm.h"
>> +#include "amdgpu_vm.h"
>> +
>> +#include <linux/ktime.h>
>> +#include <linux/list.h>
>> +#include <linux/types.h>
>> +
>> +struct amdgpu_svm;
>> +struct amdgpu_svm_attr_range;
>> +struct amdgpu_svm_attrs;
>> +struct dma_fence;
>> +struct drm_exec;
>> +struct drm_gpusvm_notifier;
>> +struct drm_gpusvm_range;
>> +struct mmu_notifier_range;
>> +
>> +enum amdgpu_svm_range_queue_state {
>> +	AMDGPU_SVM_RANGE_NOT_QUEUED = 0,
>> +	AMDGPU_SVM_RANGE_IN_GC,
>> +	AMDGPU_SVM_RANGE_PROCESSING,
>> +};
>> +
>> +struct amdgpu_svm_range {
>> +	struct drm_gpusvm_range base;
>> +	struct list_head work_node;
>> +	bool gpu_mapped;
>> +	u8 queue_state;
>> +	u8 pending_ops;
>> +	unsigned long pending_start_page;
>> +	unsigned long pending_last_page;
>> +	uint32_t attr_flags;
>> +	ktime_t validate_timestamp;
>> +};
>> +
>> +static inline struct amdgpu_svm_range *
>> +to_amdgpu_svm_range(struct drm_gpusvm_range *range)
>> +{
>> +	return container_of(range, struct amdgpu_svm_range, base);
>> +}
>> +
>> +static inline void
>> +amdgpu_svm_range_invalidate_gpu_mapping(struct amdgpu_svm_range *range)
>> +{
>> +	WRITE_ONCE(range->gpu_mapped, false);
>> +}
>> +
>> +#define AMDGPU_SVM_RANGE_DEBUG(r__, op__)                                      \
>> +	AMDGPU_SVM_TRACE("%s: pasid=%u, gpusvm=%p, mapped=%d, "                \
>> +			 "seqno=%lu, range: [0x%lx-0x%lx]-"                    \
>> +			 "0x%lx\n",                                            \
>> +			 (op__), to_amdgpu_svm((r__)->base.gpusvm)->vm->pasid, \
>> +			 (r__)->base.gpusvm, READ_ONCE((r__)->gpu_mapped),     \
>> +			 (r__)->base.pages.notifier_seq,                       \
>> +			 drm_gpusvm_range_start(&(r__)->base) >> PAGE_SHIFT,   \
>> +			 drm_gpusvm_range_end(&(r__)->base) >> PAGE_SHIFT,     \
>> +			 (drm_gpusvm_range_end(&(r__)->base) -                 \
>> +			  drm_gpusvm_range_start(&(r__)->base)) >> PAGE_SHIFT)
> 
> Clear NAK. Make that a proper trace point and don't clutter the system log with such stuff.

Will drop it, but actually this just mirror what XE_SVM does in xe_svm.c:90:

#define range_debug(r__, operation__)					\
	vm_dbg(&range_to_vm(&(r__)->base)->xe->drm,			\
	       "%s: asid=%u, gpusvm=%p, vram=%d,%d, seqno=%lu, " \
	       "start=0x%014lx, end=0x%014lx, size=%lu",		\
	       (operation__), range_to_vm(&(r__)->base)->usm.asid,	\
	       (r__)->base.gpusvm,					\
	       xe_svm_range_in_vram((r__)) ? 1 : 0,			\
	       xe_svm_range_has_vram_binding((r__)) ? 1 : 0,		\
	       (r__)->base.pages.notifier_seq,				\
	       xe_svm_range_start((r__)), xe_svm_range_end((r__)),	\
	       xe_svm_range_size((r__)))

> 
>> +
>> +enum amdgpu_svm_range_op {
>> +	AMDGPU_SVM_RANGE_OP_NONE    = 0,
>> +	AMDGPU_SVM_RANGE_OP_UNMAP   = BIT(0),
>> +};
>> +
>> +struct amdgpu_svm_range_op_ctx {
>> +	struct amdgpu_svm_range *range;
>> +	unsigned long start_page;
>> +	unsigned long last_page;
>> +	uint8_t pending_ops;
>> +};
>> +
>> +#define UNMAP_WORK(ops)		((ops) & AMDGPU_SVM_RANGE_OP_UNMAP)
> 

Will drop it.

> What's that?
> 
> Christian
> 
>> +
>> +void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm);
>> +
>> +uint64_t amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
>> +					 const struct amdgpu_svm_attrs *attrs,
>> +					 bool read_only,
>> +					 enum drm_interconnect_protocol proto);
>> +int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm,
>> +				struct drm_exec *exec,
>> +				bool intr);
>> +bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
>> +				  struct amdgpu_svm_range *range);
>> +bool amdgpu_svm_range_is_valid(struct amdgpu_svm *svm,
>> +			       struct amdgpu_svm_range *range,
>> +			       const struct amdgpu_svm_attrs *attrs);
>> +int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
>> +				      struct amdgpu_svm_range *range,
>> +				      const struct amdgpu_svm_attrs *attrs,
>> +				      bool read_only,
>> +				      bool flush_tlb, bool wait,
>> +				      struct dma_fence **fence);
>> +int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
>> +				    struct amdgpu_svm_range *range,
>> +				    const struct amdgpu_svm_attrs *attrs,
>> +				    bool read_only,
>> +				    bool intr, bool wait,
>> +				    bool flush_tlb);
>> +bool amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm,
>> +				     struct list_head *work_list,
>> +				     struct amdgpu_svm_range_op_ctx *op_ctx);
>> +void amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
>> +				      struct amdgpu_svm_range *range);
>> +void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
>> +			     struct amdgpu_svm_range *range,
>> +			     struct drm_gpusvm_ctx *ctx);
>> +int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
>> +			       const struct amdgpu_svm_attrs *attrs,
>> +			       unsigned long start, unsigned long end);
>> +int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
>> +					 unsigned long start_page,
>> +					 unsigned long last_page);
>> +int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
>> +			      struct amdgpu_svm_range *range,
>> +			      unsigned long start_page,
>> +			      unsigned long last_page);
>> +void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
>> +			    struct drm_gpusvm_range *range);
>> +void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
>> +				 struct drm_gpusvm_notifier *notifier,
>> +				 const struct mmu_notifier_range *mmu_range,
>> +				 struct drm_gpusvm_range *first,
>> +				 uint64_t adj_start, uint64_t adj_end);
>> +bool amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
>> +					   struct drm_gpusvm_range *range,
>> +					   const struct mmu_notifier_range *mmu_range);
>> +struct amdgpu_svm_range *
>> +amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
>> +				unsigned long gpuva_start, unsigned long gpuva_end,
>> +				struct drm_gpusvm_ctx *ctx);
>> +int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
>> +			       struct drm_gpusvm_range *range,
>> +			       struct drm_gpusvm_ctx *ctx);
>> +
>> +#endif /* __AMDGPU_SVM_RANGE_H__ */
> 

