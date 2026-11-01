Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E7606A332
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgS7aDR/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E1610E4D7;
	Sun,  1 Nov 2026 22:52:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ECC10E4D7
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:52:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4133343D00;
 Sun,  1 Nov 2026 22:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D201F00A18;
 Sun,  1 Nov 2026 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573528;
 bh=RJRmb9BeHS7B5qkx/YnN82Ls/IgLzffyBgwP9mAfglI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UgS7aDR/pw1j1B8WIbPwYgaP2O3sqypaMWmtcLn/uYx2LD1gkO6WKxNI1waOviMWJ
 QWPkR9mbjCzvtJMArsqCtvRStZt+KVYmVJBXruNXyzr2YEGEYCrnmde6147Cu1OKLY
 uRz6QT1Rge+5VqPT7qQOwUqSnAmnaBws9vKJ0Hs9TilI79MqCrPxEdpBeoUwIaH4Jf
 JVTrqTbRNP3AXOBLDtRUU5+0yZbWsv7nKIO/ZykwAwLVuUMJ0lw+RSvqhhPuL41fuh
 +F+xs6vu1Ugrljzo/5pLk4n8jAct2fo0C1iTXbPRIDj8H+LF42JDtf6n/1qMnQyPJh
 vY0GrDMiKNdmQ==
Message-ID: <sashiko-outbox-192741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/25] accel/qda: Add compute context bank devices
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-3-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-3-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:52:07 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel/qda: missing IOMMU probe and domain ownership in qda_create_=
cb_device()
- [Medium] accel/qda: qda_create_cb_device() leaves coherent_dma_mask at 32=
 bits
--

commit 3c742ed6e8932c7c7fe69686db2d02383880697a
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add compute context bank devices

This commit creates a platform device for each qcom,fastrpc-compute-cb
child node during rpmsg probe and configures its DMA address mask based on
per-SoC data.

> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
> new file mode 100644
> index 0000000000000..afb0bb71a1f44
> --- /dev/null
> +++ b/drivers/accel/qda/qda_cb.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/dma-mapping.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <drm/drm_print.h>
> +#include "qda_cb.h"
> +#include "qda_drv.h"
> +#include "qda_soc.h"
> +
> +static int qda_create_cb_device(struct qda_dev *qdev, struct device_node=
 *cb_node)
> +{
> +	struct qda_cb_dev *entry;
> +	struct platform_device *pdev;
> +	u32 dma_bits;
> +	int ret;
> +
> +	pdev =3D of_platform_device_create(cb_node, NULL, qdev->dev);
> +	if (!pdev) {
> +		drm_err(&qdev->drm_dev, "Failed to create CB device for %pOFn\n", cb_n=
ode);
> +		return -ENODEV;
> +	}

[Severity: High]
Can qda_create_cb_device() succeed here even when the context bank device h=
as
not been attached to an IOMMU domain or claimed for kernel DMA API use?

Because the iommus property lives on the qcom,fastrpc-compute-cb child nodes
rather than the parent fastrpc rpmsg node, fw_devlink only creates a
DL_FLAG_SYNC_STATE_ONLY proxy link on rpdev->dev, which
device_links_check_suppliers() ignores when qda_rpmsg_probe() runs.

When of_platform_device_create() calls of_device_add() -> device_add(),
bus_notify(dev, BUS_NOTIFY_ADD_DEVICE) ignores the return value of
iommu_bus_notifier(), and iommu_init_device() ignores the return value of
dev->bus->dma_configure(dev):

drivers/iommu/iommu.c:iommu_init_device() {
	if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
		mutex_unlock(&iommu_probe_device_lock);
		dev->bus->dma_configure(dev);
		mutex_lock(&iommu_probe_device_lock);
		/* If another instance finished the job for us, skip it */
		if (!dev->iommu || dev->iommu_group)
			return -ENODEV;
	}
}

If the SMMU supplier has not probed yet, of_iommu_configure() returns
-EPROBE_DEFER, causing of_dma_configure_id() to return early before
arch_setup_dma_ops() sets dev->dma_coherent:

drivers/of/device.c:of_dma_configure_id() {
	ret =3D of_iommu_configure(dev, np, id);
	if (ret =3D=3D -EPROBE_DEFER) {
		/* Don't touch range map if it wasn't set from a valid dma-ranges */
		if (set_map)
			dev->dma_range_map =3D NULL;
		kfree(map);
		return -EPROBE_DEFER;
	}
}

In the platform bus model, DMA and IOMMU configuration errors (such as
-EPROBE_DEFER or SMMU stream mapping failures) are only propagated when a
driver binds in really_probe() -> platform_dma_configure(). Since no platfo=
rm
driver binds to pdev, of_platform_device_create() still returns a valid pdev
with pdev->dev.iommu_group =3D=3D NULL, allowing the DRM device to be regis=
tered
while subsequent session DMA allocations fall back to unisolated dma-direct
physical mappings.

Additionally, when platform_dma_configure() is invoked from
iommu_init_device() with drv =3D=3D NULL, it returns before calling
iommu_device_use_default_domain():

drivers/base/platform.c:platform_dma_configure() {
	/* @dev->driver may not be valid when we're called from the IOMMU layer */
	if (ret || !drv || to_platform_driver(drv)->driver_managed_dma)
		return ret;

	ret =3D iommu_device_use_default_domain(dev);
}

This leaves group->owner_cnt at 0, so kernel DMA API ownership of the conte=
xt
bank's IOMMU group is never claimed (unlike drivers/misc/fastrpc.c, which
binds a platform driver to qcom,fastrpc-compute-cb devices). Should a
component/sub-driver bind to these context bank platform devices, or should
qda_create_cb_device() explicitly configure DMA and claim default domain
ownership while propagating errors such as -EPROBE_DEFER?

> +
> +	dma_bits =3D qda_soc_dma_addr_bits(qdev);
> +	ret =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(dma_bits));

[Severity: Medium]
Should qda_create_cb_device() call dma_set_mask_and_coherent() instead of
dma_set_mask() here?

When of_platform_device_create() allocates the device through
of_platform_device_create_pdata() -> of_device_alloc() ->
platform_device_alloc() -> setup_pdev_dma_masks(), pdev->dev.dma_mask is
pointed at pdev->platform_dma_mask while pdev->dev.coherent_dma_mask is
initialized separately to DMA_BIT_MASK(32):

drivers/base/platform.c:setup_pdev_dma_masks() {
	if (!pdev->dev.coherent_dma_mask)
		pdev->dev.coherent_dma_mask =3D DMA_BIT_MASK(32);
	if (!pdev->dev.dma_mask) {
		pdev->platform_dma_mask =3D DMA_BIT_MASK(32);
		pdev->dev.dma_mask =3D &pdev->platform_dma_mask;
	}
}

Because dev->dev.dma_mask is already non-NULL when
of_platform_device_create_pdata() checks if (!dev->dev.dma_mask),
dev->dev.dma_mask and dev->dev.coherent_dma_mask remain separate fields.

Calling dma_set_mask() only updates *pdev->dev.dma_mask
(pdev->platform_dma_mask) to 34 bits on Kaanapali CDSP and leaves
pdev->dev.coherent_dma_mask at DMA_BIT_MASK(32). When later patches allocate
context bank buffers via dma_alloc_coherent() (in commit "accel/qda: Add
buffer allocation for the DSP"), the IOMMU DMA allocator passes
dev->coherent_dma_mask as the upper IOVA limit to iommu_dma_alloc_iova(),
restricting coherent allocations on 34-bit CDSP context banks to 32-bit
IOVAs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D3
