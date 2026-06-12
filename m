Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852B1CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC54710E331;
	Fri, 12 Jun 2026 21:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RgU7FJGu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE39710E331
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 21:58:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01D1860008
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 21:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6181F000E9
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 21:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781301486;
 bh=Bj6w17bcLBZGeRUnuXkk2OlLENN7RLEchwDDqC4m0FM=;
 h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
 b=RgU7FJGu4BxGt2fpWGIVqqpOI24R2EBXGaNJdtyaFo6m6l2ViXF9Y7C35uOvTNluE
 f/B6sCAfocsbNrOQvWX6O4JfuL/JGA9MqmUb1xxLHcXMSy6I0NODwDoEnakyuBb3Ul
 FekoHzhy9+yDD2NUOHhLJsmfy/+9OUAN5u/Gzk7xYU9gn8df0xxWyQ+A4+ZoPU7Bs5
 hoIAxnboTo4W0kJVg3anq9h+WE5HxyhGseRuQ7979P6bS+vdFSNG/QduAvVoQ2MftR
 BtCbfTHPGJsi0hzQXNZA1FnylpOF57K4Be+gDaP1OTgkPPQFdMNgE8S3/DTTc/jLS8
 be4M3HbP9uOMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612215205.1887206-1-robh@kernel.org>
References: <20260612215205.1887206-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 21:58:06 +0000
Message-Id: <20260612215806.9A6181F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing bounds check on 'sil,i2s-data-lanes' values leads to out-o=
f-bounds array read.
--

commit 460b61bf52ca50a54beb619610726eb8680ea41a
Author: Rob Herring (Arm) <robh@kernel.org>

drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32

The commit updates the sii902x driver to read the "sil,i2s-data-lanes"
device tree property as a u32 array instead of a u8 array. This change makes
the driver follow the documented DT element size and binding specifications.

> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> index ea543be4ae3e2..7c90194449e1a 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -862,7 +862,7 @@ static int sii902x_audio_codec_init(struct sii902x *s=
ii902x,
>  		.max_i2s_channels =3D 0,
>  		.no_capture_mute =3D 1,
>  	};
> -	u8 lanes[4];
> +	u32 lanes[4];

[Severity: High]
This isn't a bug introduced by this patch, but does changing the type of la=
nes
from u8 to u32 increase the severity of a potential out-of-bounds read?

Later in sii902x_audio_codec_init() around line 894 of
drivers/gpu/drm/bridge/sii902x.c, the values parsed from the device tree are
used directly as indices into the i2s_lane_id array:

	for (i =3D 0; i < num_lanes; i++)
		sii902x->audio.i2s_fifo_sequence[i] |=3D audio_fifo_id[i] |
			i2s_lane_id[lanes[i]] | SII902X_TPI_I2S_FIFO_ENABLE;

Because i2s_lane_id has a fixed size of 4 elements and there is no validati=
on
on the parsed values, a malformed device tree could provide a value larger
than 3. When lanes was an array of u8, the read offset was limited, but as a
u32 it could hit unmapped memory and trigger a kernel oops during device pr=
obe.

Could we add a bounds check to ensure the values are within the correct ran=
ge?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612215205.1887=
206-1-robh@kernel.org?part=3D1
