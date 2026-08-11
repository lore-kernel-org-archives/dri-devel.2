Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76104C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 883AB10EC14;
	Tue, 11 Aug 2026 14:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X5TgAvvB";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA2910EBCD;
 Tue, 11 Aug 2026 14:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQD8nRrxHW8CsUfo0Nmu9utRLIc2si8EFRmWra+KXo/LG1fx8k/XUO0OF8jKIs8MD/0ap5SXFLw1t22+lO+ZlHrAtJGssTUZ03v/0Iow0BZVPNYP3ZTlafJnvM5HRQ4tNOR9aYk6oLOoh5ibqndtW1NVozKKwyLShc73vVTbmzIXX932dkxS1Rcw1Rc+eamsdvM+hUDh7YMWbvELL4VrdpoTYMScMBJ6Zqqh4TMpD+cruLOSq/CyomtSyK4DzldoLDfU/Ib6Eny/xZbA0etiQVcP7l941GTqX5lH27EjoJMj6sBwnagKQGTCbGlgVgwzIa0woKiKnMNzGYXynRwhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wTc/LisGMCOEsDECxzI6e04Jl930SbnKy4E8gQ7GLU=;
 b=LI0Xj4njfVoNvypyDoc0Ie7MjvfrSL8Ot8CpeB/wVLOBCSyfE5tNl75q4UJ4D7A15JHww4FuHpIJ1TpoOWQ67b85Stm1xmCFUCfXavFOkVmkuGpO2Ssi8pDPczcDylyxWEW77tIyQd9Iswi6XLz7DoJ9vYQ+4RwZeYkbUauPdOHxxdPBJHEUIGJlc+YgzP8d5lZhiRvRYOyxkDosaN19hwUzP2pIXqV+hMkGa9s9w9XLvSVcRv11a0qU6NmZHhtxrJVoB3FEZ9AZHNaeF9cvt82lQWcXUa6miJRraZB6W6vkHEs8tzXR/KXthHaakg4F9JBhdJZS5uqEosssIBM1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wTc/LisGMCOEsDECxzI6e04Jl930SbnKy4E8gQ7GLU=;
 b=X5TgAvvBBjlJfGavhbtS880RtdSnOiTiLPrKZRhl3PaK8o/DHKh8IDerH+AymNL1rZppgfxHtnN362PHYy9lzSjeu+RzmvjTVTJdwhJQGA5ox4Hfb0q/CDnxk6cd8aClj5cFdB8tMUldRs8jhbQjSW/7b6uB32TojwqGtFnfrZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 14:06:43 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 14:06:42 +0000
Message-ID: <b12d31fb-f9f2-4e09-a0fe-21f2d6bb7999@amd.com>
Date: Tue, 11 Aug 2026 22:06:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260804094246.1719318-1-ray.huang@amd.com>
 <20260804094246.1719318-3-ray.huang@amd.com>
 <ee51e993-705e-496e-89f4-c5d0196c8951@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <ee51e993-705e-496e-89f4-c5d0196c8951@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d3f960-c875-42f7-ad53-08def7b1c53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|4143699003|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MsQTpw3P+gpwYhsClla+FRN4SkTAZkY43zVwgvEdcXMihARgk/7hSCMvC898jUd6l64D2CKG39E/PGHaZnc7J71wisCXY64/xF3/sK5ZeaM9eEeh+yQacJoM/6DlWo+9AhuT/bauhyQah4M8wRZqWXiKLs7ma4YrQ/3BhQoci5hm8g8Kg2QBJg5BFtE8tuPMp01q32q5Xoe28zNoLcVE1c5LLXJfbNqG3P7PoqnirN5zOX/jiHrEL/pEHOrVlXJAR+VAVTQprjzf1mBVRtE3xXLMqrT3TaoHlC6eVGAqKWdGl1z6SU5kjT8dLjwx5KE7dztn8SH8DNlaFS2RNCWH4rK0syTADnntFP1UzvEmL0+o7VgSbuowM70CZ6RYVW2SY5EDhA1a7Y3iid9l6ZVvlC3g59aZb03pFu/p0UYof052ChPiCS10v4G+dA6FojJalEa5UHF8jheJeQQiTzCWR/X5oiz03TxbDw7EIgUD6gON6/p1y9PRFAMpx4hz7K3pJb3aqpEWPgnZHQuUFrqp6VFjvhwVEv6lxL+kHYsCt2RdE8wvmjW9AsMWicMhkrtVtfxpnNTtnpeZh6CBUJ0zIFnfIbD0MKYz/+6sH8ND5QltwxW/AT4jTE5caIDr66dCFZsLBiWC+3c4GHxu+f+Pn85V7mZm665NoA72g73E8GA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VSNDZleXJITnk4YU1ySUx4dFVXRUhaRjVxN2k1ZVZ5UjR2MlRWeS91cjRm?=
 =?utf-8?B?a2VxMmhNMnUwTnJaQmZIOEZCU1J0OFRHWWNueS9LKzBSNlJWbC9Eam81OURX?=
 =?utf-8?B?aGR4Z2E1Mzh1aWVTTE53VzVGcFJGL1c4aHptWWp1dXhuSEJIUll4UWxhOUZH?=
 =?utf-8?B?eTU4QUpWMk5uejBFejFGS3VzWkZoK1NEOWQ5dkp5MkN1MitOUTJvdWRNdEl4?=
 =?utf-8?B?c1o5M21IaW9pUERYbEF2RnVsanZoWUlaa0x3Y3NPeDFDK0pGbWlZNUhKeDR6?=
 =?utf-8?B?dlAvdUo3VlBFNXMzVFZjYmhLYVpJWllpRzJXRmtjUlpwK0NCQkczbFh0WW9j?=
 =?utf-8?B?SXV3MHViWWpkcVA0dEFFQ1NHcjF5UHA1enJjMERyd3JTdjEzUHFkd0wwRVY3?=
 =?utf-8?B?MUpsRi8wdHB6K3UwK0h0ZkgzMWpRQkg2czFzbU9VRnUrYTgyNkdoejJBNHo5?=
 =?utf-8?B?STlBNE4zSVdtd0xnaFI1UExudjlmZU96RGtBalRkYlpZRTFEZXdQbVlhOHhW?=
 =?utf-8?B?SFd4Slhudm1SN3drVjUxRTBTcFFOenk2V0VmQUFTNHVMNVFkZ290RmRLQnJD?=
 =?utf-8?B?RTFjdnVYNXppeHBXM0RFdFNBTDdRQ3BuRE4yQmYzTXlMOFc0QmJ4RHF1TzRy?=
 =?utf-8?B?Ump2dXJmV1BWbVJYbnhKOUMyVFNQSzlSb3FvNjc0TUtnZXNodWVVU1VxWUVj?=
 =?utf-8?B?T095ckY5UHBieno4UUtpOFgzeHAzQkptNXlsK1VZSklNdHQ0cS85VVh2dS9C?=
 =?utf-8?B?dStNS2tTWStaUVRjOHQ5ZnJCVGRvQzRSVUxsTXVjM092blFaWTJKaHZlajlM?=
 =?utf-8?B?bEYzOTZjRE52amM1bkxMZCtoRjlHemVIb0VYVnBja2NOZTNQYktLNUk2UU9V?=
 =?utf-8?B?QzB5STdlYmNEdjdBVjZMU0c2Z2R6dk45MEwxaGZzRzZxbEQzbTBNWGRqenlm?=
 =?utf-8?B?MDQzRE9XWmpONmFQNDFZNlAxamhTUjFXT3doWDVwQzZ4eTE4eC9ucWduM0Rs?=
 =?utf-8?B?WXQxZDQxQ2xISVg1QSs5T2RQYTlNSEphblV0S1J4VDdaVTdtSjlqSTkrRVY1?=
 =?utf-8?B?YmNVVGozcTNnR1RSUW55R0JrSFZtSnJQaDdwZXlHUEFkVW9oWkVMKzZaVks0?=
 =?utf-8?B?dnF4ZEdsRmc2eXdic3o4U3gyb0EvSm1sZmUyUkFMYVJQUlY1d2RyOUZOOW5z?=
 =?utf-8?B?OFBCcmFnL2hNTGhXdTZ0L1JRem53aUJFNVI0dmVaYmxyU0tyM1JSZ2tIRnJ4?=
 =?utf-8?B?emdoMTRwNDRhTmVjWU5xb2tKeW5RaHF1WFJUL1hJWS9DZnpSQ2lTOVV2ZlNj?=
 =?utf-8?B?K1IzZGZscW01eWRyRERyS2dLUmtobnptUklLZjlvTFA2ZjRURkx0eHZVNTJk?=
 =?utf-8?B?NWNqRHhQOW9GYVJENXpnMUN5VERtVXE1L08yN3ZueDdvdFh5Vm5vY1FQUHFp?=
 =?utf-8?B?ZytmaU5jVDBmNUxqUU9TMklRdDhWeEFVUUREb3dUM200dUJtMlVTMndLVGRE?=
 =?utf-8?B?Um1ZcVBOVGQreTBBQWFmMzlrTHpqdlJJN095Lzh2Nm1xRElXT0VZOXdsc0J1?=
 =?utf-8?B?dXY1ajlJTzhWUVVNWnhObkQ4eEdPQTE2bi9qRm4zZmY1RkNXd0NIT1V6WlZn?=
 =?utf-8?B?aG5QS2kxbnhBeXUvWEtSeG5hVjFva1pKYkJiL2dtM2diZGZ3eGJoQVo2bzh6?=
 =?utf-8?B?dHFSWEl6WTJtSThBVkJnbkw3Z3BVL3ZYQmpSTkxGLy9aaWJqZEh4SzArQ211?=
 =?utf-8?B?dGpXc09LMUNXc3BRMURxdU5wYStkNGIwcDgzWGQ4MUN4WTZncUJOQUhZUjBK?=
 =?utf-8?B?eW5GNWU0VjN1a1pCcHJkWUR0QWFSYWV5bVVjSTdxalo0NEZKUFJ5VTUzd0Mr?=
 =?utf-8?B?TVh5bjJCWVVyRk8xa1FXRG1uTlVhL01FSDZCVUJEMm1kRUpiQUtqS2FNOW5M?=
 =?utf-8?B?TjEzMGw1RmgzWlFUTW54NjRiT3FhWjArSkhyVGpsZ2k0UkRYWnZPellCaFJ3?=
 =?utf-8?B?MEZKOEVxSXdpV0ZLd3NsbGd0WDFwR3lXbEpESHVzSy9mZTlaZTNQZE4vQnMr?=
 =?utf-8?B?cFh0U2pTNGlQZXh0SGZFRUFYeGJxWTJNTm9KS25pZ1U5SzlNQXVhQlpkT2pv?=
 =?utf-8?B?eERJOTlDZG9Vb2UyaUpPZGhjL1pRWDNaR3F5Q1FHZmFyU2pmRjNqS29wb0d2?=
 =?utf-8?B?T1R1Q0hab3ZVUkNoTTY4eXBHNllZbXVSaTlmZ2VhWXZ4UVMwZVhGZkUzNGdT?=
 =?utf-8?B?M2c5VkdsaWNWL1Y5NHU1T2d5aEs0MmpidDJCMmFINmdsR2FMMUhUajUrSEJM?=
 =?utf-8?Q?lvh3HtsNgXyt6MSe/F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d3f960-c875-42f7-ad53-08def7b1c53a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:06:42.8180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOjw9NGsclPfKs6atFoKAlZ44tzPlrLLG711hlx3sVxr7eKPn53BXi2/LXC53O+jRQi6Nzl40awPHihTE2JPfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
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



On 8/11/2026 7:02 PM, Christian König wrote:
> 
> 
> On 8/4/26 11:42, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add amdgpu_svm.h with SVM data structures and public API:
>> - enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
>> - struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
>>    attribute tree, rw_semaphore, GC workqueue, xnack state.
>> - struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
> 
>> - Debug/trace macros: AMDGPU_SVM_TRACE, AMDGPU_SVM_WARN, AMDGPU_SVM_ERR
> 
> Please drop those, use pr_debug/warn/err directly in the code.

will drop it.

> 
>> - Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY

will remove this commit message.

> 
> Those where already dropped.
> 
>> - Locking helpers: amdgpu_svm_lock/unlock/assert_locked
>> - Public API declarations (including clean_queue, sync_work)
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 204 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
>>   2 files changed, 208 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> new file mode 100644
>> index 0000000000000..f3b4f228405c2
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> @@ -0,0 +1,204 @@
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
>> +#define AMDGPU_SVM_DBG(fmt, ...) \
>> +	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
>> +
>> +#define AMDGPU_SVM_WARN(fmt, ...) \
>> +	pr_warn("%s: " fmt, __func__, ##__VA_ARGS__)
>> +
>> +#define AMDGPU_SVM_ERR(fmt, ...) \
>> +	pr_err("%s: " fmt, __func__, ##__VA_ARGS__)
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
>> +	u8 default_granularity;
>> +	bool xnack_enabled;
>> +	void (*invalidate_ranges)(struct amdgpu_svm *svm,
>> +				  struct drm_gpusvm_notifier *notifier,
>> +				  const struct mmu_notifier_range *mmu_range,
>> +				  struct drm_gpusvm_range *first,
>> +				  uint64_t adj_start, uint64_t adj_end);
>> +};
>> +
>> +static inline struct amdgpu_svm *to_amdgpu_svm(struct drm_gpusvm *gpusvm)
>> +{
>> +	return container_of(gpusvm, struct amdgpu_svm, gpusvm);
>> +}
>> +
> 
> 
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
> 
> I'm starting to repeat myself, so once more: This stuff doesn't work like that!
> 
> The lock the SVM subsystem uses to serialize updates *must* be the amdgpu_vm->eviction_lock and *not* a separate one.
> 
> So clear NAK to having this functions here.


I have explained why eviction lock can not be used as svm lock in V8, 
previous version. And it seems like we have a big gap about it.

The eviction lock can not be used for svm lcok.

And the design of svm lock is the core locking design of drmsvm frame 
work, without this desgin, this framework lost its soul. So I have to 
explain how to use this lock.

I believe we are talking about two different locks. You may treat svm 
lock as notifier lock. drm_gpusvm has two of them, and the "no 
allocation while held in the MMU notifier" rule applies
to the other one, not to driver_svm_lock.

1) drm_gpusvm has two distinct locks: drivers/gpu/drm/drm_gpusvm.c

   - notifier_lock: safeguards the notifier's range RB tree and list, as
     well as the range's DMA mappings and sequence number. ... This lock
     corresponds to the driver->update lock mentioned in
     Documentation/mm/hmm.rst."

   - driver_svm_lock: In addition to the locking mentioned above, the
     driver should implement a lock to safeguard core GPU SVM function
     calls that modify state, such as drm_gpusvm_range_find_or_insert and
     drm_gpusvm_range_remove.

   Two locks, two jobs.

2) The lock held in the MMU notifier is notifier_lock, never driver_svm_lock

   drm_gpusvm_notifier_invalidate():
         down_write(&gpusvm->notifier_lock);
         ...
         gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);

   The driver invalidate callback runs under notifier_lock only. Per the
   framework's own notifier example it just unmaps pages
   and queues the range to the garbage collector no allocation, and it
   does not take driver_svm_lock:

         drm_gpusvm_range_unmap_pages(...);
         drm_gpusvm_range_set_unmapped(...);
         driver_garbage_collector_add(...);

3) driver_svm_lock is by design an allocating, process context lock

   drm_gpusvm_range_find_or_insert() asserts it and then allocates under it:

         drm_gpusvm_range_find_or_insert():
                 drm_gpusvm_driver_lock_held(gpusvm);
                 ...
                 range = drm_gpusvm_range_alloc(...);
                 ... mmu_interval_notifier_insert(), kzalloc

   drm_gpusvm_range_remove() asserts it and frees. This is only safe
   because driver_svm_lock is a sleepable, reclaim friendly lock that is
   never taken from the MMU notifier. Reference counting
    handles range *lifetime*, but it does not
   serialize tree insert/remove, which is exactly why the framework still
   asserts driver_svm_lock on those two entry points regardless of refcount.

Now the three concrete points:

A) Why the primary driver_svm_lock is required

   It is a framework requirement, not an amdgpu invention:
    - DOC: Locking says the driver "should implement" it.
    - drm_gpusvm lockdep-asserts it on every structural entry:
      drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove() both
      call drm_gpusvm_driver_lock_held().
    - The reference fault handler holds it across the whole fault:
      GC -> find_or_insert -> migrate -> get_pages -> bind.

   Xe does exactly this:
    - xe_svm.c:      drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
    - xe_pagefault.c: down_write(&vm->lock); before dispatching the fault
    - __xe_svm_handle_pagefault(): lockdep_assert_held_write(&vm->lock);
      held across GC / find_or_insert / alloc_vram / get_pages / rebind
    - xe_svm_garbage_collector(): lockdep_assert_held_write(&vm->lock);

   amdgpu's svm_lock is the same driver_svm_lock, used the same way.

B) Why eviction_lock cannot be that lock

 > This lock eviction_lock can only be grabbed while updating the 
mapping range.

   and that is precisely why it cannot be driver_svm_lock.
   driver_svm_lock must wrap find_or_insert, migration, and
   drm_gpusvm_range_get_pages
   eviction_lock is the opposite by contract:

    - It is taken with memalloc_noreclaim_save() in
      amdgpu_vm_begin_critical(), specifically so no reclaim happens while
      held (to avoid the reclaim -> MMU-notifier deadlock). Holding it
      across get_pages/migration breaks that.
    - TTM eviction try-locks it: amdgpu_vm_evictable() does
      scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) and
      sets vm->evicting. Long holds starve eviction.
    - It is a plain mutex that the SVM map path re-enters:
      amdgpu_svm_range_update_mapping() -> amdgpu_vm_map_range() ->
      amdgpu_vm_begin_critical() -> mutex_lock(&vm->eviction_lock). If
      eviction_lock were also the outer SVM lock, this is a self-deadlock.

   In short, eviction_lock has the contract of notifier_lock , not of
   driver_svm_lock. This is also why the current split is correct:
   svm_lock (outer) != eviction_lock (inner). Your own rule - "you can't
   call the VM code with the lock held, the VM code must take it itself" -
   is satisfied today only because they are separate: svm_lock is held
   while calling amdgpu_vm_map_range(), and amdgpu_vm_map_range() takes
   eviction_lock itself. Merging them is what would violate that rule.

 > No, they Xe vm->lock and eviction_lock are actually identical in the 
handling.

   They are not. Xe's vm->lock is a rw_semaphore, the "outer most lock" of
   the VM , held down_write across the whole fault. amdgpu's
   eviction_lock is a mutex taken only inside amdgpu_vm_begin_critical()
   during a PT update, under memalloc_noreclaim. Xe's eviction/reclaim
   handling is separate from vm->lock. The amdgpu analogue of Xe's vm->lock
   is svm_lock, not eviction_lock.

C) Reusing an existing amdgpu_vm lock as the primary lock needs refactor 
amdgpu VM

   Xe can register vm->lock because Xe's VM was designed with an outer
   rw_semaphore held across faults. amdgpu_vm has no such lock: only
   eviction_lock , the root PD dma_resv , and a few spinlocks.

   So do it like Xe means introducing a dedicated, outer, sleepable VM
   lock held across the fault. That lock is exactly svm_lock. Folding it
   into struct amdgpu_vm as a general vm->lock is a core amdgpu VM 
refactor.

Regards,
Honglei


> 
> Regards,
> Christian.
> 
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
>> index ec1196d390bb7..30463a83e2e60 100644
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
>> @@ -373,6 +374,9 @@ struct amdgpu_vm {
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

