Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E0DCCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C745910EBA0;
	Mon, 19 Oct 2026 14:23:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8398910EBA0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:22:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2635443FF8
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27B21F000C4;
 Mon, 19 Oct 2026 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792419779;
 bh=TatvYSy9mdRJiLGEryefucKwQtT1z4Ql/V8/EOisQHk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SLe4rGAwnnv0YzmJfW0FCHtpg597SN1zjt4+aEOuS9kQo/2v34P9cZphUCbJhCzjJ
 nXVU9YgRXotIwf/MXKjZugR6rRmJnGC/G+febLmUewOEb4Oanr8Pc7yt7lmcCksG6j
 gvQMAGh88QpI8c3lKZt3yyyj1ZyCnByT/F2LaKmNAs5r1ypVRgqpOZLv2CH5XXzESm
 /OUdtMwbi63wf1glTy4gvCbCGU1TgIAFC6BXH0hnaKxQCaq/bGYLO6Gsnn2nXegqIL
 iwAgqJVLA22YQF6EhgOHmXzBjtBrnA2vGohOY77IKIMHp7jBkZpxhuJGQq1tEvASRH
 gP/rgObgUrPng==
Message-ID: <sashiko-outbox-177366@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/amdgpu: Validate ATIF buffer
 length before use
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-55-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-55-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:22:58 +0000
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
- [High] drm/amdgpu: unvalidated number_of_points in amdgpu_atif_query_back=
light_caps()
--

commit a73a09a7b2fb3e5ffd26ffc3c59fb52e0414b2a7
Author: Lijo Lazar <lijo.lazar@amd.com>

drm/amdgpu: Validate ATIF buffer length before use

This commit adds a min_size parameter to amdgpu_atif_call() to validate that
the returned ACPI buffer is of type ACPI_TYPE_BUFFER, holds at least a u16
size field, does not claim more data than was actually returned, and meets
the minimum size required by each calling function.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 6c62e27b98002..5be40c781807a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
[ ... ]
> @@ -371,20 +383,14 @@ static int amdgpu_atif_query_backlight_caps(struct =
amdgpu_atif *atif)
> =20
>  	info =3D amdgpu_atif_call(atif,
>  		ATIF_FUNCTION_QUERY_BRIGHTNESS_TRANSFER_CHARACTERISTICS,
> -		&params);
> +		&params, offsetof(struct atif_qbtc_output, data_points));
>  	if (!info) {
>  		err =3D -EIO;
>  		goto out;
>  	}
> =20
> -	size =3D *(u16 *) info->buffer.pointer;
> -	if (size < 10) {
> -		err =3D -EINVAL;
> -		goto out;
> -	}
> -
>  	memset(&characteristics, 0, sizeof(characteristics));
> -	size =3D min(sizeof(characteristics), size);
> +	size =3D min(sizeof(characteristics), (size_t)*(u16 *)info->buffer.poin=
ter);
>  	memcpy(&characteristics, info->buffer.pointer, size);
> =20
>  	atif->backlight_caps.caps_valid =3D true;

[Severity: High]
Should amdgpu_atif_query_backlight_caps() also validate
characteristics.number_of_points against ATIF_QBTC_MAX_DATA_POINTS and the
returned buffer size?

Right after this hunk in drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c,
amdgpu_atif_query_backlight_caps() stores characteristics.number_of_points =
(a
u8) directly into atif->backlight_caps.data_points:

	atif->backlight_caps.data_points =3D characteristics.number_of_points;
	memcpy(atif->backlight_caps.luminance_data,
	       characteristics.data_points,
	       sizeof(atif->backlight_caps.luminance_data));

Because amdgpu_atif_call() only validates that the buffer is at least
offsetof(struct atif_qbtc_output, data_points) bytes, a malformed ATIF
response can report characteristics.number_of_points greater than
ATIF_QBTC_MAX_DATA_POINTS (99), or report more data points than are actually
present in the returned buffer size.

When backlight brightness is later updated via:

  amdgpu_dm_backlight_update_status() ->
    amdgpu_dm_backlight_set_level() ->
      convert_brightness_from_user() ->
        convert_custom_brightness()

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:convert_custom_brightness=
()
uses caps->data_points to index caps->luminance_data[MAX_LUMINANCE_DATA_POI=
NTS]
without clamping:

	left =3D 0;
	right =3D caps->data_points - 1;
	while (left <=3D right) {
		int mid =3D left + (right - left) / 2;
		u8 signal =3D caps->luminance_data[mid].input_signal;

Could this read out of bounds of caps->luminance_data[] when
characteristics.number_of_points exceeds ATIF_QBTC_MAX_DATA_POINTS, or read
zero-padded entries if size is smaller than
offsetof(struct atif_qbtc_output, data_points) +
characteristics.number_of_points * sizeof(struct atif_qbtc_data_point)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-55-sashal@kernel.org?part=3D1
