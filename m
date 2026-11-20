Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECD606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kvHozla1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032B0112604;
	Fri, 20 Nov 2026 08:34:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBF210E610;
 Fri, 20 Nov 2026 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795163639; x=1826699639;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=GMyEQJvmq27rqx1T/bFHEkXPkQXd+jF7hs13UOe1t2w=;
 b=kvHozla1xJhx23OnBtWIidfqHmzY/IikwD1OfqlL2piSiN91Z8hBxKH6
 5W3FUl2Vfixi0XXC0SZSkvX1MBzBE7sRd7fWzqyziPE42wibeuKZMgkta
 EjpUvLpU0r6wi5IXyB4Zn/tvWPcsY5SWuHr+CdCeQcjJi8TCgONFsB1xF
 wH0DyLsANLReX95AlplqSFxl7OPttQ7CGxE5TcyVaSQfri1smKcSONl1o
 Cz2pFnWJf35p4QWKiKPZBL+lXS/+t1Y4gUW2AUM+MhsDRUtvq2CZkW4mV
 iBlXYf0FxRc0ZiI9cZuyOmI9lVySyF1TaaEoc8M+53XnQKJnQ4dEkrvKs A==;
X-CSE-ConnectionGUID: 4yG4Qc7GSByhe+zC4f+bGA==
X-CSE-MsgGUID: fcWz6QrTSmSDu+Ep4yuODw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3950686"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3950686"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 00:33:58 -0800
X-CSE-ConnectionGUID: aXEXX1cHRaWdAopq149/8w==
X-CSE-MsgGUID: D26vuOlwRlqmJloPrNm3Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10644733"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.228])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 00:33:55 -0800
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261120024210.1658348-1-lcy8047@gmail.com>
References: <20261120024210.1658348-1-lcy8047@gmail.com>
Subject: Re: [PATCH] drm/i915/gem: Set the VM owner before publishing the VM
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
To: Changyul Lee <lcy8047@gmail.com>, David Airlie <airlied@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Date: Fri, 20 Nov 2026 10:33:52 +0200
Message-ID: <179516363210.27957.16651774665226630199@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Quoting Changyul Lee (2026-11-20 04:42:10)
> i915_gem_vm_create_ioctl() adds the VM to the file's VM table before
> setting its owner (vm.fpriv). A concurrent lookup can therefore see
> the VM without an owner and allocate page tables that are missing
> from the client's memory accounting.

This commit message is just not making any sense.

The ID used in the supposed lookup is returned from this very IOCTL.

> Concurrent VM destruction can
> also free the VM before the owner assignment, causing a write to
> freed memory.

Could you explain in your own terms the call sequence that'll lead to
this?

> Set the owner before inserting the VM into the table with xa_alloc().
> If xa_alloc() fails, err_put still releases the VM.

Very LLM'esque to just explain what the code does to inflate the patch
description.

> Fixes: ca02a0119f81 ("drm/i915: Record which client owns a VM")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>
> ---
> Found with a static analysis tool we are developing.

Unless a competent human developer looked the patches through before
submitting and wrote the patch descriptions, please redirect further
submissions to /dev/null.

Regards, Joonas

>=20
> Compile-tested only, with x86_64_defconfig and W=3D1.
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_context.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/dr=
m/i915/gem/i915_gem_context.c
> index c58ffa5a8fa6..489b221091d1 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -1838,6 +1838,8 @@ int i915_gem_vm_create_ioctl(struct drm_device *dev=
, void *data,
>                         goto err_put;
>         }
> =20
> +       ppgtt->vm.fpriv =3D file_priv;
> +
>         err =3D xa_alloc(&file_priv->vm_xa, &id, &ppgtt->vm,
>                        xa_limit_32b, GFP_KERNEL);
>         if (err)
> @@ -1845,7 +1847,6 @@ int i915_gem_vm_create_ioctl(struct drm_device *dev=
, void *data,
> =20
>         GEM_BUG_ON(id =3D=3D 0); /* reserved for invalid/unassigned ppgtt=
 */
>         args->vm_id =3D id;
> -       ppgtt->vm.fpriv =3D file_priv;
>         return 0;
> =20
>  err_put:
>=20
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> --=20
> 2.43.0
>
