Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3CFC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCEA10EDF3;
	Wed, 26 Aug 2026 19:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jgu90rz/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B8E10EDF3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 19:53:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42796601E9;
 Wed, 26 Aug 2026 19:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C383A1F000E9;
 Wed, 26 Aug 2026 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787774030;
 bh=iHBtHkeVYZ4L6m6Ve1n2kLkEP3ijEX6V0b4UNTPrdfI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jgu90rz/d66aA3GclW0vLgTir4tGQVIenmT7VMhL9CQzG/oD6c1WzvD7W8qMWYT+t
 J0TmD/D4cXGM8MISlPGGeqAE5WEaZRjrrCpUlti11FeRGSbmy9zwowbwQaKxvbp0Dj
 y5pzAeEReWauCV2o+n05E0Dvp1eHXD5NpVQbyCUz8TOG+BFGbJiwfC0CC+dF1L6bDS
 ZDLoTK7H/gTZmETV6lzCBBWJVYwiH0dL9CghwrvnMQk9nQwstnBMAZqy5ztOJ7BrhC
 ahUeLZJRV62cn78hR0H7v4Lz6BuKEWoNmdxSyl/53WDQpDpr1SPV/PRCAuvZPBoddv
 wqz44GmPMHnRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: skip receiver power control
 without AUX
To: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826193602.6441-1-neptune@imm0nv1nhtv.is-a.dev>
References: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
 <20260826193602.6441-1-neptune@imm0nv1nhtv.is-a.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 19:53:49 +0000
Message-Id: <20260826195349.C383A1F000E9@smtp.kernel.org>
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
- [High] The newly added early return in `dpcd_write_rx_power_ctrl()` incor=
rectly relies on `link->aux_mode` before it is initialized, causing the DP =
receiver power-up sequence to be skipped for all newly detected DP monitors=
 and active dongles.
--

commit 6bcb07f6c6cfc4188f9856f76b47789a74cb855e
Author: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>

drm/amd/display: skip receiver power control without AUX
   =20
Passive DP to TMDS dongles do not provide a DP receiver and use native
GPIO I2C rather than AUX. dpcd_write_rx_power_ctrl() nevertheless tries
to write DP_SET_POWER, causing the DP helpers to retry a transaction
that cannot succeed 32 times before giving up. Skip receiver power
control when the link is not using AUX mode.

> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c =
b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> index 49521ac4b0e85..7991531f6ef44 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> @@ -50,6 +50,15 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bo=
ol on)
>  	if (link->sync_lt_in_progress)
>  		return;
> =20
> +	/*
> +	 * A passive DP to TMDS dongle presents no DP receiver, so there is
> +	 * nothing to power up or down. The write can only fail, and the DP
> +	 * helpers retry it 32 times before giving up, which adds tens of
> +	 * milliseconds to link bring up.
> +	 */
> +	if (!link->aux_mode)
> +		return;

[Severity: High]
Does this early return skip the DP receiver power-up sequence for all newly
detected DP monitors and active dongles?

During system boot or display hotplug, the dc_link struct is zero-allocated,
so link->aux_mode defaults to false. The detection sequence starts with
detect_link_and_local_sink(), which calls detect_dp() -> retrieve_link_cap()
-> dp_wa_power_up_0010FA(), eventually calling dpcd_write_rx_power_ctrl().

Since link->aux_mode is still false at this point, the early return triggers
and skips the DP_SET_POWER D0 write. This breaks detection for active dongl=
es
(such as the 0010FA) that depend on being powered up before a DPCD read.

Looking at detect_link_and_local_sink() in link_detection.c, link->aux_mode
is actually initialized after detect_dp() has already executed and failed:

drivers/gpu/drm/amd/display/dc/link/link_detection.c:detect_link_and_local_=
sink() {
    ...
    if (!detect_dp(link, &sink_caps, reason)) {
    ...
    link->aux_mode =3D
            link_is_in_aux_transaction_mode(link->ddc);
    ...
}

Should we ensure link->aux_mode is initialized earlier in the detection flo=
w,
or use a different condition to skip the power control write?

> +
>  	core_link_write_dpcd(link, DP_SET_POWER, &state,
>  						 sizeof(state));
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826193602.6441=
-1-neptune@imm0nv1nhtv.is-a.dev?part=3D1
