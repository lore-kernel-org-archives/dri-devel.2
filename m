Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420E606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTZrkJAx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B769112344;
	Thu, 12 Nov 2026 23:19:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372FB112344
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:19:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D351240782;
 Thu, 12 Nov 2026 23:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE8B1F000C4;
 Thu, 12 Nov 2026 23:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794525564;
 bh=Aj1PQGniMEndnhGKrEr7EDjw3cSPO0O0tYv7X+HtJgM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JTZrkJAxylzAghbvzfxXQP+L0T8WivrU/+LVHi1qtIzSyQBoGMLjYfpjQxhCAMQIu
 cnJH1dnFZcf1P0IqCZDjtZ/ovCYcy+R+HlH6gGai/8kGiXDWphFdWQGeA4wqUwSR/u
 +Ph32X9Z+dmC0LZB2SXQfL7qgirygLt2OkFRN51OCUtrJWGpznW+mvJ0/dWO3NZJ/r
 0lMzs3SVo4j8fpXQotSCcbR2Ycp5GKTGJRaujxlKzpYHFmaxmPVBtlDwSkwehFO6Xo
 JVcCEPI9VwbPIc7SgZD1TuZ4q4ntjasHg81bKxiLt6mSD8peZZ8X0TVmRV81UUwhxt
 cCqrC6VaEeyyA==
Message-ID: <sashiko-outbox-211939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/13] drm/gma500: Publish the Cedarview SGX as an
 auxiliary device
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-2-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-2-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:19:23 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/gma500: race clearing sgx_data in
  gma_sgx_set_irq_handler()
- [Medium] drm/gma500: auxiliary device leak and UAF in
  psb_driver_load()
- [Medium] drm/gma500: unmasked _PSB_IRQ_SGX_FLAG and SGX write in
  gma_irq_preinstall()
--

commit 4cc756dfd45e5db0eddaf8ca3914b3626c097190
Author: Joseph Telaak <joseph@telaak.dev>

drm/gma500: Publish the Cedarview SGX as an auxiliary device

This commit publishes the Cedarview PowerVR SGX545 as an auxiliary device
("gma500_gfx.sgx"), skipping internal SGX MMU setup and register
initialization on chips with a dedicated SGX driver and routing SGX
interrupts to a registered callback.

> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/ps=
b_drv.c
> index d17cb5b4a4bf2..c29cc64cc10b3 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c

[ ... ]

> @@ -383,6 +393,8 @@ static int psb_driver_load(struct drm_device *dev, un=
signed long flags)
>  	spin_unlock_irqrestore(&dev_priv->irqmask_lock, irqflags);
> =20
>  	gma_irq_install(dev);
> +	if (dev_priv->ops->sgx)
> +		gma_sgx_aux_init(dev);
> =20
>  	dev->max_vblank_count =3D 0xffffff; /* only 24 bits of frame count */

[Severity: Medium]
Does calling gma_sgx_aux_init() here leak the auxiliary device and leave
a dangling aux->dev_priv pointer if gma_backlight_init() fails below?

drivers/gpu/drm/gma500/psb_drv.c:psb_driver_load() {
    ...
	if (ret)
		return ret;
	psb_intel_opregion_enable_asle(dev);

	return devm_add_action_or_reset(dev->dev, psb_device_release, dev);
    ...
}

When gma_backlight_init() returns an error, psb_driver_load() returns
directly before devm_add_action_or_reset() registers psb_device_release()
and without calling psb_driver_unload().  devres then frees dev_priv while
the auxiliary device remains registered on the auxiliary bus, causing a
use-after-free when an SGX driver probes or calls set_irq_handler().

> diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/ps=
b_irq.c
> index c224c7ff353ce..426efc126bee6 100644
> --- a/drivers/gpu/drm/gma500/psb_irq.c
> +++ b/drivers/gpu/drm/gma500/psb_irq.c

[ ... ]

> @@ -257,8 +266,11 @@ void gma_irq_preinstall(struct drm_device *dev)
>  	PSB_WVDC32(0xFFFFFFFF, PSB_HWSTAM);
>  	PSB_WVDC32(0x00000000, PSB_INT_MASK_R);
>  	PSB_WVDC32(0x00000000, PSB_INT_ENABLE_R);
> -	PSB_WSGX32(0x00000000, PSB_CR_EVENT_HOST_ENABLE);
> -	PSB_RSGX32(PSB_CR_EVENT_HOST_ENABLE);
> +	/* An SGX driver of its own enables what it needs; until one binds, mas=
k it. */
> +	if (!gma_sgx_external(dev_priv) || !READ_ONCE(dev_priv->sgx_handler)) {
> +		PSB_WSGX32(0x00000000, PSB_CR_EVENT_HOST_ENABLE);
> +		PSB_RSGX32(PSB_CR_EVENT_HOST_ENABLE);
> +	}

[Severity: Medium]
Can an active SGX interrupt trigger an unhandled IRQ storm while
dev_priv->sgx_handler is NULL?

gma_irq_preinstall() and gma_irq_postinstall() unconditionally enable
_PSB_IRQ_SGX_FLAG in dev_priv->vdc_irq_mask (written to PSB_INT_MASK_R and
PSB_INT_ENABLE_R), and gma_sgx_set_irq_handler() never masks or unmasks
_PSB_IRQ_SGX_FLAG in the VDC when registering or clearing sgx_handler.
Meanwhile, gma_irq_preinstall() leaves PSB_CR_EVENT_HOST_ENABLE2 untouched
even though psb_do_init() skips psb_spank().  If an SGX event is enabled
in PSB_CR_EVENT_HOST_ENABLE2 across kexec, or remains enabled in
PSB_CR_EVENT_HOST_ENABLE when the SGX driver unregisters its handler on an
error path, gma_irq_handler() repeatedly sees sgx_int with a NULL
sgx_handler and returns IRQ_NONE without clearing the level-triggered SGX
interrupt, disabling the shared PCI interrupt line and breaking display
interrupts.

Also, writing PSB_CR_EVENT_HOST_ENABLE here when gma_sgx_external() is
true contradicts the comments in include/drm/gma500_sgx.h, psb_drv.h, and
sgx_aux.c stating that gma500 never touches SGX registers on chips that
publish the auxiliary device.  Should gma500 instead gate
_PSB_IRQ_SGX_FLAG in the VDC interrupt registers from
gma_sgx_set_irq_handler()?

> diff --git a/drivers/gpu/drm/gma500/sgx_aux.c b/drivers/gpu/drm/gma500/sg=
x_aux.c
> new file mode 100644
> index 0000000000000..671cb6c330ec7
> --- /dev/null
> +++ b/drivers/gpu/drm/gma500/sgx_aux.c
> @@ -0,0 +1,102 @@

[ ... ]

> +static int gma_sgx_set_irq_handler(struct gma500_sgx_device *sgx,
> +				   gma500_sgx_irq_handler_t handler, void *data)
> +{
> +	struct gma_sgx_aux *aux =3D container_of(sgx, struct gma_sgx_aux, sgx);
> +	struct drm_psb_private *dev_priv =3D aux->dev_priv;
> +	struct pci_dev *pdev =3D to_pci_dev(dev_priv->dev.dev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev_priv->irqmask_lock, flags);
> +	if (handler && dev_priv->sgx_handler) {
> +		spin_unlock_irqrestore(&dev_priv->irqmask_lock, flags);
> +		return -EBUSY;
> +	}
> +	dev_priv->sgx_data =3D data;
> +	/* The data reaches the interrupt handler before the handler does. */
> +	smp_store_release(&dev_priv->sgx_handler, handler);
> +	spin_unlock_irqrestore(&dev_priv->irqmask_lock, flags);
> +
> +	/* No handler call still running on another CPU once this returns. */
> +	if (!handler && dev_priv->irq_enabled)
> +		synchronize_irq(pdev->irq);
> +	return 0;
> +}

[Severity: Medium]
Can unregistering the interrupt handler via
gma_sgx_set_irq_handler(sgx, NULL, NULL) pass a NULL data pointer to an
in-flight sgx_handler() on another CPU?

CPU0                                  CPU1 (<hardirq>)
gma_sgx_set_irq_handler(sgx, NULL, NULL)
                                      gma_irq_handler()
                                        sgx_handler =3D smp_load_acquire(
                                                        &dev_priv->sgx_hand=
ler);
  spin_lock_irqsave(&irqmask_lock)
  dev_priv->sgx_data =3D NULL;
  smp_store_release(&sgx_handler, NULL);
  spin_unlock_irqrestore(&irqmask_lock)
                                        sgx_handler(dev_priv->sgx_data)
                                          <-- NULL pointer dereference
  synchronize_irq(pdev->irq);

gma_irq_handler() drops dev_priv->irqmask_lock before loading sgx_handler
and reading dev_priv->sgx_data, while gma_sgx_set_irq_handler() overwrites
dev_priv->sgx_data before clearing dev_priv->sgx_handler and before
calling synchronize_irq(), causing the SGX driver's interrupt callback to
dereference NULL in hardirq context.  In addition, because sgx_handler is
already NULL when irqmask_lock is dropped before synchronize_irq()
finishes, a concurrent registration could overwrite dev_priv->sgx_data
while the old handler is still running.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D2
