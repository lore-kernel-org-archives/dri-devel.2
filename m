Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51A2C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163B210E55A;
	Mon, 24 Aug 2026 15:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gkca4mk2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F12710E140
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:39:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 453B140063;
 Mon, 24 Aug 2026 15:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CA71F000E9;
 Mon, 24 Aug 2026 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787585953;
 bh=hnJfvT7+WAD1MgCb4mqwhmfhbwLe1J0ZiLqsu7xC3uM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gkca4mk2wyDbMF13XRnsuBgHVzbAktuMf+PaSK72OQYt4sTCbLbZhzQEyM13Ep5sl
 io5M9E547tnOwvbt6+ZWOrlfAD9FTAhcP2CxTY90AaxlPm9DrkOxsPkrNpYFvyKymU
 6dTw/V/5YMLWWIVtUHbdTnEZbGp1EwJzDQgYoclopiIa951Inw0rz9sgN85WV+Q178
 5Rx1y2LAK3uhmgJVU8twgSWXr5x3VC0a4N7SyWQWmMxVYKNmc+ZGPczo9speyIsG/I
 bcQ3HSiKtMPlIOyhpAc4GpfYABzUhF3bTyuaw1dAJsrs9n3PWPxBw+I9rt2vKKYHYI
 WUqvhVZ4DhvEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel: ethosu: Don't read the U65 rounding mode as a
 storage mode
To: "Tomeu Vizoso" <tomeu.vizoso@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260824152612.751007-1-tomeu@tomeuvizoso.net>
References: <20260824152612.751007-1-tomeu@tomeuvizoso.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:39:12 +0000
Message-Id: <20260824153912.F2CA71F000E9@smtp.kernel.org>
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
- [High] Missing default error case in the feature matrix format switch all=
ows out-of-bounds DMA.
--

--- Patch [1]: [PATCH] accel: ethosu: Don't read the U65 rounding mode as a=
 storage mode ---
commit 1513ddc6b4e0eb1db33e857fa9c9f18ec8c80157
Author: Tomeu Vizoso <tomeu.vizoso@gmail.com>

accel: ethosu: Don't read the U65 rounding mode as a storage mode

This commit modifies the ethosu driver to stop reading bits 15:14 of
the precision field as a storage mode on U65 NPUs. On U65, this field
holds the rounding mode instead, so the storage mode is now forced to 0
for these devices to prevent command stream parsing failures.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index d50fed64d4d93..fa37a190e9fff 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -204,7 +204,7 @@ static u64 feat_matrix_length(struct ethosu_device *e=
dev,
>  			      struct feat_matrix *fm,
>  			      u32 x, u32 y, u32 c, bool ofm)
>  {
> -	u32 element_size, storage =3D fm->precision >> 14;
> +	u32 element_size, storage =3D ethosu_is_u65(edev) ? 0 : fm->precision >=
> 14;

[Severity: High]
This is a pre-existing issue, but by forcing storage to 0 on U65, does this
inadvertently allow uninitialized precision values to bypass storage
validation?

If a command stream omits the NPU_SET_IFM_PRECISION command, fm->precision =
is
initialized to 0xffff. Because storage is now forced to 0, this bypasses the
earlier switch (storage) check which would have rejected it as 3.

Later in feat_matrix_length(), there is a switch for the format:

	switch ((fm->precision >> 6) & 0x3) { // format
	case 0: //nhwc:
		element_size =3D BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);
		addr +=3D x * fm->stride_x + c * element_size;
		break;
	case 1: //nhcwb16:
		element_size =3D BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);

		addr +=3D (c / 16) * fm->stride_c + (16 * x + (c & 0xf)) * element_size;
		break;
	}

Because there is no default error case, formats 2 and 3 fall through without
adding the width and depth (x and c) components to the required length.

Does this result in an under-calculated buffer length that bypasses the
driver's GEM size validation and could allow out-of-bounds DMA accesses?

>  	int tile =3D 0;
>  	u64 addr;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824152612.7510=
07-1-tomeu@tomeuvizoso.net?part=3D1
