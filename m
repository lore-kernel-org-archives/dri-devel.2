Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F86C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7D410EEC0;
	Thu, 27 Aug 2026 07:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZQuc/Ltz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3688310EECA;
 Thu, 27 Aug 2026 07:29:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0809540250;
 Thu, 27 Aug 2026 07:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FE61F000E9;
 Thu, 27 Aug 2026 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787815770;
 bh=Cfp3DZ35lhqdG5JNhAp2kBeTyi/TLYDcpEsaNs9zzLo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZQuc/LtzpZyHHWMABBYhv9D9z/1lCGNhunD/ebnos4BPy3Qa8RXImPbHR1AMT+iIu
 89OYTZRpbU6TYgSw+4HOGfuQrs/VOxScu/VhWi+DYrTE/OAeDOvzG80WcZ7EDQBrou
 vT9vQgDA0uMYYmuwLjcNz7VB0F6SWZW5MvlnS9HMfqcWvYs+3Pg8diX2R8hVwjDhQc
 QR0jCzJg/gjEAA/SxraDpasboQ6arDmErNN9/AwiX575zrxoTpyKARSCXArY1x6Pud
 9I8AIB1yePo12zN4OIiX3BXxj2eUdwd6xgRov3U1AV87RvybQ/YYYGjoiCk+B+GuS1
 CvP5nrpNv2qww==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 4/5] drm/gpusvm: let drm_gpusvm_get_pages() map
 an array of pages
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260827071449.520398-5-honghuan@amd.com>
References: <20260827071449.520398-1-honghuan@amd.com>
 <20260827071449.520398-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:29:30 +0000
Message-Id: <20260827072930.A9FE61F000E9@smtp.kernel.org>
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
- [High] Device memory mappings are leaked when drm_gpusvm_dma_map_pages() =
fails midway.
--

commit 9ac7ddc26000d29a77c97e82c04194e8d027c3ec
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: let drm_gpusvm_get_pages() map an array of pages

This patch updates drm_gpusvm_get_pages() to take a contiguous array of
drm_gpusvm_pages plus a count. It performs the HMM fault once for the CPU
range and then DMA maps each instance per owning drm_device.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
[ ... ]
> @@ -1727,15 +1765,30 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusv=
m,
>  		goto retry;
>  	}
> =20
> -	err =3D drm_gpusvm_dma_map_pages(gpusvm, svm_pages, pfns, npages, ctx,
> -				       dma_dir);
> -	drm_gpusvm_notifier_unlock(gpusvm);
> -	if (err)
> -		goto err_free;
> +	for (p =3D 0; p < num_pages; ++p) {
> +		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
> +			continue;
> +
> +		err =3D drm_gpusvm_dma_map_pages(gpusvm, &svm_pages[p], pfns,
> +					       npages, ctx, dma_dir);

[Severity: High]
This is a pre-existing issue, but I noticed a potential leak in how
drm_gpusvm_dma_map_pages() handles its error path.

If drm_gpusvm_dma_map_pages() maps one or more device pages successfully bu=
t a
subsequent page fails (for example, yielding -EOPNOTSUPP due to mixed memor=
y,
or -EFAULT from dma_mapping_error), it jumps to err_unmap:

drm_gpusvm_dma_map_pages() {
    ...
err_unmap:
    svm_pages->flags.has_dma_mapping =3D true;
    __drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
    return err;
}

The rollback calls __drm_gpusvm_unmap_pages(), which relies on
svm_pages->dpagemap to invoke device_unmap:

__drm_gpusvm_unmap_pages() {
    ...
            else if (dpagemap && dpagemap->ops->device_unmap)
                dpagemap->ops->device_unmap(dpagemap, dev, addr);
    ...
}

However, svm_pages->dpagemap is only updated at the very end of
drm_gpusvm_dma_map_pages() upon success. During the error path, it is still
NULL.

Can this result in __drm_gpusvm_unmap_pages() silently skipping the unmappi=
ng
of all previously mapped device pages, thereby leaking device mapping
resources?

> +		if (err) {
> +			/*
> +			 * drm_gpusvm_dma_map_pages() already cleaned up the
> +			 * instance that failed. Leave the earlier ones mapped:
> +			 * on -EAGAIN the retry reuses them, on other errors the
> +			 * driver frees them with the range. They may also be
> +			 * used by other drm_devices, so do not unmap them here.
> +			 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827071449.5203=
98-1-honghuan@amd.com?part=3D4
