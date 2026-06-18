Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F363CD98F6
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 18:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3E710F3BD;
	Thu, 18 Jun 2026 18:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="nJvCA8Lw";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2C010F3A0
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 18:41:31 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so11901965e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781808090; x=1782412890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hFv3GlUYs5wNN+O537Q1dHtRqP7co1Grb9v+N2l5i1U=;
 b=nJvCA8LwULnFCPIMSmfuQ/dcmVk60Lq4tp1Z4O1Wkd57p76BCEb+SJbeoyfTjY3zwF
 a3YKs2IYjSqdp69f72pbnpJRpnea6LrQbuiwnxifPNu5BT9o72FuuRZUCaahkfDdojr4
 I6bY0UDiMDs0rZtwBq49Z9KfGzbG3PvEO/sQgDrOkVVMwPMrnBCjNuH7H1gUl1lASWOz
 OD3M5UizDBtspnlNI/3zhuewXmRa6riJiAuPq3EWS3FaJsGlVr0gqjchsKg748vMi6z4
 c5tOiiYKPFgkCuv1UDi8ZlGA3zJ4lECfHcjETiww6Q8O9Lt/A+LETA6aEi+w3ihC28On
 tTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781808090; x=1782412890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hFv3GlUYs5wNN+O537Q1dHtRqP7co1Grb9v+N2l5i1U=;
 b=XftIyLBYvkuZkO6bfIeP1X2EV4n7hNpDXUcxkgMf9EDyRMngVdNRnodBVEQwHg8/OJ
 kxFyL51of7y0Hqy267ZVRWuj1MlpKKzXXzWPY991EmFQgBiAlCbEjHkJ16au1TKbpMjZ
 rH7Il8zn50EeqXKQh9tiEiHt2ho85+u6m/m0TM0L7T/OxYgaHIPXbqJwoy0hAvbfEXE7
 cC/w8R7ISdg886nhmko7MbArbNifsHBydh802v/qqjS7bl2nfizAqbl48MjJ/8WDZTvt
 CrkPT6V2jIOCFqQn7YVpHomv6YPb3AqJcRguBGV16SwrhqHy5MN7TJLvPcfWHFj3nPiO
 VzHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SxpR6qoLoxrHaHYSiTRRWEOw/C0WPu1B/kP0LawKE9zoj0RVr98wYHfW7pWXhYInJDN/odSRdKSQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZAk6t6B/Es+foBkpn/FUepEhYW9nCvozZPyvGbH6zn5VmHXIy
 cBRo2ZfldhrlnW9gqpBLCbCNojholXAgueblrGagPtPtZB8pNE2uZAi5DJc6qW9nZD8=
X-Gm-Gg: AfdE7cnMJOdwCaaMtc2W1T940AjYnuwvr/e1rXomWwqhnsDfsqHnT1aYGJwVAb9yjCx
 Wq33qwkRoQtN1MZyWM1r1/s7Xrnzaczi3rwNljj3Ir7ewjCs2VVEWUIIZ+OnONUz7MgMAMYMK3l
 9Ko5Kv93btnVWHRqtwWHLLJEGdPIy1xiYRW9cRY9WzLUl0FL7EwArfYYFudNghj8eriA74k70wo
 ePEe9mCz97c+mHuD0uuPVXOpTTlZO1xTsItunaY+FDRQO/pczvoCkW/I0TTUSN2yxMgTClt0nWc
 YWuVi3fdJYdrCuQVCZEFK8AYdmNsvbP6lBSU75gGIxQVw00ZAT+W3f3y2bed1cqGo8sQUOisSDp
 qgxfetSp9VEVpkyjhD2b5zre4KwTTymOCmXyGidIkpgp/i2jh+CuiLuBn0Tg+qLuQavF5RASooq
 e3+q6Uk5qicP/eg0fDSboasOiJncUWp+HDsw==
X-Received: by 2002:a05:600c:1c1c:b0:492:1e36:552b with SMTP id
 5b1f17b1804b1-49240e7f307mr1905325e9.36.1781808089941; 
 Thu, 18 Jun 2026 11:41:29 -0700 (PDT)
Received: from [172.16.30.123] ([37.209.163.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b76e7c9sm865703f8f.21.2026.06.18.11.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 11:41:29 -0700 (PDT)
Message-ID: <1544040a-578f-41b0-9660-5a6f470f031f@ursulin.net>
Date: Thu, 18 Jun 2026 20:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: rename ttm_place::fpfn/lpfn to param1/param2
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260618133908.2761908-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260618133908.2761908-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 18/06/2026 15:39, Arunpravin Paneer Selvam wrote:
> The fpfn/lpfn fields in struct ttm_place were named after page frame
> numbers, but they are really just placement parameters passed to the
> backend resource manager. Rename them to the generic param1/param2
> and document that their interpretation is backend-defined. The VRAM
> range manager continues to treat them as the first and last valid
> page frame number, so behaviour is unchanged.
>
> This decouples the API from PFN/range-specific semantics so that
> these fields can be used more flexibly in the future (e.g.,
> mask-based or segment-aware placement constraints). No functional
> change.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 16 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |  8 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 46 +++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 24 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       | 16 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 32 +++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  2 +-
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  2 +-
>   drivers/gpu/drm/drm_gem_vram_helper.c         |  4 +-
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c       | 18 +++---
>   drivers/gpu/drm/i915/i915_ttm_buddy_manager.c | 56 +++++++++----------
>   drivers/gpu/drm/i915/intel_region_ttm.c       | 14 ++---
>   drivers/gpu/drm/loongson/lsdc_ttm.c           |  4 +-
>   drivers/gpu/drm/nouveau/nouveau_bo.c          | 22 ++++----
>   drivers/gpu/drm/nouveau/nouveau_mem.c         |  8 +--
>   drivers/gpu/drm/qxl/qxl_object.c              |  4 +-
>   drivers/gpu/drm/qxl/qxl_ttm.c                 |  4 +-
>   drivers/gpu/drm/radeon/radeon_object.c        | 28 +++++-----
>   drivers/gpu/drm/radeon/radeon_ttm.c           | 18 +++---
>   drivers/gpu/drm/radeon/radeon_uvd.c           |  8 +--
>   drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c | 16 +++---
>   drivers/gpu/drm/ttm/tests/ttm_mock_manager.c  |  8 +--
>   drivers/gpu/drm/ttm/ttm_bo_util.c             |  4 +-
>   drivers/gpu/drm/ttm/ttm_range_manager.c       | 18 +++---
>   drivers/gpu/drm/vmwgfx/vmwgfx_bo.c            | 30 +++++-----
>   drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c    |  8 +--
>   drivers/gpu/drm/xe/xe_bo.c                    | 24 ++++----
>   drivers/gpu/drm/xe/xe_ttm_vram_mgr.c          | 40 ++++++-------
>   include/drm/ttm/ttm_placement.h               | 15 +++--
>   32 files changed, 259 insertions(+), 252 deletions(-)

<snip>
>   	if (unlikely(ret)) {
> @@ -124,8 +124,8 @@ static bool ttm_range_man_intersects(struct ttm_resource_manager *man,
>   	u32 num_pages = PFN_UP(size);
>   
>   	/* Don't evict BOs outside of the requested placement range */
> -	if (place->fpfn >= (node->start + num_pages) ||
> -	    (place->lpfn && place->lpfn <= node->start))
> +	if (place->param1 >= (node->start + num_pages) ||
> +	    (place->param2 && place->param2 <= node->start))
>   		return false;
>   
>   	return true;
> @@ -139,8 +139,8 @@ static bool ttm_range_man_compatible(struct ttm_resource_manager *man,
>   	struct drm_mm_node *node = &to_ttm_range_mgr_node(res)->mm_nodes[0];
>   	u32 num_pages = PFN_UP(size);
>   
> -	if (node->start < place->fpfn ||
> -	    (place->lpfn && (node->start + num_pages) > place->lpfn))
> +	if (node->start < place->param1 ||
> +	    (place->param2 && (node->start + num_pages) > place->param2))
>   		return false;
>   

Not very readable ie. good for ease of maintenance - how about an union? 
Would also avoid having to touch all the drivers.

Something like:

union {
     struct {
         u64 fpfn;
         u64 lpfn;
     };
     u64 drvparam[2];
};

Regards,

Tvrtko
> diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
> index ab2639e42c54..2c38674be102 100644
> --- a/include/drm/ttm/ttm_placement.h
> +++ b/include/drm/ttm/ttm_placement.h
> @@ -73,16 +73,23 @@
>   /**
>    * struct ttm_place
>    *
> - * @fpfn:	first valid page frame number to put the object
> - * @lpfn:	last valid page frame number to put the object
> + * @param1:	generic placement parameter, interpretation depends on the
> + *		backend resource manager. For range-based managers (e.g. the
> + *		VRAM range manager, the buddy managers in amdgpu/i915/xe and
> + *		the TTM range manager) this is the start of the allowed range,
> + *		typically expressed as a page frame number.
> + * @param2:	generic placement parameter, interpretation depends on the
> + *		backend resource manager. For range-based managers this is the
> + *		exclusive end of the allowed range (a value of 0 means
> + *		"no upper bound").
>    * @mem_type:	One of TTM_PL_* where the resource should be allocated from.
>    * @flags:	memory domain and caching flags for the object
>    *
>    * Structure indicating a possible place to put an object.
>    */
>   struct ttm_place {
> -	uint64_t	fpfn;
> -	uint64_t	lpfn;
> +	uint64_t	param1;
> +	uint64_t	param2;
>   	uint32_t	mem_type;
>   	uint32_t	flags;
>   };
>
>
