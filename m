Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492A3CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A364910F677;
	Thu,  1 Oct 2026 13:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="byQUjLMW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAFD610F677
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:01:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AA76415B6;
 Thu,  1 Oct 2026 13:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585E41F000FF;
 Thu,  1 Oct 2026 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790859682;
 bh=9E2kSyttxXvOS90cVrgaVyXoUTGZcBLnJy0WM9wTRNI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=byQUjLMWZVqfe3kYCCb5KhdRUFco1rlZGbetR4nN0AaB4Au5+ydOwIrwhbGwAsJFF
 3sdYhRZFWbXC2BYARJqnVjiV/+bLp/9yJAzureKLHLVZHlpGxo6rmwVBLn1v/LrbXz
 lcFizL1aKr5L0xRzs5P3ZEBGJ0OmeceeJaZLXQajUnBRkgX9VdajJST1GbHLMAiBRT
 ewaAfsabWhKEmChsPD/M+SaMLS9ETLkYKmyO4ZWQrszsttftQrttuIetO8st5JS6Mv
 ODMRFps2fpcFr4O5MuIruqnTONYnbF8f4CA690zTPBepruKWEotCSYInmY+7hjSkoy
 U2U5fq6MjiDvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 07/24] drm/bridge: samsung-dsim: move
 drm_bridge_add() call to probe
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261001-drm-bridge-hotplug-v2-7-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-7-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:01:21 +0000
Message-Id: <20261001130122.585E41F000FF@smtp.kernel.org>
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
- [High] drm/bridge: samsung-dsim: UAF in samsung_dsim_attach() due to data=
 race
--

commit c28866fd6b4a2bff1ae13053f73c850e270af34a
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: samsung-dsim: move drm_bridge_add() call to probe

This bridge driver calls drm_bridge_add() in the DSI host .attach callback
instead of in the probe function. This looks strange, even though
apparently not a problem for currently supported use cases.

[ ... ]

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 480e568dd2c9d..b2de447dc6f43 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1827,6 +1827,9 @@ static int samsung_dsim_attach(struct drm_bridge *b=
ridge,
>  {
>  	struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> =20
> +	if (!dsi->bridge.next_bridge)
> +		return 0;
> +
>  	return drm_bridge_attach(encoder, dsi->bridge.next_bridge, bridge,
>  				 flags);
>  }

[Severity: High]
Could this lockless read of next_bridge introduce a use-after-free
regression due to a time-of-check to time-of-use race condition?

Since drm_bridge_add() is now called in probe(), the upstream encoder can
attach the bridge while the downstream panel is asynchronously probing.
This allows samsung_dsim_attach() to run concurrently with
samsung_dsim_host_detach().

If the panel concurrently unbinds or detaches, samsung_dsim_host_detach()
can clear the downstream bridge locklessly via:

    drm_bridge_clear_and_put(&dsi->bridge.next_bridge);

If this concurrent clearing happens between the check here and the
subsequent internal drm_bridge_get() call within drm_bridge_attach(),
could the kernel execute a kref_get() on a freed bridge pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D7
