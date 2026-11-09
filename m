Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE1606A330
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hBUbhUEl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918B310F2BF;
	Mon,  9 Nov 2026 13:49:16 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7359B10F2C2;
 Mon,  9 Nov 2026 13:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENxA6Wiz6b38V9OSHRv9l2aomCJ+tkvo9kQbRSu8dtvapoTNzUL5g4TnI4vRXYQlpMCLFShg+BqOhEEUYgRsrjvpFiF8//Cad0alKDUqKPfkFyLwBFSrWYFkKQtj3AA/7vxktirYfA5viP5erbKYspRIRE25etq+siLAeO5v/5Qs+WvJe4J229UBAJ5XI42LLmR+4kCNDrljApKtQ93DEau+rWuAmjKYu/bZpiJyO+g3L3CP+RtDKoNGo7Q03C/krR107mgoTlg1JSwj/lHJ12+11DxlLn00LoLTwzhzX7WspAtX/84PR/JooyYwiQuuSE8FLyuMfxFwHeOvUIZaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rU5enGez1ia1iekLh+XO6DEyCdhcq65OTKkBt0OLUA=;
 b=ou27+bnxf7VR8TOLkfedCiQwv+Qx9REwqnU3BmdsiDapDzRGMc5A/DPqSggkfOLV2LFtGBplYgH4V/vDGiwJpTB0m6eJ/VYXLU241M6tt/RtDDOZs5uXSXxFlZXEYLueM7q2Ovn9VaDcaNFUtLJnDULepWcBfVs9UcVt4Y7kkUXPmeG990Ie5nPQIRw8uAAi9Be0B1mDT+x9am2gEryy4L1pf5FbTBcWwaMgbY4FPAZXVgqCZQ17W1sae6Nrz+osB+Yx+oy4dEn/DoiUoKbhsmFVy0FERePpKF2XjsCT+Dm+Z8ThYJVvp8U6eML8b9Jb3oNgMR/vbSF8DxeIVtb9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rU5enGez1ia1iekLh+XO6DEyCdhcq65OTKkBt0OLUA=;
 b=hBUbhUEliUi2/5WnBZim3IZg2nYxLmdFByswlYYVrB77VzjyZjlaqBDz1Bh3fuKPdmNS42qNloPW1RvisH+nrs39aZdS3kQPfoozrKmeZpc9IFvTA7by4lZkDiubdmfgrZueFFr8br1puURa2ZJBEpfaRVsPvcV49QLLhHLsf1E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 13:49:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 13:49:04 +0000
Message-ID: <61071713-6f3f-494d-99bd-0d11adef1543@amd.com>
Date: Mon, 9 Nov 2026 14:48:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/22] drm/amdgpu: add SVM range types and work queue
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
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-6-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021025915.2433837-6-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e7ae8e-087c-4571-51d7-08df3e6837c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|921020|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261022115727099003|261022113327099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Sq4tYUvso4CEXl8qfJ/PHO4KDvUXEKF3zlFQHmkdq7F0GF8NeleEFqo6YcSTApMGo1WTZSYEhF7i9Qa7WW4EYg5RTTl5RwluYGmIIFUPqyMZfrjbvPWrluRpbgPMsnomRb5HGRElN/MwQAVctaCMn3VISYwZggBJnksSOUKePUdUIoi5M/5M5O+f8v4f79ZB3nBUTfaaX8B80hUpbMIdKHgOU+jKm0VN8GuWjieXt6Nq01DlvSGaHTb7J1epstmZftjcGLjFQNyrrNfBxENwMpr+35F8VQGaJshaeShn0P0UTjUq+E/DHNvDZcNKoXEaUurWTVTdjfcFOhPFrxEZ3eczFJgVf0EG+XuzEKAx3lY9FszDItPXNFEIpTHbS5vT/QVgfa9Dj+al9Jz3ojuoCIVe6ph5kgRwkpoWGVWkeG3e+zKq+6+HvzdIlLPrDeKjjh5kRINsuXGyhf/1+FR4imx+YHo6z14n1JdYwAN5pnKIeYa3EX9pRNk/fl4YrR44zZV1w9EUjVRhq8W17ABh1bAiyJE+WeV3Vj//Tml0WC64Dv5ku0FPfsEVGdmRJ0+yYt7VGavQuLDEQAHzh6oav92oikwL8yvNWiy5tj9RnmBck/C2U4x37Lf6EM2C6hSa2sh4Cz+OWVGtcwUPGBReGp6TiJrwkJBn/bv1HYEdeIGeY/tlhrEbkdAa7GChOYsniqI6NNUDoV2Kx86+C9v3jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261022115727099003)(261022113327099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdBWmg3WjUxVWRpcCtoTS9qT251OGtMUW1qWEdJdmgwcXFNczJtM05kdnZG?=
 =?utf-8?B?Smw4TnpVMDliV2UzczRZS2hUTE1Id1pCRnZLQWJVS29hYzJSS2JZM2tkUHdR?=
 =?utf-8?B?Q1JxUXdTaHZUeGVxOEZmOThQcGtGLy9ZaUJQZlRtN04rZ08zSlJ4SWhrTXlJ?=
 =?utf-8?B?UDN5TVFXZTZTQXNlUUVONWtVQ0N5bzQ0L0Z4dytYVVVlTUlOdEVzUHZqV0lX?=
 =?utf-8?B?Mll6WWZMam9ndnF0T0hVWDBLaWVmNXBrbEN6S3JHWXRvTTh0dTBIVkVIdUFB?=
 =?utf-8?B?blA3eEsvL055RmY0b1VMR01adTlNcUc2N3VFNjlQa24weXlHYVJGS1c2R2xZ?=
 =?utf-8?B?ampOUkxvMkc2UUZTOHkwZUlQSEN0cDAyM2RsNSt3UUYydEtVT1o3Kzd6RGJx?=
 =?utf-8?B?cGIya0pvSFNlcldjWlZiRFNPOStuNzI1N0JzeWtDMGN2WjdFdUdNMDFoNmlO?=
 =?utf-8?B?RnBuS2JuYlVnVVE5Rkd0QW5lUEFRVUQ0cURxY3loT3FmNTcvRzhwMVA2Zk9M?=
 =?utf-8?B?TDRhR3dMRnY5aHZBTXVhZVQvMStEM01yWStxcmt4MHhSLzhxRCtyMDlwTWdk?=
 =?utf-8?B?TFR5MTc4VjI0SlM2Rjk4c1JGTWVPNmlTUkpTRHJEdkhkQVZUMHpkMVdOcGhS?=
 =?utf-8?B?NHkxcW1JWGZJTVRZRUlwdTR4Si9ic0tUemxTUWxTdS8yOC80M0JyYXhWdXhr?=
 =?utf-8?B?ZFgvdFluL1NONEg0ZTBNYi9HYUdzenFnVDV0MUZqV3BhMFoydGRDK05PZ25Q?=
 =?utf-8?B?UGNmVStwOWdTTjgyeGRjcFdudDYrV1kvM25kb2hGS2I4eFFEbnQ2QmkvQVhy?=
 =?utf-8?B?VW9Tbm9TVzh2OFBEa0NZSng1anVCNTdlNkVxb3lLM2VIQXlUUGZOb1hiRi95?=
 =?utf-8?B?NjF3Uks5T0o1TVFaQUxKTmp5dHptTjlEVWlVMEtHTWhKVXdGNEtKSEVXSHBJ?=
 =?utf-8?B?YzJUdStvTFRZYkF2dDMvNEFIWTl5NGx1TU91dk9EdmpyYUtXaGJuL3NCZWtQ?=
 =?utf-8?B?cFlvdHhGeHhUcEx5TzQ1TjZOSWxHSkVMcFFEakNUMmR3ZDdsTmp0WVBVOWFm?=
 =?utf-8?B?ZEVmd2lTeVlydTNVRXpUQ0szZDdieXlUd0c2cVNoSkVZVlU4ek81SEMyVkt1?=
 =?utf-8?B?dFhReXVJVmlHODBMeWN2QTEwVTU1NW9ncnpQOTA1UHNLOTY4K1NUWGhuQ0Ru?=
 =?utf-8?B?ZEZia3lCMjdKaCs4cHVGSGxZWGYzUGQzVmVJNCszTEl6NUVnVjdxTTh0K1k5?=
 =?utf-8?B?c0pnOFFGWEo3TlB5RDRkMXdhenRGazNYZUlVL2pCT3YrcURiQll5WjhHcTBu?=
 =?utf-8?B?dG80WjdQVlhTYnpzRGd6SVJUVFEvaXowQU10Y1BaR2RreGp1dDdmc1NWUkVH?=
 =?utf-8?B?K0pxSjM3Nm1uNERpMWFyOWNiOTU5UFVtTE5HMmNsYzNwNk5SMklYMVRwUVQ4?=
 =?utf-8?B?MzhzUGF2Zk9nVXJNSVVGM1hubHpwWElid0NpeTE1Ly80R0FOSExHQWxMY094?=
 =?utf-8?B?dmRDRnM5Vm9xZlZmTzBqMWNFOUZGVUh3Sm0vTmhPaHFQdVg3K0hJTDVVVWFj?=
 =?utf-8?B?L0h3VWpQNjRvV3V0aVNPNStwM0Y1Nk82VWs2WUxPaFJnQUZlWXpZM2JWWHJy?=
 =?utf-8?B?L2pvNWh0enhZYThGZTNFSFNoNU5PczROTlFjVlZiekN3YjNpSTlLSm9KQlh0?=
 =?utf-8?B?ZWkrUER3N3FrR29vYlZ2SmdndTlHb0VNZHBsQmFXV01ETWhvZW1iejlkRkhE?=
 =?utf-8?B?bi9jdUJGUkFRSjRkbmU0R3hYSCt2Uk5OTWN1bWZRcGx2NTB5ZE9lbUJ4T3pP?=
 =?utf-8?B?K2k3c1l5RCtSREY2SFFuTGUrbm90VVlUNlhOUjdYem1LQlJrVFZoVTJ0TTRw?=
 =?utf-8?B?dkJ3YUtMSHNIVlFmdytnT3pqM2NrM3pmMFUxYU5mVzEycG1JS2lJL2xaRFpY?=
 =?utf-8?B?OXM2VTN0blFyYjNkdUhvdnRzbXgzRGZRY1Zmc2hRNTltZVFDMUkxZHJQRE56?=
 =?utf-8?B?ektCZWNDaElTRC9tdEpvaEN6OFdocVlxVW9zZm50bmJGaFFzeFh3SmttUHlE?=
 =?utf-8?B?U2lubHowZWFRcC9EZlNCaVhDamRBQm9vWVdPRVVERFkvT2J4L1ZId2gvV2JM?=
 =?utf-8?B?RzV0OWs2cHlZeTQrbCtYVXFCMzJpbFBUTmRucTI3VTFrRFlFRUU0bW01RW1s?=
 =?utf-8?B?U051YVlyMlZrSDdrZjhsdFJjU050RTNaRFlveVVZc2dMUS92RzA2K2tNeFRu?=
 =?utf-8?B?R0o2endFMEt5enhkcTg2K2dmUTdGcGV5d1RLZnlkSURVMHIrVXJTZXQ0NFFx?=
 =?utf-8?Q?nJlYY+9sUVwgkvYRAE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e7ae8e-087c-4571-51d7-08df3e6837c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 13:49:04.6175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40lxp9g+mGRrR3IHjHuLSfPJOOljr6L0o9tPeu9WeFON8jxCsQldyZLaU1lVvsSE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
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

On 10/21/26 04:58, Huang Rui wrote:
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
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 129 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |  30 ++++
>  2 files changed, 159 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> new file mode 100644
> index 0000000000000..39db3a18b5f2f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> @@ -0,0 +1,129 @@
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
> +/**
> + * enum amdgpu_svm_range_queue_state - Work queue state of an SVM range
> + * @AMDGPU_SVM_RANGE_NOT_QUEUED: Not on any work list.
> + * @AMDGPU_SVM_RANGE_IN_GC: Queued on the GC list.
> + * @AMDGPU_SVM_RANGE_PROCESSING: Being processed in workqueue.
> + */
> +enum amdgpu_svm_range_queue_state {
> +	AMDGPU_SVM_RANGE_NOT_QUEUED = 0,
> +	AMDGPU_SVM_RANGE_IN_GC,
> +	AMDGPU_SVM_RANGE_PROCESSING,
> +};
> +
> +/**
> + * struct amdgpu_svm_range - amdgpu GPU mapped SVM range
> + * @base: Embedded drm_gpusvm_range base.
> + * @work_node: Links the range into the work list. Protected by amdgpu_svm.work_lock.
> + * @gpu_mapped: True while the range has a live GPU mapping. Accessed with
> + *              READ_ONCE/WRITE_ONCE.
> + * @queue_state: Current work queue state @amdgpu_svm_range_queue_state.
> + *               Protected by amdgpu_svm.work_lock.
> + * @pending_ops: Pending amdgpu_svm_range_op bitmask. Protected by work_lock.
> + * @pending_start_page: First page of the accumulated pending interval.
> + * @pending_last_page: Last page of the accumulated pending interval.
> + * @attr_flags: Attribute flags last applied to the GPU mapping.
> + * @validate_timestamp: Time of the last successful mapping validation.
> + */
> +struct amdgpu_svm_range {
> +	struct drm_gpusvm_range base;
> +	struct list_head work_node;
> +	bool gpu_mapped;

> +	u8 queue_state;

What is that good for and why is it needed?

Regards,
Christian.

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
> +#define AMDGPU_SVM_RANGE_TRACE(r__, op__)				    \
> +	trace_amdgpu_svm_range((op__),					    \
> +		to_amdgpu_svm((r__)->base.gpusvm)->vm->pasid,		    \
> +		(r__)->base.gpusvm, READ_ONCE((r__)->gpu_mapped),	    \
> +		(r__)->base.pages.notifier_seq,				    \
> +		drm_gpusvm_range_start(&(r__)->base) >> PAGE_SHIFT,	    \
> +		drm_gpusvm_range_end(&(r__)->base) >> PAGE_SHIFT)
> +
> +/**
> + * enum amdgpu_svm_range_op - Pending operation bits for an SVM range
> + * @AMDGPU_SVM_RANGE_OP_NONE: No pending operation.
> + * @AMDGPU_SVM_RANGE_OP_UNMAP: Range needs to be unmapped/removed by the GC.
> + */
> +enum amdgpu_svm_range_op {
> +	AMDGPU_SVM_RANGE_OP_NONE    = 0,
> +	AMDGPU_SVM_RANGE_OP_UNMAP   = BIT(0),
> +};
> +
> +/**
> + * struct amdgpu_svm_range_op_ctx - context of a range workqueue operation
> + * @range: The dequeued range to process.
> + * @start_page: First page for workqueue operation.
> + * @last_page: Last page for workqueue operation.
> + * @pending_ops: amdgpu_svm_range_op bitmask.
> + */
> +struct amdgpu_svm_range_op_ctx {
> +	struct amdgpu_svm_range *range;
> +	unsigned long start_page;
> +	unsigned long last_page;
> +	uint8_t pending_ops;
> +};
> +
> +#endif /* __AMDGPU_SVM_RANGE_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 599c1d0e512b5..86ba09cba34c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -116,6 +116,36 @@ TRACE_EVENT(amdgpu_iv,
>  		      __entry->src_data[2], __entry->src_data[3])
>  );
>  
> +TRACE_EVENT(amdgpu_svm_range,
> +	    TP_PROTO(const char *op, u32 pasid, void *gpusvm, bool mapped,
> +		     unsigned long seqno, unsigned long start_page,
> +		     unsigned long end_page),
> +	    TP_ARGS(op, pasid, gpusvm, mapped, seqno, start_page, end_page),
> +	    TP_STRUCT__entry(
> +			     __string(op, op)
> +			     __field(u32, pasid)
> +			     __field(void *, gpusvm)
> +			     __field(bool, mapped)
> +			     __field(unsigned long, seqno)
> +			     __field(unsigned long, start_page)
> +			     __field(unsigned long, end_page)
> +			    ),
> +	    TP_fast_assign(
> +			   __assign_str(op);
> +			   __entry->pasid = pasid;
> +			   __entry->gpusvm = gpusvm;
> +			   __entry->mapped = mapped;
> +			   __entry->seqno = seqno;
> +			   __entry->start_page = start_page;
> +			   __entry->end_page = end_page;
> +			   ),
> +	    TP_printk("%s: pasid=%u gpusvm=%p mapped=%d seqno=%lu range=[0x%lx-0x%lx]-0x%lx",
> +		      __get_str(op), __entry->pasid, __entry->gpusvm,
> +		      __entry->mapped, __entry->seqno,
> +		      __entry->start_page, __entry->end_page,
> +		      __entry->end_page - __entry->start_page)
> +);
> +
>  
>  TRACE_EVENT(amdgpu_bo_create,
>  	    TP_PROTO(struct amdgpu_bo *bo),

