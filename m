Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE1CC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5F310F402;
	Sat, 25 Jul 2026 03:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gt4bMWxH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEDB10F402
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:17:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F249D600AD;
 Sat, 25 Jul 2026 03:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818A51F000E9;
 Sat, 25 Jul 2026 03:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784949429;
 bh=nDN/EP+/SGgBQ/3/i9yrlNg4A4i6vRxytwvIvj27ze0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gt4bMWxHd6bZI0Ixh+BXZkWAYkF9EzB5y1bBrWQCBj7e0Ahe0INtDGBuEp3TtPQZr
 izIrunHrxyGE95rpj5x7rMOnJxtpWv1LWUdHB6IsfYJOQTV6BAvyDf0BZWZ/WRRnWR
 MtVqLdT4uXqY535JecrqsgT6nHMg6fNyitdGI53sgzejvgt6ve1I6gBjJGeKD0jyab
 /j9yc813n1nE1TdC2fojq/QacQiUHcPnQPtQmRHW9Mnl2uC60Om3NPZe0yE4Z/fxkD
 y81M6SFHiiQFweGnNl2PejwYHzIUPzKc8oOdGXWL3Kqrqe9BuKvuUPXY+IYG+mDCvh
 HOYLmNsWAqN1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/13] drm/bridge: it6505: unregister DP AUX adapter
 on bridge detach
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <e18f8cf3b9c6993c9d628f28f64b0f39c111e2a7.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <e18f8cf3b9c6993c9d628f28f64b0f39c111e2a7.1784947240.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 03:17:09 +0000
Message-Id: <20260725031709.818A51F000E9@smtp.kernel.org>
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
- [High] Removing `drm_dp_aux_unregister()` from the I2C `remove` function =
causes a use-after-free and leaves a zombie DP AUX adapter if the I2C drive=
r is unbound while the DRM device remains attached.
--

--- Patch [3]: [PATCH v6 03/13] drm/bridge: it6505: unregister DP AUX adapt=
er on bridge detach ---
commit d6c69e9e1c11461da60c039acb301f1120930d47
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: unregister DP AUX adapter on bridge detach

This commit moves the DP AUX adapter unregistration from the I2C remove
routine to the DRM bridge detach and attach error paths, to avoid
registering the adapter multiple times during unbind/rebind cycles.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 7c61b02cc7e60..c10cc6a786b5d 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
[ ... ]
> @@ -3106,6 +3107,7 @@ static void it6505_bridge_detach(struct drm_bridge =
*bridge)
> =20
>  	flush_work(&it6505->link_works);
>  	it6505_remove_notifier_module(it6505);
> +	drm_dp_aux_unregister(&it6505->aux);
>  }
> =20
[ ... ]
> @@ -3654,7 +3656,6 @@ static void it6505_i2c_remove(struct i2c_client *cl=
ient)
>  	struct it6505 *it6505 =3D i2c_get_clientdata(client);
> =20
>  	drm_bridge_remove(&it6505->bridge);
> -	drm_dp_aux_unregister(&it6505->aux);

[Severity: High]
Does removing drm_dp_aux_unregister() here cause a use-after-free if the I2C
driver is unbound while the DRM device is still attached?

If the I2C driver is unbound (e.g., via sysfs) while the DRM display
controller is still bound, it6505_i2c_remove() is called. The
drm_bridge_remove() call only moves the bridge to a lingering list and
does not immediately call it6505_bridge_detach().

Because drm_dp_aux_unregister() was removed from this path, the AUX adapter
remains registered. When the remove function returns, devres frees the
it6505 structure.=20

Could a local user trigger a use-after-free by accessing the leaked
/dev/drm_dp_auxN character device or I2C sysfs nodes which now point to
the freed structure?

Since i2c_del_adapter() and drm_dp_aux_unregister_devnode() both contain
safety guards against unregistered adapters, is it safer to leave
drm_dp_aux_unregister() in the remove path as well to ensure it is always
unregistered before devres frees the memory?

>  	it6505_debugfs_remove(it6505);
>  	it6505_remove_notifier_module(it6505);
>  	disable_irq(it6505->irq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784947240.gi=
t.daniel@makrotopia.org?part=3D3
