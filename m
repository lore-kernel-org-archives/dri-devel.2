Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E284C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC1A10E252;
	Wed, 16 Sep 2026 10:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jyRcyFW7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C009910E1F7;
 Wed, 16 Sep 2026 10:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789555359; x=1821091359;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=jybIAO1GLgcddy90NEDtvTS4obrkgO3TiNCU1c7O9uo=;
 b=jyRcyFW7FbganaVAxlywt8nsX7dK9tsR4Tpo0icA8uUxDM+B0YyAfgz6
 tJB8PuR/Sg4NAk2YpCk2GolVVGG7YE8sml0CAFqZC4OqwFCoxJbCohK6W
 m/lbGHV7oHSo5z+4D2/tpNZHN45EWj6Pa8x2BrubhRN+6AClliiTBFJr3
 SdbbDp/owE+kUowPXYyKROu+9ER19G8HdS35PIaq/gcyY5i03SPDqDwtM
 xkNZQgXP7vEKevKSQ5Oqwgh3DcZqwFdNTOZ4z6CG2mMIIbQjprXJoBar8
 9voNG1IPVjUwSE28BbXm7Nn8jaHBAP7+voCCxiwCg0IC3fUq9WCxeS8gs Q==;
X-CSE-ConnectionGUID: sa8RkIPvR52N3wQwLR+WOg==
X-CSE-MsgGUID: k6baR9duTge7SShPnjc8RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89771838"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89771838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:42:39 -0700
X-CSE-ConnectionGUID: UfEt6JBJQuqv4M9vFNp5Ow==
X-CSE-MsgGUID: oR1r9IgtR6ecYm8gQUvzyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273846995"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.147])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:42:33 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Melissa Wen
 <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH v3 5/7] drm/i915: Use drm_timeout_rel_to_jiffies()
In-Reply-To: <20260915-drm-timeout-helpers-v3-5-f2ae987d861f@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-5-f2ae987d861f@igalia.com>
Date: Wed, 16 Sep 2026 13:42:30 +0300
Message-ID: <14ba4c66ffb00d478e71448112492a1bcd13facb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 15 Sep 2026, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
> nsecs_to_jiffies_timeout() originated here and has since been copied into
> another driver. It is now available in "drm_timeout.c", so use it and drop
> the local definition.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

and

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via drm-misc.

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_wait.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i=
915/gem/i915_gem_wait.c
> index 2893df65c359..872d4045813a 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> @@ -7,6 +7,8 @@
>  #include <linux/dma-fence-chain.h>
>  #include <linux/jiffies.h>
>=20=20
> +#include <drm/drm_timeout.h>
> +
>  #include "gt/intel_engine.h"
>  #include "gt/intel_rps.h"
>=20=20
> @@ -184,25 +186,12 @@ i915_gem_object_wait(struct drm_i915_gem_object *ob=
j,
>  	return !timeout ? -ETIME : 0;
>  }
>=20=20
> -static inline unsigned long nsecs_to_jiffies_timeout(const u64 n)
> -{
> -	/* nsecs_to_jiffies64() does not guard against overflow */
> -	if ((NSEC_PER_SEC % HZ) !=3D 0 &&
> -	    div_u64(n, NSEC_PER_SEC) >=3D MAX_JIFFY_OFFSET / HZ)
> -		return MAX_JIFFY_OFFSET;
> -
> -	return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(n) + 1);
> -}
> -
>  static unsigned long to_wait_timeout(s64 timeout_ns)
>  {
>  	if (timeout_ns < 0)
>  		return MAX_SCHEDULE_TIMEOUT;
>=20=20
> -	if (timeout_ns =3D=3D 0)
> -		return 0;
> -
> -	return nsecs_to_jiffies_timeout(timeout_ns);
> +	return drm_timeout_rel_to_jiffies(timeout_ns);
>  }
>=20=20
>  /**

--=20
Jani Nikula, Intel
