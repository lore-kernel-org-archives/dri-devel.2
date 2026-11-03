Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A5606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SNZ498qP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984B510F78C;
	Tue,  3 Nov 2026 19:00:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D7F10E817;
 Tue,  3 Nov 2026 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793732429; x=1825268429;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uSbnyMu7zPfUwkMOnzRSRXvBzH7ND59gm+U4f8AT6Ts=;
 b=SNZ498qPKKAl4TdBNAQTGzy0ckXXsZEEqDEsmPTEk6Z/Vj52Irq8xoEA
 7mNe+idm+mDaxoXprEV3YF0hYCpFCek1oRa4ioi6XGPsi4XSg5SdLPHX3
 WfkNlj14PmCTHZPXvUnK+4wIpMBQnnvXtQdjjUULJA6/OmLlrBCVheMXW
 NpO7by57k8QcSLFhYKZILJQJ1iCLEbr0aFZWBjS795qsxpHZE44sIT2On
 D6xToIs4wipzUBy+XdPpjp+bGd5+UXt2M45KWfkAchcCfzvDEN8HAXeOn
 o56LHkPq6Nc2rs5MMh5AFpTmohaMx1iaB4ekIrp9Rme6EiUcV1fFv7p0F Q==;
X-CSE-ConnectionGUID: 1wYfBlMsT22+jvrzDf6m5A==
X-CSE-MsgGUID: hSOXO9CxS2OOdbSqvup20A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2470740"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2470740"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 11:00:29 -0800
X-CSE-ConnectionGUID: eNFCkQY/TKWLhsM53RGj4g==
X-CSE-MsgGUID: 4fDu614yR5imfrONkh4GMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6837732"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.245.160])
 ([10.245.245.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 11:00:25 -0800
Message-ID: <a26a2160-fb6a-4d21-b132-d00093622b22@intel.com>
Date: Tue, 3 Nov 2026 19:00:24 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/33] drm/xe: Use IOVA-based DMA mapping for eligible
 tt BOs
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-29-matthew.brost@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260711025619.2540575-29-matthew.brost@intel.com>
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

On 11/07/2026 03:56, Matthew Brost wrote:
> Add support for mapping a ttm_tt's pages using the IOVA-based DMA API
> (dma_iova_try_alloc()/link()/sync()/unlink()/free()) as an alternative
> to the scatter-gather list. An IOVA mapping is a single contiguous DMA
> range, which is cheaper to walk and program than an sg list.
> 
> Whether the IOVA API can be used depends on the IOMMU mode, so the
> decision is made once per tt at xe_ttm_tt_create() time and recorded in
> struct xe_ttm_tt::use_iova. To keep the scope limited, only device BOs
> that are not GGTT-mapped are eligible: dma-buf imports manage their own
> mapping and GGTT bindings are programmed directly from the sg list.
> dma_iova_try_alloc() may still fail, in which case the tt transparently
> falls back to the sg list, which remains the default.
> 
> The IOVA reservation is allocated at tt creation and freed at tt
> destroy. xe_tt_map_iova() links the tt pages (coalescing physically
> contiguous runs) and syncs the IOTLB; xe_tt_unmap_iova() unlinks them
> but keeps the reservation so the tt can be remapped without
> re-allocating IOVA space. xe_tt_map()/xe_tt_unmap() dispatch between the
> IOVA and sg backends, and xe_bo_dma_unmap_pinned() learns about the IOVA
> case.
> 
> Consumers that walked the sg list via xe_res_first_sg(xe_bo_sg()) now go
> through the new xe_res_first_tt() helper, which initializes either an
> IOVA cursor (xe_res_first_iova()) or an sg cursor depending on the tt's
> mapping mode.
> 
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Ryan Neph <ryanneph@google.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>


<snip>

>   static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct ttm_tt *tt)
>   {
> +	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> +
> +	/*
> +	 * Release the IOVA reservation made in xe_ttm_tt_create(). The pages
> +	 * must already have been unlinked by xe_tt_unmap().
> +	 */
> +	if (xe_tt->use_iova) {
> +		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
> +
> +		xe_assert(xe, !xe_tt->iova_linked);
> +		dma_iova_free(xe->drm.dev, &xe_tt->iova);

Do we know if this is allowed? I think there is 
xe_bo_pci_dev_remove_all() which requires that evict_all will correctly 
tear down iommu mappings on stuff like pci unplug and I don't think 
tt_destroy is called in that flow? Does having the iova here cause 
issues? Also, for VRAM flow I think there is a tt_create() via pipeline 
gutting which will now create a new iova?

Aside from that, maybe we can land 27/28 as standalone?
