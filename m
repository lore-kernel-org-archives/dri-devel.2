Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0820DF436B0
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379B410EA5D;
	Fri, 17 Apr 2026 14:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SN/ayw83";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CBF10EA5D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776436895; x=1807972895;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=eAb+krYMb86QMqYjzcyQZaBSVQN46MsY45tI8cVVwaY=;
 b=SN/ayw83C49O7jYnu4mwg8IDrmaSbAf8WDGts75+IhkPgHzp9iZEPQJf
 gNrb8PKDtqy5a+DmsvMkCJOsV/cccnEwQo1LNAwziDUUucm9KcLLYrA9A
 Ev6LFzzQt1rTVEzqRpISoBf8xavxy2OfZuE+MxO49jrranFdIxEqZSQps
 7nLvruyTI+RoZ3Ws/PjHORjJ2uQxK1ZU1LEbq8UDU9iYAI/SxCUWOWgCc
 E5uDZaWJAbNjz+8QhTlJKapSJMVcqE2UwZfu1hB7Du8wmD7LTMiOroWse
 Dik10AqY8PBownfP6NULllPNq+Rn6xh1FKUtXjg7cvsNkc5BhyjCoiTcK w==;
X-CSE-ConnectionGUID: Aot8QO+QTFSfiIkyF4SO9Q==
X-CSE-MsgGUID: yhpPLj5kSzmRT86Fl0CdgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81330445"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="81330445"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 07:41:34 -0700
X-CSE-ConnectionGUID: WptBuJtQRTqqkX4L3rOHRA==
X-CSE-MsgGUID: ePi5+JnPTuKvC/gsjHzWpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="227916104"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.184])
 ([10.245.245.184])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 07:41:32 -0700
Message-ID: <544c97fe296f39da35e5349ba1fc0af05f2ff643.camel@linux.intel.com>
Subject: Re: [PATCH] drm/gpuvm: take refcount on DRM device
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Fri, 17 Apr 2026 16:41:29 +0200
In-Reply-To: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
References: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
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

Hi,

On Thu, 2026-04-16 at 13:10 +0000, Alice Ryhl wrote:
> Currently GPUVM relies on the owner implicitly holding a refcount to
> the
> drm device, and it does not implicitly take a refcount on the drm
> device. This design is error-prone, so take a refcount on the device.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

This is problematic since typically you also need a module reference
when taking a drm device reference.

The reason for this is that the devres reference on the drm device
expects to be the last one, since it might be called from the module
exit function of the driver. Now if there is an additional reference
held at that point the driver module can be unloaded with a dangling
reference to the drm device.

On the other hand, if you in addition take a module reference then that
blocks the driver module from being unloaded while held, just like a
drm file reference. This leads to complicated module release schemes
like the one in drm_pagemap where the module refcount is released from
a work item that is waited on in the drm_pagemap exit function.

I'm working to lift the module refcount requirement, but meanwhile I'd
recommend that in the file close callback, we'd make sure all
drm_gpuvms have called their drm_gpuvm_free() function, because then we
are sure that the drm_device is still alive and the module still
pinned.

Thanks,
Thomas


> ---
> =C2=A0drivers/gpu/drm/drm_gpuvm.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gpuvm.c
> b/drivers/gpu/drm/drm_gpuvm.c
> index 44acfe4120d2..000e7910a899 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -25,6 +25,7 @@
> =C2=A0 *
> =C2=A0 */
> =C2=A0
> +#include <drm/drm_drv.h>
> =C2=A0#include <drm/drm_gpuvm.h>
> =C2=A0#include <drm/drm_print.h>
> =C2=A0
> @@ -1117,6 +1118,7 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const
> char *name,
> =C2=A0	gpuvm->drm =3D drm;
> =C2=A0	gpuvm->r_obj =3D r_obj;
> =C2=A0
> +	drm_dev_get(drm);
> =C2=A0	drm_gem_object_get(r_obj);
> =C2=A0
> =C2=A0	drm_gpuvm_warn_check_overflow(gpuvm, start_offset, range);
> @@ -1160,13 +1162,15 @@ static void
> =C2=A0drm_gpuvm_free(struct kref *kref)
> =C2=A0{
> =C2=A0	struct drm_gpuvm *gpuvm =3D container_of(kref, struct
> drm_gpuvm, kref);
> +	struct drm_device *drm =3D gpuvm->drm;
> =C2=A0
> =C2=A0	drm_gpuvm_fini(gpuvm);
> =C2=A0
> -	if (drm_WARN_ON(gpuvm->drm, !gpuvm->ops->vm_free))
> +	if (drm_WARN_ON(drm, !gpuvm->ops->vm_free))
> =C2=A0		return;
> =C2=A0
> =C2=A0	gpuvm->ops->vm_free(gpuvm);
> +	drm_dev_put(drm);
> =C2=A0}
> =C2=A0
> =C2=A0/**
>=20
> ---
> base-commit: 126c50bc2fb6ddfe5b7718de67bbd7592a1062bb
> change-id: 20260416-gpuvm-drm-dev-get-5ded89c39bb3
>=20
> Best regards,
