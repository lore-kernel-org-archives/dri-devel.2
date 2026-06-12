Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E693CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACD110F47E;
	Fri, 12 Jun 2026 12:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NTbJY20f";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963D610F476;
 Fri, 12 Jun 2026 12:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGHoOv9VGVLautAVfyJe9tCZmweRZK7VHBlT4Z5/G42VhO2OVJwPNzKWYwUu64xrkOT7FhjK77ZzW7HdUtIjvW+GFSbt2SWodbna7mEkktdKkiFkWL9te0ONpBx04ssN+cKr8PsuSPSizSHb3tOVkHX79YatMB5t1CG1SnhsmHJfTCA/Oncf7SyRYiaThcZaVRx8WLUGokBU5VOAGOXhodema2mx5HO0LE5e0TbtTp7L+u5WCHT+pGABdmTA4Y+me+zNA5XSpoutd23djrNeJjHtb6ZuVr01xNCq+qZ8RnfBmGutIPzPqzImvsHRbTEUO+tJH0PAhcBLHKGz7mq1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPOV+amv9PZt37DndOE+tctZ/2uG57c833eczIb2r2Y=;
 b=O7LP663l0o6rjIa49htv8HTNxvsceEv6KYhc77Jh/vwLS6z6cWktyeUgLxhxwCZodllg9dQEJqhJHt/IAHYHrEvXfgRzHY4/QSmUKKdMx7tVS9kGv8PqXOcbLSvGXOg8S//uZRMZobTIJXRDOeNjlQX+VEpGyYJpeJXmVGJ6HTjvT+Wr+gtlxaDDG8IMKbKYpeBv+xSuzR+QfISEFM7YZnNIH7SypY9J/4u3D5WGajJwsZfL7VrHsVPu7JOCT0coQywflbV+tKsmFt3LK/eVnqBYai+sDMHriywd8GUHLXpj4HlDTEnfVuo/SLKJa1cC/j8an2W4WjoIi/l+t0LTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPOV+amv9PZt37DndOE+tctZ/2uG57c833eczIb2r2Y=;
 b=NTbJY20ffSk7UYWfoODPd3QLLkxL/uCN2FYEsD1nXH5K5waYbzW7Uw1FW9w9rZ5Dfcgd7PJ3ATq8/qgdSoUfuRAleBe8E1DNGeDoIcvbN9z3pGZ89rwd85fSbVDhFFz5wAPo9b0LkKt3Zvo764Y9GLAPg5bO2o3A1KBOZDriKPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 12:02:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 12 Jun 2026
 12:02:11 +0000
Message-ID: <889e580d-5ecc-4bed-b1b1-a5693692cf79@amd.com>
Date: Fri, 12 Jun 2026 14:02:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-3-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612090928.29682-3-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: a0268506-faae-4b65-9340-08dec87a6f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|921020|4143699003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 61sWBHz5fKBUNL3BXqhbpaY5jfFv4jNd2bPPRWvUg6qa2fDgg7utOf0ZzdIGdnTwWMq8yAfEqdleYtKx5qjBxqXdeyiTBOYFmAd0bnQhGtEbZKyXp7KfmNJdaRtqJHJ1UmM98wOz2XMtx1yhbuFMCBUB2a1cl6/AgS8yiNk783DgXmmsAmANVYOAnLB6lO+zvPK9x1lvxd3X0HbmK+eXEfIADt/jNyzIY131YJ03/aA1LkP6VSRQThiotkB2KggmFpVmI8EC8yRklXCNOFPGnRNXtilAix1eLzl/G3EwdMRZLYKlq8aaH6sGovHckSjCWcwyYaAp44TGlQmPqpGjub2r4pdcKQAZTndpalcCB5gQGHCXFMmH3kS7PWbEbLuzJimrzluLS7Kuvf3W5B9uHgdn34qQhuWsta2Y4Une2nT43HnDq7boFfCF2OTcWPWEMxXf7mmlvnDT1cYm1kCAro2EiPYdL/O7ColR/rpVCRwHu+fdRr4bd3frmKpbQQ28SZEuqkoE/BprhQWCkxmjNlzbXzqLoQ7jigWNCFunmJqZIfxCSPUKVt8muKJlR8Zq5PXPOV6ucfFF1f3eBEX0W6zJN18HzpGPGEdmPW9rY3ptmJGDEyZjYlV2oeHkkr/Q9I7v6H/EtFP1Py9sFp1oUOp1LGLPnJWPpacnDZNXqqhZSIGGhxl9Pbfk2v6IlT79nRMSghufO2nDd4syDqJfV1puug0YXg4sp4jAJXi54X8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(921020)(4143699003)(56012099006)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azNDWVdTenp1R2J0U00zakptaTVjN2UyS29aamxPNFNOU0hsWXhnVEpCM3Bq?=
 =?utf-8?B?bEdVbVhIUXZaZkxRVEhIcWNIc2cwdmRYZ2pOdjlhK2xCZG5yWEkrSWYzTFU4?=
 =?utf-8?B?NERMNDMzSEFkVEgrT0NYODd1blIvUFovL2xMaU1Ma1hZOVJkYWhOd3dmUzBP?=
 =?utf-8?B?S0x4SWR2RmxwUzBUVUNoWnhxZ3JqZDBkQzNzdkRaaDlvVGFsbDhjQUN5Z1hp?=
 =?utf-8?B?aEw4enhQNzlpTm1kaWIxNmFuQ09sOGpWRURTNDB2czd5YUpBZERQR0R4WHBZ?=
 =?utf-8?B?T1RYamFkNlFRWW1namVLR1NGeEdqbjZiTndDM0pWYlZIdkN6Ujc5U3Z3SXFn?=
 =?utf-8?B?NlJpbWpGbjhTQUFGZzNyU0wwaCticmIwTUlWVzRtc1ViaVRqTmp6SVYyVXVV?=
 =?utf-8?B?RSs1bENvUEhXaVcwTEhRWmdSOWM5RExSajhVMEg4dERsUTRCc2E0cm5CQ1Ar?=
 =?utf-8?B?ell6ZG5YUTZDRzB2Q2hlOXBKcm1SSVdGaEZ1RzlJdzErTHg5TEpqZEh1bWhl?=
 =?utf-8?B?V2FadkdzT2xKSU5UZUJvQzRJcy9xS1pCOW1tNGpnWkV4R29sYStUU2tHTFQz?=
 =?utf-8?B?TkllNzhVWGsyNWdjNy9CRldRMjRYdHYxbjl0VmNOYmxVUjBjdkgwaS9DV0ZL?=
 =?utf-8?B?TUl2VGV2NkN6d2ord09SR3lmL3c2ZHpFekwyOGxzcUpTQnlwQ3JaaTI3ZW9k?=
 =?utf-8?B?eFYvWXcwYVpORG9WQ0VmVnZaS1NlanhyUUlNaC92c3pSTXUxbWVkRHhGMkFs?=
 =?utf-8?B?djFkYldOMHYwMFdEUXNsanVoNFdIUElEaVgxTFJCbW1WMXdFcXFodkpyV21Q?=
 =?utf-8?B?dG1INkdHSlVBQlpOc1krbFJSWkwycjgwUG5hQnJVT3ZvSXNDUjh0UWMvNHpZ?=
 =?utf-8?B?YkhEbW5HRWFDTmVOOWlEWFFnOEo3WDIvSUZ4aStWRlVaSGtneU9Pcnc2Ym9u?=
 =?utf-8?B?Mytpd2FjZGV6SGs4aCtmRGN5bXNWWlpBdnNMb0pqRzg5S1VGZlE2djN4T2du?=
 =?utf-8?B?RWk5SjJMNGNsamdZUkNZYzlYc1lLWnEzRkw2aWtGMjZnSjcvd0lHRnlHakpt?=
 =?utf-8?B?U21JMmxsK05qT24wSzBDblVjWGFZZUxOWEJFbm9HMEdTTzNoVDBNUUlRbnB0?=
 =?utf-8?B?OGJxUVMzOXM0YXMxTmFYMGdyUFZuZk1kNXF5N1c4RW15Vlhwc1RWNHpuajZn?=
 =?utf-8?B?eUMzbWMxVXlIVmZsWW9Bb1J2RWtEOGg3Yk9KVFB2OENpWWZzSjdGVFZiQ05C?=
 =?utf-8?B?cStZWFBwellFbVB4N1RnMmxTL0JZME5IbkdjdEFFZDVQSko0SDc3M2x6dXlQ?=
 =?utf-8?B?NlYybEE5cDRRbHZWSVdDeUFnaVJsSDk0VTZ1cDFRalNiU1hWNnVNb05MSzJr?=
 =?utf-8?B?bDdyS1ZYbEdPZnh4eFl4V0RxUXpoaU1vN0E0VHYxYWRGcTFZeXVURTdmQTFH?=
 =?utf-8?B?eFQ2eUpYMlc1ZjhSR1hPMHlidnZPM3V3dU4yZk82V05sNUhib29Gb1lBVnBo?=
 =?utf-8?B?Y2dVYmY3Q1gxVVp3NmVmbVZKOUljM3NWejRDRXp0eURDRnFJdW9SK1RwMURH?=
 =?utf-8?B?YmFoQWFCbUt2V21wQzZHaUtSZjJNc2d5dGhRQ2x5NlFKbWdUYnczc1JGYVlL?=
 =?utf-8?B?ZGYrb1o0RTQ5Zy9JeXBtWmtSRC9HSFR2WDNaVytDTUdXQ1ZscmpZd295MUkz?=
 =?utf-8?B?cWdYN3Z2UTZJYXpST0k5TXJDOUtkTGNhMFJqN0RHU2RTVGlXWTc2WU5ZOVVY?=
 =?utf-8?B?d2dXVEdSakNCalNTV0pFVThsVUhTZWxjL3VCdW1aZ2xici9nMk9tQUNScWVo?=
 =?utf-8?B?TC9JWUIxUjNZWnFqeDRtcHY4V2VIYXIybjZ2TVV1eXZqRzVhR3ZHNzM4UDBv?=
 =?utf-8?B?NFBKbWdyU0RicDFyYzhIYUFMS3ZmWXdUSDV6NFUyL2h3T1VWdlhOZWN1ZXpL?=
 =?utf-8?B?ZkpHKzBnNXQvS0xSSlNYNkhrZVl5R0Fhd3VHRFdHM0JWb25aWGFiM2Ftby9U?=
 =?utf-8?B?S3g2UjZpNmZVNGEvMnhLaENoM21Ta2VmRXorMVRDdFgvODhlRGFYN3R4SjBv?=
 =?utf-8?B?WjcyclgwdXhWY0RxN0lVaHBjd0p1L3VVZkkraFlXUFdkOU1NK24xcTRGYWEz?=
 =?utf-8?B?ZEZzQVAzOExYTFc1TVdKclJ6Y2JWczIwZnlTMmxNcXM2SDExV1k2TXJEM1Bz?=
 =?utf-8?B?VDUyMlJSL2lFeElPRmVIOGJIRkdiVEQ1Wk9jK1pOaFRNcnpacXpZSzJJV0E5?=
 =?utf-8?B?QjRteFFIWnJ6anF0NTU2Q2gwdGkxeEdqd01hN0FPSUZQV3YvSlpaeXphTjVE?=
 =?utf-8?Q?vXsXYwviURuvQ+B0w2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0268506-faae-4b65-9340-08dec87a6f66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:02:11.6300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THhaevad7OaW2m9yD/T1qnczv1/dO5+GRjVWPL/6qgQC3h9rnn0PPg4GBrli1jRR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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

On 6/12/26 11:09, Huang Rui wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Add amdgpu_svm.h with SVM data structures and public API:
> - enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
> - struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
>   attribute tree, rw_semaphore, GC workqueue, xnack state.
> - struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
> - Debug/trace macros: AMDGPU_SVM_TRACE, AMDGPU_SVM_WARN, AMDGPU_SVM_ERR
> - Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
> - Locking helpers: amdgpu_svm_lock/unlock/assert_locked
> - Public API declarations (including clean_queue, sync_work)
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 196 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
>  2 files changed, 200 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> new file mode 100644
> index 0000000000000..9884a1f834d67
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> @@ -0,0 +1,196 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_SVM_H__
> +#define __AMDGPU_SVM_H__
> +
> +#include <drm/amdgpu_drm.h>
> +#include <drm/drm_gpusvm.h>
> +#include <linux/atomic.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
> +#include <linux/printk.h>
> +#include <linux/rwsem.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +struct amdgpu_device;
> +struct amdgpu_vm;
> +struct amdgpu_svm_attr_tree;
> +struct amdgpu_svm_attrs;
> +struct drm_device;
> +struct drm_file;
> +
> +enum amdgpu_svm_xnack_mode {
> +	AMDGPU_SVM_XNACK_OFF,
> +	AMDGPU_SVM_XNACK_ON,
> +	AMDGPU_SVM_XNACK_DEFAULT,
> +};
> +
> +#define AMDGPU_SVM_TRACE(fmt, ...) \
> +	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
> +
> +#define AMDGPU_SVM_WARN(fmt, ...) \
> +	pr_warn("%s: " fmt, __func__, ##__VA_ARGS__)
> +
> +#define AMDGPU_SVM_ERR(fmt, ...) \
> +	pr_err("%s: " fmt, __func__, ##__VA_ARGS__)
> +


> +#define AMDGPU_SVM_KMEM_CACHE_CREATE(name, type) \
> +	kmem_cache_create((name), sizeof(type), 0, 0, NULL)
> +
> +#define AMDGPU_SVM_KMEM_CACHE_DESTROY(cache) \
> +	do { \
> +		if ((cache) != NULL) { \
> +			kmem_cache_destroy((cache)); \
> +			(cache) = NULL; \
> +		} \
> +	} while (0)

Please completely drop that, this is mid layering.

If the kmem_cache is necessary use the functions directly.

> +
> +#define amdgpu_svm_assert_in_notifier(svm__) \
> +	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
> +
> +struct amdgpu_svm_gc {
> +	struct workqueue_struct *wq;
> +	struct list_head list;
> +	struct work_struct work;
> +};
> +
> +struct amdgpu_svm {
> +	struct drm_gpusvm gpusvm;
> +	struct kref refcount;
> +	struct amdgpu_device *adev;
> +	struct amdgpu_vm *vm;
> +	struct amdgpu_svm_attr_tree *attr_tree;
> +	struct rw_semaphore svm_lock;
> +	spinlock_t work_lock;
> +	struct amdgpu_svm_gc gc;
> +	atomic_t exiting;
> +	uint64_t checkpoint_ts;
> +	u8 default_granularity;
> +	bool xnack_enabled;
> +	void (*flush_tlb)(struct amdgpu_svm *svm);

Why do we have a callback for this here? Amdgpu already has abstraction for flushing TLBs.

> +	void (*invalidate_ranges)(struct amdgpu_svm *svm,
> +				  struct drm_gpusvm_notifier *notifier,
> +				  const struct mmu_notifier_range *mmu_range,
> +				  struct drm_gpusvm_range *first,
> +				  uint64_t adj_start, uint64_t adj_end);
> +};
> +
> +static inline struct amdgpu_svm *to_amdgpu_svm(struct drm_gpusvm *gpusvm)
> +{
> +	return container_of(gpusvm, struct amdgpu_svm, gpusvm);
> +}
> +


> +static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
> +{
> +	down_write(&svm->svm_lock);
> +}
> +
> +static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
> +{
> +	up_write(&svm->svm_lock);
> +}
> +
> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
> +{
> +	lockdep_assert_held_write(&svm->svm_lock);
> +}

What exactly is that lock protecting?

Christian.

> +
> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> +int amdgpu_svm_cache_init(void);
> +void amdgpu_svm_cache_fini(void);
> +
> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> +void amdgpu_svm_close(struct amdgpu_vm *vm);
> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
> +
> +void amdgpu_svm_put(struct amdgpu_svm *svm);
> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
> +					       uint32_t pasid);
> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
> +			    uint64_t fault_page, uint64_t ts,
> +			    bool write_fault);
> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
> +
> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp);
> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
> +			    struct list_head *work_list);
> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
> +				 const struct amdgpu_svm_attrs *old_attrs,
> +				 const struct amdgpu_svm_attrs *new_attrs,
> +				 unsigned long start_page,
> +				 unsigned long last_page);
> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
> +#else
> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm)
> +{
> +	return 0;
> +}
> +
> +static inline int amdgpu_svm_cache_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline void amdgpu_svm_cache_fini(void)
> +{
> +}
> +
> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
> +{
> +}
> +
> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
> +{
> +}
> +
> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
> +					  uint32_t pasid,
> +					  uint64_t fault_page,
> +					  uint64_t ts,
> +					  bool write_fault)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
> +{
> +	return false;
> +}
> +
> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
> +				       struct drm_file *filp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_DRM_AMDGPU_SVM */
> +
> +#endif /* __AMDGPU_SVM_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index cc096c005e348..9e6a668e8567e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>  struct amdgpu_job;
>  struct amdgpu_bo_list_entry;
>  struct amdgpu_bo_vm;
> +struct amdgpu_svm;
>  
>  /*
>   * GPUVM handling
> @@ -448,6 +449,9 @@ struct amdgpu_vm {
>  
>  	/* cached fault info */
>  	struct amdgpu_vm_fault_info fault_info;
> +
> +	/* SVM experimental implementation */
> +	struct amdgpu_svm *svm;
>  };
>  
>  struct amdgpu_vm_manager {

