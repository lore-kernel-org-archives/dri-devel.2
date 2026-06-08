Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF6CCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEF710F7A5;
	Mon,  8 Jun 2026 17:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PItO9ejy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437E810F7A5
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:11:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D1E9402B3
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57631F00893;
 Mon,  8 Jun 2026 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780938683;
 bh=g2vxtlJDibPw8A6H2z/iaz6npW9jQUcdpfglXiJiup0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PItO9ejyt+VTRur7870QaTXtifN+Q5a5VmsFFq4LarSyfDrkAYBAIMtQ3eTFywd4f
 yvSQO415RxE0J2iiahbKsF3U9gbhmhuWFpE2aVLQG/xUOPvVnUPHlcvTVpQ9YJaYWh
 E2RJ3fCp38EeV4SHBILm0AwI9RqXLPwPMhZy1KfeLbemnbgWOTqEqlckp7JqwA5pLL
 oYQJefhPq1jf4dN7/vWTXuw34u3Phrksp4Tw21LqS5Do7kLvEB/rccQfd/Zt6lXX92
 ahu8SnKcd70oEN+ispbtc+R7vuO2ZYraR29tWjsWlyKA7J/YzNGe05SSmZnzEf3IS4
 EoDttH7HdHSRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 46/78] drm/bridge: ti-tfp410: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-46-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-46-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:11:22 +0000
Message-Id: <20260608171122.E57631F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing Cleanup on Error Path
--

commit 1dbc8ff3ee3e816eec72de6095402106b128c956
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: ti-tfp410: Switch to atomic_create_state

This commit switches from the deprecated atomic_reset callback to the
atomic_create_state callback.

> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/=
ti-tfp410.c
> index bf4ab4eaf2697..6f06f7b4e9926 100644
> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> @@ -245,7 +245,7 @@ static const struct drm_bridge_funcs tfp410_bridge_fu=
ncs =3D {
>  	.enable		=3D tfp410_enable,
>  	.disable	=3D tfp410_disable,
>  	.mode_valid	=3D tfp410_mode_valid,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
>  	.atomic_get_input_bus_fmts =3D tfp410_get_input_bus_fmts,

[Severity: High]
This is a pre-existing issue, but when drm_connector_init_with_ddc() fails =
in
tfp410_attach(), it returns without cancelling dvi->hpd_work or calling
drm_bridge_hpd_disable() on dvi->bridge.next_bridge:

drivers/gpu/drm/bridge/ti-tfp410.c:tfp410_attach() {
	if (dvi->bridge.next_bridge->ops & DRM_BRIDGE_OP_HPD) {
		INIT_DELAYED_WORK(&dvi->hpd_work, tfp410_hpd_work_func);
		drm_bridge_hpd_enable(dvi->bridge.next_bridge,
				      tfp410_hpd_callback, dvi);
	}

	drm_connector_helper_add(&dvi->connector,
				 &tfp410_con_helper_funcs);
	ret =3D drm_connector_init_with_ddc(bridge->dev, &dvi->connector,
					  &tfp410_con_funcs,
					  dvi->bridge.next_bridge->type,
					  dvi->bridge.next_bridge->ddc);
	if (ret) {
		dev_err(dvi->dev, "drm_connector_init_with_ddc() failed: %d\n",
			ret);
		return ret;
	}
    ...
}

Because the DRM core does not call .detach() on a failed .attach(), the HPD
callback remains registered on the downstream bridge and the delayed work is
never cancelled.

If the device is subsequently unbound, dvi will be freed by devm. A subsequ=
ent
HPD event from the downstream bridge would execute tfp410_hpd_callback() wi=
th
the freed dvi pointer.

Could this lead to a use-after-free on dvi?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D46
