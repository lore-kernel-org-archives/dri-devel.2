Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB52606A68F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bn1Z/Dfq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408E210E852;
	Wed, 25 Nov 2026 12:54:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB49F10E852
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:54:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 707A6417C9;
 Wed, 25 Nov 2026 12:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC091F000CA;
 Wed, 25 Nov 2026 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795611250;
 bh=rAEKxI7Avp95aG1Q+Uvh6InOnfasPXVBMp8y6k0TJbs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bn1Z/DfqdES0dH0dXVrFmVdaVTDp/gLV347UvbdXqPTXekxW63iyivHwRBhAl4odG
 kIlkK7x7OC8AP43TNtEYBejKn3sMZhq4PhVqAJ4U4pD5bTat4CjjLxxB5sdf+R+etU
 JmYweO42VoW36XNTENFLZkTKE18MRE5k87IOLX06P7TN5WfSggllbWlJ8AXm10pfBM
 okFmvZTjyCPSx+Rcj33bf1ToSEhTbMJEQuKNqKjuZM+ovslZbbIzOZwdND0VHjySOm
 EkOWUUomkgc6rdAiHR/f3ZRQhOVfz6VxHh59K5kufRLY4l5+HXk9irt0itcqPUxxWs
 Y5TZkoi77nb9w==
Message-ID: <sashiko-outbox-233403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/fbdev-client: Don't restore while fbcon isn't bound
To: "Kylie C" <kyliepc@proton.me>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125-fbdev-no-early-restore-v1-1-f81dc7acf3ad@proton.me>
References: <20261125-fbdev-no-early-restore-v1-1-f81dc7acf3ad@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:54:09 +0000
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
- [Medium] drm/fbdev-client: drm_fbdev_client_restore() breaks non-fbcon
  fbdev restore
--

commit 54a83d65f9ba427c2f43d8c3969eff6a330480ba
Author: Kylie C <kyliepc@proton.me>

drm/fbdev-client: Don't restore while fbcon isn't bound

This commit skips non-forced fbdev mode restoration in
drm_fbdev_client_restore() when fb_helper->info->fbcon_par is NULL so
that deferred console takeover does not restore an unbound fbcon
framebuffer on lastclose.

> diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm=
/clients/drm_fbdev_client.c
> index eec463d199433..7981d613e652e 100644
> --- a/drivers/gpu/drm/clients/drm_fbdev_client.c
> +++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
> @@ -50,6 +50,9 @@ static int drm_fbdev_client_restore(struct drm_client_d=
ev *client, bool force)
>  	if (!fb_helper->info || !fb_helper->fb)
>  		return 0;
> =20
> +	if (!force && !fb_helper->info->fbcon_par)
> +		return 0;
> +
>  	drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
> =20
>  	return 0;

[Severity: Medium]
Does checking fb_helper->info->fbcon_par break fbdev restoration when
userspace drives /dev/fb* without fbcon?

DRM_FBDEV_EMULATION does not depend on CONFIG_FRAMEBUFFER_CONSOLE, and
userspace can also unbind fbcon at runtime to use /dev/fb0 directly.
Because info->fbcon_par is only set in fbcon_open(), it remains NULL in
those setups, so drm_lastclose() -> drm_client_dev_restore(dev, false)
will permanently skip drm_fb_helper_restore_fbdev_mode_unlocked() and
any pending delayed_hotplug handling when the last DRM client exits.

In addition, struct fb_info documents fbcon_par as an fbcon-only private
field ("/* fbcon use-only private area */" in include/linux/fb.h).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-fbdev-no-e=
arly-restore-v1-1-f81dc7acf3ad@proton.me?part=3D1
