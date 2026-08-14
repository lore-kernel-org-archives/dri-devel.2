Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C51C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 01:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD0AC10E03A;
	Fri, 14 Aug 2026 01:35:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TdCQzJba";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A7C10E03A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 01:35:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33E0441B19;
 Fri, 14 Aug 2026 01:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90D71F000E9;
 Fri, 14 Aug 2026 01:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786671336;
 bh=le3eD3k/b3+EcZD2/kTVUtNbs4TwbavbabZkJGpALv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TdCQzJba9nAjCzCvRH8FAn0JplxTt8uDGmWEXUj0SRyfdCgS0JzdTQfA/BMDh+goS
 DBZ9BEWVZsRo6aeL+42ehOzE+O5zoJE1+Qt2FMqPckl3B7aVsDy1Wr8osE1p7xGUbK
 2VSguFgYgRGN7cTOnX12/3BUR/iGlIIC1x3tZXU6KqhPTzoENNoo6RcbJa2KYD+aLi
 IkRYK0EXx4JHYPyiTC+OUJQVKDifG54hGUaPZGqs/KB88PLBalHwq34MoeqwPcdKHk
 viVZNrZgKsKWua6cG0bamEIt+RMETpz2hc2k8Qq0adBe9DDwJaXk0eyhrZp5zEnSiR
 7QJ4B76YLLUHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 56/78] drm/meson: encoder_hdmi: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-56-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-56-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:35:31 +0000
Message-Id: <20260814013535.C90D71F000E9@smtp.kernel.org>
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
- [High] Error paths in `meson_encoder_hdmi_probe` fail to remove the bridg=
e from the global `bridge_list` after it has been added, leading to a Use-A=
fter-Free (UAF).
--

--- Patch [56]: [PATCH v2 56/78] drm/meson: encoder_hdmi: Switch to atomic_=
create_state ---
commit ab73d61f7642f9fa6c7c0313f79338a817383c72
Author: Maxime Ripard <mripard@kernel.org>

drm/meson: encoder_hdmi: Switch to atomic_create_state

This commit removes the deprecated drm_bridge_funcs.atomic_reset callback
and its drm_atomic_helper_bridge_reset() helper. It switches to the
atomic_create_state callback instead.

> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm=
/meson/meson_encoder_hdmi.c
> index 55c0601df3c62..0c7a72cb514ae 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -366,7 +366,7 @@ static const struct drm_bridge_funcs meson_encoder_hd=
mi_bridge_funcs =3D {
>  	.atomic_check =3D meson_encoder_hdmi_atomic_check,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  };
> =20
>  int meson_encoder_hdmi_probe(struct meson_drm *priv)

[Severity: High]
This isn't a bug introduced by this patch, but does the error handling in
meson_encoder_hdmi_probe() fail to remove the bridge from the global list?

When the bridge is added:

	drm_bridge_add(&meson_encoder_hdmi->bridge);

	meson_encoder_hdmi->priv =3D priv;

	/* Encoder */
	ret =3D drm_simple_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
				      DRM_MODE_ENCODER_TMDS);
	if (ret) {
		dev_err_probe(priv->dev, ret, "Failed to init HDMI encoder\n");
		goto err_put_node;
	}

If an error occurs, the code jumps to err_put_node, which does not call
drm_bridge_remove().

Since devm cleanup will eventually free the memory, does leaving the freed
bridge linked in bridge_list cause a use-after-free when subsequent drivers
call of_drm_find_and_get_bridge()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D56
