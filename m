Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96B9C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 21:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E5A10E12C;
	Tue,  8 Sep 2026 21:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e0wc0Wnp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF0F10E12C
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 21:09:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73A42601DE;
 Tue,  8 Sep 2026 21:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099E21F00A3A;
 Tue,  8 Sep 2026 21:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788901787;
 bh=eErbz38Mvi8UKKqW6nugpbH3fFw7sA01g2WOGyK87T4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e0wc0WnpBX1jOkkNsdPrjpxtxznsSAx1K3vuitqpM4JBAt4wl9LBq1Q8MdPacV/cj
 N85lzFtCpbsBqNwJn0W/PloDIxLDNBwDCKTaVhDzIqx7OGVMwxJ6pEWsR0+PU13Cco
 TaAdkK358jvukvckWnh5N1hhblzZAxt+41aoPmT6+WmzBEP6K7mYLjG3OF/weS7Jr4
 caPoZTfIj3/sdNA/T5YZpE1X/5oU3gdi0KNPVoRghygQ/dbK4VsvgkVrI0gBBw2d9g
 A5lrSHpwBioefqC0IXAI4x2q2rdvjCv8vUdGZFDQDIzHbGBAbv4mUHYCUqRyv0dWe4
 OWNg0ACtqVGjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at
 probe
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz>
References: <20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:09:46 +0000
Message-Id: <20260908210947.099E21F00A3A@smtp.kernel.org>
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

New issues:
- [High] If default-brightness is 0, the OVP IRQ is incorrectly disabled wh=
ile the hardware module remains active, and the module cannot be subsequent=
ly disabled.

Pre-existing issues:
- [High] Missing platform_set_drvdata() in probe causes a guaranteed NULL p=
ointer dereference in wled_remove().
- [High] wled_remove() calls disable_irq() with negative or uninitialized I=
RQ values if the IRQs failed to map during probe.
- [High] Tearing down synchronization primitives in wled_remove() before th=
e devm-managed backlight is unregistered creates a use-after-free window.
- [High] WLED3 devices lack the wled_auto_detection_required function handl=
er, leading to a NULL pointer dereference if the OVP IRQ fires.
- [High] The short IRQ handler unconditionally re-enables the hardware modu=
le, overriding software intentions.
--

commit 5bacd29d54de18ff6f2680d6c09d873e1a8a3c3a
Author: David Heidelberg <david@ixit.cz>

    backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe

This commit fixes an issue where the OVP IRQ was unbalanced at probe. It re=
ads
the hardware module enable state to initialize the software brightness leve=
l,
and keys the OVP IRQ enable off this software state rather than the hardware
state to avoid mismatches.

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index 650dd95f06ef5..344b8cad90105 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1627,7 +1627,6 @@ static int wled_configure_ovp_irq(struct wled *wled,
>  				  struct platform_device *pdev)
>  {
>  	int rc;
> -	u32 val;
> =20
>  	wled->ovp_irq =3D platform_get_irq_byname(pdev, "ovp");
>  	if (wled->ovp_irq < 0) {

[Severity: High]
This is a pre-existing issue, but if platform_get_irq_byname() fails and
returns a negative error code, it is left in wled->ovp_irq without being
reset to 0.

Could this cause a regression during module removal?

drivers/video/backlight/qcom-wled.c:wled_remove() {
...
    disable_irq(wled->ovp_irq);
...
}

It appears wled_remove() calls disable_irq() unconditionally, which would
result in an out-of-bounds IRQ descriptor lookup or inadvertently disabling=
 a
system IRQ if wled->ovp_irq is negative.

[ ... ]
> @@ -1643,13 +1642,8 @@ static int wled_configure_ovp_irq(struct wled *wle=
d,
>  		return 0;
>  	}
> =20
> -	rc =3D regmap_read(wled->regmap, wled->ctrl_addr +
> -			 WLED3_CTRL_REG_MOD_EN, &val);
> -	if (rc < 0)
> -		return rc;
> -
> -	/* Keep OVP irq disabled until module is enabled */
> -	if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
> +	/* Keep the OVP irq disabled until the module is enabled */
> +	if (!wled->brightness)
>  		disable_irq(wled->ovp_irq);

[Severity: High]
If default-brightness is 0, wled->brightness will be seeded with 0 later in
wled_probe(). Will this incorrectly disable the OVP IRQ while the hardware
module remains active?

If the bootloader leaves the backlight ON, but default-brightness in the de=
vice
tree is 0, checking !wled->brightness instead of the hardware MOD_EN state
disables the OVP IRQ while hardware is still ON.

Additionally, a user space request to set brightness to 0 evaluates
!!0 !=3D !!0 as false, silently ignoring the request and leaving the hardwa=
re
permanently ON without OVP protection.

[ ... ]
> @@ -1734,6 +1729,24 @@ static int wled_probe(struct platform_device *pdev)
> =20
>  	INIT_DELAYED_WORK(&wled->ovp_work, wled_ovp_work);
> =20
> +	val =3D WLED_DEFAULT_BRIGHTNESS;
> +	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
> +
> +	/*
> +	 * The module may already be enabled, either by a bootloader that left
> +	 * the backlight lit or by the setup above. Record that, so that the
> +	 * first brightness update does not enable an already enabled module,
> +	 * and so that the OVP irq is armed from probe rather than from that
> +	 * first update.
> +	 */
> +	rc =3D regmap_read(wled->regmap, wled->ctrl_addr + WLED3_CTRL_REG_MOD_E=
N,
> +			 &mod_en);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (mod_en & WLED3_CTRL_REG_MOD_EN_MASK)
> +		wled->brightness =3D val;
> +

[Severity: High]
This isn't a bug introduced by this patch, but WLED3 devices lack the
wled_auto_detection_required function handler:

drivers/video/backlight/qcom-wled.c:wled_configure() {
...
    case 3:
        u32_opts =3D wled3_opts;
        size =3D ARRAY_SIZE(wled3_opts);
        *cfg =3D wled3_config_defaults;
        wled->wled_set_brightness =3D wled3_set_brightness;
        wled->wled_sync_toggle =3D wled3_sync_toggle;
...
}

Does this lead to a NULL pointer dereference if the OVP IRQ fires?

drivers/video/backlight/qcom-wled.c:wled_ovp_irq_handler() {
...
    if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
        if (wled->wled_auto_detection_required(wled)) {
            mutex_lock(&wled->lock);
...
}

[Severity: High]
This is a pre-existing issue, but the short IRQ handler unconditionally
re-enables the hardware module:

drivers/video/backlight/qcom-wled.c:wled_short_irq_handler() {
...
    rc =3D wled_module_enable(wled, true);
...
}

Does this override the software intentions if the backlight is logically OFF
(or being turned OFF) in wled->brightness when the short-circuit IRQ trigge=
rs?

This could cause the hardware backlight to become stuck ON, leading to perm=
anent
battery drain and incorrect state.

[ ... ]
> @@ -1742,9 +1755,6 @@ static int wled_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		return rc;
> =20
> -	val =3D WLED_DEFAULT_BRIGHTNESS;
> -	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
> -
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  	props.type =3D BACKLIGHT_RAW;
>  	props.brightness =3D val;

[Severity: High]
This is a pre-existing issue, but wled_probe() never calls
platform_set_drvdata() before returning successfully:

drivers/video/backlight/qcom-wled.c:wled_probe() {
...
    bl =3D devm_backlight_device_register(&pdev->dev, wled->name,
                                        &pdev->dev, wled,
                                        &wled_ops, &props);
    return PTR_ERR_OR_ZERO(bl);
}

Will this cause a guaranteed NULL pointer dereference in wled_remove() when
unbinding the driver?

drivers/video/backlight/qcom-wled.c:wled_remove() {
    struct wled *wled =3D platform_get_drvdata(pdev);

    mutex_destroy(&wled->lock);
...
}

[Severity: High]
This is another pre-existing issue, but tearing down synchronization primit=
ives
in wled_remove() before the devm-managed backlight is unregistered creates a
use-after-free window.

drivers/video/backlight/qcom-wled.c:wled_remove() {
...
    mutex_destroy(&wled->lock);
    cancel_delayed_work_sync(&wled->ovp_work);
...
}

The backlight device is registered via devm_backlight_device_register(), me=
aning
it remains active until devres cleanup after wled_remove() returns.

Could this lead to lock corruption or use-after-free if userspace accesses =
the
sysfs interface concurrently while the driver is being removed?

drivers/video/backlight/qcom-wled.c:wled_update_status() {
...
    mutex_lock(&wled->lock);
...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-qcom-wled-=
backlight-v1-1-c4dd4eabda07@ixit.cz?part=3D1
