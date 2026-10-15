Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384A3CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE7610E168;
	Thu, 15 Oct 2026 13:18:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28EDB10E168
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:18:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D86060120;
 Thu, 15 Oct 2026 13:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167BA1F000C4;
 Thu, 15 Oct 2026 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792070300;
 bh=9PntIKQaE1To8+0HAduGXshw3NMu44h/PB1DH+5aMBA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=cjIx4ruPDgGLGhrQ9sBmW4GYJDI+E0VyFh4zumvXJBT6qwFzUB/rt4UwgChnFKvwQ
 KSPrejkYekIciEdsUg4d6lDoQzzhUnSrrtzNLEDTVfX3+t48qR7rUbxnueDuqKoWU3
 6tt+xGl841/uRVClo/ptBhJsGzuEGnxNe7/7gN92m0jdNFRt8teL+wKgj3gigJzY+C
 NUw3F+gTTND0PsHqfuuA6SewTJF+wqfYO53NpGTWcA4JyIwagUdQ6p/UjbBTVc3RT1
 7ogCFLKOt7ZySwR+jV56E4nbijx8VGC4WQXVNWp9UZxKNBR9IABm/MM6sTV8kV/MA8
 VvcRkv0U8wtLQ==
Message-ID: <sashiko-outbox-172908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/panthor: Delegate neural power domain to CSF
 when present
To: "Daniel Stone" <daniels@collabora.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261015131301.711153-3-daniels@collabora.com>
References: <20261015131301.711153-1-daniels@collabora.com>
 <20261015131301.711153-3-daniels@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:18:19 +0000
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
- [Medium] panthor: resource leak due to incorrect LIFO label ordering in e=
rror path
- [Medium] panthor: incorrect hardware teardown order and duplicate TILER p=
ower-off
- [Low] panthor: build failure due to returning a label identifier
--

commit e4aa5571cda90f71765f06232acbfee948feed3e
Author: Daniel Stone <daniels@collabora.com>

drm/panthor: Delegate neural power domain to CSF when present

As the neural power domain is a child of the L2 power domain, control
over the L2 domain cannot be delegated to CSF unless the neural domain
has first been delegated. Given that we delegate all power control on
v14+, this eventually causes a hard lock-up and/or firmware OOPS when we
try to power on anything due to the inconsistent delegation state.

Fixes: ee4f9af07933 ("drm/panthor: Implement L2 power on/off via PWR_CONTRO=
L")

> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/pant=
hor/panthor_pwr.c
> index dd7b6ef8ea209..23954c863cc26 100644
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
> +		return err_retract_neural;

[Severity: Low]
Will this cause a build failure?

Because err_retract_neural is a label and not a declared variable, returnin=
g it
is invalid C syntax and results in a compiler error. Should this be a
goto err_retract_neural; instead?

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
> =20

[Severity: Medium]
Does this error path leak the NEURAL domain delegation?

The domains are delegated in the order: NEURAL -> SHADER -> TILER. On failu=
re,
they typically must be retracted in reverse order. However, the error labels
are ordered with err_retract_neural: placed before err_retract_shader:.

If TILER delegation fails, the code executes goto err_retract_shader;, retr=
acts
the SHADER domain, and immediately returns, bypassing the err_retract_neura=
l:
block above it.

Should the labels be swapped to correctly implement the teardown?

[ ... ]

> @@ -530,6 +552,13 @@ void panthor_pwr_l2_power_off(struct panthor_device =
*ptdev)
>  	 * host control to be powered down in the right order before powering
>  	 * down the L2.
>  	 */
> +	if (has_neural &&
> +	    panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_NEURAL))
> +		return;
> +
> +	if (panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_TILER))
> +		return;
> +
>  	if (panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_TILER))
>  		return;
> =20

[Severity: Medium]
Does this execute an incorrect hardware teardown order and duplicate the TI=
LER
power-off?

The NEURAL power-off block is placed above the existing TILER and SHADER bl=
ocks,
while also duplicating the TILER block. This causes
panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_TILER) to execute tw=
ice.

The execution sequence becomes NEURAL -> TILER -> TILER -> SHADER. This vio=
lates
the strict teardown order required by the hardware (delegation is NEURAL ->
SHADER -> TILER, so teardown must be TILER -> SHADER -> NEURAL).

Could this lead to invalid hardware states or timeouts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015131301.7111=
53-1-daniels@collabora.com?part=3D2
