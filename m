Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B78CC43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C26410E2F1;
	Wed,  1 Jul 2026 03:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zQ4bdufE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E4D110E2D3;
 Wed,  1 Jul 2026 03:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3DXw5MlM2P0Ye3sTCo2DarSN85XCon6s5kQ/n5AXfbZV0J5O48yYykMKzxt9hQM3xh3OKfL/7TN9jP3LBn/elt3YC3ggqcj9jund7N5cpgBBwbDH/k8o8IGBmzopZSkLsKInG9atE47OidOUzTZt/PgsGHqf8C2x2/e3+7mgJZI0g9YxYzPEQZv3/b/Hp7sz76EJM2JO6Sx4L8uDODxggAGpKS4SGy7avksxY1nsXcbjzfV74fz0t0MiR7XOAiXVyhklM1/c+NnhbGGUKYoVDXAuO3IuPnoVfdhDc2fqAs7NJdj7sP7GT6fninLKdGeFyvOXPK7s15bLGvrk68hyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axZduVim8E8rJxyyRDfcgfeZhhPB/piZN35Rc8q6ILM=;
 b=AaDU0QTOOzrt3b/muytlMcnmnmpRSyr9IfX7dkHRjMN9gn5/GGk4zey3j9Y6c9vh0CKh/1BeiI4lWh/ldzJMnkLtLftryeFwFy282chdc0BXOf7EAceWxEW5XVbh8m0CPH33NxNcDktHXgNCQSqIc9vKbk4644ckx/KA5/MJ9INRcuHwjL7fWgV58LcOrmfJ5vr8LIM5rJnSBWfwypk1FVGTTervC3jtkabSFgZdoluGglZeJ5WxNBd/ZeQmHd0TWfi7tbAM7IPEO8nACdlPqS7qOzp9Ltaz6GmcPztRm6bb11W70DQKY/10jjD1aRSDiORAVhn2hl5LYNne8bAcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axZduVim8E8rJxyyRDfcgfeZhhPB/piZN35Rc8q6ILM=;
 b=zQ4bdufErlqMZwPUoHAHPwHKSNDckIpgSpItI8XDB2I8Rbvg1afyssUtmA1EfCA/9DF+U9OG9ofKY78QQx9z13U7wg9dSaGCR9hrBFx+zxxscgNGXjY93vyU3VBFmA542cJzrxTO4Wa/0JtrTVmEoqztvhabRO1ga6zdJHdCxSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:35:05 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:35:05 +0000
Message-ID: <4c0d3658-9480-43b9-9c33-667238697d1a@amd.com>
Date: Wed, 1 Jul 2026 11:34:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, intel-xe@lists.freedesktop.org, aliceryhl@google.com,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Christian.Koenig@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260630102127.392396-1-honghuan@amd.com>
 <akPSENdX3vz8PvdY@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <akPSENdX3vz8PvdY@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 948157c8-7106-45dd-05f3-08ded721bdea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22122799003|18002099003|22082099003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 63ZogdQAYGa1iopOY52oKN3OwhPeH3qBKtPooGj/8kSf+qH3A4orbarh5rulv2k81Iidhb/CKHRDe/L+yudERx6bgnKREOC1NdYVCAfIoNEXdnwRHkbUhuorZjxz15zeVBPN7r//Sst4YiS7vMw8XG2qHsBhETiIvvgim9OEpDj2XBOWLD15bsOB45DKyggohw311oo3M62zaBTT2MWAvzDyIXeDh2w2fFKhvSz9nm4/sjvQ2XUH/d0H5+kYFJWV6x4P9fgzqkegdPbiKJg+D7wqyfnYqJ3CIkdth3Q/a5VtlP5hUHj9Gt8zgkBZa7hSVfKVaJvRMeF+Ft9zJDpwfThe+ur+wIpcbvLbRHTlZkvLBALbiyF4eMCPA3wUCQXvLIyCVdbjQbM19hf6d6tSjtENszjpUimapiY/i2OfZQCWAI5TfEOQ5jVQuZcozRFnVthRa5+WzXIY0VX7NYQyUc79pzJwtT3uAZULvbS7Kb30ydu0attwI81ej2RewjCzJo0hFUoHFizZoIUuzLFPF/wxzWh7pACYkyhDadq7gFjsnPZdxz8k+klhuXC7v5etzj83C3LqIi6hnA1PfXC2AQV6/0F3weQ96AKzTonyee5yqIb5aBIJHck34xfy2Dc+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22122799003)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVLcjlvUnJ5Nk9jSlFjNVN6MWVoRXFTOGRpMjJDMkQ4dktndHJQeENSRkZs?=
 =?utf-8?B?TWcrWTVJMGYxQ0dhbnBkSzArTDUyQnRydWdvU1Z6Mkl1QjZBem83ckxkOGEw?=
 =?utf-8?B?UCtwWERvc3FMZy80V3dkYjRvQlVxcVlCZGNZODZkcnZIWnhUVUFyb25IbWRU?=
 =?utf-8?B?b2kwdDlobnVZZVNENk1ueFdvTlpNOE54dnBvZ3hoaWhMRGZRV2hkOVFQM2NM?=
 =?utf-8?B?K28zOExZYVhWUTZhRDBzcnQ3VkJOMTJUSGZLYmxTR3M4Nm1iYjUram5Xako2?=
 =?utf-8?B?T2FqUmRyWG8rOXRpamhJNm5QNlBiUDhvNFhPSGx3TUFsTkZjQVBod3J2YWcw?=
 =?utf-8?B?S2Q4QnpqZHdHaVJzUlh6QjB2di9CaXlua3pnc2pHb0NDaEd2eUlwQVFEMGZ0?=
 =?utf-8?B?TjRVa1dhdmZndk16bUVGTklNemE0WitvL0VUNjVQY1hhMjl3TlN3NmVxbUIw?=
 =?utf-8?B?L2licC8yWGpjb1orTjlLWGdxK2pzUlZockhNZjNodUVRR0hNRDBIK1VHUWk2?=
 =?utf-8?B?M3c1eHlBcy9kUVpDMmt5bThOMUFhQVFodGVCMGZ4WEw5WFdvYlgvMitRdllN?=
 =?utf-8?B?MVZZbmhIK1gvMEgxLzg4VnhkcjRDa3ZIWXB0aWNzZVRObTlsWG5neVYzZ1Mw?=
 =?utf-8?B?TWF3SnBweFc4cTRFTW16cm1Da1NxZkxPNnBhRDFIbitoaE1DSTFyNXUvYTdW?=
 =?utf-8?B?VHF4U0d3OUg5M0VXNnJEQ09Wc1A3RGJ5QU50QWNsMkt4UnNhWEVvOU82RCtO?=
 =?utf-8?B?ZXhNNFVYSzVtRUFVUXN4SVBMdVlCK0sxZ2RVa3dUNjdJVHVIR2R2Z1BqUXBi?=
 =?utf-8?B?U3JrVVVadzRzNnM0dkx4WUF6N3JVTHl0dGkvb3JzakgrR1ZxQUgvRU9KVnkv?=
 =?utf-8?B?dmh3MU9OR3J3bUw4cWZ3VWYxb2p6Y0kvMGlZcTJ3VDNkUm5TdUlFWW40NHUr?=
 =?utf-8?B?Wlk2aDdPVzRjV3hFNWxzUk9sWGVJajVSY01vSllnVEZycGdORDYwL0pjU0JH?=
 =?utf-8?B?alZubzhxWUxTM2t3TzhyNFRpazZZcGJtYTU4aXJQV0JxYUlHcXZrb05uTm93?=
 =?utf-8?B?QUg1OS9wbDFPMjZDbzUyaHl0WVRNVXpuNlpTVzVTUXpHUXIwM29rb1k1aWFB?=
 =?utf-8?B?clNESG56VW9XVzZtZzV3aGVFKzBIVHdJQWRiZU43RGVqWkJwS0lFcVVmaHM2?=
 =?utf-8?B?UUVEU1pPeXB3UkxNU0plZzd1VFp1WEtJNE9hUS80ekVQM2t4Vkx0QVQyREJk?=
 =?utf-8?B?Qno5M0pPSVJnbzByVXIvQ0F2WkQ2djMwTjFwYnVITENMQ2ZpYURRZWJuNEVj?=
 =?utf-8?B?WTU0SnR3ZWZUNG0vZ0lPR2VXOUlOdVVIajJRdnJ5WVN2ZkdvSm12Z0lkaWRv?=
 =?utf-8?B?NllXMUtsZFlSbkZGMXhrQW8xcUo4TVNuUGVtemZRNXZqRzQ5Q2VQZ3lLVmhy?=
 =?utf-8?B?WndDaG9memQ2TG9uZEw2WDdtNFJ5QVh2ZXZja2VidUVpcm5UM3B1Q3l6UFVC?=
 =?utf-8?B?S2xXd04vUDM4TStpNWo0aHVDYnZVcTBKaW8zNUpHUWYwamtXQVNEWmUxTldu?=
 =?utf-8?B?TFhBaE5Oc1dlcWpIL1AzKytJTDZqWDgrMjFaK2NuY01RaTdqNXFYeHpjRkl3?=
 =?utf-8?B?SDNhNFpXck9XS1k0MW9QMUtiMTAzdEFtYjJJL1F1SHpWa3RMZmx6Zytrdldq?=
 =?utf-8?B?WEQxM0NjQ3d1RW9xNlFQb2dqa1FOTDQ2VDNnc0ZXcVdkRU9tRHhMTG1zdHp2?=
 =?utf-8?B?TFFzNzMxRys2ZlMrZjZteDlxNjJoOXJod09vSGJEdlVNWHJTVjVDc0xJaHBy?=
 =?utf-8?B?YW15bXIrcEVUUjdUZklJVmd2c0JSOXRZRlViQkFRQmNUUndib2VMaEJzbnBh?=
 =?utf-8?B?TzZOUzZra2hma1doMTNEaldTWnR6dldnTldXNE5OZTlVTDBrbnI3YUEwYlUw?=
 =?utf-8?B?ZitMRHFEbDVqUVAzOVFwVlZLMnkwQXNnS1U5SXl4KzFYdmIyZkNxYTcyNzdT?=
 =?utf-8?B?K1dnZkhLSjdEWE5KWVlzdmU4d3pQTndKZFUxR3RHQzh4N2hLMEUzWW9SOUJI?=
 =?utf-8?B?MEZFRUJJQkI1UnlDRVprQStlVWlVdkFtNFdGUFl5VUZQKzNhT1R6VkE0YkY1?=
 =?utf-8?B?VlNkUjFnUmY2VFVjOUJZSnJSZTFwUUE0eGZydVEvZlNqWm5XVVIyVkNPaTVS?=
 =?utf-8?B?M1dVdFVjanVSUDE3d0hkK2VGeWFkQm4yWHJ1aEZXY05QeVhNbFBTeFQyM29y?=
 =?utf-8?B?TGIzRU9DUGUyMmIxVkVlckdTb09Fa0FuWTdpbXlKYnhUdEw5SE5vSXRuUng5?=
 =?utf-8?Q?kTQ4FvwEeP8ap97yKK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948157c8-7106-45dd-05f3-08ded721bdea
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:35:05.5463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LItLr3f4sR2GFrg4Te5ZTeDUTzJd36e1hcDdkwVXTnJuT+0k2RSCJcKzzLzHigNnB6+uwCs9eZ8b+qCzx8OiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
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



On 6/30/2026 10:26 PM, Matthew Brost wrote:
> On Tue, Jun 30, 2026 at 06:21:22PM +0800, Honglei Huang wrote:
>> The intent of this series is to make drm_gpusvm more flexible and give
>> drivers more freedom over how they assemble the MM related and device
>> side operations. It implements the direction Matt suggested in [1]:
>> Mirror MR in gitlab: [4]
>>
>>    - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
>>    - Embed a struct drm_device in struct drm_gpusvm_pages and drive all
>>      DMA through it.
>>    - Drop struct drm_device from struct drm_gpusvm.
>>    - Have the driver's range structure embed one or more struct
>>      drm_gpusvm_pages in addition to struct drm_gpusvm_range.
>>    - Drop the range-based helpers (drm_gpusvm_range_pages_valid,
>>      drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages) and update
>>      drivers to use the drm_gpusvm_pages helpers instead.
>>
>> In essence the series does only two abstractions, plus the xe
>> adaptation that follows from them:
>>
>>    - range vs pages: split drm_gpusvm_range (MM / VA range state) from
>>      drm_gpusvm_pages (device physical related), so the two sides can
>>      have independent lifetimes and ownership.
>>    - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
>>      the device side down onto drm_gpusvm_pages, which is where DMA
>>      actually happens.
>>    - xe is updated to fit the modifications, no functional change
>>      intended.
>>
>> V10:
>>    Fix two issues found by the AI review:
>>    - patch 1: fix a KCSAN data race in xe_svm_alloc_vram(): read
>>      range->base.flags.__flags with READ_ONCE() and assert on a local
>>      copy, pairing with the WRITE_ONCE() in
>>      drm_gpusvm_range_set_unmapped().
>>    - patch 3: remove the DMA unmap in xe_svm_fini(): since
>>      drm_gpusvm_range_remove() no longer unmaps synchronously, explicitly
>>      drm_gpusvm_unmap_pages() all remaining ranges before
>>      drm_gpusvm_fini().
>>
>> V9:
>>    - patch 3: fix the build with CONFIG_DRM_XE_GPUSVM disabled: move
>>      pages out of the nested base struct in the stub xe_svm_range and
>>      route has_dma_mapping through range->pages. No functional change.
>>
>> V8:
>>    - patch 4: add reviewed-by for Matt's review.
>>
>> V7:
>>    - patch 1: split MM state flags: the AI review found a KCSAN / memory
>>      model cleanliness issue. Address it for consistency with
>>      drm_gpusvm_pages_flags, set the range flags with WRITE_ONCE() on
>>      __flags and read them with READ_ONCE().
>>
>> V6:
>>    - The AI review flagged a potential DMA free issue: the DMA unmap
>>      step was moved into the range_free callback, but on the invalidate
>>      path a range can be removed from the MMU interval tree while its DMA
>>      mappings are still live, so a concurrent unmap event can miss it.
>>    - patch 3: have xe_svm_range embed one drm_gpusvm_pages: explicitly
>>      call drm_gpusvm_unmap_pages() before drm_gpusvm_range_remove() in the
>>      garbage collector, so a range is never off the tree while still DMA
>>      mapped, and document this caller contract in drm_gpusvm_range_remove()
>>      kernel-doc.
>>    - patch 4: move struct drm_gpusvm_pages out: document the
>>      unmap before remove contract in the garbage collector example and
>>      note that range_free()'s drm_gpusvm_free_pages() as a final fallback.
>>    - patch 1: split MM state flags: return -EACCES directly.
>>    - Fold in the pre existing IOVA/DMA unmap fixes the AI review found
>>      previously sent separately: the uninitialized dma_addr[0].dir on
>>      the get_pages() error path, the whole reservation IOVA free for
>>      mixed ranges, and the device mapping leak on the get_pages() error
>>      path. [6]
>>
>> V5:
>>    - add reviewed-by in patches 1, 2, 3, 5 for Matt's review.
>>
>> V4:
>>    - drm_gpusvm_init_pages(): memset() the pages to zero before recording
>>      the owning drm_device.
>>    - DOC: overview: recommend a zeroing allocator: kcalloc() for the
>>      N:1 pages array.
>>    - Rebased onto the latest drm-xe.
>>    - The AI review of this series flagged two preexisting issues in the
>>      IOVA unmap path that are not introduced by this series; they are
>>      fixed in a separate series [5].
>>
>> V3:
>>    - Fix a kernel-doc/Sphinx warning from the kernel test robot: use
>>      ".. code-block:: c" for the drm_gpusvm_pages example in DOC: overview.
>>    - drm_gpusvm_range_set_unmapped(): use WRITE_ONCE() on the whole
>>      pages[i].flags.__flags word to pair with the lockless READ_ONCE()
>>      readers and avoid a data race.
>>    - xe_userptr_setup(): call drm_gpusvm_init_pages() before
>>      mmu_interval_notifier_insert() to avoid exposing uninitialized
>>      pages.drm to invalidation callbacks.
>>    - Fix per commit build of the set_unmapped() pages.
>>
>> V2:
>>    - Followed in Matt's v0 review fixups [2]:
>>       - keep unmapped flag in pages structures.
>>       - add pages_count to drm_gpusvm_range_set_unmapped() to set the pages
>>         unmapped flag, so the framework can check unmapped status in
>>         drm_gpusvm_get_pages().
>>    - Add drm_gpusvm_init_pages to init the drm_device and sequence number.
>>    - Remove drm_device from drm_gpusvm_get_pages() parameters.
>>    - Reworked the DOC: overview and usage examples to describe the new
>>      model: struct drm_gpusvm_pages, the 1:1 / N:1 driver layouts, and
>>      examples that operate on a driver embedded pages object by the
>>      drm_gpusvm_pages helpers and etc.
>>    - remove WARN_ON_ONCE in __drm_gpusvm_unmap_pages.
>>    - Dropped RFC.
>>
>> Follow-up (not in this series):
>>
>>    - modify drm_gpusvm_get_pages() to support one time hmm range fault
>>      and multi drm device dma mapping.
>>    - Add no dma device support for drm_gpusvm_get_pages().
>>
>> tests:
>> AMDGPU:
>>    based on amdgpu adaptation patch in [3], but still SVM:DRM = 1:1,
>>    1:n is on going needs many modifications and testings.
>>
>>    Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
>>    - KFD test: 95%+ passed.
>>    - ROCR test: all passed.
>>    - HIP catch test: gfx943 (MI300X): 99% passed.
>>                      gfx906 (MI60): 99% passed.
>> INTEL XE:
>>    CI tests passed in rev5 tests.[7]
> 
> 
> CI full is in flight, but it seems likely to pass. Once it completes, we
> can merge this; we just need to decide which branch to use.
> 
> The series does not apply cleanly to drm-misc-next because it depends on
> changes in drm-xe-next that have not yet been merged into drm-misc-next.
> It does apply cleanly to drm-xe-next, though.
> 
> If we merge the patches in drm-xe-next and pick them up via a rebase in
> the AMD trees, that works. Alternatively, we can ask the drm-misc-next
> maintainers to rebase and apply them there. Either option works for me.
> 

Thanks a lot, Matt, for the guidance and the reviews in this series.

For the merge, happy to rebase onto whatever base/tag decided, just
let me know.

And will work on the follow up works.

Regards,
Honglei

> Matt
> 
>>
>> links:
>> [1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
>> [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
>> [3] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
>> [4] https://gitlab.freedesktop.org/drm/xe/kernel/-/merge_requests/360
>> [5] https://lore.kernel.org/all/20260627033325.3795298-1-honglei1.huang@amd.com/
>> [6] https://lore.kernel.org/all/20260628061757.4093701-1-honglei1.huang@amd.com/
>> [7] https://patchwork.freedesktop.org/series/169384/#rev5
>>
>> Honglei Huang (5):
>>    drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
>>    drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
>>    drm/xe: have xe_svm_range embed one drm_gpusvm_pages
>>    drm/gpusvm: move struct drm_gpusvm_pages out of struct
>>      drm_gpusvm_range
>>    drm/gpusvm: let the drm_gpusvm core context purely MM level
>>
>>   drivers/gpu/drm/drm_gpusvm.c    | 243 +++++++++++++++++++-------------
>>   drivers/gpu/drm/xe/xe_pt.c      |   2 +-
>>   drivers/gpu/drm/xe/xe_svm.c     |  66 +++++++--
>>   drivers/gpu/drm/xe/xe_svm.h     |  14 +-
>>   drivers/gpu/drm/xe/xe_userptr.c |   5 +-
>>   include/drm/drm_gpusvm.h        |  67 ++++++---
>>   6 files changed, 255 insertions(+), 142 deletions(-)
>>
>> -- 
>> 2.34.1
>>

