Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00001CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6070610E5EC;
	Tue,  9 Jun 2026 19:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ny7mzlMr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC9B10E5DD
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:38:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 530DC602CE;
 Tue,  9 Jun 2026 19:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D337F1F00893;
 Tue,  9 Jun 2026 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781033919;
 bh=XPHGM0EGRSSY/Vy8eoWWttPOeuJ+XBDhfAa5o4+g8Sg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ny7mzlMrbHxebg5xp2gHjvAYhkJI01uzJ+ouzby6qT7y1pViGH+4HhN3VO90rOnqN
 OLvd16IRq2uR9vJ0LJoGlfBslukL1uZAv434N4XtLfrfEW1jD+C8d3HprQRzo+Ji4D
 whC71dm75hgy+Ed5uAXqstfnMuA1IJMCcrgcZLEiQHSYxtxksZc2X61v8qMlX1CYeg
 q72g+JIrElHNwaSUYv56fxBATu9jFOhSbISPXK0JnAIAIFxDo9CIrCjzmVvSf6RnjB
 hU5sl/5T/jnaDA4Pd9ZSmX6j2ZU/UzwYKXAkNiJFetjyL9fQG6kngC6foFbKZUd9Qp
 tq+sH9lZ+B7pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260608185646.4085127-5-zhipingz@meta.com>
References: <20260608185646.4085127-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 19:38:38 +0000
Message-Id: <20260609193838.D337F1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Unconditional validation of the flag-gated `ph` parameter causes=
 valid requests clearing metadata to be rejected.
- [Low] Mixing `goto`-based error handling with scope-based cleanup helpers=
 (`scoped_guard`) in the same function.
- [Low] Unprotected read of `priv->vdev` races with concurrent write to `NU=
LL`.
--

commit f7be31969e4c92a551932ef245b8d9697e571272
Author: Zhiping Zhang <zhipingz@meta.com>

vfio/pci: implement get_tph and DMA_BUF_TPH feature

This commit implements the dma-buf get_tph callback for vfio-pci-exported
dma-bufs. It also adds the VFIO_DEVICE_FEATURE_DMA_BUF_TPH feature to allow
userspace to attach TPH metadata to a dma-buf.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 1a177ce7de546..f1bc3733d3db5 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
[ ... ]
> @@ -327,12 +358,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
[ ... ]
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf_tph set_tph;
> +	struct vfio_pci_dma_buf *priv;
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	if (!pcie_tph_supported(vdev->pdev))
> +		return -EOPNOTSUPP;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(set_tph));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> +		return -EFAULT;
> +
> +	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> +		return -EINVAL;
> +
> +	/* PCIe TLP Processing Hint is a 2-bit field. */
> +	if (set_tph.ph & ~0x3)
> +		return -EINVAL;

[Severity: Medium]
Will this unconditionally reject requests clearing the metadata?

The documentation mentions that setting flags to 0 clears previously publis=
hed
metadata. However, because this check is evaluated unconditionally, userspa=
ce
leaving the ph field uninitialized (containing stack garbage) when passing
flags =3D 0 will cause the kernel to erroneously reject a valid clear reque=
st
with -EINVAL.

Should this validation only occur if the relevant flags are set?

> +
> +	dmabuf =3D dma_buf_get(set_tph.dmabuf_fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
> +		ret =3D -EINVAL;
> +		goto out_put;
> +	}
> +
> +	priv =3D dmabuf->priv;
> +	if (priv->vdev !=3D vdev) {

[Severity: Low]
Does this unprotected read of priv->vdev race with concurrent unbound opera=
tions?

In vfio_pci_dma_buf_cleanup(), there is a concurrent write setting=20
priv->vdev =3D NULL under the vdev->memory_lock semaphore.

Since this read occurs without locks, can it race with the concurrent write
and cause KCSAN warnings or load tearing? Would using READ_ONCE() here and
WRITE_ONCE() in vfio_pci_dma_buf_cleanup() help prevent this?

> +		ret =3D -EINVAL;
> +		goto out_put;
> +	}
> +
> +	scoped_guard(mutex, &priv->tph_lock) {
> +		priv->tph_st =3D set_tph.steering_tag;
> +		priv->tph_st_ext =3D set_tph.steering_tag_ext;
> +		priv->tph_ph =3D set_tph.ph;
> +		priv->tph_st_valid =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> +		priv->tph_st_ext_valid =3D
> +			!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> +	}
> +	ret =3D 0;
> +
> +out_put:

[Severity: Low]
Is it okay to mix goto-based error handling and scope-based cleanup helpers=
 in
this function?

The kernel cleanup guidelines discourage mixing goto labels for cleanup (li=
ke
goto out_put here) and scoped_guard() in the same function to avoid confusi=
ng
ownership semantics.

Would it be better to either use a __free() wrapper for the dmabuf or stick=
 to
traditional mutex_lock()/mutex_unlock() here?

> +	dma_buf_put(dmabuf);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608185646.4085=
127-1-zhipingz@meta.com?part=3D4
