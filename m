Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEA606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBEji5Ek
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05BD10E0C7;
	Tue, 10 Nov 2026 19:49:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC4D10E0C7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 19:49:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D5906015B;
 Tue, 10 Nov 2026 19:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AEA1F0089F;
 Tue, 10 Nov 2026 19:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794340151;
 bh=XgFkiaalUYGH25eD9eEfRJdOi43ZuGo2ADVP/IUyemI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dBEji5EktwQXVijgfeTc7chJnh47UX9U47ngoQUfa0S++uE6pUw4ke9IWrvhmIExF
 9EJrhpuzZiOh3U0m+CuyfkYp1WpQUjric1RqgR1sm6xyOa87DeOVHtmrS7l2jjMPaL
 WZ0OFzCgpu4EMETLyexjd4SHqjvSD3ZF8790dc13SToZ1QjoF1Zi+x2g0NSUHbmAUs
 jNq+eUynrGX+0gr680gi2O3B76Yfi0/pWI+WG4fMX38fMz8aLHMnxi2pOx4EHDrqiq
 gIK7bQdsVjkqT+6wuntnzhiOyVCI4Iri/46WfOMSDe6znhFvf81Dnj3s6CyMaq1EK5
 SReH+HoRbRGHg==
Message-ID: <sashiko-outbox-207683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] backlight: add ktd3137 support
To: "Roman Vivchar" <rva333@protonmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <20261110-6768-ktd3137-v2-2-9496c51efea4@protonmail.com>
References: <20261110-6768-ktd3137-v2-0-9496c51efea4@protonmail.com>
 <20261110-6768-ktd3137-v2-2-9496c51efea4@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 19:49:10 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] backlight: ktd3137: use named initializer in ktd3137_ids
--

commit 8835810206d0f5ccda9a816dd64ce8c1128ef9b3
Author: Roman Vivchar <rva333@protonmail.com>

backlight: add ktd3137 support

This commit adds an I2C backlight driver for the Kinetic KTD3137 display
backlight IC.

> diff --git a/drivers/video/backlight/ktd3137.c b/drivers/video/backlight/=
ktd3137.c
> new file mode 100644
> index 0000000000000..1595aefd46e6c
> --- /dev/null
> +++ b/drivers/video/backlight/ktd3137.c
> @@ -0,0 +1,258 @@

[ ... ]

> +static const struct i2c_device_id ktd3137_ids[] =3D {
> +	{ "ktd3137" },
> +	{ }
> +};

[Severity: Low]
This isn't a bug, but new struct i2c_device_id entries should use named
initializers ({ .name =3D "ktd3137" }).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-6768-ktd31=
37-v2-0-9496c51efea4@protonmail.com?part=3D2
