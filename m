Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAC0CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E643810F49C;
	Fri, 12 Jun 2026 12:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f7Po3H9Z";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9BB10F48D;
 Fri, 12 Jun 2026 12:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykqzeqw8jssx+jsmUMmI7sUfFmKeIoG7C+tBE0Reufv0NkFU/47DpbDlGgOcViOl1lzdsIL/PUslK7pl35FzqqUmoFw1i8wLrGGz+q2DD1ZLdgsHxgQHrj4phubt/tn4qxKVt66h8ch915pbkkeileDHD9iwRCJC9S7j5F1+A3rLecczN6IhRHjb9h1OGTktqsIb3B6oZ5n9VSjNMXEzTuuDofx36QTLs12w29lhbTLHEZ8Xe6Yg08LkRy2ytNvQuL7r9nCRvNxeAFNUckXJItBPZZwgh72yDrxZPqviVba4KJclh7pIF7cLt4eyw8p4fnoCDnHFpJIWMp/ARY3IdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3KE6hzD1/6DSaJPVKBgoCOKJenZxIpj78ctMI1cPqo=;
 b=Z5PEA6zMS1dpdrGucmVwgCn5uvXHWOTfP2DzDvmIw8Cy+74rD++7Sz7HdCmHjWp/fR3FMnEIkAL91HIbu6dRVOmoKzKlfScY2YKymupp0U4npTJbQ3SuCemBCEn+tDIIE1GbKOggLJMFt1oMrHhA158nSBdMdAYH5yFqqwRlRSW14gJgnCKKOEx99QKQdtRJdobRGjCQkgXvGwRElfLaCkAtIh98PLt6qUYNo/e1T69lcC+Z0TwoJ2nDt1sxiea3r0ziiUlNQgY5NaGRE+knkS1OR6K2qJuEMqKHpv/OSTG94Lsv5hOIq7CynropA/EfG6VRD2Scjkz/iQ5Sm+NB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3KE6hzD1/6DSaJPVKBgoCOKJenZxIpj78ctMI1cPqo=;
 b=f7Po3H9Zd0XDFoGdXplw83sebPK3l+yylSwohd10yJBKkBldRJStYUGO0O+PYhlLiapMdZukqjc07g3jMyvy5r53WG/vOJ6Wf3p0yBvtjc4Bzw3OtZ5KMg4fRMEURM3GxFEBRWczUgJuE2nRR0UWsiOYc3xCo9cIVFa2X5MOZ1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Fri, 12 Jun
 2026 12:13:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 12 Jun 2026
 12:13:10 +0000
Message-ID: <d1646a51-2c28-489c-8ae3-8b8da52be42a@amd.com>
Date: Fri, 12 Jun 2026 14:13:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/18] drm/amdgpu: add SVM range types and work queue
 interface
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
 <20260612090928.29682-7-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612090928.29682-7-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0138.namprd04.prod.outlook.com
 (2603:10b6:408:ed::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 996b5783-7201-4c10-a426-08dec87bf83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|921020|3023799007|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GgC88matgUCnc8O41gXnej0ybb5MEHYUi/zKX/rdcQ5C1Dr9sQ28voP6CZTzptMNHk4boqRhGVpNpbJxoeTCj1ibjWOy9IX/0xZJYp/ZsVtQmYDgaDcwDR3G0ePIpZYOJUFSPoD75t5zXAJMBk8JtvoaM+BKp2WJOjnOGfOGaJDAd8Az83iPUd5MaISeZ7ZbI50ZHRPVf1Tn15HlEGRVmJmmqqXrL7JSlkVeIZ1dngfxzAJHHN0BoAeoERTOADMgS+BAYDXZbN/XSj+W8UxSWLZocGxXpM8oXmrkpsKxWMoOQ8jEIgvj0jw8XOXQWpvHR1iL6++liGlvhuDEZCmBDp+hRzKcfLJsccRqZ0EUTj4mZKUIhT477xsEXm2WUJdz3dWkV19SIfSUYG0JiG+yNRkjm5CldQvEmwtjgMm4odqWr7L4jFawXdYSrTFa1qIDDdGPfyzWSKeXiBTrBDbyEqtKW1gb1ZbbEnjOIQNaR0VNrfIYCaUlRhpnMYlY4H6RPSYmKrbA7A8u72rcEHpLR/OwBPYA11cmNmgmkO6usKK+yzexKb2pWX2LQXx/+VUqhWM436CKID4HFl++osYq39L5W0hdSUSy3yParfuCLsSN6k1Lb8mke/rVOfbsL13pRTWnOxTgCFBM8eIjvcHpjjuI/5DymBnQD8TYM44g66x/wITtWg9rAcsx6txcd7dGJXnY+8O/tfUz0ZhSZfrt3+CD602Zgl2VZ4bUx1XEYxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(921020)(3023799007)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3h4QUJCVWsxUjc2MFdUa1NNdzY0R1UyS04xNWFGS1VZdlhGN0tmM3lsMkJY?=
 =?utf-8?B?d3BSSlRTTjdNc2xvNWNKaS83cG1tZFk0L1RrVmtjUUY0UDFKajhkVGlPNjhm?=
 =?utf-8?B?MmJRQ2pxUm9tcVA3aDBXMVJTbkhlUThHUU94QWEzNUNaTm4xdy9wVWVVTTJo?=
 =?utf-8?B?WmptcGplUzhmMkNSVnlBNE5qWmZWeFRRQjUyRklsenlPc2tuMDE2MlRQclFy?=
 =?utf-8?B?U0tDSHErV1pmTHR0aFRNWHZ6Y2FyYUxudmZkZnJJRDI5TWR4V0NrMVB1SFUz?=
 =?utf-8?B?ZlFOZ0JBeWNhczMxZzE2bENhTzlUeHhvdTI5TTk1aFk2V1lYUE5xL2gvVWFT?=
 =?utf-8?B?dG1hNXlDTDE0MjllaUxPTlhBeklxQnpJc0JoUTZlTDMwRTZLOVZmMHR4WGdS?=
 =?utf-8?B?ZU1yc0g2R1U3YmV3aGplaVZaK2ErTURFdVU4bzl5blN6eVFyWGgzY0R4QmRm?=
 =?utf-8?B?V21qcTJPUC9mbngvSE9HWWQ2UmxuZWxycnhvejlRNlpXTVQzenRvcmFoSXds?=
 =?utf-8?B?VEFnbVEvTEUzaFcyZ29RaTZBT2NjTThvRlUxVFNxQzF1aFozUmo5UDQ3R3pO?=
 =?utf-8?B?eWdqb28zTVJja05sNUlZblk0dy80S00ydTNvVkFqUUQwcmN1bzN4WERaaSti?=
 =?utf-8?B?WnY0R2YxZU51TFhqZXl0TkRGUjdBa0J0aGx4L3c4SWlYbkE5SXhHQUNrZzgr?=
 =?utf-8?B?b0RYYjV2cVlNWnFWeWxWekVEU0hMUHZ1d3FiTkpiRGtOcVJkdE9jczZOUzhX?=
 =?utf-8?B?UlY1c01RYkhQQ2NDZElqdjF5a0lob0lFSzRlS3o4YVJKVjBUOVlYaTZISStH?=
 =?utf-8?B?UTlOOGczVGdJWEREK2c0UTBhUmZRS014SXNBdTYyUEg0MVNFRGtQS0pFQklw?=
 =?utf-8?B?d0xGM3FVN1Q1UWozeEwraWozQ0VQQUxUSW1EL1hJRjFxM3AwWHFraHNmcUpQ?=
 =?utf-8?B?ZUZxcGFuajdqM1dESWxHaURwWlVNV3VMNlBKdTUwaTI4NjRkR3QyREZWZVhY?=
 =?utf-8?B?ZFJVUW8vVEsrVUhRenNSbTFVb0tINFJwOVNlLzZVcElnbzRKalJNR2llQlh0?=
 =?utf-8?B?WHdZNWFmSjJReDZaQTY2dVFhQXMrTGtYQ2hQUVNuK1RLYno2UE9hTG8vSTlH?=
 =?utf-8?B?Rjk0TWozZWVhMW5NbU1BcitHakkzaTk3MUU0QTNXaTFDWlVUdDZBZDdIRU9M?=
 =?utf-8?B?NnlBM0p3QXVUYVBNTFplQUhIL0NOYlF0RFNvaGFkL3Q2N3YxdW43a2hOeEpm?=
 =?utf-8?B?K1lyNHR3MFUwd1o0Q1ZIODhyRFlza1Q2TmtHNnU4ZnNpMFZQU0lGdldSaFFL?=
 =?utf-8?B?UGUrelRXKzFBUWRxWVR3MmRPUUZvWmI4NC9ybWVISXRBRUNvcGZLa0ZteFlx?=
 =?utf-8?B?MFR5SDFKWkg1ZVlOWkV5WXRObEJwTWNrZ0hwTkxWclhhdjZVUlpzK1UwaUY1?=
 =?utf-8?B?ZTdFckFRQ295S1A2QmFHeGZ6RUNYT3BnSnpyRER4VzZFbFA5a3FwSEw5YmFO?=
 =?utf-8?B?ZlJBUzlEUlFnOFNxUTZrTkV0Q2tQUDlzZVlnaWphYjV2bWkrbnZpWGh6UUNY?=
 =?utf-8?B?N3JWMWZmVEI1Q1B5OTFTM1B4Q3FhOHVrcVJ4K1lDQnpGYzU3RU11ZmJoNVov?=
 =?utf-8?B?dGZFczQwRVhwSk15c2dPcEQ0ZjltTzNYSlY0ZGtUNW5HWEY4N0E1OElMUDh5?=
 =?utf-8?B?Y1BGcGJHYWZtbU9ONkg1UXA3VWZxeU56M1Y2NmczRkl2SDV5MGRhbE40cFhW?=
 =?utf-8?B?cWRuRnJzcEU5dVhwRlBiTlh3eWI4VmorcHlhVUpHSjNmMEdqajhJcS8wVUlL?=
 =?utf-8?B?TWpYZ2MvR0M3bVc4eXl1dTZhY3QvRTFISDlobGFwSFkyUmVBbzg2ZTFQSnFi?=
 =?utf-8?B?dE5jdUFNNFZaK1NtQjVoZWd6VGhTTmJ4UHRTZjhYWEU1UHFrYlRaSjhoa2lU?=
 =?utf-8?B?Ri9QT21acTFvUWlGeUVmdmI3bm10cm40Zi9uaUZTV3hlRWVINXVPdlM5NklY?=
 =?utf-8?B?d1BFc24veHhTVWdITml0bWRTS0o0OGNmUXlxUmZJdjFEUkxYbXJDZ3hITzN1?=
 =?utf-8?B?S0JmaGt3aVhnRGZ4bitGYy9HZVN3ZS9NL3lHZGVsUllxbGhIcWdSVy9zeHJY?=
 =?utf-8?B?WUVnbXM1a2NsN2hSbEpIcmJoc2JzUENHSk5pUmpVdTNZRmFDSE9aUStNcGwx?=
 =?utf-8?B?RGFWeU1MdnY5MkxSWUFQZFJzVDl1dmNaclFONGh3WmJ6WEN3K25lTWpCMzBE?=
 =?utf-8?B?aWxocEs0cEhydng2T2F4SFJwemk1UDAwLytsdENoVEZFWU1aOVRuWG1Za2po?=
 =?utf-8?Q?KnOoWXcARiWgZDqgmU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996b5783-7201-4c10-a426-08dec87bf83a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:13:10.6304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQJjRuZJfcsHXS9QbnPB8Bz+l7qUb9SuT0BkBBcsCq8+Cs5u6l81u15dR2OjqLoV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F
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
> Add amdgpu_svm_range.h with GPU mapped range types and interfaces:
> - enum amdgpu_svm_range_queue_state: NOT_QUEUED, IN_GC, PROCESSING
>   states for queue work
> - struct amdgpu_svm_range: extends drm_gpusvm_range with gpu_mapped
>   state, queue_state, attribute flags, work queue node, pending
>   ops/pages, and validation timestamp
> - enum amdgpu_svm_range_op: NONE, UNMAP operation types
> - struct amdgpu_svm_range_op_ctx: dequeue context for GC processing
> - Inline helper: amdgpu_svm_range_invalidate_gpu_mapping
> - Range operations API declarations: find_or_insert, get_pages,
>   update_mapping, update_gpu_range, invalidate
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 165 ++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> new file mode 100644
> index 0000000000000..a079eff86020e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> @@ -0,0 +1,165 @@
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
> +#ifndef __AMDGPU_SVM_RANGE_H__
> +#define __AMDGPU_SVM_RANGE_H__
> +
> +#include <drm/drm_gpusvm.h>
> +#include <drm/drm_pagemap.h>
> +
> +#include "amdgpu_svm.h"
> +#include "amdgpu_vm.h"
> +
> +#include <linux/ktime.h>
> +#include <linux/list.h>
> +#include <linux/types.h>
> +
> +struct amdgpu_svm;
> +struct amdgpu_svm_attr_range;
> +struct amdgpu_svm_attrs;
> +struct dma_fence;
> +struct drm_exec;
> +struct drm_gpusvm_notifier;
> +struct drm_gpusvm_range;
> +struct mmu_notifier_range;
> +
> +enum amdgpu_svm_range_queue_state {
> +	AMDGPU_SVM_RANGE_NOT_QUEUED = 0,
> +	AMDGPU_SVM_RANGE_IN_GC,
> +	AMDGPU_SVM_RANGE_PROCESSING,
> +};
> +
> +struct amdgpu_svm_range {
> +	struct drm_gpusvm_range base;
> +	struct list_head work_node;
> +	bool gpu_mapped;
> +	u8 queue_state;
> +	u8 pending_ops;
> +	unsigned long pending_start_page;
> +	unsigned long pending_last_page;
> +	uint32_t attr_flags;
> +	ktime_t validate_timestamp;
> +};
> +
> +static inline struct amdgpu_svm_range *
> +to_amdgpu_svm_range(struct drm_gpusvm_range *range)
> +{
> +	return container_of(range, struct amdgpu_svm_range, base);
> +}
> +
> +static inline void
> +amdgpu_svm_range_invalidate_gpu_mapping(struct amdgpu_svm_range *range)
> +{
> +	WRITE_ONCE(range->gpu_mapped, false);
> +}
> +
> +#define AMDGPU_SVM_RANGE_DEBUG(r__, op__)                                      \
> +	AMDGPU_SVM_TRACE("%s: pasid=%u, gpusvm=%p, mapped=%d, "                \
> +			 "seqno=%lu, range: [0x%lx-0x%lx]-"                    \
> +			 "0x%lx\n",                                            \
> +			 (op__), to_amdgpu_svm((r__)->base.gpusvm)->vm->pasid, \
> +			 (r__)->base.gpusvm, READ_ONCE((r__)->gpu_mapped),     \
> +			 (r__)->base.pages.notifier_seq,                       \
> +			 drm_gpusvm_range_start(&(r__)->base) >> PAGE_SHIFT,   \
> +			 drm_gpusvm_range_end(&(r__)->base) >> PAGE_SHIFT,     \
> +			 (drm_gpusvm_range_end(&(r__)->base) -                 \
> +			  drm_gpusvm_range_start(&(r__)->base)) >> PAGE_SHIFT)

Clear NAK. Make that a proper trace point and don't clutter the system log with such stuff.

> +
> +enum amdgpu_svm_range_op {
> +	AMDGPU_SVM_RANGE_OP_NONE    = 0,
> +	AMDGPU_SVM_RANGE_OP_UNMAP   = BIT(0),
> +};
> +
> +struct amdgpu_svm_range_op_ctx {
> +	struct amdgpu_svm_range *range;
> +	unsigned long start_page;
> +	unsigned long last_page;
> +	uint8_t pending_ops;
> +};
> +
> +#define UNMAP_WORK(ops)		((ops) & AMDGPU_SVM_RANGE_OP_UNMAP)

What's that?

Christian

> +
> +void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm);
> +
> +uint64_t amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
> +					 const struct amdgpu_svm_attrs *attrs,
> +					 bool read_only,
> +					 enum drm_interconnect_protocol proto);
> +int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm,
> +				struct drm_exec *exec,
> +				bool intr);
> +bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
> +				  struct amdgpu_svm_range *range);
> +bool amdgpu_svm_range_is_valid(struct amdgpu_svm *svm,
> +			       struct amdgpu_svm_range *range,
> +			       const struct amdgpu_svm_attrs *attrs);
> +int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
> +				      struct amdgpu_svm_range *range,
> +				      const struct amdgpu_svm_attrs *attrs,
> +				      bool read_only,
> +				      bool flush_tlb, bool wait,
> +				      struct dma_fence **fence);
> +int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
> +				    struct amdgpu_svm_range *range,
> +				    const struct amdgpu_svm_attrs *attrs,
> +				    bool read_only,
> +				    bool intr, bool wait,
> +				    bool flush_tlb);
> +bool amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm,
> +				     struct list_head *work_list,
> +				     struct amdgpu_svm_range_op_ctx *op_ctx);
> +void amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
> +				      struct amdgpu_svm_range *range);
> +void amdgpu_svm_range_remove(struct amdgpu_svm *svm,
> +			     struct amdgpu_svm_range *range,
> +			     struct drm_gpusvm_ctx *ctx);
> +int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
> +			       const struct amdgpu_svm_attrs *attrs,
> +			       unsigned long start, unsigned long end);
> +int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
> +					 unsigned long start_page,
> +					 unsigned long last_page);
> +int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
> +			      struct amdgpu_svm_range *range,
> +			      unsigned long start_page,
> +			      unsigned long last_page);
> +void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
> +			    struct drm_gpusvm_range *range);
> +void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
> +				 struct drm_gpusvm_notifier *notifier,
> +				 const struct mmu_notifier_range *mmu_range,
> +				 struct drm_gpusvm_range *first,
> +				 uint64_t adj_start, uint64_t adj_end);
> +bool amdgpu_svm_range_notifier_event_begin(struct amdgpu_svm *svm,
> +					   struct drm_gpusvm_range *range,
> +					   const struct mmu_notifier_range *mmu_range);
> +struct amdgpu_svm_range *
> +amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
> +				unsigned long gpuva_start, unsigned long gpuva_end,
> +				struct drm_gpusvm_ctx *ctx);
> +int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
> +			       struct drm_gpusvm_range *range,
> +			       struct drm_gpusvm_ctx *ctx);
> +
> +#endif /* __AMDGPU_SVM_RANGE_H__ */

