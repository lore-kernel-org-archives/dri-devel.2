Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72E1C54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B30410E879;
	Tue, 28 Jul 2026 10:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QhZO0azj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4776D10E877
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:40:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A50860A9E;
 Tue, 28 Jul 2026 10:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124F51F000E9;
 Tue, 28 Jul 2026 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785235199;
 bh=0D4g/S1o3cSeE9E3aOppuaMZh5wNMIqWIvbvpczacns=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QhZO0azjem2DTTZUD4i9Wjr67GJ05OUMN+aCAKV6MWDZz8FohLxN0gfBYfTNls8gn
 REpjRMejK5Mi1E2VpRXeBby+dAs61/+NiptrBxelEsS40eIIOGlvBlMpcNKIYw1xg8
 qpFPvHTv8zRUoLAsaEFTbTJJiXZ28nnqkZejxfefswxo9qEx5CXoB7zY1ZqXOX00gq
 OeGmNwRWSZFKHrS6fue4x+xYLrbiJn3CN4W+Pbh8EGESnHL5Qhlr1Vs2u6Z0Qhyreo
 5kICRE5BpY/t4l097m31C93UH3q9mY9afq+KD/ZUGO6owibncCy3VBfVUQpFcaeb05
 NiTkJmqph2p1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/14] drm/msm/dp: re-arrange dp_display_disable()
 into functional parts
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-dp_mstclean-v9-9-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
 <20260728-dp_mstclean-v9-9-f7779fce10f4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 10:39:58 +0000
Message-Id: <20260728103959.124F51F000E9@smtp.kernel.org>
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
- [High] Redundant call to msm_dp_panel_disable_vsc_sdp() transmits Seconda=
ry Data Packet (SDP) updates over the main link to a sink that has already =
been powered down.
--

--- Patch [9]: [PATCH v9 09/14] drm/msm/dp: re-arrange dp_display_disable()=
 into functional parts ---
commit 71c4fed95d00e4e9b083de79dc56ede059ae5722
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: re-arrange dp_display_disable() into functional parts
   =20
dp_display_disable() handles special case of when monitor is
disconnected from the dongle while the dongle stays connected
thereby needing a separate function dp_ctrl_off_link_stream()
for this. However with a slight rework this can still be handled
by keeping common paths same for regular and special case.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index d094d484474cd..cd8a3b171d9db 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -716,12 +716,20 @@ static int msm_dp_display_disable(struct msm_dp_dis=
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
Does this code call msm_dp_panel_disable_vsc_sdp() a second time after the
sink is already powered down?

msm_dp_display_disable() first disables the VSC SDP:

	msm_dp_panel_disable_vsc_sdp(dp->panel);

And then it places the sink into D3 power down state:

	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);

However, msm_dp_ctrl_off() also inherently calls
msm_dp_panel_disable_vsc_sdp().

Because msm_dp_panel_disable_vsc_sdp() writes to configuration registers
and triggers msm_dp_panel_update_sdp() to transmit an SDP over the main lin=
k,
could this redundant call cause the DP controller to timeout waiting for a
response from the already powered-down sink, or leave the display hardware
unresponsive?

> +		/* re-init the PHY so that we can listen to Dongle disconnect */
> +		msm_dp_ctrl_reinit_phy(dp->ctrl);
>  	} else {
>  		/*
>  		 * unplugged interrupt

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-dp_mstclea=
n-v9-0-f7779fce10f4@oss.qualcomm.com?part=3D9
