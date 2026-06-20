Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F724CD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6258F10E286;
	Sat, 20 Jun 2026 19:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y0vVuWuI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7F710E286
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 19:33:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5D3C601E1;
 Sat, 20 Jun 2026 19:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE311F000E9;
 Sat, 20 Jun 2026 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781984023;
 bh=v20K2UI5rICGZ0hjGPo9WK2FW7yk/nyU0E3ym13BJts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y0vVuWuI7Su0PX993aITk8fzAgggU7c9vkD1kAQOAaxygwIxwJEieTA7x5jDaonTt
 6ZI95D4RkQPdV6ajDU/1X2NmBLdDjwVrHIttZ6ovVIXECw1Ri/h3UoBY/G8YS0EPXt
 TDCWTj+mC9ixv3vgxJlKCx67ir5z3IDP5L+VXj3zHxAkRD92kflftxrF5MoP/IZ+8A
 TD7xgpRU/1AfvHMwG/92csS0+vBUiQU88FVcYl7O6tHrXVtvLzbTt64m6LGWkW3PrO
 otlFyX9+TwoboZzBQJANEHAFi+m1s3RL/nus+fCBPpsv9AEZ9XR0Xj6p1iXe9/Y97l
 DI7tdoWm7QRBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tegra: Fix a strange error handling path
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <308ea09281bd0b3fb0ec7e90e23012c0783f373c.1781983379.git.christophe.jaillet@wanadoo.fr>
References: <308ea09281bd0b3fb0ec7e90e23012c0783f373c.1781983379.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 19:33:42 +0000
Message-Id: <20260620193343.4FE311F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition and Use-After-Free due to unreferenced pointer retu=
rned from drm_dp_aux_find_by_of_node().
- [High] Ignored get_device() failure leaves a dangling pointer leading to =
Use-After-Free on error paths.
- [High] Unbalanced i2c_put_adapter() on error path causes I2C adapter refe=
rence count underflow.
--

commit 214c0c58066e5c28266a88ecb7dc4e05a84c1ad9
Author: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

drm/tegra: Fix a strange error handling path

The commit fixes an error handling path in tegra_sor_probe() by returning
directly when devm_tegra_pmc_get() fails, instead of jumping to the put_aux
label which would release an uninitialized resource.

> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> index 4032c6ad45bc1..e384cbd0cbf72 100644
> --- a/drivers/gpu/drm/tegra/sor.c
> +++ b/drivers/gpu/drm/tegra/sor.c
> @@ -3764,10 +3764,8 @@ static int tegra_sor_probe(struct platform_device =
*pdev)
>  	sor->num_settings =3D sor->soc->num_settings;
> =20
>  	sor->pmc =3D devm_tegra_pmc_get(&pdev->dev);
> -	if (IS_ERR(sor->pmc)) {
> -		err =3D PTR_ERR(sor->pmc);
> -		goto put_aux;
> -	}
> +	if (IS_ERR(sor->pmc))
> +		return PTR_ERR(sor->pmc);
> =20
>  	np =3D of_parse_phandle(pdev->dev.of_node, "nvidia,dpaux", 0);
>  	if (np) {

[Severity: High]
This is a pre-existing issue, but can this lead to a race condition and a=20
use-after-free?

Looking at drm_dp_aux_find_by_of_node() in drivers/gpu/drm/tegra/dpaux.c, it
searches dpaux_list while holding dpaux_lock. Upon finding a match, it drops
the lock and returns a pointer to dpaux->aux without taking a reference=20
count on the device.

Because tegra_dpaux is a separate platform device, it can be concurrently
unbound, triggering tegra_dpaux_remove() and freeing the memory via devres.

When tegra_sor_probe() receives this pointer and calls
get_device(sor->aux->dev), if tegra_dpaux_remove() executes after the lock
is released but before get_device() is called, will this dereference
freed memory?

[Severity: High]
This isn't a bug introduced by this patch, but does the failure path of
get_device() leave a dangling pointer?

In tegra_sor_probe():

    if (get_device(sor->aux->dev))
        sor->output.ddc =3D &sor->aux->ddc;

If get_device() fails (returns NULL if the aux device is concurrently
removed), the failure is silently ignored. The output.ddc assignment is
skipped, but sor->aux remains set to the invalid pointer.

If a subsequent initialization step fails, the probe function jumps to
the put_aux label:

put_aux:
    if (sor->aux)
        put_device(sor->aux->dev);

Will this read the device structure from the dangling pointer and call
put_device() on freed memory, leading to a use-after-free?

[Severity: High]
This is a pre-existing issue, but does the error path in tegra_output_probe=
()
cause an I2C adapter reference count underflow?

In tegra_sor_probe(), sor->output.ddc is aliased to &sor->aux->ddc without
explicitly taking an I2C adapter reference via i2c_get_adapter().

The code then calls tegra_output_probe(&sor->output). If this function
encounters an error, it jumps to the put_i2c label:

drivers/gpu/drm/tegra/output.c:tegra_output_probe() {
    ...
put_i2c:
    if (output->ddc)
        i2c_put_adapter(output->ddc);
    ...
}

Since output->ddc points to the alias, i2c_put_adapter() will drop the
device and module reference without a matching get. Can this cause the
adapter to be prematurely freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/308ea09281bd0b3fb0e=
c7e90e23012c0783f373c.1781983379.git.christophe.jaillet@wanadoo.fr?part=3D1
