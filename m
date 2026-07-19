Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7506C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B76C10E062;
	Sun, 19 Jul 2026 16:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P1c8rXQO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106D010E062
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 16:12:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87E8A418A5;
 Sun, 19 Jul 2026 16:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338E91F000E9;
 Sun, 19 Jul 2026 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784477540;
 bh=QPojCu8695FmOIJAR+PnWB0P0sTsfrGDpjrI268PMYA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P1c8rXQO4vhJaDkEENBdYpY4TMPKQJYcE+xwFI188g5HdbkeiwQrN1wbKDlq/EsBO
 dRymV+ZQEl3AJoE6iJ+UJspkndd0efdpEDXx5bQEcUAjnUTgTuDMj0EYMosEvd55AK
 jFA0uLqHPakPY5pq3FqzrxrH+wdEp5m1y3VKG0YbxO83ISeFuG+mtluIgG1o3LvQtF
 qPXJ3Dcg+i/nk75FEhjxSk2zPBzetMAUGa2Vj0WvPfvVk0aMK7w3+5JhjH4Dk8rnE0
 TIO4PiWBDOUZsfKQaOVOkQvQ6+oIDKT4rZw5/cuH0yCQ4fOVbFKr+rX5oswg2iUV/w
 7ZstfrNA03pUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm/bridge: add support for lontium lt9211c bridge
To: vishnu.saini@oss.qualcomm.com
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
References: <20260719-add-lt9211c-bridge-v6-0-e56d22152586@oss.qualcomm.com>
 <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 16:12:19 +0000
Message-Id: <20260719161220.338E91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Missing cancellation of the delayed work in the disable path leads=
 to I2C writes to an unpowered/reset device.
- [High] The delayed work timer is not cancelled during driver removal, res=
ulting in a critical use-after-free.
- [High] The dynamically allocated workqueue is leaked if probe fails durin=
g host attach.
- [High] LVDS format configurations (bpp24, jeida, de) are left uninitializ=
ed when queuing the delayed work, resulting in incorrect hardware configura=
tion.
- [High] Deferring hardware enablement to a delayed workqueue violates DRM =
atomic subsystem guarantees.
- [Low] Signed error codes from `regmap_write()` are accumulated using bitw=
ise OR, mangling the error values.
--

--- Patch [2]: [PATCH v6 2/2] drm/bridge: add support for lontium lt9211c b=
ridge ---
commit 1ae4415156f1af5c0293e73eda918915f0e313c8
Author: Yi Zhang <zhanyi@qti.qualcomm.com>

drm/bridge: add support for lontium lt9211c bridge

Adds support for the LT9211C variant to the existing lt9211 driver.
It detects the chip by ID, adds a new regmap for LT9211C, and implements
DSI-to-LVDS init sequences. A delayed workqueue is used to configure
LT9211C after the DSI clock is running.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/br=
idge/lontium-lt9211.c
> index f39d83a5ae377..36c004df34fcd 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
> @@ -454,6 +526,651 @@ static int lt9211_configure_tx(struct lt9211 *ctx, =
bool jeida,
> [ ... ]
> +static int lt9211c_configure_plls(struct lt9211 *ctx,
> +				  const struct drm_display_mode *mode)
> +{
> [ ... ]
> +	if (mode->clock < 44000) {
> +		ret =3D regmap_write(ctx->regmap, 0xd00c, 0x60);
> +		ret |=3D regmap_write(ctx->regmap, 0xd01b, 0x00);
> +		ret |=3D regmap_write(ctx->regmap, 0xd01c, 0x60);
> +	} else {
> +		ret =3D regmap_write(ctx->regmap, 0xd00c, 0x40);
> +		ret |=3D regmap_write(ctx->regmap, 0xd01b, 0x00);
> +		ret |=3D regmap_write(ctx->regmap, 0xd01c, 0x40);
> +	}

[Severity: Low]
Does using bitwise OR here mangle the signed error codes returned by=20
regmap_write()?

Accumulating negative error values via bitwise OR creates a different=20
negative value, which destroys the semantic meaning of the original error
code.

> [ ... ]
> @@ -523,6 +1240,15 @@ static void lt9211_atomic_enable(struct drm_bridge =
*bridge,
>  	if (ret)
>  		return;
> =20
> +	if (ctx->chip_type =3D=3D LT9211C && ctx->wq) {
> +		drm_mode_copy(&ctx->mode, mode);
> +		/* LT9211C must enable after mipi clock enable */
> +		queue_delayed_work(ctx->wq, &ctx->lt9211_dw,
> +				   msecs_to_jiffies(100));
> +		dev_dbg(ctx->dev, "LT9211C enabled.\n");
> +		return;
> +	}

[Severity: High]
Does this code fail to save the LVDS format configurations to the context
struct?=20

The variables jeida, bpp24, and de are extracted from the bridge state=20
earlier in this function, but they are never saved to ctx->jeida, ctx->bpp2=
4,=20
or ctx->de before queuing the work. When lt9211c_configure_tx() runs later=
=20
in the workqueue, won't it read uninitialized (zero) values for these field=
s?

[Severity: High]
By deferring the hardware initialization to a delayed workqueue, does this=
=20
introduce a regression violating the DRM atomic subsystem's expectation that
the hardware is fully configured when atomic_enable completes?=20

If the goal is to wait for the upstream DSI host to enable its clock first,=
=20
would it be better to set the pre_enable_prev_first flag on the bridge rath=
er=20
than bypassing the synchronous atomic commit design?

[Severity: High]
What happens if the display pipeline is rapidly disabled before this 100ms
timer expires?=20

Since this patch introduces a delayed work item, if the driver's disable pa=
th
powers off the chip and asserts reset:

lt9211_atomic_disable()
    gpiod_set_value(ctx->reset_gpio, 0);
    usleep_range(10000, 11000);
    ret =3D regulator_disable(ctx->vccio);

without calling cancel_delayed_work_sync(), the delayed work could execute
on a powered-down device, leading to I2C timeouts and bus lockups.

> [ ... ]
> @@ -747,10 +1489,25 @@ static int lt9211_probe(struct i2c_client *client)
> [ ... ]
> +	if (ctx->chip_type =3D=3D LT9211C) {
> +		ctx->wq =3D create_workqueue("lt9211_work");
> +		if (!ctx->wq)
> +			return -ENOMEM;
> +		INIT_DELAYED_WORK(&ctx->lt9211_dw, lt9211_delayed_work_func);
> +	}
> +
>  	dev_set_drvdata(dev, ctx);
>  	i2c_set_clientdata(client, ctx);
> =20
> @@ -768,17 +1525,22 @@ static void lt9211_remove(struct i2c_client *clien=
t)
>  	ctx->bridge.of_node =3D dev->of_node;
>  	drm_bridge_add(&ctx->bridge);
> =20
>  	ret =3D lt9211_host_attach(ctx);
>  	if (ret)
>  		drm_bridge_remove(&ctx->bridge);
> =20
>  	return ret;
>  }

[Severity: High]
If lt9211_host_attach() returns an error like -EPROBE_DEFER, does this erro=
r=20
path leak the dynamically allocated workqueue?=20

It looks like destroy_workqueue(ctx->wq) is missing before returning, which=
=20
could lead to resource exhaustion if probe is deferred multiple times.

>  static void lt9211_remove(struct i2c_client *client)
>  {
>  	struct lt9211 *ctx =3D i2c_get_clientdata(client);
> =20
> +	if (ctx->wq)
> +		destroy_workqueue(ctx->wq);
> +
>  	drm_bridge_remove(&ctx->bridge);
>  }

[Severity: High]
Can this result in a regression where a use-after-free occurs if the delayed
work timer is still pending during driver removal?=20

destroy_workqueue() flushes active work, but it does not cancel pending=20
timers for delayed works. Should we call=20
cancel_delayed_work_sync(&ctx->lt9211_dw) before destroying the workqueue t=
o=20
prevent the timer from firing after the context is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719-add-lt9211=
c-bridge-v6-0-e56d22152586@oss.qualcomm.com?part=3D2
