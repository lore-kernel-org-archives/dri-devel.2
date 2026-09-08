Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686FEC79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6C910EAEB;
	Tue,  8 Sep 2026 10:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XGoLGhYj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F75C10EAEB
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 10:15:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 300FA402F9;
 Tue,  8 Sep 2026 10:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C021F00A3D;
 Tue,  8 Sep 2026 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788862509;
 bh=andQw+ebjgmfPYJID6s08wjhK0YCGL9Mdxmg0Pc61Qs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XGoLGhYjjvGi7roh7OkDuqiebVuR8PxkMZJ+OHGNnrUlkjBxDhrwGLQXnzi7lOjIH
 O5BB17Hz7aXiH+Ycvr9pM38XTJkUatXJbvDuPfBN2S5riruNvzEoxl5Up6VcBPmeWc
 oNtzjYO2JjoUJcNUm3Hl9vqHgz6Q8Vo6GOQriTRqKR1IiWkYQQ+U+23kTVWb9yKBnV
 rWuaXvSoQ9lXG8D0a5GUVt2Rc04aN0nOLHCD0RwT62zlA+qtBd0yC1VBpG/lN2yo7D
 dnMSXYk7oia+Xt+2tGzQuJtxu/r00Y8pZckH0GYj4pIi/xkkEOu2lAgmApaziqIspk
 J5Apw3SdhLMsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] drm/verisilicon: add DCUltraLite chip identity
 to HWDB
To: "Joey Lu" <a0987203069@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260908092840.225220-6-a0987203069@gmail.com>
References: <20260908092840.225220-1-a0987203069@gmail.com>
 <20260908092840.225220-6-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:15:08 +0000
Message-Id: <20260908101508.B9C021F00A3D@smtp.kernel.org>
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
- [High] Negative cursor coordinates are programmed incorrectly because the=
 offset values are not shifted before being passed to regmap_update_bits().
--

commit 71dc0bfa33a2021c1ba93da0095ed32939fb4009
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: add DCUltraLite chip identity to HWDB
   =20
The Nuvoton MA35D1 chip contains a DCUltraLite display controller with
model number 0x0 (sic, the model name contains no number either),
revision 0x5560 and customer ID 0x305.  It has a similar register map
with DC8000, only one display output and only 32x32 cursor supported.

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

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the cursor
handling code related to this new controller, I noticed an issue with how
negative cursor coordinates are programmed.

Looking at vs_cursor_plane_atomic_update() in
drivers/gpu/drm/verisilicon/vs_cursor_plane.c, when handling negative
X coordinates:

	} else {
		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
				   VSDC_CURSOR_CONFIG_X_OFF_MASK,
				   -state->crtc_x);
		regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output),
				   VSDC_CURSOR_LOCATION_X_MASK, 0);
	}

Is the unshifted X offset (-state->crtc_x) completely masked out to 0 by
regmap_update_bits() because it lacks the necessary shift macro (like
VSDC_CURSOR_CONFIG_X_OFF)?

Similarly, for the Y coordinate:

	} else {
		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
				   VSDC_CURSOR_CONFIG_Y_OFF_MASK,
				   -state->crtc_y);
		regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output),
				   VSDC_CURSOR_LOCATION_Y_MASK, 0);
	}

Does this also cause the unshifted Y offset (-state->crtc_y) to be
masked out to 0?

When the cursor is moved off the left or top edge of the screen, the hardwa=
re
offset is intended to clip the cursor.

However, if the unshifted offset value is masked out by regmap_update_bits(=
),
it results in an offset of 0.

This would cause the cursor to stick at the edge of the screen fully visibl=
e,
rather than sliding smoothly off-screen.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908092840.2252=
20-1-a0987203069@gmail.com?part=3D5
