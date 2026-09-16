Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05DCC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AFD310E2FB;
	Wed, 16 Sep 2026 13:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fuuoHtm9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C94110E047;
 Wed, 16 Sep 2026 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789566176; x=1821102176;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=lMOHGhqhRC7o8DUWxe2ZtG0eCBNNwQPKpwZSpxZkLjE=;
 b=fuuoHtm9s6pI2tk6MbCFoVhBTpAAc7rhXx/j6mq4mFaC2t4iAM2m7q7I
 ybn2+oK6vANUzZfwdMv/QRRqZFVp26aOw0izFNIFX20+c608BKqB6TFMe
 rKho+tCUDUiKbl8ThnHmAnYdN00+symXe9UT6AMge7IeFkQF9fOwlmIeB
 fHfITYQnJJ0I+63LBkAwwtUaJKyogFnVlvAKh6k+reHHSeKyYcbXnmATs
 J9J7JeE5pipH8GY6vMfTBgeRkGp7zPLxFbQe3pL6dsJdDDkEV046LSK2n
 in4Lmlj1J8s1jzhbx87Si+kDXo7j2bW6P0Ux8WpyQBl016DvuGAWcvIUG w==;
X-CSE-ConnectionGUID: 6bqCOc0QQ1i858/cH0t7uQ==
X-CSE-MsgGUID: dkD2o4U1SYOaWUhtbHqyFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93814094"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93814094"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:42:56 -0700
X-CSE-ConnectionGUID: 33c8L43rQM+N7DHUEOWbWA==
X-CSE-MsgGUID: IuQaeLKrSrK4WNC52PKSyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="303230461"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.154])
 ([10.245.244.154])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:42:55 -0700
Message-ID: <2efce17e1036dae156f0eb3f8abbce98e754d537.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Szymon =?UTF-8?Q?Aceda=C5=84ski?= <accek@invisiblethingslab.com>, 
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com, 
 xen-devel@lists.xenproject.org, stable@vger.kernel.org
Date: Wed, 16 Sep 2026 15:42:52 +0200
In-Reply-To: <20260820101212.1608543-1-accek@invisiblethingslab.com>
References: <20260820101212.1608543-1-accek@invisiblethingslab.com>
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

Hi!

On Thu, 2026-08-20 at 12:12 +0200, Szymon Aceda=C5=84ski wrote:
> Fixes display corruption on Xen PV dom0, where DMA buffers are not

Please use imperative language in commit messages: "Fix display
corruption..."

> guaranteed machine-contiguous, in which case bounce buffering kicks
> in, breaking xe's memory coherency assumptions.
>=20
> Apply the same workaround i915 carries in i915_sg_segment_size()
> since
> commit 78a07fe777c4 ("drm/i915: stop abusing swiotlb_max_segment").
>=20
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Reported-by: Marek Marczykowski-G=C3=B3recki
> <marmarek@invisiblethingslab.com>
> Closes:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8382
> Link: https://lore.kernel.org/xen-devel/aYtznP_tT6xNPwf-@mail-itl/
> Link:
> https://lore.kernel.org/all/20221020110308.1582518-1-hch@lst.de/=C2=A0#
> i915 counterpart
> Cc: stable@vger.kernel.org=C2=A0# v6.8+
> Signed-off-by: Szymon Aceda=C5=84ski <accek@invisiblethingslab.com>

Please also CC the Author of the original i915 patch in case there
are any updates to the validity of this hack. While there is a
precedent in i915 authored by Christoph, the patch really relies
on completely undocumented behaviour....

Otherwise LGTM, Once you have an update I'll forward it to Xe CI.

Thanks,
Thomas


> ---
> =C2=A0drivers/gpu/drm/xe/xe_bo.h | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> index e8081af..152bfcf 100644
> --- a/drivers/gpu/drm/xe/xe_bo.h
> +++ b/drivers/gpu/drm/xe/xe_bo.h
> @@ -9,6 +9,8 @@
> =C2=A0#include <drm/drm_prime.h>
> =C2=A0#include <drm/ttm/ttm_tt.h>
> =C2=A0
> +#include <xen/xen.h>
> +
> =C2=A0#include "xe_bo_types.h"
> =C2=A0#include "xe_ggtt.h"
> =C2=A0#include "xe_macros.h"
> @@ -575,6 +577,23 @@ static inline unsigned int
> xe_sg_segment_size(struct device *dev)
> =C2=A0	struct scatterlist __maybe_unused sg;
> =C2=A0	size_t max =3D BIT_ULL(sizeof(sg.length) * 8) - 1;
> =C2=A0
> +	/*
> +	 * For Xen PV guests pages aren't contiguous in DMA
> (machine) address
> +	 * space.=C2=A0 The DMA API takes care of that both in
> dma_alloc_* (by
> +	 * calling into the hypervisor to make the pages contiguous)
> and in
> +	 * dma_map_* (by bounce buffering).=C2=A0 But xe (like i915, see
> commit
> +	 * 78a07fe777c4) ignores the coherency aspects of the DMA
> API and thus
> +	 * can't cope with bounce buffering actually happening, so
> add a hack
> +	 * here to force small allocations and mappings when running
> in PV
> +	 * mode on Xen.
> +	 *
> +	 * Note this will still break if bounce buffering is
> required for other
> +	 * reasons, like confidential computing hypervisors or PCIe
> root ports
> +	 * with addressing limitations.
> +	 */
> +	if (xen_pv_domain())
> +		return PAGE_SIZE;
> +
> =C2=A0	max =3D min_t(size_t, max, dma_max_mapping_size(dev));
> =C2=A0
> =C2=A0	/*
>=20
> base-commit: b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6
