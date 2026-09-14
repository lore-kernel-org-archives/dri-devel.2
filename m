Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1E4C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBE910F0CD;
	Mon, 14 Sep 2026 17:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gUpA9lHN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12B410F0CD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:58:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57E326022A;
 Mon, 14 Sep 2026 17:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97171F000FF;
 Mon, 14 Sep 2026 17:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789408718;
 bh=kUgXRpcx5JNck7JzgKsbchBk4Ok0dijWYWXlPMtauW4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gUpA9lHNNQnTiGlDNxSFtPuhuzsftLEJzLZgb1YuLrEUzlIQWpwdNAPY4oHGDJnrT
 P59o/r7wDBgAjl+bA/wXScQDepKzLuZr6pBbsZZ/O2S6znXuUrDZo5+dv1lWH1L/rg
 DWwTr82ENFZAkWKc6983OX6C13rZOZfVoMaF5cqrRd5BdDZbh5vJUUsrfZMlGg4jeI
 jVsAyyekASvfyG9YLBwRhGqMzB92brRO9ypGt/xjLQBoDrzxeii+tQ68OfMIfFuSZz
 mNlAfNe/5HXPkscqEaOJdWP/50aChO1KblI6Zv8Lc0peWMdSqYFt53aX+KPK0R2QJH
 faYX0qRY5ccbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] backlight: qcom-wled: Fix unbalanced OVP IRQ
 enable at probe
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-qcom-wled-backlight-v2-2-a908d9233e93@ixit.cz>
References: <20260914-qcom-wled-backlight-v2-0-a908d9233e93@ixit.cz>
 <20260914-qcom-wled-backlight-v2-2-a908d9233e93@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:58:37 +0000
Message-Id: <20260914175837.D97171F000FF@smtp.kernel.org>
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
- [Critical] Missing platform_set_drvdata() in wled_probe() leads to a guar=
anteed NULL pointer dereference in wled_remove().
- [High] Incorrect teardown order in wled_remove() causes mutex use-after-d=
estroy and use-after-free via re-armed delayed work.
- [High] A race condition between wled_short_irq_handler() and wled_update_=
status() can leave the hardware module incorrectly enabled when requested o=
ff.
- [High] Missing cancel_delayed_work_sync() on the probe error path leads t=
o Use-After-Free if the short IRQ fires during probe.
- [High] wled_remove() unconditionally calls disable_irq() on short_irq and=
 ovp_irq, which may be unallocated or negative.
--

commit 43030df8f21835cdbc934e6ed48a2467d72a8a08
Author: David Heidelberg <david@ixit.cz>

backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe

wled_configure_ovp_irq() derives the initial state of the OVP interrupt
from the hardware but wled->brightness is left at zero. This patch moves
the MOD_EN readback into wled_probe() and seeds wled->brightness to fix
the unbalanced IRQ enable.

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index 22c35da72dce3..43e9f6f755582 100644
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
This isn't a regression introduced by this patch, but if
platform_get_irq_byname() fails, wled->ovp_irq retains the negative error
code, and wled_configure_ovp_irq() returns 0.

Later, during unbind:

drivers/video/backlight/qcom-wled.c:wled_remove() {
    ...
    disable_irq(wled->short_irq);
    disable_irq(wled->ovp_irq);
    ...
}

Does this unconditional disable_irq() risk passing an unallocated negative
value (or 0, if the threaded IRQ request fails and sets it to 0),
potentially crippling system IRQ 0?

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

[Severity: Critical]
This is a pre-existing regression, but I noticed wled_probe() successfully
registers the backlight device and returns:

drivers/video/backlight/qcom-wled.c:wled_probe() {
    ...
    bl =3D devm_backlight_device_register(&pdev->dev, wled->name,
                                        &pdev->dev, wled,
                                        &wled_ops, &props);
    return PTR_ERR_OR_ZERO(bl);
}

Since platform_set_drvdata() is never called in the probe path, won't
platform_get_drvdata(pdev) return NULL in wled_remove()?

drivers/video/backlight/qcom-wled.c:wled_remove() {
    struct wled *wled =3D platform_get_drvdata(pdev);
   =20
    mutex_destroy(&wled->lock);
    ...
}

Could this lead to a guaranteed NULL pointer dereference when the device
is unbound?

[Severity: High]
This is another pre-existing regression, but looking at the error paths at
the end of wled_probe():

If wled_configure_short_irq() succeeds, it registers and enables the
short IRQ immediately. If a subsequent step like wled_configure_ovp_irq() or
devm_backlight_device_register() fails, wled_probe() returns an error code:

drivers/video/backlight/qcom-wled.c:wled_probe() {
    ...
    rc =3D wled_configure_ovp_irq(wled, pdev);
    if (rc < 0)
        return rc;
    ...
}

If the hardware asserts the short IRQ concurrently during this failure,
wled_short_irq_handler() will run and schedule the delayed work:

drivers/video/backlight/qcom-wled.c:wled_short_irq_handler() {
    ...
    rc =3D wled_module_enable(wled, true);
    ...
}

Since there is no cancel_delayed_work_sync() on the probe error path,
will this result in a use-after-free when devres cleans up and frees the
wled struct while the delayed work is still queued?

[Severity: High]
This isn't a regression introduced by this patch, but looking at the
teardown sequence in wled_remove():

drivers/video/backlight/qcom-wled.c:wled_remove() {
    struct wled *wled =3D platform_get_drvdata(pdev);

    mutex_destroy(&wled->lock);
    cancel_delayed_work_sync(&wled->ovp_work);
    disable_irq(wled->short_irq);
    ...
}

If the short IRQ fires concurrently before disable_irq() is called, could
the IRQ handler attempt to acquire the destroyed mutex?

Additionally, since wled_short_irq_handler() unconditionally re-enables the
module, could it asynchronously re-arm wled->ovp_work after the cancellation
has already finished, leading to a use-after-free when the struct is freed?

[Severity: High]
This is also a pre-existing regression, but I noticed
wled_short_irq_handler() doesn't seem to check if the backlight was
intentionally disabled:

drivers/video/backlight/qcom-wled.c:wled_short_irq_handler() {
    ...
    msleep(WLED_SHORT_DLY_MS);
    rc =3D wled_module_enable(wled, true);
    ...
}

If userspace intentionally disables the backlight via wled_update_status()
by setting brightness to 0, and a short circuit IRQ fires concurrently or
shortly after, wouldn't the handler force the hardware back on?

Does this leave the hardware enabled indefinitely while the software state
considers it off, ignoring further requests to set brightness to 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-qcom-wled-=
backlight-v2-0-a908d9233e93@ixit.cz?part=3D2
