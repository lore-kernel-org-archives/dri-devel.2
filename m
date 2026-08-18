Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB61AC5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C7710E043;
	Tue, 18 Aug 2026 23:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MvsjrZNt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AB710E043
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:56:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9A01601FB
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABA81F000E9;
 Tue, 18 Aug 2026 23:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787097375;
 bh=4LbfR1ZPkW6cFNY63XzyEZSq9rNJefkl55JVORkS9v8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MvsjrZNt4kEft4Q+2jBol1D9HBFi8qIFN4GMOb/NllIyH3m/8Pt4kPVRe7WZ/RjXu
 4XVORlSlSCf/T4d5dOuoK0KAFNm3rD036j/oR6mQq6E3PR1NEByjZ9CWup4dAzQL4x
 eVer17ZWUtgh7q4Y80FSEQ+sIJgaTOyuLlJDd66bh4HHKSAUK/ZlcktZfA6tezgeKZ
 MGUalblw7a6MqbQIg9ZOBO314sD39pjmGmdYgn4FW8f08xLP0BBW2U2Ea1N/uNqnEV
 4IIaJFBhb0Gi9vT3zMXfiBRD/0226TkYxhjCyuIJv0nvkYmxvn9br7zCi9lYlcnjWQ
 pfESiBLWfI1SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818234621.1265415-1-robh@kernel.org>
References: <20260818234621.1265415-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 23:56:15 +0000
Message-Id: <20260818235615.7ABA81F000E9@smtp.kernel.org>
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
- [Medium] Using WARN_ON() to validate device tree input causes unnecessary=
 kernel splats and potential kernel panics.
- [Medium] Breaking out of the initialization loop on invalid lane values l=
eaves the audio data structures in an inconsistent state.
--

--- Patch [1]: [PATCH] drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u3=
2 ---
commit a4b4eceb945fa6ac0b81acc248b81fdebf849bd9
Author: Rob Herring (Arm) <robh@kernel.org>

drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32

This patch updates the sii902x bridge driver to read the "sil,i2s-data-lane=
s"
property as a u32 array instead of a u8 array to match the device tree
bindings. It also introduces a bounds check on the array values to prevent
out-of-bounds accesses.

> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
[ ... ]
> @@ -890,9 +890,12 @@ static int sii902x_audio_codec_init(struct sii902x *=
sii902x,
>  	}
>  	codec_data.max_i2s_channels =3D 2 * num_lanes;
> =20
> -	for (i =3D 0; i < num_lanes; i++)
> +	for (i =3D 0; i < num_lanes; i++) {
> +		if (WARN_ON(lanes[i] >=3D ARRAY_SIZE(i2s_lane_id)))

[Severity: Medium]
Is it safe to use WARN_ON() for validating device tree properties?

If panic_on_warn is enabled, couldn't this crash the system when parsing
malformed or untrusted device tree data?

Would it be better to use dev_err() and gracefully fail initialization?

[Severity: Medium]
If this loop breaks early due to an invalid lane, codec_data.max_i2s_channe=
ls
remains set to 2 * num_lanes.

Could this cause an inconsistent state where ALSA exposes support for more
channels than the hardware has actually configured in i2s_fifo_sequence?

Should this path return an error (like -EINVAL) to abort audio
initialization, or update the channel count?

> +			break;
>  		sii902x->audio.i2s_fifo_sequence[i] |=3D audio_fifo_id[i] |
>  			i2s_lane_id[lanes[i]] |	SII902X_TPI_I2S_FIFO_ENABLE;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818234621.1265=
415-1-robh@kernel.org?part=3D1
