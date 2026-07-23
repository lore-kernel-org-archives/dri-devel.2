Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF2AC531D1
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7F210F11E;
	Thu, 23 Jul 2026 13:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k/gPFX2b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E7810F11E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:29:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AED6A42B92;
 Thu, 23 Jul 2026 13:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7389C1F000E9;
 Thu, 23 Jul 2026 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784813342;
 bh=6sKgJWM1Yn1SB8n44241SJz8OVZQFEeI7XKZ8pqQLEc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k/gPFX2bWUa4S3Q509CPtMRkwiWc0MhnVqldCngw9yholBbFBZWyexO3kztM9tfSv
 A55bPco4i+Sr54hT8jaOJDra5+MREUNpcTcHAJgAYdqCNLsYBYrsKrmIiwAGabbsHZ
 2Wpu8cWMf38CJKQSJI1KnLu607TN5/Y9U7BSMX8RcmnniwvSbzf+wE68EWmZB80LUG
 pwbcsxQrP9djVOBj6CLkifuThh0Xpjlp1H4OEHfCPMTFMowgkBeGTmuCQnkfbn/etE
 wS249K4lWA+bPLwrzuiKXH0H72suCn6Y62/AXgHZ1begivOVqF0uYEbtXEujTLrbAK
 zjCfCIzh8OPKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] drm/bridge: cdns-mhdp8546: Remove redundant
 dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723131649.134127-3-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
 <20260723131649.134127-3-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 13:29:00 +0000
Message-Id: <20260723132902.7389C1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Use-After-Free in cdns_mhdp_remove() due to active interrupt handl=
er rescheduling work
- [High] Uninitialized workqueue and waitqueue accessed by interrupt handle=
r on probe
- [High] Use-After-Free due to asynchronous firmware loading timeout in cdn=
s_mhdp_remove()
--

--- Patch [2]: [PATCH 02/10] drm/bridge: cdns-mhdp8546: Remove redundant de=
v_err() ---
commit bcaae5554e2b18efb874ecbcbc1b83f650920be8
Author: Pan Chuang <panchuang@vivo.com>

    drm/bridge: cdns-mhdp8546: Remove redundant dev_err()

This commit removes a redundant dev_err() call after devm_request_threaded_=
irq()
fails. The genirq subsystem already logs detailed error messages automatica=
lly,
making the driver-specific print unnecessary.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 504a3186ebb3a..f47717bd10798 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2343,7 +2343,6 @@ static int cdns_mhdp_probe(struct platform_device *=
pdev)
>  					cdns_mhdp_irq_handler, IRQF_ONESHOT,
>  					"mhdp8546", mhdp);

[Severity: High]
This is a pre-existing issue, but waitqueues and workqueues accessed by the
interrupt handler are uninitialized at this point.

Because devm_request_threaded_irq() enables the interrupt immediately, an
active interrupt line from the bootloader could trigger cdns_mhdp_irq_handl=
er()
before the driver initializes mhdp->sw_events_wq and mhdp->hpd_work.

Will the interrupt handler trigger a kernel panic due to iterating over
uninitialized waitqueue list heads if the interrupt fires early?

>  	if (ret) {
> -		dev_err(dev, "cannot install IRQ %d\n", irq);
>  		ret =3D -EIO;
>  		goto plat_fini;
>  	}

[Severity: High]
This is a pre-existing issue, but using devm_request_threaded_irq() without
explicitly disabling the irq creates a use-after-free window in
cdns_mhdp_remove().

Because the devm action frees the IRQ after cdns_mhdp_remove() returns, the
interrupt remains fully active during driver unbind:

drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:cdns_mhdp_remove() {
	...
	cancel_work_sync(&mhdp->modeset_retry_work);
	flush_work(&mhdp->hpd_work);
	/* Ignoring mhdp->hdcp.check_work and mhdp->hdcp.prop_work here. */
}

Could the active interrupt handler reschedule mhdp->hpd_work after flush_wo=
rk()
completes, leading to a use-after-free when the devres cleanup subsequently
frees the mhdp structure?

[Severity: High]
This is a pre-existing issue, but is it safe to use a strict 100ms timeout =
in
cdns_mhdp_remove() while firmware is still loading?

drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:cdns_mhdp_remove() {
	...
	unsigned long timeout =3D msecs_to_jiffies(100);
	...
	ret =3D wait_event_timeout(mhdp->fw_load_wq,
				 mhdp->hw_state =3D=3D MHDP_HW_READY,
				 timeout);
	...
}

If the asynchronous firmware request takes longer than 100ms (e.g. waiting =
for
a user-mode helper fallback which times out after 60s), remove() will proce=
ed
and devres will free the mhdp structure.

When the firmware subsystem later invokes cdns_mhdp_fw_cb(), won't it
dereference the freed mhdp context pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723131649.1341=
27-1-panchuang@vivo.com?part=3D2
