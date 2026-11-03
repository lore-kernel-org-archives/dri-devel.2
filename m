Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A6606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rhj2UGBR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F3210E7A7;
	Tue,  3 Nov 2026 06:27:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B060110E7A7
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:27:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D6CD760142;
 Tue,  3 Nov 2026 06:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A721F000C1;
 Tue,  3 Nov 2026 06:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793687254;
 bh=sXTPz1q7yx5fD0sCHgPqX3IwdGSVJvMdTL/Jz61QhVc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rhj2UGBRY8eXU0d9JoflBAEkZp/5bFnnHosLEFlFy4+9QWheXNAvdMLX99Tje1yqs
 GKSp8FEPYwjZjlKYThwWuCH7qyMpOl8ufHhN4NBdHn92tXXkMUHhnyMvjO7y5JVZj4
 vEBq2LaEdikPZ3/+Rzc5ORUnI5oqKM2AnU+C50PRzY5GBlH8ARWmnDoet3MMZg1GNG
 +NOU6nDfAKHhjdMBQwyz39fJhkYtuW//sgo6pb1f3ptvahV68X51mPo7smLpQT6FWT
 FY6wZR5ngoVZERnzzkMLhiHljzfsVVaDjQ0auYEBuoKCyCj8d8tfCUH7iJiUF+mui0
 tzUxDILAmJD4g==
Message-ID: <sashiko-outbox-194629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/amdgpu: Only enable HDMI audio if display
 supports it
To: "Panpan Ren" <renpanpan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103061147.25827-1-renpanpan@kylinos.cn>
References: <20261103061147.25827-1-renpanpan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 06:27:34 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/amdgpu: broken audio pin state and sharing in dce_v*_0_afmt_=
setmode()
- [Medium] drm/amdgpu: dce_v6_0_afmt_setmode() ignores AMDGPU_AUDIO_DISABLE=
 on DP
--

commit bd861db0f0aadc54fc085212778f034d398ae2b3
Author: renpanpan <renpanpan@kylinos.cn>

drm/amdgpu: Only enable HDMI audio if display supports it

This commit gates the initial and final audio_enable() calls in
dce_v6_0_afmt_setmode(), dce_v8_0_afmt_setmode(), and
dce_v10_0_afmt_setmode() on whether the connected display reports audio
support in its EDID or has audio forced on via AMDGPU_AUDIO_ENABLE.

> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index 7de7adc8f225c..6d5f25ea67c2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1555,9 +1555,11 @@ static void dce_v10_0_afmt_setmode(struct drm_enco=
der *encoder,
>  		bpc =3D amdgpu_crtc->bpc;
>  	}
> =20
> -	/* disable audio prior to setting up hw */
> +	/* disable audio prior to setting up hw, unless the display has no audi=
o */
>  	dig->afmt->pin =3D dce_v10_0_audio_get_pin(adev);
> -	dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
> +	if (connector->display_info.has_audio ||
> +	    to_amdgpu_connector(connector)->audio =3D=3D AMDGPU_AUDIO_ENABLE)
> +		dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
> =20
>  	dce_v10_0_audio_set_dto(encoder, mode->clock);
> =20
> @@ -1705,8 +1707,10 @@ static void dce_v10_0_afmt_setmode(struct drm_enco=
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

[Severity: Medium]
As reported by Sashiko on v2 [1], gating only the initial
audio_enable(adev, dig->afmt->pin, false) and final
audio_enable(adev, dig->afmt->pin, true) calls in dce_v10_0_afmt_setmode(),
dce_v6_0_afmt_setmode(), and dce_v8_0_afmt_setmode() still leaves two issues
with audio pin state and sharing:

First, when an already-active encoder transitions from an audio-enabled sta=
te
to a non-audio state (for example, changing the connector audio property fr=
om
AMDGPU_AUDIO_ENABLE back to AMDGPU_AUDIO_AUTO on a non-audio HDMI monitor v=
ia
amdgpu_connector_set_property() -> amdgpu_connector_property_change_mode() =
->
drm_crtc_helper_set_mode(), or hot-swapping an audio-capable display for a
non-audio display on the same active CRTC), drm_crtc_prepare_encoders() does
not disable the active encoder, and dce_v10_0_afmt_enable(encoder, true)
returns early because dig->afmt->enabled is already true. When
dce_v10_0_afmt_setmode() then runs with both connector->display_info.has_au=
dio
and audio =3D=3D AMDGPU_AUDIO_ENABLE evaluating to false, both the initial
dce_v10_0_audio_enable(..., false) and final dce_v10_0_audio_enable(..., tr=
ue)
calls are skipped. Doesn't this leave
AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL__AUDIO_ENABLED_MASK stuck enab=
led
in hardware?

Second, dce_v10_0_audio_get_pin(), dce_v8_0_audio_get_pin(), and
dce_v6_0_audio_get_pin() do not track per-encoder pin ownership and always
return the first connected pin in adev->mode_info.audio.pin[]:

drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:dce_v10_0_afmt_setmode() {
    ...
    dig->afmt->pin =3D dce_v10_0_audio_get_pin(adev);
    if (connector->display_info.has_audio ||
        to_amdgpu_connector(connector)->audio =3D=3D AMDGPU_AUDIO_ENABLE)
            dce_v10_0_audio_enable(adev, dig->afmt->pin, false);

    dce_v10_0_audio_set_dto(encoder, mode->clock);
    ...
    dce_v10_0_audio_write_speaker_allocation(encoder);
    ...
    dce_v10_0_afmt_audio_select_pin(encoder);
    dce_v10_0_audio_write_sad_regs(encoder);
    dce_v10_0_audio_write_latency_fields(encoder, mode);
    ...
}

Because dig->afmt->pin is still unconditionally assigned on a non-audio
display, dce_v10_0_afmt_setmode() still overwrites the global
mmDCCG_AUDIO_DTO_SOURCE and mmDCCG_AUDIO_DTO0_* registers as well as the
shared pin's speaker allocation, SAD, and latency registers, and enables au=
dio
infoframes and sample packets. Furthermore, when the non-audio encoder is
later disabled via dce_v10_0_encoder_disable() ->
dce_v10_0_afmt_enable(encoder, false):

drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:dce_v10_0_afmt_enable() {
    ...
    if (!enable && dig->afmt->pin) {
            dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
            dig->afmt->pin =3D NULL;
    }
    ...
}

won't disabling the non-audio encoder unconditionally call
dce_v10_0_audio_enable(adev, dig->afmt->pin, false) and turn off audio on
another active display sharing that pin (and similarly in dce_v6_0.c and
dce_v8_0.c)?

> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 3c1d6901127d1..3add851974b47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1724,8 +1724,10 @@ static void dce_v6_0_afmt_setmode(struct drm_encod=
er *encoder,
>  		bpc =3D amdgpu_crtc->bpc;
>  	}
> =20
> -	/* disable audio before setting up hw */
> -	dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
> +	/* disable audio before setting up hw, unless the display has no audio =
*/
> +	if (connector->display_info.has_audio ||
> +	    amdgpu_connector->audio =3D=3D AMDGPU_AUDIO_ENABLE)
> +		dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
> =20
>  	dce_v6_0_audio_set_mute(encoder, true);
>  	dce_v6_0_audio_write_speaker_allocation(encoder);
> @@ -1748,8 +1750,10 @@ static void dce_v6_0_afmt_setmode(struct drm_encod=
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

[Severity: Medium]
For HDMI and DVI connectors, amdgpu_atombios_encoder_get_encoder_mode()
returns ATOM_ENCODER_MODE_DVI when amdgpu_connector->audio =3D=3D
AMDGPU_AUDIO_DISABLE, which prevents dce_v6_0_afmt_setmode() from being
called.

However, for native DisplayPort sinks,
amdgpu_atombios_encoder_get_encoder_mode() unconditionally returns
ATOM_ENCODER_MODE_DP regardless of amdgpu_connector->audio:

drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:amdgpu_atombios_encoder_get_=
encoder_mode() {
    ...
    case DRM_MODE_CONNECTOR_DisplayPort:
        dig_connector =3D amdgpu_connector->con_priv;
        if ((dig_connector->dp_sink_type =3D=3D CONNECTOR_OBJECT_ID_DISPLAY=
PORT) ||
            (dig_connector->dp_sink_type =3D=3D CONNECTOR_OBJECT_ID_eDP)) {
                return ATOM_ENCODER_MODE_DP;
        }
    ...
}

and dce_v6_0_encoder_mode_set() calls dce_v6_0_afmt_setmode() whenever
ENCODER_MODE_IS_DP(em) is true.

Because dce_v6_0_afmt_setmode() checks connector->display_info.has_audio
without checking amdgpu_connector->audio !=3D AMDGPU_AUDIO_DISABLE, won't
setting the audio connector property to off (AMDGPU_AUDIO_DISABLE) on an
audio-capable DisplayPort monitor still enable audio here?

[1] https://lore.kernel.org/r/20261103033914.21660-1-renpanpan@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103061147.2582=
7-1-renpanpan@kylinos.cn?part=3D1
