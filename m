Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B25C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0FA10EEC8;
	Wed,  1 Jul 2026 11:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MOuVgQ9N";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F1410E388;
 Wed,  1 Jul 2026 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782904798; x=1814440798;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gyO/hx1mJEoB9s4Jb/OgGuQ2OFVjNXQVa1TidDgDBxs=;
 b=MOuVgQ9NDKza7mUcpLNa82759rit5zlK3EqGvD7BFYWCxTlmXA/qFatU
 NR+a5cf5Z8h35C1GkCXB5IGNlt5FdrFV9jKaJvBrA193YYPvVO/aOaAyK
 BFbo+heY6k/Hi3eXo0Yx5IH8C5VO2ytv57iV5C2jXTpxQPt7614VQ9m+o
 3WPRsBWMSKaD3y+SlIWhukbvaP3mv7WzG/Ze3tWYoanUZ3Jib0UfV5qhc
 T41uhUqN8lvCEtC5hb+vucHBy48FvLJy/MwlUZTWuxjgq7/ec+GOdOnz6
 xykyut/BlRAAf+hgF8b6S43A9ESlPMSz7stmOMJfbBzi+aLgeaEujFG5R w==;
X-CSE-ConnectionGUID: 53oNnPdQQg6ZvlX6Yz9r5w==
X-CSE-MsgGUID: OIJKM4e7T/yU2PN/o3OMvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87547654"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="87547654"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 04:19:57 -0700
X-CSE-ConnectionGUID: VonLuFK8S1mY3IUQRcmzIg==
X-CSE-MsgGUID: XE1wrlocSoyhSWvPHJQjiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="252667810"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.244.98])
 ([10.245.244.98])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 04:19:56 -0700
Message-ID: <7395991e-eb9e-483b-bdc9-7eb756a1b31c@linux.intel.com>
Date: Wed, 1 Jul 2026 13:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, Martin Hodo <martin.hodo@intel.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, stable@vger.kernel.org
References: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

On 7/1/26 09:55, Joonas Lahtinen wrote:
> Setting context engine slot N into I915_ENGINE_CLASS_INVALID /
> I915_ENGINE_CLASS_INVALID_NONE and attempting to apply
> I915_CONTEXT_PARAM_SSEU to the same slot N will deref NULL.
> Fix that.
> 
> Discovered using AI-assisted static analysis confirmed by
> Intel Product Security.
> 
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index aeafe1742d30..347d1f2c05f5 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -850,7 +850,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
>  		pe = &pc->user_engines[idx];
>  
>  		/* Only render engine supports RPCS configuration. */
> -		if (pe->engine->class != RENDER_CLASS)
> +		if (!pe->engine || pe->engine->class != RENDER_CLASS)
>  			return -EINVAL;
>  
>  		sseu = &pe->sseu;

