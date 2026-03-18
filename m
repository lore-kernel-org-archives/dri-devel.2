Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D93EFCD0DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C4A10E00E;
	Wed, 18 Mar 2026 08:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b0q3LbDR";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3F010E009;
 Wed, 18 Mar 2026 08:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIGT2XlL5PLofSIeda72MVJIgIwu+rd5xDzphYAfrGfthexlAWkVtImBk05FUeigmPTFa1+mehP8bg1hQqA0YH16TL15zdQxs+vd+ZroelQ6044eQzyhhkiYNATrtL2hOG8A+aeBgtdtMdJ6+lKp3HCGF+ODThcszmZkhv4nyqXmFqv4Ne86ZbBCgWVTA2jXXUbIWGfVMPe3146W3lPrnKln2V3ZKhejAh74+85EhKkC3IJfWiAZiJtLRMPfKEr5YT3ekQEK+SG85LyXrKSw7wFOYA9V/l/PPEWWss4qemn6QTfX232fAOiUfEKbybn23lAKbTtLik98uNy4eJVUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMjx6awYWL6/41yATcQaDaULEceFld6pNaJS5rfb+A4=;
 b=WdarPWGEE02kyKywntYTFDptFiYOyQuoYKKIXc6ecrFVdU8U8y9E/Nu1qnexAKfrb8P49YWgePzTdQArSifo6+z5Q3HFLRAAdoT+B96Qvu+iV9hZ9AYvmpQcWMUoNhw7DV+WerdPo3UG97SdH2vyn8ePTLYfmrTlc6G1DPEijYZDZhSwmDCUkWHJ05SXUzRiq8iZI8QjhrX0ZqO4lH1Sv+qU2yWpIVfPkp4BgCYLZgyneRv2JQo69d93L8KaTQKLqjupOM1mUy5Lq/yT5MsWU7AHPXGDcHhSxpK7gJPqAkqA7dezWmJlKYpqbzpkau7/Je1d9MaB8u/i8aczvQf0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMjx6awYWL6/41yATcQaDaULEceFld6pNaJS5rfb+A4=;
 b=b0q3LbDRBkrGJdMkY3ya8dIpyzckqqU3QInMBMK1FnATcBRFhsrUNSNg9SPGgAnTIW1K9zIijdNflGtDCTMb7pOjIGrH3K4LNyW6QwpSCByQOyhSjyX/MO8182HppcqxUK4SXeldZtcqZFNP6mjUDWV+WgqMumFHMBMumZqjq10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 08:59:42 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 08:59:41 +0000
Message-ID: <ae5fe946-4756-43b4-848f-3b545ac61ba7@amd.com>
Date: Wed, 18 Mar 2026 16:59:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Honglei Huang <honglei1.huang@amd.com>, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
 <e21e8e1a-4d2e-40e9-bbb7-2764cf33e760@amd.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <e21e8e1a-4d2e-40e9-bbb7-2764cf33e760@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2a5cc5-2dec-40b7-2d73-08de84ccb0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 4jYD+KgvVdsIXfkBxz2LnQ0NLhmHup+K2uzEWaMABBbr91mwbuJcwE358R0mHz1dgwOcFqmV43YGRR/E8K4qqxnuirmvqvCCL/ZbdLLJuzngH0spjhdc8Dhya86AsBGRyLr89GKp4Q9Us6IXUhwEKsCF8pgU0YMMgJBATA9JmgyaAgkL9ghZATsijZY5qXDJ23K7y229UNRzCemyvgmLRpamSzZz4I0Q/mvwswRTU5CGmXjudeyL3D/pHAN8QeYV8HPLJ3qWeBMzz1F2Q6OH7Cz2D1lvNIL5tbHTF5sQ0B1cXt5bafQ+krY+jTi3DZtCvf5Z0ajD+2DV33SWAlZQ+ezrF543ZxHwomji95ySzsiqOjOaHy5WPhw45gF8vtuHWNWpudelgA2HeD0zSsxe3/FJSk82Ly8W4x5e+tfGt3UZI2MDEkcZDZ124TX84neuKhvmtse/3a01B0GlanAx22HBXEHr0wUVWUixQXYZ1ZOUhseQb2JC3Hoyv4ena6yXK7xYrBs1d5ETdhyeyEmUP4XtpXnhsdKmfWpZW2IIah643IFEXaWFMoq3YAiw9yJilji/Bnofy0R9/RaldhqLtADP6AOHUrja5ee5AjegGe5l2HDrNWgEOH3udEI0vJEXA1lZ03OFcDz6EMGzB9y0KxA9I2Pb8U2AJn7xhYzLBu/58oLJEBBg9kY8laqLt1S9C7UUGzolFVXf6PNuuJh/J+DQQVZNriEEO4a/s8A5pAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nys4RUVBYWJmVVAraFFjMUt4STc5cTJjSmI2V1ZjZ2FhdGlScWJoazdFMmds?=
 =?utf-8?B?eS8zNjJMQW1GdkE0YldUK0hzemlEdkZDRTl4NXJFek5pMXg4R1JrLzJLVWtF?=
 =?utf-8?B?QnRsM3MrcmNTanRHVy9aazE1ZlVXQm5WUG15Wkt5TmQ0Z29Jdk4yYkRLemlB?=
 =?utf-8?B?RVFrQlFrUWtFUXNkNEdiSEhHZGl6aDdoMzd1aGIrQVRGL1I2OXFzY0U0Vmlx?=
 =?utf-8?B?U21TQ0dodVZueUU3QXpOYVNuSzNGNDJtY1NMek5Pd3YyRUtHQ1dvTmlXR3h6?=
 =?utf-8?B?UytjT2htdGRtNWNaQ3g4VnVMYVl0L2g0TlhlTmVFUVJ5TjZVc1RLV0hSdEgr?=
 =?utf-8?B?U0xldzE4bzZuSEc5aTdaZzF1WFNuM05OZnZTanpaZ0dORGlJZXh6RkN1ZjBH?=
 =?utf-8?B?THJoWnZvS1lCS3l2L3lZTTFsazh0ZlRTbGRYQjdISGFZK1N2c1Z5bHdVcFR6?=
 =?utf-8?B?VU8veUgvbjUxdFY4bSt5ZTErcFMvbjVYdUpkRjdlTHRXK2cxWW51R01DVmds?=
 =?utf-8?B?aDNBQVFxblZrOGhrSDFYTnkxSTFUVnhxYlZJRGJrVitKUkJYaFZzekFPTUhq?=
 =?utf-8?B?TVZUcjBRbFhqYk9lNG9MK2xrMmhQRlZuY1BZT0owOXNHODY0WlZjWXRrT0h4?=
 =?utf-8?B?QS9la3hiYXplSC8vaTdvNVVpY2lsSzVvOS83TnhIZVgvSVl0Z1o2elR0SGhC?=
 =?utf-8?B?dm1wZmJPcWFNbVlzVFNYTCtpSFhtWmRkek9aNHB6d3JFem5keTFoV0xhS3JX?=
 =?utf-8?B?VVA5UEk3MEdGQjduV0twVms2TmNQRk11YUJwZEFiZFVBOVVRZGI4b2JJV2o4?=
 =?utf-8?B?SGU4Qmo2Uks2OFFUSzRjdmIwVmVwSEpjWFR1V0w4ZGMvLzBXRk5WSGVUamdX?=
 =?utf-8?B?T2dJZUFOU1RzdktrTnJxcFl2ZUxNZmxKa1pKdjJlRWVaVm9pVyt3KytvT1NW?=
 =?utf-8?B?Y2trYVIxTHFOdUxLOTlmUFVSSnVVb3B4b1h5WEpvSUZVUlZIbUwxNmNWUy8r?=
 =?utf-8?B?ejJ5bWdIbmtTSGZmaFFwaHh1cHNGNTF3NkdqL2QyL3I5aGZUZm5qeUJzanow?=
 =?utf-8?B?TmV1eE41S1ZmeXZXbTBweGRXVkFPNm1lUHFGWVQzQzlvMWlMb3lQY1BBY0tI?=
 =?utf-8?B?Qitad1dxQnBaOUtKOVhFZ2E1MGU3ZGVtMlhBa0RVd1RoUG8vTWJuYXJncCtk?=
 =?utf-8?B?ZkRmSjZaWmRxL3AyeEdJc3J1YTZBQ25qeDFJSHg4THRTdCtKWXdsNTdrLzBW?=
 =?utf-8?B?UC9TcEVBU0tMNVlMbUFtbk9ZWStpYkNGOVlKTiszTmpPMVZCQndMTG1rVUlQ?=
 =?utf-8?B?Y3hrZ3FVOXYraHlFNFlOYTVDbUpQNVhVNmxoQVdnT0ZRdm9IK2Zka051TjVS?=
 =?utf-8?B?V0poM2ZZcGRzRXpYZVNwR2F5RTZhUXRBeFF4ZmFTcnpNWnN3bkFOQ3RMUC9H?=
 =?utf-8?B?Yk1LNVpLNnMzUmZTeDdHTHhGVW9mYUFwZ3NkcDd3d2p0UFIrYmVORjhQWG13?=
 =?utf-8?B?dkFJWE1ZOFl1MGlQVzVVYlQzOXhyMnhnMkEwSXRuOVF0NEpzbXlyVkt1SmhV?=
 =?utf-8?B?L3ViQ0l2VjY1bXBSclU1WVlLdERHMG5JMS8xb293VUJUbVh2ank4Z1labU9B?=
 =?utf-8?B?cjFVY20weElVQm94R2ZFcG5SREk0ZTdaUWZObUZCNWhTcTVFYTNodEtZdklU?=
 =?utf-8?B?bFg2ckZJWllSNHd0UmgveVdxZ2xPcXNoMWhkejA4Q01WTEQreWRHT3RVRGVD?=
 =?utf-8?B?UmZ3U3Z0QVgzUEE1MlVqN3paa3A4MlBlbnk5WjJMZmtrV3ZLNTdtaW5VRGNV?=
 =?utf-8?B?ekNPZjRMa1RvYmVYZ28yUjB3cFQ5WStRWWdZTnRpdldFOVl1VHh2YXhxTXhS?=
 =?utf-8?B?dXVrME1VQlQ5UjQrN3NWMkVpMXVZSkZ5UXgxWGRHWG5meThBM1ltb1lDSEFu?=
 =?utf-8?B?K01zc2J3WXhablJIUDdyWGRDNk1ZR1ZZa1lJTG9ubThlcmY3YkZBYXRDakVY?=
 =?utf-8?B?U0lzREtxVHBhMHo5alZXQm9LQ3hWRG1ObHpUWFpuSGppeUJuSUx1RFYyUytD?=
 =?utf-8?B?bEtjRFUrYmtHREhWMjdqQi90MlA3anNtbkgveUFCWGM4d3pmenlLKzlLSXJH?=
 =?utf-8?B?djUzb0Y1bEhtc2hTRjdIRXR6Vng2cDM3bDNPbDluZ3EyTFN4bHo1b1BBb3k3?=
 =?utf-8?B?RWVpdzRnQ2N4cHFLWXRKZ1R0c09yRUkzMFdFYk1ueGxOV2JMSTRTSmdIK01m?=
 =?utf-8?B?ZkdzU25BMVpaZU9OR0c3YTFrWlJlN2syOVhrb0s3QkVsL2c3S2I2bFBOVWRZ?=
 =?utf-8?Q?ZFzFmKrsi4NilNbPX7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2a5cc5-2dec-40b7-2d73-08de84ccb0fa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:59:41.2551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AemBhKrVLMunYEShqm94ZRvPXqE92sKYQHl61RWNa2490wzQp/GaRz/QvmBGr7hxmjstDYetxnFptamZhmy4qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786
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



On 3/17/26 19:48, Christian König wrote:
> Adding a few XE and drm_gpuvm people on TO.
> 
> On 3/17/26 12:29, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> This is a POC/draft patch series of SVM feature in amdgpu based on the
>> drm_gpusvm framework. The primary purpose of this RFC is to validate
>> the framework's applicability, identify implementation challenges,
>> and start discussion on framework evolution. This is not a production
>> ready submission.
>>
>> This patch series implements basic SVM support with the following features:
>>
>>    1. attributes sepatarated from physical page management:
>>
>>      - Attribute layer (amdgpu_svm_attr_tree): a driver side interval
>>        tree that stores SVM attributes. Managed through the SET_ATTR,
>>        and mmu notifier callback.
>>
>>      - Physical page layer (drm_gpusvm ranges): managed by the
>>        drm_gpusvm framework, representing actual HMM backed DMA
>>        mappings and GPU page table entries.
>>
>>       This separation is necessary:
>>         -  The framework does not support range splitting, so a partial
>>            munmap destroys the entire overlapping range, including the
>>            still valid parts. If attributes were stored inside drm_gpusvm
>>            ranges, they would be lost on unmapping.
>>            The separate attr tree preserves userspace set attributes
>>            across range operations.
> 
> Isn't that actually intended? When parts of the range unmap then that usually means the whole range isn't valid any more.


It is about partial unmap, some subregion in drm_gpusvm_range is still 
valid but some other subregion is invalid, but under drm_gpusvm, need to 
destroy the entire range.

e.g.:

           [---------------unmap region in mmu notifier-----------------]
[0x1000 ------------ 0x9000]
[  valid ][     invalid    ]

see deatil in drm_gpusvm.c:110 line
section:Partial Unmapping of Ranges


> 
>>
>>         -  drm_gpusvm range boundaries are determined by fault address
>>            and pre setted chunk size, not by userspace attribute boundaries.
>>            Ranges  may be rechunked on memory changes. Embedding
>>            attributes in framework ranges would scatter attr state
>>            across many small ranges and require complex reassemble
>>            logic when operate attrbute.
> 
> Yeah, that makes a lot of sense.
> 
>>
>>    2) System memory mapping via drm_gpusvm
>>
>>       The core mapping path uses drm_gpusvm_range_find_or_insert() to
>>       create ranges, drm_gpusvm_range_get_pages() for HMM page fault
>>       and DMA mapping, then updates GPU page tables via
>>       amdgpu_vm_update_range().
>>
>>    3) IOCTL driven mapping (XNACK off / no GPU fault mode)
>>
>>       On XNACK off hardware the GPU cannot recover from page faults,
>>       so mappings must be established through ioctl. When
>>       userspace calls SET_ATTR with ACCESS=ENABLE, the driver
>>       walks the attr tree and maps all accessible intervals
>>       to the GPU by amdgpu_svm_range_map_attr_ranges().
>>
>>    4) Invalidation, GC worker, and restore worker
>>
>>       MMU notifier callbacks (amdgpu_svm_range_invalidate) handle
>>       three cases based on event type and hardware mode:
>>         - unmap event: clear GPU PTEs in the notifier context,
>>           unmap DMA pages, mark ranges as unmapped, flush TLB,
>>           and enqueue to the GC worker. On XNACK off, also
>>           quiesce KFD queues and schedule rebuild of the
>>           still valid portions that were destroyed together with
>>           the unmapped subregion.
>>
>>         - evict on XNACK off:
>>           quiesce KFD queues first, then unmap DMA pages and
>>           enqueue to the restore worker.
> 
> Is that done through the DMA fence or by talking directly to the MES/HWS?

Currently KFD queues quiesce/resume API are reused, lookig forward to a 
better solution.

Regards,
Honglei

> 
> Thanks,
> Christian.
> 
>>
>>         - evict on XNACK on:
>>           clear GPU PTEs, unmap DMA pages, and flush TLB, but do
>>           not schedule any worker. The GPU will fault on next
>>           access and the fault handler establishes the mapping.
>>
>> Not supported feature:
>>    - XNACK on GPU page fault mode
>>    - migration and prefetch feature
>>    - Multi GPU support
>>
>>    XNACK on enablement is ongoing.The GPUs that support XNACK on
>>    are currently only accessible to us via remote lab machines, which slows
>>    down progress.
>>
>> Patch overview:
>>
>>    01/12 UAPI definitions: DRM_AMDGPU_GEM_SVM ioctl, SVM flags,
>>          SET_ATTR/GET_ATTR operations, attribute types, and related
>>          structs in amdgpu_drm.h.
>>
>>    02/12 Core data structures: amdgpu_svm wrapping drm_gpusvm with
>>          refcount, attr_tree, workqueues, locks, and
>>          callbacks (begin/end_restore, flush_tlb).
>>
>>    03/12 Attribute data structures: amdgpu_svm_attrs, attr_range
>>          (interval tree node), attr_tree, access enum, flag masks,
>>          and change trigger enum.
>>
>>    04/12 Attribute tree operations: interval tree lookup, insert,
>>          remove, and tree create/destroy lifecycle.
>>
>>    05/12 Attribute set: validate UAPI attributes, apply to internal
>>          attrs, handle hole/existing range with head/tail splitting,
>>          compute change triggers, and -EAGAIN retry loop.
>>          Implements attr_clear_pages for unmap cleanup and attr_get.
>>
>>    06/12 Range data structures: amdgpu_svm_range extending
>>          drm_gpusvm_range with gpu_mapped state, pending ops,
>>          pte_flags cache, and GC/restore queue linkage.
>>
>>    07/12 PTE flags and GPU mapping: simple gpu pte function,
>>          GPU page table update with DMA address, range mapping loop:
>>          find_or_insert -> get_pages -> validate -> update PTE,
>>          and attribute change driven mapping function.
>>
>>    08/12 Notifier and invalidation: synchronous GPU PTE clear in
>>          notifier context, range removal and overlap cleanup,
>>          rebuild after destroy logic, and MMU event dispatcher
>>
>>    09/12 Workers: KFD queue quiesce/resume via kgd2kfd APIs, GC
>>          worker for unmap processing and rebuild, ordered restore
>>          worker for mapping evicted ranges, and flush/sync
>>          helpers.
>>
>>    10/12 Initialization and fini: kmem_cache for range/attr,
>>          drm_gpusvm_init with chunk sizes, XNACK detection, TLB
>>          flush helper, and amdgpu_svm init/close/fini lifecycle.
>>
>>    11/12 IOCTL and fault handler: PASID based SVM lookup with kref
>>          protection, amdgpu_gem_svm_ioctl dispatcher, and
>>          amdgpu_svm_handle_fault for GPU page fault recovery.
>>
>>    12/12 Build integration: Kconfig option (CONFIG_DRM_AMDGPU_SVM),
>>          Makefile rules, ioctl table registration, and amdgpu_vm
>>          hooks (init in make_compute, close/fini, fault dispatch).
>>
>> Test result:
>>    on gfx1100(W7900) and gfx943(MI300x)
>>    kfd test: 95%+ passed, same failed cases with offical relase
>>    rocr test: all passed
>>    hip catch test: 20 cases failed in all 5366 cases, +13 failures vs offical relase
>>
>> During implementation we identified several challenges / design questions:
>>
>> 1. No range splitting on partial unmap
>>
>>    drm_gpusvm explicitly does not support range splitting in drm_gpusvm.c:122.
>>    Partial munmap needs to destroy the entire range including the valid interval.
>>    GPU fault driven hardware can handle this design by extra gpu fault handle,
>>    but AMDGPU needs to support XNACK off hardware, this design requires driver
>>    rebuild the valid part in the removed entire range. Whichs bring a very heavy
>>    restore work in work queue/GC worker: unmap/destroy -> rebuild(insert and map)
>>    this restore work even heavier than kfd_svm. In previous driver work queue
>>    only needs to restore or unmap, but in drm_gpusvm driver needs to unmap and restore.
>>    which brings about more complex logic, heavier worker queue workload, and
>>    synchronization issues.
>>
>> 2. Fault driven vs ioctl driven mapping
>>
>>    drm_gpusvm is designed around GPU page fault handlers. The primary entry
>>    point drm_gpusvm_range_find_or_insert() takes a fault_addr.
>>    AMDGPU needs to support IOCTL driven mapping cause No XNACK hardware that
>>    GPU cannot fault at all
>>
>>    The ioctl path cannot hold mmap_read_lock across the entire operation
>>    because drm_gpusvm_range_find_or_insert() acquires/releases it
>>    internally. This creates race windows with MMU notifiers / workers.
>>
>> 3. Multi GPU support
>>
>> drm_gpusvm binds one drm_device to one instance. In multi GPU systems,
>> each GPU gets an independent instance with its own range tree, MMU
>> notifiers, notifier_lock, and DMA mappings.
>>
>> This may brings huge overhead:
>>      - N x MMU notifier registrations for the same address range
>>      - N x hmm_range_fault() calls for the same page (KFD: 1x)
>>      - N x DMA mapping memory
>>      - N x invalidation + restore worker scheduling per CPU unmap event
>>      - N x GPU page table flush / TLB invalidation
>>      - Increased mmap_lock hold time, N callbacks serialize under it
>>
>> compatibility issues:
>>      - Quiesce/resume scope mismatch: to integrate with KFD compute
>>        queues, the driver reuses kgd2kfd_quiesce_mm()/resume_mm()
>>        which have process level semantics. Under the per GPU
>>        drm_gpusvm model, maybe there are some issues on sync. To properly
>>        integrate with KFD under the per SVM model, a compatibility or
>>        new per VM level queue control APIs maybe need to introduced.
>>
>> Migration challenges:
>>
>>    - No global migration decision logic: each per GPU SVM
>>      instance maintains its own attribute tree independently. This
>>      allows conflicting settings (e.g., GPU0's SVM sets
>>      PREFERRED_LOC=GPU0 while GPU1's SVM sets PREFERRED_LOC=GPU1
>>      for the same address range) with no detection or resolution.
>>      A global attribute coordinator or a shared manager is needed to
>>      provide a unified global view for migration decisions
>>
>>    - migrate_vma_setup broadcast: one GPU's migration triggers MMU
>>      notifier callbacks in ALL N-1 other drm_gpusvm instances,
>>      causing N-1 unnecessary restore workers to be scheduled. And
>>      creates races between the initiating migration and the other
>>      instance's restore attempts.
>>
>>    - No cross instance migration serialization: each per GPU
>>      drm_gpusvm instance has independent locking, so two GPUs'
>>      "decide -> migrate -> remap" sequences can interleave. While
>>      the kernel page lock prevents truly simultaneous migration of
>>      the same physical page, the losing side's retry (evict from
>>      other GPU's VRAM -> migrate back) triggers broadcast notifier
>>      invalidations and restore workers, compounding the ping pong
>>      problem above.
>>
>>    - No VRAM to VRAM migration: drm_pagemap_migrate_to_devmem()
>>      hardcodes MIGRATE_VMA_SELECT_SYSTEM (drm_pagemap.c:328), meaning
>>      it only selects system memory pages for migration.
>>
>>    - CPU fault reverse migration race: CPU page fault triggers
>>      migrate_to_ram while GPU instances are concurrently operating.
>>      Per GPU notifier_lock does not protect cross GPU operations.
>>
>> We believe a strong, well designed solution at the framework level is
>> needed to properly address these problems, and we look forward to
>> discussion and suggestions.
>>
>> Honglei Huang (12):
>>    drm/amdgpu: add SVM UAPI definitions
>>    drm/amdgpu: add SVM data structures and header
>>    drm/amdgpu: add SVM attribute data structures
>>    drm/amdgpu: implement SVM attribute tree operations
>>    drm/amdgpu: implement SVM attribute set
>>    drm/amdgpu: add SVM range data structures
>>    drm/amdgpu: implement SVM range PTE flags and GPU mapping
>>    drm/amdgpu: implement SVM range notifier and invalidation
>>    drm/amdgpu: implement SVM range workers
>>    drm/amdgpu: implement SVM core initialization and fini
>>    drm/amdgpu: implement SVM ioctl and fault handler
>>    drm/amdgpu: wire up SVM build system and fault handler
>>
>>   drivers/gpu/drm/amd/amdgpu/Kconfig            |   11 +
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   13 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  430 ++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |  147 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |  894 ++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  |  110 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 1196 +++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   76 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   40 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |    4 +
>>   include/uapi/drm/amdgpu_drm.h                 |   39 +
>>   12 files changed, 2958 insertions(+), 4 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>>
>>
>> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> 

