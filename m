Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6383606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i720krEQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F2E10E23F;
	Wed,  4 Nov 2026 12:24:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F30510E115;
 Wed,  4 Nov 2026 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793795038; x=1825331038;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1BGhszcXd1nd2f/W1asjzyiXIgQ6Y8hOWyfjyF/i5wo=;
 b=i720krEQiSAfIXk+lGR+Qhltid7v2lQjfhlWLHVy/mgyFDCbfbs/woiw
 GfgCex6hPEpDKQs0VuF3WUYNjNrZ3eH//OnoAlUFHoX4jZIfFofqsZUYc
 6UC+EJZxzw91Q/+8PpADyVWPUYXYA2SpZlfDJPy57QeudaEhU4woY5zju
 69vuD6zo23VH4/hVizWndGXtfy+5MWf7jELKhJJlyji7yEd2EgSvx+zQu
 /hGgXaGXXc3t6LX41vKHkPeZFu68nXQbiB3UCaI1sC1Sr4mjXa/ReO5AC
 tPAllUwVZuuwqOU/rzzucUktbzzermXkd23exZ0i5v5T/OzLx9bNFGjuG Q==;
X-CSE-ConnectionGUID: zUbAsqT/QyulbjWQpeSM9g==
X-CSE-MsgGUID: xmpns9BDRc63CDMzuWnGAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2425503"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2425503"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 04:23:57 -0800
X-CSE-ConnectionGUID: Qwin6OTXTPmwyFEmPMQdlg==
X-CSE-MsgGUID: cyPe5PgjQHejj2+uFyT8eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6532938"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.43])
 ([10.245.244.43])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 04:23:54 -0800
Message-ID: <5f114662-8c82-4781-9bb1-32e49112fbf4@intel.com>
Date: Wed, 4 Nov 2026 12:23:51 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/33] drm/xe: Add IOVA-based xe_res_cursor variant
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
 <20260711025619.2540575-28-matthew.brost@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260711025619.2540575-28-matthew.brost@intel.com>
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
> Introduce xe_res_first_iova() to walk a buffer that was DMA mapped using
> the IOVA-based DMA API (dma_iova_try_alloc() and friends). Such a mapping
> is described by a struct dma_iova_state and is a single contiguous IOVA
> range, so the cursor walks it as one segment.
> 
> Add an is_iova flag to struct xe_res_cursor to distinguish this case.
> When set, xe_res_dma() returns the IOVA backing the current position
> (state->addr + cursor offset), xe_res_next() advances within the single
> contiguous segment, and xe_res_is_vram() returns false since IOVA
> mappings never point to same-device VRAM.
> 
> The flag is explicitly cleared in the existing xe_res_first(),
> xe_res_first_sg() and xe_res_first_dma() initializers so stale stack
> values cannot leak into the new path.
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
