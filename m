Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74D2CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5168311A058;
	Thu,  4 Jun 2026 13:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B6b61wpe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A1611A058
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:22:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0B7C40B64;
 Thu,  4 Jun 2026 13:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5F31F00898;
 Thu,  4 Jun 2026 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780579361;
 bh=6iaAxOe5Pdj/Dt9cTUoWYlp7QKbhtrvvLDUXgGLDlqE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=B6b61wpeR4fy2cBp5R3+7PDR6//mNBrqmCQJZajRy/A7bAIrBt0n0v+6xLasq/aHQ
 1WpBF2HZsaTS8SC4/sBzWnTuSPEPw9hu+8YrbxX1J/wMnimRP+mvJZrK4o/M63AwvH
 UKk/W4V8KsElPGTZ7ehmwtXNC5a3bJEkAfSUib5ikMgXe6wfpL11c7j7232+rlBaK9
 RApolfWRCzAAPMsTMC7+p8BAFZmLzuFGxR0jdbqo5OXBa94U1YPAPuBOwiX4BwCetD
 jkTspYkdqEaGFLqY3ttbJTgNfKFhApvzy9hvjqBLexp2LnOCuKwK9AAk8rzZhlzEnh
 TqGCySX/8hMJw==
Date: Thu, 4 Jun 2026 15:22:39 +0200
From: Maxime Ripard <mripard@kernel.org>
To: wangdich9700@163.com
Cc: maarten.lankhorst@linux.intel.com, airlied@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH] drm/connector: add CRTC state change callback to HDMI
 audio helpers
Message-ID: <20260604-adaptable-myna-of-courage-7ffeae@houat>
References: <20260527085329.124777-1-wangdich9700@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="esonjemvazrrql4m"
Content-Disposition: inline
In-Reply-To: <20260527085329.124777-1-wangdich9700@163.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--esonjemvazrrql4m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/connector: add CRTC state change callback to HDMI
 audio helpers
MIME-Version: 1.0

Hi,

On Wed, May 27, 2026 at 04:53:29PM +0800, wangdich9700@163.com wrote:
> From: wangdicheng <wangdicheng@kylinos.cn>
>=20
> The DRM HDMI audio helper framework notifies the audio codec about
> physical connection changes via drm_connector_hdmi_audio_plugged_notify(),
> but has no mechanism to notify when the CRTC state changes while the
> connector remains physically connected.
>=20
> This is a real problem on platforms with DP/HDMI audio. When a CRTC is
> disabled while the sink remains connected (e.g. user switches to
> "internal display only" mode but still wants audio from the external
> monitor), the audio path silently breaks because:
>=20
> 1. The video stream is disabled, so there are no blanking intervals
>    for audio Secondary Data Packets (SDP) to be transported.
>=20
> 2. The audio codec still believes the jack is present because
>    plugged_notify() was not called (the connector is still physically
>    connected).
>=20
> 3. Userspace (PulseAudio/PipeWire) continues routing audio to the
>    external display, but no sound is actually output.
>=20
> Without a framework-level notification, vendors who need to support
> "audio output to external display while CRTC is inactive" are forced
> to scatter condition checks across CRTC disable, encoder disable,
> suspend, and resume paths. This pattern is fragile: any change in
> the display pipeline can break the audio path, and the same condition
> ("connector connected but CRTC inactive, and audio is in use") must
> be duplicated in multiple locations.
>=20
> The root cause is architectural: the audio codec has no visibility
> into CRTC state changes, so there is no clean way to implement
> policies like:
>=20
> - Mute audio output when CRTC is disabled (instead of silent breakage)
> - Keep the video stream alive for audio transport
> - Switch to DP Audio Only mode (hardware-supported on some platforms,
>   e.g. Intel TRANS_DP_AUDIO_ONLY, but never used in i915 driver)
>=20
> The HDA HDMI silent stream / KAE mechanism partially addresses this on
> Intel platforms, but it operates only on the audio codec side and does
> not coordinate with the DRM side. It also cannot work on platforms
> without HDA codec support (e.g. ASoC-based designs).
>=20
> Add an optional callback crtc_state_change() to
> drm_connector_hdmi_audio_funcs, and a corresponding notification
> function drm_connector_hdmi_audio_crtc_notify(). DRM drivers should
> call this when the CRTC state changes on a connector with audio
> capability, allowing audio codec implementations to react to display
> pipeline state changes rather than only physical connection changes.
>=20
> This provides a framework-level mechanism to implement "audio without
> active display" policies cleanly, instead of scattering condition
> checks across the display pipeline.
>=20
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>

I'm not saying this is right or wrong, but I'd like to see what it looks
like from a driver point of view before merging anything in the
framework.

Maxime

--esonjemvazrrql4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiF8HgAKCRAnX84Zoj2+
dlf6AX4sXeFeJrd9hJOCZK2d2NAsvapCSl2UFgSyOmi58uKhmw+Fx5SyzCbaNofT
0nJJtAQBf0QLI9se14JNAWKbWQNAj774wcSBuBLtpj+3a2OCKvfBJz1K0lQ5Jga9
NiMsYhFxzQ==
=c1MQ
-----END PGP SIGNATURE-----

--esonjemvazrrql4m--
