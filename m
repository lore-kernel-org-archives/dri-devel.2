Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA57FCD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A17E10E208;
	Mon, 15 Jun 2026 06:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NpLBUruS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61E510E208
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:59:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FB4643D7A;
 Mon, 15 Jun 2026 06:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A25C1F000E9;
 Mon, 15 Jun 2026 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781506771;
 bh=6XzBu3M2scvQsZp9WK4RvPSBsl6EUuLeUaeoh0Te2LE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NpLBUruSWPrSSg4S5u2fRhoCIUHFxb+q/2ecTnkppAa1qGFZVBZslkPCGrmecPsPU
 ZwesQvGDjdqZY4Qkx5CKSPn20/gdHcdhKWHBHYAXA59kVloLiKLtEHIppQNj0Lqs1h
 Hzu/y4jEnrrGJpb13Jm2Y8nV+E37mgFab49mQ29wKNUMf150zfZ8ctF7unFc88PFWj
 wG0trOYG6ATncPsTiFW+8YL+SqNKhAeJfizrgPZna6CpjhUTUbNFHJTkOSEHNb6PQT
 t8ACtEMFk3j4aQ8tYE4E9MML9Dr5iLARO2F4OhscFB4LNpTEXCfS2wXfgF9PftjexA
 s4y/qTdCrQG8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] drm/verisilicon: add DCUltraLite chip identity
 to HWDB
To: "Joey Lu" <a0987203069@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260615065003.76661-6-a0987203069@gmail.com>
References: <20260615065003.76661-6-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:59:30 +0000
Message-Id: <20260615065931.3A25C1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] A wildcard entry in vs_chip_identities shadows specific customer I=
D entries, making them unreachable.
- [High] The function vs_fill_chip_identity() ignores the return values of =
regmap_read() calls, leading to potential use of uninitialized stack memory.
--

commit a6a5d6f3773180ae44a10c5525c46667d81239fe
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: add DCUltraLite chip identity to HWDB
   =20
Register the Nuvoton MA35D1 DCUltraLite chip identity in
vs_chip_identities[]:
  model       =3D 0x0   (DCUltraLite; Verisilicon uses 0 for this IP)
[ ... ]

> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/veri=
silicon/vs_hwdb.c
> index 91524d16f7785..7d630a667a3f0 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
[ ... ]
> @@ -129,6 +129,16 @@ static struct vs_chip_identity vs_chip_identities[] =
=3D {
>  		.max_cursor_size =3D 64,
>  		.formats =3D &vs_formats_no_yuv444,
>  	},
> +	{
> +		.model =3D 0x0,		/* DCUltraLite */
> +		.revision =3D 0x5560,
> +		.customer_id =3D 0x305,
> +
> +		.generation =3D VSDC_GEN_DC8000,
> +		.display_count =3D 1,
> +		.max_cursor_size =3D 32,
> +		.formats =3D &vs_formats_no_yuv444,
> +	},
>  };
> =20
>  int vs_fill_chip_identity(struct regmap *regs,
>  			  struct vs_chip_identity *ident)
>  {
>  	u32 model;
>  	u32 revision;
>  	u32 customer_id;
>  	int i;
> =20
>  	regmap_read(regs, VSDC_TOP_CHIP_MODEL, &model);
>  	regmap_read(regs, VSDC_TOP_CHIP_REV, &revision);
>  	regmap_read(regs, VSDC_TOP_CHIP_CUSTOMER_ID, &customer_id);

[Severity: High]
This isn't a bug introduced by this patch, but does vs_fill_chip_identity()
ignore the return values of these regmap_read() calls?

The regmap_read() API returns an integer error code on failure and leaves
the output pointer's target unmodified.=20

If any of these reads fail due to bus errors or unmapped I/O, will the
function proceed to use uninitialized stack memory in the loop to compare
against the vs_chip_identities array?

> =20
>  	for (i =3D 0; i < ARRAY_SIZE(vs_chip_identities); i++) {
>  		if (vs_chip_identities[i].model =3D=3D model &&
>  		    vs_chip_identities[i].revision =3D=3D revision &&
>  		    (vs_chip_identities[i].customer_id =3D=3D customer_id ||
>  		     vs_chip_identities[i].customer_id =3D=3D ~0U)) {
>  			memcpy(ident, &vs_chip_identities[i], sizeof(*ident));
>  			ident->customer_id =3D customer_id;
>  			return 0;
>  		}

[Severity: High]
This is a pre-existing issue, but does the wildcard entry in
vs_chip_identities[] shadow specific customer ID entries?

Looking at vs_chip_identities[] in drivers/gpu/drm/verisilicon/vs_hwdb.c,
there is a wildcard entry at the beginning of the array:

	{
		.model =3D 0x8200,
		.revision =3D 0x5720,
		.customer_id =3D ~0U,
		...
	}

Since vs_fill_chip_identity() searches sequentially and returns on the first
match, will any hardware with model 0x8200 and revision 0x5720 instantly
match this wildcard entry?

If so, the specific configurations for customer IDs 0x310 and 0x311 defined
later in the array might be completely shadowed and never reached. This wou=
ld
cause customer ID 0x310 to incorrectly use vs_formats_no_yuv444 instead of
its intended vs_formats_with_yuv444.

>  	}
> =20
>  	return -EINVAL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615065003.7666=
1-1-a0987203069@gmail.com?part=3D5
