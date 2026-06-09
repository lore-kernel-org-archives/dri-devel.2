Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341DECD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9436D10E222;
	Tue,  9 Jun 2026 10:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BuJdQGm4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2449E10E222
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:17:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0827B407F4;
 Tue,  9 Jun 2026 10:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2F21F00893;
 Tue,  9 Jun 2026 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781000232;
 bh=vT0SGOzlrNIk05SQtKAK5dwRyPsSVqOqe2VIUP68NYU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BuJdQGm4six0UX+q7BceYGibxo+2W7ubPZU5Sxqf8o+CvKmZQsuCWF4Hune2btUYQ
 nuhOm6eUf3pXaORf5jPCiHTMxa7jsSOKIho7wSf7goss5KXcBt7ohwXUmsHN44QiE9
 aeldc8pQGT/n8SlmAUQGNfhW0VXfe+EtNvCjFD1CC7TYpwFJ+bFJSMNL8Jv3S43R7k
 gkkInfrOEFsM/iTmu42n1fBzi+Xcq0V6c3LvT264abbAUUrcUyPwIphSP2ioQtZHsa
 LU97iEciYjal+6N7mHfRv7hsjMCiRyKEdqMqhr5B+9f2YD4HIfc207QIJlru7gUo6q
 KCEUpqUab0OlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/15] drm/msm/dp: re-arrange dp_display_disable()
 into functional parts
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-9-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-9-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:17:12 +0000
Message-Id: <20260609101712.AC2F21F00893@smtp.kernel.org>
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
- [High] Replacing msm_dp_ctrl_off_link_stream() with msm_dp_ctrl_off() for=
 the disconnected monitor case inadvertently resets the DP controller, clea=
ring HPD interrupt masks and permanently breaking dongle unplug detection.

Pre-existing issues:
- [High] The display disable sequence invokes sleeping functions from atomi=
c context during the bridge post_disable callback.
--

commit 4edd0bb0b0901115e8cbd3c69301ff0b85ef4340
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: re-arrange dp_display_disable() into functional parts

dp_display_disable() handles special case of when monitor is
disconnected from the dongle while the dongle stays connected
thereby needing a separate function dp_ctrl_off_link_stream()
for this. However with a slight rework this can still be handled
by keeping common paths same for regular and special case.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 2cf4c984c7ca7..e1d90b8539c27 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -714,12 +714,20 @@ static int msm_dp_display_disable(struct msm_dp_dis=
play_private *dp)
>  	if (!msm_dp_display->power_on)
>  		return 0;
> =20
> +	msm_dp_panel_disable_vsc_sdp(dp->panel);
> +
> +	/* dongle is still connected but sinks are disconnected */
>  	if (dp->link->sink_count =3D=3D 0) {
>  		/*
>  		 * irq_hpd with sink_count =3D 0
>  		 * hdmi unplugged out of dongle
>  		 */
> -		msm_dp_ctrl_off_link_stream(dp->ctrl);
> +
> +		/* set dongle to D3 (power off) mode */
> +		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> +		msm_dp_ctrl_off(dp->ctrl);

[Severity: High]
Does replacing msm_dp_ctrl_off_link_stream() with msm_dp_ctrl_off() here
permanently break dongle unplug detection?

msm_dp_ctrl_off() calls msm_dp_ctrl_reset(), which performs a software
reset (DP_SW_RESET) on the controller:

	sw_reset |=3D DP_SW_RESET;
	msm_dp_write_ahb(ctrl, REG_DP_SW_RESET, sw_reset);

This clears the controller's register state, including REG_DP_INTR_STATUS
and REG_DP_DP_HPD_INT_MASK.

Because the dongle is still connected, the driver holds a runtime PM refere=
nce
and doesn't transition through suspend/resume. Will this cause the HPD
interrupts to remain permanently masked, causing the driver to silently miss
subsequent dongle unplug events since msm_dp_ctrl_enable_irq() is never cal=
led
again?


[Severity: High]
This isn't a bug introduced by this patch, but does calling msm_dp_ctrl_off=
()
here invoke sleeping functions from atomic context?

msm_dp_display_disable() is invoked from the bridge atomic disable path, wh=
ich
runs in atomic context where sleeping is forbidden. However, msm_dp_ctrl_of=
f()
calls msm_dp_ctrl_reset(), which executes:

	usleep_range(1000, 1100);

Is this safe to run in atomic commit paths?

> +		/* re-init the PHY so that we can listen to Dongle disconnect */
> +		msm_dp_ctrl_reinit_phy(dp->ctrl);

[Severity: High]
This is a pre-existing issue, but does calling msm_dp_ctrl_reinit_phy()
here also invoke sleeping functions from atomic context?

msm_dp_ctrl_reinit_phy() calls generic PHY framework functions (phy_exit()
and phy_init()) that acquire mutexes internally, which is forbidden in atom=
ic
context.

>  	} else {
>  		/*
>  		 * unplugged interrupt

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D9
