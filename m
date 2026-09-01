Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31738C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4779910E1E5;
	Tue,  1 Sep 2026 20:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zoud6/QI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943B110E65E;
 Tue,  1 Sep 2026 20:48:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D01E600D9;
 Tue,  1 Sep 2026 20:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5ED11F000E9;
 Tue,  1 Sep 2026 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788295710;
 bh=FhCklhuhjBYALNQ61jeRR8SR37l2RaEJpAjPuo2Wn+I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zoud6/QIfjp+bAKAe1vbDqAwO8duJdtLyjMK3g9U78EfGXtUeh4nk9A8HnAs1SkII
 Hhlk2xnDjxYQLRUPCFjk2UkLiVhou4rEVOYa8WRFJRdGKykoN/A3+tdVMLF4OjnpSr
 y3uNmq49tdXIwWIHAapmf7PovK9g7WBSMVCyPlTGZF5OfsDa7sIZbloZa3QmHh7o1F
 bbyF3I9BSgbNt6YB6h2HzwZhKwKO9kwydGDoFPsAEMZW7DMUB396z2OrSBREzhYByC
 JuK5FqdhkyPGfJptHi07sPBHveT8u2JMuh1Nw05L4MY4fk6XYlXO19q3KQeiaxMXkz
 M8glaRyYQ/PVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/psr: clear the Panel Replay error status register
To: "Jake Steinman" <j@metarealtyinc.ca>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260901203633.92628-1-j@metarealtyinc.ca>
References: <20260901203633.92628-1-j@metarealtyinc.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 20:48:29 +0000
Message-Id: <20260901204829.D5ED11F000E9@smtp.kernel.org>
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
- [High] The patch fails to clear the Panel Replay error status because it =
evaluates a state variable (`psr->panel_replay_enabled`) that has already b=
een cleared upon error detection.

Pre-existing issues:
- [High] If `drm_dp_dpcd_readb` reads 0 bytes, the driver falsely assumes s=
uccess and uses uninitialized stack variables.
--

commit 1da2d4e9ad55e4f8b758998afbe0f6630bae226f
Author: Jake Steinman <j@metarealtyinc.ca>
drm/i915/psr: clear the Panel Replay error status register

This commit aims to fix an issue where the Panel Replay error status regist=
er
is never cleared on the sink. It updates intel_psr_short_pulse() to use
the same conditional offset for clearing the error as is used for reading i=
t.

> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i=
915/display/intel_psr.c
> index 52836496040ff..1d0372c5f895f 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -3891,7 +3891,10 @@ void intel_psr_short_pulse(struct intel_dp *intel_=
dp)
>  			"PSR_ERROR_STATUS unhandled errors %x\n",
>  			error_status & ~errors);

[Severity: High]
This is a pre-existing issue, but if drm_dp_dpcd_readb() reads 0 bytes, it
returns 0.

In psr_get_status_and_error_status(), the check if (ret !=3D 1) return ret;=
 will
then return 0.

Does this cause intel_psr_short_pulse() to wrongly treat the read as a succ=
ess
and proceed to use uninitialized stack variables status and error_status?

>  	/* clear status register */
> -	drm_dp_dpcd_writeb(&intel_dp->aux, DP_PSR_ERROR_STATUS, error_status);
> +	drm_dp_dpcd_writeb(&intel_dp->aux,
> +			   psr->panel_replay_enabled ?
> +			   DP_PANEL_REPLAY_ERROR_STATUS : DP_PSR_ERROR_STATUS,
> +			   error_status);

[Severity: High]
Does this code still write to the wrong register during an error condition?

If an error is detected, the earlier check in intel_psr_short_pulse() calls
intel_psr_disable_locked():

intel_psr_short_pulse()
  if ((!psr->panel_replay_enabled && status =3D=3D DP_PSR_SINK_INTERNAL_ERR=
OR) ||
      (error_status & errors)) {
      intel_psr_disable_locked(intel_dp);
      ...
  }

intel_psr_disable_locked() unconditionally clears the flag:
  intel_dp->psr.panel_replay_enabled =3D false;

When we later attempt to clear the status register, psr->panel_replay_enabl=
ed
will evaluate to false, causing the error status to be incorrectly written =
to
DP_PSR_ERROR_STATUS instead of DP_PANEL_REPLAY_ERROR_STATUS.

> =20
>  	if (!psr->panel_replay_enabled) {
>  		psr_alpm_check(intel_dp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901203633.9262=
8-1-j@metarealtyinc.ca?part=3D1
