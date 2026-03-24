Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B015E9A762
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7900710E669;
	Tue, 24 Mar 2026 11:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f5FLS3aM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5086610E65B;
 Tue, 24 Mar 2026 11:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774350736; x=1805886736;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=1gjBNrZ6P4NBt8zD4oJZQ6r+FwYPsubK9NELuoYgFNE=;
 b=f5FLS3aM49MhTiauIq+gNxkyszZWJCuo5jn8L2qhv/8sqMRj4YQ/Goe5
 ZCE1vsccO3dDvLxIfnn5FDpqf7+u9EdWHCFFUhz44bnnUXO9eZN8HSrf4
 k0rD9CycYE6r0WZnjzg4u87ogxo8c8WiT3loC+FR7jSbLBApe2l3xXQLH
 XLR6SNVn/zfA30ACnhi/Dn2PUkvTquRr0/zuYZ3JEncgzx8bm1wqlqNNw
 i9EuPulhUYX4aWRBRFQtxmZborauTWj5ELRXpVyeTd1YlO/eK2sxrSxAc
 4MIjo/y0lf4oJWnbDEJDSDcxsZj/DmyZgkQBpBEXAaoBEXox4bSZ3Jqjj Q==;
X-CSE-ConnectionGUID: L4GP8l6YQo2YLhgXgmkb2w==
X-CSE-MsgGUID: d4uqi+9WQ0e4LwSLhTfAXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75076501"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75076501"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 04:12:16 -0700
X-CSE-ConnectionGUID: XsK2llDkReyBDvD/wS32Rw==
X-CSE-MsgGUID: KfvNSAcdRxCH9RwrWLBDOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="262247550"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.208])
 ([10.245.244.208])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 04:12:14 -0700
Message-ID: <f1953706e241aff8048d826a262d8258ddc70ec7.camel@linux.intel.com>
Subject: Re: [PATCH] drm/syncobj: Fix xa_alloc allocation flags
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Himanshu Girotra <himanshu.girotra@intel.com>, Matthew Brost
 <matthew.brost@intel.com>
Date: Tue, 24 Mar 2026 12:12:11 +0100
In-Reply-To: <20260324111019.22467-1-tvrtko.ursulin@igalia.com>
References: <20260324111019.22467-1-tvrtko.ursulin@igalia.com>
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

On Tue, 2026-03-24 at 11:10 +0000, Tvrtko Ursulin wrote:
> The xarray conversion blindly and wrongly replaced idr_alloc with
> xa_alloc
> and kept the GFP_NOWAIT. It should have been GFP_KERNEL to account
> for
> idr_preload it removed. Fix it.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: fec2c3c01f1c ("drm/syncobj: Convert syncobj idr to xarray")
> Reported-by: Himanshu Girotra <himanshu.girotra@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> ---
> =C2=A0drivers/gpu/drm/drm_syncobj.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_syncobj.c
> b/drivers/gpu/drm/drm_syncobj.c
> index 250734dee928..8d9fd1917c6e 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -602,7 +602,7 @@ int drm_syncobj_get_handle(struct drm_file
> *file_private,
> =C2=A0	drm_syncobj_get(syncobj);
> =C2=A0
> =C2=A0	ret =3D xa_alloc(&file_private->syncobj_xa, handle, syncobj,
> xa_limit_32b,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_NOWAIT);
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> =C2=A0	if (ret)
> =C2=A0		drm_syncobj_put(syncobj);
> =C2=A0
> @@ -716,7 +716,7 @@ static int drm_syncobj_fd_to_handle(struct
> drm_file *file_private,
> =C2=A0	drm_syncobj_get(syncobj);
> =C2=A0
> =C2=A0	ret =3D xa_alloc(&file_private->syncobj_xa, handle, syncobj,
> xa_limit_32b,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_NOWAIT);
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> =C2=A0	if (ret)
> =C2=A0		drm_syncobj_put(syncobj);
> =C2=A0
