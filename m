Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2ABC5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A28710EB63;
	Tue, 18 Aug 2026 13:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gvGuIMNJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D900B10EB63;
 Tue, 18 Aug 2026 13:05:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D50A601DE;
 Tue, 18 Aug 2026 13:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEDF1F00A3A;
 Tue, 18 Aug 2026 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787058347;
 bh=bQaJgiGjuAD96kn/7OalzUA6lCHbPxXMTnaT8tOMXqk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gvGuIMNJqu5T1Uwhxc6cYB/9GNIK02OoNZbtDftXHBmt0BsG5mIg/tYiLRZCx2cFu
 NmLR2mW6xEIU/qLZZxjhF9EpF1FG/e99HYFePMo8M/ZLehswtz/kyjC6P6mSsl7c9L
 eI1K9L/eyQVxwbL1sIza9DK0qvFzqMzO9kLxRORoC10HbjbeMQXvMuUHvjFPNW8xS7
 /eHvKKCcTd6vT5EMahR8MWp1Mt7CXXdd70aCoqEfqooImOIO5nPw6Xvt6QTr9IorL6
 qOQG8KCJ17Upaw9jPDSo4tQESIWswflThYhYQ37R04wZrMs35TqZ26Nq2sao7CHf2A
 hXlkVWOTSQF6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] drm/panic: Retry in dispatch function if panic
 output fails
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Frank.Li@kernel.org, imx@lists.linux.dev, intel-xe@lists.freedesktop.org,
 ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com
In-Reply-To: <20260818125012.468092-8-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:05:46 +0000
Message-Id: <20260818130547.4FEDF1F00A3A@smtp.kernel.org>
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
- [Medium] Removing the internal fallback from `draw_panic_screen_qr_code` =
breaks the `drm_panic` KUnit tests.
--

--- Patch [7]: [PATCH 07/12] drm/panic: Retry in dispatch function if panic=
 output fails ---
commit 23392eb57457ad383d9c4741f6fc2f3c107aabb3
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Retry in dispatch function if panic output fails

On failed output of QR codes and kmsg buffers, fall back to a user
message. QR-code output already did this internally, but now formally
support it in drm_panic_dispatch(). Streamlines the existing logic.

> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
[ ... ]
> @@ -816,15 +816,6 @@ static int _draw_panic_screen_qr_code(struct drm_sca=
nout_buffer *sb,
>  	drm_panic_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
>  	return 0;
>  }
> -
> -static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				     u32 fg_color, u32 bg_color,
> -				     unsigned int qr_version)
> -{
> -	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
> -		draw_panic_screen_user(sb, fg_color, bg_color);
> -	return 0;
> -}

[Severity: Medium]
Does removing this fallback cause the drm_panic KUnit tests to fail?

Looking at the test suite in drivers/gpu/drm/tests/drm_panic_test.c, it
calls this function directly without going through the new dispatch logic:

static int draw_panic_screen_qr_code_default(struct drm_scanout_buffer *sb)
{
	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000, 40);
}

When tested with a small resolution like 300x200, the scale evaluates to 0
and returns -ENOSPC. Previously, this wrapper caught the error, fell back
to draw_panic_screen_user, and safely returned 0, satisfying the KUnit
check.

Since the fallback was moved to draw_panic_dispatch and the test calls
the lower-level function directly, will this now propagate the -ENOSPC
error and spuriously fail the test?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D7
