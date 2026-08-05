Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E549BC55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4230F10E1C5;
	Wed,  5 Aug 2026 08:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HGZh48ie";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF90010E1C5;
 Wed,  5 Aug 2026 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785919830; x=1817455830;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=Cv25upHpUp/Swr3Y8wPSp3npw/ImL4eZcWFzljZv1cE=;
 b=HGZh48ieIgJWg41zM75V+JyXHZpdcsqTnwA/qp6Vs00x9pY/QXqcq/uP
 x2dYydYhdE3egPtI2bCvgic0M3N1AwwzV0GOE/P8kZnRXfE4jRSVOjog1
 jsFEHsUG/EKgg4F/FqapVU2etaoBW73neS5rkkvKV0cYbPKcMKtYtuSpt
 dyb95sfbecw/pp8nrA2ZZ5Bw26A+eg/QzjeU0ayEDUKw5UWLhPGOhTyPH
 2krHivk9k31PrU35Q4UiFd5NTx2uw+WKQYtwa5x+Zq8YGpHT4EMVmwkxt
 1l6BW7rBOwDJa9G/ytHcoa0WY7vFYyTku8hILSTg+ZwGpp54GE5d+9A/M Q==;
X-CSE-ConnectionGUID: SYUumNRJSXqvswFmvP/iZA==
X-CSE-MsgGUID: X1hW6jcrQo2gmy5cQb8SfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96841477"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="96841477"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 01:50:29 -0700
X-CSE-ConnectionGUID: Hpt7A5tFQyScsJg+tqED/Q==
X-CSE-MsgGUID: G1hOLmvuTdGhGwGBPRSm+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="261811840"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.40])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 01:50:25 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260728054152.140524-1-zhaojinming@uniontech.com>
References: <20260728054152.140524-1-zhaojinming@uniontech.com>
Subject: Re: [PATCH v2] drm/i915/userptr: Fix user pages leak on get_pages
 failure
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kees Cook <kees@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 ZhaoJinming <zhaojinming@uniontech.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 ZhaoJinming <zhaojinming@uniontech.com>, dri-devel@lists.freedesktop.org
Date: Wed, 05 Aug 2026 11:50:22 +0300
Message-ID: <178591982239.30698.15708833006428973734@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

Adding Maarten and Matt for below discussion points.

Quoting ZhaoJinming (2026-07-28 08:41:52)
> When ____i915_gem_object_get_pages() fails inside
> i915_gem_object_userptr_submit_init(), the pvec containing pages
> pinned by pin_user_pages_fast() was never freed:
>=20
> 1. obj->userptr.pvec was set to the pinned pages
> 2. The local pvec variable was NULLed
> 3. ____i915_gem_object_get_pages() failed, but its internal
>    i915_gem_object_userptr_drop_ref() only decremented page_ref
>    from 2 to 1, not triggering the pvec cleanup
> 4. The unconditional obj->userptr.page_ref-- brought page_ref
>    to 0, but the pinned pages remained referenced only by
>    obj->userptr.pvec with no path to reclaim them
>=20
> Additionally, the cache hit path could return success on a
> subsequent call despite page_ref being 0, leading to a
> GEM_BUG_ON(obj->userptr.page_ref < 0) crash in drop_ref when
> the pages were eventually invalidated.

That's a very verbose way of saying that error handling is missing
for ____i915_gem_object_get_pages failures here.

> Fix by calling i915_gem_object_userptr_drop_ref() on the
> get_pages failure path, which properly decrements page_ref
> from 1 to 0, triggering the pvec cleanup. Make the page_ref--
> after the if block conditional on success, since drop_ref
> already handles the refcount on failure.

Not sure that is the right fix, seems that i915_gem_userptr_get_pages
is rigged in a way that in the intro page_ref >=3D 1 is required, and is
unconditionally increased (becomes >=3D 2), then on error path drop_ref is
called which will unconditionally decrease but never free because page_ref
always remains at least 1. I think that is the real bug which is being pape=
red
over here. Maarten, am I missing something?

This seems to be introduced by commit:

	ed29c2691188 ("drm/i915: Fix userptr so we do not have to worry about obj-=
>mm.lock, v7.")

As for the original report, lack of error handling seems to be introduced
by commit:

	b4b9731b02c3 ("drm/i915: Simplify userptr locking")

The commit message goes on to explain it a little bit, but this chunk from
original patch still seems quite odd?

-------------------------- 8< -------------------------- =20
@@ -341,12 +317,14 @@ int i915_gem_object_userptr_submit_init(struct drm_i9=
15_gem_object *obj)
        if (!obj->userptr.page_ref++) {
                obj->userptr.pvec =3D pvec;
                obj->userptr.notifier_seq =3D notifier_seq;
-
                pvec =3D NULL;
+               ret =3D ____i915_gem_object_get_pages(obj);
        }
=20
+       obj->userptr.page_ref--;
+
 out_unlock:
-       spin_unlock(&i915->mm.notifier_lock);
+       i915_gem_object_unlock(obj);
=20
 out:
        if (pvec) {
-------------------------- 8< -------------------------- =20

Regards, Joonas

>=20
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/dr=
m/i915/gem/i915_gem_userptr.c
> index 043095f93ac6..7d2750528485 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -292,9 +292,12 @@ int i915_gem_object_userptr_submit_init(struct drm_i=
915_gem_object *obj)
>                 obj->userptr.notifier_seq =3D notifier_seq;
>                 pvec =3D NULL;
>                 ret =3D ____i915_gem_object_get_pages(obj);
> +               if (ret)
> +                       i915_gem_object_userptr_drop_ref(obj);
>         }
> =20
> -       obj->userptr.page_ref--;
> +       if (!ret)
> +               obj->userptr.page_ref--;
> =20
>  out_unlock:
>         i915_gem_object_unlock(obj);
> --=20
> 2.20.1
>
