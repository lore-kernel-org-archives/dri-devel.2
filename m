Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72FCCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21CB10F588;
	Fri, 12 Jun 2026 15:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KMvfeVHd";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4295F10F153;
 Fri, 12 Jun 2026 15:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFXQSjFbTkRHGHTTHGIliP+2lvazVHUQ4ZPu4oCJLI8DrQ+DtwmGUd/3etbf1LRjz6RUOn4xsxOuJKgC5SKsP4xgbFuNHAjGQXiC71LD1nDFgfeRGVAbUZ40N2O4kjq/KDB0+6Zzk4rwJt2pjvKW7SBq4DzCcZkz/zgQm1x+b1SDOhEr/UM5m6OglNbUVCkeurbNGyM+D7ncMC2n6jkY1D1kSeNbD19F9eqtscoe12fWphF6MHguh4+P1r//B92MeYhVa4ZYdIOlZeZM3AgiPfKLBGKFwrcPzAjIMKhiuLErHPzJdHuM4W3iiTJKMlf0zDaG9lCwGBuNXSd+5nmvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Trda1UAaCtbOEOTgOsd+1V26k4GXuzYYAF3UXzSfr0U=;
 b=ENY0dH9z8GgL8P/hEkFHWSBy6fB6Z5pVdvOx2VZbBfeSQbBJsfcfPu5/z93PXiugdz+fvEHOZqRpO7qyQ/ftKEePc+g+J7ttQhHZyTCcvLEg8hVIgdV9FmqyNlhlCwl3bDbI6Ce/eOUX2aLR/cv3zk0S4DNbFdRcQQf4Uj+8ZLPtaaBxFaHPhlaogHVFVhHOl11XhxZn09bIQ8cCyiugpZsVcpImdh1l+Fyr+WI0xP/6d6UgsrvRq84rzQk0Fv0Xd1W+pU5FRDg70N5xuPYh10kIliApqko1Ac17lJ4QmMz96m/TOYuPJ2ZD4Ybhv6p8GJzgFbK+CKOq6abNW/xfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Trda1UAaCtbOEOTgOsd+1V26k4GXuzYYAF3UXzSfr0U=;
 b=KMvfeVHdDFZH35KqPrmoX4hQHmqQuV4WGPFghzPhabawbiD4un/ECpVmim370A73Rj2rK+J12YP9pBKFI2hPGdH+Re3POjs/TZe6KzZSZsmMzncKaHsjJKpxGYyVYm0S1b0VPnh1SMYtDr2y3vayjCu1w8L4prGlZBJQsO/dcbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 15:01:53 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 15:01:53 +0000
Message-ID: <4a5b6a1a-0ed9-4678-b52e-f10991d5c6cf@amd.com>
Date: Fri, 12 Jun 2026 23:01:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/18] drm/amdgpu: implement SVM range GPU mapping core
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
 <20260612090928.29682-8-ray.huang@amd.com>
 <7d073e2b-0a7c-4e42-a67d-32817596d238@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <7d073e2b-0a7c-4e42-a67d-32817596d238@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:4:297::17) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe5877c-83f6-4951-9b38-08dec8938986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|3023799007|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RMAZu1RpkpF2rX+is/Nn3LYwx+cD82vvBHYGSsqr7K9dg3wg4m0feP0gL/lKpWEI2NsGiUj918A3itEPiJnDvPzIdJ4oLHBRwbAQ29WGOX2Y5MKVchX4uUgyGGwjRZcBwxu8NGhmWrIcdOnul1ow0l/nBipdj9teqVxK6ZdU2bTF+mJ7syLfGxRAu8Jm8T9of3A3Eu2hNpPTfWwp7LYlnmQiCnx2BTixbsz+J2b8hcZI8x3Qqfn/c2IR7R43FRjdxE+L0/dl8vDtp/oR5vvlMMA2MtAcsu5UXknkcjjN1TjkbVN8ILEES8nUu2R6des1RSv32nazpfnmMPBM0nhZ1yCvq+RgXH0ied6KlJIpryYl9gsjHxcsj1C8aATfjsdBAgBl6aE8decleqnJH8UcCxhMmkm+Q+97GAec9nnaLXdSGYduZIGRZyOkBjgLwW7qcDf+qLfbS7vWevOSdSSoS+o2pAJ7PmZeA1o8NFNz+8p5xYC0+se4Phs4EBIzkVBcUmb5NP+bpPeb6W3lN7Y19lNhS3fqcL/rvl+SmbygZNmvRzbMwmJ3xrg9GnI9UeNEkLTcZ30aJV46TL0+hc2OdGguFi8KbdBa8ZxlYw4agwRv/eykvX9oC8vuGwsWnr71l0d2IG5SP1Ta6ZlQ2F+v8mgx6fJcMMxE1UsmElkgwTirr3bKOnc8RizOya/hTNl8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(3023799007)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW8zZnBQWjZrMGdER1ZFTXFONktDUjBvU1M4aHhJckpMOU1ScFdtMFZJSURh?=
 =?utf-8?B?dGhJT3NZeHRLU0VtK3FnSSt4QVJkYXYvbU1MeHdURDdKRlQ0RDR5NzgrVzBK?=
 =?utf-8?B?RWd4c0xQNkgyTDV0ZFVZN05oRWtxVk9YbTRMVllMOHIzRVlGVmRjbHpOeHY5?=
 =?utf-8?B?TzVGdi84NlVCMUJDRFRtTjZLUyt2eDVHTGsvZm9PckZvNFJKNFI1N05haGtS?=
 =?utf-8?B?OFBrNVlEVWN6UDcrQVFzczliQkg5a0N3ZUE2TzVsTENFSXN4T1VOeGNmbVh2?=
 =?utf-8?B?S1M4eEpkOC9FUzg3eWVycVZ2Y2FVNFUzbGEvZWJnVU5NMEsxaFBqU2JBNzJv?=
 =?utf-8?B?RVhlWnZ3RFRTcDdyZ2grZitweEVNS3RielpqZ3NLMEYyRGZ4UjdCZFlnU3RU?=
 =?utf-8?B?UEd4Ri9aUFRTRXQ1NGEzb3RWcFU1WGNXd0FSRXhTSndEZGwyLzhOOVVXZG9E?=
 =?utf-8?B?TG1xcEw4NW9UamhadncyN21vT1ZhT09xNXJQU3RQNGwzQTVLei9XVzlzTUhO?=
 =?utf-8?B?R3ZYM0pKZ2J2NitwZGQ2RlJ3VXlwbytGcG5CaDNnYjFLb0Z4ZWRFRkd4Slpy?=
 =?utf-8?B?NDJjS2ZWSWdybE9scXZWaWlSVEJNUlZYSXR5QVFjZXpIWWhqK3NtN0lsbTZI?=
 =?utf-8?B?Mk1GaW5BTFY4Y3pTVnp6ZXhJRjY2SVNQTW9hcHhSSVpJV2JJUExsQXlMdjBo?=
 =?utf-8?B?c2d3L1JaUTRndmgyWWtJL0pvNzNaZWNHc3JHTGxDMVBwYk5oemdhMW1hVyt6?=
 =?utf-8?B?R1JCOU1EbVJST2hHejJtM0ZyOXVDWXZLWTVSY2p3RE9Za3FsbFFvUGxWYmxw?=
 =?utf-8?B?Y3VBSzE4NWRGbVNwcW9teDVkUlZDczljTTg5Z0NXRUY4Qm9jUzEwM01iTEJZ?=
 =?utf-8?B?RXlhMjJrT0tsNXNIMTRrRTZUNkFuOERLRmRDbE5NbnhRWEVRV1o0aEUvMVY5?=
 =?utf-8?B?WFdmalJoUmZCMVExVUhMOE1jekxxTGtLNVpJOEtoUWVpWkJzTm5pcmNMb3cy?=
 =?utf-8?B?TFJvU29PQmJxckJXak9ocVFTdWpBYjNpNXM4VUllT1ZmNWpEeDlseU9wV1VT?=
 =?utf-8?B?SjRYNytWU0xEQnN5eU9hWUQyRG81cmlKZks2dExoY3RwS0VFNXFPUkRYWU1V?=
 =?utf-8?B?MnREUHorZnpIOGVTZzMyWElPTG9waG55QW5PWFpYSDgzRFFsR0lFZzFveGdF?=
 =?utf-8?B?YXBNVjlKL2loeko2VTVxRDFPd1c4RFNyZ0NUaDRrRGcxbFgyWDd2bjV4cW5x?=
 =?utf-8?B?QVpMSkVySklrVXcwbENIaVkwTm9mRU5JZWQ0Y3lIdDRGVG04Y2xQM2RvU2Vi?=
 =?utf-8?B?Z3NpUDVZT3pXajRwWVUwZ1BmRGxSb1d5L1ljcHRKL00zSDNocStRWnpIeFgv?=
 =?utf-8?B?WU5vcUE1a1FHbUtld0ZuVzNmRnd6Mm45akZJVkswTWlkcGJZaTVhZG1kdlZK?=
 =?utf-8?B?TVRObGE4WlE4WU5qTnhTcXhvWFIvMHNiWGJSVFFQNFhFQVF0ZEdzRnhIUmFw?=
 =?utf-8?B?bGlHdWtnRUVXVE16dXpnNXdnLzNJNjRJbkttY0dRdVRubnVxM1JvdmJqd1A2?=
 =?utf-8?B?eTVrdzJTNVA0bUxzKzNjMnpEajdMVVdxN1pSazNqWHk1V2RGL1VyTmd4anhw?=
 =?utf-8?B?djJFMXhDRUVMR2pWTFhaS3VoeVhtZmY5ZVhMRnpDekpzMHV3b2wyb1BpblFy?=
 =?utf-8?B?ditLdEpRamM3eHMrNjd5OE52dkphMVlrdFZpQ1ZZMC96YWNML1pRUW9TTCtx?=
 =?utf-8?B?R3Z3c0h0WjJJNkdjM2tQcHpaanY3d0QydkxJV1p5RU5KSmVpMU0ya2U1Rzdi?=
 =?utf-8?B?WnFXblhRaGZBclBHc0JlTXlpcm1JSlVtY1cxTWR0cjFXUlJ4Snlsd3BkeXZ0?=
 =?utf-8?B?MDREdU1zK0ltdm50ZmlJUnJWeWZXb1NOOWE5L1N0RVBOVjNjZmsxQWoyL1di?=
 =?utf-8?B?dllBcmtheFN4Z2s3bVJXZ3liOHRadmRQcGdkQXJSN1h1eVVEMHUzU2NsZG1w?=
 =?utf-8?B?RlJiSmtVcmZjWmJ5VStuQjhtcGVWWTlBUXlEM0tRQzRMOFFhSEwxL3dQcEZG?=
 =?utf-8?B?V21ZNXpqOGlFMDVqSzZXdU5ZQ1BtUVVTZ1NhYjBZSTdyZHdLNU5yUU1za3ND?=
 =?utf-8?B?VDV6cDZoRndEUHRrei8rQ28yMVlqSmdDNktJNXdKR0crb0lCYjJkQ0Zyck4w?=
 =?utf-8?B?UkJBMTVNOXlodm5MWkFpOCtHR3VoZEVNbnpiWHNweHVBeVZtWEt4dUwwOTlR?=
 =?utf-8?B?MlAwTFN0a2ZiS1lzbFMrZ2k3aW5jazNVY1ViUGM5U1lLZ01KdUZ6VkFrSm90?=
 =?utf-8?Q?4xLK0yZUduJkzpq82K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe5877c-83f6-4951-9b38-08dec8938986
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 15:01:52.9010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ii20HA8P0N3TxH0YIip6OujcCarofKU3cA4n4sPpq/Fy0lvkqEg/wiNKZd9wD0n/oIQhkTJ30hFkhRqrihsnDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
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



On 6/12/2026 8:21 PM, Christian König wrote:
> 
> 
> On 6/12/26 11:09, Huang Rui wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Implement GPU page table mapping in amdgpu_svm_range.c:
>> - amdgpu_svm_range_pages_valid: check notifier sequence validity
>> - amdgpu_svm_range_is_valid: validate gpu_mapped and attr_flags
>>    against the requested attribute set, under MMU notifier lock.
>> - amdgpu_svm_range_zap_ptes: clear GPU PTEs via amdgpu_vm_update_range
>> - amdgpu_svm_range_attr_pte_flags: compute PTE flags per GC IP version
>> - amdgpu_svm_range_lock_vm_pd: acquire VM page directory by drm_exec
>> - amdgpu_svm_range_update_gpu_range: DMA segment coalescing; recomputes
>>    PTE flags per segment from entry->proto via attr_pte_flags, then
>>    programs PTEs under notifier lock
>> - amdgpu_svm_range_find_or_insert: wrapper of drm gpu SVM find or insert
>>    API.
>> - amdgpu_svm_range_get_pages: wrapper of drm gpu SVM get pages.
>> - amdgpu_svm_range_evict: thin wrapper of drm_gpusvm_range_evict
>> - amdgpu_svm_range_update_mapping: full pipeline (lock PD, validate
>>    pages, program PTEs, update PDEs, flush TLB, record attr_flags
>>    and mapped state); takes attrs + read_only and forwards them to
>>    update_gpu_range
>> - amdgpu_svm_range_map_attrs: cursor based iteration across attr tree,
>>    creating/mapping ranges
>>
>> - Add to amdgpu_svm.h driver private interconnect tags used in
>> drm_pagemap_addr.proto:
>>    AMDGPU_INTERCONNECT_VRAM = DRM_INTERCONNECT_DRIVER
>>    AMDGPU_INTERCONNECT_P2P  = AMDGPU_INTERCONNECT_VRAM + 1
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   4 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 488 ++++++++++++++++++
>>   2 files changed, 492 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> index 9884a1f834d67..ac84b80f750f8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>> @@ -27,6 +27,7 @@
>>   
>>   #include <drm/amdgpu_drm.h>
>>   #include <drm/drm_gpusvm.h>
>> +#include <drm/drm_pagemap.h>
>>   #include <linux/atomic.h>
>>   #include <linux/kref.h>
>>   #include <linux/list.h>
>> @@ -44,6 +45,9 @@ struct amdgpu_svm_attrs;
>>   struct drm_device;
>>   struct drm_file;
>>   
>> +#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
>> +#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
>> +
>>   enum amdgpu_svm_xnack_mode {
>>   	AMDGPU_SVM_XNACK_OFF,
>>   	AMDGPU_SVM_XNACK_ON,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>> new file mode 100644
>> index 0000000000000..e1b392b2cf56a
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>> @@ -0,0 +1,488 @@
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
>> +#include "amdgpu_svm_range.h"
>> +#include "amdgpu_svm_fault.h"
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +
>> +#include <drm/drm_exec.h>
>> +#include <drm/drm_pagemap.h>
>> +
>> +#include <linux/mmu_notifier.h>
>> +#include <uapi/linux/kfd_ioctl.h>
>> +
>> +bool
>> +amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
>> +		  struct amdgpu_svm_range *range)
>> +{
>> +	struct drm_gpusvm_range *base = &range->base;
>> +
>> +	lockdep_assert_held(&svm->gpusvm.notifier_lock);
>> +
>> +	if (base->pages.flags.unmapped || base->pages.flags.partial_unmap)
>> +		return false;
>> +
>> +	return drm_gpusvm_range_pages_valid(&svm->gpusvm, base);
>> +}
>> +
>> +bool amdgpu_svm_range_is_valid(struct amdgpu_svm *svm,
>> +			       struct amdgpu_svm_range *range,
>> +			       const struct amdgpu_svm_attrs *attrs)
>> +{
>> +	bool valid;
>> +
>> +	drm_gpusvm_notifier_lock(&svm->gpusvm);
>> +	valid = range->gpu_mapped &&
>> +		range->attr_flags == attrs->flags &&
>> +		amdgpu_svm_range_pages_valid(svm, range);
>> +	drm_gpusvm_notifier_unlock(&svm->gpusvm);
>> +
>> +	return valid;
> 
> That looks completely broken to me.
> 
> The valid state looses meaning as soon as the lock is dropped.
> 
>> +}
>> +
>> +
>> +int
>> +amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
>> +			  struct amdgpu_svm_range *range,
>> +			  unsigned long start_page,
>> +			  unsigned long last_page)
>> +{
>> +	struct dma_fence *fence = NULL;
>> +	unsigned int flags;
>> +	int ret;
>> +
>> +	if (last_page < start_page)
>> +		return 0;
>> +
>> +	flags = memalloc_noreclaim_save();
>> +	ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, true, true, false,
>> +				     NULL, start_page, last_page, 0, 0, 0, NULL,
>> +				     NULL, &fence);
>> +	memalloc_noreclaim_restore(flags);
> 
> That's the same nonsense we already had in the existing KFD implementation.
> 
> The whole patch set needs to be rebased on top of my patches to fix this.

Got it will rebase the whole patch baseed on your fix patches.

> 
>> +
>> +	if (!ret && fence) {
> 
> That needs to block for the fence even if the return value is non zero.

Got it will fix.

> 
>> +		ret = dma_fence_wait(fence, false);
> 
>> +		if (ret < 0)
>> +			AMDGPU_SVM_TRACE(
>> +				"notifier unmap fence wait failed: ret=%d [0x%lx-0x%lx]-0x%lx\n",
>> +				ret, start_page, last_page,
>> +				last_page - start_page + 1);
> 
> Drop that check and warning.

Got it will drop.>
>> +	}
>> +
>> +	dma_fence_put(fence);
>> +	return ret;
>> +}
>> +
>> +uint64_t
>> +amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
>> +			    const struct amdgpu_svm_attrs *attrs,
>> +			    bool read_only,
>> +			    enum drm_interconnect_protocol proto)
>> +{
>> +	uint32_t flags = attrs->flags;
>> +	uint32_t mapping_flags = 0;
>> +	uint32_t gc_ip_version = amdgpu_ip_version(svm->adev, GC_HWIP, 0);
>> +	uint64_t pte_flags;
>> +	bool snoop = proto != AMDGPU_INTERCONNECT_VRAM;
>> +	bool coherent = flags & (AMDGPU_SVM_ATTR_BIT_COHERENT |
>> +				 AMDGPU_SVM_ATTR_BIT_EXT_COHERENT);
>> +	bool ext_coherent = flags & AMDGPU_SVM_ATTR_BIT_EXT_COHERENT;
>> +	unsigned int mtype_local, mtype_remote;
>> +	bool is_aid_a1;
>> +	bool is_local = (proto == AMDGPU_INTERCONNECT_VRAM);
>> +	bool is_vram = is_local || (proto == AMDGPU_INTERCONNECT_P2P);
>> +
>> +	switch (gc_ip_version) {
>> +	case IP_VERSION(9, 4, 1):
>> +	case IP_VERSION(9, 4, 2):
>> +		if (is_local) {
>> +			mapping_flags |= coherent ?
>> +				AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>> +			/* 9.4.2 local VRAM with XGMI keeps snoop */
>> +			if (gc_ip_version == IP_VERSION(9, 4, 2) &&
>> +			    svm->adev->gmc.xgmi.connected_to_cpu)
>> +				snoop = true;
>> +		} else {
>> +			mapping_flags |= coherent ?
>> +				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +			/* TODO: migration: re enable snoop for same hive */
>> +		}
>> +		break;
>> +	case IP_VERSION(9, 4, 3):
>> +	case IP_VERSION(9, 4, 4):
>> +	case IP_VERSION(9, 5, 0):
>> +		if (ext_coherent)
>> +			mtype_local = AMDGPU_VM_MTYPE_CC;
>> +		else
>> +			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>> +				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC :
>> +				AMDGPU_VM_MTYPE_RW;
>> +		snoop = true;
>> +		if (is_vram) {
>> +			if (is_local) {
>> +				/* local HBM region close to partition */
>> +				mapping_flags |= mtype_local;
>> +			} else if (!ext_coherent) {
>> +				/* TODO: add same hive check */
>> +				mapping_flags |= AMDGPU_VM_MTYPE_NC;
>> +			} else if (gc_ip_version < IP_VERSION(9, 5, 0)) {
>> +				/* TODO: add same hive check */
>> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +			} else {
>> +				mapping_flags |= ext_coherent ?
>> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +			}
>> +		} else if (svm->adev->flags & AMD_IS_APU) {
>> +			/* On NUMA systems, locality is determined per-page
>> +			 * in amdgpu_gmc_override_vm_pte_flags.
>> +			 */
>> +			if (num_possible_nodes() <= 1)
>> +				mapping_flags |= mtype_local;
>> +			else
>> +				mapping_flags |= ext_coherent ?
>> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +		} else {
>> +			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
>> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +			else
>> +				mapping_flags |= AMDGPU_VM_MTYPE_NC;
>> +		}
>> +		break;
>> +	case IP_VERSION(12, 0, 0):
>> +	case IP_VERSION(12, 0, 1):
>> +		mapping_flags |= AMDGPU_VM_MTYPE_NC;
>> +		break;
>> +	case IP_VERSION(12, 1, 0):
>> +		is_aid_a1 = (svm->adev->rev_id & 0x10);
>> +		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
>> +				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>> +				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
>> +		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
>> +		snoop = true;
>> +
>> +		if (is_local) {
>> +			mapping_flags |= mtype_local;
>> +		} else if (ext_coherent) {
>> +			mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +		} else {
>> +			/* system memory or remote VRAM */
>> +			mapping_flags |= mtype_remote;
>> +		}
>> +		break;
>> +	default:
>> +		mapping_flags |= coherent ?
>> +			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +		break;
>> +	}
> 
> All of this needs to be in HW IP version specific files.
> 
> Regards,
> Christian.
> 
>> +
>> +	if (flags & AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
>> +		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>> +
>> +	pte_flags = AMDGPU_PTE_VALID;
>> +	pte_flags |= is_local ? 0 : AMDGPU_PTE_SYSTEM;
>> +	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>> +	if (gc_ip_version >= IP_VERSION(12, 0, 0))
>> +		pte_flags |= AMDGPU_PTE_IS_PTE;
>> +
>> +	amdgpu_gmc_get_vm_pte(svm->adev, svm->vm, NULL, mapping_flags, &pte_flags);
>> +	pte_flags |= AMDGPU_PTE_READABLE;
>> +	if (!(flags & AMDGPU_SVM_ATTR_BIT_GPU_RO) && !read_only)
>> +		pte_flags |= AMDGPU_PTE_WRITEABLE;
>> +
>> +	if (gc_ip_version == IP_VERSION(12, 1, 0) &&
>> +	    svm->adev->have_atomics_support)
>> +		pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
>> +
>> +	return pte_flags;
>> +}
>> +
>> +
>> +
>> +int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *exec,
>> +				bool intr)
>> +{
>> +	unsigned int exec_flags = DRM_EXEC_IGNORE_DUPLICATES;
>> +	int ret;
>> +
>> +	if (intr)
>> +		exec_flags |= DRM_EXEC_INTERRUPTIBLE_WAIT;
>> +
>> +	drm_exec_init(exec, exec_flags, 0);
>> +	drm_exec_until_all_locked(exec) {
>> +		ret = amdgpu_vm_lock_pd(svm->vm, exec, 1);
>> +		drm_exec_retry_on_contention(exec);
>> +		if (ret) {
>> +			drm_exec_fini(exec);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int
>> +amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
>> +				  struct amdgpu_svm_range *range,
>> +				  const struct amdgpu_svm_attrs *attrs,
>> +				  bool read_only,
>> +				  bool flush_tlb,
>> +				  bool wait_fence,
>> +				  struct dma_fence **fence)
>> +{
>> +	struct drm_gpusvm_range *base = &range->base;
>> +
>> +	lockdep_assert_held(&svm->gpusvm.notifier_lock);
>> +
>> +	const unsigned long range_start_page = drm_gpusvm_range_start(base) >> PAGE_SHIFT;
>> +	const unsigned long range_end_page = drm_gpusvm_range_end(base) >> PAGE_SHIFT;
>> +	const unsigned long npages = range_end_page - range_start_page;
>> +	unsigned long mapped_pages = 0;
>> +	unsigned long dma_idx = 0;
>> +	int ret;
>> +
>> +	if (!base->pages.dma_addr || !npages)
>> +		return -EINVAL;
>> +
>> +	while (mapped_pages < npages) {
>> +		const struct drm_pagemap_addr *entry = &base->pages.dma_addr[dma_idx++];
>> +		unsigned long seg_pages = min_t(unsigned long, 1UL << entry->order,
>> +						npages - mapped_pages);
>> +		uint64_t pte_flags;
>> +		unsigned long start_page, last_page;
>> +		bool is_last_seg;
>> +
>> +		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
>> +			return -EOPNOTSUPP;
>> +
>> +		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
>> +							    read_only,
>> +							    entry->proto);
>> +
>> +		start_page = range_start_page + mapped_pages;
>> +		last_page = start_page + seg_pages - 1;
>> +		mapped_pages += seg_pages;
>> +		is_last_seg = mapped_pages == npages;
>> +
>> +		ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
>> +					     flush_tlb && is_last_seg, true, NULL,
>> +					     start_page, last_page, pte_flags,
>> +					     0, entry->addr, NULL, NULL,
>> +					     wait_fence && is_last_seg ? fence : NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +struct amdgpu_svm_range *
>> +amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
>> +				unsigned long gpuva_start, unsigned long gpuva_end,
>> +				struct drm_gpusvm_ctx *ctx)
>> +{
>> +	struct drm_gpusvm_range *r;
>> +
>> +retry:
>> +	r = drm_gpusvm_range_find_or_insert(&svm->gpusvm, addr,
>> +					    gpuva_start, gpuva_end, ctx);
>> +	/*
>> +	 * UMD doesn't set RO for some RO VMAs, but the drm gpu svm framework
>> +	 * denies no RO flag range insert for RO VMAs, so treat
>> +	 * -EPERM as an indication of RO and retry if not set.
>> +	 */
>> +	if (PTR_ERR_OR_ZERO(r) == -EPERM && !ctx->read_only) {
>> +		ctx->read_only = true;
>> +		goto retry;
>> +	}
>> +
>> +	if (IS_ERR(r))
>> +		return ERR_CAST(r);
>> +
>> +	return to_amdgpu_svm_range(r);
>> +}
>> +
>> +int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
>> +			       struct drm_gpusvm_range *range,
>> +			       struct drm_gpusvm_ctx *ctx)
>> +{
>> +	int ret;
>> +
>> +retry:
>> +	ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, ctx);
>> +	/*
>> +	 * HMM returns -EPERM when write access is requested for a read-only
>> +	 * VMA. Retry as read-only so the eventual GPU mapping follows the CPU
>> +	 * VMA permissions.
>> +	 */
>> +	if (ret == -EPERM && !ctx->read_only) {
>> +		ctx->read_only = true;
>> +		goto retry;
>> +	}
>> +
>> +	if (ret == -EOPNOTSUPP) {
>> +		AMDGPU_SVM_ERR(
>> +			"range get pages -EOPNOTSUPP, evict and retry: gpuva=[0x%lx-0x%lx) ret=%d\n",
>> +			drm_gpusvm_range_start(range),
>> +			drm_gpusvm_range_end(range), ret);
>> +		amdgpu_svm_range_evict(svm, range);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
>> +			    struct drm_gpusvm_range *range)
>> +{
>> +	if (!range->pages.flags.has_devmem_pages)
>> +		return;
>> +
>> +	drm_gpusvm_range_evict(&svm->gpusvm, range);
>> +}
>> +
>> +int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
>> +				    struct amdgpu_svm_range *range,
>> +				    const struct amdgpu_svm_attrs *attrs,
>> +				    bool read_only,
>> +				    bool intr, bool wait,
>> +				    bool flush_tlb)
>> +{
>> +	struct drm_exec exec;
>> +	struct dma_fence *fence = NULL;
>> +	unsigned int flags;
>> +	int ret;
>> +
>> +	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, intr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	flags = memalloc_noreclaim_save();
>> +	drm_gpusvm_notifier_lock(&svm->gpusvm);
>> +
>> +	if (!amdgpu_svm_range_pages_valid(svm, range)) {
>> +		amdgpu_svm_range_invalidate_gpu_mapping(range);
>> +		ret = -EAGAIN;
>> +	} else {
>> +		ret = amdgpu_svm_range_update_gpu_range(svm, range, attrs,
>> +							read_only, flush_tlb,
>> +							wait, wait ? &fence : NULL);
>> +	}
>> +
>> +	drm_gpusvm_notifier_unlock(&svm->gpusvm);
>> +	memalloc_noreclaim_restore(flags);
>> +
>> +	if (!ret && fence)
>> +		dma_fence_wait(fence, intr);
>> +	dma_fence_put(fence);
>> +
>> +	if (!ret)
>> +		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
>> +
>> +	if (!ret) {
>> +		if (flush_tlb)
>> +			svm->flush_tlb(svm);
>> +		WRITE_ONCE(range->attr_flags, attrs->flags);
>> +		WRITE_ONCE(range->gpu_mapped, true);
>> +		range->validate_timestamp = ktime_get_boottime();
>> +	}
>> +
>> +	drm_exec_fini(&exec);
>> +	return ret;
>> +}
>> +
>> +int
>> +amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
>> +		       const struct amdgpu_svm_attrs *attrs,
>> +		       unsigned long start, unsigned long end)
>> +{
>> +	unsigned long addr = start;
>> +	int ret;
>> +	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
>> +	bool need_vram_migration = devmem_possible &&
>> +				   amdgpu_svm_attr_prefer_vram(attrs);
>> +	struct drm_gpusvm_ctx map_ctx = {
>> +		.devmem_possible = devmem_possible,
>> +		.devmem_only = need_vram_migration,
>> +		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
>> +	};
>> +
>> +	while (addr < end) {
>> +		struct amdgpu_svm_range *range;
>> +		unsigned long next_addr;
>> +		/* reset read_only every iteration, amdgpu_svm_range_find_or_insert may change it */
>> +		map_ctx.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO);
>> +
>> +		range = amdgpu_svm_range_find_or_insert(svm, addr,
>> +							addr, end,
>> +							&map_ctx);
>> +		if (IS_ERR(range)) {
>> +			AMDGPU_SVM_ERR(
>> +				"failed to find/insert range for gpuva 0x%lx [0x%lx-0x%lx), ret=%ld\n",
>> +				addr, start, end, PTR_ERR(range));
>> +			return PTR_ERR(range);
>> +		}
>> +
>> +		next_addr = drm_gpusvm_range_end(&range->base);
>> +		if (next_addr <= addr)
>> +			return -EINVAL;
>> +
>> +		if (amdgpu_svm_range_is_valid(svm, range, attrs)) {
>> +			addr = next_addr;
>> +			continue;
>> +		}
>> +
>> +		/* TODO: add migration */
>> +
>> +		AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
>> +
>> +		ret = amdgpu_svm_range_get_pages(svm, &range->base,
>> +						 &map_ctx);
>> +		if (ret) {
>> +			AMDGPU_SVM_ERR("failed to get pages for range [0x%lx-0x%lx), ret=%d\n",
>> +					drm_gpusvm_range_start(&range->base),
>> +					drm_gpusvm_range_end(&range->base), ret);
>> +			return ret;
>> +		}
>> +
>> +		AMDGPU_SVM_RANGE_DEBUG(range, "UPDATE MAPPING");
>> +
>> +		ret = amdgpu_svm_range_update_mapping(svm, range, attrs,
>> +						      map_ctx.read_only,
>> +						      true, true,
>> +						      true);
>> +		if (ret) {
>> +			AMDGPU_SVM_ERR("failed to update gpu map for range [0x%lx-0x%lx), ret=%d\n",
>> +					drm_gpusvm_range_start(&range->base),
>> +					drm_gpusvm_range_end(&range->base), ret);
>> +			return ret;
>> +		}
>> +
>> +		addr = next_addr;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 

