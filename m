Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180FDC5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B7310E35C;
	Thu,  6 Aug 2026 17:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EBFaCwN2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57CF10E35C
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:29:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7891E415AB;
 Thu,  6 Aug 2026 17:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A261F000E9;
 Thu,  6 Aug 2026 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786037377;
 bh=NfIGvapZmrNP5/iFxVjJchGfYLISDrBmxSv5TDZiUqw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EBFaCwN2NahknnlTfkKKxUCn1AnoU7tVr9/IRR0uYm617vpen6cqdR0rx0Vy/gzy3
 pupT5FrrN4lo3L0Z0rD6ksBySS2qaSmPmjkczuHRKtyrWIAGsuw1AMLW6hagMMgGmN
 Fv9kkWCeEY8lLnGAr2PWLyi8rooKDzsle+pPWj1gLD5yOTfTwdoumG4R3WCNh5hFtz
 hEtBdmnJtLMfuXsst3Zb9yeW7LH1QkeJ/a/Eh5716bwhVHxY/WybTbrkQNVhHvJCsB
 GuQFD8/rfDSSyMKp8g1+3Fpsz5nEJ/q8MOcjsymfAauPBc0JoBgeYh9WWQuibZKPKK
 7fHOuJ3me7xew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/21] drm/bridge: synopsys: dw-dp: Fix error
 handling for DP link enablement
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-3-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-3-0d508505f383@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:29:35 +0000
Message-Id: <20260806172936.D0A261F000E9@smtp.kernel.org>
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

New issues:
- [High] Unconditional call to `drm_dp_link_power_down()` on error path cau=
ses severe stalls when unplugged.

Pre-existing issues:
- [High] Missing `reinit_completion()` in `dw_dp_aux_transfer()` leads to s=
purious AUX timeouts and data corruption.
- [High] TOCTOU race condition between asynchronous HPD worker and non-bloc=
king atomic disable.
--

--- Patch [3]: [PATCH v11 03/21] drm/bridge: synopsys: dw-dp: Fix error han=
dling for DP link enablement ---
commit a255c1363edf851c03c63d0e1832fe5878093ca6
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
drm/bridge: synopsys: dw-dp: Fix error handling for DP link enablement

This commit introduces an enabled state variable in the link structure to
ensure that the link is only disabled if it was properly enabled, preventing
PHY power state mismatches. It also adds missing error handling to
dw_dp_link_enable() to ensure the link enablement is an atomic operation.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index d7945f7fe9f05..21d60e89126f0 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1636,10 +1641,22 @@ static int dw_dp_link_enable(struct dw_dp *dp)
> =20
>  	ret =3D drm_dp_link_power_up(&dp->aux, dp->link.revision);
>  	if (ret < 0)
> -		return ret;
> +		goto err_phy_power_off;
> =20
>  	ret =3D dw_dp_link_train(dp);
> +	if (ret < 0)
> +		goto err_link_power_down;
> +
> +	dp->link.enabled =3D true;
> =20
> +	return 0;
> +
> +err_link_power_down:
> +	drm_dp_link_power_down(&dp->aux, dp->link.revision);

[Severity: High]
Can this unconditionally stall the DRM commit worker during a hot-unplug ev=
ent?

If dw_dp_link_enable() fails link training due to the display being unplugg=
ed,
this error path unconditionally executes drm_dp_link_power_down() without
verifying if the hardware is still plugged in.

Because the sink is disconnected, DPCD writes over the AUX channel will
repeatedly time out, stalling the DRM commit worker for hundreds of
milliseconds. The existing cleanup code safely guards this with
if (dw_dp_hpd_detect(dp)), but this new inline error path omits the check.

> +	dw_dp_phy_xmit_enable(dp, 0);
> +
> +err_phy_power_off:
> +	phy_power_off(dp->phy);
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does dw_dp_aux_transfer() ha=
ve
a missing completion re-initialization that could cause data corruption?

Looking at dw_dp_aux_transfer():

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_aux_transfer() {
    ...
    status =3D wait_for_completion_timeout(&dp->complete, timeout);
    ...
}

The wait relies on the completion state being clean, but because it is not
re-initialized, a late interrupt from a previous timeout will prematurely
satisfy this wait. This could cause the next transfer to immediately return
without waiting for actual completion, returning stale data or falsely
reporting timeouts.

Should reinit_completion() be called before starting a transfer?

[Severity: High]
This is a pre-existing issue, but is there a TOCTOU race condition between =
the
asynchronous HPD worker and non-blocking atomic disable?

Looking at dw_dp_link_retrain():

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_link_retrain() {
    ...
    if (!ret)
        ret =3D dw_dp_link_train(dp);
    ...
}

And dw_dp_bridge_atomic_disable():

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bridge_atomic_disable() {
    ...
    dw_dp_link_disable(dp);
    ...
}

dw_dp_hpd_work() can trigger a link retrain asynchronously. It checks
dw_dp_needs_link_retrain() without the connection_mutex, then acquires the =
lock
and unconditionally calls dw_dp_link_train().

Since non-blocking atomic commits drop connection_mutex before
dw_dp_bridge_atomic_disable() executes, the HPD worker can run concurrently
with bridge teardown. If atomic_disable powers off the PHY, the HPD worker
could blindly access the powered-down hardware, potentially causing a locku=
p or
crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v11-0-0d508505f383@collabora.com?part=3D3
