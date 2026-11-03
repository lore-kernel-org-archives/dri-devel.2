Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B90606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXyDyVd6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDFF10E2E5;
	Tue,  3 Nov 2026 03:53:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D068B10E2E5
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 03:52:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 661BB4049F;
 Tue,  3 Nov 2026 03:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231A91F000C1;
 Tue,  3 Nov 2026 03:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793677976;
 bh=wzYgxYOdf148EOlczQyeAOMq3VmWTR4s1xIcsuX5sqM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LXyDyVd6APX1T/FdnkgfVWNu3lB5ddYuzIlpiCWv2Xt3tmdazNoRMZWIxJqnq1nv6
 goVjUTVuOkb39Do+JZbx9EisJZ6Q+sh2rbmb40FOjilq2Vp8uXexfiQyhQf0fRHRdy
 biXq7NMKzLmFjhlu2b/Oo8upQUTwkMScJWAQMyHDTJoJ1zn7kOoU/bMsvQYGlZIXHp
 dZXYuabdj87y8Qr+ww/krdYLPjtRPt55LUthz39dG/kSBSSX5bA82eSE4GLOh0pOd0
 7OOS1EINnOpNB1cAeKZ0kJKB6ph4a7bNWnILrt11nav5e7xy7rLjE0L5n3K6u+eYRP
 pAm7OZbaSvPEw==
Message-ID: <sashiko-outbox-194543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: Only enable HDMI audio if display
 supports it
To: "Panpan Ren" <renpanpan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103033914.21660-1-renpanpan@kylinos.cn>
References: <20261103033914.21660-1-renpanpan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:52:55 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/amdgpu: dce_v*_0_afmt_setmode() disables shared audio pin wh=
en !has_audio
--

commit 82b015798aa29dad02e55c15ad68c627d16b7df9
Author: renpanpan <renpanpan@kylinos.cn>

drm/amdgpu: Only enable HDMI audio if display supports it

This commit gates the final audio_enable(adev, dig->afmt->pin, true) call at
the end of dce_v6_0_afmt_setmode(), dce_v8_0_afmt_setmode(), and
dce_v10_0_afmt_setmode() on connector->display_info.has_audio or the
AMDGPU_AUDIO_ENABLE override.

> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index 7de7adc8f225c..a692227ddfefa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1705,8 +1705,10 @@ static void dce_v10_0_afmt_setmode(struct drm_enco=
der *encoder,
>  	WREG32(mmAFMT_RAMP_CONTROL2 + dig->afmt->offset, 0x00000001);
>  	WREG32(mmAFMT_RAMP_CONTROL3 + dig->afmt->offset, 0x00000001);
> =20
> -	/* enable audio after to setting up hw */
> -	dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it or is forced on */
> +	if (connector->display_info.has_audio ||
> +	    to_amdgpu_connector(connector)->audio =3D=3D AMDGPU_AUDIO_ENABLE)
> +		dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
>  }
> =20
>  static void dce_v10_0_afmt_enable(struct drm_encoder *encoder, bool enab=
le)
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 3c1d6901127d1..d21efce004f56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1748,8 +1748,10 @@ static void dce_v6_0_afmt_setmode(struct drm_encod=
er *encoder,
>  		dce_v6_0_audio_dp_enable(encoder, 1);
>  	}
> =20
> -	/* enable audio after setting up hw */
> -	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it or is forced on */
> +	if (connector->display_info.has_audio ||
> +	    amdgpu_connector->audio =3D=3D AMDGPU_AUDIO_ENABLE)
> +		dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
>  }
> =20
>  static void dce_v6_0_afmt_enable(struct drm_encoder *encoder, bool enabl=
e)
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index a17944d5e8434..22c0d91c3041c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1653,8 +1653,10 @@ static void dce_v8_0_afmt_setmode(struct drm_encod=
er *encoder,
>  	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
>  	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
> =20
> -	/* enable audio after setting up hw */
> -	dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it or is forced on */
> +	if (connector->display_info.has_audio ||
> +	    to_amdgpu_connector(connector)->audio =3D=3D AMDGPU_AUDIO_ENABLE)
> +		dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
>  }

[Severity: Medium]
Can gating only the final audio_enable(..., true) call in
dce_v6_0_afmt_setmode(), dce_v8_0_afmt_setmode(), and
dce_v10_0_afmt_setmode() disable active audio on another connected display?

In dce_v6_0.c, dce_v8_0.c, and dce_v10_0.c, the audio_get_pin() helpers do
not track per-encoder pin ownership and simply return the first connected p=
in
in adev->mode_info.audio.pin[].

At the start of dce_v10_0_afmt_setmode() (and similarly in
dce_v6_0_afmt_setmode() and dce_v8_0_afmt_setmode()), the function
unconditionally grabs and disables that pin before configuring the hardware:

	/* disable audio prior to setting up hw */
	dig->afmt->pin =3D dce_v10_0_audio_get_pin(adev);
	dce_v10_0_audio_enable(adev, dig->afmt->pin, false);

It then programs the DTO, pin endpoint registers (speaker allocation, SAD,
lipsync), and enables HDMI_AUDIO_INFO_SEND and AFMT_AUDIO_SAMPLE_SEND.

When a non-audio HDMI monitor (or a non-audio DP monitor on DCE6) sets mode
while another encoder is driving an audio-capable display, afmt_setmode() on
the non-audio encoder will grab the same audio pin, disable it via
audio_enable(adev, dig->afmt->pin, false), overwrite its endpoint and DTO
state, and then skip re-enabling it at the end of the function.

Furthermore, because dig->afmt->pin remains assigned on the non-audio
encoder, a subsequent call to dce_v6_0_afmt_enable(), dce_v8_0_afmt_enable(=
),
or dce_v10_0_afmt_enable() with enable =3D=3D false on the non-audio encode=
r will
also call audio_enable(adev, dig->afmt->pin, false) and shut off the shared
pin:

	if (!enable && dig->afmt->pin) {
		dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
		dig->afmt->pin =3D NULL;
	}

Should the audio capability check happen before acquiring and disabling
dig->afmt->pin (or in the caller before enabling AFMT audio), similar to how
radeon checks drm_detect_monitor_audio() before setting up audio?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103033914.2166=
0-1-renpanpan@kylinos.cn?part=3D1
