Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811BCC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB62910F66F;
	Thu, 24 Sep 2026 15:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jlGMvFMh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D1C10F66F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:34:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D95A601DE;
 Thu, 24 Sep 2026 15:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CB11F000FF;
 Thu, 24 Sep 2026 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790264061;
 bh=az7xxfOSK3d7joncT9mggFE1+UrHB7sT8pFuodahjII=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jlGMvFMhOQ/royNRBsJE1AzE6EFZnpSugaXsY9pSyNDNx+Opa1coatYKIZU+sVWi+
 rjweNpyTtcLq8k32gJB9ukF7ALzlKMw+dJZk/0WHjmjnnxMlrtPCnteEEAkhMAgUBg
 41MKL5u2DBDcUg9gBU55tfjDTyvq32illNz5qbh6MHSpMi2vhlA+SNqyOMwF9N95ZC
 zAYreI66RZtAa3KvrRYbU503ni/Fkq8gAPBVXm9Ijx9MRN/NrNneGk8O25/SN0uKtv
 04nx2G1zAj5gqxzT/JnCSi9JI3coWcG3TfdyC8IK6gaSVtgXFJUxED8x31h9vcnkMx
 X8FuVKXTBdrKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] vfio/pci: Convert BAR mmap() to use a DMABUF
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260924152159.49702-7-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-7-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:34:20 +0000
Message-Id: <20260924153421.77CB11F000FF@smtp.kernel.org>
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

> Convert the VFIO device fd fops->mmap to create a DMABUF representing
> the BAR mapping, and make the VMA fault handler look up PFNs from the
> corresponding DMABUF.  This supports future code mmap()ing BAR
> DMABUFs, and iommufd work to support Type1 P2P.
>=20
> First, vfio_pci_core_mmap() uses the new
> vfio_pci_core_mmap_prep_dmabuf() helper to export a DMABUF
> representing a single BAR range.  Then, the vfio_pci_mmap_huge_fault()
> callback is updated to understand revoked buffers, and uses the new
> vfio_pci_dma_buf_find_pfn() helper to determine the PFN for a given
> fault address.
>=20
> Now that the VFIO DMABUFs can be mmap()ed, vfio_pci_dma_buf_move()
> zaps PTEs (used on the revocation and cleanup paths).
>=20
> CONFIG_VFIO_PCI_CORE now unconditionally selects
> CONFIG_DMA_SHARED_BUFFER.  The CONFIG_VFIO_PCI_DMABUF feature
> conditionally includes support for VFIO_DEVICE_FEATURE_DMA_BUF,
> depending on the availability of CONFIG_PCI_P2PDMA.
>=20
> When the DMABUF feature is not present, DMABUFs are used internally
> for the BAR mappings.  In this case, DMABUF attach is prohibited (and
> the requirement for a P2PDMA provider is relaxed).
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D6

