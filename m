Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604CCC43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C0410EC2F;
	Tue, 30 Jun 2026 10:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nJiF1N3y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C037210EC2F
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:57:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F7AB41228;
 Tue, 30 Jun 2026 10:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEC41F000E9;
 Tue, 30 Jun 2026 10:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782817038;
 bh=6TNdTs9e+zswQHONVLn+KHfsYSMTBFRxU3F5V7mXaqY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nJiF1N3yUICncManiD6BG4sEuPg8JqsxEzoEm3BARHk75mRSCzB3qk6Y841NNz9yC
 o5hmCamgZjfCUd1zBc2IYG5Ud3AV66pRyuIr+qhL670/s+rC8kWN+X6KSTzyN9Ljl5
 RiMLusvjRldAXM/G8O28bqZMMHSeElecae8n7mi9II8vSi3lYw9CF67kNAOVPBRDCb
 lSQkt9mLq9UKEb9m+UMXMdq/FLXucyodR+hjuqLPIzxBqUPD0KgEkAe3Ts/MeKBlzA
 1b0CgnvCDs5dajbbZOUjke5LVfkxlnqsmms+COycerEveh1+vrQAFrDR110mraFkLZ
 wwfjyAu6AtZ/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd property
To: "Yashas D" <y-d@ti.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260630102610.1849902-3-y-d@ti.com>
References: <20260630102610.1849902-1-y-d@ti.com>
 <20260630102610.1849902-3-y-d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:57:17 +0000
Message-Id: <20260630105718.0EEC41F000E9@smtp.kernel.org>
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
- [High] Polling monitor presence using `drm_dp_dpcd_read_link_status()` re=
ads from link training status registers (DP_LANE0_1_STATUS), which can disr=
upt the DP sink's state machine.
- [High] Calling `cdns_mhdp_update_link_status()` from the `.detect()` call=
back continuously re-programs live video registers during DRM polling.
- [High] Missing `drm_dp_aux_unregister` on the firmware load timeout error=
 path in `cdns_mhdp_attach`.
- [Medium] In no-hpd mode, link status evaluation is bypassed, preventing r=
ecovery from main link failures.
- [Medium] A hardcoded 100ms timeout in `cdns_mhdp_attach` to wait for asyn=
chronous firmware loading is too short and will cause initialization failur=
es.
--

commit 2c6e286375fe2e77fec97f0ea17066c50894dd26
Author: Rahul T R <r-ravikumar@ti.com>

drm: bridge: cdns-mhdp8546: Add no-hpd property

This patch adds a 'no-hpd' property to support boards where the HPD line ca=
nnot
be used for hotplug detection. It implements a polling mechanism using AUX =
reads
to detect monitor presence when hardware HPD signals are unavailable.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 36c07b71fe04b..5e1bad8fc73ea 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
[ ... ]
> @@ -1523,6 +1532,26 @@ static int cdns_mhdp_attach(struct drm_bridge *bri=
dge,
> =20
>  	spin_unlock(&mhdp->start_lock);
> =20
> +	if (mhdp->no_hpd) {
> +		/*
> +		 * In no-hpd mode there is no interrupt to signal firmware
> +		 * readiness. The firmware loads asynchronously after probe(),
> +		 * so we must wait here until the uCPU is running before
> +		 * attempting the first AUX channel poll for monitor presence.
> +		 */
> +		ret =3D wait_event_timeout(mhdp->fw_load_wq,
> +					 mhdp->hw_state =3D=3D MHDP_HW_READY,
> +					 msecs_to_jiffies(100));

[Severity: Medium]
Will this 100ms timeout cause initialization failures?

Async firmware loading can routinely take longer than 100ms on a busy syste=
m or
when reading from slow storage.

> +		if (ret =3D=3D 0) {
> +			dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
> +				__func__);
> +			return -ETIMEDOUT;

[Severity: High]
Does this error path leak the registered AUX channel?

Earlier in cdns_mhdp_attach(), the DRM DP AUX channel is registered using
drm_dp_aux_register(). Returning directly here skips the aux_unregister err=
or
path label at the end of the function, leaving the AUX channel registered b=
ut
in an invalid state.

> +		}
> +
> +		cdns_mhdp_update_link_status(mhdp);
> +		return 0;
> +	}
> +
[ ... ]
> @@ -2100,7 +2132,16 @@ static int cdns_mhdp_update_link_status(struct cdn=
s_mhdp_device *mhdp)
> =20
>  	mutex_lock(&mhdp->link_mutex);
> =20
> -	mhdp->plugged =3D cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
> +	if (mhdp->no_hpd) {
> +		ret =3D drm_dp_dpcd_read_link_status(&mhdp->aux, status);

[Severity: High]
Is it safe to read link training status registers to poll for monitor prese=
nce?

drm_dp_dpcd_read_link_status() reads the DP_LANE0_1_STATUS (0x202) register.
According to the DRM subsystem guidelines, reading link training status
registers (0x202-0x207) outside of the expected training sequence can trigg=
er
unintended state machine transitions in DP/eDP sinks. Could this cause hard=
ware
state corruption or screen flickering?

> +		hpd_pulse =3D false;

[Severity: Medium]
Does hardcoding hpd_pulse to false bypass link retraining?

Later in cdns_mhdp_update_link_status(), link validation logic checks
if (hpd_pulse && old_plugged =3D=3D mhdp->plugged). By hardcoding this to f=
alse,
that logic is skipped. If the main high-speed link loses synchronization but
the monitor remains connected, wouldn't the driver fail to retrain the link?

[Severity: High]
Does this also cause live video stream registers to be reprogrammed on every
polling event?

Since hpd_pulse is false, the function skips the early return path for a he=
althy
link (goto out;). It then falls through to the end of the function where it
unconditionally executes cdns_mhdp_sst_enable(mhdp, current_mode) if
mhdp->bridge_enabled is true.

When called via periodic DRM polling via the .detect() callback, won't this
cause severe screen flickering or sync loss by continuously overwriting act=
ive
hardware display timing registers?

> +		if (ret < 0)
> +			mhdp->plugged =3D false;
> +		else
> +			mhdp->plugged =3D true;
> +	} else {
> +		mhdp->plugged =3D cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630102610.1849=
902-1-y-d@ti.com?part=3D2
