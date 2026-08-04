Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74480C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A541810E913;
	Tue,  4 Aug 2026 08:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nnO1NTVI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B007B10E129
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:44:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E56043BD2;
 Tue,  4 Aug 2026 08:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143611F000E9;
 Tue,  4 Aug 2026 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785833054;
 bh=G5gRoThDumjl7Z03nsTXlne3uHQ2LmlU8pnWBDU0ZNI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nnO1NTVIj3StWXDiq0ZMsz+gtF6NtJMOwQNkG+DGkTMYoSVqf9HUTh4mG0HOfVrlV
 A9X3aPeuTeZ3Rl9BHN2NSw1xkEdVhEZIu9qO+igGOEu/KNDzUDp/m0aox7UsP9hRSn
 43/TCUhzfCBQnZcvMRYkpTuJwYVADXCvoVezhgXPXKUrzrH4q47zB1etJeYm/cI0rN
 q+BjVkeY3X1B20vFMxDI3/Ll4qerxuy+DiTWuBzCuk6Vn8rTUj/NKTIzv9U0Mw9ljh
 LpEyooB4Bguwm0uQud/ylwC+I6JDx/bE+9ZtfijQZ/KhXT/BD/WbAn9idQhoA00I82
 Evm/m9wqzeigw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] drm/bridge: analogix_dp: Handle HPD
 notification from downstream bridge
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260804081717.741404-11-damon.ding@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
 <20260804081717.741404-11-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:44:13 +0000
Message-Id: <20260804084414.143611F000E9@smtp.kernel.org>
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
- [High] Bypassing force_hpd initialization breaks AUX channel and link tra=
ining

Pre-existing issues:
- [High] Sleeping in atomic context during bridge enable
--

--- Patch [10]: [PATCH v2 10/10] drm/bridge: analogix_dp: Handle HPD notifi=
cation from downstream bridge ---
commit 9728fd12d41ed8de2891a5a3947c23bae76130a5
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Handle HPD notification from downstream bridge

The patch implements the .hpd_notify bridge callback to receive connection
status updates from downstream bridges. It caches the connection status to
short-circuit analogix_dp_detect_hpd() when a downstream bridge has already
confirmed the connection.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index f7db5b5a3f917..14a78aea48bd7 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -68,6 +68,13 @@ static int analogix_dp_detect_hpd(struct analogix_dp_d=
evice *dp)
>  {
>  	int timeout_loop =3D 0;
> =20
> +	/*
> +	 * Trust connection status from downstream bridge (e.g.,
> +	 * display-connector with hpd-gpios).
> +	 */
> +	if (dp->plat_data->next_bridge && dp->connection_notified)
> +		return 0;

[Severity: High]
Does returning early here bypass the analogix_dp_force_hpd(dp) call needed
to unblock the AUX channel?

If the downstream bridge manages HPD, the native HPD pin is typically
unconnected, making the hardware HPD_STATUS register read 0. The Analogix
DP hardware blocks all AUX transactions when HPD_STATUS is 0.

By returning 0 early, analogix_dp_force_hpd(dp) is skipped, leaving the
F_HPD bit cleared and the AUX channel blocked. This could cause link
training to fail because it cannot read DPCD over the AUX channel.

>  	while (timeout_loop < DP_TIMEOUT_LOOP_COUNT) {
>  		if (analogix_dp_get_plug_in_status(dp) =3D=3D 0)
>  			return 0;
> =20
>  		timeout_loop++;
>  		usleep_range(1000, 1100);

[Severity: High]
This isn't a bug introduced by this patch, but does this usleep_range()
violate atomic context requirements?

When the core DRM framework calls analogix_dp_bridge_atomic_enable() during
a non-blocking atomic commit, it executes analogix_dp_set_bridge() which
then calls analogix_dp_detect_hpd():

analogix_dp_bridge_atomic_enable()
  analogix_dp_set_bridge()
    analogix_dp_detect_hpd()
      usleep_range(1000, 1100);

Since atomic enable/disable callbacks execute in atomic context, sleeping
functions like usleep_range() are not allowed and can cause kernel
warnings (BUG: scheduling while atomic) or system instability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804081717.7414=
04-1-damon.ding@rock-chips.com?part=3D10
