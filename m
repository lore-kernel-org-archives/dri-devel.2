Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A826CD98D6
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3FC10F53B;
	Fri, 12 Jun 2026 14:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ezwPk28S";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3E910EA53;
 Fri, 12 Jun 2026 14:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH8OyWDk+XtlSP71itlFKOsDgKexwodFWNMCtGgauruYsv3sBeu1TzdC7EIaZHqDeNvf9xLNdD1xHGIsgU96AGm/0J948OvTlO+T2NuoxgV0SBVcK8ZXJG7c/Y8oIE9bjqZm5ThAxdQyBCYkSHuW6yyRngba788xna9WIoTZTusxLvVHX1Wg7LKlvhKdfts2e1JzbKq57atQ/HjPrnYpm6P0xPvUQgFYGaZDux2VmfFza+JKHAc60TkS3QgetS3AVL+8osw2juJEzQMSYxqLPl+Zn0m5AIf0ZZ/hmFWfSIVncwmm5MzFkmv7rK98NMRhx8HDo/BCqLsMZ3DO1kIRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2YyawoS85KETQow29a8ZYO7QrM1Pv4nmeY43qUUFkw=;
 b=ojwxOGRLcsHeEHdrjotMVshDppP06hwB4gFtEgFpIplfVA4sKbD9K3ifpwdq1Wt5btHHQih+9sPRLvh3lHj6/F7AXRDixlhhXTALx/I+pFu9OMpscKOGKPi0ZR1Bku/YZeU/FSwt7WQYbVDOdAcqdjIdhlK8OLOcUcK+9bJ6ORnBh/P7ego1+kmR1dSS45Lft+dCOGVUBUNXkb36OpevbLzfxBFoQx+EKPMcGN42bO4PVVboNqaUveuVs2sEvmAUnEv2bNDYbMbosCZu9wAusbEHqh34htTdInC+6rmni/4HWFSCRhMdzG8oWj0ZLM8kbvQ5EWeIOpqEL6l+x525Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2YyawoS85KETQow29a8ZYO7QrM1Pv4nmeY43qUUFkw=;
 b=ezwPk28SLT4Mpyl6xHuaDx2EgYreO0MFWi1RzNijppxDXDWH68xk8552KNxDOpqmiGeqiJGfLrPuSktdHRTNOi1SPNqmGAyMbrmInV06oO3aRx2451uDf7Z5ibVKU0+x251WpckjTSjImIUB/IvzYsZNNKVBN5942hBdJraHkaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 14:26:58 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 14:26:58 +0000
Message-ID: <70bd2f07-957f-4235-b9ce-e5be55f4fa78@amd.com>
Date: Fri, 12 Jun 2026 22:26:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/18] drm/amdgpu: implement SVM attribute tree and
 helper functions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-5-ray.huang@amd.com>
 <e9d48794-ac52-47f9-a9d5-4e6e11d6e0cb@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <e9d48794-ac52-47f9-a9d5-4e6e11d6e0cb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 04729314-512a-40ab-cba0-08dec88ea8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: XY1WNC2B8x0+azPKb4FAXsIteGVbOazF2VFEgHUPHwPWWMQ5MRFo4kxbLP1VvdkPya3o6U2BNW5eQotAgEGD8am87KgzNJYeEXLIlUetZ52KeWqmoEioAMl8iDLTJleOUEi6JZvZzTfr+tzeo+tQaGpx6I2Wl+r6NSe4c6BY4ad37TiYU3/tsHiZutHBvPynS/KD1G4/M6X36EbG1oRJWyb/WrR+XpNeIHTdyydNRqA5NNdf2KITkpegMngvANxpbMY1kS+7RgZRAfqbkVGTs3ekXS1IGFnDl5a8HBsqZUMOtSwpNBhXo3inENpXJY6ReBkGFlReIjB8eodR9YC5d7tN3Fy9r3K28oRXJG9DQmM1cOc7EdMJmnAbFyBtPlHNTiHUqb8GRIccE7fn9r/fP/IaMqv4LjwEq3V434wDlJbc00tORlV3jay1MXsn/nGXZoe/3Cibx7s4MzqqQkzdhJihyFW0wLtCf7iGJmCnOS+Vw2zlzFNSDMJH5RLm038lIDuQ1HRVFNiZLJ1hav+d2QJYin5mms0T+A7IH+GSAUClCVmsJQvNeuMn0th1SwW5KlW3g7hVydZE75VvECwtZzz+aTNCs1hT4unR+2wJqNqUC0KNN+KWzM5h4hIBnAujVBQyCYaF5jcpLKF2GGZEPRY4sAgAI/sfEj53VI869ZA0HhyG66TgjR7ZLs2yoiVh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(3023799007)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVE1OWgvRDVtTXRBS1dZVXNMcHgzMG15eFRLVlBOaEx5SktKaXBDT1lTaHIw?=
 =?utf-8?B?U3NDeDZQRHBNb0tVWFFrZ3JUYnJGTkt4cmhHUEpHRCtSSy81MGlKUS9lbVdq?=
 =?utf-8?B?OXRzRHRjTXBOTDdiVHU0V3R4dWI4RXM2RVhPQ3FaZWVqdStzWTBBZ0xVamMw?=
 =?utf-8?B?ZHN6ZHh3eUlhTGVzZVFZd3ZYUDJEUE1TbmIrV1h3WW1yaDhIdHY3TjdZWlR6?=
 =?utf-8?B?SlpCMzFTbUUrSVI1MGIxZ1Z1dTkxVStvVHkwM0tDejBZUUc0NWVmTEpkd1F2?=
 =?utf-8?B?VjBpWWRvUkhSZHJjUVQrS0U2K1VYdnJXSUhreE9IRm0rSUtlT0MrRndudFZJ?=
 =?utf-8?B?WWRyaDhndkdubHBGM3UzWnVQM2lCeUZVQis5RFZhM2RiWG1BZktCZ3hWQXJt?=
 =?utf-8?B?OVFhTVFTc2liTGd0c1NXRmlVY0FnK0hlcVN4cXdxNkNXYVA0czhDM3BIanNG?=
 =?utf-8?B?a2NPYTM3WjdWelBSNmVOREpRa0ZZN2tTWnN5OTlBZDdnS3hFUjQ2UXljM3lT?=
 =?utf-8?B?ZzFtTTBBbVpUbERhYkdnRHdXVU91ZkhwMmpWcEY5ZWFPZGZGR050NGJQUDEr?=
 =?utf-8?B?Tmh1d3FOZmZMK0VaYXhtd2N5MFFJN3pzeENYQzdoaEoxc3JYNHVnNnlXK2p6?=
 =?utf-8?B?VERIKzNaallKTnJmYmF6OTNabzVGWmJWb2J6aE5OQ3poSnJIT20zWkpIelgy?=
 =?utf-8?B?KzRMM0NJNUJidVNMeVc4VWlhTlZKUm42cTJydnJmNmxmcUt5b0RtNkNLa09L?=
 =?utf-8?B?WHVmNDJRbWdERDVLWThQZ1p6RGtwcnZkRSszUG5mVjk4OHh2cDV1ckVzMlA4?=
 =?utf-8?B?KzJCc2EzS3NVMVpiQVNuVW9CdDNDUXErdm1zZUZrTm1FdGlCTHlkUVhLa3hr?=
 =?utf-8?B?T3d3d3A0N1Z1M01zb2tGTXlQVW1UVm5HN0hWQmwwV3VVZTdUUnNYNWpvRXFw?=
 =?utf-8?B?anIwWU9MZFV3TURhQVNGaytBTUlpbS9RYVlhVUVpaUNEblRxb2lYMTJqL0Y5?=
 =?utf-8?B?RlVGcmxZMUJOcE9HcFE4Ulo3dk1aUSs3NkRIc29MMkNTOXRwS1ptYjRXMyt1?=
 =?utf-8?B?RHcwM0tIb2JmWFFqZUhXa2ZFem5oNHV5RmtTb09sckM2cEViVFFIZXp6bFln?=
 =?utf-8?B?dlZYaWJTWkxnRnJ6WXA0anNRTjRmMUl5dDg1V0NRTXl5ZEQ3QklndGY0MHlo?=
 =?utf-8?B?alliOGtTMWNBYXM1M3RoTFpaN0JIQTZjTTE4ekd6MjJuWVpGL0hDdFlMbEN0?=
 =?utf-8?B?bHo0eVdoTEczVXFYdmZJRjRHMUMxWXRzN0NaK3FWczUrMEN4dWZ4ZWFDWmNC?=
 =?utf-8?B?aUEzL21TUzcyb1BSRWtjS0pERytFcUs1MW95cW01MXhXeS9uWmlCeUhvK29P?=
 =?utf-8?B?WW40Tit6WHFiWHZsN0psd2orL1EvUms5SlhlQzFxMlkwS3lrNWhaK0taM1hx?=
 =?utf-8?B?bmdBejdXbkJuU2FXSnBCRUpqeHQ2VTNOamJPK2Y5TmQwNlpQTWZBT2wyZlkw?=
 =?utf-8?B?YlRmYWN1VmVxZlZCajlIWFBOMFU4UEFMaHBmclNPT1JNMnl4akhTTE5BTVhQ?=
 =?utf-8?B?ZWpicG4zYW5HazUxYTJpWDMxNldESVQzeTFnL1g3Q01zYzZQNUZWejV4Tmdh?=
 =?utf-8?B?dERPNkV1aDgxOEFpeXQ1a3BPSW5HRzZOZHphZlhDOXZsVWFQb0lvVm12R3B3?=
 =?utf-8?B?RHJWdHJjdzQrYnYvcTBqQTNRZzZvRW5TdUI5VDgvMU0yekdFTVExUjlBUG9O?=
 =?utf-8?B?ZXpQdzJNRWpLUzgybnorVG0yaUU1STlBekNoa2Q3SnFuQTArZjAxL3Yyakk5?=
 =?utf-8?B?NERPUEZjbTZ2a0dVbGZmWlpldUUvWm1TQU9yd0FwVE0zT2d0bFgxbHpqS1dQ?=
 =?utf-8?B?dFBhZklQYTNQNnp1ZHBxSmlwQkZJSDVDL3A1NzFSR2hiWGltZU9lckFqNWdM?=
 =?utf-8?B?NjlYUzN2RmVXdm5QcW4zOVdPZGhVZUZQeE5aeHVDODYvWDR6aUJvRFk4a2xB?=
 =?utf-8?B?a3BFU21kd3VSN3JhRlg1NWdKRndBN2JkdGNuaVlxa01neVdvSmJiRWxtbm1H?=
 =?utf-8?B?K3RyY1pvSEZqK1gzcHBIZnBVY3FWWFowZGJZZ214eGo4U1R1SktIRElpb0dp?=
 =?utf-8?B?S3dJK1hoNm5MajkzWnBDZlFNa2UvcmY1ckRrazlUZEEwUW9wNGR0OUcyV04x?=
 =?utf-8?B?bmswc1pxVEFlSlhRTzJmNlh6ZmRoMmgvT0FOenlmM0ZZM1piMGo3MmZlREhn?=
 =?utf-8?B?SzlNeS90Y2xCUEozM0NUdTBsZ1V5MHcrQ1djQ3N2MzlNWkdLYkN5ZVVlNTF0?=
 =?utf-8?Q?YyXw0+6t9soSsmMQ2V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04729314-512a-40ab-cba0-08dec88ea8bf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 14:26:58.0695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uc5klp5CE55m5GM2ouP6dwzZpbbkBzx9eSE2ViXLzy2HQfV+stzELDNNLUkgIxePk/l/CtyH/+Fx7bs10TjEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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



On 6/12/2026 8:07 PM, Christian König wrote:
> On 6/12/26 11:09, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Implement attribute tree foundations in amdgpu_svm_attr.c:
>> - Slab cache management: amdgpu_svm_attr_cache_init/fini
> 
> That's superflous as far as I can see. Why is not simply kmalloc used?

Got it will use kmalloc instead of slab cache.>
>> - Default attribute initialization: amdgpu_svm_attr_set_default
>> - Device memory and VRAM preference helpers
>> - VMA validity checker: amdgpu_svm_check_vma
>> - Attribute equality comparison: attr_equal
>> - Interval tree CRUD operations: find, get_bounds,
>>    alloc, insert, and remove
>> - attr_set_interval helper for range boundary updates
> 
> You need to squash that patch together with the one who adds the header.

Got it will fix.

> 
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 234 +++++++++++++++++++
>>   1 file changed, 234 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>> new file mode 100644
>> index 0000000000000..ba09aa3c3fe4d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>> @@ -0,0 +1,234 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
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
>> +#include "amdgpu_svm.h"
>> +#include "amdgpu_svm_attr.h"
>> +#include "amdgpu.h"
>> +
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/gfp.h>
>> +#include <linux/lockdep.h>
>> +#include <linux/minmax.h>
>> +#include <linux/mm.h>
>> +#include <linux/slab.h>
>> +
>> +static struct kmem_cache *amdgpu_svm_attr_range_cache;
>> +
>> +struct attr_set_ctx {
>> +	struct amdgpu_svm_attrs old_attrs;
>> +	struct amdgpu_svm_attrs new_attrs;
>> +	unsigned long start_page;
>> +	unsigned long last_page;
>> +};
>> +
>> +struct attr_get_ctx {
>> +	int32_t preferred_loc;
>> +	int32_t prefetch_loc;
>> +	enum amdgpu_ioctl_svm_access access;
>> +	uint32_t granularity;
>> +	uint32_t flags_and;
>> +	bool has_range;
>> +};
>> +
>> +bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs)
>> +{
>> +	if (attrs->preferred_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
>> +	    attrs->preferred_loc != AMDGPU_SVM_LOCATION_SYSMEM)
>> +		return true;
>> +
>> +	if (attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
>> +	    attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
>> +					unsigned long addr)
>> +{
>> +	const unsigned long flags = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
> 
> That needs a better name.
> 
>> +	struct vm_area_struct *vma = vma_lookup(mm, addr);
>> +
>> +	if (!vma)
>> +		return ERR_PTR(-EFAULT);
>> +
>> +	if (vma->vm_flags & flags)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	return vma;
>> +}
>> +
>> +int amdgpu_svm_attr_cache_init(void)
>> +{
>> +	amdgpu_svm_attr_range_cache = AMDGPU_SVM_KMEM_CACHE_CREATE(
>> +				"amdgpu_svm_attr_range_cache", struct amdgpu_svm_attr_range);
>> +	if (!amdgpu_svm_attr_range_cache)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +void amdgpu_svm_attr_cache_fini(void)
>> +{
>> +	AMDGPU_SVM_KMEM_CACHE_DESTROY(amdgpu_svm_attr_range_cache);
>> +}
>> +
>> +static void attr_set_interval(struct amdgpu_svm_attr_range *range,
>> +				unsigned long start_page,
>> +				unsigned long last_page)
>> +{
>> +	range->it_node.start = start_page;
>> +	range->it_node.last = last_page;
>> +}
>> +
>> +void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
>> +				 struct amdgpu_svm_attrs *attrs)
>> +{
>> +	attrs->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
>> +	attrs->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
>> +	attrs->granularity = svm->default_granularity;
>> +	attrs->flags = AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_COHERENT;
>> +	attrs->access = svm->xnack_enabled ?
>> +		AMDGPU_SVM_ACCESS_ALLOW_MIGRATE : AMDGPU_SVM_ACCESS_INACCESSIBLE;
>> +}
>> +
>> +struct amdgpu_svm_attr_range *
>> +amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
>> +			   unsigned long page)
>> +{
>> +	struct interval_tree_node *node;
>> +
>> +	node = interval_tree_iter_first(&attr_tree->tree, page, page);
>> +	if (node)
>> +		return container_of(node, struct amdgpu_svm_attr_range, it_node);
>> +
>> +	return NULL;
>> +}
>> +
>> +struct amdgpu_svm_attr_range *
>> +amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
>> +				  unsigned long page,
>> +				  unsigned long *start_page,
>> +				  unsigned long *last_page)
>> +{
>> +	struct amdgpu_svm_attr_range *attr_range;
>> +	struct interval_tree_node *node;
>> +	struct rb_node *rb;
>> +
>> +	attr_range = amdgpu_svm_attr_find_locked(attr_tree, page);
>> +	if (attr_range) {
>> +		*start_page = amdgpu_svm_attr_start_page(attr_range);
>> +		*last_page = amdgpu_svm_attr_last_page(attr_range);
>> +		return attr_range;
>> +	}
>> +
>> +	*start_page = 0;
>> +	*last_page = ULONG_MAX;
>> +
>> +	if (page == ULONG_MAX)
>> +		return NULL;
>> +
>> +	node = interval_tree_iter_first(&attr_tree->tree, page + 1, ULONG_MAX);
>> +	if (node) {
>> +		if (node->start > page)
>> +			*last_page = node->start - 1;
>> +
>> +		rb = rb_prev(&node->rb);
>> +		if (rb) {
>> +			node = container_of(rb, struct interval_tree_node, rb);
>> +			if (node->last < page)
>> +				*start_page = node->last + 1;
>> +		}
>> +	} else {
>> +		rb = rb_last(&attr_tree->tree.rb_root);
>> +
>> +		if (rb) {
>> +			node = container_of(rb, struct interval_tree_node, rb);
>> +			if (node->last < page)
>> +				*start_page = node->last + 1;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static bool attr_equal(const struct amdgpu_svm_attrs *a,
>> +				 const struct amdgpu_svm_attrs *b)
>> +{
>> +	return a->flags == b->flags &&
>> +	       a->preferred_loc == b->preferred_loc &&
>> +	       a->prefetch_loc == b->prefetch_loc &&
>> +		       a->granularity == b->granularity &&
>> +		       a->access == b->access;
>> +}
>> +
>> +struct amdgpu_svm_attr_range *
>> +amdgpu_svm_attr_range_alloc(unsigned long start_page,
>> +			   unsigned long last_page,
>> +			   const struct amdgpu_svm_attrs *attrs)
>> +{
>> +	struct amdgpu_svm_attr_range *range;
>> +
>> +	range = kmem_cache_zalloc(amdgpu_svm_attr_range_cache, GFP_KERNEL);
>> +	if (!range)
>> +		return NULL;
>> +
>> +	INIT_LIST_HEAD(&range->list);
>> +	attr_set_interval(range, start_page, last_page);
>> +	range->attrs = *attrs;
>> +	return range;
>> +}
>> +
>> +void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
>> +					 struct amdgpu_svm_attr_range *range)
>> +{
>> +	struct interval_tree_node *node;
>> +	struct amdgpu_svm_attr_range *next;
>> +
>> +	lockdep_assert_held(&attr_tree->lock);
>> +
>> +	node = interval_tree_iter_first(&attr_tree->tree, amdgpu_svm_attr_start_page(range),
>> +					ULONG_MAX);
>> +	if (node) {
>> +		next = container_of(node, struct amdgpu_svm_attr_range, it_node);
>> +		list_add_tail(&range->list, &next->list);
>> +	} else {
>> +		list_add_tail(&range->list, &attr_tree->range_list);
>> +	}
>> +
>> +	interval_tree_insert(&range->it_node, &attr_tree->tree);
>> +}
>> +
>> +static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
>> +					  struct amdgpu_svm_attr_range *range,
>> +					  bool free_range)
>> +{
>> +	lockdep_assert_held(&attr_tree->lock);
>> +
>> +	interval_tree_remove(&range->it_node, &attr_tree->tree);
>> +	list_del_init(&range->list);
>> +	if (free_range)
>> +		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
>> +}
> 

