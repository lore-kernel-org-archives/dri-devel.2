Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1538C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F7D10EC92;
	Wed, 22 Jul 2026 07:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bBuBS1Z4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D941D10EC92
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:09:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C99660A67;
 Wed, 22 Jul 2026 07:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58491F000E9;
 Wed, 22 Jul 2026 07:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784704161;
 bh=yfyu/KanP6qnriRYguQnjXMHbf/YnrvRqa028R6znig=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bBuBS1Z4EUsjYDKNiTv4RV6jx6cli5kVnZ0trpNZ7h8NLtDOGe8SAMGQyx0SSZA5M
 euxck/mNDregqShi67CJVUUp5QDi35RNXsuB226naD+6W5EtdS3r1QQC+fPn+0T+9D
 0e/ZCU7fkStO3EKgvo47xtrzO1xcBZypNir8gGOAGdN13c/PvdPRJB1dtBXfGn+RSF
 vc1uFTb4lrdWlKuhu9aYZoRUr88k0fJXaXOGbWFWO/lCd2kKtRHjDkIqZOpft7Gw2/
 3RKx+iYNP6LZ9FIabARiylAjIFDWlDBiEyPtflFIo+a91RanVo/XLVO/+PRZkB1rvI
 X1B0QloRSCYnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] backlight: qcom-wled: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722065709.346072-1-panchuang@vivo.com>
References: <20260722065709.346072-1-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:09:20 +0000
Message-Id: <20260722070920.E58491F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] Incomplete cleanup of redundant dev_err() after devm_request_thread=
ed_irq().

Pre-existing issues:
- [High] Unconditional calls to disable_irq() during driver removal can use=
 negative or 0 IRQ values, leading to crashes or disabling critical system =
IRQs.
- [High] Teardown race condition in wled_remove() allows sysfs and IRQ acce=
ss to a destroyed mutex.
- [Medium] The driver swallows -EPROBE_DEFER from platform_get_irq_byname()=
, leading to permanent feature loss.
--

--- Patch [1]: [PATCH] backlight: qcom-wled: Remove redundant dev_err() ---
commit d0dd0e4fe4ebc4391de7914a6014d4894f4acea9
Author: Pan Chuang <panchuang@vivo.com>

backlight: qcom-wled: Remove redundant dev_err()

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index 8054e4787725e..650dd95f06ef5 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1639,8 +1639,6 @@ static int wled_configure_ovp_irq(struct wled *wled,
>  				       wled_ovp_irq_handler, IRQF_ONESHOT,
>  				       "wled_ovp_irq", wled);
>  	if (rc < 0) {
> -		dev_err(wled->dev, "Unable to request ovp_irq (err:%d)\n",
> -			rc);
>  		wled->ovp_irq =3D 0;
>  		return 0;
>  	}

[Severity: Low]
Is this cleanup incomplete? Looking at wled_configure_short_irq(), it appea=
rs
there is another call to dev_err() after devm_request_threaded_irq() that w=
as
left behind:

drivers/video/backlight/qcom-wled.c:wled_configure_short_irq()
    ...
	rc =3D devm_request_threaded_irq(wled->dev, wled->short_irq,
				       NULL, wled_short_irq_handler,
				       IRQF_ONESHOT,
				       "wled_short_irq", wled);
	if (rc < 0)
		dev_err(wled->dev, "Unable to request short_irq (err:%d)\n",
			rc);
    ...

[Severity: High]
This isn't a bug introduced by this patch, but could wled_remove() pass
negative or zero IRQ values to disable_irq()?

Looking at wled_remove(), it disables both IRQs unconditionally:

drivers/video/backlight/qcom-wled.c:wled_remove()
    ...
	disable_irq(wled->short_irq);
	disable_irq(wled->ovp_irq);
}

If platform_get_irq_byname() fails, wled->short_irq retains the negative
error code because probe continues. If devm_request_threaded_irq() fails
for ovp_irq, wled->ovp_irq is explicitly set to 0. Would passing these
values to disable_irq() lead to out-of-bounds access or disable system IRQs?

[Severity: Medium]
This is a pre-existing issue, but might the driver permanently lose features
by swallowing -EPROBE_DEFER?

drivers/video/backlight/qcom-wled.c:wled_configure_ovp_irq()
    ...
	wled->ovp_irq =3D platform_get_irq_byname(pdev, "ovp");
	if (wled->ovp_irq < 0) {
		dev_dbg(&pdev->dev, "OVP IRQ not found ...\n");
		return 0;
	}
    ...

If the interrupt controller driver probes after the backlight driver,
platform_get_irq_byname() returns -EPROBE_DEFER. Instead of deferring,
the driver treats any negative value as missing and proceeds without the IR=
Q.
The same pattern exists in wled_configure_short_irq().

[Severity: High]
This is a pre-existing issue, but is there a use-after-destroy race conditi=
on
during driver unbind?

drivers/video/backlight/qcom-wled.c:wled_remove()
{
	struct wled *wled =3D platform_get_drvdata(pdev);

	mutex_destroy(&wled->lock);
	cancel_delayed_work_sync(&wled->ovp_work);
	disable_irq(wled->short_irq);
	disable_irq(wled->ovp_irq);
}

Since devm_backlight_device_register() is used, the sysfs interface remains
active until devres cleanup, which happens after wled_remove() returns.
A concurrent write to the sysfs brightness attribute can call
wled_update_status(), locking the already destroyed mutex.=20

Additionally, hardware IRQs are disabled after mutex_destroy(), so an
in-flight OVP interrupt could trigger wled_ovp_irq_handler() and also lock
the destroyed mutex.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722065709.3460=
72-1-panchuang@vivo.com?part=3D1
