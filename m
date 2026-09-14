Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E506C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E1E10E1F3;
	Mon, 14 Sep 2026 17:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bsvvWuIr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F30310E1F3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:57:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA4F2405F4;
 Mon, 14 Sep 2026 17:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD381F000FF;
 Mon, 14 Sep 2026 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789408619;
 bh=3HMso1qiw0//TEr5pmeLQJGc2mX13ZH6vkyvs6YeJK0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bsvvWuIrlrFxiys+TVOS7mD61CgcOJvMH+xE347NIISakKFFpAloRyCGz/YAexTr7
 7SPYo32w4vq2zQMI89b5eAbjqA3xzMpU6BqC5f8zknzETap4T/KaukRtHEj6J/FUta
 GOhIybp9jrByTLG/mLVkZqzPCbwmd2xw6xlpWCOsAM1cF7o32MYuG87jzO5mbSdRKr
 h1m2emloqeS/k+K5/d2mpIwK2xeAypCiAgitsLlhEp/hekDUyIjKMXvc/XTL90idCp
 eeUSo3ahEMMHic0GBwosrli09gGTZT/ruvXk+hAkp4iul5owwO9q56OZxJgi8UAKdY
 A3kzOPglPoBNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] backlight: qcom-wled: Read back the programmed
 brightness at probe
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-qcom-wled-backlight-v2-3-a908d9233e93@ixit.cz>
References: <20260914-qcom-wled-backlight-v2-0-a908d9233e93@ixit.cz>
 <20260914-qcom-wled-backlight-v2-3-a908d9233e93@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:56:58 +0000
Message-Id: <20260914175659.2CD381F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] wled_remove() dereferences a NULL pointer because platform_set=
_drvdata() is never called in wled_probe().
- [High] wled_auto_string_detection() hardcodes wled4_set_brightness() inst=
ead of using the wled_set_brightness() function pointer, corrupting WLED5 h=
ardware registers.
- [High] The asynchronous delayed work wled->ovp_work can execute after the=
 wled struct is freed on the probe error path.
- [High] Incorrect teardown sequence in wled_remove() causes use-after-dest=
roy on mutex and Use-After-Free on workqueue.
- [High] WLED3_SINK_REG_BRIGHT macro is incorrectly defined with a 16-byte =
stride instead of a 2-byte stride, causing brightness updates to corrupt un=
related registers.
--

commit 410b83154149a165bcd4c13790f405a3c5f2ac9d
Author: David Heidelberg <david@ixit.cz>

backlight: qcom-wled: Read back the programmed brightness at probe

This commit adds support to read the hardware brightness at probe time to a=
void
visible stepping if the bootloader left the backlight on. It introduces
wled_read_brightness() and wires it up to the backlight_ops get_brightness.

> A module that is enabled with the brightness registers at zero, which
> wled4_setup() and wled_auto_string_detection() can leave behind on a
> cold boot, now reads back as off.

[Severity: High]
This is a pre-existing issue, but since the commit message mentions
wled_auto_string_detection(), does this function incorrectly hardcode the W=
LED4
brightness setter for all versions?

Looking at wled_auto_string_detection(), it bypasses the
wled->wled_set_brightness() pointer and directly calls wled4_set_brightness=
():

drivers/video/backlight/qcom-wled.c:wled_auto_string_detection() {
    ...
    rc =3D wled4_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
    ...
    rc =3D wled4_set_brightness(wled, wled->brightness);
}

On WLED5 hardware, this writes to the WLED4 register instead of the proper
WLED5 registers, potentially corrupting hardware state when an OVP fault
occurs. Could this be updated to use the generic function pointer?

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index 43e9f6f755582..1acb3ee86878f 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c

[ ... ]

> @@ -290,6 +290,50 @@ static int wled5_set_brightness(struct wled *wled, u=
16 brightness)
>  	return rc;
>  }
> =20
> +static int wled_read_brightness(struct wled *wled)
> +{
> +	u16 addr, mask;
> +	__le16 v;
> +	u32 val;
> +	int rc;
> +
> +	rc =3D regmap_read(wled->regmap, wled->ctrl_addr + WLED3_CTRL_REG_MOD_E=
N,
> +			 &val);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
> +		return 0;
> +
> +	switch (wled->version) {
> +	case 3:
> +		addr =3D wled->sink_addr +
> +		       WLED3_SINK_REG_BRIGHT(wled->cfg.enabled_strings[0]);

[Severity: High]
This is a pre-existing issue, but does WLED3_SINK_REG_BRIGHT use an incorre=
ct
stride that corrupts other registers here and in wled3_set_brightness()?

Looking at the macro definition:
#define WLED3_SINK_REG_BRIGHT(n)            (0x40 + (n * 0x10))

The macro applies a 16-byte stride instead of a 2-byte stride. Because
WLED3_SINK_REG_STR_MOD_EN(n) also uses a 16-byte stride starting at 0x60,
evaluating WLED3_SINK_REG_BRIGHT(2) results in 0x60.

This aliases exactly with WLED3_SINK_REG_STR_MOD_EN(0), meaning brightness
updates for string 2 can accidentally overwrite the modulator enable for
string 0.

> +		mask =3D WLED3_SINK_REG_BRIGHT_MAX;
> +		break;

[ ... ]

> @@ -480,6 +524,18 @@ static int wled_update_status(struct backlight_devic=
e *bl)
>  	return rc;
>  }
> =20
> +static int wled_get_brightness(struct backlight_device *bl)
> +{
> +	struct wled *wled =3D bl_get_data(bl);
> +	int rc;
> +
> +	mutex_lock(&wled->lock);

[Severity: High]
This isn't a bug introduced by this patch, but does the teardown sequence in
wled_remove() allow a use-after-destroy here if this new sysfs method is
called concurrently?

wled_remove() prematurely destroys the mutex:

drivers/video/backlight/qcom-wled.c:wled_remove() {
    ...
    mutex_destroy(&wled->lock);
    cancel_delayed_work_sync(&wled->ovp_work);
    ...
}

Because the backlight device is registered with devm_backlight_device_regis=
ter,
it remains accessible in sysfs until devres cleanup runs after wled_remove()
finishes.

If a user reads the brightness via sysfs during this window,
wled_get_brightness() will lock a destroyed mutex. Could we move the resour=
ce
cleanup to a devm action or unregister the backlight explicitly?

> +	rc =3D wled_read_brightness(wled);
> +	mutex_unlock(&wled->lock);
> +
> +	return rc;
> +}

[ ... ]

> @@ -1757,7 +1809,7 @@ static int wled_probe(struct platform_device *pdev)
> =20
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  	props.type =3D BACKLIGHT_RAW;
> -	props.brightness =3D val;
> +	props.brightness =3D wled->brightness ?: val;
>  	props.max_brightness =3D wled->max_brightness;
>  	bl =3D devm_backlight_device_register(&pdev->dev, wled->name,
>  					    &pdev->dev, wled,
>  					    &wled_ops, &props);
>  	return PTR_ERR_OR_ZERO(bl);
>  }

[Severity: Critical]
This is a pre-existing issue, but does wled_remove() dereference a NULL poi=
nter
because we missed calling platform_set_drvdata() in probe?

If the driver is unbound, wled_remove() does:

drivers/video/backlight/qcom-wled.c:wled_remove() {
    struct wled *wled =3D platform_get_drvdata(pdev);
    mutex_destroy(&wled->lock);
    ...
}

Since platform_set_drvdata(pdev, wled) is never called in wled_probe(),
platform_get_drvdata() will return NULL, causing a crash on module removal.

[Severity: High]
This is also a pre-existing issue, but can the wled->ovp_work delayed work
execute after the wled structure is freed if this backlight registration fa=
ils?

If the short circuit interrupt fires during probe after
wled_configure_short_irq() enables it, the handler can call
wled_module_enable() which does:

drivers/video/backlight/qcom-wled.c:wled_module_enable() {
    ...
    schedule_delayed_work(&wled->ovp_work, HZ / 100);
    ...
}

If devm_backlight_device_register() subsequently fails, wled_probe() returns
an error. Devres will free the wled structure, but the delayed work is never
cancelled on the probe error path, resulting in a use-after-free when the
work executes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-qcom-wled-=
backlight-v2-0-a908d9233e93@ixit.cz?part=3D3
