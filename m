Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AFDCD98D2
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2916C10F666;
	Fri, 12 Jun 2026 18:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c2WGr5Cy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D92B10F666
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:44:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 666A14436F;
 Fri, 12 Jun 2026 18:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DF01F000E9;
 Fri, 12 Jun 2026 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781289874;
 bh=b8Jo6qHTytRrEZTDb7wJE/6PN70bUtG9d5l/BfyVZiY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c2WGr5Cy8Sii3fY1lcka79JmHScjsuPpE/h64uRJi9BX+TcDLVZSfpKpUoWD9sNXh
 kiyO59UiRqwgF1J4uchqUuhQ5NiJtWgY+Kp2/6/iabdhEaQFxKSwUIYXR6GfGxHaY7
 Nqd++FUaYDWe8/5eq+sBJyqJazBue22P1yf+z+e/aRH/WvZzgIW5z6VJ1A7SAPsH3z
 lS/FEErHXMmb6t8ehI990glN9uyIBnPhT7382DEz5L0JDjVKs4gwUkwh8RGhGXBoM5
 P65z/fLcWCHzu9NeFsAhbBFeu2Z5MQ+VC4fOpRl/+PeTmshlGAtyGzbN5XRXsuit5H
 Vy9H6Nm3y7QHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] drm/vc4: use drmm_writeback_connector_init()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260612-wb-drop-encoder-v6-7-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-7-9f3a54f81310@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:44:33 +0000
Message-Id: <20260612184434.17DF01F000E9@smtp.kernel.org>
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
- [High] The patch converts the writeback connector to use DRM-managed init=
ialization (`drmm_writeback_connector_init`) but leaves the manual cleanup =
in `vc4_txp_unbind`, causing a double-free and NULL pointer dereference dur=
ing device teardown.
- [Medium] The commit message claims a change to encoder allocation that is=
 entirely absent from the patch.
--

commit 2e74a8f54aeae971a4434e6be6dd5849a3cfa4ff
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/vc4: use drmm_writeback_connector_init()

The driver uses drm_writeback_connector_init() instead of its drmm
counterpart, but it doesn't perform the job queue cleanup. The
drmm_writeback_connector_init() function ensures the proper cleanup of
the job queue.

> Use drmm_plain_encoder_alloc() to allocate simple encoder and
> drmm_writeback_connector_init() in order to initialize writeback
> connector instance.

[Severity: Medium]
This isn't a bug, but the commit message mentions using
drmm_plain_encoder_alloc(), yet this function isn't used anywhere in the pa=
tch.

The encoder remains embedded in struct vc4_txp and continues to be initiali=
zed
via drmm_encoder_init() in vc4_txp_bind().

Could the commit message be updated to match the actual code?

> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index 66b6f2acf8626..3fd89fccfa10a 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
[ ... ]
> @@ -602,10 +601,10 @@ static int vc4_txp_bind(struct device *dev, struct =
device *master, void *data)
> =20
>  	drm_connector_helper_add(&txp->connector.base,
>  				 &vc4_txp_connector_helper_funcs);
> -	ret =3D drm_writeback_connector_init_with_encoder(drm, &txp->connector,
> -							encoder,
> -							&vc4_txp_connector_funcs,
> -							drm_fmts, ARRAY_SIZE(drm_fmts));
> +	ret =3D drmm_writeback_connector_init(drm, &txp->connector,
> +					    &vc4_txp_connector_funcs,
> +					    encoder,
> +					    drm_fmts, ARRAY_SIZE(drm_fmts));

[Severity: High]
Since we are moving to drmm_writeback_connector_init(), which automatically
handles cleanup by registering a managed action, is it still safe to keep
the manual drm_connector_cleanup() call in vc4_txp_unbind()?

drivers/gpu/drm/vc4/vc4_txp.c:vc4_txp_unbind() {
	struct vc4_txp *txp =3D dev_get_drvdata(dev);

	drm_connector_cleanup(&txp->connector.base);
}

During teardown, vc4_txp_unbind() will manually clean up the connector,
but the drmm-managed action will later attempt to clean it up again when
the drm_device is released.

Does this cause a double-free or NULL pointer dereference on device teardow=
n?

>  	if (ret)
>  		return ret;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-wb-drop-en=
coder-v6-0-9f3a54f81310@oss.qualcomm.com?part=3D7
