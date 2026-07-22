Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FB5C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DAB10E4CF;
	Wed, 22 Jul 2026 20:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DEwy/dy6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B961510E4CF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 20:46:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01A3C60051;
 Wed, 22 Jul 2026 20:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815281F000E9;
 Wed, 22 Jul 2026 20:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784753181;
 bh=rWSba6subFqr7XtDQFE+tfhQeFN5BabLrbDEwyTBLRE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DEwy/dy68Hg52FvRhwXRBu3Xho++anA0EO5azSTYWEHm4L4fDzeDVVg3/RbACCfax
 N0n+QZdQ8/UlKvkTYhadmOvIJZIlWa3KmuiVm+ggLbR9SjOxSMT/1DPLnjKjxrqxvk
 EmswILkB4gXzvklWcdCmXTNPBzJxn89Ij0ebsXehRCAlXLOD1yST6pPU/x3qe0BCni
 dXBIn7gfnXUsgZ1e/9SngupmNRZEg+g0PHTfRxMUSLC5+zK24Kf7Q83i9A42Rc6N2G
 AuExabS0uJJUe9uNBx2an87ot4uhHFj5l2ZEDE96Ir3wctxCnTypuBqntU8E3QWCpI
 08Urhn7OHP0Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/11] drm/bridge: it6505: unregister DP AUX adapter
 on bridge detach
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <a472535bc291e77aee5cae71ea2a26d695511fd6.1784717129.git.daniel@makrotopia.org>
References: <cover.1784717129.git.daniel@makrotopia.org>
 <a472535bc291e77aee5cae71ea2a26d695511fd6.1784717129.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 20:46:21 +0000
Message-Id: <20260722204621.815281F000E9@smtp.kernel.org>
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
- [High] Removing `drm_dp_aux_unregister()` from `it6505_i2c_remove()` intr=
oduces a critical Use-After-Free vulnerability if the I2C driver is unbound=
 while the DRM bridge remains attached.
--

--- Patch [3]: [PATCH v5 03/11] drm/bridge: it6505: unregister DP AUX adapt=
er on bridge detach ---
commit b259e088ec0ed97d1f41a3a8463e232914e7c924
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: unregister DP AUX adapter on bridge detach

This commit moves the DP AUX adapter unregistration from the I2C remove
path to the bridge detach and attach error paths. This is intended to
prevent duplicate registrations when unbinding and rebinding the DRM
device.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c

[ ... ]

> @@ -3652,7 +3654,6 @@ static void it6505_i2c_remove(struct i2c_client *cl=
ient)
>  	struct it6505 *it6505 =3D i2c_get_clientdata(client);
> =20
>  	drm_bridge_remove(&it6505->bridge);
> -	drm_dp_aux_unregister(&it6505->aux);

[Severity: High]
Does removing drm_dp_aux_unregister() here introduce a use-after-free
if the I2C driver is unbound while the DRM bridge remains attached?

If the I2C driver is unbound (for example, via sysfs) while the DRM
device is still active, the DP AUX character device (/dev/drm_dp_auxN)
appears to remain registered because drm_bridge_remove() does not invoke
it6505_bridge_detach() when the bridge is removed from the global list.

After it6505_i2c_remove() returns, the driver core's devres cleanup will
execute and free the it6505 structure and its managed resources, such as
the regmap.

If userspace subsequently interacts with the leaked character device,
it can invoke it6505_aux_transfer() which dereferences the freed memory:

drivers/gpu/drm/bridge/ite-it6505.c:it6505_aux_transfer() {
	struct it6505 *it6505 =3D container_of(aux, struct it6505, aux);
	...
	// accesses freed it6505 and performs I/O on freed it6505->regmap
}

Should drm_dp_aux_unregister() be kept in the I2C remove path as well,
or is there another mechanism guaranteeing the AUX character device is
unregistered before devres cleanup occurs?

>  	it6505_debugfs_remove(it6505);
>  	it6505_remove_notifier_module(it6505);
>  	disable_irq(it6505->irq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784717129.gi=
t.daniel@makrotopia.org?part=3D3
