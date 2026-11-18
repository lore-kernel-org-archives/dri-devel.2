Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680D60A260F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqDmzYvL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3089010FD09;
	Wed, 18 Nov 2026 14:10:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F048C10FD09
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:10:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 596146221A;
 Wed, 18 Nov 2026 14:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64161F000C6;
 Wed, 18 Nov 2026 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795011033;
 bh=28xTWR+N19apmWv9g+61s6vTnXlPriSlsitFE6VpunU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lqDmzYvLhfZe/gHe5R+4k0MgMgJnj3TXIwFvHi5lf+tVbhdSVZ/hvjLR9C4udSI1h
 t/d1x9vuN8CJxuC1H4JKN5t1rP55g+iqZJDasCwC5TmVNRthlCbbiiRDttBrWatPih
 N5mMglcadBjKaGg4hBf4T4IXvrQRkJ8Znb/yEye7kR261urFHJ4E0dZ5c1aQeHoEAs
 bib8bWgfsf29RfmuUw4TVGnoPap+NLJUGUwgfaXYNAWG9NtTmXCY9cvt0ZCr6YId4H
 hlAnNV/0SsDLOe5mft9yGBdKte5wFkELhKn4YJ867TckFy383+rHnVjTvJqQlixvyw
 JM4i1AbLrNgYA==
Message-ID: <sashiko-outbox-221161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] drm/ch1115: add support for Chipwealth CH1115
 OLED controller
To: =?utf-8?b?Tmljb2zDoXMgQW50aW5vcmk=?= <nico.antinori.7@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <39277a7a51b0bc59e0aa6ec570e86076b6b64b4e.1795008752.git.nico.antinori.7@gmail.com>
References: <cover.1795008752.git.nico.antinori.7@gmail.com>
 <39277a7a51b0bc59e0aa6ec570e86076b6b64b4e.1795008752.git.nico.antinori.7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:10:32 +0000
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
- [Medium] drm/ch1115: out-of-range display offset 64 sent in
  ch1115_oled_init()
--

commit 267a026ef99b05c8104e1fd889562214c3da0086
Author: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

drm/ch1115: add support for Chipwealth CH1115 OLED controller

This commit adds a DRM driver for Chipwealth CH1115 monochrome dot matrix
OLED panels connected over I2C, along with its Kconfig, Makefile, and
MAINTAINERS entries.

> diff --git a/drivers/gpu/drm/tiny/ch1115-i2c.c b/drivers/gpu/drm/tiny/ch1=
115-i2c.c
> new file mode 100644
> index 0000000000000..22d99da3e5019
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/ch1115-i2c.c

[ ... ]

> +static int ch1115_oled_init(struct ch1115_device *ch1115)
> +{
> +	u8 commands[] =3D {
> +		CH1115_CMD_OFF,
> +
> +		CH1115_CMD_CLOCK_DIVIDE_RATIO,
> +		CH1115_VAL_CLOCK_DIVIDE_RATIO(CH1115_VAL_CLOCK_OSC_FREQ,
> +					      CH1115_VAL_CLOCK_DIV_RATIO),
> +
> +		CH1115_CMD_MUX_RATIO,
> +		ch1115->height - 1,
> +
> +		CH1115_CMD_OFFSET,
> +		ch1115->flip_vertical
> +			? ch1115->y_start_offset
> +			: CH1115_MAX_HEIGHT - ch1115->y_start_offset,

[Severity: Medium]
Does CH1115_CMD_OFFSET send an out-of-range value of 64 (0x40) when
flip_vertical is false and y_start_offset is 0?

ch1115_parse_dt() defaults y_start_offset to 0 when "chipwealth,offset" is
omitted and restricts explicit values to [0, CH1115_MAX_HEIGHT - 1] (0 to
63) to fit the controller's 6-bit vertical offset field.  With the default
offset of 0 and flip_vertical disabled, CH1115_MAX_HEIGHT -
ch1115->y_start_offset evaluates to 64 instead of wrapping modulo
CH1115_MAX_HEIGHT to 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795008752.gi=
t.nico.antinori.7@gmail.com?part=3D2
