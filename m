Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD526CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 11:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0A588CBF;
	Thu,  8 Oct 2026 11:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="W93yaLrQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312FA88CBF
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=roIZUDPeZfs+BIIKGMj2aUvvyJImJ7yniX1NoOVWaNg=; b=W93yaLrQgGyHLfFugnDCXXnsBG
 AtnavBAFS/Nf32lZeap+/VCXScvcTeIbrr0pmf/Vw0KHqgQyKps15R5/NxiJj3+0Nx4nQJYxh5TF8
 5Z5h+ZO3Bna/8tuxJJfAmwRzp/kpvbUosDEEeHZsFI5rE2ipDA6HyMGbjFu0Na+GQ4SD9KGikeC9/
 dYOGh2WVzPQRBrs6mPzF4jZTHKn7Po7GT1dA1ihI0g/sh0G5GqGNhNx5GmhEKOd6aM/6prnlj+sfo
 jjNoFCfG5E2VNSfsFL4zX1imQsNviIYD7Gi2Bf0I+rV7C0p2EakEDAGK4uTCZEKxoqYAyHgSOZAhC
 lAAAEc0w==;
Received: from [148.56.135.230] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xEmC3-00ERf8-Tb; Thu, 08 Oct 2026 13:21:47 +0200
Message-ID: <749f58993b891f756cde15e1408b1e98b861ce54.camel@igalia.com>
Subject: Re: [PATCH] drm/vc4: Disable the V3D interrupt across runtime suspend
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Date: Thu, 08 Oct 2026 13:21:37 +0200
In-Reply-To: <20260925191318.541938-1-mcanal@igalia.com>
References: <20260925191318.541938-1-mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Looks good to me, I have a couple of questions below:

El vie, 25-09-2026 a las 16:10 -0300, Ma=C3=ADra Canal escribi=C3=B3:
(...)
> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c
> b/drivers/gpu/drm/vc4/vc4_irq.c
> index 7877d493d80e..98a8db720091 100644
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> @@ -276,7 +276,7 @@ vc4_irq_disable(struct drm_device *dev)
> =C2=A0	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
> =C2=A0
> =C2=A0	/* Finish any interrupt handler still in flight. */
> -	synchronize_irq(vc4->irq);
> +	disable_irq(vc4->irq);

With this change, do we still need the 2 V3D_WRITEs above this?
>=20
>=20
> =C2=A0	cancel_work_sync(&vc4->overflow_mem_work);
> =C2=A0}
> @@ -284,7 +284,6 @@ vc4_irq_disable(struct drm_device *dev)
> =C2=A0int vc4_irq_install(struct drm_device *dev, int irq)
> =C2=A0{
> =C2=A0	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> -	int ret;
> =C2=A0
> =C2=A0	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
> =C2=A0		return -ENODEV;
> @@ -298,19 +297,8 @@ int vc4_irq_install(struct drm_device *dev, int
> irq)
> =C2=A0	init_waitqueue_head(&vc4->job_wait_queue);
> =C2=A0	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
> =C2=A0
> -	/* Clear any pending interrupts someone might have left
> around
> -	 * for us.
> -	 */
> -	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);

Why this change?

> -
> -	ret =3D devm_request_irq(dev->dev, irq, vc4_irq, 0,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(dev->dev), dev);
> -	if (ret)
> -		return ret;
> -
> -	vc4_irq_enable(dev);
> -
> -	return 0;
> +	return devm_request_irq(dev->dev, irq, vc4_irq,
> IRQF_NO_AUTOEN,
> +				dev_name(dev->dev), dev);
> =C2=A0}
