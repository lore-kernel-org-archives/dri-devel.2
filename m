Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D74CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8977C10E5AA;
	Thu, 15 Oct 2026 13:59:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B1410E267
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:59:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C8E9C60200;
 Thu, 15 Oct 2026 13:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639A51F000C4;
 Thu, 15 Oct 2026 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072739;
 bh=lQ4iNRsgVlgE6fN3jnDVeXJXJzpXp4yggpHZqd2vZig=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=efo9LPfK40jQu9eIG28qZlW+Gq843E5V+YmQJqjCse5kfxT48OvDi2ZJoxERR0SWS
 TGUS4rXs2ssDEf4xtcZX+cc/ZswAz6lZwLo65oX9PMlOsDl/TelNuQz69VgQtnF1ad
 ngXg3O/jbWan/HDAqRhoM5dFfiVyv3+qG9VTmH+QbcpWfCyddlo/zWT+7/TiLk4GNO
 J7cRoP7lK/LWwOIvASGzLOTW2ORJD73sljiLmA4ImaOwZMmCOxJ+AW9QiX5Zw6bE53
 NFYCj7F2RsUMHXHHcWrFqZvvOnyP2xOE5bvMCBYHxf9XAkRmWns1Fz/Al4MPtyLVyq
 iE1MazpaJMtlg==
Message-ID: <sashiko-outbox-172942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/panthor: Delegate neural power domain to CSF
 when present
To: "Daniel Stone" <daniels@collabora.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261015135116.713461-3-daniels@collabora.com>
References: <20261015135116.713461-1-daniels@collabora.com>
 <20261015135116.713461-3-daniels@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:58:59 +0000
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
- [High] drm/panthor: resource leak due to inverted error labels in delegat=
e_domains
- [High] drm/panthor: incorrect error cleanup and teardown order violates L=
IFO
--

commit c290abd8b3c0e64a66dafb547bc7c789688cb8df
Author: Daniel Stone <daniels@collabora.com>

    drm/panthor: Delegate neural power domain to CSF when present

This commit delegates the neural power domain to the CSF before delegating
other domains to prevent a hard lock-up or firmware OOPS on v14+.
It also updates power state transitions and debugging output for the
neural domain.

> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/pant=
hor/panthor_pwr.c
> index dd7b6ef8ea209..7a841cfa86fd5 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
[ ... ]
> @@ -405,9 +418,15 @@ static int panthor_pwr_delegate_domains(struct panth=
or_device *ptdev)
>  	if (!ptdev->pwr)
>  		return 0;
> =20
> +	if (panthor_hw_has_neural(ptdev)) {
> +		ret =3D delegate_domain(ptdev, PWR_COMMAND_DOMAIN_NEURAL);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret =3D delegate_domain(ptdev, PWR_COMMAND_DOMAIN_SHADER);
>  	if (ret)
> -		return ret;
> +		goto err_retract_neural;
> =20
>  	ret =3D delegate_domain(ptdev, PWR_COMMAND_DOMAIN_TILER);
>  	if (ret)
> @@ -415,6 +434,8 @@ static int panthor_pwr_delegate_domains(struct pantho=
r_device *ptdev)
> =20
>  	return 0;
> =20
> +err_retract_neural:
> +	retract_domain(ptdev, PWR_COMMAND_DOMAIN_NEURAL);
>  err_retract_shader:
>  	retract_domain(ptdev, PWR_COMMAND_DOMAIN_SHADER);

[Severity: High]
Does this skip retracting the NEURAL domain on a TILER delegation failure?

If delegate_domain(ptdev, PWR_COMMAND_DOMAIN_TILER) fails, the code jumps to
err_retract_shader. Because the err_retract_shader label is placed below
err_retract_neural, it skips retracting the NEURAL domain.

Since the commit message notes that an inconsistent delegation state causes=
 a
hard lock-up or firmware OOPS, shouldn't the labels be placed in LIFO order
so err_retract_shader can fall through to err_retract_neural?

> =20
> @@ -530,6 +552,10 @@ void panthor_pwr_l2_power_off(struct panthor_device =
*ptdev)
>  	 * host control to be powered down in the right order before powering
>  	 * down the L2.
>  	 */
> +	if (has_neural &&
> +	    panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_NEURAL))
> +		return;
> +
>  	if (panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_TILER))
>  		return;
> =20

[Severity: High]
Does this violate the LIFO teardown order for the power domains?

In panthor_pwr_delegate_domains(), the domains are delegated in the order:
NEURAL, SHADER, TILER.

Here in panthor_pwr_l2_power_off(), the NEURAL domain is forced off before
TILER and SHADER. Should the teardown order be TILER, SHADER, then NEURAL
to safely unwind the delegation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015135116.7134=
61-1-daniels@collabora.com?part=3D2
