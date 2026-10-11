Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F39CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 14:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7822110E235;
	Sun, 11 Oct 2026 14:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A5n+eCIi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B1610E235
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 14:05:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9898F600E2
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 14:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505471F008A1
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791727511;
 bh=/ZP9mYgIUz9YMc+23KxEk5KZByJyBE7m+dN+yOiaTi4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=A5n+eCIi69zoQuXvSnhBIZ9aC63O+JFKGaUTOdc+TTU5juSfBG5RSKT3c4rQ2Ri+Y
 gZfaAq0vuypFVJCSSgzGDEw/h9hQULGq0GEssJu8Qs4ap4aj5SxdSY1hDDm0MXlWr7
 5bL0lt43aSVerpBE8RqSZ5cyqTVEoHgp7XXIxxUhopFy+EHeCMRgGaMSjmVRgM903R
 7sdPHS5OncIz5DE7tMXr/bV/S3o04NTbLr7qhSOp4ylztl9196oQ7R1keXoftB7jXU
 1FyvXwZl3QTM9PUZ2PvU7eg/YJj9M0u2Y31dpIBGG4CV3venPal8goYCdHqckZAosZ
 nxlXtuF348bZw==
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6afb0d2a586so1991807a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 07:05:11 -0700 (PDT)
X-Gm-Message-State: AFq9FYLfubklgAPEO6pEAP4uyiDuO4yTLto9eae4Z4ddB6g2+HVaBqo8
 K58j24iGfVfHrAZlxEVVu/3z5uhcQ6Xjcl26hgUPZSYgCtsGTD+I+s+4Q+cArqiCBmTU5M5v7Rq
 wbOV0cusJWVVxs1+9OaEHVEm7A2r1eqw=
X-Received: by 2002:a05:6402:c518:10b0:6aa:1112:62f2 with SMTP id
 4fb4d7f45d1cf-6b17c2759c5mr4536370a12.15.1791727509987; Sun, 11 Oct 2026
 07:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
In-Reply-To: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 11 Oct 2026 22:05:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4w6SN7GU-sYQerr7rkdD9vesJ=h24jEQHDxczeB0YU1A@mail.gmail.com>
X-Gm-Features: AclHuK_wkl41GPKJI7ip6m3noq5nnGLcBVVPh9hjqmLS-fvueKzuBAPhXPgohI4
Message-ID: <CAAhV-H4w6SN7GU-sYQerr7rkdD9vesJ=h24jEQHDxczeB0YU1A@mail.gmail.com>
Subject: Re: [PATCH] drm/loongson: Fix framebuffer selection in async cursor
 updates
To: Evanshenf <archwse@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Jianmin Lv <lvjianmin@loongson.cn>, 
 Qianhai Wu <wuqianhai@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Sui Jingfeng <suijingfeng@loongson.cn>,
 kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, Oct 3, 2026 at 5:00=E2=80=AFPM Evanshenf <archwse@gmail.com> wrote:
>
> An asynchronous cursor update swaps the new framebuffer into the live
> plane state. However, the driver reads both old_fb and new_fb from the
> live state before this swap. When an enabled cursor changes buffers, the
> address-update condition is therefore false and the hardware continues
> scanning the previous buffer.
>
> Read new_fb from the new plane state before swapping the framebuffer
> references. This updates the hardware address when the framebuffer
> changes while retaining the existing behavior for cursor movement.
>
> Verified on a Loongson 3A5000 with LS7A2000 using 32x32 and 64x64 legacy
> cursor updates. Callback counters and read-only register observations
> confirmed the asynchronous path, the stale address before the change,
> and the new address afterward. Same-framebuffer movement and cursor
> disable/re-enable also passed, with the primary framebuffer and mode
> unchanged.
>
> AI assistance was used to investigate the existing report, prepare the
> fix and test tools, run the build and hardware comparison, and draft
> this message.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202311152357.4KFS0M8f-lkp@intel.com/
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller=
")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

> Signed-off-by: Evanshenf <archwse@gmail.com>
> ---
>  drivers/gpu/drm/loongson/lsdc_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loon=
gson/lsdc_plane.c
> index bcc0ffa..7b9c65c 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> @@ -230,7 +230,7 @@ static void lsdc_cursor_plane_atomic_async_update(str=
uct drm_plane *plane,
>
>         new_state =3D drm_atomic_get_new_plane_state(state, plane);
>
> -       new_fb =3D plane->state->fb;
> +       new_fb =3D new_state->fb;
>
>         plane->state->crtc_x =3D new_state->crtc_x;
>         plane->state->crtc_y =3D new_state->crtc_y;
>
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
> --
> 2.43.0
>
