Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D0606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VprqfZ9C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B457710E558;
	Sun, 25 Oct 2026 04:27:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49BA10E558
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:27:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1BB1600D4;
 Sun, 25 Oct 2026 04:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE631F01825;
 Sun, 25 Oct 2026 04:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792902449;
 bh=20ZLKBnT3bPboGlBNgLE/muRWPscqV5jgHNHq1NqpO0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VprqfZ9CaN8T21RgjWsXyrOO1h6RXLfnh0zLpGfFI0ThFcVvYQLlCywlOtFTtO7in
 tgTgrsMvHvb99+Z64mIOP3N9svdZDZS8azVL/Hp1/CuRWEWohcS4iJ2HgkXfJjGdTB
 Vtczy3HLimoaOtbpKurspp8Er2Bgt7F3Z3KVfggnUIW0t5SX3zhhYqoEOD4YlVIfzE
 Yslrt63ZrXFqpZs6hiC3hkNXHL43uaUTxjyvMVdS+lWCUzyMVMsuazmMrr0CHNyyXm
 WiaU7l24u26q68B3Lb9C/VReclebb0LJDozYiO/UDyc19R06vqCV9cSu1LufwGp70v
 zFiNwdOXdZS2w==
Message-ID: <sashiko-outbox-184063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] platform/apple-gmux: Fix MMIO interface
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:27:29 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] platform/x86: apple-gmux: missing unlock on timeout in gmux_mmio_r=
ead8/32()
- [High] platform/x86: apple-gmux: uninitialized return in gmux_mmio_read8/=
32()
--

commit b2c93280b42eef5a3e3e707b2033f83778f7828f
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/apple-gmux: Fix MMIO interface

This patch updates the apple-gmux MMIO helpers to sleep for 1ms per poll
iteration in gmux_mmio_wait(), check for wait timeouts before performing MM=
IO
reads and writes, and wait before writing in gmux_mmio_write32().

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 4e8786a5e58ec..076ed7ba6af90 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -250,12 +250,14 @@ static u8 gmux_mmio_read8(struct apple_gmux_data *g=
mux_data, int port)
>  	u8 val;
> =20
>  	mutex_lock(&gmux_data->index_lock);
> -	gmux_mmio_wait(gmux_data);
> -	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> -	iowrite8(GMUX_MMIO_READ | sizeof(val),
> -		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> -	gmux_mmio_wait(gmux_data);
> -	val =3D ioread8(gmux_data->iomem_base);
> +	if (gmux_mmio_wait(gmux_data)) {
> +		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> +		iowrite8(GMUX_MMIO_READ | sizeof(val),
> +			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> +		if (!gmux_mmio_wait(gmux_data))
> +			return 0;

[Severity: High]
Does this early return in gmux_mmio_read8() in
drivers/platform/x86/apple-gmux.c leave gmux_data->index_lock locked when t=
he
second gmux_mmio_wait(gmux_data) call times out and returns 0?

The same early return while holding gmux_data->index_lock also appears in
gmux_mmio_read32() below, which will cause subsequent GMIO accesses to
deadlock on mutex_lock(&gmux_data->index_lock).

> +		val =3D ioread8(gmux_data->iomem_base);
> +	}
>  	mutex_unlock(&gmux_data->index_lock);
> =20
>  	return val;
>  }

[ ... ]

> @@ -281,12 +286,16 @@ static u32 gmux_mmio_read32(struct apple_gmux_data =
*gmux_data, int port)
>  	u32 val;
> =20
>  	mutex_lock(&gmux_data->index_lock);
> -	gmux_mmio_wait(gmux_data);
> -	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> -	iowrite8(GMUX_MMIO_READ | sizeof(val),
> -		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> -	gmux_mmio_wait(gmux_data);
> -	val =3D ioread32be(gmux_data->iomem_base);
> +
> +	if (gmux_mmio_wait(gmux_data)) {
> +		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> +		iowrite8(GMUX_MMIO_READ | sizeof(val),
> +			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> +		if (!gmux_mmio_wait(gmux_data))
> +			return 0;
> +
> +		val =3D ioread32be(gmux_data->iomem_base);
> +	}
>  	mutex_unlock(&gmux_data->index_lock);
> =20
>  	return val;
>  }

[Severity: High]
Can gmux_mmio_read32() and gmux_mmio_read8() in
drivers/platform/x86/apple-gmux.c return an uninitialized val if the initial
gmux_mmio_wait(gmux_data) call times out and returns 0?

In both functions, val is declared without an initializer and is only
assigned inside the if (gmux_mmio_wait(gmux_data)) block before being
returned after mutex_unlock(&gmux_data->index_lock). Could val be initializ=
ed
to 0 (and returned after unlocking on both timeout paths)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D3
