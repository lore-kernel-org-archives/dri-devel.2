Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D63C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98BD10E422;
	Thu, 23 Jul 2026 09:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k2YR18XQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED26310E422
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:51:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3332960A73;
 Thu, 23 Jul 2026 09:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41251F00A3A;
 Thu, 23 Jul 2026 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784800287;
 bh=l+A+nid6JUn1zlZFhVEBYIwODOqF8SfMLZBa4kfV0fg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k2YR18XQqgwemeFNCQXQc4ZyYx5DecNgscNCUteWtyBdxHvySPRJEJEsRXYexfTtY
 jakNocWPE1VRL41NtQmQvlh3q3JvmWkNaXtK02T5UenKJw0kPqLUr1JPr/XN7UL7xb
 2spTG2vAksghcCIsOKv/ZsfsAPSvUh8ElKu0h0LxVHytHclSFS8J0p/4Rho31nPN/S
 IuE0Dpqa7O2ssNeb3FdFUw/sqqlGHWJyHvEL7QvuTebgi+XQb0wlzFbtAIOzebd551
 588WNz5ABhmBxQi+166VVLBu/YyxQeIXMZGZuJF+ywB0iZeYrW2f0K3A9G+NCdIST8
 47KA8ruxy1tWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/bridge: sii9234: use extcon cable detection
 logic to detect MHL
To: "Henrik Grimler" <henrik@grimler.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-exynos4-sii9234-driver-v5-1-44b31b5597bd@grimler.se>
References: <20260723-exynos4-sii9234-driver-v5-1-44b31b5597bd@grimler.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:51:27 +0000
Message-Id: <20260723095127.B41251F00A3A@smtp.kernel.org>
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
- [High] Use-After-Free due to race between `flush_work()` and devres teard=
own.
- [High] Missing initial state check breaks display on coldplug.
- [Medium] Missing `return` statement after `dev_err_probe()` ignores initi=
alization errors.
--

--- Patch [1]: [PATCH v5] drm/bridge: sii9234: use extcon cable detection l=
ogic to detect MHL ---
commit 15547772b748ad5e9e79681b157e1cae684d850d
Author: Henrik Grimler <henrik@grimler.se>

drm/bridge: sii9234: use extcon cable detection logic to detect MHL

To use MHL we currently need the MHL chip to be permanently on, which
consumes unnecessary power. Let's use extcon attached to MUIC to enable
the MHL chip only if it detects an MHL cable.

> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/si=
i9234.c
> index be67642ab7d31..bf211906fefc6 100644
> --- a/drivers/gpu/drm/bridge/sii9234.c
> +++ b/drivers/gpu/drm/bridge/sii9234.c
[ ... ]
> @@ -864,6 +870,63 @@ static int sii9234_init_resources(struct sii9234 *ct=
x,
>  	return 0;
>  }
> =20
> +static void sii9234_extcon_work(struct work_struct *work)
> +{
> +	struct sii9234 *ctx =3D container_of(work, struct sii9234, extcon_wq);
> +	int state =3D extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
> +
> +	if (state =3D=3D ctx->cable_state)
> +		return;
> +
> +	ctx->cable_state =3D state;
> +
> +	if (state > 0)
> +		sii9234_cable_in(ctx);
> +	else
> +		sii9234_cable_out(ctx);
> +}
[ ... ]
> +static int sii9234_extcon_init(struct sii9234 *ctx)
> +{
[ ... ]
> +	ctx->extcon =3D edev;
> +	ctx->extcon_nb.notifier_call =3D sii9234_extcon_notifier;
> +	INIT_WORK(&ctx->extcon_wq, sii9234_extcon_work);
> +	ret =3D devm_extcon_register_notifier(ctx->dev, edev, EXTCON_DISP_MHL, =
&ctx->extcon_nb);
> +	if (ret)
> +		dev_err_probe(ctx->dev, ret, "failed to register notifier for MHL\n");
> +
> +	return 0;
> +}

[Severity: Medium]
Will this ignore initialization errors?

If devm_extcon_register_notifier() fails (for example, returning -EPROBE_DE=
FER
or -ENOMEM), the error is logged but ignored since there is no return state=
ment
after dev_err_probe(). The probe function completes successfully and assumes
ctx->extcon is active.

[ ... ]
> @@ -919,12 +982,17 @@ static int sii9234_probe(struct i2c_client *client)
[ ... ]
>  	i2c_set_clientdata(client, ctx);
> =20
>  	ctx->bridge.of_node =3D dev->of_node;
>  	drm_bridge_add(&ctx->bridge);
> =20
> -	sii9234_cable_in(ctx);
> +	if (!ctx->extcon)
> +		sii9234_cable_in(ctx);
> =20
>  	return 0;
>  }

[Severity: High]
Does this code skip setting the initial state if the cable is already plugg=
ed
in during boot?

Extcon notifiers trigger on state changes but do not automatically emit an
event for the current state upon registration. In sii9234_probe(), if an
extcon device is found, sii9234_cable_in() is skipped, but the driver never
queries the initial state.

If the cable is already connected when the driver probes, the hardware will
never be powered on, and the display will remain non-functional until the u=
ser
physically unplugs and replugs the cable.

> @@ -933,7 +1001,13 @@ static void sii9234_remove(struct i2c_client *clien=
t)
>  {
>  	struct sii9234 *ctx =3D i2c_get_clientdata(client);
> =20
> -	sii9234_cable_out(ctx);
> +	if (ctx->extcon) {
> +		flush_work(&ctx->extcon_wq);

[Severity: High]
Does this code introduce a race condition with the devres teardown?

Since the notifier is registered via devm_extcon_register_notifier(), it wi=
ll
only be unregistered after sii9234_remove() completes. If an extcon state
change occurs right after flush_work(&ctx->extcon_wq),
sii9234_extcon_notifier() will queue the work again.

Once sii9234_remove() completes, devres will unregister the notifier and
free ctx (allocated via devm_drm_bridge_alloc()). When the queued work exec=
utes
in sii9234_extcon_work():

	struct sii9234 *ctx =3D container_of(work, struct sii9234, extcon_wq);
	int state =3D extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);

it will dereference the freed ctx, resulting in a use-after-free.

> +		if (ctx->cable_state > 0)
> +			sii9234_cable_out(ctx);
> +	} else {
> +		sii9234_cable_out(ctx);
> +	}
>  	drm_bridge_remove(&ctx->bridge);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-exynos4-si=
i9234-driver-v5-1-44b31b5597bd@grimler.se?part=3D1
