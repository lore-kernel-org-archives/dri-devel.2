Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F4CD8C90
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311E810E5D3;
	Sun,  7 Jun 2026 21:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KiNwAdmw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347FC10E33A
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:46:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53A8960018;
 Sun,  7 Jun 2026 21:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C120E1F00893;
 Sun,  7 Jun 2026 21:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780868808;
 bh=f4TYD2MK/8wcG+xA5CmnPUXUwAKuqVUgIAionwX1Aqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KiNwAdmwa7xTofVXFQc7QuWKxACGacgB2xMGs1/RnOU0zji8lNry6GGfE9SJ4dqE8
 dN2mGJWk2b2nfsVa8vhbKH/y+EAB1EIMMIgKTr35iPrDFzo+djczZji93xezVtI2Nj
 yEseB8ct/ZYjvf5iQr4H9nl4kCgI5uQ/qVhxz2IVEC4yFTLaMpx01Qi8UEmlYQC6Sc
 Ca33dvb7PHWQe7mSf5X/bLB7Ort+F4HomB9kCRrVwNs4jctX1GGaSD1CPK5MvLRDI8
 y/iTJrD9Rt/wv4iQYyZskTAOEVXPSog35V1SgwM1hi3goJsCU9tVPbBPz/VwKe4hOT
 A5XTrPL6U9/ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/8] soc: qcom: pmic-glink-altmode: pass down HPD_IRQ
 events
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260608-hpd-irq-events-v4-7-30b62b335487@oss.qualcomm.com>
References: <20260608-hpd-irq-events-v4-7-30b62b335487@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 21:46:47 +0000
Message-Id: <20260607214647.C120E1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing `cancel_work_sync()` upon device unbind leads to a use-aft=
er-free vulnerability for the `altmode` and `alt_port` structures.
- [High] Missing `reinit_completion()` can cause subsequent firmware reques=
ts to prematurely succeed if a previous request timed out.
--

commit 94236240b5d1e90ad191dae53982a24598cd3d4c
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

soc: qcom: pmic-glink-altmode: pass down HPD_IRQ events

This commit passes IRQ_HPD events from the firmware to the DisplayPort
driver through the HPD bridge. This enables the DP source to receive
notifications about events on the sink side.

> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmi=
c_glink_altmode.c
> index 619bad2c27eeb..946eb20b8f836 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -373,7 +373,11 @@ static void pmic_glink_altmode_worker(struct work_st=
ruct *work)
>  		else
>  			conn_status =3D connector_status_disconnected;
> =20
> -		drm_aux_hpd_bridge_notify(&alt_port->bridge->dev, conn_status);
> +		drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
> +						conn_status,
> +						alt_port->hpd_irq ?
> +						DRM_CONNECTOR_DP_IRQ_HPD :
> +						DRM_CONNECTOR_NO_EXTRA_STATUS);
>  	} else if (alt_port->mux_ctrl =3D=3D MUX_CTRL_STATE_TUNNELING) {
>  		if (alt_port->svid =3D=3D USB_TYPEC_TBT_SID)
>  			pmic_glink_altmode_enable_tbt(altmode, alt_port);

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the
workqueue handler, is there a potential use-after-free due to missing work
cancellation on teardown?

In pmic_glink_altmode_probe(), the driver allocates the altmode structure v=
ia
devm_kzalloc() and initializes altmode->enable_work and alt_port->work, but
it does not register a .remove callback or a devres action to synchronously
cancel these work items.

When the auxiliary device is unbound, the devres framework will automatical=
ly
free the altmode structure and release resources.

If pmic_glink_altmode_worker() is currently pending or executing, could it
dereference the freed altmode and alt_port pointers?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential state machine
issue regarding how requests are sent to the firmware.

In pmic_glink_altmode_request(), the driver sends a request and waits for an
acknowledgment:

	ret =3D pmic_glink_send(altmode->client, &req, sizeof(req));
	...
	wait_for_completion_timeout(&altmode->pan_ack, ...);

If the wait times out, the function returns -ETIMEDOUT. If the delayed
acknowledgment eventually arrives, pmic_glink_altmode_callback() will call
complete(), incrementing the counter.

Since the driver never calls reinit_completion() before sending a new reque=
st,
will the next call to pmic_glink_altmode_request() instantly succeed by
consuming the stale completion counter instead of waiting for the actual
hardware acknowledgment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-hpd-irq-ev=
ents-v4-0-30b62b335487@oss.qualcomm.com?part=3D7
