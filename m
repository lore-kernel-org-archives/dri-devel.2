Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB33CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC65E10EB83;
	Thu, 15 Oct 2026 09:22:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1870010EB83
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:22:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4A534338F;
 Thu, 15 Oct 2026 09:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542161F000C4;
 Thu, 15 Oct 2026 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792056144;
 bh=gx+PkpGOKZ4IwVdNPeUudktmree1fafNvihHrBs2fow=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WFhtVGf4PAXhkM/VO3hsMYoMdaBtRe7f+O9GecylIY2WbpflNzm3In8ee5qvwIS5l
 ft+jlDhlCnCRoogTBM8N+eMC9DlyijBYi1JbCHZyMwmSsvhWMrxDvs31yQLTIGtTha
 i+OT8LaufWKjt6htlRbKtpmU+9vVATQiJS+XIo6o679MnfBuROhyR5yJ3M4U7NFaF3
 9Tp6hU3QuD5Jitbpj9TNzbTlq8ZMW9aQXEJaqxUKjQWOuBLHjndgSw70FXdUMcltOp
 GUspuDmQO5+6FQ760u1DfKYvdJZniU33E9hGUyqNvx0Z73j4f9f2GmsF/yVyFQDduU
 0MZ5NU59Us97w==
Message-ID: <sashiko-outbox-172565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] backlight: qcom-wled: fix unbalanced OVP interrupt
 enable
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 mfd@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, lee@kernel.org
In-Reply-To: <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:22:23 +0000
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
- [High] backlight: ABBA deadlock between wled->lock and ovp_irq handler
- [High] backlight: missing cancel_delayed_work_sync in wled_probe() error =
path
--

commit f07dcfad88603020539ad65ef60f36337093bf41
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

    backlight: qcom-wled: fix unbalanced OVP interrupt enable
   =20
    If the bootloader leaves the WLED module enabled, the OVP interrupt is
    left enabled at probe time. The first brightness update then schedules
    wled_ovp_work(), which enables the interrupt for a second time and
    triggers the "Unbalanced enable for IRQ" warning.
   =20
    Track whether the driver has disabled the interrupt and only enable it
    back in that case.
   =20
    Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection l=
ogic")
    Assisted-by: LLM
    Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index 650dd95f06ef5..f2e0430cccbca 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
[ ... ]
> @@ -321,8 +326,11 @@ static int wled_module_enable(struct wled *wled, int=
 val)
>  			 */
>  			schedule_delayed_work(&wled->ovp_work, HZ / 100);

[Severity: High]
Could this delayed work execution lead to a use-after-free if probe fails?

In wled_probe(), INIT_DELAYED_WORK(&wled->ovp_work, wled_ovp_work) initiali=
zes
the delayed work without registering a devm action for cancellation.
wled_probe() then requests the short IRQ, making it active.

If a short IRQ triggers during probe, its handler calls wled_module_enable()
which reaches here and globally schedules ovp_work.

If wled_probe() subsequently returns an error (e.g., if
devm_backlight_device_register() fails), devres automatically frees the wled
structure without cancelling the scheduled work. When ovp_work executes, wo=
n't
it dereference the freed wled structure?

>  		} else {
> -			if (!cancel_delayed_work_sync(&wled->ovp_work))
> +			cancel_delayed_work_sync(&wled->ovp_work);
> +			if (!wled->ovp_irq_disabled) {
>  				disable_irq(wled->ovp_irq);

[Severity: High]
Does this code introduce an ABBA deadlock with the OVP IRQ handler?

If wled_update_status() or wled_short_irq_handler() disables the module, it
holds wled->lock and calls wled_module_enable(wled, false), which reaches h=
ere
and blocks in disable_irq() waiting for any currently executing OVP IRQ han=
dler
to complete.

Meanwhile, the threaded OVP IRQ handler tries to acquire wled->lock to perf=
orm
auto string detection:

drivers/video/backlight/qcom-wled.c:wled_ovp_irq_handler() {
    ...
	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
		if (wled->wled_auto_detection_required(wled)) {
			mutex_lock(&wled->lock);
			wled_auto_string_detection(wled);
			mutex_unlock(&wled->lock);
		}
	}
    ...
}

If the OVP IRQ fires concurrently, will disable_irq() wait forever while the
handler waits for wled->lock?

> +				wled->ovp_irq_disabled =3D true;
> +			}
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-sm8150-dis=
play-card-v1-0-5c14928cef29@oss.qualcomm.com?part=3D1
