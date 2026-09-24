Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687E3C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30A510F698;
	Thu, 24 Sep 2026 15:38:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bTBPhELI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF9410F68E
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:38:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A2362601DE;
 Thu, 24 Sep 2026 15:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7021F000FF;
 Thu, 24 Sep 2026 15:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790264334;
 bh=akutNHbzTxDEF9m34BiAHrNOwltYDiuyMm35he8BXEo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bTBPhELIRN3O0FFn8rpkmZEmYBQLN/8ZJX9fWuZ2YU+nsYszze+8Po6E2Jpkx1/U2
 csSAmCdllvo6txJLC5zGIYOQEIRXycEUR2jXLQiZCsxHIWtiRgVdUo8BIveljHW2nQ
 UbCjydyZNZc1l/gbAwQpobRjn0br/M5EesAtxQ67z9UrKC8jsDW8Wx2ZQne4Y4AGls
 INJ91jqLgCH/y0bJchnHu7Ii1zPf9g9rdXPPFTLIz0IMAmVDkydnbNJGdFCibyKJqZ
 RR5RoUM9ekOIuy56k9wImJFfBzeSmO59rpxTjSeQikGWDqnHT0bD5Y7TlHBal8T0IU
 Chd99eqtvZhOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <20260924152159.49702-6-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-6-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:38:53 +0000
Message-Id: <20260924153854.2F7021F000FF@smtp.kernel.org>
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

> This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
> DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
> commit by VFIO's ordinary mmap() path.
>=20
> This function transfers ownership of the VFIO device fd to the
> DMABUF, which fput()s when it's released.
>=20
> Refactor the existing vfio_pci_core_feature_dma_buf() to split out
> export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
> this new VFIO_BAR mmap().
>=20
> By exchanging the VMA file, we lose the original device path in
> /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented synthetic
> 'filename' for BAR mappings based on the BDF, plus resource index.
> (This does not apply to explicitly-exported DMABUFs which are named by
> DMA_BUF_SET_NAME.)
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D5

