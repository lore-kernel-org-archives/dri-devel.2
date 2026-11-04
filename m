Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923B606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Syde+xg9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E93310FA25;
	Wed,  4 Nov 2026 11:39:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B31D10FA25;
 Wed,  4 Nov 2026 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793792378; x=1825328378;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/7/ERNg8lgbcxb3bPZCGMGuw3wZ3SgyLLV1A63XrHi0=;
 b=Syde+xg9d8BmhnoIYy/9Csa5Mmw2MW4Ku7p5tKqX/viRd6KV8ldQJBXc
 335Xim+Z+RpQ4wb1KRDbbQ50USiVL4H2WHMOH35Ae4FkxIiGqSuaHw8XC
 S22Q3+6m+FtWdcK1LUQzTKiBTBmNar97mTla94JWIDDgX6uvBeG+k3U8P
 j+Fs+RCeTJSSmZowpe7mJEJabkdYmqnrwulWpGtMcsVVfFrDwZ85TNe2S
 MZMjrxxrppfZwcvxZHvYkTDUtWcYBOmpwkpHC1bnPBGX1qtkLUiMMaYY7
 AJfevt2vuhT/IAT4VzmhoCzvrHokrdWM/nyNcar7zEwOlPJ7avuOxY3OQ w==;
X-CSE-ConnectionGUID: ZrRIdxL/SFWRZgIA+VQLjw==
X-CSE-MsgGUID: MuMNexyUTlGuU1QLPpST1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2577900"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2577900"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:39:37 -0800
X-CSE-ConnectionGUID: YWADxan0TVGS+ce0naeN7Q==
X-CSE-MsgGUID: PeC3xVFbQ8i5lWsFZgLJpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8568820"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.43])
 ([10.245.244.43])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:39:33 -0800
Message-ID: <7f567052-f8a8-488f-beb8-aff8f099fe0c@intel.com>
Date: Wed, 4 Nov 2026 11:39:30 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/33] drm/xe: Use IOVA-based DMA mapping for eligible
 tt BOs
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-29-matthew.brost@intel.com>
 <a26a2160-fb6a-4d21-b132-d00093622b22@intel.com>
 <aupCPWQ7v5kyCpcW@gsse-cloud1.jf.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <aupCPWQ7v5kyCpcW@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03/11/2026 20:21, Matthew Brost wrote:
> On Tue, Nov 03, 2026 at 07:00:24PM +0000, Matthew Auld wrote:
>> On 11/07/2026 03:56, Matthew Brost wrote:
>>> Add support for mapping a ttm_tt's pages using the IOVA-based DMA API
>>> (dma_iova_try_alloc()/link()/sync()/unlink()/free()) as an alternative
>>> to the scatter-gather list. An IOVA mapping is a single contiguous DMA
>>> range, which is cheaper to walk and program than an sg list.
>>>
>>> Whether the IOVA API can be used depends on the IOMMU mode, so the
>>> decision is made once per tt at xe_ttm_tt_create() time and recorded in
>>> struct xe_ttm_tt::use_iova. To keep the scope limited, only device BOs
>>> that are not GGTT-mapped are eligible: dma-buf imports manage their own
>>> mapping and GGTT bindings are programmed directly from the sg list.
>>> dma_iova_try_alloc() may still fail, in which case the tt transparently
>>> falls back to the sg list, which remains the default.
>>>
>>> The IOVA reservation is allocated at tt creation and freed at tt
>>> destroy. xe_tt_map_iova() links the tt pages (coalescing physically
>>> contiguous runs) and syncs the IOTLB; xe_tt_unmap_iova() unlinks them
>>> but keeps the reservation so the tt can be remapped without
>>> re-allocating IOVA space. xe_tt_map()/xe_tt_unmap() dispatch between the
>>> IOVA and sg backends, and xe_bo_dma_unmap_pinned() learns about the IOVA
>>> case.
>>>
>>> Consumers that walked the sg list via xe_res_first_sg(xe_bo_sg()) now go
>>> through the new xe_res_first_tt() helper, which initializes either an
>>> IOVA cursor (xe_res_first_iova()) or an sg cursor depending on the tt's
>>> mapping mode.
>>>
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
>>
>>
>> <snip>
>>
>>>    static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct ttm_tt *tt)
>>>    {
>>> +	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>>> +
>>> +	/*
>>> +	 * Release the IOVA reservation made in xe_ttm_tt_create(). The pages
>>> +	 * must already have been unlinked by xe_tt_unmap().
>>> +	 */
>>> +	if (xe_tt->use_iova) {
>>> +		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
>>> +
>>> +		xe_assert(xe, !xe_tt->iova_linked);
>>> +		dma_iova_free(xe->drm.dev, &xe_tt->iova);
>>
>> Do we know if this is allowed? I think there is xe_bo_pci_dev_remove_all()
>> which requires that evict_all will correctly tear down iommu mappings on
>> stuff like pci unplug and I don't think tt_destroy is called in that flow?
> 
> But unpopulate is called which unlinks / syncs (TLB flush for the IOVA).
> 
>> Does having the iova here cause issues? Also, for VRAM flow I think there is
>> a tt_create() via pipeline gutting which will now create a new iova?
>>
> 
> Maybe we shuffle this around a bit so the iova alloc is tied to
> populate/unpopulate. It was been a while I forget exactly why I did this
> way.
> 
>> Aside from that, maybe we can land 27/28 as standalone?
> 
> Yes, let me extract these two into standalone patches today and
> reworking if needed.

Quickly double checked this, indeed looks to be needed:

[  808.058892] [IGT] core_hotunplug: finished subtest 
hotreplug-lateclose-with-load, SUCCESS
[  808.058928] [IGT] core_hotunplug: exiting, ret=0
[  808.059673] BUG: kernel NULL pointer dereference, address:
[  808.061068] RIP: 0010:iommu_get_dma_domain+0x10/0x20
[  808.061141] PKRU: 55555554
[  808.061144] Call Trace:
[  808.061146]  <TASK>
[  808.061149]  dma_iova_free+0x18/0xf0
[  808.061153]  xe_ttm_tt_destroy+0x23/0x40 [xe]
[  808.061231]  ttm_bo_put+0x242/0x3d0 [ttm]
[  808.061412]  ? drm_gpuvm_bo_put+0x199/0x200 [drm_gpuvm]
[  808.061418]  xe_vma_destroy_late+0x89/0x90 [xe]
[  808.061476]  xe_vm_close_and_put+0x5de/0x920 [xe]
[  808.061534]  xe_file_close+0x105/0x190 [xe]
[  808.061712]  drm_file_free+0x218/0x260
[  808.061717]  drm_release_noglobal+0x6d/0xd0
[  808.061721]  __fput+0xf9/0x270
[  808.061725]  task_work_run+0x8b/0xb0
[  808.061730]  do_exit+0x229/0x8b0
[  808.061735]  do_group_exit+0x8b/0x90
[  808.061739]  __x64_sys_exit_group+0x17/0x20
[  808.061744]  x64_sys_call+0x18c6/0x18d0
[  808.061749]  do_syscall_64+0xee/0x350
[  808.061753]  ? __pte_offset_map+0x1d/0xd0
[  808.061757]  ? next_uptodate_folio+0xbb/0x3a0
[  808.061762]  ? set_pte_range+0x20d/0x290
[  808.061766]  ? filemap_map_pages+0x8e1/0x9c0
[  808.061772]  ? count_memcg_events+0x7c/0x1b0
[  808.061776]  ? handle_mm_fault+0xbde/0x14f0
[  808.061781]  ? __se_sys_close+0x7a/0xe0
[  808.061785]  ? __se_sys_close+0x7a/0xe0
[  808.061790]  ? do_user_addr_fault+0x272/0x6c0
[  808.061794]  ? irqentry_exit+0x3f/0x640
[  808.061799]  ? do_syscall_64+0x42/0x350
[  808.061803]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  808.061808] RIP: 0033:0x7f95428c71b8

I assume this is dev->iommu_group = NULL post unplug.

> 
> Matt

