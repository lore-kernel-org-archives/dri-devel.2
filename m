Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9FE606A330
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsSId3GG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD59112984;
	Fri, 27 Nov 2026 10:16:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB02112984
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:15:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 794A241697
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293171F000C1;
 Fri, 27 Nov 2026 10:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774555;
 bh=Ee8GXp4xjV7v5Y34cA3qq6FSqLMtlRynCf3o2qgvr3s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SsSId3GGFVodveiI06qYSJUzLfa9NSUnBblQkCDhiix22kfPqvsMvNzSWDvl3jLPg
 kwoatvEyiyMC3QHiouug6dgaZXHsdzPDBh+5ad5VpY1++qpeCfGoOoyz92yo84pDd8
 NneoDaVYjqmlShec6VthJLIvtJkX8bfj9QvJEsisz5fl0iTSL0OLBRUC0EMJ80AKAF
 Ro11Tgm+gKxVurLmVb6tlSueTLsXjz4hcD2KxYHpY46IOvcBcblxEElyC2Q4rFvPAy
 4u+/9QFA4VD/KiHKITHvrKMc70twcObQ7mOA/mDpibiVrkFLTDYcZ1u7NZeHztAD9s
 5Etv5lyo2uRiQ==
Message-ID: <sashiko-outbox-237077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 25/36] drm/tidss: Implement hw_reset
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-25-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-25-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:15:54 +0000
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
- [Medium] drm/tidss: request_irq() called before hardware reset in
  tidss_probe()
--

commit b7be101c4a90886c580dfd2b9acb390dc70de5c1
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: Implement hw_reset

This commit moves the DISPC hardware reset out of dispc_init() into a new
drm_mode_config_funcs.hw_reset callback so the hardware is only reset on
the reset path during initial state creation.

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 8c4d7e148eb0e..e186c63ba5fb9 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
[ ... ]
> @@ -3003,10 +2994,6 @@ int dispc_init(struct tidss_device *tidss)
>  	of_property_read_u32(dispc->dev->of_node, "max-memory-bandwidth",
>  			     &dispc->memory_bandwidth_limit);
> =20
> -	r =3D dispc_init_hw(dispc);
> -	if (r)
> -		return r;
> -
>  	tidss->dispc =3D dispc;
> =20
>  	return 0;

[Severity: Medium]
Can moving the hardware reset from dispc_init() to
drm_mode_config_create_initial_state() allow tidss_irq_handler() to fire
while the device is still runtime-suspended?

Commit d4652187367b ("drm/tidss: IRQ code cleanup") dropped hardware IRQ
masking from tidss_irq_install() because dispc_init() had already reset
the hardware and masked all IRQs before request_irq().  With the reset
deferred to drm_mode_config_create_initial_state(), tidss_probe() now
calls tidss_irq_install() -> request_irq() before the hardware is reset:

drivers/gpu/drm/tidss/tidss_drv.c:tidss_probe() {
    ...
	ret =3D tidss_irq_install(ddev, irq);
	if (ret) {
		dev_err(dev, "tidss_irq_install failed: %d\n", ret);
		goto err_runtime_suspend;
	}

	drm_kms_helper_poll_init(ddev);

	ret =3D drm_mode_config_create_initial_state(ddev);
    ...
}

If the bootloader or a previous kexec kernel left DISPC interrupts
enabled, an interrupt arriving after request_irq() will run
tidss_irq_handler() -> dispc_read_and_clear_irqstatus() while the device
is runtime-suspended and dispc->fclk is disabled, causing unclocked MMIO
register accesses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D25
