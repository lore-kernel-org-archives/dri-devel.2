Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99023C88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49CB10E2AA;
	Tue, 15 Sep 2026 14:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Pyzat2xq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0632010E071;
 Tue, 15 Sep 2026 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789481456; x=1821017456;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Oxxao6blWXExFijm5Fok3ZVkCi9b1qDzUnzbmJN9OrY=;
 b=Pyzat2xqxenEOPdcBxn4kz5P6X98/50e9LjjxDhW2u6VpzTa9vahhg93
 hfniIvGnrO2dS2dPUo4lE0LiQ9hWOqXSSnuLG8gvyIW4lj6Q8dQINItA6
 MSmOed1qb0mfmvGdgQRlE4QNqVXTF30ikVm+gjuCFuckxgD4BHz8dn3su
 th+UR7CmXc6mCfNz/7jXG/SoGxOaekIuolKV3a6AeDM/b7L59YRtre55C
 xvX8VYeXliAkLo6an6vehevGp0Y/SpEX3+/g8rBN1b69pSm+wdo1xp4qI
 6NIkbDaScS20XGpCmy3XXncO0DXWVY3AGmNDw523S6xtdwxHk9DET1nwv Q==;
X-CSE-ConnectionGUID: Jz8iANY5Q+2/z/sJxCjGdQ==
X-CSE-MsgGUID: 7TCiAOW6QQG1NZ8eE5RuTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77404370"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="77404370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 07:10:55 -0700
X-CSE-ConnectionGUID: YLPfbuBUTtOAfdrt260klg==
X-CSE-MsgGUID: QkvsK42dSOCYYZM+mWL9+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="271206121"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.243])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 07:10:52 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: Re: [PATCH] drm/i915/fb: replace kmalloc_array with kmalloc_objs
In-Reply-To: <20260910155846.79513-1-lalitshankarch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260910155846.79513-1-lalitshankarch@gmail.com>
Date: Tue, 15 Sep 2026 17:10:50 +0300
Message-ID: <c45b9b5e99c763e37aafdf0c8d794e2499543ceb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 10 Sep 2026, Lalit Shankar Chowdhury <lalitshankarch@gmail.com> wrote:
> Replace the remaining kmalloc_array instance with kmalloc_objs.
>
> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>

Thanks, pushed to drm-intel-next.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/intel_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
> index 1c0859d5f829..c3e4c3f6d8cf 100644
> --- a/drivers/gpu/drm/i915/display/intel_fb.c
> +++ b/drivers/gpu/drm/i915/display/intel_fb.c
> @@ -596,7 +596,7 @@ u64 *intel_fb_plane_get_modifiers(struct intel_display *display,
>  			count++;
>  	}
>  
> -	list = kmalloc_array(count, sizeof(*list), GFP_KERNEL);
> +	list = kmalloc_objs(*list, count);
>  	if (drm_WARN_ON(display->drm, !list))
>  		return NULL;

-- 
Jani Nikula, Intel
