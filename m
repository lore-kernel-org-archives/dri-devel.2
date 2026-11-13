Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E88606A333
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQjDmUgu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B7D1126D0;
	Fri, 13 Nov 2026 16:39:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527511126C3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:39:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC5AF62451;
 Fri, 13 Nov 2026 16:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314891F000C4;
 Fri, 13 Nov 2026 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794587968;
 bh=FV4a70Vp3RVtWK1HqXBXBGRqs0Nbda6wDSby3FpOvtU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AQjDmUguGAwbevrUvSPrDEsENVrVWzRCgdUeYiTnHTU5qUI2a/JMJB6ouY2TyCba2
 5O5Cv5QXooukNj1TwMnlml2QZrVWStP+p+GfuuSHlAgRLL6stcx8PxxurpcKGzI95x
 I/MUMcytI0jjtAZi9h1dNRjK+GDeffDb0O6aJYoIUgTRS/bBCeQ6OhaPHl/SwIOKyx
 CGH6SesthYU1H2MTZJYAza8mI2Dhd9Y4r1lRwSYuOmS6Vv2ogRw5FfQDSbwTzHFzjR
 LFDuA6dhQqGAiSWP664MgptsNQE6QwVRSeuBKzupdHXyt2EVhrUgvYso+eaM4fxTIn
 wMPYciKtLW9aQ==
Message-ID: <sashiko-outbox-213215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/10] media: tegra-video: vi: Adjust pad assignment
 logic
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261113161819.36847-7-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-7-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:39:27 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] media: tegra-video: unpopulated pad index in
  __tegra_channel_try_format()
--

commit afb13afd32b21ef80b48671edacb48e14ada5d73
Author: Svyatoslav Ryhel <clamor95@gmail.com>

media: tegra-video: vi: Adjust pad assignment logic

This commit populates the pad field in V4L2 subdevice format, selection, and
enumeration structures using media_get_pad_index() instead of assuming the
source pad is at index 0.

> diff --git a/drivers/media/platform/nvidia/tegra-video/vi.c b/drivers/med=
ia/platform/nvidia/tegra-video/vi.c
> index 139e3ff0faaed..f028780f07bde 100644
> --- a/drivers/media/platform/nvidia/tegra-video/vi.c
> +++ b/drivers/media/platform/nvidia/tegra-video/vi.c

[ ... ]

> @@ -465,7 +471,9 @@ static int __tegra_channel_try_format(struct tegra_vi=
_channel *chan,
>  	}
> =20
>  	pix->field =3D V4L2_FIELD_NONE;
> -	fmt.pad =3D 0;
> +	fmt.pad =3D media_get_pad_index(&subdev->entity, MEDIA_PAD_FL_SOURCE,
> +				      PAD_SIGNAL_DEFAULT);
> +
>  	v4l2_fill_mbus_format(&fmt.format, pix, fmtinfo->code);
> =20
>  	/*

[Severity: Medium]
Should fse.pad, sdsel.pad, and the pad argument to
v4l2_subdev_state_get_crop() also be set to the source pad index in
__tegra_channel_try_format()?

Right after this hunk, __tegra_channel_try_format() still targets pad 0 for
those operations:

drivers/media/platform/nvidia/tegra-video/vi.c:__tegra_channel_try_format()=
 {
    ...
	try_crop =3D v4l2_subdev_state_get_crop(sd_state, 0);
	fse.code =3D fmtinfo->code;
	ret =3D v4l2_subdev_call(subdev, pad, enum_frame_size, sd_state, &fse);
	if (ret) {
		if (!v4l2_subdev_has_op(subdev, pad, get_selection) ||
		    v4l2_subdev_call(subdev, pad, get_selection, NULL, NULL, &sdsel)) {
    ...
}

When the remote subdevice's source pad is not at index 0, enum_frame_size
and get_selection query pad 0 with a source-pad media bus code, and try_crop
updates pad 0's crop rectangle in sd_state instead of fmt.pad's before
set_fmt runs on fmt.pad.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113161819.3684=
7-1-clamor95@gmail.com?part=3D6
