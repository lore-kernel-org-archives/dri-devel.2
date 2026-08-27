Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD359C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E822010E3B9;
	Thu, 27 Aug 2026 07:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AyG4OnWC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36F810E3B9;
 Thu, 27 Aug 2026 07:26:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44E1B411FC;
 Thu, 27 Aug 2026 07:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FFA1F000E9;
 Thu, 27 Aug 2026 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787815584;
 bh=7lnsPDPuMMvJ48/M6q5itvlgOef7B/IaxDSacIMpRRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AyG4OnWCjFLMvrsshutSypwsEIXGr2Gv+VBrrznS8p6DQHmEhSrVzCrAvLVx3ySWH
 /zD5atm6fiDTzg1cdiYwXwmBySdwM8YBjhJRd22I0eA8p6NLQsYgVDPjaAyNHsf+nO
 2AcGWDOdIzWac0sriZ8CxNMpHpQmt4xO1ntBvRdJw0oR/M2/8YduAglGe/JMCV6TKI
 1KAd7Dqu+3Y8EVA33gdh2u9U/KbnpcusbuM8wUDZhacUXiR/KULVhIzX15+k/xf/5k
 Yv6aQWm1AELLM22/nQwOdPMTMW2nbnefiNIOa8Z0GSLJOWK9s5XGWKLbLLQTrIaLOd
 iVPHyg8VoT6PA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 3/5] drm/gpusvm: extract
 drm_gpusvm_dma_map_pages() helper
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260827071449.520398-4-honghuan@amd.com>
References: <20260827071449.520398-1-honghuan@amd.com>
 <20260827071449.520398-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:26:23 +0000
Message-Id: <20260827072623.E5FFA1F000E9@smtp.kernel.org>
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
- [High] Device memory mappings are permanently leaked on the error path du=
e to deferred assignment of svm_pages->dpagemap
--

commit 09830ce1d99e5366614becf544e5d523ceeb461d
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: extract drm_gpusvm_dma_map_pages() helper

This commit moves the per-device DMA mapping loop of drm_gpusvm_get_pages()
into a helper drm_gpusvm_dma_map_pages(). The mapping logic is only moved,
not changed, so there is no functional change.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 3496cb5688365..753361b965cf9 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
[ ... ]
> @@ -1695,17 +1631,114 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpus=
vm,
>  	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
>  	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
> =20
> +	return 0;
> +
> +err_unmap:
> +	svm_pages->flags.has_dma_mapping =3D true;
> +	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);

[Severity: High]
This is a pre-existing issue, but does this code permanently leak device
memory mappings on the error path?

When a device page is successfully mapped in drm_gpusvm_dma_map_pages(),
dpagemap->ops->device_map() is used. However, svm_pages->dpagemap is only
updated at the end of the function upon complete success.

If an error occurs on a subsequent page (such as returning -EOPNOTSUPP
due to encountering a mixed device memory mapping), the code jumps to
err_unmap and calls __drm_gpusvm_unmap_pages().=20

Because svm_pages->dpagemap is still NULL at this point, the unmap helper
will skip the cleanup callback:

drivers/gpu/drm/drm_gpusvm.c:__drm_gpusvm_unmap_pages() {
    ...
    struct drm_pagemap *dpagemap =3D svm_pages->dpagemap;=20
    ...
    else if (dpagemap && dpagemap->ops->device_unmap)
        dpagemap->ops->device_unmap(...)
    ...
}

Should the local dpagemap be temporarily assigned to svm_pages->dpagemap
before calling the unmap helper, or is there another way to ensure these
partially mapped pages are properly cleaned up?

> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827071449.5203=
98-1-honghuan@amd.com?part=3D3
