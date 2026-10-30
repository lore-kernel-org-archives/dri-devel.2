Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C59606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqBTXH67
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AB010E879;
	Fri, 30 Oct 2026 10:11:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37A210E879
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:11:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EE42601EE;
 Fri, 30 Oct 2026 10:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672E41F000C1;
 Fri, 30 Oct 2026 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793355105;
 bh=Keq8l/LaR55uxRtrq1C75Crik8bqjBF0WvmIWNJLZIQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hqBTXH67i7iQ24Uc/YBdJStl1wi8ZtOxRofe2SSZh8GA0+NsUXkjLLKOOmUQKJ3Y9
 SCU4CKQuQuSTqMYodcL/eMBsFBcZ3EpFdt9VEyxy77mMrPiLjmQt36YhjqS1b3EAVT
 JL4QooYSk+1R1S2/7uxhcpZNN9oFefKO68NPnI1Vwa2GGHM8JqVOa31Z/y4CST6668
 CqKcldl6Eo+eUhkUTxlYtpOW8ZSbz8WIGi90YgYvLWotL+/+tqyWvkD/RdlQug5SMj
 3BANRx+og6T3vpJgFGbowZlfnXpQuMH0LBTYkgLRL9a795IZRDjQozUkoE716Ii7SG
 fC9tO9UftNHaQ==
Message-ID: <sashiko-outbox-190814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/15] drm/imx: dc-crtc: Disable at boot
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261030-imx8-dc-prefetch-v8-6-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-6-c4f81afd4533@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:11:44 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/imx: dc-crtc: premature clk_axi disable in dc_crtc_disable_a=
t_boot()
--

commit e47c892a97b7a909d6fe7c57ba9a8454d386aea8
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc-crtc: Disable at boot

This commit adds dc_crtc_disable_at_boot() and calls it for each CRTC in
dc_drm_bind() prior to drm_dev_register() to ensure CRTCs and their
associated clocks left running across an unplug are disabled at boot.

> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc=
-crtc.c
> index 0d64186a99018..5bc952d6883e1 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c

[ ... ]

> @@ -331,6 +341,48 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct=
 drm_atomic_commit *state)
>  	spin_unlock_irq(&crtc->dev->event_lock);
>  }
> =20
> +int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
> +{
> +	struct dc_drm_device *dc_drm =3D to_dc_drm_device(crtc->dev);
> +	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dc_crtc->de->dev);
> +	if (ret < 0) {
> +		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
> +			    ret);
> +		goto out1;
> +	}
> +
> +	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
> +		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
> +		goto out2;
> +	}
> +
> +	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
> +	__dc_crtc_disable_fg(crtc);
> +
> +	if (!dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)))
> +		goto out2;
> +
> +	dc_crtc_dbg(crtc, "disabling clocks at boot\n");
> +
> +	dc_fg_disable_clock(dc_crtc->fg);
> +
> +	dc_drm->pe_clk_axi_needs_disable =3D true;
> +
> +	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
> +
> +out2:
> +	pm_runtime_put(dc_crtc->de->dev);
> +out1:
> +	/* Let CRTC(with index =3D=3D 1) disablement path disable AXI clock. */
> +	if (dc_drm->pe_clk_axi_needs_disable && drm_crtc_index(crtc) =3D=3D 1)
> +		clk_disable_unprepare(dc_drm->pe->clk_axi);
> +
> +	return ret;
> +}

[Severity: Medium]
In dc_crtc_disable_at_boot() in drivers/gpu/drm/imx/dc/dc-crtc.c, can jumpi=
ng
to out1 when pm_runtime_resume_and_get() fails on CRTC1 prematurely disable
dc_drm->pe->clk_axi?

When dc_drm_bind() iterates over CRTCs with drm_for_each_crtc():

1. If CRTC0 was left enabled before unplug, dc_crtc_disable_at_boot() disab=
les
   CRTC0's FrameGen and pixel clock, sets dc_drm->pe_clk_axi_needs_disable =
to
   true, and clears CRTC_ENABLED(0).

2. Next, dc_crtc_disable_at_boot() is called for CRTC1 (drm_crtc_index(crtc=
) =3D=3D 1).
   If pm_runtime_resume_and_get(dc_crtc->de->dev) fails, it jumps to out1
   before stopping CRTC1's FrameGen or clearing CRTC_ENABLED(1).

3. At out1, both dc_drm->pe_clk_axi_needs_disable and drm_crtc_index(crtc) =
=3D=3D 1
   are true, so clk_disable_unprepare(dc_drm->pe->clk_axi) is called even
   though CRTC1 failed to disable.

If CRTC1 was also active, this cuts the Pixel Engine AXI clock while CRTC1 =
is
still scanning out through the Pixel Engine, and leaves CRTC_ENABLED(1) set=
 so
that a subsequent bind attempt would disable dc_drm->pe->clk_axi a second t=
ime.

Should the clk_disable_unprepare(dc_drm->pe->clk_axi) call happen before ou=
t1
(under out2), or only when ret =3D=3D 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-imx8-dc-pr=
efetch-v8-0-c4f81afd4533@nxp.com?part=3D6
