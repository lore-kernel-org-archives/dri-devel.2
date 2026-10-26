Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B63606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVwF9UnB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E437B10ED36;
	Mon, 26 Oct 2026 09:48:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7BC10ED36
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:48:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D29A5600CB;
 Mon, 26 Oct 2026 09:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618E31F01825;
 Mon, 26 Oct 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793008114;
 bh=nlJVhmEQLUryFYsRWFOnsIW3X4sYdWweuRiC9lT81eU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FVwF9UnBzyozJ9ZrmS4qKuJfYFK/z1meXXadOl91C6/NtNLxp7wmKXgG4kdFVWi/L
 RQ0xUKq5TBb2x/HBXdB9T04Lla2KDqi52hEfZjcQeVdSJP5xkJgOsyNSmghjPHTMY7
 DbZ67L+zcsjBQh4jZEBEWVxZuMu8l3UVLmSmza07Dac4/DnCmGzM45vZCOOHDAAekh
 dA7BxEnj/iF9sudxwkiBqBrzjwM9TZnO2uYZ20/Ktj5Xs4I0moU2kJ5LIhLpCatWoR
 9E/IkX9JY3snu+vVNU/cvxVzVlh3CfD8oqjOmlMv4gCrBMwNKdS721g8mPUQo+UPMf
 dZTAakqhpAbVA==
Message-ID: <sashiko-outbox-184838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes v4 2/2] drm/hisilicon/hibmc: Add a
 flag to indicate whether the OS-side driver has been loaded
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026060303.289737-3-shiyongbang@huawei.com>
References: <20261026060303.289737-1-shiyongbang@huawei.com>
 <20261026060303.289737-3-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:48:33 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/hisilicon/hibmc: unconditional enable flag set when DP init fa=
ils
--

commit 9960ec3a8f045c4b7198b1788310aca553de0cc3
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver has =
been loaded

This commit adds a hardware register flag (HIBMC_ENABLE_STATE in
HIBMC_ENABLE_FLAG) to notify the BMC when the OS-side driver is loaded and
unloaded, preventing the BMC from enabling DP and triggering unhandled
interrupts before the driver is ready. It also introduces a spinlock to
serialize read-modify-write operations on the shared register.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gp=
u/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index df4501bb076bc..15583a2d1c6fd 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c

[ ... ]

> @@ -460,6 +486,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>  		goto err_return;
>  	}
> =20
> +	hibmc_set_enable_flag(priv);

[Severity: High]
Should hibmc_set_enable_flag() be called unconditionally here if DP
initialization failed or if fewer than two MSI vectors were allocated?

In drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c, hibmc_kms_init() treats
hibmc_dp_init() failures as non-fatal so that VDAC can still function:

	ret =3D readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL);
	if (ret) {
		ret =3D hibmc_dp_init(priv);
		if (ret)
			drm_err(dev, "failed to init dp: %d\n", ret);
	}

Meanwhile, hibmc_msi_init() either allocates 2 MSI vectors and registers
hibmc_dp_interrupt and hibmc_dp_hpd_isr unconditionally, or succeeds with
HIBMC_MIN_VECTORS (1) without registering the DP interrupt handler at all.

If hibmc_set_enable_flag() is called unconditionally in hibmc_pci_probe()
and the BMC subsequently enables DP and triggers a DP interrupt:

1. If hibmc_dp_init() failed before allocating priv->dp.dp_dev (or failed
   in hibmc_dp_serdes_init() before clearing HIBMC_DP_INTR_ENABLE),
   hibmc_dp_interrupt() calls hibmc_dp_get_hpd_status(&priv->dp), which
   dereferences a NULL dp->dp_dev pointer in hard IRQ context.

2. If hibmc_dp_init() failed during encoder or connector initialization,
   priv->dp.connector.dev remains NULL, and the threaded handler
   hibmc_dp_hpd_isr() calls drm_connector_helper_hpd_irq_event(),
   dereferencing NULL.

3. If pci_alloc_irq_vectors() only allocated 1 MSI vector, the DP interrupt
   has no handler registered.

Would it be safer to only set HIBMC_ENABLE_STATE when DP has been
successfully initialized and its MSI vector is registered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026060303.2897=
37-1-shiyongbang@huawei.com?part=3D2
