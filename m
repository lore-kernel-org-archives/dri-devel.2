Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6255C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3600910EE40;
	Tue,  7 Jul 2026 16:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k0vPOxQU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F91710EE40
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:06:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 090FC435B5;
 Tue,  7 Jul 2026 16:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05B01F000E9;
 Tue,  7 Jul 2026 16:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440395;
 bh=EPd/+wmyOWU+FRL2COoT47FMAjQTsfQtMekKIkYXc+g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k0vPOxQU7JKtuanSnjPMDdra9xOI1gBQPX0F3jOswGV4jSM14sFS5hJVRrxtiRyQ1
 idt83CScWLFYC9SR/w93P3YbKl2edzluR2G3GXs2UpTcdhvJfMytzSeDYugr2kY2LX
 1mYwDcq/zhulqRV+Ccm81qGvtVeFsSiYObv2r2ld9Vlt9/nPdej/19L4ZWo582hO/9
 7AV3IF8B2fVFRg4bFM2XoSDOb0uNZQndwcQZ7iLFT12opc8YvmG9jmq9gZGA1WtO9I
 iZZHB3N/bExu7ZAyro/hHLnMzeHFVlCrBZJ8+x0Mmto0RMtECM0lRvH/wrq58UWxqZ
 lev67sAvdOsEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: remove dependency on DRM simple helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-qxl-simple-v1-1-524f6316b5d5@gmail.com>
References: <20260707-qxl-simple-v1-1-524f6316b5d5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:06:35 +0000
Message-Id: <20260707160635.C05B01F000E9@smtp.kernel.org>
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

New issues:
- [Low] The patch mistakenly defines a `drm_connector_funcs` structure name=
d `qxl_connector_funcs` instead of a `drm_encoder_funcs` structure for the =
new encoder, causing a redefinition build error.

Pre-existing issues:
- [High] Lockless reallocation of `client_monitors_config` leads to Use-Aft=
er-Free during connector operations.
- [High] Missing `free_irq()` and `cancel_work_sync()` during device teardo=
wn leads to Use-After-Free on module unload.
--

--- Patch [1]: [PATCH] drm/qxl: remove dependency on DRM simple helpers ---
commit d182374fb0440bb0cb67a0c069afac8494f4bf85
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/qxl: remove dependency on DRM simple helpers

This patch removes the drm_simple_encoder_init() helper usage in the qxl
display driver by open coding it and using the encoder atomic helpers
directly. This is a step to eventually get rid of the simple KMS helper.

> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
> index a026bd35ef485..236d027fbc9fe 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1095,6 +1095,10 @@ static const struct drm_connector_helper_funcs qxl=
_connector_helper_funcs =3D {
>  	.best_encoder =3D qxl_best_encoder,
>  };
> =20
> +static const struct drm_connector_funcs qxl_connector_funcs =3D {
> +	.destroy =3D drm_encoder_cleanup,
> +};
> +

[Severity: Low]
Does this code inadvertently define struct drm_connector_funcs instead of
struct drm_encoder_funcs?

The struct name qxl_connector_funcs also conflicts with an existing definit=
ion
later in the file.

[ ... ]

> @@ -1169,10 +1173,10 @@ static int qdev_output_init(struct drm_device *de=
v, int num_output)
>  	drm_connector_init(dev, &qxl_output->base,
>  			   &qxl_connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
> =20
> -	ret =3D drm_simple_encoder_init(dev, &qxl_output->enc,
> -				      DRM_MODE_ENCODER_VIRTUAL);
> +	ret =3D drm_encoder_init(dev, &qxl_output->enc, &qxl_connector_funcs,
> +			       DRM_MODE_ENCODER_VIRTUAL, NULL);

[Severity: Low]
Is this passing a pointer to the newly added struct drm_connector_funcs whe=
re
drm_encoder_init() expects struct drm_encoder_funcs *?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free
risk during connector operations?

In qxl_alloc_client_monitors_config() in drivers/gpu/drm/qxl/qxl_display.c,=
=20
the shared client monitors config can be freed locklessly:

	if (qdev->client_monitors_config &&
	    count > qdev->client_monitors_config->count) {
		kfree(qdev->client_monitors_config);
		qdev->client_monitors_config =3D NULL;
	}

Concurrently, DRM ioctls like qxl_conn_detect() check and dereference this
pointer without synchronization:

	if (!qdev->client_monitors_config) {
		if (output->index =3D=3D 0)
			connected =3D true;
	} else
		connected =3D qdev->client_monitors_config->count > output->index &&
		     qxl_head_enabled(&qdev->client_monitors_config->heads[output->index]=
);

Could a concurrent reallocation free the config while it is being accessed =
here?


[Severity: High]
This is a pre-existing issue, but is there a missing teardown of the IRQ
handler and workqueue on module unload?

In qxl_irq_init() in drivers/gpu/drm/qxl/qxl_irq.c, the IRQ is manually=20
requested and the workqueue is initialized:

	INIT_WORK(&qdev->client_monitors_config_work,
		  qxl_client_monitors_config_work_func);
...
	ret =3D request_irq(pdev->irq, qxl_irq_handler, IRQF_SHARED,=20
			  ddev->driver->name, ddev);

However, the teardown logic in qxl_pci_remove() in drivers/gpu/drm/qxl/qxl_=
drv.c=20
appears to omit free_irq() and cancel_work_sync():

static void
qxl_pci_remove(struct pci_dev *pdev)
{
	struct drm_device *dev =3D pci_get_drvdata(pdev);

	drm_kms_helper_poll_fini(dev);
	drm_dev_unregister(dev);
	drm_atomic_helper_shutdown(dev);

Does this leak the IRQ handler registration, potentially leading to a
use-after-free if the shared IRQ fires after the device is unbound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-qxl-simple=
-v1-1-524f6316b5d5@gmail.com?part=3D1
