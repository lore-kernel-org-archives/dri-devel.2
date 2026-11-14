Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B86606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKQubDGB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29AB710E264;
	Sat, 14 Nov 2026 16:38:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1306710E264
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:38:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56B8061423;
 Sat, 14 Nov 2026 16:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95D01F000C4;
 Sat, 14 Nov 2026 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794674294;
 bh=AeX6XuE7e2Pgc/Ao1xJe90LjSjZOuzRBgCqPZev9yTY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=HKQubDGBVpMUDP1odjlGn5xALOgbHqwRSlSDWC10L+3iF4V0taYqVNqStFl9ZmUMo
 cy6x4LziH9JbCiMX+rF7kGlLznEfQHDytv7AgHjxAdTtJVPcx0iXGYObYsuVsSFt/h
 +Ah6L1QVlxkkOXh7Pq0XdWcss0G1ReSut03+foUsLrcc7ZfWF2NJ5tcwdVcigM3bWJ
 jPKlrgX7XZgrdFA0HtTDbSm7RKcEpnGyij69+49pILgJQ7bD/zRge/SZzOU0/gehC1
 dxAVEnVNnRA5DJjvFXHds4qfAylFlsX694hsCOxpf6rwLMqAWp26Mv8Spja9Y7MEp3
 CfZ2qwPcYZugQ==
Message-ID: <sashiko-outbox-214768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/fbdev-dma: Copy the shadow buffer on unblank
To: "Angelo Compagnucci" <angelo.compagnucci@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261113110708.927665-1-angelo.compagnucci@gmail.com>
References: <20261112091630.3947184-1-angelo.compagnucci@gmail.com>
 <20261113110708.927665-1-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:38:13 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/fbdev-dma: sleeping lock in
  drm_fbdev_dma_shadowed_fb_blank() on oops
- [Low] drm/fbdev-dma: missing Fixes trailer for shadow buffer unblank
  fix
--

commit a63597b4af664e3cb6d1b39bfd1dd1e573a6fdb2
Author: Angelo Compagnucci <angelo.compagnucci@gmail.com>

> drm/fbdev-dma: Copy the shadow buffer on unblank
>
> With a shadow buffer, what userspace draws in fbdev reaches the
> framebuffer memory only when the damage worker runs. Turning the display
> on shows the framebuffer memory as it is. So a program that draws its
> first picture and then unblanks, such as a boot splash, shows an older
> picture for a moment.
>
> Seen on an ILI9341 panel (tinydrm ili9341): enabling the pipe sends the
> whole framebuffer memory to the panel, still black, and the splash only
> replaces it once the damage worker runs.
>
> Nothing can be flushed to a display that is off. But the copy from the
> shadow buffer into the framebuffer memory does not need the display. On
> unblank, copy the whole shadow buffer into the framebuffer memory before
> turning the display on. The damage worker still flushes the damage once
> the display is on.
>
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>

[Severity: Low]
This fixes a bug introduced with shadow buffering.  Should the commit
message include a Fixes tag?

  Fixes: 360399643299 ("drm/fbdev-dma: Add shadow buffering for deferred I/=
O")

> diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_=
dma.c
> index 452f844003504..cc8813538bd90 100644
> --- a/drivers/gpu/drm/drm_fbdev_dma.c
> +++ b/drivers/gpu/drm/drm_fbdev_dma.c

[ ... ]

> @@ -196,6 +187,41 @@ static const struct drm_fb_helper_funcs drm_fbdev_dm=
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
> +	 */
> +	if (blank =3D=3D FB_BLANK_UNBLANK)
> +		drm_fbdev_dma_damage_blit(fb_helper, &clip);
> +
> +	return drm_fb_helper_blank(blank, info);
> +}

[Severity: Medium]
Can calling drm_fbdev_dma_damage_blit() before checking oops_in_progress
sleep in atomic context or deadlock during an oops or panic?

When the VT console is blanked during an oops or panic, bust_spinlocks(0)
and panic() call console_unblank() -> ... -> fb_blank(info,
FB_BLANK_UNBLANK) with oops_in_progress set and interrupts disabled.
drm_fb_helper_blank() guards against this at entry:

drivers/gpu/drm/clients/drm_fbdev_helper.c:drm_fb_helper_blank() {
	if (oops_in_progress)
		return -EBUSY;
    ...
}

Calling drm_fbdev_dma_damage_blit() before reaching that check
unconditionally acquires the sleeping mutex fb_helper->lock, which sleeps in
atomic context and can deadlock if the crashing context or a stopped CPU
already holds fb_helper->lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113110708.9276=
65-1-angelo.compagnucci@gmail.com?part=3D1
