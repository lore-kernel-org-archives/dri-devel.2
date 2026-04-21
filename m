Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA64F327D6
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294B410E20C;
	Tue, 21 Apr 2026 09:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dTrhuI/G";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3299C10E20C;
 Tue, 21 Apr 2026 09:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDyEcamPdargFEICfIF6bLIzqv7wrMvyyoc9ymtcCrRdgGv6DcGfZt+VMs+JBhbIExbFEAqbS+fKcOK6kJzUbr0olX6NBGAJPe/+gZaQQVNtzzuCP6tkMUydnqeyux7IG9j688q60X4bqM9tmxfuzPAHmg6mMD4W1zcfq+UVBJyXLlQu1pClWkQ7XldFfCwwzhWQSKHt8c8dFthIxPmi37uK4h0SlHS/ANbxibv8E7bdPUWADzHD2uKX656EvAX9jF1AcZicUdIK2KtcrQ3nlVL3tyq/oe99iLbiQ8uRQHL1byWb3G/7DyO3oYBqUJbTvsRTbSwa9ghgDYx0by2T2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjN1Fm2gJRNGTUnDgpyHgKZ3aAWw74T6p2Sgappj/cU=;
 b=R0ToTY8yPV5hPTgdl92dhxOP6DrB5hqe0g1R48zwdn3j6z4jCO1MPadquVunG+Ib62i7wgOSGZm4xdiJphS/QWwlogb3xTemx1Sev1RC9fYkPfPeD5YNnGkOpvXEk17c417/ZU14v8JO8B40oGOWAiICHVnvBYPv/oTSB29w3X8vm0pWq1boxJPVslQcB1HIqtKfRprkZK+myr2cl7oFeWc9jG+nzUyTnY+t8DiGhV4n7XbTmt9pxIvoQGnvFSuBebX+iGMFxNT+38jYWk/Op+g67wmgJikEUThLPimttuJDOX5+JBZKhGEv7euvsWmrBfep1zByRYTkgRIj+IYazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjN1Fm2gJRNGTUnDgpyHgKZ3aAWw74T6p2Sgappj/cU=;
 b=dTrhuI/Gfv4r9cRzY9k6nnWE9AXlVzTHRLUTldeoGEwpZkp2IfW9ZAzFJV05l8fYdQoeGAN4Oauy6pW/yTN8OHNzK/vm0Up7+jACdVeDsKXdOeMPXyhws073x18XoUPp3CQULbIZq8JXGwONtd886y/DDhBH8er7C4o+iaRKFvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 09:54:54 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.017; Tue, 21 Apr 2026
 09:54:54 +0000
Message-ID: <ab69089d-5e21-43b2-8b36-62235d130bdc@amd.com>
Date: Tue, 21 Apr 2026 17:54:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 00/12] drm/amdgpu: SVM implementation based on drm_gpusvm
To: Huang Rui <ray.huang@amd.com>
Cc: Honglei Huang <honglei1.huang@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, matthew.brost@intel.com,
 rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 aliceryhl@google.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
 <aebhbe9gMAqz1tpM@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <aebhbe9gMAqz1tpM@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::12) To CY5PR12MB6430.namprd12.prod.outlook.com
 (2603:10b6:930:3a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a85a686-f180-4493-4eb6-08de9f8c0980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: nhNOclMPwTbIvF5JSPvPn6mTB/XIr2SlXF1AGl4JSRe6PBzFuCZUgTvrHjv+7UFlcNdvEXkhz6oTQDl3gGWMD1we/YbwB3nEx5rX0OSTc9UQCtJGi3Gu/RSqs0ZurlojkEe+Jo1hlhx9kzjRDUfRXIvE7pjN7g+rAJyvPIaX2/dutI7LbgXS52Das2kTuOHp7zwSSchZavXmeRsJJZ1i2TGifA1+IrDB5pzlEhfC00/8Vloye0R1UfMIsNF9xjbkQxPrIBV0Tj7VGXR0hvPOkY2/Fuzp2Rdf31l0GYtfZ9AZ/J85fv7zx66MQUOn9yZE0hMami9IbJ19pfb/F1i4SEW7k8rCBXuDvgMJmdPUbuT5QK2q3hvONpFBIQh++1OLFy/zR28WXLDuU5nyQc1wGeQtnsDsVj8fLQVdiI5ie2p7pAUK7bXuYyFJzwKXYsUEhdgVRbqgOj14OjI21xmMKuY7ZytT61Y5Wu5PKSs6Q1s8YaElrUFpktFpdocxvgqDj4NIlH+z9+eSl/KASxEMaiTBKX6xCeh9SJRN91YA0ny5fSThS14Wi4618shGqR3LcOpqbsvoml01B4voOgVZDU5q0ZVgjs1FQ9qH5XKhYwykbUEu16LLOXAMvxJGlSbIGhsSouNNJ4DL1z0k61Ae7RdMs+eeNi1s+LVo8LkZm2UaE1L4EbJmGg/5RORWXfzKCqZfV8cBAzaF057SuRUlcYhjLylou2vcP/W5DOP5gwkrPrmWywkIlLqs399yF0u1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3d6QkZQbGIwNnpDeVhFUENBL29NcGxkVWk4NVA4SXJlNGVvbm4zTzU2SDB2?=
 =?utf-8?B?eEIrUHl1VkJNV016bFFvdm52QjVGSlV6MDZLODhkYytzdUR1VHBNdzZNbTkr?=
 =?utf-8?B?NWZyU3paV1ZkNk80VXgremlYeEU0bWkxRWwrNDNGVUQ0TzJDWkxHSEZGcGlv?=
 =?utf-8?B?OUdTQldNdW5DOHdTYUtNUzYwTGoyS2dVT3VuUTAyTzhEWEtDeDNXcFVSOU1u?=
 =?utf-8?B?YlF4dEJBc1loVXh2V0NlU1UzejVnUzdqUlBwdTFkRXlOWEM3YmdTY25samN1?=
 =?utf-8?B?c2lTdjQrWnhnUzduV29wakwwSWpibkx3SG1GbWc3aGNWNy9yNFBGRVZvUkFJ?=
 =?utf-8?B?Q3F5VW4vbXV0cVEzVDUrSTE5aU82YTJSRG5QVEFBcGVTbkxuSWh5eU5JdTho?=
 =?utf-8?B?c3ZYb0tiTkFCOFl0bjZvMzRjT1dYQmI3czNBM1V2V2wwcEV6dUZDcXFiSnRi?=
 =?utf-8?B?QVFESmdUZFVtNHNsQmRKTWYrNGEzWU9TTEVkR1ltRTBRZ0R2cXEzQitiZ1l0?=
 =?utf-8?B?TUMyd0xreTdYY3ZHTUZtOWo3VzNQSTJjSmJGSHRLNVltNEhLZTgrUkxUcVdN?=
 =?utf-8?B?VW51VUErQ3RiZ0p5VTRYdjBWYktrTlB1U01SQU0yUFlpanNhdHNvTmVEL0Iw?=
 =?utf-8?B?QU5ibkhmandxRENBR3BRTzNMZTBsM0h2TzVFWU5zSjlnWFBpQ1QxeXZzSEtJ?=
 =?utf-8?B?dVlsZUxESS9TM1RJVkk5MVlRZUYwVDhuWVlzYlI3U29WRXgxWWN3aW5oQytS?=
 =?utf-8?B?UVNNa1o3Z3dXSEcyWlFqRUJCUHVpVnk3NFcxck1XQzBreHpnY0c4WlZUNDRk?=
 =?utf-8?B?TFVBWlZOUzJMelBhY1A4cXh0WTRpN2premVvN2N3ZXladnRsV01lV3c1WEpD?=
 =?utf-8?B?MHlBWmd2ZG1wMHZQcURiNzB5c29OVVJqcmlzK3hkQ1NyQnJldENteUp0STNL?=
 =?utf-8?B?ZFExSi9NRUsvRWptZjRZR0RleXVoa2hISUt4UXRpM0N6ZWhZZXZWb1ZhSXJR?=
 =?utf-8?B?eWRYSUVXS1RhOWJERTJOSUNmNFRsYUVrUjZ6THpPVzBXZDVGNVk2a0lGM1h1?=
 =?utf-8?B?OVVBdjJoNEZoVFRlemdMQU1NNWVqdDk1V05lNGpWNWwwQjJoYUFCWGpQYUh0?=
 =?utf-8?B?RVdpN3ZvZ2tXcEJLbUxYQzFmdUhtU05QcGcvS0l1WmMrR0ZHdUUxU3RRRWpo?=
 =?utf-8?B?WG1pby91dE9IZDRPSDh6MmNUZnArV0p0eU5zSkxQN05CcE1DUHg4QTJZcjZj?=
 =?utf-8?B?RXdsRk1uNUZqbTlJUlpmY01weW5US2d3QTFEK3hyWnNKTVhBMWlhbVF6dC9n?=
 =?utf-8?B?WnlrWDlpVWxwVndFM29HQk9pc0NVM0orOFR0VjdDbkRGMkxKdzZQYjY2Titl?=
 =?utf-8?B?YXpBVWYrNThmeU4xdE94WXNWVWovampGYktyVnBEb243V1RJVXpCanZWUVFS?=
 =?utf-8?B?bk9SZG1CK2FrbnA0dWVxWmpHS0JBZ3djZ2VQNlNKWjRMVlg1aTBhblJaZ05I?=
 =?utf-8?B?anUrczBhRnlEam56aDJLZ29yMk94aDZ5NmhXMW9PZzZaMzVNVERBZFZDTGZa?=
 =?utf-8?B?cEI4STk3anFsTHBiY0duTE0rcWxXVEU3bGF4QVcvem1Qc1hTWSthU0RzaHVL?=
 =?utf-8?B?QS9rcEMzWmpVUi9zMTB3M3JGOVcvL0d2UFYxUHZQazNlRVB3M20xa2o2M2pG?=
 =?utf-8?B?cUVWQi9UNU44MWlVbGEwSm1HMUlyMytUb3NEbmdQa1V5N3pCMGRwdUxCNEp1?=
 =?utf-8?B?T2lFSU1wR2JPRWx2OG1ZMlB3K0ZiV0ZvL0F2TUVQclExTXQwZ20wa1JJbDJ6?=
 =?utf-8?B?MXdtUEIvSWpLK1VrV1BZMUgzeTFkN0FOK1MrbHJnOFRyL1p2UjNJRHN3c3hP?=
 =?utf-8?B?cEJBRzlXaUtzaEZpWGw2aHcranl0UjJUdFlEc0hWSkJFOHk2VUZzUFN5OGdF?=
 =?utf-8?B?Zk45Mklhb0ZZSHkyekpva2dJamhpSzFJeFlYcDcyenBJek10elhJaXFmL3Uv?=
 =?utf-8?B?K0RueHJZVGhTQzkyZWl5cGhNMWUxN25UY0IwTXZBQzVBZi9lejFBb0xjK1Uw?=
 =?utf-8?B?Um1KUHhmdmsvQkdNNWNTc2RtQ0lzWUFHY0ZBZHNKT1RBWkF1QVAzSE56R3B5?=
 =?utf-8?B?TFdtdnpVd3hGRGhuQnBKczhCNlN0K1M4VCsyaXF2Tk5VSndrZk1JY0tDSVMw?=
 =?utf-8?B?ZEMrSjEzQ0lxbWdWdE5UNVFCYlcrazBJeVFKckk2aEdFR1lORDZ0Zk9zanlh?=
 =?utf-8?B?TGQzdXlIVHZPby9aMk1JRFpQVHE5dGxYU2o0c0dQcWNWRkpZWVYzcm9XaHUx?=
 =?utf-8?Q?taTyBx+JV55XGHMO5I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a85a686-f180-4493-4eb6-08de9f8c0980
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:54:54.5301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHxw+LgnjAU509QzhiYSE3Zuvzpi10kvd6PCSeBWgbzzO1BJQjOHBxouV9z3FAisSiHWnoNQVUU5xsoFStc8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527
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



On 4/21/2026 10:31 AM, Huang Rui wrote:
> On Mon, Apr 20, 2026 at 09:12:55PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> V3 of the SVM patch series for amdgpu based on the drm_gpusvm framework.
>> This revision incorporates feedback from V1, adds XNACK on GPU fault handling,
>> improves code organization, and removes the XNACK off (no GPU fault) implementation
>> to focus on the fault driven model that aligns with drm_gpusvm's design.
>> The implementation references extensively from xe_svm.
>>
>> This patch series implements SVM support with the following design:
>>
>>    1. Attributes separated from physical page management:
>>
>>      - Attribute layer (amdgpu_svm_attr_tree): a driver-side interval
>>        tree storing per-range SVM attributes. Managed through SET_ATTR
>>        ioctl and preserved across range lifecycle events.
>>
>>      - Physical page layer (drm_gpusvm ranges): managed by the
>>        drm_gpusvm framework, representing HMM-backed DMA mappings
>>        and GPU page table entries.
>>
>>      This separation ensures attributes survive when GPU ranges are
>>      destroyed (partial munmap, attribute split, GC). The fault
>>      handler recreates GPU ranges from the attribute tree on demand.
>>
>>    2. GPU fault driven mapping (XNACK on):
>>
>>      The core mapping path is driven by GPU page faults instead of ioctls.
>>      amdgpu_svm_handle_fault() looks up SVM by PASID, runs GC,
>>      resolves attributes, then maps via find_or_insert -> get_pages
>>      -> GPU PTE update. For unregistered addresses, default
>>      attributes are derived from VMA properties automatically.
>>
>>    3. MMU notifier invalidation:
>>
>>      Two-phase callback: event_begin() zaps GPU PTEs and flushes
>>      TLB, event_end() unmaps DMA pages. UNMAP events queue ranges
>>      to GC for deferred cleanup. Non-UNMAP events (eviction) rely
>>      on GPU fault to remap.
>>
>>    4. Garbage collector:
>>
>>      GC workqueue processes unmapped ranges: removes them
>>      from drm_gpusvm and clears corresponding attributes. No
>>      rebuild or restore logic, GPU fault handles recreation.
>>
>> Changes since V2:
>>    - Add version tittle in commit message.
>>    - Fix some content mistaken.
>>
>> Changes since V1:
>>    - Added GPU fault handler: amdgpu_svm_handle_fault with PASID-based
>>      SVM lookup, following the standard flow: garbage collector ->
>>      find or insert range -> check valid -> migrate (TODO) / get_pages
>>      -> GPU bind/map.
>>
>>    - Removed the restore worker queue entirely. V1 had separate GC
>>      and restore workers: restore workers were responsible for
>>      synchronously restore in queue stop/start cause no GPU fault support.
>>      With XNACK on fault driven model, synchronous restore is unnecessary,
>>      the GPU fault handler recreates ranges on demand. The GC worker in
>>      V2 is simplified to only discard ranges and clear their attributes,
>>      with no rebuild or restore logic. AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED
>>      support is removed as no restore worker.
>>
>>    - Reworked MMU notifier callback (amdgpu_svm_range_invalidate):
>>      V1 had a monolithic dispatcher with flag combinations and
>>      queue ops (CLEAR_PTE/QUEUE_INTERVAL, UNMAP/RESTORE) plus
>>      begin_restore() to quiesce KFD queues. V2 uses a two-phase
>>      model: event_begin() zaps GPU PTEs and flushes TLB,
>>      event_end() unmaps DMA pages and queues UNMAP ranges to GC.
>>      Non-UNMAP events (eviction) just zap PTEs and let GPU fault
>>      remap. Removed begin_restore/end_restore callbacks,
>>      has_always_mapped_range() check, and NOTIFIER flag dispatch.
>>      Added checkpoint timestamp capture on UNMAP for fault dedup.
>>
>>    - Added amdgpu_svm_range_invalidate_interval(): when userspace
>>      sets new attributes on a sub region of an existing attribute
>>      range, the attribute tree splits the old range and the new
>>      sub region gets different attributes. However, existing
>>      drm_gpusvm ranges may across the new attribute boundary
>>      (e.g., a 2M GPU range covers both the old and new attribute
>>      regions). This function walks all gpusvm ranges in the
>>      affected interval, zaps GPU PTEs and flushes TLB. Ranges
>>      that cross the new boundary and old boundary are removed
>>      entirely so the GPU fault handler can recreate them with
>>      boundaries aligned to the updated attribute layout.
>>
>>    - On MMU_NOTIFY_UNMAP events, discard all affected gpusvm ranges
>>      entirely without synchronous rebuild in v1. The unmap may destroy
>>      more ranges than strictly necessary (e.g., a partial munmap
>>      hits a 2M range that extends beyond the unmapped region), but
>>      the attribute layer preserves the still valid attributes for
>>      the remaining address space. When the GPU next accesses those
>>      addresses, the fault handler automatically recreates the
>>      ranges with correct boundaries from the surviving attributes.
>>      This avoids the synchronous rebuild logic that V1 required
>>      (unmap -> rebuild in GC/restore worker).
>>
>>    - Add attribute creation for unregistered addresses:
>>      amdgpu_svm_range_get_unregistered_attrs() derives default
>>      SVM attributes from VMA properties and GPU IP capabilities
>>      when the faulting address has no user attributes registered.
>>      this feature is needed to pass ROCm user mode runtime tests:
>>      kfd/rocr/hip. ROCm supports no registered virtual address access
>>      with default SVM attributes before, so amdgpu svm needs to support.
>>
>>    - Explicitly returns -EOPNOTSUPP in amdgpu_svm_init when XNACK
>>      is disabled. V1 attempted mixed XNACK on/off support with
>>      complex KFD queue quiesce/resume callbacks and ioctl driven
>>      mapping paths, which added substantial complexity. V2 drops
>>      these implementations to focus on the fault driven model.
>>
>>    - Removed kgd2kfd_quiesce_mm()/resume_mm() dependency that V1
>>      used for XNACK off queue control. For XNACK on, the GPU fault
>>      handler is the enterance for SVM range mapping, so no quiesce/resume
>>      is needed for this version.
>>
>>    - Added new change triggers: TRIGGER_RANGE_SPLIT, TRIGGER_PREFETCH.
>>      for sub attr set and prefetch trigger support.
>>
>>    - Added helper functions: find_locked, get_bounds_locked,
>>      set_default for GPU fault handling.
>>
>>    - Design questions section removed.
>>
>> TODO:
>>    - Add multi GPU support.
>>    - Add XNACK off mode.
>>    - Add migration or prefetch. This part work is ongoing in:
>>      https://lore.kernel.org/amd-gfx/20260410113146.146212-1-Junhua.Shen@amd.com/
>>
>> Test results:
>>    Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on:
>>    - KFD test: 95%+ passed.
>>    - ROCR test: all passed.
>>    - HIP catch test: gfx943 (MI300X): 96% passed.
>>                      gfx906 (MI60):99% passed.
> 
> It would be best to also include the ROCm runtime merge request in the
> cover letter, and clarify that the above test results are based on V3 +
> user-space ROCR.
> 
> https://github.com/ROCm/rocm-systems/pull/4364
> 
> Thanks,
> Ray

Got it, will add in next version.

Regards,
Honglei

> 
>>
>> Patch overview:
>>
>>    01/12 UAPI: DRM_AMDGPU_GEM_SVM ioctl, SVM flags, SET_ATTR/GET_ATTR
>>          operations, attribute types in amdgpu_drm.h.
>>
>>    02/12 Core header: amdgpu_svm wrapping drm_gpusvm with refcount,
>>          attr_tree, GC struct, locks, and VM integration hooks.
>>
>>    03/12 Attribute types: amdgpu_svm_attrs, attr_range (interval tree
>>          node), attr_tree, access enum, flag masks, change triggers.
>>
>>    04/12 Attribute tree ops: interval tree lookup, insert, remove,
>>          find_locked, get_bounds_locked, set_default, and lifecycle.
>>
>>    05/12 Attribute set/get/clear: validate UAPI attributes, apply to
>>          tree with head/tail splitting, change propagation, and query.
>>
>>    06/12 Range types: amdgpu_svm_range extending drm_gpusvm_range
>>          with gpu_mapped state, pending ops, work queue linkage,
>>          and op_ctx for batch processing.
>>
>>    07/12 Range GPU mapping: PTE flags computation with read_only
>>          support, GPU page table update, range mapping loop.
>>
>>    08/12 Notifier and GC helpers: two-phase notifier events, range
>>          removal, GC enqueue/add with dedicated workqueue.
>>
>>    09/12 Attribute change and invalidation: apply attribute triggers
>>          to GPU ranges, invalidate_interval for boundary realignment,
>>          work queue dequeue helpers, checkpoint timestamp.
>>
>>    10/12 Initialization and lifecycle: kmem_cache, drm_gpusvm_init
>>          with chunk sizes (2M/64K/4K), XNACK detection, GC init,
>>          PASID lookup, TLB flush, and init/close/fini lifecycle.
>>
>>    11/12 Ioctl, GC, and fault handler: ioctl dispatcher, GC worker,
>>          and amdgpu_svm_fault.c/h with full fault path including
>>          unregistered attribute derivation and retry logic.
>>
>>    12/12 Build integration: Kconfig (CONFIG_DRM_AMDGPU_SVM), Makefile
>>          rules, ioctl registration, and amdgpu_vm fault dispatch.
>>
>> Honglei Huang (12):
>>    drm/amdgpu: define SVM UAPI for GPU shared virtual memory
>>    drm/amdgpu: introduce SVM core header and VM integration
>>    drm/amdgpu: define SVM attribute subsystem types
>>    drm/amdgpu: implement SVM attribute tree and helper functions
>>    drm/amdgpu: implement SVM attribute set, get, and clear
>>    drm/amdgpu: define SVM range types and work queue interface
>>    drm/amdgpu: implement SVM range GPU mapping core
>>    drm/amdgpu: implement SVM range notifier and GC helpers
>>    drm/amdgpu: implement SVM attribute change and invalidation callback
>>    drm/amdgpu: implement SVM initialization and lifecycle
>>    drm/amdgpu: add SVM ioctl, garbage collector, and fault handler
>>    drm/amdgpu: integrate SVM into build system and VM fault path
>>
>>   drivers/gpu/drm/amd/amdgpu/Kconfig            |  11 +
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  13 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 467 +++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 162 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 952 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 144 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 368 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 863 ++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 148 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  20 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>>   include/uapi/drm/amdgpu_drm.h                 |  39 +
>>   14 files changed, 3231 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>>
>> -- 
>> 2.34.1
>>

