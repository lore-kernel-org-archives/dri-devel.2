Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C0606D806
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBaYsXjs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2E110E9D3;
	Fri,  6 Nov 2026 11:33:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25F010E9D3
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 11:33:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EFF2860416;
 Fri,  6 Nov 2026 11:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1FE1F0089F;
 Fri,  6 Nov 2026 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793964815;
 bh=7P5zNMeKPnx3xe1x+0JQR513+3VjQobVS0eV+liJabI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BBaYsXjsA+14vNu+isWf9OBhbWRDKZBhJpWA+G1ObRRBKH/QVHlamg90aTHSfRM50
 u6GRPoU0gvug4D7eaHcYZ4sUTmGY6rmiIvopMnq/2vv1jv7YFVCD+z+mPwke6lmTOi
 JH9otBMbyp6A7epOjC9q2kggQEa8ozXHQzF3lkEHfovPg3wJZqstlw8U4xMMsggHMB
 XeptVkHsql9pguQSB7m3dmc6jKsCWZgvrtPEoMPu8stNs9p/GzvAUuUqDIvoiJlqCB
 ZOsiyonx3qrKFyprIa5LaQgDuK0H7LINcBP2JjcF9pPtY0mKGT4ovSInr1D0M+0CVM
 P8aNX2/LIHp/A==
Message-ID: <sashiko-outbox-201317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] drm/panel: Add the HiBy LG35583
To: "Olivier Louvignes" <olivier@mgcrea.io>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106112000.1612-6-olivier@mgcrea.io>
References: <20261106112000.1612-1-olivier@mgcrea.io>
 <20261106112000.1612-6-olivier@mgcrea.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:33:35 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/panel: hiby-lg35583: reverse regulator disable order in
  lg35583_unprepare()
--

commit d7b0c5c3d496f641bc7958504a4bf1c7175af30f
Author: Olivier Louvignes <olivier@mgcrea.io>

drm/panel: Add the HiBy LG35583

This commit adds a DRM panel driver for the HiBy LG35583 480x800 parallel
RGB panel configured over a 3-wire SPI bus.

> diff --git a/drivers/gpu/drm/panel/panel-hiby-lg35583.c b/drivers/gpu/drm=
/panel/panel-hiby-lg35583.c
> new file mode 100644
> index 0000000000000..47aba09e91a4c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-hiby-lg35583.c
[ ... ]
> +static int lg35583_prepare(struct drm_panel *panel)
> +{
> +	struct lg35583 *ctx =3D to_lg35583(panel);
> +	unsigned int i;
> +	int ret;
> +
> +	ret =3D regulator_enable(ctx->vccio);
> +	if (ret)
> +		return ret;
> +	usleep_range(5000, 6000);
> +
> +	ret =3D regulator_enable(ctx->vcc);
> +	if (ret)
> +		goto err_vccio;
[ ... ]
> +err_vcc:
> +	gpiod_set_value_cansleep(ctx->reset, 1);
> +	regulator_disable(ctx->vcc);
> +err_vccio:
> +	regulator_disable(ctx->vccio);
> +	return ret;
> +}
[ ... ]
> +static int lg35583_unprepare(struct drm_panel *panel)
> +{
> +	struct lg35583 *ctx =3D to_lg35583(panel);
> +
> +	lg35583_cmd(ctx, LG35583_SLPIN);
> +	usleep_range(5000, 6000);
> +
> +	gpiod_set_value_cansleep(ctx->reset, 1);
> +	regulator_disable(ctx->vccio);
> +	regulator_disable(ctx->vcc);
> +	return 0;
> +}

[Severity: Low]
Should lg35583_unprepare() disable ctx->vcc before ctx->vccio?
lg35583_prepare() enables ctx->vccio before ctx->vcc and disables ctx->vcc
first in its error path, whereas lg35583_unprepare() turns off the I/O
supply while the main panel supply is still enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106112000.1612=
-1-olivier@mgcrea.io?part=3D5
