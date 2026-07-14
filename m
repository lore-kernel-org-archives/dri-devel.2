Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0912C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8500A10E465;
	Tue, 14 Jul 2026 09:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bthuTOKi";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E8D10E03C;
 Tue, 14 Jul 2026 09:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQvEoz0VJFKKdczLBHN8Qn8S4doT6YRFRA4x/lI/LV+y9Z+mPZi2UxKV6rOcsh5dUuqmf39UPJk1ICHyj/tSKCCAAq+5VN+9+ux0hh8Jlnevmhrs468u1p4X7YpvAYGxqt8UIMj+BNnJzUUwi/UjpG6/27WBuMlHc7cgYbKRyW4S7N3f+uCjz/andrI+fpdsgovYZg3WYApWViUipgV3LysU62HKNBKLI3tuOMf22hqfik854FS3lPKm2H3JAYB/DNBcBe2LRZmrMrZMCi0DeOaMG3YSwGw4EnPBXKVwgs/8MnQxjFxMzg7iW46C2PWjjj1rxIWv9LEHzn5l/sNp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Dkb70HSPAlqEkQY7C4P1tkcn1fbgGg3WklioWUfbC4=;
 b=H/kG4oVR+6m2dzoCQKL3xKwRnXWse9FCoZ42BKFE/qlcYQUTwGJN9Ixqe6/FOK319aXlMAXY7Uqz2cCGPNBikgyrDkpYZwGOYggzjqYXlTI02LFI52XYCwYRarcr9fhvOArlBKKxk+/Fhcjk3wVzh9Jq46BoHRUf3X7haL3EV6TiARR7qqUP7dBrr+JCSNuELu45I8m1EN2XbrvcpejTZusN04I6eimlFhUUY9RakwgEBEFmYf9U/ekCVfMFRg4u7tlYtzcaW8ms2+tYKDFzWEnaFXmcDEgj/57Tm+JnTSZzacLoJ/Uoyr9bqxzZpcK2FH8ZhuwHfE4EQPIVyneFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dkb70HSPAlqEkQY7C4P1tkcn1fbgGg3WklioWUfbC4=;
 b=bthuTOKiRAXEtSoSXk6Z6q8SusUealP+6PqvCW+bJx6X8WxszcCORnbHYc//ScuACioByKKcD6c4//yx1WQXolxe08I4H2ol2NYGIYu759/FBvawbtxIm2gAePrODBmgRDDQweZxZqm5inSUAJudRZlxALZpjMDUoTIRkgS5IQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 09:17:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:17:38 +0000
Message-ID: <357a21c0-7181-474f-bb97-c795d9456238@amd.com>
Date: Tue, 14 Jul 2026 11:17:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/33] drm/amdgpu: Preallocate system BO pages outside
 the reservation lock
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-34-matthew.brost@intel.com>
 <13b16ffb-f9aa-4b83-a1cc-1b9ac8475c5f@amd.com>
 <alVJgfBepuNZhAmd@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <alVJgfBepuNZhAmd@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b48ec6-56e9-4b31-113b-08dee188bfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: T7XJiyXESLstRuQ3eeJe+CGlDuPX+vKJ6eY+JshF7NX/5j8b1KytWAzl7MqtMzgshoVNmrNEOFFr/dnwV7QQ1Jfh4EbDk0aovu/JS4phCHkGS9dhSYfRann+P/OjhOvSkgzSjxdVUV72EWYC7E5YDwsIEcQTx+qLqlz7aS9rGmwnSvcaywVzLWHGbjA2GuIW00F9cI78oUVvVAsmvmQ4w709Ljc8QcHJfoJT91bdXTQjNXGUYjacNmA/FwBf3DexG6nGORbBCcswVpXzx3k7A7ZUHVB+4oporH0siWB9Ur7JR8K6CKnHSImChoP29CqQt7aU3M9Y2U5ZFFqRQDce84OLK408NKKUk7oO9uvEjAi+jGvbP3SevPoF02/DBPeXaQNBnSv8tr6zxCirBKdizFtZxeQBcFpQlBzNvwe2jCmeuA3eE+l7E3xqwwEZnQh/NoCFuIGWDD+Mr4a1Bj9EROZS+ViJFGkpxJzNZ2DL7Ox2HqwkrLOq6uMfFn502lbieFD++ZCoSZSHUYNjinsZfBjnUTY1WR3GQz7xNpO23LtIdQeTQFIcqtMLIeLTCwU4qf7+zQMpXvvzRY8N17vFqzFsV4teyZ+WQJVNgc7sV2UxlHnct91hnxijxqhCpFgr3hH/fdHM31vH0dAy+kGIFj/n5LQq0n6ixnPfK50+ns8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWcwbUhmSmFIM3R2TFY0UVBGOVRBUlMyendmNUV0N09EOWIwQWhvM25GUEFX?=
 =?utf-8?B?dzI1Uk1GVmk5UUMrTEMwVUwvNlk4aHNDNUh6UHcxTkhVQzFnbmxPenJMRnhj?=
 =?utf-8?B?eDJvSEdNNUlPVWRZV1gzVzl0NkF5eGJUT2xFNmZiVFJRbkZZL0RLZGwrUWNx?=
 =?utf-8?B?Um5ySlBuYVhHZ1QvWE1sS0Zmd2p4UE1SWnBLUVIxUFFMS1BrK0huTmkveUZs?=
 =?utf-8?B?VXdzMmhnS3VKYlU3blFUbmlZTzJnZ2hwckt2NDlIbUNFSUthV0xuWDZBQ0lG?=
 =?utf-8?B?azRIT1gwSGwyMUQ4VEk5YTBuQ2x4c2dWdmdkY3h5SGo4VmdGZFdQaStxRUht?=
 =?utf-8?B?M0RubXVOZlZGOEhwNW00YmE4V0hrczVLVFF2VFNBcjgyY1U1a0puSGJxN2pj?=
 =?utf-8?B?S2JCZ25aTitoemxjZ2djb3Q4amFjY096dkxiMjM2T3pub3BsVldxa2pPZkhR?=
 =?utf-8?B?L0ZkbUNRcy9zTWJPMEV2V1dJNTBsYmZtS3VaS3RxbUd0S29SblluUHhGeURJ?=
 =?utf-8?B?KzBLMzM0YVJGZHVLblNIdk8xdjFkQ2V6VlQwQW9TdTVuaU9sNnlxTm1pdjJy?=
 =?utf-8?B?Z2ZIOXQ2d3puSi8vQ0x1azRKS2Zid29zbmdKa0VZMW80cVB3ZnlrUmlrWmNH?=
 =?utf-8?B?Y0gweElUdkRaVzJWSXV2aEQ0VExHOVk5ZlVCazU2Y2RhTVA2cXcvOXRHRC83?=
 =?utf-8?B?MWxlZWVhRXlSa0ZiaGVnOVpnb1lHMHR3Uys2bUcxVjRCRWZIYXd2QVNPUzZZ?=
 =?utf-8?B?OEErekxuQUZrSXplYXd5Tm03V0pwWW9IMks0MzE0SVNPdG02WnpTQjNhSzZO?=
 =?utf-8?B?TkZJZ29aeVdhYUt3NzllL0M1c09GMjdOWWdvdEZ1ck5NSzREd09sSkorcmNa?=
 =?utf-8?B?UDZ0VFFlWVJQYm03S0hpOUV3MHllYm1tOTJrR1E5dHJEaGF0cU9Jbk04eTBj?=
 =?utf-8?B?RjZQT2lXU2YwQXFpcmlZdmV5Sk92dEg3WVg1b2pQcUdhY2xpOTY1V0RMczk1?=
 =?utf-8?B?MkRqNFlWYVZ6aHlBS3QwK2YvRkFWQ3p0aE5INGZkK2hwdFM0bmFBSzVwUkZU?=
 =?utf-8?B?SDJMNCtNQWp0MXo4TFFvQjhNOXpkYk00TWM3TEhvVDhiK3EvQlk2TjRXOFIx?=
 =?utf-8?B?L3BIUzRVWjNwNlltT2tqYUZ1VWJnVGIxdE9TSEhYTGtVK1FPUkVkMTBNV3Nm?=
 =?utf-8?B?UlQyditmUmRWbW9hYnB5dHNnR3VJVUViZ01nZHQwbG9CY1dqRi9JYXU4OGRp?=
 =?utf-8?B?by93ZGRFMmZ6dk1sZVFHemNndUJybTc3bnAwWE9xaDFjVmtKaW5HQ01uRklK?=
 =?utf-8?B?ODlLOUtkdEJnQ3M4VmlQdXpXTWkxdHdZNVpUcGhUWnNtLzFpV28zL204cUFU?=
 =?utf-8?B?YmdNOG82VHM0R29SaXNjVHROaThrUFg4emxqOEE1NlZpZUZ4OXJpN2NXZnZv?=
 =?utf-8?B?Ykk5SjVsN2hyS2NhaFVrYWlUSTFWTUZ1MWZIakhtaEZ4MEtRN2Z3cU1Wai9E?=
 =?utf-8?B?Rlh2OXIvbUN1Y0ZydERXaVZPbUdzRG9JS0xNT0lyQTAzWVZWZ1FoNjJiK0l0?=
 =?utf-8?B?VEJhbFNPbVRBNmk0cEtzUDNpRU9ld3NweVEwc2RFZEFXUHhCdU9OR0h3MDN1?=
 =?utf-8?B?UmZUM1VmK3FmdEdPTzQ5NjZ2QzM3QzQrbnpnVEtNVE9HUXIrTER6cnBvaFMx?=
 =?utf-8?B?RUJHaE5kWkVoSU0zYlFXMXpudE1zcXJDTWEveUdiajBRV1Bpc3NlVXIyUDdj?=
 =?utf-8?B?R1F6MWJKLzZuNkYzcURNbjR4a3YrcFlKaEM4bm1GbGJqdklWcUcxN0Zxdnpw?=
 =?utf-8?B?bVBGYjMwKzBITldJdG9xZ3FCVTdOamJXYWYyT04xT012NmdselFhNDhUbEVC?=
 =?utf-8?B?dkxaRXM5S0szT3JZNjNaSk9mVGwyN2FpT1E3Q21VaTRKeTcrN0haYVRFQVpV?=
 =?utf-8?B?SVRtV09ZQkwyWXZnUll2bGlyZkpiRmtPOWRHN3R0MGYyRUxlM2M5My9Jd0Jx?=
 =?utf-8?B?RDVMU1AwN2xPOCtuN2dyUnVKT1JqWnNwS0VoUlRCY0tmdExNeTRDS0NvQXNL?=
 =?utf-8?B?em84TzBEQlIxVG1rWTNhTm5MU3kxbXFCZU9xTTVJWjlOK0JrTDVDNEdtSTd4?=
 =?utf-8?B?YStHU0RxZ2VqeUlpcmJXMStKU0VyL3FjMmZzL05rcFQwdjhUUks5eHkzeHBX?=
 =?utf-8?B?SUhGdE9UYmd0UXJETlpkcHg5dVdlQ0VmUmd2a1h3TmZLSWo0NWdIQ1puTkdW?=
 =?utf-8?B?eWp6Mm1Kbnp6b0luY1VRVEcvMWxNSGU4d0hVQVlZNXZhd2FlejVselVvcERn?=
 =?utf-8?Q?Nq9G4GNtoOIzPKTwsW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b48ec6-56e9-4b31-113b-08dee188bfe9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:17:38.7034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU8/9Z5S1gBItzjSlyv49/sTv/8w3JIDadLOMXWHUfNUkNyHK7lZRB8iFvso4rKF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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

On 7/13/26 22:24, Matthew Brost wrote:
> On Sat, Jul 11, 2026 at 12:46:40PM +0200, Christian König wrote:
>> On 7/11/26 04:56, Matthew Brost wrote:
>>> Populating a GTT (system) buffer object under the reservation lock can
>>> stall in reclaim and compaction while trying to satisfy beneficial-order
>>> allocations, holding the lock for the duration.
>>
>> Yeah and that is perfectly intentional behavior.
>>
>> I really don't see any reason for any driver to change that.
>>
>> The purpose of the dma_resv lock is to stall other allocation for the same object it protects, making sure that we don't have multiple threads allocating memory for the same buffer object.
>>
>> Why in the world should that be a problem?
>>
> 
> See my example in my reply to the cover letter: multiple threads
> sharing a VM, with a memory allocation performed under the VM dma-resv
> lock, which in turn blocks exec IOCTLs, CPU page faults or VM binds on
> BOs sharing the same VM dma-resv lock. With that, this code could be
> gating on whether the BO allocation shares a VM dma-resv lock.

Ah, ok I see the problem now.

> The most relevant example here, I believe, is that launching a new
> Chrome tab could potentially stall the aforementioned operations in a
> different Chrome tab. Likewise, if games allocate memory on demand
> (they typically do not, because memory allocations are prone to
> introducing stalls), they could also incur the aforementioned stalls.

Yeah, I was already wondering how such an use case is seen with gaming or HPC.

But Chrome is indeed the right stress test for memory allocation :)

> I think the opposite question is more appropriate here: does
> preallocating memory outside of dma-resv before a device can DMA to it
> break any invariants? The answer is no; it does not in the case of GEM
> create IOCTLs or the defragmentation moves introduced in this series.

Of hand it looks like a valid approach to me, but it is still quite hacky.

I would rather suggest something like that:

1. Allocate a BO #1 with a separate dma_resv lock.
2. Populate that BO with the backing store you want to have.
3. Allocate a BO #2 with the dma_resv lock of the VM, but no backing store whatsoever.
4. Lock both BO #1 and #2.
5. Use a new function ttm_bo_swap_backing_stores() to switch the backing store between the two.
6. Unlock everything and drop the reference on BO #1 to let it cleanup.

This way the memory/resources are always allocated to some resource and buffer object which makes it possible to track it.

Tracking the allocated memory is necessary for hot plug and eventually shrinking it.

Regards,
Christian.

> 
> Matt
> 
>> Regards,
>> Christian.
>>
>>>
>>> Mirror the Xe out-of-lock preallocation for pure system BOs: when a
>>> gem_create request targets AMDGPU_GEM_DOMAIN_GTT only, fill the full page
>>> backing up front via ttm_pool_prealloc_fill_full() before taking the
>>> reservation lock. The populate under the lock then simply installs these
>>> pages instead of reclaiming and compacting in the critical section. The
>>> fill is best-effort - a short fill falls back to the normal in-lock
>>> allocation for the remaining pages, and any leftover pages are released
>>> by ttm_pool_prealloc_fini() on all exit paths.
>>>
>>> Unlike Xe, amdgpu has no background defragmenter, so the higher-order
>>> reclaim backoff is left disabled (normal reclaim). If the pool uses
>>> dma-alloc (swiotlb), the fill bails and the feature is a silent no-op.
>>>
>>> Factor the tt pool selection into amdgpu_ttm_tt_pool_id() and
>>> amdgpu_ttm_pool() so the preallocation targets the exact pool the
>>> populate will consume, and thread an optional prealloc bag through
>>> amdgpu_gem_object_create() and amdgpu_bo_param into the populate ctx.
>>>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Carlos Santa <carlos.santa@intel.com>
>>> Cc: Ryan Neph <ryanneph@google.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: Huang Rui <ray.huang@amd.com>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>> Cc: Maxime Ripard <mripard@kernel.org>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Simona Vetter <simona@ffwll.ch>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Assisted-by: GitHub_Copilot:claude-opus-4.8
>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>
>>> ---
>>>
>>> v3:
>>>  - Keep WC caching only when USWC is supported and bound the
>>>    preallocation to available GTT space (Sashiko)
>>> ---
>>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 73 +++++++++++++++++--
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |  5 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  4 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 39 +++++++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +
>>>  8 files changed, 108 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 20831dbebc31..940f58848a97 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -345,7 +345,7 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
>>>  
>>>  	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, 1,
>>>  			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
>>> -			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0);
>>> +			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0, NULL);
>>>  
>>>  	amdgpu_bo_unreserve(mem->bo);
>>>  
>>> @@ -1811,7 +1811,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>  		 domain_string(alloc_domain), xcp_id);
>>>  
>>>  	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
>>> -				       bo_type, NULL, &gobj, xcp_id + 1);
>>> +				       bo_type, NULL, &gobj, xcp_id + 1, NULL);
>>>  	if (ret) {
>>>  		pr_debug("Failed to create BO on domain %s. ret %d\n",
>>>  			 domain_string(alloc_domain), ret);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index b33c300e26e2..51510e831129 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -435,7 +435,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>>>  
>>>  	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
>>>  				       AMDGPU_GEM_DOMAIN_CPU, flags,
>>> -				       ttm_bo_type_sg, resv, &gobj, 0);
>>> +				       ttm_bo_type_sg, resv, &gobj, 0, NULL);
>>>  	if (ret)
>>>  		goto error;
>>>  
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 6a0699746fbc..e8b732218e7d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -39,6 +39,7 @@
>>>  #include <drm/drm_exec.h>
>>>  #include <drm/drm_gem_ttm_helper.h>
>>>  #include <drm/ttm/ttm_tt.h>
>>> +#include <drm/ttm/ttm_pool.h>
>>>  #include <drm/drm_syncobj.h>
>>>  
>>>  #include "amdgpu.h"
>>> @@ -168,7 +169,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>>>  			     int alignment, u32 initial_domain,
>>>  			     u64 flags, enum ttm_bo_type type,
>>>  			     struct dma_resv *resv,
>>> -			     struct drm_gem_object **obj, int8_t xcp_id_plus1)
>>> +			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
>>> +			     struct ttm_pool_prealloc *prealloc)
>>>  {
>>>  	struct amdgpu_bo *bo;
>>>  	struct amdgpu_bo_user *ubo;
>>> @@ -188,6 +190,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>>>  	bp.domain = initial_domain;
>>>  	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>  	bp.xcp_id_plus1 = xcp_id_plus1;
>>> +	bp.prealloc = prealloc;
>>>  
>>>  	r = amdgpu_bo_create_user(adev, &bp, &ubo);
>>>  	if (r)
>>> @@ -412,6 +415,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>  	struct dma_resv *resv = NULL;
>>>  	struct drm_gem_object *gobj;
>>>  	uint32_t handle, initial_domain;
>>> +	struct ttm_pool_prealloc prealloc = {};
>>> +	struct ttm_pool *prealloc_pool = NULL;
>>>  	int r;
>>>  
>>>  	/* reject invalid gem flags */
>>> @@ -443,10 +448,57 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>  		flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>>>  	}
>>>  
>>> +	/*
>>> +	 * For system-only (pure GTT) BOs, preallocate the whole page backing
>>> +	 * up front, outside the reservation lock. Populate under the lock then
>>> +	 * just installs these pages instead of reclaiming/compacting in the
>>> +	 * critical section. Best-effort: a short fill falls back to the normal
>>> +	 * in-lock allocation for the missing pages.
>>> +	 */
>>> +	if (args->in.domains == AMDGPU_GEM_DOMAIN_GTT) {
>>> +		struct ttm_resource_manager *gtt_man =
>>> +			ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>> +		int32_t xcp_id = adev->gmc.mem_partitions ? fpriv->xcp_id : 0;
>>> +		int32_t pool_id = amdgpu_ttm_tt_pool_id(adev, xcp_id);
>>> +		/*
>>> +		 * Mirror the USWC handling in amdgpu_bo_create(): the flag is
>>> +		 * stripped when the platform can't do write-combining, in which
>>> +		 * case the tt is created ttm_cached. The prealloc caching must
>>> +		 * match the final tt caching exactly, otherwise ttm_pool_free()
>>> +		 * would restore the wrong PAT state on these pages (PAT aliasing
>>> +		 * / leak of WC pages into the cached allocator).
>>> +		 */
>>> +		bool uswc = (flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>>> +			amdgpu_bo_support_uswc(flags);
>>> +		enum ttm_caching caching =
>>> +			uswc ? ttm_write_combined : ttm_cached;
>>> +
>>> +		/*
>>> +		 * Only prealloc when the request fits the currently-available
>>> +		 * GTT (total manager size minus current usage). This mirrors the
>>> +		 * amdgpu_bo_validate_size() bound applied later in
>>> +		 * amdgpu_bo_create() while also skipping the up-front reclaim /
>>> +		 * compaction when GTT is already near full or the user-controlled
>>> +		 * size is over-large (the creation path handles those anyway).
>>> +		 */
>>> +		if (gtt_man) {
>>> +			u64 used = ttm_resource_manager_usage(gtt_man);
>>> +			u64 avail = gtt_man->size > used ?
>>> +				gtt_man->size - used : 0;
>>> +
>>> +			if (size <= avail) {
>>> +				prealloc_pool = amdgpu_ttm_pool(adev, pool_id);
>>> +				ttm_pool_prealloc_fill_full(prealloc_pool,
>>> +							    caching, &prealloc,
>>> +							    PFN_UP(size), false);
>>> +			}
>>> +		}
>>> +	}
>>> +
>>>  	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>>>  		r = amdgpu_bo_reserve(vm->root.bo, false);
>>>  		if (r)
>>> -			return r;
>>> +			goto out_prealloc;
>>>  
>>>  		resv = vm->root.bo->tbo.base.resv;
>>>  	}
>>> @@ -455,7 +507,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>  retry:
>>>  	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
>>>  				     initial_domain,
>>> -				     flags, ttm_bo_type_device, resv, &gobj, fpriv->xcp_id + 1);
>>> +				     flags, ttm_bo_type_device, resv, &gobj,
>>> +				     fpriv->xcp_id + 1, prealloc_pool ? &prealloc : NULL);
>>>  	if (r && r != -ERESTARTSYS) {
>>>  		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
>>>  			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>> @@ -479,17 +532,21 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>  		amdgpu_bo_unreserve(vm->root.bo);
>>>  	}
>>>  	if (r)
>>> -		return r;
>>> +		goto out_prealloc;
>>>  
>>>  	r = drm_gem_handle_create(filp, gobj, &handle);
>>>  	/* drop reference from allocate - handle holds it now */
>>>  	drm_gem_object_put(gobj);
>>>  	if (r)
>>> -		return r;
>>> +		goto out_prealloc;
>>>  
>>>  	memset(args, 0, sizeof(*args));
>>>  	args->out.handle = handle;
>>> -	return 0;
>>> +
>>> +out_prealloc:
>>> +	if (prealloc_pool)
>>> +		ttm_pool_prealloc_fini(prealloc_pool, &prealloc);
>>> +	return r;
>>>  }
>>>  
>>>  int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>> @@ -528,7 +585,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>>  
>>>  	/* create a gem object to contain this object in */
>>>  	r = amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOMAIN_CPU,
>>> -				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
>>> +				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
>>>  	if (r)
>>>  		return r;
>>>  
>>> @@ -1298,7 +1355,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>>>  	domain = amdgpu_bo_get_preferred_domain(adev,
>>>  				amdgpu_display_supported_domains(adev, flags));
>>>  	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
>>> -				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
>>> +				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
>>>  	if (r)
>>>  		return -ENOMEM;
>>>  
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>>> index b558336bc4c6..706aeca011f1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>>> @@ -35,6 +35,8 @@
>>>  
>>>  extern const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
>>>  
>>> +struct ttm_pool_prealloc;
>>> +
>>>  unsigned long amdgpu_gem_timeout(uint64_t timeout_ns);
>>>  
>>>  /*
>>> @@ -45,7 +47,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>>>  			     int alignment, u32 initial_domain,
>>>  			     u64 flags, enum ttm_bo_type type,
>>>  			     struct dma_resv *resv,
>>> -			     struct drm_gem_object **obj, int8_t xcp_id_plus1);
>>> +			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
>>> +			     struct ttm_pool_prealloc *prealloc);
>>>  int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>>>  			    struct drm_device *dev,
>>>  			    struct drm_mode_create_dumb *args);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index f98bfba59a2c..18c4cf3f35a5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -632,7 +632,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>>  		/* We opt to avoid OOM on system pages allocations */
>>>  		.gfp_retry_mayfail = true,
>>>  		.allow_res_evict = bp->type != ttm_bo_type_kernel,
>>> -		.resv = bp->resv
>>> +		.resv = bp->resv,
>>> +		.prealloc = bp->prealloc,
>>>  	};
>>>  	struct amdgpu_bo *bo;
>>>  	unsigned long page_align, size = bp->size;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index ff11a0903499..11f1d403f152 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -45,6 +45,8 @@
>>>  #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
>>>  #define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
>>>  
>>> +struct ttm_pool_prealloc;
>>> +
>>>  struct amdgpu_bo_param {
>>>  	unsigned long			size;
>>>  	int				byte_align;
>>> @@ -58,6 +60,8 @@ struct amdgpu_bo_param {
>>>  	void				(*destroy)(struct ttm_buffer_object *bo);
>>>  	/* xcp partition number plus 1, 0 means any partition */
>>>  	int8_t				xcp_id_plus1;
>>> +	/* optional out-of-lock preallocated backing (system/GTT only) */
>>> +	struct ttm_pool_prealloc	*prealloc;
>>>  };
>>>  
>>>  /* bo virtual addresses in a vm */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index b10b0878df37..c9cd4714f515 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1173,6 +1173,30 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
>>>  	kfree(sgt);
>>>  }
>>>  
>>> +/*
>>> + * amdgpu_ttm_tt_pool_id - compute the ttm pool id backing a given xcp
>>> + *
>>> + * Mirrors the mapping used when creating the gtt ttm_tt, so callers that only
>>> + * have an xcp id (e.g. an out-of-lock preallocation before the bo exists) pick
>>> + * the same pool the populate will use.
>>> + */
>>> +int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id)
>>> +{
>>> +	if (adev->gmc.mem_partitions && xcp_id >= 0)
>>> +		return KFD_XCP_MEM_ID(adev, xcp_id);
>>> +
>>> +	return xcp_id;
>>> +}
>>> +
>>> +/* amdgpu_ttm_pool - select the ttm pool for a given pool id */
>>> +struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id)
>>> +{
>>> +	if (adev->mman.ttm_pools && pool_id >= 0)
>>> +		return &adev->mman.ttm_pools[pool_id];
>>> +
>>> +	return &adev->mman.bdev.pool;
>>> +}
>>> +
>>>  /**
>>>   * amdgpu_ttm_tt_create - Create a ttm_tt object for a given BO
>>>   *
>>> @@ -1194,10 +1218,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
>>>  		return NULL;
>>>  
>>>  	gtt->gobj = &bo->base;
>>> -	if (adev->gmc.mem_partitions && abo->xcp_id >= 0)
>>> -		gtt->pool_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
>>> -	else
>>> -		gtt->pool_id = abo->xcp_id;
>>> +	gtt->pool_id = amdgpu_ttm_tt_pool_id(adev, abo->xcp_id);
>>>  
>>>  	if (abo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
>>>  		caching = ttm_write_combined;
>>> @@ -1239,10 +1260,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
>>>  	if (ttm->page_flags & TTM_TT_FLAG_EXTERNAL)
>>>  		return 0;
>>>  
>>> -	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
>>> -		pool = &adev->mman.ttm_pools[gtt->pool_id];
>>> -	else
>>> -		pool = &adev->mman.bdev.pool;
>>> +	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
>>>  	ret = ttm_pool_alloc(pool, ttm, ctx);
>>>  	if (ret)
>>>  		return ret;
>>> @@ -1284,10 +1302,7 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
>>>  
>>>  	adev = amdgpu_ttm_adev(bdev);
>>>  
>>> -	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
>>> -		pool = &adev->mman.ttm_pools[gtt->pool_id];
>>> -	else
>>> -		pool = &adev->mman.bdev.pool;
>>> +	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
>>>  
>>>  	return ttm_pool_free(pool, ttm);
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index ff9e2e346609..f90844937b73 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -207,6 +207,9 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>>  
>>> +int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id);
>>> +struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id);
>>> +
>>>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>>  				 struct amdgpu_hmm_range *range);
>>

