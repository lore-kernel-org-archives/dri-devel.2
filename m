Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A5EC44503
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0940D10F390;
	Thu,  9 Jul 2026 06:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q/iYgCPG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FBB710F390;
 Thu,  9 Jul 2026 06:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loSGyJnuhFaZC0YbvP3vSo5JDoXU+2YgbnRVoJsXHSAhpome1lChgGth2Agh0ImkUy69lfs1dAhrc5jYJz+N5WAPPgSVFTrvSPjTrJYWHQsW0LlOkptP2atTDNbNasg3uO7YC+ucRcMkB73Yy2BCakOlCuc2SvSbSorivA1QJTMwpvdg95huJxDhCCNo2VfFnRhr466y63IP5zme/l01VJud/QcDBxSllBtFtQCaZSz5kIaxtJRYapn8CvhtV0ZUcmRrHo1naHqYaJ3/329cvGR+84XTWdwjOnjBVXadkWLj1lYiKPzsFs/9KFaLlLIDEkq2/o4mUcZ7NpBh2eBP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZFTqoDnWem0TlMhgT5CRE6md3vYHjQQgJzuJ2/ZNus=;
 b=OS2ruJ706cdPSkHQIbBcNugl4xDcQhJOFTkVjZ82TjEbRhPNoO2gICOeZnqqz5vDj7nWIepYRKJ8Hco5nAJR88X322vA3NTvk6zXeQWsCDoU6Enho8pBoUU7ZYzv80MkUGyVCCnJOZqN8OAiPfvugVIi83ysAWsK9CERDtX/ZD58pEZGym5ewd9zQ2fuPvowr9i9jsWuBOhAj2yOnxtG8FBe4LxK3pgqC/9cD9kEAi9xLQ+/y4r33hXYJSln2/21syzUeY0IQkssZ4kiQVtG46rLS1BVdXUx/2vWafw74CVG2jew7sh7qHEjTMCN2DzM26guw+p169nsQDbfYCT2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZFTqoDnWem0TlMhgT5CRE6md3vYHjQQgJzuJ2/ZNus=;
 b=q/iYgCPGW4QB/NRkO1YXyX0DjuFN79wLRYF2gZuciYeqx9PFjYkjjYA8OG1ll1YvbBQcyH22hgK2cCPPO32xMVF0wRaXIajj+9Eko+s7apLiWZoeD6VTEs0jL0hYgatubADKpqd0BHnd1t5+xoVdNgGjFEtD+r1/3aD+H5sPfUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:26:54 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 06:26:54 +0000
Message-ID: <9b973aa0-fa6d-4047-9f4c-52d2ae50924d@amd.com>
Date: Thu, 9 Jul 2026 14:26:46 +0800
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
 <4c0d3658-9480-43b9-9c33-667238697d1a@amd.com>
 <ak7VlleUwy65QLtg@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <ak7VlleUwy65QLtg@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::17) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb81a1c-fe62-435c-922d-08dedd831156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|22122799003|1800799024|18002099003|22082099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: +DiG108kMO5/VwA3tGMBTi2QUWFGWcHImg3ue4hfuGb86TtPaNSzYFitci8EHzXESGOHbU1cIKqG88EN+XcFP5sPmONH3EUx41YuTVg68KbTpN5kMGZnvJ0VLDvSEAzl4iKTt1bckPFcRqkiVYDyX1KJgHQedY0D8CelYNxUvxLoTSGxdk5PF8TwZy0QmH9QvyrPyXwAmWRfjsA4Zz59f2EvORhALrpG0/cwmD970e26d+RVr2RFAuhzkbn0phxvuLNM7kOz656Ug68FKmH8u5A6c64pVOt+G2QRV1yOFw2pjKbsV9ll52+REsY5UfeAJMfqpvLsir97p4PA2i22QY5Ktf4u22x1DYC6DIIFqiOh6Msb/JXTJoNKBeA9WNcMwwWn3h/SV7jFKhLf/ziTwV61E81fQ+g49Y1jMmYyxFatuRNEhk15tTwFAjq98oavki11RSmoNPnoZ9DfKGuSXQWaI3ovKDj0kK+YHKT2DFLjf8XRAKT6+fLIWjMAaVPIXMc5SPwG2/qYIZXM/InoD1uocyfRmf4aa1R60U3FtSyL/hddLIJF+xKwSv20DWdw5FrP7nWldWz22jFr1v79jKnbKwDxWNJoLxHy0Dp9IRjtTZJNptOloubc54gAcFM/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(22122799003)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1nNUt4R2luNnBUQVRYWEFDa1BuaGFma0NneG9CaGpFdTk2bWxJWDFxT1VB?=
 =?utf-8?B?eEpPeFMrempxVW5yM242OE5YL3NiWFRGQkFneERncHBHRWJ2N2U1cmZZSGhC?=
 =?utf-8?B?VmhyV1p4NWpRZkZzK1ZabTZZSzB3Z2xpcWNnMzJDMkNTcnF0R2lLeUdma1My?=
 =?utf-8?B?aEJDdWxGNW45cW5xUjhpdTQwSGw0RXhoQVpOSW9NL0xyREMzZUlBNWZiN0kw?=
 =?utf-8?B?MzFkMjJDd0MwdWNzTVNDcVdvRUhrMVQvTnZTUmR5OXdOdUZ5WmsydThmUUda?=
 =?utf-8?B?bnRKd09rWHhKcE02QUMwRVErdTFZTmlZQ1ZpSTBYeU1FQmZ6bDZrY1h4N2Ux?=
 =?utf-8?B?Y2VyZ044T3FJbHpUQmhBbFdvQkpJOEdVY01kbzQ1M3ZLcWZNQ2dFdC9yczVT?=
 =?utf-8?B?Wko4dEVrRkQ2QUhoaTlML1ZQRk0xai9VcFYwMkNIQndFM0RGb1J0R3FSaE0r?=
 =?utf-8?B?ZGxzcDcrakhkOGZZdnk2TkxwekNja0lIN0lVMXFpMmoyZjJ6ci9WRWhCLzJk?=
 =?utf-8?B?Y2gxUnhPSEVqVjFSMnVYVkM3Q3VnZlRNK2doNzBZcGNSK25LdVpYeVNPZFpP?=
 =?utf-8?B?alJwVVJCR1owSnhMcEFycUREY3puY21TUmh6WUZJQWRLempJSkRHK2g3MHRl?=
 =?utf-8?B?Nk9vK0I5ZkErb3M2bWlEV2J6UFg0MzkyTnM5dzZmTmJsajZFZzFma2kwdkEz?=
 =?utf-8?B?dHAxRzJLSWRYd294bXhKWkduNkNCY3pld3I0aHZlTE9vOGpieE43Z0JUK0Ny?=
 =?utf-8?B?OTJtRSt1ejVBSkk5Z1QrR2EwNEF2UEVDUmN6NVRKZ0ZXZ1JUU2NUdmxHU09C?=
 =?utf-8?B?bUFGREl5ZWtYT3lKUG5BME5qNGUzT3hJMVUzdU9oS2cyN1JsNE15S1BzdUpt?=
 =?utf-8?B?UTRQZXdERVh0bEJLNWMwcjJxZ1dtcDQrYVNkUGkvRHhJUldkYVowWlhqQ2lv?=
 =?utf-8?B?bHd3ZTVUbjd2TFdPVUlnZ1R0S3RLNzVSN3lGOFZEcTltbEdabkRTMEJmaUR6?=
 =?utf-8?B?ZmlHM2RzME5URHhsUkxCMmpMdVgvM0tjT29hRk52M0dKcjdWeTdESUdMenY3?=
 =?utf-8?B?Mk1zQzdCUVlxSmRqMlZaRTRNWmhlRU1vaFFJalVTM2NPZkhWOXFydG9sRWVh?=
 =?utf-8?B?elMrUG4rU0F3Z0Q2V3VjMFk0SThiSGtoRWo1Z1pnL051RFdBVzZrNjcvOTNV?=
 =?utf-8?B?TGp0VVhOQmlYcFFpenVzTitWSm9TNnAyWFJZQ21qOThqcDV0MXB3QXlUR0R3?=
 =?utf-8?B?a2xPT1JBdlRUQlVCTjNQZlNXODRMR2lFVTlRaUFVWGlkcThndk5seDZsRmJN?=
 =?utf-8?B?RUpacFh6bEhjMHdUVXV4T1ZoY29YZS9nd3FXUU52RjVDRlRrZEh4eUxUUzV3?=
 =?utf-8?B?bzdZajZlOFVnZXM2TUFYMklXOGpkWGRwb0c5Uk1uM0dVQ1pjOUJrWE00RVNF?=
 =?utf-8?B?RTBvWncxUXpkZ3pJbm9CdHI0ZG1naFFJK3VNV1huWmNqcnhleUZLbExacmlj?=
 =?utf-8?B?cGU5YVhHWVhiL21CTVU5T3o1eDNneDRsbVlNREtpTnhxQ3FyYTBMVjVmcDFZ?=
 =?utf-8?B?UVZZU2FZaXJZeldDWjZ0NVlZUVgzMkMzbTFqcWh2cjZ2Wk0rbkViN1BmSk1S?=
 =?utf-8?B?L1dGaWRFLzVEWGlJNHRDcW1aQmIrdFRNN3R5S2ZtVGdUUVVMaDhVczE4dW41?=
 =?utf-8?B?a1dQb01tQWtmSkRTZnpYS0dqa2ZnK09KcWJBYlVRM1h3TmRSVzE2S1UxRG1L?=
 =?utf-8?B?RjNIc0FPU1E2WlFuTXN0Z2QzYVNrM3Q1aklTZEpsSWp2SzFKUmNZWHN3Z296?=
 =?utf-8?B?QjZVMHFqUnZ6bUZ4RktHTVg4NEVuU2xYdkFWcDFIUHp1Z1RFQ2UySGUrY1hJ?=
 =?utf-8?B?aVlJaktmaTltNGovWEtxVVYrNlptcFE0d0lyUmU0VEg0TlFvVkgzZUQ0WFZT?=
 =?utf-8?B?ZVAzNkRHOUx0cit6T2pVWE1oMUl4TmdjR0FuS0JYNWJNcFFaN3l4bDFHcFBI?=
 =?utf-8?B?VVpZQ3cwSFZqdVdmVUlOeFlGYWdCS1VsSzRiakRRRUl2bGFCVGdNNndmYW1k?=
 =?utf-8?B?MGVTWm9pTS9zS1MyNW1VK2M0aFJ4cE5DbXljcmFyakt2ZGtWSjNSOGFaVFIz?=
 =?utf-8?B?SE9WNURhS1Y5MUxFVG5kaVNTY0FlYzhXN0VZOGdSUzZjN1dkdWZkYXlzckdL?=
 =?utf-8?B?V3BhM3ViQmlXNlY0K2hUVDlEdTdNVkIyd05tVEN0ckp0TTVzS0M0UkZmdmx5?=
 =?utf-8?B?Vy85em40cUlScjVwUTNkVzZUQTVQdlQ0cS9HN3U3anQvVklnU0ppZVNCNTBZ?=
 =?utf-8?B?SDAwZlJSb2pvdkJXcWtVekdJWXRmZDRCQVV1WWg2ZGdkZStTNkc2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb81a1c-fe62-435c-922d-08dedd831156
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:26:54.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sChkB7TuQnBG5xUMdMUreIYVPJfGqJEOPllec9MzMR1pos7CoMFJRpJjCJHxuhgGzKUisjmDtuog2qthH91Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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



On 7/9/2026 6:56 AM, Matthew Brost wrote:
> On Wed, Jul 01, 2026 at 11:34:57AM +0800, Huang, Honglei wrote:
>>
>>
>> On 6/30/2026 10:26 PM, Matthew Brost wrote:
>>> On Tue, Jun 30, 2026 at 06:21:22PM +0800, Honglei Huang wrote:
>>>> The intent of this series is to make drm_gpusvm more flexible and give
>>>> drivers more freedom over how they assemble the MM related and device
>>>> side operations. It implements the direction Matt suggested in [1]:
>>>> Mirror MR in gitlab: [4]
>>>>
>>>>     - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
>>>>     - Embed a struct drm_device in struct drm_gpusvm_pages and drive all
>>>>       DMA through it.
>>>>     - Drop struct drm_device from struct drm_gpusvm.
>>>>     - Have the driver's range structure embed one or more struct
>>>>       drm_gpusvm_pages in addition to struct drm_gpusvm_range.
>>>>     - Drop the range-based helpers (drm_gpusvm_range_pages_valid,
>>>>       drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages) and update
>>>>       drivers to use the drm_gpusvm_pages helpers instead.
>>>>
>>>> In essence the series does only two abstractions, plus the xe
>>>> adaptation that follows from them:
>>>>
>>>>     - range vs pages: split drm_gpusvm_range (MM / VA range state) from
>>>>       drm_gpusvm_pages (device physical related), so the two sides can
>>>>       have independent lifetimes and ownership.
>>>>     - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
>>>>       the device side down onto drm_gpusvm_pages, which is where DMA
>>>>       actually happens.
>>>>     - xe is updated to fit the modifications, no functional change
>>>>       intended.
>>>>
>>>> V10:
>>>>     Fix two issues found by the AI review:
>>>>     - patch 1: fix a KCSAN data race in xe_svm_alloc_vram(): read
>>>>       range->base.flags.__flags with READ_ONCE() and assert on a local
>>>>       copy, pairing with the WRITE_ONCE() in
>>>>       drm_gpusvm_range_set_unmapped().
>>>>     - patch 3: remove the DMA unmap in xe_svm_fini(): since
>>>>       drm_gpusvm_range_remove() no longer unmaps synchronously, explicitly
>>>>       drm_gpusvm_unmap_pages() all remaining ranges before
>>>>       drm_gpusvm_fini().
>>>>
>>>> V9:
>>>>     - patch 3: fix the build with CONFIG_DRM_XE_GPUSVM disabled: move
>>>>       pages out of the nested base struct in the stub xe_svm_range and
>>>>       route has_dma_mapping through range->pages. No functional change.
>>>>
>>>> V8:
>>>>     - patch 4: add reviewed-by for Matt's review.
>>>>
>>>> V7:
>>>>     - patch 1: split MM state flags: the AI review found a KCSAN / memory
>>>>       model cleanliness issue. Address it for consistency with
>>>>       drm_gpusvm_pages_flags, set the range flags with WRITE_ONCE() on
>>>>       __flags and read them with READ_ONCE().
>>>>
>>>> V6:
>>>>     - The AI review flagged a potential DMA free issue: the DMA unmap
>>>>       step was moved into the range_free callback, but on the invalidate
>>>>       path a range can be removed from the MMU interval tree while its DMA
>>>>       mappings are still live, so a concurrent unmap event can miss it.
>>>>     - patch 3: have xe_svm_range embed one drm_gpusvm_pages: explicitly
>>>>       call drm_gpusvm_unmap_pages() before drm_gpusvm_range_remove() in the
>>>>       garbage collector, so a range is never off the tree while still DMA
>>>>       mapped, and document this caller contract in drm_gpusvm_range_remove()
>>>>       kernel-doc.
>>>>     - patch 4: move struct drm_gpusvm_pages out: document the
>>>>       unmap before remove contract in the garbage collector example and
>>>>       note that range_free()'s drm_gpusvm_free_pages() as a final fallback.
>>>>     - patch 1: split MM state flags: return -EACCES directly.
>>>>     - Fold in the pre existing IOVA/DMA unmap fixes the AI review found
>>>>       previously sent separately: the uninitialized dma_addr[0].dir on
>>>>       the get_pages() error path, the whole reservation IOVA free for
>>>>       mixed ranges, and the device mapping leak on the get_pages() error
>>>>       path. [6]
>>>>
>>>> V5:
>>>>     - add reviewed-by in patches 1, 2, 3, 5 for Matt's review.
>>>>
>>>> V4:
>>>>     - drm_gpusvm_init_pages(): memset() the pages to zero before recording
>>>>       the owning drm_device.
>>>>     - DOC: overview: recommend a zeroing allocator: kcalloc() for the
>>>>       N:1 pages array.
>>>>     - Rebased onto the latest drm-xe.
>>>>     - The AI review of this series flagged two preexisting issues in the
>>>>       IOVA unmap path that are not introduced by this series; they are
>>>>       fixed in a separate series [5].
>>>>
>>>> V3:
>>>>     - Fix a kernel-doc/Sphinx warning from the kernel test robot: use
>>>>       ".. code-block:: c" for the drm_gpusvm_pages example in DOC: overview.
>>>>     - drm_gpusvm_range_set_unmapped(): use WRITE_ONCE() on the whole
>>>>       pages[i].flags.__flags word to pair with the lockless READ_ONCE()
>>>>       readers and avoid a data race.
>>>>     - xe_userptr_setup(): call drm_gpusvm_init_pages() before
>>>>       mmu_interval_notifier_insert() to avoid exposing uninitialized
>>>>       pages.drm to invalidation callbacks.
>>>>     - Fix per commit build of the set_unmapped() pages.
>>>>
>>>> V2:
>>>>     - Followed in Matt's v0 review fixups [2]:
>>>>        - keep unmapped flag in pages structures.
>>>>        - add pages_count to drm_gpusvm_range_set_unmapped() to set the pages
>>>>          unmapped flag, so the framework can check unmapped status in
>>>>          drm_gpusvm_get_pages().
>>>>     - Add drm_gpusvm_init_pages to init the drm_device and sequence number.
>>>>     - Remove drm_device from drm_gpusvm_get_pages() parameters.
>>>>     - Reworked the DOC: overview and usage examples to describe the new
>>>>       model: struct drm_gpusvm_pages, the 1:1 / N:1 driver layouts, and
>>>>       examples that operate on a driver embedded pages object by the
>>>>       drm_gpusvm_pages helpers and etc.
>>>>     - remove WARN_ON_ONCE in __drm_gpusvm_unmap_pages.
>>>>     - Dropped RFC.
>>>>
>>>> Follow-up (not in this series):
>>>>
>>>>     - modify drm_gpusvm_get_pages() to support one time hmm range fault
>>>>       and multi drm device dma mapping.
>>>>     - Add no dma device support for drm_gpusvm_get_pages().
>>>>
>>>> tests:
>>>> AMDGPU:
>>>>     based on amdgpu adaptation patch in [3], but still SVM:DRM = 1:1,
>>>>     1:n is on going needs many modifications and testings.
>>>>
>>>>     Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
>>>>     - KFD test: 95%+ passed.
>>>>     - ROCR test: all passed.
>>>>     - HIP catch test: gfx943 (MI300X): 99% passed.
>>>>                       gfx906 (MI60): 99% passed.
>>>> INTEL XE:
>>>>     CI tests passed in rev5 tests.[7]
>>>
>>>
>>> CI full is in flight, but it seems likely to pass. Once it completes, we
>>> can merge this; we just need to decide which branch to use.
>>>
>>> The series does not apply cleanly to drm-misc-next because it depends on
>>> changes in drm-xe-next that have not yet been merged into drm-misc-next.
>>> It does apply cleanly to drm-xe-next, though.
>>>
>>> If we merge the patches in drm-xe-next and pick them up via a rebase in
>>> the AMD trees, that works. Alternatively, we can ask the drm-misc-next
>>> maintainers to rebase and apply them there. Either option works for me.
>>>
>>
>> Thanks a lot, Matt, for the guidance and the reviews in this series.
>>
>> For the merge, happy to rebase onto whatever base/tag decided, just
>> let me know.
>>
>> And will work on the follow up works.
> 
> This now applies to drm-misc-next, so going to apply there by EOD unless
> I hear an objection.
> 

Thanks Matt!

No objection from my side, drm-misc-next works for me. Thanks again
for all the reviews and for handling the merge.

I'll rebase the amdgpu SVM on top of drm-misc-next once this lands.

Regards,

> Matt
> 
>>
>> Regards,
>> Honglei
>>
>>> Matt
>>>
>>>>
>>>> links:
>>>> [1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
>>>> [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
>>>> [3] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
>>>> [4] https://gitlab.freedesktop.org/drm/xe/kernel/-/merge_requests/360
>>>> [5] https://lore.kernel.org/all/20260627033325.3795298-1-honglei1.huang@amd.com/
>>>> [6] https://lore.kernel.org/all/20260628061757.4093701-1-honglei1.huang@amd.com/
>>>> [7] https://patchwork.freedesktop.org/series/169384/#rev5
>>>>
>>>> Honglei Huang (5):
>>>>     drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
>>>>     drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
>>>>     drm/xe: have xe_svm_range embed one drm_gpusvm_pages
>>>>     drm/gpusvm: move struct drm_gpusvm_pages out of struct
>>>>       drm_gpusvm_range
>>>>     drm/gpusvm: let the drm_gpusvm core context purely MM level
>>>>
>>>>    drivers/gpu/drm/drm_gpusvm.c    | 243 +++++++++++++++++++-------------
>>>>    drivers/gpu/drm/xe/xe_pt.c      |   2 +-
>>>>    drivers/gpu/drm/xe/xe_svm.c     |  66 +++++++--
>>>>    drivers/gpu/drm/xe/xe_svm.h     |  14 +-
>>>>    drivers/gpu/drm/xe/xe_userptr.c |   5 +-
>>>>    include/drm/drm_gpusvm.h        |  67 ++++++---
>>>>    6 files changed, 255 insertions(+), 142 deletions(-)
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>

