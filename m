Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9D7C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 05:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A9310F2CA;
	Thu, 10 Sep 2026 05:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P0pyTFWE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB77E10F2CA
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:51:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D9F7400AB;
 Thu, 10 Sep 2026 05:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032041F000FF;
 Thu, 10 Sep 2026 05:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789019506;
 bh=PfDFIpXgEfBo7zFiXauA8T/wflo+eFiuqxubVxqsxac=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P0pyTFWELyTpE6ZiGvnLVb+cJBZPiA70d+x9kmoIAjbu9kWKcXPR0a+p8c63AJ+Mt
 ISwN7NkiRG4mP/SEEPupZePyFJHtqXhKWIchCPTEigR94zhWDRRhusDEUOKjG68sQj
 HC0zbGRwgEKlZP/XFN/rAYVxaHmkLc4zh8kXEVcx6nKsNUkeO7pOULMpVCQEKIyNLg
 3pZzjnyU0V7zsExCzW5JwNlzShTvpmlr1tsWTGgFq9bmQcV+CB1RCeuFPhJLiJC8LK
 hUbUhZd2dD1q5F3vUAKUjoeP7zGn5x/JjuaxXLtdBGP/EeqA+Y1qzsfG7jtOHOxoA8
 JQ3fCrmlc2dsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/pl111: drop alpha formats the hardware cannot
 scan out
To: "Roshan Kumar" <roshaen09@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910054503.4155812-1-roshaen09@gmail.com>
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <20260910054503.4155812-1-roshaen09@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 05:51:45 +0000
Message-Id: <20260910055146.032041F000FF@smtp.kernel.org>
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
- [High] The patch fails to remove alpha pixel formats from board-specific =
variant tables in `pl111_versatile.c` (such as `pl111_realview_pixel_format=
s` used by `vexpress-a15`). This leaves the original bug unfixed on the exa=
ct platform mentioned in the commit message. Furthermore, it introduces a n=
ew regression: because the alpha case labels were removed from `pl111_displ=
ay_enable()`, selecting one of these still-exposed formats will hit the `de=
fault:` case. This triggers a new `WARN_ONCE` and fails to properly configu=
re the hardware display registers (skipping `cntl` setup).
--

commit 10499c458facc30bed43b7322f9a6352b1c136f7
Author: Roshan Kumar <roshaen09@gmail.com>

drm/pl111: drop alpha formats the hardware cannot scan out

This commit removes alpha pixel formats from the PL110 and PL111 variant
tables to prevent exposing unsupported blend modes to userspace. It also
removes the corresponding format case labels from the display setup code.

Link: https://github.com/google/syzkaller/issues/7805

> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl11=
1/pl111_display.c
> index 5d10bc5fdf1f6..e1b513d36c27c 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> @@ -267,14 +267,12 @@ static void pl111_display_enable(struct drm_simple_=
display_pipe *pipe,
>  		if (priv->variant->st_bitmux_control)
>  			cntl |=3D CNTL_ST_LCDBPP24_PACKED;
>  		break;
> -	case DRM_FORMAT_ABGR8888:
>  	case DRM_FORMAT_XBGR8888:

[Severity: High]
Will removing these case labels cause a regression for boards using the
versatile variants?

It looks like the alpha formats were not removed from the board-specific
tables in drivers/gpu/drm/pl111/pl111_versatile.c (such as the
pl111_realview_pixel_formats table used by vexpress-a15).

Because those formats are still exposed to userspace, if an application
selects an alpha format like DRM_FORMAT_ABGR8888, pl111_display_enable()
will now fall through to the default case:

    default:
        WARN_ONCE(true, "Unknown FB format 0x%08x\n",
                  fb->format->format);
        break;

This seems like it would trigger the newly reachable warning (causing boot
failures on systems like the vexpress-a15 manager if panic_on_warn is
enabled) and fail to properly configure the hardware display registers.
Should the versatile formats be updated to drop the alpha formats as well?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910054503.4155=
812-1-roshaen09@gmail.com?part=3D1
