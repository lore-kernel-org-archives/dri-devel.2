Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F32606BD74
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2Ta14VdF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E4D110E933;
	Tue, 10 Nov 2026 06:44:59 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8BA10E927;
 Tue, 10 Nov 2026 06:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZiL2JUXnKD7KV5S2kKoTUmCjKyvG+coHSCpghkhJTpjXobYd/chBz40ei6Wg7KTRtjlKHPLOlpy6CFqauhuJKqDv6sHKzbUw7+WVG5NRr91sSPzmNzkggl+5TQV7FUm5Evh8hBWvM92+lNvdxm4/CXUx0e5Fsoz47D1TsHCd0Zrt0924LjwRcoFQDMDsWE4EVFqu7f4XBbFS0mQ1fFFD56LwJsnujMI91m7e/eqi2A6s+IkxqeIJdzfzFgQrZo6c5/DgUPgPhXed59PJl0hmX1iXxk6tKxCofEfCRYrSfgT4mILiQuRNbBmhC/xVH8VCOgYw2kM2u2F/1FXHLhkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zpl/iygIhTP8PqxB+T2w3PV+OqHUKL6vt61U6DNXr8=;
 b=RK79MnyB4GIFRANjGEWput1YltzqeOnW1Dr39i46kj2yHjCGRJuBDbr1i4Emwu6PIRHL0Z4LbIWgnCo4b9N//WzSweDg6rYiS1ICbhGPfg57GGhT3AHmuzhbVgbJyC8NSBcpLOP71RxXNM/m8tmEFsY5yls7e8mDq7WIJtC7VasulhN+gBdn8B4gRsnypaIZY1TWZQm4ViB3zeAYgL1XLxjt6KEJd2ZZM7o3HcQ0HGkUCVlJZ/eSPgIRqN+nNnpmgwdz3zGlXUZ0ddII+zny4e/zRTW5lhWEe7rJm4XGB7nWFx1oN/lcwLAvfSyi3gM5c1ePaacRsknOmTaRKT8joQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zpl/iygIhTP8PqxB+T2w3PV+OqHUKL6vt61U6DNXr8=;
 b=2Ta14VdFXfbyOPW893SVOuO4jmGmmTvdTxQRAyknfdbhKW4eRM5jkM1yb8O1kKBbxAfnJTWVgVa91m6Wdw6Mn/2umEG7Ip38sOZ3b0FVfGltAnhd5/Nxd5tSbHooCoiH96sPytYzod4f7nVZQBplRMWRlZ+edpWXvIpARRjn/yg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 06:44:50 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 06:44:49 +0000
Message-ID: <d40e50fb-72ef-4e20-bbd9-cf501b5ae127@amd.com>
Date: Tue, 10 Nov 2026 14:44:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/22] drm/amdgpu: add SVM range types and work queue
 interface
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-6-ray.huang@amd.com>
 <61071713-6f3f-494d-99bd-0d11adef1543@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <61071713-6f3f-494d-99bd-0d11adef1543@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6448dc-36c4-4bfd-27ef-08df3ef61e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007|10067099003|261102123227099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261022115727099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: AE7MNKLydbm9gj7f56hWgTdElrnu9PAbyGnfbifyvb59n6m8uh6SbzWTqXtsF6jo24T8yaaYZ95ocnYsX3pZVIKfzP6YHUIXUUVXsbdJe/HQwhybiZLAESrPfNIdpFIRIEOGgt4//6Pe1beV4T+GaTF1a1o/rR+hBuZ+s6FPrQNwsB0nXmeq2pXeqn7McQJ8pFzfl2UPsSmx8jcV2ImB6QCGlu8XfbS+8LfK0D/9npQND0JzZoH5zGTc7UOGLLGfuWoK4PjLlMijMeqLq9zvEdsJiRngEegZIt0XKmKPxYzGVj09MEQ2VwJjADPlwHqJ7z2Ufd7JqXd4hMFecMvednhVZBn6vuFQ79x+SC0ugU+F7JtL30fbyDiBfMa0uD/tpeKzmhOE3tQzDRZE2sscdCejI7dYKOHLcaJ/rDSno2DSIS2DT8xcawgGv/XqWPNs2hfKeOkzvRGAElrbZO8rFTaVjBIBjWJs8YgnDgFDf9lMFqyIa3yNX1CiqYs71X5nRiTJ1/wYDwKnvAb6wU6Ya/ru1iIfNHgKWbQoK2idqTp04eIxM6tspPtkYY5rJtdmkVe5rDJubA6REvJltuRl8ajdZD6IRmWGPgHyg6sEU6cx1TCiZPNoLQzj6Ycu+ISijeS24lmn4RzbYGdvEmrIfeKnrcaQ09OFGUJTofxPpzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007)(10067099003)(261102123227099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022115727099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujgzbm9Pc0s3VDVSQnJlVVNHUE9ZRndiMGlGTzl4aDEza1ZmS3ovcDdST01a?=
 =?utf-8?B?c1V0S0ZSMzhGc2NBTFBtZjgwaVJ2enBZdTRyY1RvNzFFa3NWTDVtSEVCUGJG?=
 =?utf-8?B?WGYrTmkzaFhZNGZtZDNZdEkyaE54LzhtbFcyc3BUM3h0V05xb2JqRHcwdk9r?=
 =?utf-8?B?OVJ0cHZuNVYxNnRVRktzcHpXYWJyQUovaS93WUdkTFdkd3BwdGtTMDBkcm1w?=
 =?utf-8?B?SnRVNzExYk9vUEJKdGdLYkg3MVZDc25yMFJUOWZlTUZEUmlIZDJ6YmVaTHhY?=
 =?utf-8?B?amIzTndtVVhmSXpJN0hnUWNHVjBacHowT2pBTGdBbU1pd1VXdHZoT2szUmJH?=
 =?utf-8?B?Uml1T1dyQzRJZjN2ZGxCbGFMOVVLOWhpZ2h5TGZDOURXaEFsSTAvTFVqeXYr?=
 =?utf-8?B?MHlEcVZFV21tZ0xUVjJaMTNkS2lSNGRCaFhrUHR2MzVneXVkZjJJMXFQZ0N5?=
 =?utf-8?B?WFFKZ0dONW85KytGeXZISzYwTlVrRWpSRmhRTllFeGxCZlVmVy9IQ3E5SG9L?=
 =?utf-8?B?bHFONE85ZGVZSVNHRFphZnVPRnB3di94RmpRTyt0ZllxMHozQnI0cmpyeEw4?=
 =?utf-8?B?MGtreklXKzNhRDllOTRnMVhESFljVExIcWY1dkVTQVNyU0RUcWtaMENLcXJh?=
 =?utf-8?B?Q2tUbXV4TVZ5Y0cyZlBWTW5ZUXZEdWZRZHZESytRRzA5MUVYN2k1dTdHV3hH?=
 =?utf-8?B?N1RGMW56NkpwRklKT3ZFU25pY2kza3dyL1FNVTcwV0FBUFpna2l5NkNzVXU1?=
 =?utf-8?B?RXhYUzd3TUl5QzJuanRPdDVkOXZEblVoZFR0WVZSNEM1dXA2Z0RCWGF3Zi9N?=
 =?utf-8?B?eFVSM1Bhd3VZWkFWV3ZyY21pSEJ6bFJFRjVjaURwQ2tDU3pRWE91ZmxRd0c0?=
 =?utf-8?B?alpBRnRJTG1BZlRZcVFxbTFac3pSK1NVN3l2dzJmaXVrNU82TWZGdXFjU2o0?=
 =?utf-8?B?U2pOaStPYlgvL25jUVQ2Mk4vT095MUtVRVhkcWhhdkhZTGk1bEZQekx0dlZr?=
 =?utf-8?B?cWYvdmJkK0N0SFhDcm9QeitPa0hJLzdmbTVJL09SNEo4WHdLdmFuZ3U3cE14?=
 =?utf-8?B?MEtwUFNFbC9kYnlWdHNGSm4yUDVzRzFlREdBOGg3U25IcW8rV0NnYlRCN0xy?=
 =?utf-8?B?OGVaYXQ5TitoTE5KWnUyWDIxQ0NHcktpdFp2Q3hDa1VUbUF6RlhVdG9BRUt2?=
 =?utf-8?B?WkEzazU1R0hRRkhYUlpRdzJYNXZwdW1CdTl0ZjJxQ0EveVF3eE9EUUlYZ2k2?=
 =?utf-8?B?N3Y4cGR4dGI4TWVYWVoveU1TMWx2UDM4VFNjOUNWTHZpSXRnODZoWFZYYmVt?=
 =?utf-8?B?OVFFS3BLamQrcTEvRmcvSEFldlNxaVVKczd1U3ZxNDM3WVhQUTR4a0ZISG5z?=
 =?utf-8?B?ZVRPZldpTmRJNUZjQ3o0bEFSc3lBcnVuQ3RrcFErWThMek01VVMwRXdJc2R3?=
 =?utf-8?B?ZkVEY0U1a2N3dzFZVXBSdzludDlhbWdYdnBFSzgvU0xSYmJKSXY5ZmZBczFF?=
 =?utf-8?B?VTUzaTBhUVBSdkNrL1JjN0hFZUZxVm1RTUloQURUb2RsUDBaeTg1VVVpaWd1?=
 =?utf-8?B?UUZPYVZRdWV2dUxzTCtVT05QY3NKdjVGamR1VEtMRi9LVnl3djJDT0NuOFZw?=
 =?utf-8?B?dkwwQ2ZwSURLMDJOT2pFdFc2QkNka2tHT3pidE9kc3Zha1hrYkFUWWdxcmQ5?=
 =?utf-8?B?MmJYMWhVYUNzRlVhU2ROYUl3QUlRRjJQK1BndU0waHZxTVk2UFdGd0NDcU04?=
 =?utf-8?B?WFhZYzR5QzlTTENISERQbHlZQzR3WXZWdDY3WWdaZ2lLUUozK1EvNU52UFhW?=
 =?utf-8?B?djhzaWNaNGtZSkZpWDlCQ1ZYNTkrNW9TSzVmMStrSHNnRzFCU1ZwVVV2ZmNJ?=
 =?utf-8?B?QnhUTHFINHZYRHE1UEFnOVVzekJJa2ZwbU5sbVh0eWVEZk5VUWZkNHE0Rmtv?=
 =?utf-8?B?Zmlud2pDS3YrdlFTeDJCUlNNcVV4VkpTRThqV2xmait5Q3hDTUMyOUdtZ1h0?=
 =?utf-8?B?VW95SHBkOEgreEVURE15NUNtNjhaRnVRSmRsUDY5VEp6SURyMFpUdC9EMFJw?=
 =?utf-8?B?SUhKMkFoeXFJdDQwU0pOQWJwV21vQ2Jsb3R1SC81Q3VkSUwvU0JqSllFUUgr?=
 =?utf-8?B?dERDMnZxaUc2MDJ3THA0NlY5VHNFTHU3VG5zV2NnekU2aDdFZGpDY2tQaVdz?=
 =?utf-8?B?NHZNS0tJcEp4QzcrTmlad3VzanB4allmWnkvUzVDZmhPL0NTMlFKNDBmQWdj?=
 =?utf-8?B?c0sxdWdiUE1ydGM5QUVNZWdMUncrMVQ0enZEUEJybmlkSXVKb1NzNkFCWHI2?=
 =?utf-8?Q?LQGenPZW5bUFCR9ogx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6448dc-36c4-4bfd-27ef-08df3ef61e07
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 06:44:49.9129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEM78OgpGxL2pSxCbXZ/F3ut1LGoXR1NdgfplCrv0D/cOc9mJaT3pgixm5H6SY40EMGEqybV86eGrKr4OAVf8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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



On 11/9/2026 9:48 PM, Christian König wrote:
> On 10/21/26 04:58, Huang Rui wrote:
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
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 129 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |  30 ++++
>>   2 files changed, 159 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>> new file mode 100644
>> index 0000000000000..39db3a18b5f2f
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>> @@ -0,0 +1,129 @@
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
>> +/**
>> + * enum amdgpu_svm_range_queue_state - Work queue state of an SVM range
>> + * @AMDGPU_SVM_RANGE_NOT_QUEUED: Not on any work list.
>> + * @AMDGPU_SVM_RANGE_IN_GC: Queued on the GC list.
>> + * @AMDGPU_SVM_RANGE_PROCESSING: Being processed in workqueue.
>> + */
>> +enum amdgpu_svm_range_queue_state {
>> +	AMDGPU_SVM_RANGE_NOT_QUEUED = 0,
>> +	AMDGPU_SVM_RANGE_IN_GC,
>> +	AMDGPU_SVM_RANGE_PROCESSING,
>> +};
>> +
>> +/**
>> + * struct amdgpu_svm_range - amdgpu GPU mapped SVM range
>> + * @base: Embedded drm_gpusvm_range base.
>> + * @work_node: Links the range into the work list. Protected by amdgpu_svm.work_lock.
>> + * @gpu_mapped: True while the range has a live GPU mapping. Accessed with
>> + *              READ_ONCE/WRITE_ONCE.
>> + * @queue_state: Current work queue state @amdgpu_svm_range_queue_state.
>> + *               Protected by amdgpu_svm.work_lock.
>> + * @pending_ops: Pending amdgpu_svm_range_op bitmask. Protected by work_lock.
>> + * @pending_start_page: First page of the accumulated pending interval.
>> + * @pending_last_page: Last page of the accumulated pending interval.
>> + * @attr_flags: Attribute flags last applied to the GPU mapping.
>> + * @validate_timestamp: Time of the last successful mapping validation.
>> + */
>> +struct amdgpu_svm_range {
>> +	struct drm_gpusvm_range base;
>> +	struct list_head work_node;
>> +	bool gpu_mapped;
> 
>> +	u8 queue_state;
> 
> What is that good for and why is it needed?

Previous SVM implemetation need pop the range task under mmap write lock 
to prevent the UAF. This is not allowed under drmsvm helper.
The current series use queue state to trace the range work op state and 
seralize the different op by using work_lock instead of mmap lock.

Regards,
Honglei

> 
> Regards,
> Christian.
> 
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
>> +#define AMDGPU_SVM_RANGE_TRACE(r__, op__)				    \
>> +	trace_amdgpu_svm_range((op__),					    \
>> +		to_amdgpu_svm((r__)->base.gpusvm)->vm->pasid,		    \
>> +		(r__)->base.gpusvm, READ_ONCE((r__)->gpu_mapped),	    \
>> +		(r__)->base.pages.notifier_seq,				    \
>> +		drm_gpusvm_range_start(&(r__)->base) >> PAGE_SHIFT,	    \
>> +		drm_gpusvm_range_end(&(r__)->base) >> PAGE_SHIFT)
>> +
>> +/**
>> + * enum amdgpu_svm_range_op - Pending operation bits for an SVM range
>> + * @AMDGPU_SVM_RANGE_OP_NONE: No pending operation.
>> + * @AMDGPU_SVM_RANGE_OP_UNMAP: Range needs to be unmapped/removed by the GC.
>> + */
>> +enum amdgpu_svm_range_op {
>> +	AMDGPU_SVM_RANGE_OP_NONE    = 0,
>> +	AMDGPU_SVM_RANGE_OP_UNMAP   = BIT(0),
>> +};
>> +
>> +/**
>> + * struct amdgpu_svm_range_op_ctx - context of a range workqueue operation
>> + * @range: The dequeued range to process.
>> + * @start_page: First page for workqueue operation.
>> + * @last_page: Last page for workqueue operation.
>> + * @pending_ops: amdgpu_svm_range_op bitmask.
>> + */
>> +struct amdgpu_svm_range_op_ctx {
>> +	struct amdgpu_svm_range *range;
>> +	unsigned long start_page;
>> +	unsigned long last_page;
>> +	uint8_t pending_ops;
>> +};
>> +
>> +#endif /* __AMDGPU_SVM_RANGE_H__ */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index 599c1d0e512b5..86ba09cba34c9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> @@ -116,6 +116,36 @@ TRACE_EVENT(amdgpu_iv,
>>   		      __entry->src_data[2], __entry->src_data[3])
>>   );
>>   
>> +TRACE_EVENT(amdgpu_svm_range,
>> +	    TP_PROTO(const char *op, u32 pasid, void *gpusvm, bool mapped,
>> +		     unsigned long seqno, unsigned long start_page,
>> +		     unsigned long end_page),
>> +	    TP_ARGS(op, pasid, gpusvm, mapped, seqno, start_page, end_page),
>> +	    TP_STRUCT__entry(
>> +			     __string(op, op)
>> +			     __field(u32, pasid)
>> +			     __field(void *, gpusvm)
>> +			     __field(bool, mapped)
>> +			     __field(unsigned long, seqno)
>> +			     __field(unsigned long, start_page)
>> +			     __field(unsigned long, end_page)
>> +			    ),
>> +	    TP_fast_assign(
>> +			   __assign_str(op);
>> +			   __entry->pasid = pasid;
>> +			   __entry->gpusvm = gpusvm;
>> +			   __entry->mapped = mapped;
>> +			   __entry->seqno = seqno;
>> +			   __entry->start_page = start_page;
>> +			   __entry->end_page = end_page;
>> +			   ),
>> +	    TP_printk("%s: pasid=%u gpusvm=%p mapped=%d seqno=%lu range=[0x%lx-0x%lx]-0x%lx",
>> +		      __get_str(op), __entry->pasid, __entry->gpusvm,
>> +		      __entry->mapped, __entry->seqno,
>> +		      __entry->start_page, __entry->end_page,
>> +		      __entry->end_page - __entry->start_page)
>> +);
>> +
>>   
>>   TRACE_EVENT(amdgpu_bo_create,
>>   	    TP_PROTO(struct amdgpu_bo *bo),
> 

