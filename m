Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44069CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9705510EF4D;
	Thu, 11 Jun 2026 14:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZFZhnueD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C1B10EF4D
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 14:02:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BFB8E601E1;
 Thu, 11 Jun 2026 14:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBDB1F00893;
 Thu, 11 Jun 2026 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781186561;
 bh=68kmeMWIrJIvNLu5IUJ0yn35paUZvTP76Rh91x2E3HU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZFZhnueDpk/TdBwcNBA98ajTZl1cYzQh57HJlaGNhRLNxxUnYyUC5nrOEDpu2Vc+v
 bk7RfSUzt7JAVdhFJaFRx+8HMatOhLhiX8F1QieQpML6QoB17+1PQloH8kdRbsOj+s
 JfIKarJOaVavhPIwjSHtYViYB3IS1Qk5jm4UnNzjGhOgvpGjGOSsKcE7wZ82TAPgKa
 T8RQ9OGsh7ihn1olQL7vDvAWOlo1ePbRyX3lExQFVt3vIXv10z3+Y0I3ZC1VFBaDR0
 8QWIyqudyCPSGJ4HzE/zwB76v8TelZMszTiqIoPNRuYTKE/4qhnjR4RPgRAnTYzO1h
 UmIzLN9zZRj3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/display: guard intel_alpm_get_error() against
 non-ALPM sinks
To: "Stephen J. Fuhry" <fuhrysteve@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611125408.676626-1-fuhrysteve@gmail.com>
References: <20260611125408.676626-1-fuhrysteve@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 14:02:40 +0000
Message-Id: <20260611140241.4FBDB1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] intel_alpm_get_error() clears the hardware error state on read, ca=
using a secondary caller within the same short pulse interrupt to miss the =
error.
--

commit 7e6bdc8ef5d560933201e9367240c8dcc3b248fe
Author: Stephen J. Fuhry <fuhrysteve@gmail.com>

drm/i915/display: guard intel_alpm_get_error() against non-ALPM sinks

intel_alpm_get_error() unconditionally reads DP_RECEIVER_ALPM_STATUS via
AUX from any DP connection that receives a short-pulse interrupt. However,
alpm_dpcd is only populated by intel_edp_init_dpcd(), so it is zero for
all external (non-eDP) DP and DP-MST connections. This patch adds a check
to return early when ALPM is not supported.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index c6963ea420cc9..07c1a96ddc6e2 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -629,6 +629,9 @@ bool intel_alpm_get_error(struct intel_dp *intel_dp)
>  	u8 val;
>  	int r;
> =20
> +	if (!intel_dp->alpm_dpcd)
> +		return false;
> +
>  	r =3D drm_dp_dpcd_readb(aux, DP_RECEIVER_ALPM_STATUS, &val);
>  	if (r !=3D 1) {
>  		drm_err(display->drm, "Error reading ALPM status\n");
>  		return true;
>  	}
> =20
>  	if (val & DP_ALPM_LOCK_TIMEOUT_ERROR) {
>  		drm_dbg_kms(display->drm, "ALPM lock timeout error\n");
> =20
>  		/* Clearing error */
>  		drm_dp_dpcd_writeb(aux, DP_RECEIVER_ALPM_STATUS, val);

[Severity: High]
This is a pre-existing issue, but does clearing the hardware error state he=
re
cause subsequent checks to miss the error?

During an HPD short pulse, intel_dp_short_pulse() first calls
intel_psr_short_pulse(), which calls psr_alpm_check(). This invokes
intel_alpm_get_error() which reads and clears the DP_ALPM_LOCK_TIMEOUT_ERROR
bit:

drivers/gpu/drm/i915/display/intel_psr.c:psr_alpm_check() {
    ...
    if (intel_alpm_get_error(intel_dp)) {
        intel_psr_disable_locked(intel_dp);
        psr->sink_not_reliable =3D true;
    }
    ...
}

Later in the same sequence, intel_dp_short_pulse() directly calls
intel_alpm_get_error() a second time:

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_short_pulse() {
    ...
    intel_psr_short_pulse(intel_dp);

    if (intel_alpm_get_error(intel_dp)) {
        intel_alpm_disable(intel_dp);
        intel_dp->alpm.sink_alpm_error =3D true;
    }
    ...
}

Because the DPCD error bit was already cleared by the first call, the second
call will return false.

While psr_alpm_check() disables PSR via intel_psr_disable_locked(), that
function only disables ALPM/LOBF for Panel Replay, and psr_alpm_check() only
runs when Panel Replay is NOT enabled.

For standard PSR-enabled eDP panels, does the second check failing mean we
skip calling intel_alpm_disable(intel_dp), leaving LOBF improperly enabled
despite the ALPM timeout?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611125408.6766=
26-1-fuhrysteve@gmail.com?part=3D1
