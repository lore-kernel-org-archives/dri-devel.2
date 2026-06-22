Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F643CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F6910E7E4;
	Mon, 22 Jun 2026 19:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mYATQ9io";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54BA510E7E4
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 19:41:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C7AF601F3;
 Mon, 22 Jun 2026 19:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228451F000E9;
 Mon, 22 Jun 2026 19:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782157303;
 bh=ev1es4hTmKfw06JQVhllEegKEEaCvR+Zx8NKVJoUQ9g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mYATQ9iotijk7lzEDfWVmUtlSrhcifb0Pkoc1JsnrAi8IqmpPa6kgCboFUIZGyoRl
 o1FPxkTzMBvfsDuMUxhCCvedP0nIodjDF3YYuY23KR5D1dW4efp9BKZM8WEJEAxw7F
 ukn7COC6huXsFF612KMDc6uwFGjGVOTyEyC/FU7MC7rogFAT7V7WLPJPkrlzl1iuoo
 ktTZTS+2dp1t/eXomnRDwcVuF7KYxawxrnpbd80WHS1X8pktWmc/K6q5tXukezTuJR
 404uaFUnrwZ+NPDsdqSxO3y0FPRoTLi9txevxSxmMg/mAdFUn18vDwaqwqH3/y3wNu
 QQaj4xt06Peqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_init()
To: "Liam Zuiderhoek" <zuiderhoekl@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622193250.211429-1-zuiderhoekl@gmail.com>
References: <20260622193250.211429-1-zuiderhoekl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:41:42 +0000
Message-Id: <20260622194143.228451F000E9@smtp.kernel.org>
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
- [Low] The patch introduces a duplicate definition of the `drm_simple_enco=
der_funcs_cleanup` structure, causing a build failure.
--

commit 2bbec9d596493f3ca9a28c3ddb628d5753d83aa2
Author: Liam Zuiderhoek <zuiderhoekl@gmail.com>

GPU: drm: meson: inline call to drm_simple_encoder_init()

This commit inlines the function drm_simple_encoder_init for the meson
driver. It replaces the simple encoder init call with drm_encoder_init
and a custom cleanup struct.

> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm=
/meson/meson_encoder_hdmi.c
> index 55c0601df3c62..f4100e23dd270 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -44,9 +44,17 @@ struct meson_encoder_hdmi {
>  	struct cec_notifier *cec_notifier;
>  };
> =20
> +static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup =
=3D {
> +	.destroy =3D drm_encoder_cleanup,
> +};
> +
>  #define bridge_to_meson_encoder_hdmi(x) \
>  	container_of(x, struct meson_encoder_hdmi, bridge)
> =20
> +static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup =
=3D {
> +	.destroy =3D drm_encoder_cleanup,
> +};

[Severity: Low]
Does this code cause a compiler error? It appears that the static structure
drm_simple_encoder_funcs_cleanup is defined twice in the same file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622193250.2114=
29-1-zuiderhoekl@gmail.com?part=3D1
