Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A6606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKEEgc6/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0537510E5DD;
	Tue, 17 Nov 2026 13:56:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DB210E5DD
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:56:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC4B763522;
 Tue, 17 Nov 2026 13:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796071F000C5;
 Tue, 17 Nov 2026 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794923810;
 bh=1wmpD/ObIyXNcZYJvXuwsraxg5MFiTAvN1b4cK6/8tE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TKEEgc6/YM9uRBXCyRjYyzc3Ob5M4BddUWPwLbpKYYQvxi8gzX3YEIZETvBJ0NB9e
 SMEeFL9rvYh5xBCB/acVfTyHMYynSdTBt5e71gt72Y0STngMH9UsX1oTwmY7p5FGkg
 mHzuI5T+5urN/BNgwrJ5gqHmki7FIq/z4Rk61XubAx+szmitE50NKjxrlpL1U+jmO+
 QdFPZatRYVV4YOUN/qQrFESOddlP3UmLlVJZKkVWMlgZRZjyWHIiLhGRU29tdSyXxu
 hparmRjLzoYV8+5AmqcBYbrn+dpoqvtdgJv/jF6mBX75BRY0/2tOl0uc/0mJPw8djP
 w3mJ+e51wbvWw==
Message-ID: <sashiko-outbox-218910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes v5 2/2] drm/hisilicon/hibmc: Add a
 flag to indicate whether the OS-side driver has been loaded
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261117130056.272609-3-shiyongbang@huawei.com>
References: <20261117130056.272609-1-shiyongbang@huawei.com>
 <20261117130056.272609-3-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:56:50 +0000
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
  single-MSI fallback
--

commit c5b72c7e5869fdeb7952573f12ec81ff829734f9
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver has =
been loaded

This commit adds a hardware enable flag to notify the BMC when the OS
driver and DP block are initialized, and serializes RMW access to the
shared GPIO/flag register with a spinlock.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gp=
u/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index a110b5e15e596..9b9077b69cdc5 100644
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
What happens when priv->dp.initialized is true, but
pci_alloc_irq_vectors() only allocates 1 vector instead of 2 (for
example, when multi-MSI is unavailable)?

Because HIBMC_MIN_VECTORS (1) is still passed as min_vecs,
hibmc_msi_init() succeeds while only requesting vector 0
(hibmc_interrupt()) and skipping hibmc_dp_interrupt().  However,
hibmc_set_enable_flag() still sets HIBMC_ENABLE_STATE because
priv->dp.initialized is true, and hibmc_dp_late_register() unmasks DP
interrupts via hibmc_dp_enable_int().  With single-message MSI fallback,
DP interrupts are routed to vector 0 where hibmc_interrupt() does not
clear them and returns IRQ_NONE, triggering an unhandled interrupt storm
that disables vector 0 and leaves DP HPD broken.

Should min_vecs also be HIBMC_MAX_VECTORS when priv->dp.initialized is
true, or should DP be disabled if the second vector cannot be allocated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117130056.2726=
09-1-shiyongbang@huawei.com?part=3D2
