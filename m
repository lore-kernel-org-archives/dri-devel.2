Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622C5C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 17:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F4010E0BE;
	Mon, 29 Jun 2026 17:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n7r5ciAc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E7610E0BE
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 17:48:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 74E4D43E8C;
 Mon, 29 Jun 2026 17:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54AE1F000E9;
 Mon, 29 Jun 2026 17:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782755307;
 bh=MfTr/mtdep6rnBuwtmYTFz4punSahPSjWj9qoNkHzMY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n7r5ciAcPbmfkBW2ZdQCpkaZXD11xBoFFboiZ2J/CsDlnTBWsk7cx8jo+697125tY
 ctVGMnQhoxbRdgOz0ZBewuSjLpQ4Effvz1YIdCEiXAsvzpNYUEPZYAMoKNFbd91lxy
 TkHMOfRmp2nf/IcqBhayTYAKPVHnLRstgxbqx87mEmJL0bI3Nq4fYhuBK70x3OLFDH
 tKlUUonDrag+lPnftTtE5jqQWN1LbZDpKzouE46qRXpR/E/XUq0WpVrSzRcmgGVChk
 vOUlmvdnPbiSr8ar+Wcc5abuIFJibCsvH3JxxKIX3tU13mJHIi6q9ENoNs4I2dqUIu
 VzCwh+xsp9LSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_init()
To: "Liam Zuiderhoek" <zuiderhoekl@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629173902.29415-1-zuiderhoekl@gmail.com>
References: <20260629173902.29415-1-zuiderhoekl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 17:48:26 +0000
Message-Id: <20260629174826.E54AE1F000E9@smtp.kernel.org>
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

New issues:
- [Medium] The commit claims to inline `drm_simple_encoder_init` for the en=
tire meson driver, but it only modifies `meson_encoder_hdmi.c`, leaving oth=
er encoders unconverted.

Pre-existing issues:
- [High] Missing `drm_bridge_remove()` on error paths in `meson_encoder_hdm=
i_probe()` leaves the bridge registered in the global `bridge_list`, leadin=
g to a dangling pointer and potential Use-After-Free.
--

commit 640b38eb942af61527b421bb5d62cb275bca9574
Author: Liam Zuiderhoek <zuiderhoekl@gmail.com>

GPU: drm: meson: inline call to drm_simple_encoder_init()

This commit inlines the function drm_simple_encoder_init for the meson
driver. It replaces the simple encoder init call with drm_encoder_init
and a custom cleanup struct.

> This commit inlines the function drm_simple_encoder_init for the meson
> driver.

[Severity: Medium]
Is the commit message description accurate for the scope of this patch?

The commit states it inlines the function for the meson driver, but this pa=
tch=20
only modifies the HDMI encoder (meson_encoder_hdmi.c).=20

The CVBS (meson_encoder_cvbs_probe) and DSI (meson_encoder_dsi_probe) encod=
ers=20
in the same driver still use drm_simple_encoder_init().

Should this patch update those files as well, or should the commit message =
be=20
clarified to specify it only targets the HDMI encoder?

> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm=
/meson/meson_encoder_hdmi.c
> index 55c0601df3c62..0dd3a76ad959e 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c

[ ... ]

> @@ -407,8 +411,9 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
>  	meson_encoder_hdmi->priv =3D priv;
> =20
>  	/* Encoder */
> -	ret =3D drm_simple_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
> -				      DRM_MODE_ENCODER_TMDS);
> +	ret =3D drm_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
> +			       &drm_simple_encoder_funcs_cleanup,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
>  	if (ret) {
>  		dev_err_probe(priv->dev, ret, "Failed to init HDMI encoder\n");
>  		goto err_put_node;

[Severity: High]
This is a pre-existing issue, but does this error path leave the bridge=20
registered in the global bridge list, leading to a potential use-after-free?

In meson_encoder_hdmi_probe(), drm_bridge_add() is called before the encode=
r=20
initialization.=20

If we fail here at drm_encoder_init() (or later during=20
drm_bridge_connector_init()), the code jumps to err_put_node which does not=
=20
call drm_bridge_remove():

err_put_node:
	of_node_put(remote);
	return ret;

Similarly, if cec_notifier_conn_register() fails later in the probe, it ret=
urns=20
directly without cleaning up the bridge.

The cleanup function meson_encoder_hdmi_remove() will not catch this becaus=
e=20
priv->encoders[MESON_ENC_HDMI] is only assigned at the very end of a succes=
sful=20
probe.=20

If the still-registered bridge is later found via of_drm_find_and_get_bridg=
e()=20
and its callbacks are invoked, could it dereference the freed priv pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629173902.2941=
5-1-zuiderhoekl@gmail.com?part=3D1
