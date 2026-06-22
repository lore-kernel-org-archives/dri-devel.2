Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B1ACD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D2E8989E;
	Mon, 22 Jun 2026 10:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f6X3eOsu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B298989E;
 Mon, 22 Jun 2026 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782124235; x=1813660235;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=zRe08PDGarrGK1rS5XbKDiCwvzPgMFARTDD9yKpSLqA=;
 b=f6X3eOsuEhToD0xqXquahJVK69GuPjth6X+qtGK5FoBZ/vLDMQjo913w
 4vyF4YyY/t/ZhPHF974UacQRJ6ESujZ5yL8wJa1oEtlAxjkHFN3VMK0x0
 3O8PLFNOFWIu+Iuj/m9mhihC8HP8GgpCeoTwPHM5r51+bm/GD+7QhChJz
 uLCo31DPuxRhZBhi8XRnnQMV5F/u4Xw7luHfZ9LLbDhUDok55Yt7FvFe7
 LvQSAzkfJbZ1lIzzgH4JqCkJ3cGsrFwvOR82GUHlF243YJrHR1D2L2aaJ
 n9Lqa8q/K4uLli1QTITbN/JquwmpFeFpcBedPidkuwsOvJQIsk+DHHbDE A==;
X-CSE-ConnectionGUID: Rrk4lU/QR9OU5taMYpy8yQ==
X-CSE-MsgGUID: nzzzJQj3QmWTQcHfx9YUgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82735022"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="82735022"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 03:30:35 -0700
X-CSE-ConnectionGUID: qJk5kaPdQ/W8xWa3tB1NUg==
X-CSE-MsgGUID: 1gXiJV1ES9SJ+MWG3jbnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="249293869"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.245.69])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 03:30:33 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260617152500.108597-1-jose.souza@intel.com>
References: <20260617152500.108597-1-jose.souza@intel.com>
Subject: IOCTL feature detection #2 (Was: Re: [PATCH v2] drm/xe/uapi: Add flag
 to tell if VM_GET_PROPERTY_FAULTS is supported)
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
To: =?utf-8?q?Jos=C3=A9?= Roberto de Souza <jose.souza@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Simona Vetter <simona@ffwll.ch>
Date: Mon, 22 Jun 2026 13:30:29 +0300
Message-ID: <178212422953.110786.15960772731280455512@jlahtine-mobl>
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

(+ Sima and dri-devel)

This goes very much against the previously discussed and agreed
direction[1].

The QUERY style IOCTL (like xe_vm_get_property_ioctl here) were specifically
designed to have built-in feature-checking to avoid need for anything
like this check.

Executing the query with size zero would be a pretty much no-overhead
call (there's one spinlock there) as we can see from the body of
xe_vm_get_property_helper:

	if (!args->size) {
		args->size =3D size;
		return 0;
	}

That trait got added to the QUERY style IOCTLs exactly to address the
requirement for low-overhead feature checking by Mesa folks back then.

So you execute all the validity checks, but avoid actual data copying.

Quoting Jos=C3=A9 Roberto de Souza (2026-06-17 18:25:00)
> Not all Xe versions or Xe-supported devices support this feature, so this
> flag is required to make the UMD's life easier.
>=20
> v2:
> - DRM_XE_QUERY_CONFIG_FLAG_HAS_VM_GET_PROPERTY_FAULTS should be set on
> info[DRM_XE_QUERY_CONFIG_FLAGS].
>=20
> Signed-off-by: Jos=C3=A9 Roberto de Souza <jose.souza@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_query.c | 4 ++++
>  include/uapi/drm/xe_drm.h     | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
> index dc975f595368..f187a264756a 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
> @@ -354,6 +354,10 @@ static int query_config(struct xe_device *xe, struct=
 drm_xe_device_query *query)
>                 DRM_XE_QUERY_CONFIG_FLAG_HAS_DISABLE_STATE_CACHE_PERF_FIX;
>         config->info[DRM_XE_QUERY_CONFIG_FLAGS] |=3D
>                 DRM_XE_QUERY_CONFIG_FLAG_HAS_PURGING_SUPPORT;
> +       if (xe->info.has_usm) {
> +               config->info[DRM_XE_QUERY_CONFIG_FLAGS] |=3D
> +                       DRM_XE_QUERY_CONFIG_FLAG_HAS_VM_GET_PROPERTY_FAUL=
TS;
> +       }

I think it kind of proves the validness of concerns in [1] that the
has_usm check you add here doesn't have much relevance to the actual
VM_GET_PROPERTY_FAULTS IOCTL being available or functional.

If you think the VM_GET_PROPERTY_FAULTS should be gated by the has_usm
condition, then you should have updated the actual IOCTL, no?

The whole point of the original discussions resulting in [1] was that
it is such an easy error to make the capability flag check and the
actual IOCTL availability differ that it should be avoided.

The fact that such an error is in this very patch still after reading
through the original reasoning from Sima kind of underlines why the
point still stands strongly.

Regards, Joonas

[1] https://www.spinics.net/lists/intel-gfx/msg325342.html
