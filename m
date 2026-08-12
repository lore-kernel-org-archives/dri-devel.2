Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1686BC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2728C10F08B;
	Wed, 12 Aug 2026 15:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W6wQJ04g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D649710F086
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:56:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 05A6760A7D;
 Wed, 12 Aug 2026 15:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A5F1F00A3A;
 Wed, 12 Aug 2026 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786550214;
 bh=kEkdtALvUXvnJ0OpHZVcdGWnjsUMz+o/2ftAnU78Ywo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W6wQJ04g8bXaaeoLkEZ+afzLCnCJU9ce/EDDo1ZiJDM/2ZGkpjO3NfSRTmWd+70gz
 7d0vsIwv0RuDhiYvUyhiu8Q7Fsm7GgdpkdeBhOWQGtqdyzRNdl52pxOM6HgnSL2M2Y
 /5dwZctleCm3HieHZCVWlefdUFjhHncpTKkZRnXqRVA+RlB8Spq7uGSi0S1NeYkXZa
 y8sHVaufX7rniuPJt1slbV7qy4fLKqDkRPiz75fknC3QF/lA0nwBCeD0YiVcKQwbLU
 TP2CbTnQk0+QVX9b5AvPaB4QvEcf2OkxkVA2hO5sD7Jg8p8IbBxOOwm8EAP6Jev7nw
 MhdmdGgXNtP1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: verisilicon: fix cursor offset field update
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812154829.671777-1-zhengxingda@iscas.ac.cn>
References: <20260812154829.671777-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:56:54 +0000
Message-Id: <20260812155654.87A5F1F00A3A@smtp.kernel.org>
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
- [Medium] The patch introduces a visual regression (double offset and shea=
ring) by enabling hardware offsets for partially off-screen cursors without=
 removing the existing offset applied to the DMA address.
--

--- Patch [1]: [PATCH] drm: verisilicon: fix cursor offset field update ---
commit 390079034c32d7765a68a40d73ac95602ccd1720
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm: verisilicon: fix cursor offset field update

This patch corrects the regmap_update_bits arguments for setting the cursor
X/Y offset fields by wrapping them in the appropriate macros, ensuring the
hardware offsets are correctly programmed when the cursor is clipped.

> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/=
drm/verisilicon/vs_cursor_plane.c
> index fa4f601dd0c87..4ce311ae48823 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> @@ -199,7 +199,7 @@ static void vs_cursor_plane_atomic_update(struct drm_=
plane *plane,
>  	} else {
>  		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>  				   VSDC_CURSOR_CONFIG_X_OFF_MASK,
> -				   -state->crtc_x);
> +				   VSDC_CURSOR_CONFIG_X_OFF(-state->crtc_x));

[Severity: Medium]
By enabling the hardware offsets here, does this apply the offset twice sin=
ce
the DMA address is already being shifted for clipped coordinates?

Earlier in vs_cursor_plane_atomic_update(), the DMA address is calculated
using the clipped state->src coordinates:

	dma_addr =3D vs_fb_get_dma_addr(fb, &state->src);

Looking at vs_fb_get_dma_addr(), it adjusts the base DMA address linearly:

	/* Fixup framebuffer address for src coordinates */
	dma_addr +=3D drm_format_info_min_pitch(fb->format, 0,
					      src_rect->x1 >> 16);

Because the hardware offset is now functional with this patch, keeping the
existing DMA shift causes the cursor image to be offset by twice the intend=
ed
amount. Furthermore, linearly shifting a 2D hardware cursor DMA address typ=
ically
causes row shearing.

Does applying this patch independently from the framebuffer address fix
mentioned in the commit message introduce an active visual regression for
partially off-screen cursors?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812154829.6717=
77-1-zhengxingda@iscas.ac.cn?part=3D1
