Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE7606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRPC/eHf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE9910ED93;
	Mon, 16 Nov 2026 09:11:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4DC10E9DC
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:11:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD3D762788;
 Mon, 16 Nov 2026 09:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE2B1F000C7;
 Mon, 16 Nov 2026 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794820306;
 bh=4nkE5eKl/GAJTyCEzr+0pBXORpO8ZFmdM286uGYwDI0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YRPC/eHfSuKWoQOMPrgwjfbCCYtbgEvrCP/UgzA7MN0IJ4axDQqxWnuhZfHXZz/NF
 Woh5Q33dCS0LQchR7STSwhim+0cFSazGYiTTQpCRAlkVwXc4uUQDik0QfhL6r+/qSJ
 hUim0IpVmFzyKgSdDoY6SyImfqtlWjLMA41BoswLjKMUJrQZ+h0beGZh+i9dwaooSb
 QnvZzSJe+pxwJ5ua9W/twuqzByQldxo8MTHzZUcckOMxWmBugk3aSFWDQ4gd9UwDYL
 dTg8j2XmRMJOyoGEPYl/uUBrQGf9e7ULndWwEUsMPyJuOeG8oQvFr7GFlBFmHPdgbQ
 PGT04xRM96Qxg==
Message-ID: <sashiko-outbox-216593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/fbdev-dma: Copy the shadow buffer on unblank
To: "Angelo Compagnucci" <angelo.compagnucci@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261114201351.2788719-1-angelo.compagnucci@gmail.com>
References: <20261113110708.927665-1-angelo.compagnucci@gmail.com>
 <20261114201351.2788719-1-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:11:45 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/fbdev-dma: unaddressed v2 review on
  drm_fbdev_dma_shadowed_fb_blank()
--

commit 7dc07a1feeaa7bfcabe7b06bf9f13b3b3f41fd0e
Author: Angelo Compagnucci <angelo.compagnucci@gmail.com>

drm/fbdev-dma: Copy the shadow buffer on unblank

This commit adds a custom .fb_blank callback for shadowed fbdev-dma
framebuffers that copies the shadow buffer into the GEM DMA buffer on
FB_BLANK_UNBLANK before calling drm_fb_helper_blank().

> diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_=
dma.c
> index 452f844003504..3effc5c05d9ce 100644
> --- a/drivers/gpu/drm/drm_fbdev_dma.c
> +++ b/drivers/gpu/drm/drm_fbdev_dma.c

[ ... ]

> @@ -196,6 +187,45 @@ static const struct drm_fb_helper_funcs drm_fbdev_dm=
a_helper_funcs =3D {
>   * struct drm_fb_helper
>   */
> =20
> +static int drm_fbdev_dma_shadowed_fb_blank(int blank, struct fb_info *in=
fo)
> +{
> +	struct drm_fb_helper *fb_helper =3D info->par;
> +	struct drm_clip_rect clip =3D {
> +		.x2 =3D fb_helper->fb->width,
> +		.y2 =3D fb_helper->fb->height,
> +	};
> +
> +	/*
> +	 * Turning the display on shows the framebuffer memory. Copy the
> +	 * shadow buffer into it first, so it holds what was drawn. This
> +	 * does not need the display; the damage worker still flushes the
> +	 * damage once the display is on.
> +	 *
> +	 * The copy takes a mutex, so skip it during an oops, where the
> +	 * console is unblanked in atomic context. drm_fb_helper_blank()
> +	 * does nothing then.
> +	 */
> +	if (blank =3D=3D FB_BLANK_UNBLANK && !oops_in_progress)
> +		drm_fbdev_dma_damage_blit(fb_helper, &clip);
> +
> +	return drm_fb_helper_blank(blank, info);
> +}

[Severity: Medium]
As reported by Thomas Zimmermann on v2 [1], does this comment and the
commit message accurately describe how unblanking and damage flushing
interact here?

In v2, Thomas Zimmermann noted in response to the v1 -> v2 changelog entry
that some hardware and drivers require the CRTC to be enabled before
display data can be transferred (as in drm_atomic_helper_commit_tail_rpm()),
and asked what problem this change is trying to solve.

In addition, on MIPI DBI drivers such as ili9341,
drm_fb_helper_blank(FB_BLANK_UNBLANK) -> drm_fb_helper_dpms() ->
drm_client_modeset_commit_atomic() enables the CRTC and immediately
commits the active planes with full-frame damage, which transfers the GEM
DMA buffer to the panel during drm_fb_helper_blank() itself rather than
waiting for the damage worker. If FB_BLANK_UNBLANK is called while
deferred I/O work is still pending, drm_fbdev_dma_shadowed_fb_blank()
copies the shadow buffer and the modeset flushes the full frame to the
panel, and then drm_fb_helper_damage_work() runs afterward and copies and
flushes the damaged area a second time.

[1] https://lore.kernel.org/r/556dd1ab-a1af-4c8b-be6e-04382ed0b958@suse.de

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114201351.2788=
719-1-angelo.compagnucci@gmail.com?part=3D1
