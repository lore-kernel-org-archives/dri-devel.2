Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE0DCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F1910F78F;
	Mon,  8 Jun 2026 17:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="guxwd9ng";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C873910F78F
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:03:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 936394055C
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0F31F00893;
 Mon,  8 Jun 2026 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780938208;
 bh=4fs+qqIcZXUpUicScFWGq5imRcAmwybJuLtEyKUZTpY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=guxwd9ngkaV7b2lpVPTXHnESmSeZrGi0NfjXnhMeF5JA8aPzWqHcU/8KjTn4gk9Q6
 RfKolyaKlRI6jXEZxTRbC/5gUGqpUxZAiR1uvVZ5qMfjTQn/C8XphZ77LiA9FKl7Oj
 eyNWYQ5DbxePTg2Ecio5qtfS8Zd2BIoU6Q1r+wO42Wex0vx7W41ov/OTgUjImRc3Hv
 uouTVUKkybrzufneXXErjI/5gSOqsiJizF8/7R7Si7r8+XK7afYMYTxCaYNe0Vlop8
 F8OIAKQWfVPh/2sA/EpPzluoRg27QGlnl4gqPuxyU6GzyCp3Ajz8wjGcJJeJP1PMGm
 5dgzvGdKXWxCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 43/78] drm/bridge: ti-sn65dsi83: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-43-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-43-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:03:27 +0000
Message-Id: <20260608170328.0E0F31F00893@smtp.kernel.org>
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
- [High] The `reset_work` work item is never cancelled on driver unbind, re=
sulting in a potential Use-After-Free.
- [High] The return value of `devm_add_action()` is ignored in `sn65dsi83_a=
tomic_pre_enable()`, risking resource leaks and Use-After-Free.
--

commit 89a74ef02922861d8761592a3b63cea7724d9fa1
Author: Maxime Ripard <mripard@kernel.org>

    drm/bridge: ti-sn65dsi83: Switch to atomic_create_state
   =20
    The drm_bridge_funcs.atomic_reset callback and its
    drm_atomic_helper_bridge_reset() helper are deprecated.
   =20
    Switch to the atomic_create_state callback and its
    drm_atomic_helper_bridge_create_state() counterpart.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 42b451432bbb6..ec6390ee9943c 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -801,7 +801,7 @@ static const struct drm_bridge_funcs sn65dsi83_funcs =
=3D {
> =20
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  	.atomic_get_input_bus_fmts =3D sn65dsi83_atomic_get_input_bus_fmts,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free related to the reset_work item.  Does this code need a
cancel_work_sync() in the driver removal path?

In sn65dsi83_remove():

static void sn65dsi83_remove(struct i2c_client *client)
{
	struct sn65dsi83 *ctx =3D i2c_get_clientdata(client);

	drm_bridge_unplug(&ctx->bridge);
}

If the reset_work remains pending when sn65dsi83_remove() is called, the
devres cleanup will free the ctx memory.  Could this cause a use-after-free
when sn65dsi83_reset_work() subsequently executes and accesses the freed ctx
pointer?

[Severity: High]
This is a pre-existing issue, but the return value of devm_add_action()
appears to be ignored in sn65dsi83_atomic_pre_enable():

err_add_action:
	devm_add_action(ctx->dev, sn65dsi83_release_resources, ctx);
err_exit:
	drm_bridge_exit(idx);

If devm_add_action() fails, the cleanup action won't be registered.  When
disabled, devm_release_action() would skip executing
sn65dsi83_release_resources().

Could this bypass cancel_delayed_work_sync(&ctx->monitor_work) and leak the
regulator and GPIO states, potentially leading to a use-after-free of ctx w=
hen
devres frees it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D43
