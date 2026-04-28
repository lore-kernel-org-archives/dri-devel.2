Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACF3FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1983F10EAC1;
	Tue, 28 Apr 2026 09:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gFphJHPh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC99810E2FA;
 Tue, 28 Apr 2026 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777369832; x=1808905832;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8s9vQdXd3kEQ7KMCHR5ooAK8wxF33yzjapSExtEU4KQ=;
 b=gFphJHPhJO1oAV0tv7/6pzcdcbmu5B9wqIA2GwuArUXzbx/M3bkY/sM8
 WaB80ceGubjU8HXi2CmUv4ZxmK6W6QcnTH2vVvjqawKvAW66Rz2hAx/O5
 C7DV5wA/QsaKviVRMsLAG2B9jaTGdj5B5XLWU3pr/e6m/ScDXfpqGFjcH
 rTJGQoW7NIUfO1qz/eI+ltBmSAw+g4YpnChHnAdu2jca2Q6nXM+q+9sbq
 E9hLVcnVIPPrbRAyQMAp4vc8DudhbDs8xBuX98f0P1aJqU49sjLyZY/wn
 huIlMX0k98J55QPvogijVquD2MUfQhJehFXRzhqrauhLg41Qa/5yWxeAJ Q==;
X-CSE-ConnectionGUID: sRdY/6NLS1K4mmfv5tOqdw==
X-CSE-MsgGUID: 93hhBuZRQWGYAThz5B31IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82125289"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="82125289"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 02:50:31 -0700
X-CSE-ConnectionGUID: hnwItf69R7e23gjNGDOHiQ==
X-CSE-MsgGUID: oJoL+nlBQxC0jIG/0kpnVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="232901388"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.244.230])
 ([10.245.244.230])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 02:50:27 -0700
Message-ID: <84473cbe-79ad-421e-8c8a-171e5784105f@linux.intel.com>
Date: Tue, 28 Apr 2026 11:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/xe: Wire up dmem cgroup reclaim for VRAM
 manager
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>, 
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260428073116.15687-1-thomas.hellstrom@linux.intel.com>
 <20260428073116.15687-4-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260428073116.15687-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



Den 2026-04-28 kl. 09:31, skrev Thomas Hellström:
> Register the VRAM manager with the dmem cgroup reclaim infrastructure
> so that lowering dmem.max below current VRAM usage triggers TTM
> eviction rather than failing with -EBUSY.
> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> index 5fd0d5506a7e..1bdcb3fee901 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> @@ -303,13 +303,6 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
>  	struct ttm_resource_manager *man = &mgr->manager;
>  	int err;
>  
> -	if (mem_type != XE_PL_STOLEN) {
> -		const char *name = mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
> -		man->cg = drmm_cgroup_register_region(&xe->drm, name, size);
> -		if (IS_ERR(man->cg))
> -			return PTR_ERR(man->cg);
> -	}
> -
>  	man->func = &xe_ttm_vram_mgr_func;
>  	mgr->mem_type = mem_type;
>  	mutex_init(&mgr->lock);
> @@ -318,6 +311,18 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
>  	mgr->visible_avail = io_size;
>  
>  	ttm_resource_manager_init(man, &xe->ttm, size);
> +
> +	if (mem_type != XE_PL_STOLEN) {
> +		const char *name = mem_type == XE_PL_VRAM0 ? "vram0" : "vram1";
> +		struct dmem_cgroup_region *cg =
> +			drmm_cgroup_register_region(&xe->drm, name, size);
> +
> +		if (IS_ERR(cg))
> +			return PTR_ERR(cg);
> +
> +		ttm_resource_manager_set_dmem_region(man, cg);
> +	}
> +
>  	err = gpu_buddy_init(&mgr->mm, man->size, default_page_size);
>  	if (err)
>  		return err;

This patch will conflict with 
https://patchwork.freedesktop.org/series/164694/ which removes
stolen support, can we merge that patch first while we wait for AMD acks?

Do I need an ack to get the series through drm-misc?

Kind regards,
~Maarten Lankhorst
