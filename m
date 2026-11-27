Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD31606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=av+Pc7h4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538BB10E4CA;
	Fri, 27 Nov 2026 08:40:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53CB10E4BD;
 Fri, 27 Nov 2026 08:39:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14F106014B;
 Fri, 27 Nov 2026 08:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F7F1F000C1;
 Fri, 27 Nov 2026 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795768746;
 bh=cAF1E5gUYB48wGRlAS0sH1NNOtVAY0OVxJG6VPc6uJk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=av+Pc7h407kHTUFMgdBo3R2owf6hUst3nRbzozC6X4ucBJ8sxXoEle2C1YEun3Smu
 xo2+2PyjPEQyK0gvvRETG7NllDtoWvUB6d0Doa50UZ8a2RJLyjGuu3yNNdXO5x26AN
 RhJBQyVF8U1uzxOT1ExI6t+fGeFinh5AStnNmuTAk69d2yykahoK6RfADqKmDDxE0U
 ILDm5pkwTXeP2dWoAysqu1sbe2/Uqj4kcmhs/TbhpKYt99GVU1Vf6OOOfmse2mXz08
 XS9Go/b4BF6gYdsxPHtNohf4r36gBTmSe5qBYSzlKOYGOcwVzH4IcugaDdiLejKqL5
 p3Y7P6BPA6bNQ==
Message-ID: <sashiko-outbox-236889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/connector: Handle scaling mode property
 allocation failures
To: "Alex Kazinsky" <a.kazinsky@ideco.ru>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261126081602.2901498-5-a.kazinsky@ideco.ru>
References: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
 <20261126081602.2901498-5-a.kazinsky@ideco.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:39:05 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/gma500: unhandled gma_irq_install() error in
  psb_driver_load() [1]
--

commit 0fa9a1743597a5d0174fd433239776d4d22bf483
Author: Alex Kazinsky <a.kazinsky@ideco.ru>

drm/connector: Handle scaling mode property allocation failures

This commit returns -ENOMEM from drm_mode_create_scaling_mode_property()
when property creation fails and checks the return value in AMDGPU, GMA500,
Nouveau, and Radeon.

> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/ps=
b_drv.c
> index d17cb5b4a4bf2..6321cbc305bfd 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -386,7 +386,9 @@ static int psb_driver_load(struct drm_device *dev, un=
signed long flags)
> =20
>  	dev->max_vblank_count =3D 0xffffff; /* only 24 bits of frame count */
> =20
> -	psb_modeset_init(dev);
> +	ret =3D psb_modeset_init(dev);
> +	if (ret)
> +		goto out_err;
>  	drm_kms_helper_poll_init(dev);
> =20
>  	/* Only add backlight support if we have LVDS or MIPI output */

[Severity: High]
This problem wasn't introduced by this patch, but right above this hunk,
does psb_driver_load() (and similarly gma_power_resume()) ignore errors
from gma_irq_install() [1]?

drivers/gpu/drm/gma500/psb_drv.c:psb_driver_load() {
	...
	gma_irq_install(dev);

	dev->max_vblank_count =3D 0xffffff; /* only 24 bits of frame count */
	...
}

If request_irq() fails inside gma_irq_install(), the driver continues
initializing modesetting without working interrupts, causing vblank waits
and modeset operations to time out.

[1] https://sashiko.dev/#/bug/linux-c478675b-0011-4ea4-9556-c75f52fd7d08

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126081602.2901=
498-1-a.kazinsky@ideco.ru?part=3D4
