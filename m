Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5629C5DF84
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C6410EB61;
	Tue, 18 Aug 2026 13:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y+P5Ru/t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6922D10EB5E;
 Tue, 18 Aug 2026 13:03:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79F4A601E0;
 Tue, 18 Aug 2026 13:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CC51F000E9;
 Tue, 18 Aug 2026 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787058230;
 bh=BT6TUKSfzL9GnZa97feyroupicTpFudSzUIqpKfpnFo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y+P5Ru/tYOkCTyu07ibkl2psgdrxYVZXOja3N941iO+kauUOcS4wJq4HmKQovC/vr
 MdZz9dreZHynCmHwtEbcyoczemQ3VzNThQOr4vPmOuC+158LQ4BdPuHNDy2vTAMydu
 z6ekco8F1HUNV0cLdBjkSgOcHVc/aauSmS809ykdxG+pZnJVcel7Hcvl68niJAqoBA
 zPF3w/+HIo7Q/w4vHaoPvZLbA5DL2FM2hnREvRVbO/hNOcty+cBFg0K5qCK8/jMDeQ
 XaYr8yl6kKoV6z906qg04ZK1mhagLPLiGfHYsUVHXnBRPEkwdxiaQPKXn7mo8yWuqe
 jb0kVEKrSlPkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] drm/panic: Return errno codes if panic output fails
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260818125012.468092-5-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:03:49 +0000
Message-Id: <20260818130349.B3CC51F000E9@smtp.kernel.org>
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
- [Medium] draw_panic_screen_qr_code() ignores the return value of its fall=
back function draw_panic_screen_user() and unconditionally returns 0.
--

--- Patch [4]: [PATCH 04/12] drm/panic: Return errno codes if panic output =
fails ---
commit 8764682ca919f839ac40d09290f5a67bb03da8dc
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Return errno codes if panic output fails

This commit updates the panic output helpers to return errno codes on
failure. This allows the driver to avoid flushing the display if an error
occurs, preserving the unflushed display output for debugging.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
[ ... ]
> @@ -814,10 +818,11 @@ static int _draw_panic_screen_qr_code(struct drm_sc=
anout_buffer *sb)
>  	return 0;
>  }
> =20
> -static void draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
> +static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>  {
>  	if (_draw_panic_screen_qr_code(sb))
>  		draw_panic_screen_user(sb);
> +	return 0;

[Severity: Medium]
Should this return the error code from draw_panic_screen_user() if the
fallback also fails?

Because this unconditionally returns 0, draw_panic_dispatch() will report
success even if both _draw_panic_screen_qr_code() and the fallback fail.
This causes draw_panic_plane() to still flush the display buffer, which
might overwrite the unflushed output this patch aims to preserve.

>  }
>  #else
>  static void drm_panic_qr_init(void) {};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D4
