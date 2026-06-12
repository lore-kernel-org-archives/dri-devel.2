Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54620CD98D9
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 428FB10EAC5;
	Fri, 12 Jun 2026 16:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Iq1fkRD5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B919C10EAC1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:46:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6401340107;
 Fri, 12 Jun 2026 16:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9AD1F00A3D;
 Fri, 12 Jun 2026 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781282789;
 bh=mtAVy1u9/Zaxp8fZzeySoG/NXQhWeHkmxw4ZYwc18h0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Iq1fkRD5fsi52Iu8j41RWp9eW1YhJbCuz6c9ZOGid4FaksVuvdm8Klp44Kx4U2X8o
 k6gtTxiG+GRCwB9zo9fJ2PuuiNKeHl4Kx/tyv2RPm6DM2Nafhe17lejeweh4nfKJq4
 0Ap6tWdIful6sA6Ayt4VAVl2mEN1vR4I/5QSv5f0oJwtVsEdk/Rdw0lzaJsWgCUIyz
 EkbFxaS/U7emSSPdt+lfFpWgBHoFTjXGasL8ssm5GvAUWitrBml7hDdV1Xf4ITm9bO
 XUF0OC7AqzxImcH8iDNGSEv71QuAk6lklbbFpj/mknMI3oZJfC2TaOD58uzuzwDrLt
 yqXMiqyOHboWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260611161546.4075580-5-zhipingz@meta.com>
References: <20260611161546.4075580-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:46:28 +0000
Message-Id: <20260612164629.0D9AD1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional validation of the flag-gated `ph` parameter outsid=
e its flag gate.
- [Medium] VFIO_DEVICE_FEATURE_PROBE incorrectly reports that the DMA_BUF_T=
PH feature is supported for devices that lack TPH completer capabilities.
--

commit cadaa92f5a8da2be3b081b506699064b7bf68059
Author: Zhiping Zhang <zhipingz@meta.com>

vfio/pci: implement get_tph and DMA_BUF_TPH feature

Implement dma-buf get_tph for vfio-pci exported dma-bufs and add
VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
for a VFIO-owned device.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 1a177ce7de546..0a0705c8dbea6 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c

[ ... ]

> @@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
>  	return ret;
>  }
> =20
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf_tph set_tph;
> +	struct vfio_pci_dma_buf *priv;
> +	struct dma_buf *dmabuf;
> +	u8 comp;
> +	int ret;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(set_tph));
> +	if (ret !=3D 1)
> +		return ret;

[Severity: Medium]
Will VFIO_DEVICE_FEATURE_PROBE incorrectly report that the feature is
supported on all devices?

vfio_check_feature() returns 0 for probe requests, which means this code
will return 0 (success) before checking the hardware's TPH completer
capabilities below. Should the hardware capability check happen before
returning the probe result?

> +
> +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> +		return -EFAULT;
> +
> +	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> +		return -EINVAL;
> +
> +	if (set_tph.ph & ~0x3)
> +		return -EINVAL;

[Severity: Medium]
Does this code reject valid clear requests if the unused ph field contains
uninitialized data?

When userspace sets flags =3D=3D 0 to clear the metadata, ph is effectively
unused and might contain garbage. Validating it unconditionally outside of
its flag gate could cause valid API usage to fail with -EINVAL. Should the
ph validation only happen if VFIO_DMA_BUF_TPH_ST or
VFIO_DMA_BUF_TPH_ST_EXT are set?

> +
> +	comp =3D pcie_tph_completer_type(vdev->pdev);
> +	if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> +		return -EOPNOTSUPP;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611161546.4075=
580-1-zhipingz@meta.com?part=3D4
