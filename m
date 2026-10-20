Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A9606A321
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqBMztqU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA2910EBEA;
	Tue, 20 Oct 2026 14:22:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E10110EBEA
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 14:22:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2EC8600AA;
 Tue, 20 Oct 2026 14:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558561F000C4;
 Tue, 20 Oct 2026 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792506144;
 bh=JVQ9fYos69/aUfYoeeKqK/oWRcay5wbskmZLmgBK3kk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jqBMztqUpzj0KtaK8Wu0xcP5YcmY3/nnp8CYXynpkKpC2G3VKTvcK6ut6t94wdJQx
 lCSj1VG2171CBYFAp2Z8k48jBDH4SHKBzyTvqGGHicLiYf8c7VdGy5/14lpu/ghsJO
 J9JdQFDqJ51MBgifdTbw2n09CcHw93VsLoNgRK6EpddgmZxEgx0t7mY7h9M6QY+TBx
 KqLO0YHGHnIpyV8oQK74Jr/55TkZrfhdg5oTvfPJaPVp7Zt8VlXRTnEUL1s2FVqXEl
 h/bQJxfWTszA4aJxNQcq5RPiZgc1GAuxoL1ZBdH3g0CcuTjEQJKBhNaKROQYc8xcaJ
 TXRpwTI1/xK2Q==
Message-ID: <sashiko-outbox-179119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: hdmi: write SCDC TMDS_Bit_Clock_Ratio before
 the TMDS clock starts
To: "Lucas Tanure" <lucas.tanure@neat.no>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261020134941.631907-1-lucas.tanure@neat.no>
References: <20261020134941.631907-1-lucas.tanure@neat.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:22:23 +0000
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/vc4: hdmi: SCDC bits updated while TMDS clock runs on BCM2712
- [Medium] drm/vc4: hdmi: split SCDC and scrambler enable across crtc callb=
acks
- [Medium] drm/vc4: hdmi: race with scrambling_work when disabling scrambli=
ng in powerdown
--

commit 5be38e4d64847031b3ada407365354ff41c9b9d0
Author: Lucas Tanure <lucas.tanure@neat.no>

drm/vc4: hdmi: write SCDC TMDS_Bit_Clock_Ratio before the TMDS clock starts

This commit moves the SCDC high TMDS clock ratio and scrambling configurati=
on
into vc4_hdmi_encoder_pre_crtc_configure() before PHY initialization, and
moves vc4_hdmi_disable_scrambling() into
vc4_hdmi_encoder_post_crtc_powerdown() after phy_disable().

Link: https://github.com/raspberrypi/linux/issues/7693

> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index 3a90dbb61f4ea..11b9811bb97cf 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -812,9 +812,6 @@ static void vc4_hdmi_enable_scrambling(struct drm_enc=
oder *encoder)
>  	if (!drm_dev_enter(drm, &idx))
>  		return;
> =20
> -	drm_scdc_set_high_tmds_clock_ratio(connector, true);
> -	drm_scdc_set_scrambling(connector, true);
> -
>  	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
>  	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) |
>  		   VC5_HDMI_SCRAMBLER_CTL_ENABLE);
> @@ -919,8 +916,6 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct=
 drm_encoder *encoder,
>  		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
>  	}
> =20
> -	vc4_hdmi_disable_scrambling(encoder);
> -
>  	drm_dev_exit(idx);
> =20
>  out:
> @@ -948,6 +943,8 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(stru=
ct drm_encoder *encoder,
>  	if (vc4_hdmi->variant->phy_disable)
>  		vc4_hdmi->variant->phy_disable(vc4_hdmi);
> =20
> +	vc4_hdmi_disable_scrambling(encoder);
> +

[Severity: High]
Does moving vc4_hdmi_disable_scrambling() after variant->phy_disable()
actually stop the TMDS clock before clearing the SCDC bits on BCM2712?

While bcm2711_hdmi0_variant sets .phy_disable to vc5_hdmi_phy_disable() (wh=
ich
calls vc5_hdmi_reset_phy()), bcm2712_hdmi0_variant and bcm2712_hdmi1_variant
set .phy_disable to vc6_hdmi_phy_disable(), which is an empty stub:

drivers/gpu/drm/vc4/vc4_hdmi_phy.c:
void vc6_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi)
{
}

Because clk_disable_unprepare() and pm_runtime_put() have not executed yet =
in
vc4_hdmi_encoder_post_crtc_powerdown(), vc4_hdmi_disable_scrambling() still
clears SCDC_SCRAMBLING_ENABLE and SCDC_TMDS_BIT_CLOCK_RATIO_BY_40 while the
BCM2712 PHY PLL and TX clock lane (VC6_HDMI_TX_PHY_HDMI_POWERUP_CTL_TX_CK_P=
WRUP)
are powered up and outputting the TMDS clock.

Furthermore, during a mode switch (for example from 1080p60 to 3840x2160@60)
or a hotplug link reset via vc4_hdmi_connector_detect_ctx() ->
vc4_hdmi_handle_hotplug() -> vc4_hdmi_reset_link() ->
drm_atomic_helper_reset_crtc(), runtime PM may not synchronously suspend and
reset the hardware between drm_atomic_helper_commit_modeset_disables() and
drm_atomic_helper_commit_modeset_enables() (for instance when pm_runtime_pu=
t()
is asynchronous, when CEC holds a runtime PM reference via
vc4_hdmi_cec_enable(), or when vc4_hdmi_connector_detect_ctx() holds a runt=
ime
PM reference across vc4_hdmi_handle_hotplug()). Since vc6_hdmi_phy_disable()
did not call vc6_hdmi_reset_phy(), won't the previous mode's TMDS clock sti=
ll
be running when vc4_hdmi_encoder_pre_crtc_configure() writes the SCDC
registers and waits 1-2 ms before vc6_hdmi_phy_init() finally calls
vc6_hdmi_reset_phy()?

[Severity: Medium]
Can deferring vc4_hdmi_disable_scrambling() to
vc4_hdmi_encoder_post_crtc_powerdown() race with vc4_hdmi->scrambling_work =
and
leave SCDC scrambling enabled after teardown?

During vc4_crtc_atomic_disable() -> vc4_crtc_disable(),
vc4_hdmi_encoder_post_crtc_disable() stops HDMI output and drops
vc4_hdmi->mutex, followed by vc4_crtc_pixelvalve_reset(),
vc4_hvs_stop_channel(), and variant->phy_disable(). Throughout this teardown
sequence, vc4_hdmi->scrambling_work remains armed while the link and PHY are
shut down, causing the sink to drop SCDC_SCRAMBLING_STATUS to 0.

If scrambling_work fires during this window and vc4_hdmi_scrambling_wq()
starts executing on system_percpu_wq before vc4_hdmi_disable_scrambling() is
called, delayed_work_pending(&vc4_hdmi->scrambling_work) will return false =
in
vc4_hdmi_disable_scrambling():

drivers/gpu/drm/vc4/vc4_hdmi.c:vc4_hdmi_disable_scrambling() {
	...
	if (delayed_work_pending(&vc4_hdmi->scrambling_work))
		cancel_delayed_work_sync(&vc4_hdmi->scrambling_work);
	...
}

Because vc4_hdmi_scrambling_wq() neither acquires vc4_hdmi->mutex nor checks
vc4_hdmi->scdc_enabled:

drivers/gpu/drm/vc4/vc4_hdmi.c:vc4_hdmi_scrambling_wq() {
	...
	if (drm_scdc_get_scrambling_status(connector))
		return;

	drm_scdc_set_high_tmds_clock_ratio(connector, true);
	drm_scdc_set_scrambling(connector, true);

	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
}

won't the in-flight worker observe drm_scdc_get_scrambling_status(connector)
returning false, write SCDC_TMDS_BIT_CLOCK_RATIO_BY_40 and
SCDC_SCRAMBLING_ENABLE back to true on the sink, and re-queue scrambling_wo=
rk
every second after vc4_hdmi_disable_scrambling() has finished?

>  	clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
>  	clk_disable_unprepare(vc4_hdmi->pixel_clock);
> =20
> @@ -1555,6 +1552,13 @@ static void vc4_hdmi_encoder_pre_crtc_configure(st=
ruct drm_encoder *encoder,
>  		goto err_disable_pixel_clock;
>  	}
> =20
> +	if (vc4_hdmi_supports_scrambling(vc4_hdmi) &&
> +	    vc4_hdmi_mode_needs_scrambling(mode, vc4_hdmi->output_bpc, vc4_hdmi=
->output_format)) {
> +		drm_scdc_set_high_tmds_clock_ratio(connector, true);
> +		drm_scdc_set_scrambling(connector, true);
> +		usleep_range(1000, 2000);
> +	}
> +

[Severity: Medium]
Is it intentional to enable SCDC scrambling in the sink here in
vc4_hdmi_encoder_pre_crtc_configure(), while leaving the source scrambler
enable (VC5_HDMI_SCRAMBLER_CTL_ENABLE) and vc4_hdmi->scdc_enabled =3D true =
at
the end of vc4_hdmi_encoder_post_crtc_enable()?

During vc4_atomic_commit_tail() -> drm_atomic_helper_commit_modeset_enables=
()
-> vc4_crtc_atomic_enable() for a mode above 340 MHz, after
vc4_hdmi_encoder_pre_crtc_configure() sets SCDC_SCRAMBLING_ENABLE in the si=
nk,
the driver runs phy_init(), set_timings(), enables the PixelValve, and then=
 in
vc4_hdmi_encoder_post_crtc_enable() enables video output, waits for
VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE, enables packet RAM, transmits
InfoFrames via drm_atomic_helper_connector_hdmi_update_infoframes(), and ca=
lls
vc4_hdmi_recenter_fifo() before finally calling vc4_hdmi_enable_scrambling(=
):

drivers/gpu/drm/vc4/vc4_hdmi.c:vc4_hdmi_encoder_post_crtc_enable() {
	...
	if (display->is_hdmi) {
		...
		HDMI_WRITE(HDMI_RAM_PACKET_CONFIG,
			   VC4_HDMI_RAM_PACKET_ENABLE);

		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
		vc4_hdmi->packet_ram_enabled =3D true;

		drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
	}

	vc4_hdmi_recenter_fifo(vc4_hdmi);
	vc4_hdmi_enable_scrambling(encoder);
}

During that window, the sink's descrambler is enabled while the source is
transmitting unscrambled TMDS control periods, video data, and initial
InfoFrames.

In addition, because vc4_hdmi->mutex is dropped between
vc4_hdmi_encoder_pre_crtc_configure() and vc4_hdmi_encoder_post_crtc_enable=
(),
if vc4_hdmi_enable_scrambling() returns early (for example if a concurrent
vc4_hdmi_connector_detect_ctx() -> vc4_hdmi_handle_hotplug() ->
drm_atomic_helper_connector_hdmi_hotplug() updates connector->display_info =
so
vc4_hdmi_supports_scrambling() returns false, or if drm_dev_enter() fails),
vc4_hdmi->scdc_enabled will remain false while the sink's SCDC bits are left
enabled, causing vc4_hdmi_disable_scrambling() to skip clearing them on
disable.

Also, drm_scdc_set_high_tmds_clock_ratio() in
drivers/gpu/drm/display/drm_scdc_helper.c already calls usleep_range(1000,
2000) before returning, so is the additional usleep_range(1000, 2000) here
needed?

>  	if (vc4_hdmi->variant->phy_init)
>  		vc4_hdmi->variant->phy_init(vc4_hdmi, conn_state);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020134941.6319=
07-1-lucas.tanure@neat.no?part=3D1
