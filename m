Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3F606D804
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsvayB5g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEF710E68A;
	Mon,  2 Nov 2026 20:18:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A572E10E68A
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 20:18:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D46D600D1;
 Mon,  2 Nov 2026 20:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026831F00A16;
 Mon,  2 Nov 2026 20:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793650714;
 bh=foci4f70UydJSwMd14VzyKAURSSHbyEmiOSHIFxoTXQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UsvayB5gFXO2p0INdlx7X0jjh3ZRWiz5tN0A/Ep53mbNjkeJfwiChFxHTLe7TeHgu
 NJidCFGoGHbEujPtP5SLNEUE9FC3+8QuuHk7O5uYG0sNJfmiakQKYoZ+l7x75x5/jU
 OubnnSwGeVs36SwvcTvEK6ovPBhoL+2iDCSkOd6baunSwWLOF5TgrIrdbSFRxrt2cT
 rXC7sYs3OA3gXdJ0ji0yxFybSfLO6HSjrEkFLYCRHOxTdWnbYrtQo3kWJatC/dPmqY
 AFkPeMP1LFrTTAktCWxwzn+td/wSEVkNjupIqoSW2hW76QDHWvOHooCnEkmJKxJLNJ
 cyAWEaoJ1q8SA==
Message-ID: <sashiko-outbox-194088@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] backlight: add ktd3137 support
To: "Roman Vivchar" <rva333@protonmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <20261102-6768-ktd3137-v1-2-b5b4f903c56e@protonmail.com>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-2-b5b4f903c56e@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:18:33 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] backlight: ktd3137: use named initializer in ktd3137_ids
--

commit d3260d17f4919396b8ff6c1268dffef7e26e01cf
Author: Roman Vivchar <rva333@protonmail.com>

backlight: add ktd3137 support

This commit adds a backlight driver for the Kinetic KTD3137 display
backlight IC.

> diff --git a/drivers/video/backlight/ktd3137.c b/drivers/video/backlight/=
ktd3137.c
> new file mode 100644
> index 0000000000000..a3ff334b8d460
> --- /dev/null
> +++ b/drivers/video/backlight/ktd3137.c
> @@ -0,0 +1,262 @@

[ ... ]

> +static const struct i2c_device_id ktd3137_ids[] =3D {
> +	{ "ktd3137" },
> +	{ }
> +};

[Severity: Low]
This isn't a bug, but in drivers/video/backlight/ktd3137.c, could the
struct i2c_device_id entry in ktd3137_ids[] use a named initializer
({ .name =3D "ktd3137" }) instead of a positional initializer to match I2C
subsystem conventions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-6768-ktd31=
37-v1-0-b5b4f903c56e@protonmail.com?part=3D2
