Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BE8C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A77F10E2C2;
	Thu, 10 Sep 2026 19:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pptpq7MK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5784010E2C2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 19:34:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6641160213;
 Thu, 10 Sep 2026 19:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52D11F000FF;
 Thu, 10 Sep 2026 19:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789068844;
 bh=F2nV1w1XPKE3njUNpMm129Z8cwPbsxxIm8IPNG80VA0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pptpq7MKyxP5qxrONQDaDOhdJND7qaf1r5r+kO0eq4E5Syq4mpoxBtZYOUym1W8ty
 QRMQiu/+ZdBVEO8kmOPhWg9ifJE6NFCZe5ORC370Mlhig0IS32aVyePPE6Flk6NgN5
 yxdL4jZOk1U3+AuaViKpAx+BplZuYt6y3dRbkS95uCZI7ZBV6diSecO2gax3O+RPSl
 vZSpAhS7DUiFtOjZGFpNb9UsG1iEv+3u7bnHw3v7mUAfqDjgjtljyu5Wn9ADUiWlWi
 rGUNmQnuj9n8aIN9gypd/PQqHUc79xTv07hpbLLgRLPvbuszofno/bNazY52fJvA4T
 j28B4Cg3hLD3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/pl111: drop alpha formats the hardware cannot
 scan out
To: "Roshan Kumar" <roshaen09@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910192526.137057-1-roshaen09@gmail.com>
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <20260910192526.137057-1-roshaen09@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:34:03 +0000
Message-Id: <20260910193403.E52D11F000FF@smtp.kernel.org>
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
- [High] Sleeping function msleep() is called from CRTC atomic enable/disab=
le callbacks, which execute in atomic context.
--

commit a2121d13cc86548614d1273c2a018211978e598e
Author: Roshan Kumar <roshaen09@gmail.com>

drm/pl111: drop alpha formats the hardware cannot scan out

The PL110/PL111 controller does not support alpha blending, so exposing alp=
ha
formats causes issues when pixel blend mode properties are expected. This
patch drops alpha formats from all variant tables and format checking
switches so that alpha-picking clients fall back to XRGB/XBGR/RGB formats
instead.

Link: https://github.com/google/syzkaller/issues/7805

> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl11=
1/pl111_display.c
> index 5d10bc5fdf1f6..e1b513d36c27c 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
[ ... ]
> @@ -311,13 +307,11 @@ static void pl111_display_enable(struct drm_simple_=
display_pipe *pipe,
>  		else
>  			cntl |=3D CNTL_BGR;
>  		break;
> -	case DRM_FORMAT_ABGR4444:
>  	case DRM_FORMAT_XBGR4444:
>  		cntl |=3D CNTL_LCDBPP16_444;
>  		if (priv->variant->st_bitmux_control)
>  			cntl |=3D CNTL_ST_1XBPP_444 | CNTL_BGR;
>  		break;
> -	case DRM_FORMAT_ARGB4444:
>  	case DRM_FORMAT_XRGB4444:
>  		cntl |=3D CNTL_LCDBPP16_444;
>  		if (priv->variant->st_bitmux_control)

[Severity: High]
This is a pre-existing issue, but I noticed that msleep() is called
further down in pl111_display_enable():

	/*
	 * We expect this delay to stabilize the contrast
	 * voltage Vee as stipulated by the manual
	 */
	msleep(20);

There is also a similar msleep(20) call in pl111_display_disable()
in the same file (drivers/gpu/drm/pl111/pl111_display.c).

Since pl111_display_enable() and pl111_display_disable() serve as the
CRTC atomic enable and disable callbacks, they execute in atomic context
where sleeping is forbidden.

Can calling msleep() in these paths cause kernel warnings, system
instability, or potential deadlocks during modeset operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910192526.1370=
57-1-roshaen09@gmail.com?part=3D1
