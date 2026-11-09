Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121C6606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QlBhSGqf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B13D10F24F;
	Mon,  9 Nov 2026 12:33:28 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDB710F240;
 Mon,  9 Nov 2026 12:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOyrI/WuetAX16easZQGRs897JfU2A4H8dkNqF8edaCQvQQtezzzRiLoGSWpwQlh/IhshT84HWmvmTVH+rxkJ9gK0f1lqrAkFwXGmOxYOmAPITUz8ILT483n5dwWPPnPwmLOIbXW4HqtTRb+1+OtcLt4BvELuwRzom5FTpmNzn3X+2o3qdhFGJc55rkR54byNybCFnTUegjdA5rfNZGHWvaMvpVl2KnTsSu4lfoRfuxmhU7BDbTMyS6Bm1+Paxtf2Vqa7vxrMSN1OkFrmZsRU+DPLpXyDy5UUplmIzeHrcqB+7KQv/jDo+7GgnYoK/POLSjEudkO5zyUSXN0AfQIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7C8KG2ksgcRtX36DBZVdWLTzWMxzhcVwdb3agh2Lds=;
 b=gFk+4vftCtHSYjMJRHp7aBkyTyAWaYP57pV7M92r9USaDFbNbUqZS4YTS0yUWtC632rB3E16aoJjOefcxiqcu4ejiIIoaWWp6QsT/HROOjk7jeftM4tu/Iinu27+cTaGQBp/c11aPD4TjBL8nZDFbhY1yv1kyrn/5YY7Mu5iChHRDuhklJ+B9gk036O1j3zozrdGwQtUPLIgLKv0oHsndTAVUbdm3APSXkn40WO8jxqBSv4BHrwVImwUsDmDwvd487W0DMbNvK9rSTzmeIoZugERi5IOBHL/moP/3AOo7LyL0bfDwkXOXQhZJVaezvuBOULS7w/mK3/FL6gmVn1pgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7C8KG2ksgcRtX36DBZVdWLTzWMxzhcVwdb3agh2Lds=;
 b=QlBhSGqfRQjbqyLXhJDvv6M/26s6F+Ezd+E+NPHY9ffMZe9ae/+wK9zatge0sFzd3JJvNpnZGvD1Qc+KZkRryJknadE7NFYdIXEG40H9CTblUtZV8DfVBv6kWhf9RLNTCbgdi3LnvWG69fc7FI07r4MJqYMb/O8zVfYzyMRDjQE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:33:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:33:16 +0000
Message-ID: <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
Date: Mon, 9 Nov 2026 13:33:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/22] drm/amdgpu: add SVM core header and VM
 integration
To: Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021025915.2433837-3-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a9ab3c-9a16-4350-8874-08df3e5da0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|921020|261009223327099003|11063799006|4143699003|56012099006|261021121427099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: KccERK4orTMfmSdG3hZ59V+2vCgBtkChxFsaojhDK/8kNVT1BUxpfbbcr2QAIzrTKIqmMv8JpaesUhxlL5cUzE3yF0l5HGyN7ykS90eegLiOwY0SCkHY4vYeoZa9oKrMx1KcpP3YeqADMTVjp35TsZN/ifoSjMWo/VrPI1OzXDMyAlruW7Y1JiCPFpE2myeWX/9j1tHd70GWxp7yE123GsO/Yh+Rwhb9CRsm9HU/0cEG15qPOtI3bz0wfVbZERY3UqgZpO3LwswBv4MbS/Gq5fdwijuQsWMWDo5TKx91qTmuZ5SKprK7kzbKU49+hZYe5bHnXcHDm5QD90Y/WuAKE8RqXPTeklJVq9iUY5yhBD0d6GXOM8OdsT1SIFdnqcAnBe6/56w5jeXvc4sXSNOex7K2R1U0sZ1Io0a5eAMN85pNcYK9kRXenyG8xsZuvaP8wtsURoiu2rhEeffzjQs06CzhKG3oewB9Xn4ZCC7kxWWYiLUnqeoe+07co/cWjL62wq4K0ufwbgmKifw1wFVxzJSFf36ScBCy0YyrDkQkMIwxmIMe3rOFyLNDWY2V+iSFAuSfMM6nMGWktG1l9mA/fa2zBnAh+d7HoBXGn18DcGirzBf+m33MlmcrmSOT2EDK8KBTg/Jqvpyc9KCMPR+YpxhRzUzXBAUw7PoDQCULVVJ62lEI2BTDbgYZdLsGIxnJ8BqzpSuJMWbMrX/kYDBUDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(261009223327099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUFZSERQSjZnM25yTlpVbW54UEd0cCtPOHpuVlpXeEdwNDJONlpnMnFJbkRn?=
 =?utf-8?B?N2VxeWEyK2F4aGJMLytOSzJLcUQ1VGhzSDVZRW5jcG5mejRtRkRqOUhIa1Nm?=
 =?utf-8?B?TjNLWVNicEFZSDZWdUltdHh3NzVMVmZoOThhenZIaHR2M3BDRXdadW5CQzRL?=
 =?utf-8?B?ckFkcE9Zdnk2K2NRQmtvWTE3NzdrOXA0RjVzUDljdFpsaG1IQVkvR3pmU3BG?=
 =?utf-8?B?dFppbCtyNVY4dW1GNlFJUWNYZXZ2YWhhUTNJUy9IVlRqaHBZN21vek9FclY5?=
 =?utf-8?B?cStrVXlpV0tIb2R6TFkzUmRsZ2tpYUdkVmFtbEFGODIxd014YUlseVJ4QVdq?=
 =?utf-8?B?cXYvSjFWNWNJOWZmRUt4aHdrQngrQnA4ZjM4cVRxT041WXRUTXhQMHIrMXdx?=
 =?utf-8?B?UjVNeEdWNnpkTHAxL3lBU0MyeWhBUzYrbWo4MENyOWNjU1cycjNGUFhLRGU1?=
 =?utf-8?B?NkkzT2VDV2k2VFBQWHFiYzRHemVpTWc2MmFJNFBiMDhvOXJaK0RLMDRaNCtQ?=
 =?utf-8?B?T2dqcXVXTUpWUzRCNFg3OU92eXUzSE9TTU9vMVIyTVVneGZDOERteGd2UkZl?=
 =?utf-8?B?T2RhZ0ZIMm8vZGNsYlFBai9zTkNZb1hyS2VVNmxPTXJPNVJMK09GOEtWM3FQ?=
 =?utf-8?B?UnNhdkZsZzJ5RTZnU3FSOUlYWitwYzBSeit0YTJhSEdROXk2cXByazRaYW5G?=
 =?utf-8?B?WXREb1BpUFlELy90d1F5UUtKb2RxTVNtZ2dwR1JoYXJBV28vZmtMMFhEeTFB?=
 =?utf-8?B?N1BSYmdHQVdFUENUdm9GSzhCWWltV2Z1YTdINGhOWkNOOXZoaXdoMWFHK2h6?=
 =?utf-8?B?c20wanMvN3pEK0Y3Y01SZy9mVHBFZy9VR0dNVmRTV3VGNU5OYXlBYXZ0eUdC?=
 =?utf-8?B?Z0NGeUhuQStUcWhCaURtS2tLZlRKSkhtRnhtL3RsQjV1SWRtOG9ZaWNWWnVU?=
 =?utf-8?B?aitCcXNORzhNV1lldk5nbzlNd3hNcG0zS0EzblprRlIwYWlkdUFmai8zdEdX?=
 =?utf-8?B?UjBIeGlzUmVmUjh0OE1vUGlYMVYzZ0VrVy9aZnNYNTJ2bUNkNm40MW9neTdL?=
 =?utf-8?B?blhPZVlWb09MQTlQMS8rMW1vUWdIbkQ1SnpYMEFSN202UjhoOFcvWUV2NDhz?=
 =?utf-8?B?elFYSFRKeVRlU3lLa0ZlZWJxY2FoQlpGR1hCNERNRnlVRnpHNDJwQk84VHdV?=
 =?utf-8?B?Tk5ydmRFSi94VFMxSWJDaFNySFR3M0RXQWJxR2VSSlFOOE9ubFk2aEtiS3Vq?=
 =?utf-8?B?Y2VPZDhwdHE1eDJld0RjOUZQNVhrMDZUWEl4amVwQmkwNXFadTFQUjFCK1R4?=
 =?utf-8?B?Zkh4ZzkxT2VZS2lUMmdCNm5KUm9NTlRxRW0rWHBlc3NhL0VLNjlvSkt1dndF?=
 =?utf-8?B?WUZ4RXB2YkxCY1ZRb1V3Nk9qUU9GVml4c21BS2RwU3A4VW1IYUFaOFJrd2dI?=
 =?utf-8?B?akFRVFFEZ1FaOEpyV3BrQ2hPbDNsK0cva2hQMjZiMHNBZzIvK2NhQkE1aFRB?=
 =?utf-8?B?MFViR1p5cHdvMzIyOTBMQUFtaUduajdjT0VjZFg5V0tSbFJUcCtVcGp1TVZJ?=
 =?utf-8?B?SW0xMUN4K2NMTEVaZWladVhBb2wxdU9RRHV4YktEVDU3TEZMTUJiMDZUUDRR?=
 =?utf-8?B?K1dpREFtVnhiQjNRbkdWME5uWktLWk5kM01hZXlBRjJhTzJuZno0V215bFBI?=
 =?utf-8?B?TWErUmRuWC9TemNLZ1U0cktUd0V1TjdGOUN5c2pWWkViYlU3WUU2L1BqbjVj?=
 =?utf-8?B?NU1GUHJ1RzhGdS9JY0pLeExTc1B6OG50RDdiK2diSXF3K1RRWHJJcEFra1VN?=
 =?utf-8?B?ZnEyRTBhSUxPQ0Q3TE1TMTZwbUpHNnNiL1VrWE9wdDljOVBNWjIxVmlwS2cz?=
 =?utf-8?B?TFNQLzZiOHFUYitwUDlKK0lkY1lHNmRDalZKOFkrSEUzTlg3eFNOVHhUNXBP?=
 =?utf-8?B?bzFKd3IraGVDc3ZlZHUvdnFIcTZuYVJjQ1U3RVlIZW4xM3QxaFl4dndtc3hi?=
 =?utf-8?B?Mzk2amVBdWQyeit2Y1ROTFh2NE5JM1lhOVM2Q2h1U0VldzYxM3NSaVZuMk1F?=
 =?utf-8?B?RHlsY2FFaGJ4WGhEMVdSdGVjZHExalJoNGNFN0o2ZWNTYkpoWGJETE95a1R6?=
 =?utf-8?B?Z2JzWVo2L1RZQXUrZ2N4Y2xRakhXSDB5UUxJWFBlL0RkSTlidnJDOXNnRlUw?=
 =?utf-8?B?OGJsczNDUlZSQ1c1b1doOXpBa01hK1RiSjZ3Sk1FR3dzR2s5RXZFRTJEaEZy?=
 =?utf-8?B?T05PY0Zhd1BDVWNFMWNPejM3OEtWZytHNldyMGtZRy83Rm43c290K1F1d3gx?=
 =?utf-8?Q?Di/GQVhZasCmOrIJbZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a9ab3c-9a16-4350-8874-08df3e5da0fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:33:16.5646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYii+/PaJjIm67VRT+GGZGZ/n6TgYCIgDaPyd872EcegupSm9FIxHyIr1h8rFidr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

On 10/21/26 04:58, Huang Rui wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Add amdgpu_svm.h with SVM data structures and public API:
> - enum amdgpu_svm_xnack_mode: OFF, ON and DEFAULT mode
> - struct amdgpu_svm: core context with drm_gpusvm, kref lifecycle,
>   attribute tree, rw_semaphore, GC workqueue, xnack state.
> - struct amdgpu_svm_gc: garbage collector with workqueue and work_struct
> - Kmem cache helpers: AMDGPU_SVM_KMEM_CACHE_CREATE/DESTROY
> - Locking helpers: amdgpu_svm_lock/unlock/assert_locked
> - Public API declarations (including clean_queue, sync_work)
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h | 195 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   4 +
>  2 files changed, 199 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> new file mode 100644
> index 0000000000000..72f954d2df39e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> @@ -0,0 +1,195 @@
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
> +#define amdgpu_svm_assert_in_notifier(svm__) \
> +	lockdep_assert_held_write(&(svm__)->gpusvm.notifier_lock)
> +
> +/**
> + * struct amdgpu_svm_gc - SVM range garbage collector used for unmapping
> + * SVM ranges in response to mmu_notifier events.
> + * @wq: Workqueue where @work runs on.
> + * @list: Ranges list in garbage collector. Protected by amdgpu_svm.work_lock.
> + * @work: Drains @list under amdgpu_svm.svm_lock.
> + */
> +struct amdgpu_svm_gc {
> +	struct workqueue_struct *wq;
> +	struct list_head list;
> +	struct work_struct work;
> +};
> +
> +/**
> + * struct amdgpu_svm - shared virtual memory context
> + * @gpusvm: Embedded drm_gpusvm base, manages the range/notifier trees.
> + * @refcount: Reference count guarding the lifetime of this instance.
> + * @adev: The amdgpu device this SVM context belongs to.
> + * @vm: Back pointer to the owning amdgpu_vm.
> + * @attr_tree: Interval tree of SVM attributes.
> + * @svm_lock: The driver_svm_lock described in the GPU SVM locking section.
> + *            registered by drm_gpusvm_driver_set_lock().
> + * @work_lock: Protects the deferred work queues such as @gc.list.
> + * @gc: garbage collector for ranges queued for destruction.
> + * @exiting: Set once when the context starts tearing down.
> + * @checkpoint_ts: IH ring timestamp captured on unmap, used to drop stale
> + *                 faults.
> + * @default_granularity: Default range granularity.
> + * @xnack_enabled: Whether retry (XNACK) faults are enabled.
> + * @invalidate_ranges: Callback of the MMU notifier invalidate event.
> + */
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

By now we have figured out that TS in faults are not useable for fault handling.

Background is that they reset from time to time because of GFXOFF and may vary depending on the engine who sends the fault.

Adding Timur from Valve on CC, he send out a patch to completely remove the existing timestamp handling from the fault filter.

We need to come up with a different approach here.

> +	u8 default_granularity;

> +	bool xnack_enabled;

It's probably ok to have that here for now, but that will become a VM property in the future I think.

> +	void (*invalidate_ranges)(struct amdgpu_svm *svm,
> +				  struct drm_gpusvm_notifier *notifier,
> +				  const struct mmu_notifier_range *mmu_range,
> +				  struct drm_gpusvm_range *first,
> +				  uint64_t adj_start, uint64_t adj_end);

That looks a bit questionable. Why is that a pointer inside the amdgpu_svm structure?

Apart from those questions that looks rather reasonable.

Regards,
Christian.

> +};
> +
> +static inline struct amdgpu_svm *to_amdgpu_svm(struct drm_gpusvm *gpusvm)
> +{
> +	return container_of(gpusvm, struct amdgpu_svm, gpusvm);
> +}
> +
> +/*
> + * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
> + * Hold it in write mode around structural GPU SVM updates, including
> + * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
> + */
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
> +
> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
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
> index 9b07df5a2b816..b435e393be154 100644
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
> @@ -381,6 +382,9 @@ struct amdgpu_vm {
>  
>  	/* cached fault info */
>  	struct amdgpu_vm_fault_info fault_info;
> +
> +	/* SVM experimental implementation */
> +	struct amdgpu_svm *svm;
>  };
>  
>  struct amdgpu_vm_manager {

