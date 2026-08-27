Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1B7C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF0A10EF94;
	Thu, 27 Aug 2026 10:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AICDHbc1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5DC10EF90;
 Thu, 27 Aug 2026 10:30:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83707408EB;
 Thu, 27 Aug 2026 10:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C5A1F000E9;
 Thu, 27 Aug 2026 10:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787826649;
 bh=e2cYiJIWkd2pG8ZWMzUGU4h/KCpBplw9IeeQQpgbgV0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AICDHbc1Cp+d8xiJxFjgaDU/+RCgeSvI20cHhuCcp9Zo/Aw2S+S894AnQFMh5El+4
 2dLdbfS79G5pMTIdFb3uTDBuJnpdPKX4ebi1427Isnqxb+BE6ENPbURxr/c8TD2D3S
 JZQIYxwZK2u43UCZZpIIfKE8Eop66gXNqQZTf11Z+z7VLBIlvEOFElOxSyEiGIcFSY
 50bQNEYSBeRgLs1+cD2luk/EyEYmU9OlpnClISeEMQRuUkKSOGBlDvTJSE0VilelOf
 rBGq2QjfpYqvgyGHaCKTVkgy7IEaZ3Z7BlaQkrm3/hsude9rsrCqOkNo3fdmOd0SET
 tRPzB9NyMnyrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] drm/xe: Reuse one dummy page per BO after wedge
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260827101801.1247654-7-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-7-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 10:30:48 +0000
Message-Id: <20260827103049.31C5A1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded VMA prefaulting loop causes CPU starvation and soft lock=
ups.
--

commit 359edbd46613b71dc869a156d98f9fb5a002a599
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe: Reuse one dummy page per BO after wedge

This commit replaces the allocation of a dummy page on every call to
ttm_bo_vm_dummy_page() with a single zeroed page kept per BO. It maps the
faulting address first and then prefaults the rest of the VMA as a best-eff=
ort
optimization.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index b86cd6030ed6b..1f6ea9f5afe62 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -2080,6 +2083,50 @@ static vm_fault_t xe_bo_cpu_fault_fastpath(struct =
vm_fault *vmf, struct xe_devic
>  	return ret;
>  }
> =20
> +static vm_fault_t xe_bo_vm_dummy_page(struct vm_fault *vmf, struct xe_bo=
 *bo)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
[ ... ]
> +	/* The faulting address must be mapped successfully. */
> +	ret =3D vmf_insert_pfn_prot(vma, vmf->address, pfn,
> +				  vma->vm_page_prot);
> +	if (ret & VM_FAULT_ERROR)
> +		return ret;
> +
> +	/* Prefault the remaining VMA as a best-effort optimization. */
> +	for (address =3D vma->vm_start; address < vma->vm_end;
> +	     address +=3D PAGE_SIZE) {

[Severity: High]
This is a pre-existing issue, but does this unbounded loop risk causing CPU
starvation and soft lockups?

When a user allocates and mmaps a very large BO, and the device becomes
wedged, a page fault will call xe_bo_cpu_fault() and trigger this path in
xe_bo_vm_dummy_page(). For huge buffer objects (e.g., tens of gigabytes),
iterating millions of times to insert PTEs without yielding points or signal
checks can cause severe CPU starvation and watchdog soft lockups. This can
also make the faulting task temporarily unkillable while stalling concurrent
mmap_write_lock() requests.

This behavior was inherited from ttm_bo_vm_dummy_page(), but should this
loop be bounded or conditionally yield?

> +		if (address =3D=3D vmf->address)
> +			continue;
> +
> +		prefault_ret =3D vmf_insert_pfn_prot(vma, address, pfn,
> +						   vma->vm_page_prot);
> +		if (prefault_ret & VM_FAULT_ERROR)
> +			break;
> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827101801.1247=
654-1-arvind.yadav@intel.com?part=3D6
