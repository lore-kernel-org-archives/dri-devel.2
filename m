Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D88606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVJ6AHYH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59EBC10E2E8;
	Thu, 26 Nov 2026 03:25:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C7110E2E8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 03:25:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CCB7408CB;
 Thu, 26 Nov 2026 03:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6441F000C4;
 Thu, 26 Nov 2026 03:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795663523;
 bh=l0sVppufTnf1UJp9nAyj6E1PzJ4jxtm9cQc2/SdrmwM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dVJ6AHYHmQtiVaU2g010Y1YCjheUrfTZwYtYn7zdfzjzeIwVWAmbghzu+ny3f4LUG
 ZODyWfM9zjmCt67MXhOBp9XvmtfTmwcr8AnYsy1zfAieoD89C8Nr/8hF+VQs+02wZm
 cUP9aq61KULioIKq3TSIu0ipI/13Ny3I2ARj5Sskif5jsMIGAD0hIUdpvHrxOR12a7
 QSRzgUjo646xUwUZzuqv/kiQodhWIJj5OpP7zZniu+eQ51bErtwX1IkgSYCAaGXFpi
 b2iH+f2Z2jhCZ+B58ntINwX10U/QKnpoReaop96X6ssxK/nTkUoc14k10Ou8Ma3nR+
 LAQe65MxvKeSQ==
Message-ID: <sashiko-outbox-234696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes v6 2/2] drm/hisilicon/hibmc: Add a
 flag to indicate whether the OS-side driver has been loaded
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126030648.3231196-3-shiyongbang@huawei.com>
References: <20261126030648.3231196-1-shiyongbang@huawei.com>
 <20261126030648.3231196-3-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 03:25:22 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/hisilicon/hibmc: missing DP IRQ in hibmc_msi_init() on
  1-MSI fallback
--

commit 69a03a5b7c8791a711817f3c15bf41b6de54192a
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver has =
been loaded

This commit tracks DisplayPort initialization with a flag, only requests
the DP MSI vector when DP is initialized, and updates HIBMC_ENABLE_FLAG
under a spinlock to tell the BMC when the driver is ready.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gp=
u/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index a110b5e15e596..1e01a210b047d 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c

[ ... ]

> @@ -347,12 +349,17 @@ static void hibmc_unload(struct drm_device *dev)
>  static int hibmc_msi_init(struct drm_device *dev)
>  {
>  	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
> +	struct hibmc_drm_private *priv =3D to_hibmc_drm_private(dev);
> +	int max_vectors =3D HIBMC_MIN_VECTORS;
>  	int valid_irq_num;
>  	int irq;
>  	int ret;
> =20
> -	ret =3D pci_alloc_irq_vectors(pdev, HIBMC_MIN_VECTORS,
> -				    HIBMC_MAX_VECTORS, PCI_IRQ_MSI);
> +	if (priv->dp.initialized)
> +		max_vectors =3D HIBMC_MAX_VECTORS;
> +
> +	ret =3D pci_alloc_irq_vectors(pdev, HIBMC_MIN_VECTORS, max_vectors,
> +				    PCI_IRQ_MSI);
>  	if (ret < 0) {
>  		drm_err(dev, "enabling MSI failed: %d\n", ret);
>  		return ret;

[Severity: Medium]
Can pci_alloc_irq_vectors() succeed with only 1 MSI vector when
priv->dp.initialized is true?

Passing HIBMC_MIN_VECTORS (1) as min_vecs allows pci_alloc_irq_vectors()
to fall back to a single vector when multi-MSI is unavailable or vectors
are constrained.  In that case the loop below only registers
hibmc_interrupt() on vector 0 and never installs hibmc_dp_interrupt(),
yet hibmc_set_enable_flag() still sets HIBMC_ENABLE_STATE and
hibmc_dp_late_register() unmasks DP interrupts, leaving DP HPD broken and
DP interrupts unhandled on vector 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126030648.3231=
196-1-shiyongbang@huawei.com?part=3D2
