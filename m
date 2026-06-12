Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E131CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82BE10F47B;
	Fri, 12 Jun 2026 12:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZlCoUQBJ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6312B10F47F;
 Fri, 12 Jun 2026 12:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwfwNj5bb3ozOj+H7zuM9jzJlq47abon136+DVpXZAQcWbFfnk9BpkWuUL9JvyMVR/Lb1YnlJul+k04lX76ivcbUW0J3zTPjXMuB8UMoxrvnuNQw9ndzYD3z0fhKPSBpw6CDFaZp3ZYwmiC3bE5Bz9ypgxj/TR8fsAVI+/38dOa5PbBVCRerRJF9MOj8D7M2Cd0AQnxH+Kc4i+DAsEXb6oC2+EqT+tOChlf0lbo5zZU3Tb18A15lKGiNw7sylAQx9bGrvuoj2lB7pZW+0usyjbOVVaLLk/Qh1t6dI9eAp519eTSm/294O+KUp/XFVDmk/27M4Ua/GzAPnghHiIW2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxuhCQvD6vqi+TJg423ISeegzxj5pqfu4E54MZG//1Q=;
 b=kpueOY6Jlgm0Y06/DpxlYADksvD6rxrOo1uuV6GplDAK2hkTNm2DUSEsJAd0VJXAmk1SAu3CdhqSp//U71enzSwaW33hda+BctwwM9wSGX+9BtS1Fq2lWfTrDKbl8ME1CK0VrNbHXrtP9/bHMrT6ch9FLwuwydNdJatCHsuYD4KBZfeUd5jtknmVYnw6N8nKNIuyOvLV8XdccHlxMx40wdbrfX7bu/fBLCoY66LJ/RKhr3Kg7sT0mcV/Kbg1RGbVXtD802q1F/MFcVPObRR3yvJTpWWsKWxeNhorKnGVMoCzLHwCPbfg0M6Mqm5FvXhma7YbZ6zDQ9wl1ViMxnujfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxuhCQvD6vqi+TJg423ISeegzxj5pqfu4E54MZG//1Q=;
 b=ZlCoUQBJbgSye395oBsJXX6g9Z3mZVaTv9nvulN1Zk/mbUVhXWgI9D171tZKgAo0UrLFT7vfc17gdKV8mT4eRgxGce+9vdgx74vh8tCy55NF0OLlVgfsHXUzrGxxje5PFtoL6SFDyvyQozO1bjkDih7Y1xehpr9bE5PSxuTeRq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 12:03:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 12 Jun 2026
 12:03:40 +0000
Message-ID: <e71a85ef-2b75-4870-841c-c23849918275@amd.com>
Date: Fri, 12 Jun 2026 14:03:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/18] drm/amdgpu: add SVM attribute subsystem types
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
 <20260612090928.29682-4-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612090928.29682-4-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2dfc02-40aa-40e1-0ada-08dec87aa4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|921020|11063799006|3023799007|6133799003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3JGfQIm6CZkDfI90eaPPna0/+G13hmFYQPr7OBYiAyXcU/+bHpWYOmhUPEtAEPjjKNllXBOCt4DrIw/Gl3vUxj3PO/qHvpCSY1oAb0PQRJqytXUJLkDjLtRgDeJoHzEAyIPkpv1g4Q6ZN577dLbvwNGToGokNlEpgBiuh6PwqP73NJ6z0L+jzH23/IU96F47JCKgSjC+jxav4jm3CBsXqb2G5kuWfRaMgSy7Xscmrm0lWwECMsiiPzhRrwsqL9fxszIGH7sn8ASgy3VCsm5T4jMhzPKy0ELLUVjOgJbXtIk1fz5NPXUmAhsZd14/T/Z/xPZpqNwbWCwqVtoxCVCpyQCBilQ6zYKVyUSRUKFu4ZbWCYVJ6IevTf1ZWmAbfIxdqFXzsCG0xGR2etjTOg2yh8683bWNtUz91ZAU1zODOy+IiLP/fFBp9X/446pR21xSjYuoBxOK+R8oKwnYxdKeRqgico0as+cxfdJ7EYBs1Otz8wFl24CNqG3kjZPcaqWINc5zWWNtLCd1PFvgph6IYj+/o33c7UCHELS1zNM6PEn9D279d4FhQ2m4DyvL55hUq+7NHAU6oUsrUJmm+H/PrkB2073E2ErEC6IX7/JwR/XyEBy3/Spg2U5yxDKO6Wvfe+j8HVDcYHpgVRhhvWF0jkd2ovtp2k4x7U7sdHSoag3slN3UhpLcI5CqMSI2B9BRCw3oxLfUnPFk+4Pkca3ElM5YZwZY1KYyVPtVVCR1hNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(921020)(11063799006)(3023799007)(6133799003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnVLaDdiZXRrdHZuMGRwdk1wenlhVC8rWEk5c243OVJBaHB1ODYwMGVkOFBD?=
 =?utf-8?B?OTNVeHJ4dk0zSHJucy9OUW5NT3NkOFhSSjA4Q0tYak9qeUlBck5XVDZJb3ZV?=
 =?utf-8?B?N3VYM2pWd1hraGRTd01qa0Q5ZVk4WUFjS1R1czBLVlpTa3FRL3k4N0ZsSUxk?=
 =?utf-8?B?ZEM3a3Zxb3AwT1ZGVjB3cFEzbUhqeG1yTitqQXpkUkxubnFjVUJENEZYdTBM?=
 =?utf-8?B?RjdveGNuRnIrWm9Tcm9tZjgyV00wNm5OQXR1ckR0ZGZnNWhLL2ZraU9yRGtI?=
 =?utf-8?B?N0tQSzNsd2lpTjcycko3RmQ1enRscnBqcyt2ZnJvQmpUQmdBbUZSVTkwK3hy?=
 =?utf-8?B?djJRdXVBZy8zQm9FeDRVQUdaQ0lDclVtTUo0ZGZuQU5HS0JhWXlOSjU0bDMy?=
 =?utf-8?B?Nmwwa2VUMGF1UnJkc3MwL1hzZUg4aGExbFMyR0ZWbk1KZUx0cUtrYlJEamxI?=
 =?utf-8?B?MWNZNm5OYUMyNVdJTEVRUzQxSlpSQ1czbzVETUNJVTFoZ3Y2M0xxYzY1cGlS?=
 =?utf-8?B?dUpBSlhDZXRsOEI3UTNqa3FoUko2d0dXTkt5SGxtcFM4MkVaL1krSm50S0x6?=
 =?utf-8?B?UUNQMThUL0ZQMW0ralpTTUI2WnBFSnIzcm1YVjUyZzJJWmtOUFdESFVYRjFi?=
 =?utf-8?B?ZzEzOHVuSEFQeEZrZzV2eUVBS2lONlJjT29ZYVUwbDRFeXZrR2RNZXErcVJo?=
 =?utf-8?B?d0o0NlZKYWsxc2lvSXEzZVJxU3hCbkU4WHozUWhjMEM3bUpvVnZDRE8rVEJK?=
 =?utf-8?B?SUhiemNSa3Rqc2dhUThvM3l5OUlMRFBXYi9Jbkh6Y2hvc1hBdGZsQSs2VzRE?=
 =?utf-8?B?OG5yMklFMmlNZWhEMDI4cTdFaGlOMG80YWRCemRxaVpTWXF1UHBtdzRuNWZJ?=
 =?utf-8?B?eDNPOEhmSXJuYUdRN2lJK2xleDU2bWRQL1U4SzRiL1pWWmp4VzZVTEo5SWQ0?=
 =?utf-8?B?QURHaVYwUUxnVXEvdFYyZXMzUXpCek1LOUlCZnZyVEdEVkpSVlhCSUdGeldD?=
 =?utf-8?B?V1hnK3NSSWhGZm5jd0luR2pJK01USUh5UURFYzN6S2ovaUlBdkkyRllqN29n?=
 =?utf-8?B?SjBnalI1ZndRemdZZlpxQ0dDUVVHaGpPczdGVVRBMmFTdFdUMmNLS3ZZZVFn?=
 =?utf-8?B?U1JySWQwUVlpczhZYXV1UG5FbzNMcklENnJYQXlRbER5Ymc0NFRoZVRzcjk5?=
 =?utf-8?B?T0tTam5JTW9sWnFCMDAzQXl0TVpqQXlIVDVqdXFrZjZlRE5NOTlwQ0hxcUI1?=
 =?utf-8?B?TVo2VmhvRzFQVmZWZTc2a1VCdmlqWHA4b1lVVU9PSVBQRk1YUzRaZWJUbm1J?=
 =?utf-8?B?MjFuYmxMZ0lSZUd1dm8ySWpmNElLZW9tYXA1Y2VQV2lCSld1V3pmai9scFBt?=
 =?utf-8?B?ZXkrRDZISCt0ek90K3NuUTJXY2tpVkgwVDVYTDR2QkRGUGs0U0puTk5iaEsy?=
 =?utf-8?B?MTdxRXdJdTRKaWE3TWZmeTREUzc3bWhHVGNHa1g2a29IbXBpakdGMytpc2gv?=
 =?utf-8?B?Qk9iaWM3Z0NnellmV1pCcHdVc21OaHU1SjdZS3QvVldvaVplcWpzVGNucVRl?=
 =?utf-8?B?K2dWaldrbGhNWVFyRXJzbkRjTW1rMDBadVNjaDZNMEdTZElhNlk4M0FOM2Vx?=
 =?utf-8?B?eCtISFNnaGljUGpWYzFrTDIzTmhlZitucmhzMVZaeEhTYng0SVBidEtORXcw?=
 =?utf-8?B?M2xhOE1iRExqWithQnJscEJZTzdjb0dlMklVazJRNWEyTzdGSzREakFHNE5j?=
 =?utf-8?B?TVR1RHg4c1Zncm5kZEdkbVJuSXdFZUViY1duZW9zVDJrdlFtam9iOUh2Q2N5?=
 =?utf-8?B?RlA0ZnpCVGVUSmVyTDYxblhEY3lIUnRSQWhxYVp1NW9jd3dVZGFEc0Q3emFy?=
 =?utf-8?B?U011bzR0TC9BaEJRcnBHMll4QndhUElKdWVrVlFnaTRsVEZCcTRNTllqKzdN?=
 =?utf-8?B?NnJtWmNsUUUxWG8veWtyQUZMTHF5d0pyUjdrblVCOENta2NLMkJlcFIxREt5?=
 =?utf-8?B?WmJrREtLMGtwVnpqdmNaNW5xd3BpYlMwVGtzNEV5RW5RTFY4Qk1tZzliUXNH?=
 =?utf-8?B?dlpidVlRdzl1cUFyM2t2RWpYbnFldnd0aUJEWnprV1Q0bFE3SFpaZGxWRnFx?=
 =?utf-8?B?d0IxS1lqOGd1SFY4QTNiaEFWRWwyVTF5aGxvcVZJL2FUZExuR0pwYzQ4MHVR?=
 =?utf-8?B?MmpseDJpRDNKbnN4bUpqRXVWUjhoSVJleXBUUTFKRGYzdjBPeDFRSENSL3FQ?=
 =?utf-8?B?cFJDTCtMUlBMQk5Vczl0S0kvMVJPUjI2OTR1TFhXblFEaXhLWFBwTVk2Rm9i?=
 =?utf-8?Q?i6TxAENcXJMFaM0eSH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2dfc02-40aa-40e1-0ada-08dec87aa4a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:03:40.8775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5pkko99GabAbc2gyyuJ26fG+FXWVTVK/bQA/QlLYy+vIoqf5WYwfxX5laFpEBjH
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
> Add amdgpu_svm_attr.h with attribute types and tree infrastructure:
> - Internal flag bitmask definitions mapping from UAPI attr types
> - PTE_FLAG_MASK and MAPPING_FLAG_MASK for change detection
> - struct amdgpu_svm_attrs: user set attribute range
> - struct amdgpu_svm_attr_range: interval tree node with attrs
> - struct amdgpu_svm_attr_tree: mutex protected RB tree for store and
>   search
> - enum amdgpu_svm_attr_change_trigger: change flags of user attributes
>   change tirgger
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 171 +++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> new file mode 100644
> index 0000000000000..4181ec3bdb046
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> @@ -0,0 +1,171 @@
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
> +#ifndef __AMDGPU_SVM_ATTR_H__
> +#define __AMDGPU_SVM_ATTR_H__
> +
> +#include <drm/amdgpu_drm.h>
> +#include <linux/interval_tree.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/rbtree.h>
> +#include <linux/types.h>
> +
> +/* Internal SVM attribute bitmask flags mapped from UAPI ioctl definitions */
> +#define AMDGPU_SVM_ATTR_BIT_HOST_ACCESS		(1u << 0)
> +#define AMDGPU_SVM_ATTR_BIT_COHERENT		(1u << 1)
> +#define AMDGPU_SVM_ATTR_BIT_EXT_COHERENT	(1u << 2)
> +#define AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL		(1u << 3)
> +#define AMDGPU_SVM_ATTR_BIT_GPU_RO		(1u << 4)
> +#define AMDGPU_SVM_ATTR_BIT_GPU_EXEC		(1u << 5)
> +#define AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY	(1u << 6)
> +
> +#define AMDGPU_SVM_PTE_FLAG_MASK \
> +	(AMDGPU_SVM_ATTR_BIT_COHERENT | AMDGPU_SVM_ATTR_BIT_EXT_COHERENT | \
> +	 AMDGPU_SVM_ATTR_BIT_GPU_RO | AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
> +
> +#define AMDGPU_SVM_MAPPING_FLAG_MASK \
> +	(AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL | \
> +	 AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY)
> +
> +struct amdgpu_svm_attrs {
> +	/* keep preferred_loc to adapt to kfd API */
> +	int32_t preferred_loc;
> +	int32_t prefetch_loc;
> +	uint32_t flags;
> +	uint32_t granularity;
> +	enum amdgpu_ioctl_svm_access access;
> +};
> +
> +struct amdgpu_svm_attr_range {
> +	struct interval_tree_node it_node;
> +	struct list_head list;

This needs more documentation. Why do you have an interval tree and a linked list here?

> +	struct amdgpu_svm_attrs attrs;
> +};
> +
> +static inline unsigned long
> +amdgpu_svm_attr_start_page(const struct amdgpu_svm_attr_range *range)
> +{
> +	return range->it_node.start;
> +}
> +
> +static inline unsigned long
> +amdgpu_svm_attr_last_page(const struct amdgpu_svm_attr_range *range)
> +{
> +	return range->it_node.last;
> +}
> +
> +static inline unsigned long
> +amdgpu_svm_attr_start(const struct amdgpu_svm_attr_range *range)
> +{
> +	return range->it_node.start << PAGE_SHIFT;
> +}
> +
> +static inline unsigned long
> +amdgpu_svm_attr_end(const struct amdgpu_svm_attr_range *range)
> +{
> +	return (range->it_node.last + 1) << PAGE_SHIFT;
> +}
> +
> +struct amdgpu_svm;
> +struct mm_struct;
> +struct vm_area_struct;
> +
> +static inline bool
> +amdgpu_svm_attr_has_access(enum amdgpu_ioctl_svm_access access)
> +{
> +	return access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE ||
> +	       access == AMDGPU_SVM_ACCESS_IN_PLACE;
> +}
> +
> +struct amdgpu_svm_attr_tree {
> +	struct mutex lock;
> +	struct rb_root_cached tree;
> +	struct list_head range_list;
> +	struct amdgpu_svm *svm;
> +};
> +
> +enum amdgpu_svm_attr_change_trigger {
> +	AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE = (1U << 0),
> +	AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE = (1U << 1),
> +	AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE = (1U << 2),
> +	AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE = (1U << 3),
> +	AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE = (1U << 4),
> +	AMDGPU_SVM_ATTR_TRIGGER_PREFETCH = (1U << 5),
> +};
> +
> +#define AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE \
> +	(AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE | \
> +	 AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE | \
> +	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
> +	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
> +
> +struct amdgpu_svm_attr_tree *
> +amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
> +void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
> +int amdgpu_svm_attr_cache_init(void);
> +void amdgpu_svm_attr_cache_fini(void);
> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +			   unsigned long page);
> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +				  unsigned long page,
> +				  unsigned long *start_page,
> +				  unsigned long *last_page);
> +void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
> +				 struct amdgpu_svm_attrs *attrs);
> +
> +int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
> +			   uint64_t start,
> +			   uint64_t size,
> +			   uint32_t nattr,
> +			   const struct drm_amdgpu_svm_attribute *attrs);
> +int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
> +				       uint64_t start,
> +				       uint64_t size,
> +				       uint32_t nattr,
> +				       struct drm_amdgpu_svm_attribute *attrs);
> +int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
> +			  unsigned long start_page,
> +			  unsigned long last_page);
> +int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
> +			  unsigned long start_page,
> +			  unsigned long last_page);
> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_range_alloc(unsigned long start_page,
> +			   unsigned long last_page,
> +			   const struct amdgpu_svm_attrs *attrs);
> +void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +					 struct amdgpu_svm_attr_range *range);
> +bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs);
> +struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
> +					unsigned long addr);
> +int amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
> +				unsigned long start_page,
> +				unsigned long last_page,
> +				unsigned long *bo_start,
> +				unsigned long *bo_last);
> +
> +#endif /* __AMDGPU_SVM_ATTR_H__ */

