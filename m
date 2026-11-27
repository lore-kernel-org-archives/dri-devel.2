Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B1606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vg5fqktp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEEC9112A1B;
	Fri, 27 Nov 2026 11:01:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B615E112A1B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:01:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 72AF145156;
 Fri, 27 Nov 2026 11:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CDB1F00893;
 Fri, 27 Nov 2026 11:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795777287;
 bh=ls+mD37Fvz8kUkk2nVrOCb7VfeFHNrWvnBgF4D55lcg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vg5fqktp1Z31CMthKaGZlcDLb+3P0HRRKNgGUv6H6ijzF8zowTTFsNL6jxHAJBScI
 OuXWpZ5Yg+CV2k94tyitljTNRQuYWfJXTAT1fyBFQ3hZX8039nCBsJ/WSiLBuDGkrJ
 ghY0iXtpHkTbAOFYdtKdyOEdl8tmDTUJ4YRKAhlb3d96HJMyyWGlMyHxMlGLepO/5H
 QJOYVfBMfhpQ/H9KRNaz3xqkMmcsuzl4fiY3DnFnO+v6L0sniy1tIfaJWMgPTRrrKN
 XTlFvrohv6bi7bddEfCqEKDXe2YjQtPc2zrfc4WnFeyac1ZJLuXFsGjxXXMIzwSg65
 GCqZIRheaLp0w==
Message-ID: <sashiko-outbox-237202@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] drm/msm/dp: keep PHY initialized while plugged
 across link unprepare
To: "Gianfranco Mariotti" <gianfranco.mariotti94@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127101417.24303-9-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
 <20261127101417.24303-9-gianfranco.mariotti94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 11:01:27 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/msm/dp: unbalanced link and PHY teardown when atomic_enable
  fails
- [High] drm/msm/dp: race on power_on in msm_dp_hpd_unplug_handle()
  exits powered PHY
--

commit 0a488765100dee43f3575efbfcd59d2d2be4bb48
Author: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>

drm/msm/dp: keep PHY initialized while plugged across link unprepare

This commit keeps the DP PHY initialized across link unprepare while a sink
remains plugged in, exits the PHY on unplug when power_on is false, and
balances PHY exit and init across runtime PM suspend and resume.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index a48f42a173657..d3f4b5a9e723f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -483,8 +483,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_dis=
play_private *dp)
>  	if (!dp->msm_dp_display.is_edp)
>  		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);
> =20
> -	/* triggered by irq_hdp with sink_count =3D 0 */
> -	if (dp->link->sink_count =3D=3D 0)
> +	if (!dp->msm_dp_display.power_on)
>  		msm_dp_display_host_phy_exit(dp);
> =20
>  	dp->link->has_sink_count =3D false;

[Severity: High]
Can an unplug during modeset enable cause msm_dp_hpd_unplug_handle() to exit
the PHY while it is powered on and msm_dp_ctrl_on_stream() is running?

msm_dp_display_prepare_link() powers on the PHY and enables link clocks
under dp->plugged_lock, then drops the lock while msm_dp_display->power_on
is still false.  msm_dp_display_enable() then runs msm_dp_ctrl_on_stream()
and sets power_on =3D true without holding dp->plugged_lock:

CPU0                                  CPU1
msm_dp_display_atomic_enable()
  msm_dp_display_prepare_link()
    lock(&dp->plugged_lock)
    msm_dp_ctrl_on_link()
      phy_power_on(phy)
    unlock(&dp->plugged_lock)
                                      msm_dp_hpd_unplug_handle()
                                        lock(&dp->plugged_lock)
                                        if (!dp->msm_dp_display.power_on)
                                          msm_dp_display_host_phy_exit(dp)
                                            ...
                                            phy_exit(phy)  <-- PHY is power=
ed on
  msm_dp_display_enable()
    msm_dp_ctrl_on_stream()
    msm_dp_display->power_on =3D true

This resets the PHY/PLL and calls phy_exit() while phy->power_count is 1 and
msm_dp_ctrl_on_stream() is accessing link and stream registers clocked by
the PHY PLL.

[ ... ]

> @@ -1533,19 +1534,21 @@ static void msm_dp_display_unprepare(struct msm_d=
p_display_private *dp)
>  {
>  	struct msm_dp *msm_dp_display =3D &dp->msm_dp_display;
> =20
> -	/* dongle is still connected but sinks are disconnected */
> -	if (dp->link->sink_count =3D=3D 0)
> -		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> +	scoped_guard(mutex, &dp->plugged_lock) {
> +		/* dongle is still connected but sinks are disconnected */
> +		if (dp->link->sink_count =3D=3D 0 && dp->plugged)
> +			msm_dp_link_psm_config(dp->link, &dp->panel->link_info,
> +					       true);
> =20
> -	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> =20
> -	if (dp->link->sink_count =3D=3D 0)
> -		/* re-init the PHY so that we can listen to Dongle disconnect */
> -		msm_dp_ctrl_reinit_phy(dp->ctrl);
> -	else
> +		/* Keep PHY initialized for AUX and IRQ_HPD while a sink remains plugg=
ed */
>  		msm_dp_display_host_phy_exit(dp);
> +		if (dp->plugged)
> +			msm_dp_display_host_phy_init(dp);
> =20
> -	msm_dp_display->power_on =3D false;
> +		msm_dp_display->power_on =3D false;
> +	}

[Severity: High]
What happens in msm_dp_display_atomic_post_disable() when an earlier
msm_dp_display_atomic_enable() failed and left msm_dp_display->power_on
false?

If msm_dp_display_prepare_link() fails (returning -ENOTCONN or failing link
training in msm_dp_ctrl_on_link(), where msm_dp_ctrl_deinitialize_mainlink()
already disables link clocks and calls phy_power_off()), a later
msm_dp_display_atomic_post_disable() still calls msm_dp_display_unprepare()
unconditionally.  Because msm_dp_display_unprepare() does not check
power_on, msm_dp_ctrl_off_link() accesses REG_DP_MAINLINK_CTRL with link
clocks off, calls clk_bulk_disable_unprepare() on already-disabled link
clocks, and calls phy_power_off() when phy->power_count is already 0
(decrementing it to -1 so subsequent phy_power_on() calls never invoke
phy->ops->power_on()).

Conversely, if msm_dp_display_prepare_link() succeeds (leaving the PHY
powered on) and msm_dp_display_enable() fails in msm_dp_ctrl_on_stream(),
power_on is also false, so an unplug or the eDP msm_dp_hpd_unplug_handle()
call at the start of msm_dp_display_atomic_post_disable() now sees
!dp->msm_dp_display.power_on and calls msm_dp_display_host_phy_exit() ->
phy_exit() before msm_dp_display_unprepare() calls phy_power_off().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127101417.2430=
3-1-gianfranco.mariotti94@gmail.com?part=3D8
