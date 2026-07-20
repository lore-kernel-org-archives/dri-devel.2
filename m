Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B72C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B25E10E6B7;
	Mon, 20 Jul 2026 17:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BR8mknFU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1507910E6B7
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 17:35:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB8C240836;
 Mon, 20 Jul 2026 17:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAAD1F000E9;
 Mon, 20 Jul 2026 17:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784568936;
 bh=HsBQ3nUA4zcmLZMc7LUSjfEBdRZj44LAUkCCLkftuxw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BR8mknFUblMVYbT5BtdL9Xrm87iqQgywRa1tfIChchRlsTEfNoAIFdTKZLErN6neV
 jFwKlJ/k0475GUnIItlL38Su3vFj9hPDm/ANvHXIuSoH7gyIBPnKwR9gU0GrEQUO2z
 v9AWSHKIzSBcr1vQth8C3E94fP9MyfVaXfbe2FzlBJQBLlhO0oY2fAIIRygXHNiwCl
 vaGhcexZfD7bRhXXMWZ6KTIEHyO43Ozvf5NVUv3LO5+UX+vjVefLqoTNvmgtLiobIG
 ZSFS5C9eSyb2Ci14faW4RdAQ/6AiFMQYhZbzHbU4jWffYQx8Hzzr6M5u2IsJwoktzK
 4ZkoTFG7wsbYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: hvs/v3d: Fix null dereference in unbind
To: "Gregor Herburger" <gregor.herburger@linutronix.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-rpi-vc4-fix-v1-1-6073a96a5773@linutronix.de>
References: <20260720-rpi-vc4-fix-v1-1-6073a96a5773@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 17:35:36 +0000
Message-Id: <20260720173536.6EAAD1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] vc4_v3d_unbind() accesses hardware without resuming from runtime s=
uspend, leading to system hangs.
- [High] Component bind callbacks improperly use devm_ APIs on the componen=
t device, causing memory leaks and dangling IRQ handlers.
--

--- Patch [1]: [PATCH] drm/vc4: hvs/v3d: Fix null dereference in unbind ---
commit 70be44b543f0237e5db3dfd6dff591c323b131ef
Author: Gregor Herburger <gregor.herburger@linutronix.de>

drm/vc4: hvs/v3d: Fix null dereference in unbind

The hvs and v3d drivers use dev_get_drvdata(master) in their unbind
functions. Since the vc4-drm gets removed before its dependent drivers
(vc4_hvs/vc4_v3d) the vc4_hvs_unbind/vc4_v3d_unbind functions try to
get drvdata of its master and fails with a null dereference error.

> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 184d51ea3fa57..e715147d091ca 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -1752,7 +1752,7 @@ static int vc4_hvs_bind(struct device *dev, struct =
device *master, void *data)
>  static void vc4_hvs_unbind(struct device *dev, struct device *master,
>  			   void *data)
>  {
> -	struct drm_device *drm =3D dev_get_drvdata(master);
> +	struct drm_device *drm =3D data;

[Severity: High]
This is a pre-existing issue, but does vc4_hvs_bind() improperly use
devm_ APIs?

The component framework leaves the component device bound to its base driver
even when the aggregate DRM master unbinds. Since devm_ APIs are attached
to the component device (dev), they are only freed when the component device
is removed, not when it is unbound.

Specifically, devm_request_irq() in vc4_hvs_bind() leaves the IRQ handler
registered after unbind. Since vc4_hvs_unbind() nullifies vc4->hvs, will
a subsequent interrupt cause vc4_hvs_irq_handler() to dereference a NULL
pointer?

>  	struct vc4_dev *vc4 =3D to_vc4_dev(drm);
>  	struct vc4_hvs *hvs =3D vc4->hvs;
>  	struct drm_mm_node *node, *next;
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index d31b906cb8e78..f32410420d3e4 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -494,7 +494,7 @@ static int vc4_v3d_bind(struct device *dev, struct de=
vice *master, void *data)
>  static void vc4_v3d_unbind(struct device *dev, struct device *master,
>  			   void *data)
>  {
> -	struct drm_device *drm =3D dev_get_drvdata(master);
> +	struct drm_device *drm =3D data;

[Severity: High]
This is a pre-existing issue, but does vc4_v3d_bind() leak memory on unbind?

Since devm_ APIs attached to the component device (&pdev->dev) are only fre=
ed
when the component device is removed (not unbound), does the devm_kzalloc()
in vc4_v3d_bind() leak memory on every unbind/bind cycle?

>  	struct vc4_dev *vc4 =3D to_vc4_dev(drm);
> =20
>  	vc4_irq_uninstall(drm);

[Severity: High]
This is a pre-existing issue, but can this code access hardware while it is
runtime suspended?

When the DRM driver is unbound, vc4_v3d_unbind() is called. The V3D hardware
may be in an autosuspended state because vc4_v3d_bind() enables runtime PM
autosuspend.

This calls vc4_irq_uninstall() (which accesses V3D_INTDIS and V3D_INTCTL)
and subsequently writes to V3D_BPOA and V3D_BPOS.

Will accessing these registers without a preceding pm_runtime_get_sync() to
wake the hardware cause an AXI bus timeout and system hang on ARM systems?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-rpi-vc4-fi=
x-v1-1-6073a96a5773@linutronix.de?part=3D1
