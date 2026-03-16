Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0983F46433
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8D510E2ED;
	Mon, 16 Mar 2026 09:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E+lB3Z3U";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99A610E2ED;
 Mon, 16 Mar 2026 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773653545; x=1805189545;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=NrY9iylBVBfPlaka58Q5PtZv0KUqV0CEp1PxVWzR96k=;
 b=E+lB3Z3UVX7zBlrzsUy9jasrNPuOxKurxvWzabAAKkx3svbasR2CpcY5
 22yVeacwkQchfcfHhQ+zqjHXRT0Y5xVBhR9Q3CCo5OI1k4ZfEOUpO/J5M
 D8m8skn6r+iOunBJ1eXIMeevzhFXT/9W0NbKGaRbiy4n3qnqI2U5XJFBo
 NJTcoczmBc7ynbq9Ut4NEBVIQtSU+r0ZBnpKiMMWda+jkN3Q/zh1D8nCu
 oLptBZ+bkZu1bS/4nWoXGpbZaTXWL3O+TaKs+DWgHb9cKgSxzQ/WwDkIi
 3Rr4PmEotJhR2ptRngMYWWKWLNvhOzGNkfHJtr2zuG/FKsBUyD0Z23IBL A==;
X-CSE-ConnectionGUID: JOk5qO2jQC+4TrQ6FR8rpA==
X-CSE-MsgGUID: qrd7+k6sTZWPtuQjxoOFtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74637084"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74637084"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 02:32:25 -0700
X-CSE-ConnectionGUID: yN61M7R1SUmy17pR6CT1gg==
X-CSE-MsgGUID: Uu5Kwo0kS8yR1IgwJU52hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="216403736"
Received: from zzombora-mobl1.ger.corp.intel.com (HELO [10.245.244.233])
 ([10.245.244.233])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 02:32:23 -0700
Message-ID: <0c1376275156c4a1392f9e19a20b78184c27cfc5.camel@linux.intel.com>
Subject: Re: [PATCH v3] drm/pagemap_util: Ensure proper cache lock
 management on free
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>, 
 dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, 
 intel-xe@lists.freedesktop.org, matthew.brost@intel.com, 
 maarten.lankhorst@linux.intel.com
Date: Mon, 16 Mar 2026 10:32:05 +0100
In-Reply-To: <20260306154322.60120-2-jonathan.cavitt@intel.com>
References: <20260306154322.60120-2-jonathan.cavitt@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Fri, 2026-03-06 at 15:43 +0000, Jonathan Cavitt wrote:
> Static analysis issue:
>=20
> Though probably unnecessary given the cache is being freed at this
> step,
> for the sake of consistency, ensure that the cache lock is always
> unlocked after drm_pagemap_cache_fini.
>=20

Typically you don't start the commit message with the tool that found
it, like "fixing an error found by checkpatch.pl" or something similar,
but rather mention it at the bottom after explaining the fix and its
implications.

Also I'd skip the "Though probably unnecessary..." sentence. Spinlocks
typically disable preemption and if the code-path missing the unlock is
hit, preemption will remain disabled even if the lock is subsequently
freed.

Fix looks good, so with the commit message fixed,

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> v2:
> - Use requested code flow (Maarten)
>=20
> v3:
> - Clear cache->dpagemap (Matt Brost, Maarten)
>=20
> Fixes: 77f14f2f2d73f ("drm/pagemap: Add a drm_pagemap cache and
> shrinker")
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
> =C2=A0drivers/gpu/drm/drm_pagemap_util.c | 14 +++++---------
> =C2=A01 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_pagemap_util.c
> b/drivers/gpu/drm/drm_pagemap_util.c
> index 14ddb948a32e..6111d90a38e2 100644
> --- a/drivers/gpu/drm/drm_pagemap_util.c
> +++ b/drivers/gpu/drm/drm_pagemap_util.c
> @@ -65,18 +65,14 @@ static void drm_pagemap_cache_fini(void *arg)
> =C2=A0	drm_dbg(cache->shrinker->drm, "Destroying dpagemap
> cache.\n");
> =C2=A0	spin_lock(&cache->lock);
> =C2=A0	dpagemap =3D cache->dpagemap;
> -	if (!dpagemap) {
> -		spin_unlock(&cache->lock);
> -		goto out;
> -	}
> +	cache->dpagemap =3D NULL;
> +	if (dpagemap && !drm_pagemap_shrinker_cancel(dpagemap))
> +		dpagemap =3D NULL;
> +	spin_unlock(&cache->lock);
> =C2=A0
> -	if (drm_pagemap_shrinker_cancel(dpagemap)) {
> -		cache->dpagemap =3D NULL;
> -		spin_unlock(&cache->lock);
> +	if (dpagemap)
> =C2=A0		drm_pagemap_destroy(dpagemap, false);
> -	}
> =C2=A0
> -out:
> =C2=A0	mutex_destroy(&cache->lookup_mutex);
> =C2=A0	kfree(cache);
> =C2=A0}
