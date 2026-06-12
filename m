Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2D1CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D9110F4D0;
	Fri, 12 Jun 2026 12:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ErwItn0L";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A64510F4A3;
 Fri, 12 Jun 2026 12:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsgUJzzrRv3GPpif3txc8Dd2iWhxYLgv/tO8zFKXeKCZNPnIlZYaW3MsbrRo1GAhPHQdmNOSuNzRo6FPaPyQurTakYouL+RKwPwkCjOX1v+U2NsFDHTOa6bnPlQjct5sPz4MZbKE1ziL5xd5m9WTimHq392JYWBIur2TW1ogt0K2gD1aT+f0DonqrBw+FRaYStM73YnvOhhOKnsThMNcdOs7OglmCMCAa0GWSyGhZCkfvS/fPndalaYMm5BqdOUssvbiT46gN14eVRiYz+IYkxk5JsXSk4P/4vzRgC0GcVvRK7hBlSX5p7NSSGXlLiTsNoEU7o3nDadpNLYmTWJ4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihbegeMwGolyuxYPa0zXycJ5SCwlnSogk+nRglUDsCs=;
 b=wInEhsA6ZybZIXKDjA9eNW7fBWEMexNqHroy0C/rc7LTlTjKl691biFsr3EKJkQyuGRGX03pmFPEmCdPWVafmmEXfK4ib4OdUHRexxiG8mMUjgd4yJdV6G3RBLYsw6pr2bGJoyZZFt+0Fper3UvFTBe7cvdansxGkYG98QQ5+POM9Y9SNPIJrNKJIxBdz2hCcZESE+dKR/7GYTAPLQ8f+MKaeAF05pnybeXPP5ECT7UEt8lle5qmQrrkAoRtOYOBjLebMWLCAmmKlA8pv83Am1XZSV0blRMPDL10YFtFeP5sCXsU1ZJniw9SuMGaggMcHpjOA8/aAAkAJapzAJoLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihbegeMwGolyuxYPa0zXycJ5SCwlnSogk+nRglUDsCs=;
 b=ErwItn0Lno5KVGc42kwUJ0ZLOGw1EhDBVFEYAvYSSPaarSNy3ZsWvASQz/092plGzPuZbgyhbW9nT0OlzHuAMwS266GV4Pr6gefQqYenDJolzDuzRXHYlcSyYDsATq7nP75k2hUoqZcXAv/B7G6/G3Bv90T18wLhac+m0exEHAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 12 Jun
 2026 12:21:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 12 Jun 2026
 12:21:12 +0000
Message-ID: <7d073e2b-0a7c-4e42-a67d-32817596d238@amd.com>
Date: Fri, 12 Jun 2026 14:21:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/18] drm/amdgpu: implement SVM range GPU mapping core
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
 <20260612090928.29682-8-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612090928.29682-8-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cfce5e-b91a-4271-4f00-08dec87d171c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|921020|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: V96pmJR713Nqv3Pr95nslwMuv9hEu7xjz4iSQWsOpMIEDjMMspIE/Xl76HlkrNzuOICMcPtkoCs7sS1Q78K7WWVOwry3ufnTMYuoLaFiASROxaNt+7ibWylFW2zr//43BtFUq5JPfLMqXR/RjYuOEdxNWt36qcX1XPsG1cN7lOtuJDvtYSfgnf6t2k766LOGcYyKnp/sUeOuNdsOFBWTUXXH85ULbKzxCeQnRG+FMJetpPgw16whcxn5UbpE1Zn3BF565I2gbWvbEYoqw8ITcq8A9DfK0mMJHwpTyUCkmXJlrNowfwu0r4xQWz7Ky3ojGaJGXupj6nm1Ev/+PYuKH6bif3X5WpgzTd/g5zl+uMtOaAT69dS2b4yBjjQQE97aCMNpc4V/+aRp5aIcBARA1GfC0J95ytDJkrGzKXO8VLbJjlw8PyHZUdFqk+DdlM03BCM3MzAg3qeaJhEtFcbaoMKwfarTRv40hLTw4/5iFYuVHRBXcfN3vt+Jdz6AC6IzB51qJ788K5WgsqrjADWqs+uFkong2GB3XEa2AHqvtFFaMIpr4wTcMKeBsgaiEy79gXYn1ybSJer+e0Rfbry0vGjkR3fX9VuTFXfrCAHVrzs4MfSyJLFCv4PA2amMt+1q53L/YO062bEZIRn6zfiqS9qJ63NZKinajs74uC4UTHyD6hVjU3q8xjTQCZutRYiAsNafRJHCwh1sHDEKODgO8PpNEScijcNRv1y52hQtBL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(921020)(3023799007)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c29IRGJxQ2Zzb2VTR2V5SUI2Nm0zSXh0SExwenNPRzRRYno5anQ5bit1QlZx?=
 =?utf-8?B?cFE2UEtUcTJmUUpoQlFNUlVmYzBSVE84K3FrSXM5SjAvZHl2TzBNSHA3YWYr?=
 =?utf-8?B?ZUtWZVNMcEZrbVhRWTFXbjJXeGZLMEo3ZDNucjczZ3hKTkIwZXpTclVZRlRV?=
 =?utf-8?B?R3NFVXVsSHlUVWEyTEVWMHB6QlN4Mzk3THdLQnczbEh6VG1Ud1JWSXdrb0RQ?=
 =?utf-8?B?OGdOam5wRWppemYwZzBjWXZzWnZaZTdPaHg5Nm1mUnJkemhvcEJ1cE9SZ2x1?=
 =?utf-8?B?L21ZTVk3ajZ0Q1crcXVUWjlOUVA5YXRreTdSaFVhZXN0bzZLL2thNU1QUjZu?=
 =?utf-8?B?UXluTTN1a2VISUs1MDFJSWVJYnA5eFdmaHh5dzgwdmswcHdHZEhuZW5PWHpZ?=
 =?utf-8?B?cHJRR2RtTElxbDZHNVUvemVVMmRMY2c0b2dDTXFNdy9MdmJ6RE1kQzZmdE90?=
 =?utf-8?B?bldacW1pcE9SUHNRK2ZCUjBoVTdjNGYrNkY2WldFM3ZNT0dQS1NodUI5VktM?=
 =?utf-8?B?VkJBQnRpNlBJWVJWWVpWRUFETjZnalFRcFJHdmpRVTZOTFV0cTM3L3hmdkFi?=
 =?utf-8?B?ckxjNmZZaHN5VU9NMTIweEtLS01FaWpKVmkrODUrMWZhdGhkVTRjSHFXeUd1?=
 =?utf-8?B?SmNLTjBDeXFuZ2NLWWI1YmF2VTg5RzcxZ2tGbEZpcFRXL3piRDFzQWUwaWtW?=
 =?utf-8?B?V3hjMmpXUEVrenNoWUVqdGRNQ1FjUitLMHhmQ2twdDA4cDZXcWlSUkRKYnBK?=
 =?utf-8?B?ZzNwSXlERnVxM1p0SEZHWEtiVGZSRUk2TzZmOGh3QU5XU2hnTW5UUjQzaUwr?=
 =?utf-8?B?L0FlbVViOGh5N1pWT3Q1Yks2b3Y4WEpnWUY0bHNPMVBXeDVXVnAwdzE5QkhI?=
 =?utf-8?B?eWt4MzRWRFNrbHJzekxveXN2dEZxS0NTZDVVUEQxcGtabm5CSGt1eGdwZ2kr?=
 =?utf-8?B?RnVGTFhRT3ExTkxqbEVlYnNzZkZPcWNUL1FoK2NhUnhNTkJ4d3dEZzh5LzZO?=
 =?utf-8?B?ZjFOeHFJWkVjZTE4NHBycUpjbFY5Mk9WKzdESGtrZ2h3VjF4YzZraSsvdVBL?=
 =?utf-8?B?MUowTC9NNGFaS1NTUndwTFZYdFR2dW5kVGMrMzdkTzlEeko4am94VU5JNzhn?=
 =?utf-8?B?am9qL0dvZ0VhNmozM2FjcXZ3TVd2Z3ZNUHV5QUJpSUJsK1NHcFU4a1VHR0pN?=
 =?utf-8?B?SnRYb3NteE04QTdaVVN5c2FRUHpMUWpJNERxcXNwbXBmU1gvNTRRM0FyS1Bp?=
 =?utf-8?B?dXI2aVFZN2hkTm44cVB0aEpUWTkrNDBsckFxdHBnNUQyV2c2TU9wYlVEbDJE?=
 =?utf-8?B?UWY5bkpibnV1SHJSUWkrZlJjM2R0ZGxaZGVnY0RzZkxvVEJFMXBhQUhiOTJG?=
 =?utf-8?B?dy9yT1NFRUI2cXVOa1JmdlhhbFJIK1BWMlBiL3g5emY0RmduWldIb1dQMURa?=
 =?utf-8?B?YW9EbzU4L1YyUDhHcTRURlhIcXNEU0RkNWx3MkVmWFJlbTFZMkJXOG9jK1Ey?=
 =?utf-8?B?RllpeCt2WGVqYWNxcWtPMmZYRnQ1Y2xtdzVKbHdjd1FxUVgyYVdPajdMK3da?=
 =?utf-8?B?clFUTmI2UW13R3R4UC9nWFJ6K0I3VVpPeFUxTzR3dDA1VFhma203QUhuZGlh?=
 =?utf-8?B?YkwxelBTdVJlYXZReXVDMWs0cFZTTnBSc2YweVZwRXk1UzVob3p6bFZrcXVQ?=
 =?utf-8?B?NjFabXE1T0NmR1M2S2JMTDhqSnVhbHhxTFpJK1dSVDdKRkluc2J1UWdqaVRS?=
 =?utf-8?B?aVdSUGYzaHVibzNiZDNNZ1hBNzdQUVkycmg5S2pRSHBPNlZueVJUTGJyUXE2?=
 =?utf-8?B?ZEJKczdqWHVlRWVwMUQ4U0tBWGhCcHlXNE1lWCtnVFkyaGhvNWFuK1RxUklQ?=
 =?utf-8?B?ZlE5YUJmNHFhbUc3bGROYVFjd3hITlV6REtZU2RwTzN0Tm56cVdLTm5oOEh0?=
 =?utf-8?B?MXdEakkwYjIrUm9ENzlKeTNVYjZnSHRBb3F2MzhHOXZ1M2oxQ0ZMOG9QdUZw?=
 =?utf-8?B?V0p1N0NsQlpmYjBrZTloVzBONGNaREtLbllUT2loSmFQdENLcnlsazhPRmRE?=
 =?utf-8?B?MW0rZWYyVkZJY1QzSXhYemJxMU9LR3IxNTZpNWdGWnZMc01kVitLaktIMENE?=
 =?utf-8?B?Vks4cjhSbndzZnRJZEp4VVVXV1VrZCtXZDFXejhIM24wOEZPWkxjZXdYYktl?=
 =?utf-8?B?eFFKSm1ianM5bFVzVDIzd0l6aEt0UlhibVNPZzgzak4yUTJTOGIzNCtVdUNa?=
 =?utf-8?B?ekFqTStCdU0wQXA5ZDBqTnpQeGZZaGhZbW1oM0t4ZU5kSXU0Y0FBdHVpWmE2?=
 =?utf-8?Q?XnyX89qCTwNfLm5mGS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cfce5e-b91a-4271-4f00-08dec87d171c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:21:12.0027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGijliLb247N/gTUF1nNyOMkH26rLgnt/MhYCqLJ74jdR3Y2rfm6J+RiQmzHVJfh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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
> Implement GPU page table mapping in amdgpu_svm_range.c:
> - amdgpu_svm_range_pages_valid: check notifier sequence validity
> - amdgpu_svm_range_is_valid: validate gpu_mapped and attr_flags
>   against the requested attribute set, under MMU notifier lock.
> - amdgpu_svm_range_zap_ptes: clear GPU PTEs via amdgpu_vm_update_range
> - amdgpu_svm_range_attr_pte_flags: compute PTE flags per GC IP version
> - amdgpu_svm_range_lock_vm_pd: acquire VM page directory by drm_exec
> - amdgpu_svm_range_update_gpu_range: DMA segment coalescing; recomputes
>   PTE flags per segment from entry->proto via attr_pte_flags, then
>   programs PTEs under notifier lock
> - amdgpu_svm_range_find_or_insert: wrapper of drm gpu SVM find or insert
>   API.
> - amdgpu_svm_range_get_pages: wrapper of drm gpu SVM get pages.
> - amdgpu_svm_range_evict: thin wrapper of drm_gpusvm_range_evict
> - amdgpu_svm_range_update_mapping: full pipeline (lock PD, validate
>   pages, program PTEs, update PDEs, flush TLB, record attr_flags
>   and mapped state); takes attrs + read_only and forwards them to
>   update_gpu_range
> - amdgpu_svm_range_map_attrs: cursor based iteration across attr tree,
>   creating/mapping ranges
> 
> - Add to amdgpu_svm.h driver private interconnect tags used in
> drm_pagemap_addr.proto:
>   AMDGPU_INTERCONNECT_VRAM = DRM_INTERCONNECT_DRIVER
>   AMDGPU_INTERCONNECT_P2P  = AMDGPU_INTERCONNECT_VRAM + 1
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 488 ++++++++++++++++++
>  2 files changed, 492 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> index 9884a1f834d67..ac84b80f750f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> @@ -27,6 +27,7 @@
>  
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_gpusvm.h>
> +#include <drm/drm_pagemap.h>
>  #include <linux/atomic.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> @@ -44,6 +45,9 @@ struct amdgpu_svm_attrs;
>  struct drm_device;
>  struct drm_file;
>  
> +#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
> +#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
> +
>  enum amdgpu_svm_xnack_mode {
>  	AMDGPU_SVM_XNACK_OFF,
>  	AMDGPU_SVM_XNACK_ON,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> new file mode 100644
> index 0000000000000..e1b392b2cf56a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> @@ -0,0 +1,488 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
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
> +#include "amdgpu_svm.h"
> +#include "amdgpu_svm_attr.h"
> +#include "amdgpu_svm_range.h"
> +#include "amdgpu_svm_fault.h"
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +
> +#include <drm/drm_exec.h>
> +#include <drm/drm_pagemap.h>
> +
> +#include <linux/mmu_notifier.h>
> +#include <uapi/linux/kfd_ioctl.h>
> +
> +bool
> +amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
> +		  struct amdgpu_svm_range *range)
> +{
> +	struct drm_gpusvm_range *base = &range->base;
> +
> +	lockdep_assert_held(&svm->gpusvm.notifier_lock);
> +
> +	if (base->pages.flags.unmapped || base->pages.flags.partial_unmap)
> +		return false;
> +
> +	return drm_gpusvm_range_pages_valid(&svm->gpusvm, base);
> +}
> +
> +bool amdgpu_svm_range_is_valid(struct amdgpu_svm *svm,
> +			       struct amdgpu_svm_range *range,
> +			       const struct amdgpu_svm_attrs *attrs)
> +{
> +	bool valid;
> +
> +	drm_gpusvm_notifier_lock(&svm->gpusvm);
> +	valid = range->gpu_mapped &&
> +		range->attr_flags == attrs->flags &&
> +		amdgpu_svm_range_pages_valid(svm, range);
> +	drm_gpusvm_notifier_unlock(&svm->gpusvm);
> +
> +	return valid;

That looks completely broken to me.

The valid state looses meaning as soon as the lock is dropped.

> +}
> +
> +
> +int
> +amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
> +			  struct amdgpu_svm_range *range,
> +			  unsigned long start_page,
> +			  unsigned long last_page)
> +{
> +	struct dma_fence *fence = NULL;
> +	unsigned int flags;
> +	int ret;
> +
> +	if (last_page < start_page)
> +		return 0;
> +
> +	flags = memalloc_noreclaim_save();
> +	ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, true, true, false,
> +				     NULL, start_page, last_page, 0, 0, 0, NULL,
> +				     NULL, &fence);
> +	memalloc_noreclaim_restore(flags);

That's the same nonsense we already had in the existing KFD implementation.

The whole patch set needs to be rebased on top of my patches to fix this.

> +
> +	if (!ret && fence) {

That needs to block for the fence even if the return value is non zero.

> +		ret = dma_fence_wait(fence, false);

> +		if (ret < 0)
> +			AMDGPU_SVM_TRACE(
> +				"notifier unmap fence wait failed: ret=%d [0x%lx-0x%lx]-0x%lx\n",
> +				ret, start_page, last_page,
> +				last_page - start_page + 1);

Drop that check and warning.

> +	}
> +
> +	dma_fence_put(fence);
> +	return ret;
> +}
> +
> +uint64_t
> +amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
> +			    const struct amdgpu_svm_attrs *attrs,
> +			    bool read_only,
> +			    enum drm_interconnect_protocol proto)
> +{
> +	uint32_t flags = attrs->flags;
> +	uint32_t mapping_flags = 0;
> +	uint32_t gc_ip_version = amdgpu_ip_version(svm->adev, GC_HWIP, 0);
> +	uint64_t pte_flags;
> +	bool snoop = proto != AMDGPU_INTERCONNECT_VRAM;
> +	bool coherent = flags & (AMDGPU_SVM_ATTR_BIT_COHERENT |
> +				 AMDGPU_SVM_ATTR_BIT_EXT_COHERENT);
> +	bool ext_coherent = flags & AMDGPU_SVM_ATTR_BIT_EXT_COHERENT;
> +	unsigned int mtype_local, mtype_remote;
> +	bool is_aid_a1;
> +	bool is_local = (proto == AMDGPU_INTERCONNECT_VRAM);
> +	bool is_vram = is_local || (proto == AMDGPU_INTERCONNECT_P2P);
> +
> +	switch (gc_ip_version) {
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		if (is_local) {
> +			mapping_flags |= coherent ?
> +				AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
> +			/* 9.4.2 local VRAM with XGMI keeps snoop */
> +			if (gc_ip_version == IP_VERSION(9, 4, 2) &&
> +			    svm->adev->gmc.xgmi.connected_to_cpu)
> +				snoop = true;
> +		} else {
> +			mapping_flags |= coherent ?
> +				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +			/* TODO: migration: re enable snoop for same hive */
> +		}
> +		break;
> +	case IP_VERSION(9, 4, 3):
> +	case IP_VERSION(9, 4, 4):
> +	case IP_VERSION(9, 5, 0):
> +		if (ext_coherent)
> +			mtype_local = AMDGPU_VM_MTYPE_CC;
> +		else
> +			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
> +				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC :
> +				AMDGPU_VM_MTYPE_RW;
> +		snoop = true;
> +		if (is_vram) {
> +			if (is_local) {
> +				/* local HBM region close to partition */
> +				mapping_flags |= mtype_local;
> +			} else if (!ext_coherent) {
> +				/* TODO: add same hive check */
> +				mapping_flags |= AMDGPU_VM_MTYPE_NC;
> +			} else if (gc_ip_version < IP_VERSION(9, 5, 0)) {
> +				/* TODO: add same hive check */
> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +			} else {
> +				mapping_flags |= ext_coherent ?
> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +			}
> +		} else if (svm->adev->flags & AMD_IS_APU) {
> +			/* On NUMA systems, locality is determined per-page
> +			 * in amdgpu_gmc_override_vm_pte_flags.
> +			 */
> +			if (num_possible_nodes() <= 1)
> +				mapping_flags |= mtype_local;
> +			else
> +				mapping_flags |= ext_coherent ?
> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +		} else {
> +			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +			else
> +				mapping_flags |= AMDGPU_VM_MTYPE_NC;
> +		}
> +		break;
> +	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 0, 1):
> +		mapping_flags |= AMDGPU_VM_MTYPE_NC;
> +		break;
> +	case IP_VERSION(12, 1, 0):
> +		is_aid_a1 = (svm->adev->rev_id & 0x10);
> +		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
> +				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
> +				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
> +		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
> +		snoop = true;
> +
> +		if (is_local) {
> +			mapping_flags |= mtype_local;
> +		} else if (ext_coherent) {
> +			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +		} else {
> +			/* system memory or remote VRAM */
> +			mapping_flags |= mtype_remote;
> +		}
> +		break;
> +	default:
> +		mapping_flags |= coherent ?
> +			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +		break;
> +	}

All of this needs to be in HW IP version specific files.

Regards,
Christian.

> +
> +	if (flags & AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
> +		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
> +
> +	pte_flags = AMDGPU_PTE_VALID;
> +	pte_flags |= is_local ? 0 : AMDGPU_PTE_SYSTEM;
> +	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
> +	if (gc_ip_version >= IP_VERSION(12, 0, 0))
> +		pte_flags |= AMDGPU_PTE_IS_PTE;
> +
> +	amdgpu_gmc_get_vm_pte(svm->adev, svm->vm, NULL, mapping_flags, &pte_flags);
> +	pte_flags |= AMDGPU_PTE_READABLE;
> +	if (!(flags & AMDGPU_SVM_ATTR_BIT_GPU_RO) && !read_only)
> +		pte_flags |= AMDGPU_PTE_WRITEABLE;
> +
> +	if (gc_ip_version == IP_VERSION(12, 1, 0) &&
> +	    svm->adev->have_atomics_support)
> +		pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
> +
> +	return pte_flags;
> +}
> +
> +
> +
> +int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *exec,
> +				bool intr)
> +{
> +	unsigned int exec_flags = DRM_EXEC_IGNORE_DUPLICATES;
> +	int ret;
> +
> +	if (intr)
> +		exec_flags |= DRM_EXEC_INTERRUPTIBLE_WAIT;
> +
> +	drm_exec_init(exec, exec_flags, 0);
> +	drm_exec_until_all_locked(exec) {
> +		ret = amdgpu_vm_lock_pd(svm->vm, exec, 1);
> +		drm_exec_retry_on_contention(exec);
> +		if (ret) {
> +			drm_exec_fini(exec);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int
> +amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
> +				  struct amdgpu_svm_range *range,
> +				  const struct amdgpu_svm_attrs *attrs,
> +				  bool read_only,
> +				  bool flush_tlb,
> +				  bool wait_fence,
> +				  struct dma_fence **fence)
> +{
> +	struct drm_gpusvm_range *base = &range->base;
> +
> +	lockdep_assert_held(&svm->gpusvm.notifier_lock);
> +
> +	const unsigned long range_start_page = drm_gpusvm_range_start(base) >> PAGE_SHIFT;
> +	const unsigned long range_end_page = drm_gpusvm_range_end(base) >> PAGE_SHIFT;
> +	const unsigned long npages = range_end_page - range_start_page;
> +	unsigned long mapped_pages = 0;
> +	unsigned long dma_idx = 0;
> +	int ret;
> +
> +	if (!base->pages.dma_addr || !npages)
> +		return -EINVAL;
> +
> +	while (mapped_pages < npages) {
> +		const struct drm_pagemap_addr *entry = &base->pages.dma_addr[dma_idx++];
> +		unsigned long seg_pages = min_t(unsigned long, 1UL << entry->order,
> +						npages - mapped_pages);
> +		uint64_t pte_flags;
> +		unsigned long start_page, last_page;
> +		bool is_last_seg;
> +
> +		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
> +			return -EOPNOTSUPP;
> +
> +		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
> +							    read_only,
> +							    entry->proto);
> +
> +		start_page = range_start_page + mapped_pages;
> +		last_page = start_page + seg_pages - 1;
> +		mapped_pages += seg_pages;
> +		is_last_seg = mapped_pages == npages;
> +
> +		ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
> +					     flush_tlb && is_last_seg, true, NULL,
> +					     start_page, last_page, pte_flags,
> +					     0, entry->addr, NULL, NULL,
> +					     wait_fence && is_last_seg ? fence : NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +struct amdgpu_svm_range *
> +amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
> +				unsigned long gpuva_start, unsigned long gpuva_end,
> +				struct drm_gpusvm_ctx *ctx)
> +{
> +	struct drm_gpusvm_range *r;
> +
> +retry:
> +	r = drm_gpusvm_range_find_or_insert(&svm->gpusvm, addr,
> +					    gpuva_start, gpuva_end, ctx);
> +	/*
> +	 * UMD doesn't set RO for some RO VMAs, but the drm gpu svm framework
> +	 * denies no RO flag range insert for RO VMAs, so treat
> +	 * -EPERM as an indication of RO and retry if not set.
> +	 */
> +	if (PTR_ERR_OR_ZERO(r) == -EPERM && !ctx->read_only) {
> +		ctx->read_only = true;
> +		goto retry;
> +	}
> +
> +	if (IS_ERR(r))
> +		return ERR_CAST(r);
> +
> +	return to_amdgpu_svm_range(r);
> +}
> +
> +int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
> +			       struct drm_gpusvm_range *range,
> +			       struct drm_gpusvm_ctx *ctx)
> +{
> +	int ret;
> +
> +retry:
> +	ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, ctx);
> +	/*
> +	 * HMM returns -EPERM when write access is requested for a read-only
> +	 * VMA. Retry as read-only so the eventual GPU mapping follows the CPU
> +	 * VMA permissions.
> +	 */
> +	if (ret == -EPERM && !ctx->read_only) {
> +		ctx->read_only = true;
> +		goto retry;
> +	}
> +
> +	if (ret == -EOPNOTSUPP) {
> +		AMDGPU_SVM_ERR(
> +			"range get pages -EOPNOTSUPP, evict and retry: gpuva=[0x%lx-0x%lx) ret=%d\n",
> +			drm_gpusvm_range_start(range),
> +			drm_gpusvm_range_end(range), ret);
> +		amdgpu_svm_range_evict(svm, range);
> +	}
> +
> +	return ret;
> +}
> +
> +void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
> +			    struct drm_gpusvm_range *range)
> +{
> +	if (!range->pages.flags.has_devmem_pages)
> +		return;
> +
> +	drm_gpusvm_range_evict(&svm->gpusvm, range);
> +}
> +
> +int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
> +				    struct amdgpu_svm_range *range,
> +				    const struct amdgpu_svm_attrs *attrs,
> +				    bool read_only,
> +				    bool intr, bool wait,
> +				    bool flush_tlb)
> +{
> +	struct drm_exec exec;
> +	struct dma_fence *fence = NULL;
> +	unsigned int flags;
> +	int ret;
> +
> +	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, intr);
> +	if (ret)
> +		return ret;
> +
> +	flags = memalloc_noreclaim_save();
> +	drm_gpusvm_notifier_lock(&svm->gpusvm);
> +
> +	if (!amdgpu_svm_range_pages_valid(svm, range)) {
> +		amdgpu_svm_range_invalidate_gpu_mapping(range);
> +		ret = -EAGAIN;
> +	} else {
> +		ret = amdgpu_svm_range_update_gpu_range(svm, range, attrs,
> +							read_only, flush_tlb,
> +							wait, wait ? &fence : NULL);
> +	}
> +
> +	drm_gpusvm_notifier_unlock(&svm->gpusvm);
> +	memalloc_noreclaim_restore(flags);
> +
> +	if (!ret && fence)
> +		dma_fence_wait(fence, intr);
> +	dma_fence_put(fence);
> +
> +	if (!ret)
> +		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
> +
> +	if (!ret) {
> +		if (flush_tlb)
> +			svm->flush_tlb(svm);
> +		WRITE_ONCE(range->attr_flags, attrs->flags);
> +		WRITE_ONCE(range->gpu_mapped, true);
> +		range->validate_timestamp = ktime_get_boottime();
> +	}
> +
> +	drm_exec_fini(&exec);
> +	return ret;
> +}
> +
> +int
> +amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
> +		       const struct amdgpu_svm_attrs *attrs,
> +		       unsigned long start, unsigned long end)
> +{
> +	unsigned long addr = start;
> +	int ret;
> +	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
> +	bool need_vram_migration = devmem_possible &&
> +				   amdgpu_svm_attr_prefer_vram(attrs);
> +	struct drm_gpusvm_ctx map_ctx = {
> +		.devmem_possible = devmem_possible,
> +		.devmem_only = need_vram_migration,
> +		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
> +	};
> +
> +	while (addr < end) {
> +		struct amdgpu_svm_range *range;
> +		unsigned long next_addr;
> +		/* reset read_only every iteration, amdgpu_svm_range_find_or_insert may change it */
> +		map_ctx.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO);
> +
> +		range = amdgpu_svm_range_find_or_insert(svm, addr,
> +							addr, end,
> +							&map_ctx);
> +		if (IS_ERR(range)) {
> +			AMDGPU_SVM_ERR(
> +				"failed to find/insert range for gpuva 0x%lx [0x%lx-0x%lx), ret=%ld\n",
> +				addr, start, end, PTR_ERR(range));
> +			return PTR_ERR(range);
> +		}
> +
> +		next_addr = drm_gpusvm_range_end(&range->base);
> +		if (next_addr <= addr)
> +			return -EINVAL;
> +
> +		if (amdgpu_svm_range_is_valid(svm, range, attrs)) {
> +			addr = next_addr;
> +			continue;
> +		}
> +
> +		/* TODO: add migration */
> +
> +		AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
> +
> +		ret = amdgpu_svm_range_get_pages(svm, &range->base,
> +						 &map_ctx);
> +		if (ret) {
> +			AMDGPU_SVM_ERR("failed to get pages for range [0x%lx-0x%lx), ret=%d\n",
> +					drm_gpusvm_range_start(&range->base),
> +					drm_gpusvm_range_end(&range->base), ret);
> +			return ret;
> +		}
> +
> +		AMDGPU_SVM_RANGE_DEBUG(range, "UPDATE MAPPING");
> +
> +		ret = amdgpu_svm_range_update_mapping(svm, range, attrs,
> +						      map_ctx.read_only,
> +						      true, true,
> +						      true);
> +		if (ret) {
> +			AMDGPU_SVM_ERR("failed to update gpu map for range [0x%lx-0x%lx), ret=%d\n",
> +					drm_gpusvm_range_start(&range->base),
> +					drm_gpusvm_range_end(&range->base), ret);
> +			return ret;
> +		}
> +
> +		addr = next_addr;
> +	}
> +
> +	return 0;
> +}
> +

