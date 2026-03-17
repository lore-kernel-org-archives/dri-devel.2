Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD989FD8746
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295BA10E21C;
	Tue, 17 Mar 2026 11:48:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="En/G0ZCf";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289E310E21C;
 Tue, 17 Mar 2026 11:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKGqIdp2ZcVJuRIz5dC9x6qb42w5DMu3pR3YdaZV3oTKL+5MMGRcz2TOCORMbog8BCl0r/4DD3ubwtfw7EybPMv5ih5Qzuu9+HBG8OEbV+s8+pJ+heyNzdTjiB6PzOoyMf0MtXq211thTj3ushVbwDHprGrq3ytGJ/dGV8OiOGgbcyOAc9qNeQvZFu40qxLUFl07FMGBHkHdH/IwpKl7dKx2p0v9JWgqC11pkP+IZmHf3W0Ixfa3pQSEjVW/DJ3Vzzl17QHDMb9NSDFBAVnm7WiwsCDkCb70g1uiqWWXquObmMIhVdTyDem7n+c4RAFzcaflsK+trb0WYTFVA8MRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjvBwrMqFKa1zHrnxbNFbmDCOMa3hC7q6pvYFm2DYe4=;
 b=SQKq5U/5E++5WRt4QyjSx1gCwzTrnhO+TWvWTSzz+VgQ5/2DOEQHng3J4loRRjuVsbg03WEerdbSaJNRuU2uW+Hd7Rg5Q0xuMs37r13AbcoHL9tRHpeAj1oognIqT4Xrgg97O1PXmiTnuJTLLuNPlxLNecIOU2nI4X5t+6Epv9AUX+MGQTZERcnyfu504FN1vn/phqes3KEH2n7B7/3rg7CfvRSFApZsMwTOR0+xwesa/8pnFzzbnyHMl/hA94l+eSeAqEQmQPxE20NmvTapv5J1GZbMAlOZg1KnaMjl3TgXYuYaDayFngj9nGkwxgB5qlHFVL+HJDD2xbJeSXozhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjvBwrMqFKa1zHrnxbNFbmDCOMa3hC7q6pvYFm2DYe4=;
 b=En/G0ZCfLm45dQuoMRz54TlHBI0weob/QrY/k1ZEZcLr32WE/pOmj7KPBKGZv2FiisIVdt/9k/OM1J3VFhZdMWc8EhtfIx0Rt3wR8SRbnZGo9vx1+sBGAug+/4luWKxuVE0vloKe0YML8yiBJrnxXcpDPf3KAsfheRnus3jJ5rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 11:48:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 11:48:34 +0000
Message-ID: <e21e8e1a-4d2e-40e9-bbb7-2764cf33e760@amd.com>
Date: Tue, 17 Mar 2026 12:48:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
To: Honglei Huang <honglei1.huang@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 honghuan@amd.com
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260317112958.2925370-1-honglei1.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb0e3d1-a46d-407e-8e5d-08de841b1e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: RO18tBYaYQ4W9smfhM1Ab4joOzPyQBLLYTXtAt2WZ1pAHpwbXryflpWfZ2kXgiVX6/zGjhpDwnmXl0KRK0w/QMw05ZdqjQTgHdRed8DRyMD1zL0rDAXPqGey30WGZlEN1K6F1kYYprER0+hsXb6ngXNEMZg/oZCBQMxyMmWEOl68Bx+WLVf7Vq9KNx51SoE5JGkShpyKonllcsIq9rnFBFKMj4nbLUt8daQcQ4nTM7BGQejWtZjr+ZNohCG+yDlMY7daBDJ+XOkHPz6haUU5pRObVKjI6dvYALRdCuFbpt/7A0uL0zGsiT0uzv+DJTko86fuLTuj+5TDdRuGB0CUu02tvAQ8kpjDuKuzyRUm0vlP07CYEHUeo9TBp8O4Z34X6mU/EVU9CQQL+HEyUQQhgPG3wYS2/4YkQJ3Zx4Wl3BnQWYn3ReYeqSUpgvUgtKBXBZ7uECCgYk0DHYwvWdBswbT042zLfdDAiOeGwO51o7X6USb9WZY+x1ghTNl38ljlxKdG/hGhzqm57v+bCGdT7jq3++OtxsNsqLG00vvBlj9s48dKX+fuIdnEL8BIXDRl+E/CH25a8fBYYTvBFUwd3+JjAQXxinWU7ax5gxYxraCQ/hWwCkBMhEUJr0Tthq/KGjS8ZpAbeGHyhATtR6Kv7/u/JpeY1TTfUF96i13nZ6N5Vqv6ZWWMn1J8ZKkZVKlJGP+rVlY+oAyzA/ZYRrkAkV9kNiD3spajvMj21mlr0i8JVPAMgg2iodRUZs2N7eMd9/ukw6Fx5UxdFiPFtTgOsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjM1eEdkT25NR1VmcmkweGs3QWplTUJuMzY5WkJPRjNnUXlEUnl3Z3ZicDk5?=
 =?utf-8?B?K3c4eWROUlFxREw5cUdiTTUrNXJDY1AwcEFUTFJidWFwSXJqcW9jOEZsbUk1?=
 =?utf-8?B?bmNBenJMVXFTZlQ5bTkxYllLM1RrbS9xWkUrNzBvVlFRSUxER1J5WkdaR0Qw?=
 =?utf-8?B?eW1sQmJHcTF6SVFVYmJTOGpoL0RFaE1yT2l4dlFoMUEzRXhIczhEMUZhdEpE?=
 =?utf-8?B?bDZUdUR2SWZwU2VSQ2R3aGpDY2VMWng1NHIyb3doVldaWitzSUJtTEdYODhI?=
 =?utf-8?B?b3VjNW11TnJJd0VWTHZpZjNIU2xJSGxGRXF2WWxNMXlHS3o0cjJYQ2xiN2RP?=
 =?utf-8?B?M3pwZ09EOTRqQ2NTOStJbHFFeWVHdzZmc0xpcXRDbkFZeUE4ZFp1NkMxUHZ0?=
 =?utf-8?B?VkVFcTc4RHNqR09JOGJES2VkL09OT3BOTEpDcjY1TVFJd1RHTXdJTUpiK0g5?=
 =?utf-8?B?NFFrVkdUVmNsaGZHcXZQUVh5OVh2TVQyeU55dEVBYmRPOGdPZGR6YXFtWTEv?=
 =?utf-8?B?MUovUjM3UFRYbGkrWVFGTTl2NkY2clpCM1RjUitJOFFBSEgrTHdLdWdUVEdH?=
 =?utf-8?B?YnQ1cUZvOERPNDAxSG1Zb0pCT291KzFvQU1qcmF5L3EyL2t0QlA5TlhFZHJ4?=
 =?utf-8?B?NnhxYzVzby9wdUVhQ0VObkQ5K1p4bm51MWZRZTl6eGVGcTVpUEFROUdvWEFz?=
 =?utf-8?B?R3R5Mm83bWdQTjVRMUtld0tOcjNKTWVBOGNCRjFKaUkrMkJiaDI2bmx5dkpZ?=
 =?utf-8?B?Mm9BNmt5bm1Ualdzc2dpTTRUdnl3ZHF6MFFwdXJxVmd6VTk5V2FHampVaW5I?=
 =?utf-8?B?SHg0Q0N2dDg1bWlWdG9VU1lrTkpIWUFCZmMxSGZra3lvS0tuZWVmeUJ6MW5m?=
 =?utf-8?B?blBKWjg2U1MxOVdtRWh4Zk1KZ1FIUnFMQlpVMEowUmRGN1RWVkp4dTJFN290?=
 =?utf-8?B?YWFETVMwdFBZNjlGdWF4ZkpvVnJ1QVpEU21OUEM0WEttcjlMSSthQUNTakFM?=
 =?utf-8?B?Uy9KQlRmYVViUWVydnc4N0RmYTdrODVnazhybUtCQTNXaCthVndBMCtjNDdO?=
 =?utf-8?B?NW8rZnVMb0ZjVE93R2N4SGUwVk42YjlkejJHOFRsWGNoL3BLZzU2aHl6V0Nw?=
 =?utf-8?B?Zjl5blRTZXFvNFc2b2l4c2lrSUdwK1lOK2JMUmtRSUY3ZDI4c1JYdXgwSExG?=
 =?utf-8?B?UGhxbU1qS091RVBxWEZOZlpvYkQ0aXRZTE9ybWtoRzhQQTBGdGd2RitsTVNB?=
 =?utf-8?B?Mlo0YXJjYmlMT2tDWnZseW5aK1haSjN5UzNtdE8wajQxZ3Bmem1vOHpseUNx?=
 =?utf-8?B?QWU2d1dxd0YvYjdOa25iYk1NbS9WNndmWFo1SWNPbG1xWVFILzhaM29DSm13?=
 =?utf-8?B?eWkrczRsMkJiZEJJR3B6T2M5b3M5TVd2WnJncHlyMU5TeE5kMEtVb3VVQVRt?=
 =?utf-8?B?MW1RdXM1ZlE1aUJOOTc0bjRWNFhHVGlvYndEWVc1WTFyUjJtRmw5ZlRVSTNY?=
 =?utf-8?B?ODFmUjB0RzZyS2xBMFhrNXo5SVRQNkhhMysrQ3hhWDlhc1RIdzhiQTRRTlNB?=
 =?utf-8?B?TDk1VnVIai9PZ1o3Q0YrbWcrc2hTekZmeERod3VPZ1NXd0llRmdLQ2FORitz?=
 =?utf-8?B?S3pOV2lNbVlQUzhYZm1aekFtTDN0OTNJZGtBUnZFemRoSmp2UGNNVGxHQ1M4?=
 =?utf-8?B?YnRjTUdGZjZVcjI0aW5GamlCQkgzSkc1WjlTZDFhbmNPSzhoN1l6T2ZpT2Fu?=
 =?utf-8?B?cEVQeVNHQzBkMUhiUkpFbTdqMm40RnlLTGZ1d3JId1cvbHZ1WjI5REpLTDl0?=
 =?utf-8?B?ZDFtU1oxM3VlYkhUUmovSFNrNjNMeC9PcE9UT1E4U1J2RE9iN2x1MDhaMkVi?=
 =?utf-8?B?Y3YzZzdyWUJMNHFBZVN1eGFja0owMmY3UG1XVHBIcC9IRXFUNDVjeDMwRVFr?=
 =?utf-8?B?V2FqUENhL0lLM2syWnRHNkQ2TWkyN1JFNXBwQ1pCd3RBWVFjNEFkQm9vUmZn?=
 =?utf-8?B?aUFZQ1JIYUE0bjhMSU9RYzRvcFFhMHJuMzFHR05wT3VraW9wcUZqS1BIVUJ3?=
 =?utf-8?B?a3RseGJ3Q2dDTCtVeXpTV0lENFc0U2Z6MVUxUnRLbVNYMkhlZXF1dDFJaVVT?=
 =?utf-8?B?RnNVOUUzVk5UcUZWbm5LMHZvcnVuZ2V1V1ViM0dvSFRNNERETnJIdmE3V0Fu?=
 =?utf-8?B?MWFoazNzYkx1cTZzdGxKZ3M5MFQreDhXWEVONTBYcFE1Z1dGa2Zsb29vMFZP?=
 =?utf-8?B?dXhuYjlremIxRjFnK2xWZ2R2RHJ0dEkwTzZiaVhZK2VvWmI3NVFySXp5OTBx?=
 =?utf-8?Q?oOMNCo6uc08r2RY8vg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb0e3d1-a46d-407e-8e5d-08de841b1e32
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:48:34.0519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evnDRpB6XtdnJj2gOAoDTceCv/nFcotBtFnekT04e6s4p/Pwm69wQQIYLqtmcvLy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
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

Adding a few XE and drm_gpuvm people on TO.

On 3/17/26 12:29, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> This is a POC/draft patch series of SVM feature in amdgpu based on the 
> drm_gpusvm framework. The primary purpose of this RFC is to validate
> the framework's applicability, identify implementation challenges, 
> and start discussion on framework evolution. This is not a production 
> ready submission.
> 
> This patch series implements basic SVM support with the following features:
> 
>   1. attributes sepatarated from physical page management:
> 
>     - Attribute layer (amdgpu_svm_attr_tree): a driver side interval
>       tree that stores SVM attributes. Managed through the SET_ATTR,
>       and mmu notifier callback.
> 
>     - Physical page layer (drm_gpusvm ranges): managed by the
>       drm_gpusvm framework, representing actual HMM backed DMA
>       mappings and GPU page table entries.
> 
>      This separation is necessary:
>        -  The framework does not support range splitting, so a partial 
>           munmap destroys the entire overlapping range, including the 
>           still valid parts. If attributes were stored inside drm_gpusvm
>           ranges, they would be lost on unmapping.
>           The separate attr tree preserves userspace set attributes
>           across range operations.

Isn't that actually intended? When parts of the range unmap then that usually means the whole range isn't valid any more.

> 
>        -  drm_gpusvm range boundaries are determined by fault address
>           and pre setted chunk size, not by userspace attribute boundaries.
>           Ranges  may be rechunked on memory changes. Embedding
>           attributes in framework ranges would scatter attr state
>           across many small ranges and require complex reassemble
>           logic when operate attrbute.

Yeah, that makes a lot of sense.

> 
>   2) System memory mapping via drm_gpusvm
> 
>      The core mapping path uses drm_gpusvm_range_find_or_insert() to
>      create ranges, drm_gpusvm_range_get_pages() for HMM page fault
>      and DMA mapping, then updates GPU page tables via
>      amdgpu_vm_update_range().
> 
>   3) IOCTL driven mapping (XNACK off / no GPU fault mode)
> 
>      On XNACK off hardware the GPU cannot recover from page faults,
>      so mappings must be established through ioctl. When
>      userspace calls SET_ATTR with ACCESS=ENABLE, the driver 
>      walks the attr tree and maps all accessible intervals 
>      to the GPU by amdgpu_svm_range_map_attr_ranges(). 
> 
>   4) Invalidation, GC worker, and restore worker
> 
>      MMU notifier callbacks (amdgpu_svm_range_invalidate) handle
>      three cases based on event type and hardware mode:
>        - unmap event: clear GPU PTEs in the notifier context,
>          unmap DMA pages, mark ranges as unmapped, flush TLB,
>          and enqueue to the GC worker. On XNACK off, also
>          quiesce KFD queues and schedule rebuild of the
>          still valid portions that were destroyed together with
>          the unmapped subregion.
> 
>        - evict on XNACK off:
>          quiesce KFD queues first, then unmap DMA pages and
>          enqueue to the restore worker.

Is that done through the DMA fence or by talking directly to the MES/HWS?

Thanks,
Christian.

> 
>        - evict on XNACK on:
>          clear GPU PTEs, unmap DMA pages, and flush TLB, but do
>          not schedule any worker. The GPU will fault on next
>          access and the fault handler establishes the mapping.
> 
> Not supported feature:
>   - XNACK on GPU page fault mode
>   - migration and prefetch feature
>   - Multi GPU support
> 
>   XNACK on enablement is ongoing.The GPUs that support XNACK on 
>   are currently only accessible to us via remote lab machines, which slows
>   down progress.
> 
> Patch overview:
> 
>   01/12 UAPI definitions: DRM_AMDGPU_GEM_SVM ioctl, SVM flags,
>         SET_ATTR/GET_ATTR operations, attribute types, and related
>         structs in amdgpu_drm.h.
> 
>   02/12 Core data structures: amdgpu_svm wrapping drm_gpusvm with
>         refcount, attr_tree, workqueues, locks, and
>         callbacks (begin/end_restore, flush_tlb).
> 
>   03/12 Attribute data structures: amdgpu_svm_attrs, attr_range
>         (interval tree node), attr_tree, access enum, flag masks,
>         and change trigger enum.
> 
>   04/12 Attribute tree operations: interval tree lookup, insert,
>         remove, and tree create/destroy lifecycle.
> 
>   05/12 Attribute set: validate UAPI attributes, apply to internal
>         attrs, handle hole/existing range with head/tail splitting,
>         compute change triggers, and -EAGAIN retry loop.
>         Implements attr_clear_pages for unmap cleanup and attr_get.
> 
>   06/12 Range data structures: amdgpu_svm_range extending
>         drm_gpusvm_range with gpu_mapped state, pending ops,
>         pte_flags cache, and GC/restore queue linkage.
> 
>   07/12 PTE flags and GPU mapping: simple gpu pte function,
>         GPU page table update with DMA address, range mapping loop:
>         find_or_insert -> get_pages -> validate -> update PTE,
>         and attribute change driven mapping function.
> 
>   08/12 Notifier and invalidation: synchronous GPU PTE clear in
>         notifier context, range removal and overlap cleanup,
>         rebuild after destroy logic, and MMU event dispatcher
> 
>   09/12 Workers: KFD queue quiesce/resume via kgd2kfd APIs, GC
>         worker for unmap processing and rebuild, ordered restore
>         worker for mapping evicted ranges, and flush/sync
>         helpers.
> 
>   10/12 Initialization and fini: kmem_cache for range/attr,
>         drm_gpusvm_init with chunk sizes, XNACK detection, TLB
>         flush helper, and amdgpu_svm init/close/fini lifecycle.
> 
>   11/12 IOCTL and fault handler: PASID based SVM lookup with kref
>         protection, amdgpu_gem_svm_ioctl dispatcher, and
>         amdgpu_svm_handle_fault for GPU page fault recovery.
> 
>   12/12 Build integration: Kconfig option (CONFIG_DRM_AMDGPU_SVM),
>         Makefile rules, ioctl table registration, and amdgpu_vm
>         hooks (init in make_compute, close/fini, fault dispatch).
> 
> Test result:
>   on gfx1100(W7900) and gfx943(MI300x)
>   kfd test: 95%+ passed, same failed cases with offical relase
>   rocr test: all passed
>   hip catch test: 20 cases failed in all 5366 cases, +13 failures vs offical relase
> 
> During implementation we identified several challenges / design questions:
> 
> 1. No range splitting on partial unmap
> 
>   drm_gpusvm explicitly does not support range splitting in drm_gpusvm.c:122.
>   Partial munmap needs to destroy the entire range including the valid interval.
>   GPU fault driven hardware can handle this design by extra gpu fault handle,
>   but AMDGPU needs to support XNACK off hardware, this design requires driver 
>   rebuild the valid part in the removed entire range. Whichs bring a very heavy
>   restore work in work queue/GC worker: unmap/destroy -> rebuild(insert and map)
>   this restore work even heavier than kfd_svm. In previous driver work queue 
>   only needs to restore or unmap, but in drm_gpusvm driver needs to unmap and restore.
>   which brings about more complex logic, heavier worker queue workload, and 
>   synchronization issues.
> 
> 2. Fault driven vs ioctl driven mapping
> 
>   drm_gpusvm is designed around GPU page fault handlers. The primary entry
>   point drm_gpusvm_range_find_or_insert() takes a fault_addr.
>   AMDGPU needs to support IOCTL driven mapping cause No XNACK hardware that
>   GPU cannot fault at all
> 
>   The ioctl path cannot hold mmap_read_lock across the entire operation
>   because drm_gpusvm_range_find_or_insert() acquires/releases it
>   internally. This creates race windows with MMU notifiers / workers.
> 
> 3. Multi GPU support
> 
> drm_gpusvm binds one drm_device to one instance. In multi GPU systems,
> each GPU gets an independent instance with its own range tree, MMU
> notifiers, notifier_lock, and DMA mappings.
> 
> This may brings huge overhead:
>     - N x MMU notifier registrations for the same address range
>     - N x hmm_range_fault() calls for the same page (KFD: 1x)
>     - N x DMA mapping memory
>     - N x invalidation + restore worker scheduling per CPU unmap event
>     - N x GPU page table flush / TLB invalidation
>     - Increased mmap_lock hold time, N callbacks serialize under it
> 
> compatibility issues:
>     - Quiesce/resume scope mismatch: to integrate with KFD compute
>       queues, the driver reuses kgd2kfd_quiesce_mm()/resume_mm()
>       which have process level semantics. Under the per GPU 
>       drm_gpusvm model, maybe there are some issues on sync. To properly
>       integrate with KFD under the per SVM model, a compatibility or 
>       new per VM level queue control APIs maybe need to introduced.
> 
> Migration challenges:
> 
>   - No global migration decision logic: each per GPU SVM
>     instance maintains its own attribute tree independently. This
>     allows conflicting settings (e.g., GPU0's SVM sets
>     PREFERRED_LOC=GPU0 while GPU1's SVM sets PREFERRED_LOC=GPU1
>     for the same address range) with no detection or resolution.
>     A global attribute coordinator or a shared manager is needed to
>     provide a unified global view for migration decisions
> 
>   - migrate_vma_setup broadcast: one GPU's migration triggers MMU
>     notifier callbacks in ALL N-1 other drm_gpusvm instances,
>     causing N-1 unnecessary restore workers to be scheduled. And 
>     creates races between the initiating migration and the other
>     instance's restore attempts.
> 
>   - No cross instance migration serialization: each per GPU
>     drm_gpusvm instance has independent locking, so two GPUs'
>     "decide -> migrate -> remap" sequences can interleave. While
>     the kernel page lock prevents truly simultaneous migration of
>     the same physical page, the losing side's retry (evict from
>     other GPU's VRAM -> migrate back) triggers broadcast notifier
>     invalidations and restore workers, compounding the ping pong
>     problem above.
> 
>   - No VRAM to VRAM migration: drm_pagemap_migrate_to_devmem()
>     hardcodes MIGRATE_VMA_SELECT_SYSTEM (drm_pagemap.c:328), meaning
>     it only selects system memory pages for migration.
> 
>   - CPU fault reverse migration race: CPU page fault triggers
>     migrate_to_ram while GPU instances are concurrently operating.
>     Per GPU notifier_lock does not protect cross GPU operations.
> 
> We believe a strong, well designed solution at the framework level is
> needed to properly address these problems, and we look forward to 
> discussion and suggestions.
> 
> Honglei Huang (12):
>   drm/amdgpu: add SVM UAPI definitions
>   drm/amdgpu: add SVM data structures and header
>   drm/amdgpu: add SVM attribute data structures
>   drm/amdgpu: implement SVM attribute tree operations
>   drm/amdgpu: implement SVM attribute set
>   drm/amdgpu: add SVM range data structures
>   drm/amdgpu: implement SVM range PTE flags and GPU mapping
>   drm/amdgpu: implement SVM range notifier and invalidation
>   drm/amdgpu: implement SVM range workers
>   drm/amdgpu: implement SVM core initialization and fini
>   drm/amdgpu: implement SVM ioctl and fault handler
>   drm/amdgpu: wire up SVM build system and fault handler
> 
>  drivers/gpu/drm/amd/amdgpu/Kconfig            |   11 +
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   13 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  430 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |  147 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |  894 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  |  110 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 1196 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   76 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   40 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |    4 +
>  include/uapi/drm/amdgpu_drm.h                 |   39 +
>  12 files changed, 2958 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> 
> 
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449

