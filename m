Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406D1CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B3C10F580;
	Fri, 12 Jun 2026 14:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RF0hwzvE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7D910EA51;
 Fri, 12 Jun 2026 14:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geA4GH2fwJ44nHFoMpJoELhGmWsae4FBkS5JDr3tSmwjN3L/nQQX5lhtzqwOkN5gWMhNG1VEaHCztGYnS606SSSxmMojb62MvU/s7clDoDkv+l7yzU+u2XELpL7E1/j0Fkya9HNAwoXMbSOpoNPdVqWObqDtXlEp63BbApNlL6GUfe9YY/wrZ0DddFjioq2jQzvQSr3PCix0pnw/oeTm+q0HcQaOZsg8Kckc9kUh5TZegiWsBVfDXKBsq+zEo2fIBhNTpMYPqa+gdExPfCLyZZXNaD6xxb74ggY8fXde3dQZm3qgrWMiNDKFhId9x4mgVffMlccIJVSv49tBhrfjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH8fPgW8MBSbUb3bm7TkLsedOPWy2sk/aAUKzoaV8UA=;
 b=IJq8jEu9WCUI3+CkpiH+oIws7c/G+oMF08U2F47f0yYAN45TyTCXY1K39rGjZhhFta6mI2y2L1coGbl3efaBrO/McPqtXdA8gTe08LblYhoWjnNn73WEaw2JNEQirnUedggnsiRwdgKqRo8tzM4LdSPCkffsRmlqZvk9UWkzqvTaN58yf5DFyFIkzyXS7hJSA1gybO99gYsHeKGFtwdfswPxdPkQXIWGWFKeoOCDjbRzYIMmGXGmvlb8H8fPFj8maBmZ5j8vUsX8HENf+4LQzkBz/QhAfFowGb+FrmJXllvQtTXpinZdx3y/TZjpjIPLzNqkFRSDbGJw59/Z9Eg73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH8fPgW8MBSbUb3bm7TkLsedOPWy2sk/aAUKzoaV8UA=;
 b=RF0hwzvEZvw67yq1Z/MKgReOdWcUum/MxTIh441jJyu3LPz37a7NNPMh6rPDqzIYdhWbtUuMlzkAcCnFs96ldPjNwy8domiDrmlpBJbAcRR9P4gwzp/ZoV07Izoq6iioCHLJE/wF0Z9zGnXGovwMdN1ejmEh7GDpqOVSao1alcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 14:54:58 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 14:54:58 +0000
Message-ID: <a8b6dddb-8913-4b2a-be17-2385fbf8da9a@amd.com>
Date: Fri, 12 Jun 2026 22:54:47 +0800
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
X-ClientProxiedBy: SI3PR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:4:297::10) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 4518feb8-f074-4564-5afa-08dec8929278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 7rhdkeshWOa8Ke5QyX1pOB/3xXIUso75yXQAiP1+gLTi8aYjzjZFv9acXtTSMoCgMkeI7ETmH3K3fr8jIuPKu9W+WsmqWPPs6zO2g/wn6QlVOKO6EQsNgWgHnymsKS0+RQjhB+4Ma/6vPJvFdOYzCJ0gu6aTOtk3hpd9qak/DYnj0SCQ2LqdvoAMFxG3ziRtjOcHOfFhW0MGdyTLYYqsj4kHQJ4BxSLB8aROCou3A8Yr3PTdRTm4NRgRkfB7Bm0FxpWR9/Lmd/z1zuLX4CxvLaBCJXfcMmhh/YfiLkd/DT+IpJ8y49QYVh+VjrvGSExfjx8HN61+ttnaPd80hAb3e6Bk0tAyIbcn1A+31Xx5U/ZYSX7yx2AQJpczeNYKf9SdEELCbYhfuolPljtrha9Ur/rMnv8CHKCFByCof3/YKB9hAwoYv2BoVYWps57BPng5aXEhyuJ3CIHRcmwzpp2nYsk6RAF2tb6aZfBnMmj+YstpeNrcwz9vcSsZUqs5qLZ+VTPBxFs6XSUZwCPI/ZshbGrpgxwXcLap6EDOvtL1K9vVC705R2QZqDqXxWshILviEvwPTOilycyAyCC2ya9Qpkp5q5IREOnIF/2BYqt71jZyzCAki5WN5GEJ1SA/lunt7l6S0YL47mi6vP1ERHCPJxGWqmgEpLjxB3DDORjMDD62YV9zWwvtVSwWVoyC6dGd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dMTkZiK3Z4VU42NmFlcUVGd1prT3lQWGF0T1ZrN090WmVuTCtxZFBoTWM2?=
 =?utf-8?B?WWsxZG1ka25KQ2dBVG9DQVRqRkd0SW0xTGxvU2JmbmNNTXE4Q01OWndVRHlx?=
 =?utf-8?B?ZnBZdGVDQ0hFbFN5N2s3VzRZcVI2cW5hZldiSHNBeC9TeFByL1RiV3phRXRk?=
 =?utf-8?B?bnppaHk5dVNKQ2QvcWx5SlorYzFob3NDMWxDWDBkZlVUVmtxbkdXa3JjcUYr?=
 =?utf-8?B?VEphM0JTVk1rSzQ1TjRiVVpJVDk2eXZjSVlKY2JDK09pQkpyQ1IrcjA1SWtL?=
 =?utf-8?B?YzdEZmtHWWpZbGRsa09SL0l4UWdvbk1vek0yNTRtbWIveE9YeVZ4L29BTDhI?=
 =?utf-8?B?ZVJsSUdTQWdiNjBpaHIwQXNNZXNyRU1TaU9sdmVEUCs0REtEUzJGK1UzQkdN?=
 =?utf-8?B?eFlnUm1iMHRESDdrem92UmRNdXBiOFpwQ1RzcHJCTDVtd08xa1ZVS1JqY1p2?=
 =?utf-8?B?Kzl2NVdwOTRsSUVGelg5WWI1RjBuL0ZyQjFsWDFPbzF3WFFnMWFoQm0rQmpH?=
 =?utf-8?B?Q3RwTkkrL3lZNGR4eHdyd0pBbDU3cGJ0TklKVm9idXVqSW5mZnBCeEF5RkFv?=
 =?utf-8?B?YUtuQWUvZ28xRGFidzZUdzZ5RWtXZVVROEN4MlUzdHU4NzJETWFzVmFqMmdO?=
 =?utf-8?B?cmtZeFhqTXRzUUhURXNZOFFZMTJlMjMyT0ZvWWt6L3NqcnpLOGdPakt4eEtW?=
 =?utf-8?B?bVp6MEtIMjJNZXhWOVFDNVJueUJxeUE4dG54SVF4VGtLV0hyaFA4eWpUY1lS?=
 =?utf-8?B?OVBCVFRaTDFqUm1NbHoxK0I0ZktOZU9objV6MXhJazNTQWJkLzNqTnQ1RCtF?=
 =?utf-8?B?cW04Tk5GeGdTMDRKOGtYSWV0S2p5UllSam9Hb3Noc0tmdFJFcXdTTGdjcmhq?=
 =?utf-8?B?emxkc0YvYjdwOEFFSnJqTG90bVZIMVRyWnlKZFFLYWR1U0c2MWdTQkpPb0tw?=
 =?utf-8?B?bFBvUmJNTVd3UUhZVDhCR1lweFRDOFhmSTBPZ3Q1R293Ym9TZmtUMFplVXdl?=
 =?utf-8?B?ZUNleVY4VnNMeGhMcVpuQzNBMTBWWWlVUWlCTHJWdEpZTlFVa3VYY3ZxRDhQ?=
 =?utf-8?B?cVVzaENIWFJUOE8rNmlNZ2FRR01yQlhtRlpHNlRzN3pzanJLdTAzVFRkbXJT?=
 =?utf-8?B?UlpYWGFTUDFTNjhrYzR4a0FZb2hPQnNyUUJJWGRtZjlrY3F3dnJFdWpKVVBz?=
 =?utf-8?B?TDNQOFVsclNtYi9Fb3NHOURHeW50QzE2dFcrWGR0djBiRW9GbjhWOXQrd2NE?=
 =?utf-8?B?WFdsNDJJdk00UytteWNMRldvVitwbkExcERIVktHU2ZkWWtzaG9OUGhpREFX?=
 =?utf-8?B?Z3pYVjFQTXQ5Z2pjSXFpUGdnNDJSWmlSZHhpTDliWXR1NXJENnUxdUhkTmgw?=
 =?utf-8?B?NUtBdWZFbjBGTXh6TldNd3FIREZSWDdNYmxydytRbDJTMGdSVkoweEtUV3lx?=
 =?utf-8?B?WGVLOE50eHBFY2x2UWltRUNKU2p1WjVBZUt0Sll4dmEydGNVMUhWTklSQ0xP?=
 =?utf-8?B?N2trUU0yNmJic2lqT3VoMWZ0a3daWUZpVlE3MlVBd3hNeFFiZzYyMFZTb1Fm?=
 =?utf-8?B?c0RHc21BYWhTQ1pvRjBLUzdiRVdKNnROcHRTN0NuTW8zZ09Ea1VjUk42QXBr?=
 =?utf-8?B?T2MwMHdUL09qblNUY1lSdXVUVzhxUE5OcDVZVlhTVDZWZ0xQaG9FM0hDZnhP?=
 =?utf-8?B?cTQ2cWVlODQ3aExZRm8xS1RjR3NPMWFYaHFaSnZBN29tL2JBM3Z6bDZwRWlW?=
 =?utf-8?B?RStYeFdPSFN3VFA0dTNhK1oyYVNHbU9jZjZYK3VmVzBVTzZRU0oveGZ3cTBZ?=
 =?utf-8?B?ZHdVMkdFUyt2SW12S1R5THpnOFEzT3VqM1RSU1hlNmxycVNNMktEaTcvbkIz?=
 =?utf-8?B?ZVlnWDlPWDVlcWRtby80Z2V0UUFtNytPaTZCZ0QvblFiZGdKa0YzMVZadzEx?=
 =?utf-8?B?UUNXVG5HOS9EUDlydE43TFgzelRZei9jUWViMk0yakpTSzZFNDI1YitDUVN0?=
 =?utf-8?B?ajNRSGI2dmpPbmYwTE9pYXJQZHJvSlVoMnBxSnEwbE95cjJDbHlRbWp5SUFr?=
 =?utf-8?B?SGx5OFF4YTRiZTMvaVpuMnpha3lBaTVGcXdVd0tQazZlWVRIWDNQQ25haGhH?=
 =?utf-8?B?VDVEdS9TUWZNK3VRTkg1YXJEODcwQ0ZkSFdYTlgvbitMZk1SckRWQnhCZVlC?=
 =?utf-8?B?aURWNVFyTFV4bUpNQ2cwS1AxY0NXbThEZUJYRmZtTFNnMlRKcEU3TWU2VUY3?=
 =?utf-8?B?ZEYwakJsT1N4OU10a1FaSHpqZWNrMWpKUUF3NkFDejNjMzYvYm1GWDE2ZVc4?=
 =?utf-8?Q?QD7BdE3M9nOLdqHenQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4518feb8-f074-4564-5afa-08dec8929278
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 14:54:58.3293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n46Js35vd8m49FG9M34JY01S6exgbVsDkYOM3j+hG2HLAmk7ZlVXZ7oT+JijozlYcn4PD7C+1I0LOUo6vnXRaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

Got it will drop the notifier lock here, but actaully the usage just 
mirror the xe_svm_range_is_valid, it check the xe_svm_range_has_pagemap
under the notifier lock, and according to the documents in 
drm_gpusvm.c:1311:

...
  * This function determines if a GPU SVM range pages are valid. Expected be
  * called holding gpusvm->notifier_lock and as the last step before 
committing a
  * GPU binding. This is akin to a notifier seqno check in the HMM 
documentation
...
static bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
				   struct drm_gpusvm_pages *svm_pages)
{
	lockdep_assert_held(&gpusvm->notifier_lock);

	return svm_pages->flags.has_devmem_pages || 
svm_pages->flags.has_dma_mapping;
}


the valid check must be in notifier lock, or the lockdep in frame work 
will go wrong.


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
> 
>> +
>> +	if (!ret && fence) {
> 
> That needs to block for the fence even if the return value is non zero.
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
> 
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

Got it will do. Where should I place those code? gmc_v9_0/12_0.c?
or someplace else?

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

