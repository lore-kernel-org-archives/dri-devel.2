Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549F0CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B753D10E852;
	Thu, 11 Jun 2026 20:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cdmmYE1g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4641310E7EB
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 20:25:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83E34601FE;
 Thu, 11 Jun 2026 20:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FE31F000E9;
 Thu, 11 Jun 2026 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781209556;
 bh=cwZQ4Fkcp4Qe17h4r7IOj7PfdpW+0mtqRp4Cr44HjnI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cdmmYE1gqMivjLvCV3iGtJtODJlL4jjwuVAlY1aJEWIcRe+IsSWQPSh9irNHGx7ys
 oULys0IO85O84kQ2e18N2YEahb1G6fLO2/XzsT0ys3DZVvTs9Jgj3KLK8zZcsCYiC3
 Uw+BKAmpFtQSCsfwBq7Fnh/tDkNWv3kDUxDqs0O/IYBPmaSvZt36JL8F00a8ysNdd3
 2OOqI1I28taUlHf1c2i9HLPlM6q8jmKssE22rjuS+AVCnY/KBmY5sQzny1VX4iMfAd
 csyUx650G3Sn6QxRw61fooa+DdXTSzG3ps1OmoxUCp027dFhrVCg9Bm4FHZ4nDeUn8
 iLlH+4ovOiwcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260610193158.2614209-5-zhipingz@meta.com>
References: <20260610193158.2614209-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:25:55 +0000
Message-Id: <20260611202555.B0FE31F000E9@smtp.kernel.org>
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
- [Medium] Unconditional validation of the flag-gated 'ph' parameter can le=
ad to spurious -EINVAL errors, breaking the syscall trust boundary.
- [Medium] VFIO_DEVICE_FEATURE_PROBE falsely reports that VFIO_DEVICE_FEATU=
RE_DMA_BUF_TPH is supported even if the hardware lacks TPH support.
--

commit d57637d667ca6dc95def77a0a5bd339d62d4f506
Author: Zhiping Zhang <zhipingz@meta.com>

vfio/pci: implement get_tph and DMA_BUF_TPH feature

This commit implements dma-buf get_tph for vfio-pci exported dma-bufs and
adds the VFIO_DEVICE_FEATURE_DMA_BUF_TPH feature. This allows userspace to
publish TPH metadata for a VFIO-owned device. It checks completer support
and protects the metadata under dmabuf->resv.

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
vfio_check_feature() returns 0 for VFIO_DEVICE_FEATURE_PROBE, causing an=20
early return of success.=20

Should the hardware capability check (pcie_tph_completer_type) occur before
checking the feature flags, to avoid falsely reporting that the feature is
supported on devices that lack TPH?

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
When userspace clears the TPH metadata by passing flags =3D=3D 0, is it req=
uired
to zero-fill the unused ph field?=20

Since this check is unconditional, could stack garbage in the uninitialized=
=20
ph field cause spurious -EINVAL errors, rejecting a valid invalidation=20
request?

> +
> +	comp =3D pcie_tph_completer_type(vdev->pdev);
> +	if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> +		return -EOPNOTSUPP;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610193158.2614=
209-1-zhipingz@meta.com?part=3D4
