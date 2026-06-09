Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40121CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627DA10E20D;
	Tue,  9 Jun 2026 10:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BqyAo6kz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA3B10E20D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:02:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEBBC601DC;
 Tue,  9 Jun 2026 10:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4726E1F00893;
 Tue,  9 Jun 2026 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999343;
 bh=8kHfBDZKHcSFsUcGGN68/54k4nvukqqfoUCBikBVWmo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BqyAo6kz48Piq0UeI7ZzK0CVBiZbe9ocuOhWVfXVT466buRONmtyvXXSG91sxmbfV
 aLnVt7ull+ALSW+uGk/m74NHJtJLSKpH4y24Ui1mcj3H2AFG11Wv6amsqIyctQoN6Z
 aIMiecZD907ZeDHB4Muygo7y59OE4h67t22JMHgB8jyHtax3NMJgYyKmJdPx0Q/fTO
 ImsZzLtVf4KgH3ZcaJwNrf+/HoylvP2rPHd1j2x4mjmsrUQOQrS2c4zkSGCuSb2e3S
 ODgaHpqFwuu3Rb3Wzme2kVe48mf4gaUthkyxkx4Oq7A51Hcly4t2BT7+z/8/ndlG40
 4Z3ilKRHM+J0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/15] drm/msm/dp: simplify link and clock disable
 sequence
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-12-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-12-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:02:22 +0000
Message-Id: <20260609100223.4726E1F00893@smtp.kernel.org>
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
- [High] The patch introduces a Time-of-Check to Time-of-Use (TOCTOU) race =
by splitting a single `sink_count` evaluation into two unprotected checks, =
risking an inconsistent hardware disable sequence.
--

commit 4b86b22d6f1aa41eba1cece8a907cf0b3a12b55c
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: simplify link and clock disable sequence

This patch refactors the disable sequence by pulling common steps out
of the sink_count condition block to simplify the flow.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -716,27 +716,19 @@ static int msm_dp_display_disable(struct msm_dp_dis=
play_private *dp)
> =20
>  	msm_dp_panel_disable_vsc_sdp(dp->panel);
> =20
> -	/* dongle is still connected but sinks are disconnected */
> -	if (dp->link->sink_count =3D=3D 0) {
[ ... ]
> +	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> =20
> -		/* set dongle to D3 (power off) mode */
> +	/* dongle is still connected but sinks are disconnected */
> +	if (dp->link->sink_count =3D=3D 0)
>  		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> -		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +
> +	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +
> +	if (dp->link->sink_count =3D=3D 0)

[Severity: High]
Could this double-evaluation of dp->link->sink_count introduce a race
condition?

The original code checked dp->link->sink_count =3D=3D 0 exactly once. By
checking it twice, if an asynchronously processed HPD IRQ event modifies
the sink_count between the two checks, could the driver execute a
mismatched hardware disable sequence?

For instance, if sink_count changes from 0 to 1 after the first check,
the driver would perform msm_dp_link_psm_config(), but then take the
else branch and call msm_dp_display_host_phy_exit() below. This would
leave the PHY completely powered down, potentially breaking the ability
to detect future dongle disconnects.

Would it be safer to read sink_count once into a local variable and
evaluate the local variable for both conditions?

> +		/* re-init the PHY so that we can listen to Dongle disconnect */
>  		msm_dp_ctrl_reinit_phy(dp->ctrl);
> -	} else {
> -		/*
> -		 * unplugged interrupt
> -		 * dongle unplugged out of DUT
> -		 */
> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> -		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
> +	else
>  		msm_dp_display_host_phy_exit(dp);
> -	}
> =20
>  	msm_dp_display->power_on =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D12
