Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0D606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeAYts55
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20D110E5DA;
	Mon,  2 Nov 2026 10:13:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1217410E5DA
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:13:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20A496021C;
 Mon,  2 Nov 2026 10:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD41E1F000C1;
 Mon,  2 Nov 2026 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793614410;
 bh=r5FVjd2UCRZ+bMx1EcIopu42uN4coVp+E4jVAWmDKCQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JeAYts559I0Qjaadi9mANJKUOBzbI85EiTPnuu8gK1KEHpj1+nz/F+QRM3EpTEUsN
 VGjc1DIZ3YsWN4Y/hwxdlltkr6tF+U3tw+ojvX2Tqd6uMiP8nzSgXsAIEC25mP8fgi
 /45nGYRoxi2oWt7/Uft71ELDtLVB9nw9544J843Kfy82A1k10Z2DzVk9ORPBq3bbaL
 ey//ICUTUnWq0JJq65e4NLfluDngM1oa8nEZ+XmfrWeJ+OHgu0QjAO1w8BBHEUPZ+U
 O4ni2KOnAfWNAD3uEKCWyIIYMBhZbc29hnqWCo4G21z0/hIbGPnEI1CRKO2r4BegMn
 4QNrsItvRWqHw==
Message-ID: <sashiko-outbox-193243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: Only enable HDMI audio if display supports it
To: rppxj178543@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261102094929.251563-1-rppxj178543@163.com>
References: <20261102094929.251563-1-rppxj178543@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:13:29 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/amdgpu: shared audio pin disabled in dce_v*_0_afmt_setmode()
- [Medium] drm/amdgpu: audio packets still enabled when !has_audio in afmt_=
setmode()
- [Medium] drm/amdgpu: dce_v*_0_afmt_setmode() ignores AMDGPU_AUDIO_ENABLE =
override
--

commit f7468a5a289e3e4a150c1f54f3a6dce9ca20fa57
Author: renpanpan <renpanpan@kylinos.cn>

drm/amdgpu: Only enable HDMI audio if display supports it

This commit gates the call to dce_v6_0_audio_enable(),
dce_v8_0_audio_enable(), and dce_v10_0_audio_enable() at the end of each
afmt_setmode() callback on connector->display_info.has_audio so that
displays without EDID audio support do not appear as active HDMI audio
outputs.

> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index 7de7adc8f225c..05d7da888f492 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1705,8 +1705,9 @@ static void dce_v10_0_afmt_setmode(struct drm_encod=
er *encoder,
>  	WREG32(mmAFMT_RAMP_CONTROL2 + dig->afmt->offset, 0x00000001);
>  	WREG32(mmAFMT_RAMP_CONTROL3 + dig->afmt->offset, 0x00000001);
> =20
> -	/* enable audio after to setting up hw */
> -	dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it */
> +	if (connector->display_info.has_audio)
> +		dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
>  }
> =20
>  static void dce_v10_0_afmt_enable(struct drm_encoder *encoder, bool enab=
le)
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 3c1d6901127d1..f0722bdaeab61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1748,8 +1748,9 @@ static void dce_v6_0_afmt_setmode(struct drm_encode=
r *encoder,
>  		dce_v6_0_audio_dp_enable(encoder, 1);
>  	}
> =20
> -	/* enable audio after setting up hw */
> -	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it */
> +	if (connector->display_info.has_audio)
> +		dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
>  }
> =20
>  static void dce_v6_0_afmt_enable(struct drm_encoder *encoder, bool enabl=
e)
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index a17944d5e8434..3f5247314edee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1653,8 +1653,9 @@ static void dce_v8_0_afmt_setmode(struct drm_encode=
r *encoder,
>  	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
>  	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
> =20
> -	/* enable audio after setting up hw */
> -	dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it */
> +	if (connector->display_info.has_audio)
> +		dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
>  }

[Severity: Medium]
Can this disable audio on another active monitor in a multi-display setup?

Unlike radeon's dce6_audio_get_pin(), which tracks which pins are already
in use by other encoders and only allocates a pin when the display supports
audio, dce_v6_0_audio_get_pin(), dce_v8_0_audio_get_pin(), and
dce_v10_0_audio_get_pin() always return the first connected pin in
adev->mode_info.audio.pin[].

At the start of dce_v6_0_afmt_setmode(), dce_v8_0_afmt_setmode(), and
dce_v10_0_afmt_setmode(), the code unconditionally grabs that pin and
disables it:

	dig->afmt->pin =3D dce_v10_0_audio_get_pin(adev);
	dce_v10_0_audio_enable(adev, dig->afmt->pin, false);

If one encoder is driving a display with audio enabled and a second encoder
then runs afmt_setmode() for a display where
connector->display_info.has_audio is false (including non-audio DP/eDP
displays on DCE6, where dce_v6_0_encoder_mode_set() calls
dce_v6_0_afmt_setmode() for both HDMI and DP), the second encoder will grab
the same shared pin, disable it at entry, overwrite its endpoint registers,
and skip re-enabling it at the end of the function.

In addition, because dig->afmt->pin remains non-NULL on the non-audio
encoder, later disabling that encoder via dce_v6_0_afmt_enable(),
dce_v8_0_afmt_enable(), or dce_v10_0_afmt_enable() with enable =3D=3D false=
 will
also call audio_enable(adev, dig->afmt->pin, false) on the shared pin.

[Severity: Medium]
When connector->display_info.has_audio is false, should
dce_v6_0_afmt_setmode(), dce_v8_0_afmt_setmode(), and
dce_v10_0_afmt_setmode() also avoid enabling audio packet and secondary
stream transmission in the encoder hardware?

With this change, only the final Azalia codec pin enable
(AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL__AUDIO_ENABLED_MASK) is
skipped when has_audio is false. Earlier in dce_v8_0_afmt_setmode() and
dce_v10_0_afmt_setmode(), the hardware is still programmed to send HDMI
Audio InfoFrames, ACR packets, and audio sample packets:

	tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, =
1);
	tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_CONT, =
1);
	WREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset, tmp);
	...
	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL, HDMI_ACR_AUTO_SEND, 1);
	WREG32(mmHDMI_ACR_PACKET_CONTROL + dig->afmt->offset, tmp);
	...
	tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_AUDIO_SAMPLE_SE=
ND, 1);
	WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset, tmp);

Similarly, in dce_v6_0_afmt_setmode(), dce_v6_0_audio_hdmi_enable(encoder, =
1)
and dce_v6_0_audio_dp_enable(encoder, 1) are still called unconditionally
right before the has_audio check, enabling HDMI_AUDIO_INFO_SEND,
AFMT_AUDIO_SAMPLE_SEND, and the DP secondary audio stream bits
(DP_SEC_ASP_ENABLE, DP_SEC_ATP_ENABLE, DP_SEC_AIP_ENABLE, and
DP_SEC_STREAM_ENABLE in mmDP_SEC_CNTL) on sinks that do not support audio.

[Severity: Medium]
Does checking only connector->display_info.has_audio break the connector
audio property override when userspace forces audio on?

In drivers/gpu/drm/amd/amdgpu/atombios_encoders.c,
amdgpu_atombios_encoder_get_encoder_mode() checks amdgpu_connector->audio:

		if (amdgpu_audio !=3D 0) {
			if (amdgpu_connector->audio =3D=3D AMDGPU_AUDIO_ENABLE)
				return ATOM_ENCODER_MODE_HDMI;
			else if (connector->display_info.is_hdmi &&
				 (amdgpu_connector->audio =3D=3D AMDGPU_AUDIO_AUTO))
				return ATOM_ENCODER_MODE_HDMI;

When a user sets the connector audio property to "on"
(AMDGPU_AUDIO_ENABLE) for a monitor whose EDID does not advertise audio
(so connector->display_info.has_audio is false), the encoder mode is forced
to ATOM_ENCODER_MODE_HDMI and dce_v6_0_afmt_setmode(),
dce_v8_0_afmt_setmode(), or dce_v10_0_afmt_setmode() is called, but the
final audio_enable(..., true) call will now be skipped because only
connector->display_info.has_audio is checked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102094929.2515=
63-1-rppxj178543@163.com?part=3D1
