Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F0DC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A80C510E1EA;
	Mon, 14 Sep 2026 18:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n8P8hDcz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C407910E1EA
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:32:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 171AB60142;
 Mon, 14 Sep 2026 18:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31261F000FF;
 Mon, 14 Sep 2026 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789410771;
 bh=V+/3EQ15SLOhMk+WaACJbIhbmlsxDBMGK9m3yji9CFM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n8P8hDczUV6ya8WVMcDktmJAdjH7R33QZkc5aZo//4WZnwGJp7bmVP+2jped6+fFz
 2t/IoIb/PNq2Al21TvB94tYAIIUZGgDvZ+/+wyONoGrr97jN7ZKz8sPNRvRWyO8LGJ
 0ZFs+02QS9tEs9k59PgG60ZnicuLbvnNEH7spapCbhmbHRvZDJm7c72bt6Nojwotwo
 6BQHCh5h/zgdzYolD1nJUrGyPJbSwUCwVnIwNsyQd5sh4l2oxOSVW3W92471CQFJ6e
 QNCHbpFNW6J1RZggTKDj8CEmZLZLUb4SxI9rgzx2I7CKg9rI7yA2BnSRpcwxXHKkB7
 dkOAJlczH0wxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] backlight: qcom-wled: Fix unbalanced OVP IRQ
 enable at probe
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-qcom-wled-backlight-v3-3-d69fe9843841@ixit.cz>
References: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
 <20260914-qcom-wled-backlight-v3-3-d69fe9843841@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:32:51 +0000
Message-Id: <20260914183251.A31261F000FF@smtp.kernel.org>
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
- [High] Hardware over-voltage protection (OVP) interrupt is incorrectly di=
sabled if the module is active but software evaluates brightness as 0, leav=
ing the hardware unprotected.

Pre-existing issues:
- [Critical] Type mismatch in driver data leads to memory corruption and ke=
rnel panic in wled_remove().
- [High] AB-BA Deadlock between `wled_update_status` and `wled_ovp_irq_hand=
ler` via `disable_irq()`.
- [High] Unsafe `disable_irq()` calls in `wled_remove()` with potentially i=
nvalid or uninitialized IRQ numbers.
- [High] Destroying the driver mutex and cancelling work before unregisteri=
ng the backlight device creates a use-after-destroy race condition via sysf=
s.
- [High] Delayed work `wled->ovp_work` can be scheduled during device probe=
 but is not cancelled on probe error paths, causing a Use-After-Free.
--

commit fc9aa7b480cc714e361a97ee0c2edec0701360bf
Author: David Heidelberg <david@ixit.cz>

backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe

This commit fixes an issue where the OVP interrupt is disabled during probe
even if the backlight is already enabled by the bootloader. It does this by
checking the hardware MOD_EN register during probe and seeding
wled->brightness appropriately.

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index e1962c2d90ed4..eb742a6598173 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
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
Does this leave the hardware unprotected if the module is active but softwa=
re
evaluates brightness as 0?

If wled4_setup() explicitly sets MOD_EN to 1, and the initial brightness
evaluates to 0 (either via default-brightness or wled_read_brightness),
wled->brightness becomes 0. Could this cause disable_irq() to strip
protection from the active module?

Furthermore, if userspace later writes 0 to turn off the screen, could
wled_update_status() check (0 !=3D 0), skip wled_module_enable(0), and
leave the unprotected hardware permanently on?

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
                 ^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
If default-brightness evaluates to 0, will wled->brightness become 0 here
despite MOD_EN being active?

[Severity: Critical]
This is a pre-existing issue, but does a type mismatch in the driver data l=
ead
to memory corruption in wled_remove()?

wled_probe() incorrectly sets the platform drvdata to the backlight device:

drivers/video/backlight/qcom-wled.c:wled_probe() {
	...
	bl =3D devm_backlight_device_register(...);
	platform_set_drvdata(pdev, bl);
	return PTR_ERR_OR_ZERO(bl);
}

wled_remove() retrieves this pointer and incorrectly casts it to a
struct wled *:

drivers/video/backlight/qcom-wled.c:wled_remove() {
	struct wled *wled =3D platform_get_drvdata(pdev);

	mutex_destroy(&wled->lock);
	...
}

Since struct backlight_device has a completely different memory layout than
struct wled, does this type confusion corrupt arbitrary memory when unbindi=
ng?

[Severity: High]
This is a pre-existing issue, but does destroying the mutex and cancelling
work before unregistering the backlight device create a use-after-destroy
race condition?

The backlight device is registered using devm_backlight_device_register(),
which defers unregistration until after wled_remove() completes.

However, wled_remove() manually performs cleanup while the backlight device
is still active and its sysfs interface is exposed:

drivers/video/backlight/qcom-wled.c:wled_remove() {
	...
	mutex_destroy(&wled->lock);
	cancel_delayed_work_sync(&wled->ovp_work);
	...
}

Could a concurrent sysfs write to the brightness attribute invoke
wled_update_status() and attempt to acquire the already-destroyed mutex?

drivers/video/backlight/qcom-wled.c:wled_update_status() {
	...
	mutex_lock(&wled->lock);
	...
}

[Severity: High]
This is a pre-existing issue, but could a delayed work use-after-free occur
if probe fails?

If the hardware asserts a short circuit condition early, the threaded short
IRQ handler can execute and schedule wled->ovp_work:

drivers/video/backlight/qcom-wled.c:wled_module_enable() {
	...
	schedule_delayed_work(&wled->ovp_work, HZ / 100);
	...
}

If probe subsequently fails during backlight device registration:

drivers/video/backlight/qcom-wled.c:wled_probe() {
	...
	bl =3D devm_backlight_device_register(...);
	platform_set_drvdata(pdev, bl);
	return PTR_ERR_OR_ZERO(bl);
}

Will devres silently free the wled structure without canceling the scheduled
delayed work, causing a crash when the workqueue later executes?

[Severity: High]
This is a pre-existing issue, but can this sequence lead to an AB-BA deadlo=
ck?

wled_update_status() acquires the mutex before attempting to disable
the module:

drivers/video/backlight/qcom-wled.c:wled_update_status() {
	...
	mutex_lock(&wled->lock);
	...
	rc =3D wled_module_enable(wled, !!brightness);
	...
}

wled_module_enable() spin-waits for any currently executing OVP interrupt
handlers to finish while holding the mutex:

drivers/video/backlight/qcom-wled.c:wled_module_enable() {
	...
	disable_irq(wled->ovp_irq);
	...
}

Concurrently, if the OVP interrupt fires on another CPU, the handler begins
executing and blocks attempting to acquire the same mutex:

drivers/video/backlight/qcom-wled.c:wled_ovp_irq_handler() {
	...
	mutex_lock(&wled->lock);
	...
}

Would CPU 1 hold the lock and wait for the IRQ handler, while CPU 2 runs the
handler and waits for the lock?

[Severity: High]
This is a pre-existing issue, but does wled_remove() unconditionally disable
potentially invalid IRQs?

If devm_request_threaded_irq() fails, wled_configure_ovp_irq() explicitly
sets ovp_irq to 0:

drivers/video/backlight/qcom-wled.c:wled_configure_ovp_irq() {
	...
	if (rc < 0) {
		wled->ovp_irq =3D 0;
		return 0;
	...
}

Additionally, platform_get_irq_byname() can return negative error codes.
However, wled_remove() appears to disable both IRQs without validation:

drivers/video/backlight/qcom-wled.c:wled_remove() {
	...
	disable_irq(wled->short_irq);
	disable_irq(wled->ovp_irq);
	...
}

Could passing a negative value cause out-of-bounds descriptor lookups, and
could passing 0 disable an essential system interrupt like the timer IRQ?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-qcom-wled-=
backlight-v3-0-d69fe9843841@ixit.cz?part=3D3
