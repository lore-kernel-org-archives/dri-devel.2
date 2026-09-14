Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAE7C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A11010F12B;
	Mon, 14 Sep 2026 18:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ePuyoGtc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362AC10F12B
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:30:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C63A41AC6;
 Mon, 14 Sep 2026 18:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30601F000FF;
 Mon, 14 Sep 2026 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789410645;
 bh=AijHQR9JwnQReOU8RtDOn5PY0TyZgNRMr2vMHpETIkE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ePuyoGtcEzHAnsDHGpnt/Hz0DAQnh4vmSEmuzMw4/dgUAKDuD3S2rj+Mwhh0Jq4Fm
 3vAaqgYzDc334vcqZto9OrtdV4nmVLusOzReTIhS3BVasDgL2xlo+ajFHEkwmf4D7w
 KWUi9nxqcODun0+FaKdfbHw3ifuSwPbEHIwUkEBuO+kJFvEn3LknDPExDubdfJ1foL
 CpPqIkocfq3GPsN/BRAOp8T1iOj1Q75kSBDNBlybCNa+GjXYBVTs7OkUVjSW0Odfxg
 XtYSNwPIWCKdASAUubYcABjaGH0G9j4Y+ss1ZgRjnrxY0ChejU3finQJ6ZQFdPDk9o
 KNK70CzZRydXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] backlight: qcom-wled: Read back the programmed
 brightness at probe
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-qcom-wled-backlight-v3-4-d69fe9843841@ixit.cz>
References: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
 <20260914-qcom-wled-backlight-v3-4-d69fe9843841@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:30:45 +0000
Message-Id: <20260914183045.C30601F000FF@smtp.kernel.org>
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

New issues:
- [Critical] Type confusion and memory corruption in wled_remove() due to i=
ncorrect drvdata pointer.

Pre-existing issues:
- [High] Use-after-free on probe error path due to uncancelled delayed work.
--

commit 925c19cfe92bc196afb0b7a2001d793450d1b94f
Author: David Heidelberg <david@ixit.cz>

backlight: qcom-wled: Read back the programmed brightness at probe

Since the previous change wled_probe() seeds wled->brightness from
MOD_EN, but with default-brightness rather than the level the hardware
is actually driving, so a backlight left lit by the bootloader still
visibly steps on the first update. Add wled_read_brightness() to seed
both wled->brightness and the initial backlight property.

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index eb742a6598173..471a0cb2b81f6 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c

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
>  	platform_set_drvdata(pdev, bl);

[Severity: Critical]
Does this code incorrectly set the platform drvdata to a backlight_device
pointer instead of the expected wled structure pointer?

Looking at wled_remove(), it retrieves the platform drvdata but dereferences
it as a struct wled:

static void wled_remove(struct platform_device *pdev)
{
        struct wled *wled =3D platform_get_drvdata(pdev);

        mutex_destroy(&wled->lock);
        cancel_delayed_work_sync(&wled->ovp_work);
        ...
}

Because the memory layout does not match, can this cause type confusion,
destruction of uninitialized or unrelated mutexes, and guaranteed memory
corruption or a kernel panic on removal?

>  	return PTR_ERR_OR_ZERO(bl);

[Severity: High]
This is a pre-existing issue, but if devm_backlight_device_register() fails,
this function returns an error and devm frees the wled structure without
canceling any potentially scheduled delayed work. Is it possible for a
spurious IRQ to trigger a use-after-free here?

wled_probe() configures and implicitly enables the short IRQ earlier via
devm_request_threaded_irq(). It also configures the OVP IRQ, which sets
wled->ovp_irq > 0. If the short IRQ triggers during or just before this
failure, wled_short_irq_handler() will execute and call
wled_module_enable(wled, true).

Because wled->ovp_irq > 0, wled_module_enable() schedules the delayed work:

        schedule_delayed_work(&wled->ovp_work, HZ / 100);

Since the probe error path does not call cancel_delayed_work_sync(), this
leaves the work on the queue. When the delayed work executes, it calls:

static void wled_ovp_work(struct work_struct *work)
{
        struct wled *wled =3D container_of(work,
                                         struct wled, ovp_work.work);
        enable_irq(wled->ovp_irq);
}

Can this access the already freed wled structure during the delayed work
execution, resulting in a use-after-free?

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-qcom-wled-=
backlight-v3-0-d69fe9843841@ixit.cz?part=3D4
