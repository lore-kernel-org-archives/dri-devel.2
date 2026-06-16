Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551E7CD98E3
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9482610E1E6;
	Tue, 16 Jun 2026 15:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JUV8Po3t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1447A10E1E6
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 15:25:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 517C760122;
 Tue, 16 Jun 2026 15:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81FB1F000E9;
 Tue, 16 Jun 2026 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781623537;
 bh=yasEz4Tq+eUaI6JGQsAnSpTU53AkTnLLp12eYN07HE0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JUV8Po3tjzCUY546QlfKhCSnMjmPICeJL5Kh+t5qisQAITKG+Q72XTxWHZ8qYTO0c
 kGgVHaYHoiYul6YPklOxYQJy7QO7IHzB4FSIfdng4rnDrQGy7AZF6oRmNM4+41Y6RA
 zhtMCPxLFXcG5KA1D4mBdX7Wlg2GmeE4pC1ZWBI2dxtE07uWrBoGpXhEh0whr7v/CT
 lb1qSM7RGpRLvbb3jDAoFi5OhvQtAIRCHVaQg8mt5WfOctoSMF4VsaG/1tqrS/oDe2
 y0yK9gTDHhsXpw4yBMz1QhjDrBgy1QEMCF2/HWt4Sio8I14hH+z0H9tcHj0XE3knNK
 jA3UQMZ15uw+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/msm/dp: return 0 from audio_prepare when cable
 is disconnected
To: "Kumar Anurag" <kumar.singh@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616151252.3599089-2-kumar.singh@oss.qualcomm.com>
References: <20260616151252.3599089-2-kumar.singh@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:25:36 +0000
Message-Id: <20260616152536.D81FB1F000E9@smtp.kernel.org>
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
- [High] Returning success (0) from `msm_dp_audio_prepare` when the display=
 is disconnected causes silent audio failures upon hotplug and NoC errors d=
ue to unclocked DSP hardware access.

Pre-existing issues:
- [High] Race condition between `msm_dp_audio_prepare` and `msm_dp_display_=
disable` causes unclocked MMIO accesses.
--

commit bfb65364e66313dc1385a42e09172f44a1e1fbd1
Author: Kumar Anurag <kumar.singh@oss.qualcomm.com>

drm/msm/dp: return 0 from audio_prepare when cable is disconnected

PipeWire treats a non-zero return from prepare as fatal, marking the
DP audio device as a dummy sink when the cable is unplugged.

> The active_stream_cnt guard already prevents any unclocked hardware acces=
s,
> so return success instead of -EINVAL when the link is not active.

[Severity: High]
Is this commit message accurate for the upstream tree? There doesn't appear
to be an active_stream_cnt guard in the mainline driver. Without this guard,
will the DSP push data to powered-off, unclocked DP hardware and cause NoC
errors?

> diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/d=
p_audio.c
> index 41018e82efa10..df222943ae57f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_audio.c
> +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
> @@ -284,10 +284,8 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
>  	 * such cases check for connection status and bail out if not
>  	 * connected.
>  	 */
> -	if (!msm_dp_display->power_on) {
> -		rc =3D -EINVAL;
> +	if (!msm_dp_display->power_on)
>  		goto end;

[Severity: High]
Does returning 0 here trick the ALSA/ASoC framework into marking the stream
as successfully prepared?

If the stream is marked RUNNING, ALSA won't re-invoke prepare() when the
display is later connected. Could this regression result in silent playback
because the DP hardware is never actually configured?

[Severity: High]
This is a pre-existing issue, but does this lockless check of power_on
race with msm_dp_display_disable()?

If msm_dp_display_disable() runs concurrently (e.g., from a hotplug interru=
pt)
immediately after this check but before audio_enabled is set to true, it wi=
ll
skip waiting and disable the DP link and clocks.

When msm_dp_audio_prepare() resumes, it will call msm_dp_audio_setup_sdp() =
and
attempt MMIO operations on unclocked DP audio registers. Could this lead to=
 a
synchronous external abort?

> -	}
> =20
>  	audio =3D msm_dp_audio_get_data(msm_dp_display);
>  	if (IS_ERR(audio)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616151252.3599=
089-2-kumar.singh@oss.qualcomm.com?part=3D1
