Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24197C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD4F10F3A1;
	Thu,  3 Sep 2026 06:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YwEtRm8h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB7F10F3AD
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:17:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43B18600C8;
 Thu,  3 Sep 2026 06:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE731F000E9;
 Thu,  3 Sep 2026 06:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788416229;
 bh=Jcy8U/4PDKtN5GY+lhVnHWrKMdnDmw/uF9+XpnRoH8U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YwEtRm8hDvjLnIZQqG9Uh083EnSTdoSPbaAHswnLFLmtFcAhvWMWiJ5blIfxCZ2IS
 g2wgkF9ZcFkTrq4YJA+3dzzu5DX0XQ27lNfUZMGZ8M9RHekSBC2/+cNTbPRxVBgRlQ
 p2nZmOOwsmwK+UoRlnXK4g+D2tSNmrF/L6y1TmCVUt66nrUOeYU5+HP4ejGZlDf7bU
 JL3FQ5qt3aCg7Tez2BvyOxk535sG2mi3RXTxxWJeMpfwuOGVVGQQqq57WLhiCSoI4N
 vRfjD5SRyTB9u0JHXyOaCMqLLoTJ04UNsJgw5VD6eqTJdF0tr6A1mDHlSNP0aPwsg1
 kpUcd4yVF9tHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/sysfb: Use drm_format_info_min_pitch() to
 calculate line clear length
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903060651.3724163-2-wenst@chromium.org>
References: <20260903060651.3724163-1-wenst@chromium.org>
 <20260903060651.3724163-2-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 06:17:08 +0000
Message-Id: <20260903061708.CEE731F000E9@smtp.kernel.org>
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
- [Medium] Incomplete implementation of block format support, contradicting=
 the commit message's claim of making the logic "future proof with respect =
to format block size additions".
--

commit 530a334e99c89cda78ed6306c7a7d6188cc1bf65
Author: Chen-Yu Tsai <wenst@chromium.org>

drm/sysfb: Use drm_format_info_min_pitch() to calculate line clear length

This commit updates drm_sysfb_plane_helper_atomic_disable() to use
drm_format_info_min_pitch() instead of format->cpp[] to calculate the
length of each line in the buffer to clear. This change is intended to
transparently handle the migration to format->chars_per_block[] and be
future-proof for format block size additions.

> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/=
sysfb/drm_sysfb_modeset.c
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> @@ -396,7 +396,7 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm=
_plane *plane,
>  	offset =3D drm_fb_clip_offset(dst_pitch, dst_format, &dst_clip);
>  	for (i =3D 0; i < lines; ++i)
>  		iosys_map_memset(&sysfb->fb_addr, offset + dst_pitch * i, 0,
> -				 linepixels * dst_format->cpp[0]);
> +				 drm_format_info_min_pitch(dst_format, 0, linepixels));

[Severity: Medium]
The commit message claims this change makes the logic "future proof with
respect to format block size additions", but is this implementation complete
for block formats?

For block formats where block_height > 1, lines represents the number
of pixel rows, but dst_pitch represents bytes per block row. Because the
loop iterates lines times and advances the pointer by dst_pitch each
iteration, wouldn't this advance the memory pointer block_height times
faster than the physical layout?

Additionally, it appears drm_fb_clip_offset() still multiplies by
format->cpp[0] internally, which is 0 for modern block formats,
potentially leading to an incorrect starting offset.

Although sysfb currently only exposes linear formats from firmware (meaning
block formats cannot reach this path today), could this cause an
out-of-bounds memory write and incorrect X-axis offset calculations if block
formats were ever used with sysfb in the future?

> =20
>  	drm_dev_exit(idx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903060651.3724=
163-1-wenst@chromium.org?part=3D2
