Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F6606A32E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L8rGaNpu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C2110E1E0;
	Thu,  5 Nov 2026 11:27:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 081FE10E1E0;
 Thu,  5 Nov 2026 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793878059; x=1825414059;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=D4OjcmHrS0QbC9UUT3DILK073eHBKw+YkRSR7R15oDs=;
 b=L8rGaNpuB5a1nABj7OiWlbmn+a0dnOsW8a+uyQGPNLPKVfClVZDIwTOu
 11ny70idCp8QgfG+3XiYlv1QjZCZ+momTPxX1xIntZaCx8WRiMuIxCF9p
 Us2VtBMKls5O/j/XZVEHoFI3bPm7SB5SAVAB2kIV7tPRo+EOe8ffGTkrH
 rvcgImGbkhhyHNP2o5yIsWJjaahdnX4LVPQmyVmU6lHh8MuQtIr7vcTjQ
 wAUyzu4upwJ1S42zpRBgvM0XrZl2Bzeo0XwpEI0cskpEmSPZzdwGTi8L0
 sXbJxvEoiVn0zFmw5lIoZkiYu8YM90BmhBiMWzeMAqIeI9bFOsz7EKVzx w==;
X-CSE-ConnectionGUID: qgw7Z5SMTiiRvBdozXuRsg==
X-CSE-MsgGUID: W+ZgJs1uRY6tl7DvXLVGDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2560946"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2560946"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 03:27:38 -0800
X-CSE-ConnectionGUID: cIpsfU0YTKyQnCv4J0MbOg==
X-CSE-MsgGUID: nf8slcV4SlitA07YKR+Bmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6861812"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.225])
 ([10.245.244.225])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 03:27:35 -0800
Message-ID: <c2441394-82ac-4647-a068-be365194596a@intel.com>
Date: Thu, 5 Nov 2026 11:27:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/33] drm/ttm/pool: Add ttm_pool_page_order_nodma()
 helper
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
 <20260711025619.2540575-3-matthew.brost@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260711025619.2540575-3-matthew.brost@intel.com>
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

On 11/07/2026 03:55, Matthew Brost wrote:
> TTM records the allocation order of a multi-order page in page->private at
> allocation time. For pools that do not use dma_alloc the order is stored
> directly, while dma_alloc pools store a struct ttm_pool_dma pointer there
> instead. Drivers that do their own DMA mapping (e.g. Xe) need the per-page
> order to walk a populated ttm_tt one chunk at a time, but cannot rely on
> folio_order(): TTM allocates high-order pages with alloc_pages_node()
> without __GFP_COMP, so they are not compound and folio_order() always
> returns 0.
> 
> Expose ttm_pool_page_order_nodma(), a thin wrapper that returns the order
> recorded in page->private. It is only valid for pages from a pool that does
> not use dma_alloc; whether a TTM device uses dma_alloc is fixed at ttm
> device init time, so callers know from their device configuration that this
> helper applies. Use it from the existing internal ttm_pool_page_order() to
> keep a single source of truth.
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

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

