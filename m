Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352CE606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0tx8oQl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7596310E6C9;
	Tue, 17 Nov 2026 21:14:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FFFE10E6C9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:14:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 472CE40E40;
 Tue, 17 Nov 2026 21:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047571F000C7;
 Tue, 17 Nov 2026 21:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794950089;
 bh=V8kL6x12scOB+Z7e0rCNbxdkqZUX/USGRsJsjXbEKxU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E0tx8oQlSRcPHRj5xk7zlZlZV4EB7XmwPG098xQmYw848V8YmI/QEcyk6gEOCZLce
 CbRS85zj/FTxjS2WnMiyGmrXTCJzBXdlRyFHyo+WhB4810kgv2Y0q5Xg0llKfBUT5j
 FcUPwwZKAMdZZpgTioHc5AZ/dE2mFHA4N8YXWTGkvy2L69ZFgEF1c9juG5SAwLpGKk
 kTykG98se7Yeo4ClMew+9PPo3dp2v8CeX0aFshhaTkyOiI2w5dzU8jkQp24zuzid58
 bBP9TTewPeBf3b+CXCpnJMxhn/ZTXOrQiIecqwLLG6Yn1Pm3EV3LQmhHFxKCJFh8Fd
 iwtWK7K/wf0ag==
Message-ID: <sashiko-outbox-219679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: dsi: Allocate the encoder per DRM device
To: "Henry Zhang" <henryzhang62@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261117205902.1293962-1-henryzhang62@gmail.com>
References: <20261117205902.1293962-1-henryzhang62@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 21:14:48 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/vc4: dsi: unmanaged OF clock provider in
  vc4_dsi_init_phy_clocks() [1]
--

commit 809765ced535c89f7b7aa0f22cdfc9aa61cc56b3
Author: Henry Zhang <henryzhang62@gmail.com>

drm/vc4: dsi: Allocate the encoder per DRM device

This commit moves the VC4 DSI encoder out of struct vc4_dsi into a
DRM-managed struct vc4_dsi_encoder allocated in vc4_dsi_bind() so that
re-binding the DSI component while an older DRM device is still open does
not reuse or corrupt the old encoder.

> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index ec008f766dd5b..5bd8f579b515a 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c

[ ... ]

> @@ -1758,12 +1765,16 @@ static int vc4_dsi_bind(struct device *dev, struc=
t device *master, void *data)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D drmm_encoder_init(drm, encoder,
> -				&vc4_dsi_encoder_funcs,
> -				DRM_MODE_ENCODER_DSI,
> -				NULL);
> -	if (ret)
> -		return ret;
> +	dsi_encoder =3D drmm_encoder_alloc(drm, struct vc4_dsi_encoder, base.ba=
se,
> +					 &vc4_dsi_encoder_funcs,
> +					 DRM_MODE_ENCODER_DSI, NULL);
> +	if (IS_ERR(dsi_encoder))
> +		return PTR_ERR(dsi_encoder);
> +
> +	dsi_encoder->dsi =3D dsi;
> +	dsi_encoder->base.type =3D dsi->variant->port ?
> +		VC4_ENCODER_TYPE_DSI1 : VC4_ENCODER_TYPE_DSI0;
> +	encoder =3D &dsi_encoder->base.base;
> =20
>  	ret =3D devm_pm_runtime_enable(dev);
>  	if (ret)

[Severity: Critical]
This problem wasn't introduced by this patch, but does
vc4_dsi_init_phy_clocks() just above this hunk leave a dangling OF clock
provider behind [1] when vc4_dsi_bind() later fails or the component
is unbound?

drivers/gpu/drm/vc4/vc4_dsi.c:vc4_dsi_init_phy_clocks() {
	dsi->clk_onecell =3D devm_kzalloc(dev, ...);
	...
	return of_clk_add_hw_provider(dev->of_node,
				      of_clk_hw_onecell_get,
				      dsi->clk_onecell);
}

Because vc4_dsi_init_phy_clocks() registers the provider with the unmanaged
of_clk_add_hw_provider() instead of devm_of_clk_add_hw_provider(),
unbinding the component (or failing later in vc4_dsi_bind(), such as when
drm_bridge_attach() returns -EBUSY) frees the devres-managed
dsi->clk_onecell while the provider stays on of_clk_providers, causing a
use-after-free in of_clk_hw_onecell_get() on subsequent clock lookups.

[1] https://sashiko.dev/#/bug/linux-4c5f4ec7-e4cd-4631-aa06-37e8551cebec

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117205902.1293=
962-1-henryzhang62@gmail.com?part=3D1
