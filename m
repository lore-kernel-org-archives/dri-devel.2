Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE278C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09AE310E232;
	Mon, 21 Sep 2026 06:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wtk5edny";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF47A10E1E0;
 Mon, 21 Sep 2026 06:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789972260; x=1821508260;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=HtBwz7MpjVfsvm3vZY/Sk05dMHNZT6Od24wsVNFrNxk=;
 b=Wtk5edny4RduoWLcZxji1Oinn7JvOrHt/fpj1g75iCkUJkXoBeSY0w6m
 7cnz7TrmmxffWzbv7ogfQw4Ai9gMlWPupli+UyaWFGu0c17j7FDmDyd+5
 44V8lhBL5+0c78EqsuWTyL/lP29rBwcfZ/OvZFfLwgEHrCkW5fLbSSzk+
 hIn8TmsoaTHJzFMfDInTdao+N951/4X7vksy0WnOrhcz90KNrXD/+Ld/9
 Jub3oM+zeSIbw5Z11o+A7LhhTkS+sfvSnQHQdb+q2V+I0CPARtIKwswcf
 iLtikAPbBBWGOE/pKqBeJLYU9pmdW/wuBsF/B1NKEHgbw9OPz8fJrXPRT w==;
X-CSE-ConnectionGUID: KzO6NTyJQoCJbpB2shnidA==
X-CSE-MsgGUID: B42YPWZzR3iyFxmQPaYJFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="971839"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="971839"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:30:59 -0700
X-CSE-ConnectionGUID: WdnO2D4rQri/9a2FF6dXig==
X-CSE-MsgGUID: nX8TpcC+Q0+GS22QJVfQWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="300460814"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.142])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:30:56 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260919171710.3699710-1-lgs201920130244@gmail.com>
References: <20260919171710.3699710-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] drm/i915: fix mock ring memory leak on context allocation
 failure
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>, David Airlie <airlied@gmail.com>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 09:30:49 +0300
Message-ID: <178997224953.20141.15039837012698810465@jlahtine-mobl>
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

Quoting Guangshuo Li (2026-09-19 20:17:10)
> mock_context_alloc() creates ce->ring before allocating and pinning the
> context timeline. mock_ring() initializes the ring reference count and
> returns the initial reference to the context.
>=20
> If intel_timeline_create() fails, mock_context_alloc() returns without
> dropping the ring reference. The same leak occurs when
> mock_timeline_pin() fails after the timeline has been created. Since
> context allocation did not complete, CONTEXT_ALLOC_BIT is not set and
> the later context teardown does not release the ring.
>=20
> Drop the initial ring reference with kref_put() on both failure paths.
> When the reference count reaches zero, intel_ring_free() releases the
> ring VMA and frees the ring allocation. Clear ce->ring after dropping
> the reference to avoid retaining a stale pointer.
>=20
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>=20
> Fixes: 75d0a7f31eec ("drm/i915: Lift timeline into intel_context")
> Cc: stable@vger.kernel.org

We're not going to put Fixes and especially not Cc stable in
for selftests.

You should use onion teardown idiom instead of duplicating code.

Commit message also reeks of LLM generation as an average developer
doesn't need "explain to me like I have never programmed before".

Regards, Joonas

> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/i915/gt/mock_engine.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/gt/mock_engine.c b/drivers/gpu/drm/i915=
/gt/mock_engine.c
> index 79741f043f03..fa4368730d33 100644
> --- a/drivers/gpu/drm/i915/gt/mock_engine.c
> +++ b/drivers/gpu/drm/i915/gt/mock_engine.c
> @@ -170,6 +170,8 @@ static int mock_context_alloc(struct intel_context *c=
e)
> =20
>         ce->timeline =3D intel_timeline_create(ce->engine->gt);
>         if (IS_ERR(ce->timeline)) {
> +               kref_put(&ce->ring->ref, intel_ring_free);
> +               ce->ring =3D NULL;
>                 kfree(ce->engine);
>                 return PTR_ERR(ce->timeline);
>         }
> @@ -178,6 +180,8 @@ static int mock_context_alloc(struct intel_context *c=
e)
>         if (err) {
>                 intel_timeline_put(ce->timeline);
>                 ce->timeline =3D NULL;
> +               kref_put(&ce->ring->ref, intel_ring_free);
> +               ce->ring =3D NULL;
>                 return err;
>         }
> =20
> --=20
> 2.43.0
>
