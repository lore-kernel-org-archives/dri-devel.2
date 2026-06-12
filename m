Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E368CD98D8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A365310F4DC;
	Fri, 12 Jun 2026 13:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yYmVUFVH";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B37C210E929;
 Fri, 12 Jun 2026 13:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxJRaEgCPMUmxmLsdXQm5qyoVAci26UUzmij59rigExBR9Mj3sdx1cwFFtamSLr97G+Aqa2SRAdMsDs4f9cs4YijZn8mLpvPlt96XJ9v0UgtE9NhN0SzC8TFCtdAQ96Mo0J8C8IxD8pdFyWvLOCveWL+/XnytOdzgRiJUVGYh5wAkZUKNSioAcOonrQR92aEatoRGMwGYqhkI5qeGut71TUv1AUmjaNcVpY3Rq4BpH38MvRKF6OGbqJ1Nd5urJaIuBOyzFzu1K+Sz6nhbWHixJJ62Ag12VWJS9kK1FLXt19aZwzg6mvonbEVYJCgwWBOzRn/Cj1+tE61SWvusfNotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8QUqtYABVpzMUZ1z8BBJP26pWKJ4FwutEBucfCuLmo=;
 b=ExOiuPubbAEDNuXv+f+f8cU7DpSqDKNYuMfOI28GpVDsSccaZi0+OGhK4DtOTBeDOrfYrJmcqZaM61YPGI9R3VqTvlOx9kUV0/yQfl6YGwCkjEsRQrbsM715XDs5Opr5GO2gZyMO2EyeAJKaqgctP5EWJhI+MA6woS7N8ZYsdw3f9FbZBrfUMnV9T2wcMX7yTIFEwdSes1UFGniKnwokuwhbJ/dgZR/5eaH7KBhXlT5qgCK/1g9xQJTVsouHJdRQFGEz8EFh7eSatSjd2ZkH9W/TrwRAXso3R4tgB6eC7Vqvhf/g0MrDNap8klkykQNvjo7+v7N6TgjhfewBhjMpxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8QUqtYABVpzMUZ1z8BBJP26pWKJ4FwutEBucfCuLmo=;
 b=yYmVUFVHla9pA9RNBHuw86A0YjRU9Vkf3TO4Lr4WdtikNatIxiH3K+vvcUDNiHcusD9a1uOrICnl5NEC/W8wS6s/Q3gITUA7cu7BVmgAT4yl/KDXILQUQ0QI2U5kl/oo5/QcWb0XKmVyZrd7xT+IiD+/XWZlJcumCXOBb5a23+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 13:20:31 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 13:20:30 +0000
Message-ID: <03e6e547-3c03-446e-91e7-da5b043344ea@amd.com>
Date: Fri, 12 Jun 2026 21:20:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM
 integration
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
 <20260612090928.29682-3-ray.huang@amd.com>
 <889e580d-5ecc-4bed-b1b1-a5693692cf79@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <889e580d-5ecc-4bed-b1b1-a5693692cf79@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::11) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 39923dac-a594-4def-9389-08dec8855ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|3023799007|11063799006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: K+sw90VC93w7uNLdChJpXyOhpSUpl0EQ6kbl3CSm+nv6lzWOAqEuZMWK1vjGLvmu3JRfUHZ107N0YxHqIpMOCFruKP+WNL39k0FnFlA/lcErS+3bsNjvhfgPphi6f7/ocqvmlJ10jUL/nZscAvMQ8AHV0UmAduIeKYBAcqkUhoY2U+H9WW5k5QY/+Z/vDhytRXjcRy+kf0AQ4dVRCtfp4TL/D7aezhG4qzx0JAX2j6z+uKvRn9FzmIWQh/y1XBMHIUxdXMH7Snlx2riFbbIDymTr7ZLyg7AruAtPYYxRqj+POJnJ6BEg4MnmjgS4uoBoyo9L+ChyTEeFQcX+GJWEseSJKlZVWfLZhNzwBV6axuPxY4SzowkiyTM9x/5ytLBk8aetq2/5YlsC7HNkoy37E6+valX7F1IQ6gpvvZjkryl+skAhLY+13tLIKE0GV55yYERX5gm07nf9rjucCKKWC/PT2n4dia71XM/Nhq/TbwWxR7BwfTD1oLty8qA58LvuM33TLpkkHVkC3LaebRljs2wVUXAQ/ASolEzJWPT30zb4bc3L3IS1nFW7itkMLz2GhrIlt3F+VPpdM+pHkmlqZfKzHz2mRlHWU+J4UAZuedbzdtscjCw20IABtdCgK5NbAX7uSb6hMfGKeLK1Gz1Z72JGHuPcsUPbry+IP9gUpS7RhzkbG6W2HtVEyUtDG94k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJkUHhpZGxOa2R0cWY0M04rWkdzYzU3WWI2TUJab2NIR1B2YnB2c0dZcjUw?=
 =?utf-8?B?cDdnSnhYdG1zMUJnOU9hSW1Za1FPSDFJZEpUNktEMnc3aytaazZaaFFkTVJt?=
 =?utf-8?B?U0lHbkxIUGZ3bkxhR0dlRkgwMGhHK3RGTDZGM1dwSWo5eDNSS1dhaVJyUTd0?=
 =?utf-8?B?QVRvZDdWd3FWNHl4dlF6UlpZUVEzNGlGWS9sVmc0a3Z1K0ROKzVIT004ZnM4?=
 =?utf-8?B?dUVjV1lVcnNOYXUxM0NHS1l6WGlSeHpDNGlXNjJhbmJLZ2hGWks0cTIrNHlN?=
 =?utf-8?B?Sm9QYTBPcWkrdDVPZGJzOHNHQjAwTHoxNU40Q2RNS0dZZC9pazFEQlp1THFH?=
 =?utf-8?B?WCtwd2ZZTzlmYU44U3d1U3Zkb1ZHV055QlZWRjljMlh3anlKbmhmZnRObFcx?=
 =?utf-8?B?QktnNnZhWjJ3Ky9xUExNbWF3STZjb3MzZlp6WERKdGFwdStaNkREQ1loanl2?=
 =?utf-8?B?V1ZNWjNXeXZSZlVVNHVpWDQ1Q3ZPbkkzSU5MVlFTS3pWUjM4UTZYQlM0UGdS?=
 =?utf-8?B?Yk9GWUNJSlU3dld4U2cwOUZRajNJRmRpSkFZaytLUGI0eHVMem5BNS9mTnp5?=
 =?utf-8?B?eXJZQzJQdE55Tks3U3hFOFBvT2c3c0FFbHRSRmQ5cm4vdGpmNXhXalU1N3F3?=
 =?utf-8?B?eEtWREtMWFRCRE1QVVVHNFowNStEYkZmR3FhVjByditqeHIvNXBsL1hUTHRJ?=
 =?utf-8?B?citJLy8xdmE0UFdmeGRiNkpiNmZjZCtrUE1pbUw1cVd5ZXc5N29KMllackU5?=
 =?utf-8?B?Uldyai9VZ0FlNHIzSWVrRkVabzVPWTNiVjZidFdya2RuUTFmS2Y1NDlDUGt6?=
 =?utf-8?B?d3Q0TFV5NUM0dVJSTmJlOVhaemJXNzZaYzNEOExEdWI4Mlg2cVpFWFpubEV3?=
 =?utf-8?B?eXlTbDdOTVBLQlArckpvNDd0cnoza1ZQWWJmL21QbkhkY3NRMnlDa2hveW1C?=
 =?utf-8?B?cjBJTThYWWFodXc0ZmtkSnJqTG5ydzRFc010MTN0MVZ3alVlWk1ET09JSG5v?=
 =?utf-8?B?c0QwTlBULzE4UDlwYkJXcHRCeXZma0ZEUTRiYlFRWXJqV0xucmRUckhtSFNu?=
 =?utf-8?B?ZCtxUHNVMTcxSVQrVFlnUkpGK1ZsclppelhvMHBLK1FuSVVFZkRZYXFFSk9S?=
 =?utf-8?B?Yko2RWU1S21IS2M1TDhtZFZ0TkZCUVc4RSs2UWVRUTl2UTZrMXZ5TjczNUo2?=
 =?utf-8?B?R0RQWDlnRVZQMU1YYjQ1RWN0L1FjeWQ2OXFJSCtmQXE3NnJRVStCVy93aVJi?=
 =?utf-8?B?d0JqdWt6T3NPOVJUTkpYanZwWDRIZk1WUlE2Z2lrazBZZ0FhcmxsSkd5SHpK?=
 =?utf-8?B?aWgzNExvbmZBaWFVSGcxQkhRNitzWDRVVUlnVlNwOWFpdHJlTVpoUDRqNmhN?=
 =?utf-8?B?eTYwTVcxRzZtU2NRdGVZN2pPOGNjdTFBaWovY0JYckFXVE95cVY1U2xFLys2?=
 =?utf-8?B?cWNoSmIyR1VkM3hMaEJsa2MwZzNQbEVVRGlXZ3ErYXpoQUtKYVNmb0l2N3Fj?=
 =?utf-8?B?MEV1b3UxOHAvNE52QnBlN0N3ZTJTdDlaRHJ3WU1NN0FiSmE1WXJFQVgxUXMw?=
 =?utf-8?B?eFM2Rk1wS21UWUwrRzJvcElFSU1NMDRKWUxoZnpqY04xOS8rRHovTGphcVVu?=
 =?utf-8?B?RVdhYWNtNDE3T2hFZzV3VVgyc0VUV042ZG9JT1NvWmZQNlEyeDNITFVXbDVX?=
 =?utf-8?B?R2RZL0JWY3JxUkhkMnJ1aHR0blZSSUIrb1k3eTVQVEwvVi9lWnRsamsxTElG?=
 =?utf-8?B?STRyS2dGZllmWjFKMEx6dVovdElHKzNsdDVnNlZPYXVtUDJJMkxGMjh2bXc2?=
 =?utf-8?B?TW1vYUI4bWFBQitLb1lXNjY5Y3BGeG11b1ljcVJlay96aWRSVE1oRmo1blVK?=
 =?utf-8?B?emxsTnQ5TitYcDNmWjFkRXdaQnVzYzZ1a09YRHhhZk1VUmlManRkRHNEdWd3?=
 =?utf-8?B?a0JCNVRDNGs0UlRneHRKYW0yMmt2dlpYSW90cEh3RmVBSUhkaVRlVFMzZEVn?=
 =?utf-8?B?YndkNXhIaU9Bd21KTHhPMFBQcUlsOUxmN21sVk1KdGdjVEllUkptQlhBdnVr?=
 =?utf-8?B?ZWVkKzRueVJBRnN2K2tWbEV3YkpOc1RnTVNzU0VGcjQzMXluckJyZE1nTFFv?=
 =?utf-8?B?djkwMmdFWHdTbklXblNsWTlONWcwNjcvYk5aek9Rbkt3Q0F2aWJUSnozcWRx?=
 =?utf-8?B?R25yNFZ1blp3VW4rTzBmd0E5QkdpK1VBdDZjdVpRclNaT0x6ZFF4TmJPOGgx?=
 =?utf-8?B?SnViWFZMNEp6VUtPcGY5Ri9qQ3dHU0R1eVVkOU1ROENYSHBJbnJPTXRoT3Qy?=
 =?utf-8?B?N2pUc1BMTVlQMUJtbFRrQkhjODNSRXA0ckdoWnVqWlg5TDZ1ZGNnZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39923dac-a594-4def-9389-08dec8855ffe
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:20:30.3831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiEnw2xcIXDd7lyM8RaCVXsXUvqE/hD0fpvkv+U3l10WIZF+w4D63cPumJVctD4nwnnJNv0NJGyKBnvZdj8pAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
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



On 6/12/2026 8:02 PM, Christian König wrote:
> On 6/12/26 11:09, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Add amdgpu_svm.h with SVM data structures and public API:
>> - enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
>> - struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
>>    attribute tree, rw_semaphore, GC workqueue, xnack state.
>> - struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
>> - Debug/trace macros: AMDGPU_SVM_TRACE, AMDGPU_SVM_WARN, AMDGPU_SVM_ERR
>> - Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
>> - Locking helpers: amdgpu_svm_lock/unlock/assert_locked
>> - Public API declarations (including clean_queue, sync_work)
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 196 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
>>   2 files changed, 200 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> new file mode 100644
>> index 0000000000000..9884a1f834d67
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> @@ -0,0 +1,196 @@
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
>> +#define AMDGPU_SVM_TRACE(fmt, ...) \
>> +	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
>> +
>> +#define AMDGPU_SVM_WARN(fmt, ...) \
>> +	pr_warn("%s: " fmt, __func__, ##__VA_ARGS__)
>> +
>> +#define AMDGPU_SVM_ERR(fmt, ...) \
>> +	pr_err("%s: " fmt, __func__, ##__VA_ARGS__)
>> +
> 
> 
>> +#define AMDGPU_SVM_KMEM_CACHE_CREATE(name, type) \
>> +	kmem_cache_create((name), sizeof(type), 0, 0, NULL)
>> +
>> +#define AMDGPU_SVM_KMEM_CACHE_DESTROY(cache) \
>> +	do { \
>> +		if ((cache) != NULL) { \
>> +			kmem_cache_destroy((cache)); \
>> +			(cache) = NULL; \
>> +		} \
>> +	} while (0)
> 
> Please completely drop that, this is mid layering.
> 
> If the kmem_cache is necessary use the functions directly.

Got it will dop it.>
>> +
>> +#define amdgpu_svm_assert_in_notifier(svm__) \
>> +	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
>> +
>> +struct amdgpu_svm_gc {
>> +	struct workqueue_struct *wq;
>> +	struct list_head list;
>> +	struct work_struct work;
>> +};
>> +
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
>> +	void (*flush_tlb)(struct amdgpu_svm *svm);
> 
> Why do we have a callback for this here? Amdgpu already has abstraction for flushing TLBs.

Got it, will drop the callback.


> 
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
> What exactly is that lock protecting?
> 

this lock is the driver_svm_lock required by the drm_gpusvm framework
It is registered by drm_gpusvm_driver_set_lock(), and drm_gpusvm lockdep 
asserts it on every structural entry point, e.g.
drm_gpusvm_range_find_or_insert() / drm_gpusvm_range_remove().

Per amdgpu_svm it serializes the write/commit side against the fault
handler: range/notifier tree insert+remove, attribute changes, and the
garbage collector.

This is the same thing xe does, in drivers/gpu/drm/xe/xe_svm.c:

drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);



> Christian.
> 
>> +
>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>> +int amdgpu_svm_cache_init(void);
>> +void amdgpu_svm_cache_fini(void);
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
>> +static inline int amdgpu_svm_cache_init(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void amdgpu_svm_cache_fini(void)
>> +{
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
>> index cc096c005e348..9e6a668e8567e 100644
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
>> @@ -448,6 +449,9 @@ struct amdgpu_vm {
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

