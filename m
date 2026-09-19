Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B74AC982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 22:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5396710E236;
	Sat, 19 Sep 2026 22:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="emwQqmvJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF4710E236
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:48:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 096976025A;
 Sat, 19 Sep 2026 22:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A7F1F000FF;
 Sat, 19 Sep 2026 22:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789858133;
 bh=r4wiKhi6y/+ObXMDHmgsDH97P7N7TEg7eK1F7Z2+Z5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=emwQqmvJDB96gj+0qAHUYBm3Mp7xxyR6EAlhZGWYkCz5UUR53668Jt8JT+zLV1Uj3
 RZiumOMYa61bG6/BWpZDs97vXaBRUaCMJcXzmVYq0VECBFPQOgX/Y8b5yp7Y7B86Wt
 3xkaLYpcfBpGm/oYvGuQZlgL2+msF+y2pdL+N0qDGuUJkTsNUJx1rUrpTCLyPlyVfI
 cvfLVoiLZJ0QfGqSxNlTf6b2JPtHMINWFYKNT3lyUObI4sa3UkB75Gmt1JUsOKo5Hc
 eeVTtsFye39tzstT87FPKLbTi1E0qWz0G7YHpU4ZHHoHw+m7LDcL72IjVAgdNs4aeu
 F2i2F8mre2ngQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sitronix: st7571: fix hwbuf heap buffer overflow
 from unaligned nlines
To: "Hui Peng" <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260919222631.3798442-1-benquike@gmail.com>
References: <20260919222631.3798442-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:48:53 +0000
Message-Id: <20260919224853.92A7F1F000FF@smtp.kernel.org>
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
- [Medium] drm/sitronix: commit message and patch implementation completely=
 mismatched
--

commit 46fb9fd81496f4b52e8d10740054c55dda3862dc
Author: Hui Peng <benquike@gmail.com>

drm/sitronix: st7571: fix hwbuf heap buffer overflow from unaligned nlines

The commit attempts to fix a heap buffer overflow in the sitronix st7571 dr=
iver
by ensuring the allocated buffer size is aligned.

> In st7571_fb_blit_rect() (drivers/gpu/drm/sitronix/st7571.c), align y1
> down and y2 up to multiples of 8 rows before computing nlines so the
> byte count written into st7571->hwbuf matches the allocated page-aligned
> buffer capacity and cannot overflow st7571->hwbuf.

[Severity: Medium]
Does the commit message describe the actual changes made in this patch?

The message claims to fix an issue in st7571_fb_blit_rect() by modifying how
coordinates y1 and y2 are aligned. However, the patch does not modify this
function, but instead rounds up an allocation size in st7571_probe().

> diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix=
/st7571.c
> index fc3ba5e8600f6..40017ee5a1f6e 100644
> --- a/drivers/gpu/drm/sitronix/st7571.c
> +++ b/drivers/gpu/drm/sitronix/st7571.c
> @@ -827,7 +827,8 @@ struct st7571_device *st7571_probe(struct device *dev,
>  	st7571->regmap =3D regmap;
> =20
>  	st7571->hwbuf =3D devm_kzalloc(st7571->dev,
> -				     (st7571->nlines * st7571->ncols * st7571->bpp) / 8,
> +				     (round_up(st7571->nlines, 8) *
> +				      st7571->ncols * st7571->bpp) / 8,
>  				     GFP_KERNEL);

Could the commit message be updated to match the implementation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919222631.3798=
442-1-benquike@gmail.com?part=3D1
