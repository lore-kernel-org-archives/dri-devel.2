Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C531C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780EE10EFE3;
	Thu, 17 Sep 2026 16:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="edKct2gt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8582F10EFEB
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:06:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8CB27600D4;
 Thu, 17 Sep 2026 16:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256C91F00893;
 Thu, 17 Sep 2026 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789661179;
 bh=djP1EE+owfRT7De5mNJYek2gbfbLgE3WV4brsVoWc8Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=edKct2gtDTpm6Jo9w+gvfFgrBNWPZTwHqvkblhIkP5GIC274Vx85uFsToiqv5TkMg
 RgWFna+JBrStm9KL6SCDlq75jqpigxxrRM+v8LElPQlkM3KkksgCDkULvFQI1/gTvT
 5zEcIgSK7g75a3IFACktnY+qcCiK1hA6Ot9/E8UqBiaD+Ypup45AsnRFY3Pso09oUI
 3gaUWMZh8BX6p7jZfbG4De73n/la1DzNOv6jgKxaDp+dnkXzdoboCQVe5KWqu5Wqo+
 VRQenJwGt10PIsTcx1CFEGo+VHuaGNJH15GWJ7YiqmpG5NlLiGPqwPsQApf/uVrAu3
 DMvlbvdoplU+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/client: fix restore of partially initialized client
To: shechenglong <shechenglong@xfusion.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917154743.1621-1-shechenglong@xfusion.com>
References: <20260907035147.1339-1-shechenglong@xfusion.com>
 <20260917154743.1621-1-shechenglong@xfusion.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:06:18 +0000
Message-Id: <20260917160619.256C91F00893@smtp.kernel.org>
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
- [Medium] drm/client: early return of 0 in fbdev restore aborts fallback l=
oop
--

commit d167ca7eea0e08eeed4c9c5277344faccb69545c
Author: shechenglong <shechenglong@xfusion.com>

drm/client: fix restore of partially initialized client

This commit fixes a NULL pointer dereference that occurs when userspace
closes a DRM file descriptor and a partially initialized fbdev client is
restored. It adds a check to skip the restore operation if the framebuffer
device has not been fully initialized.

> diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm=
/clients/drm_fbdev_client.c
> index 827f326687140..7574bd36f45eb 100644
> --- a/drivers/gpu/drm/clients/drm_fbdev_client.c
> +++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
> @@ -42,6 +42,14 @@ static int drm_fbdev_client_restore(struct drm_client_=
dev *client, bool force)
>  {
>  	struct drm_fb_helper *fb_helper =3D drm_fb_helper_from_client(client);
> =20
> +	/*
> +	 * The client is registered before the initial fbdev probe.
> +	 * If probing failed, the client remains registered but there
> +	 * is no valid fbdev framebuffer to restore.
> +	 */
> +	if (!fb_helper->info || !fb_helper->fb)
> +		return 0;

[Severity: Medium]
Does returning 0 here prematurely abort the fallback loop in the caller?

When the fbdev client is registered but fails probing, fb_helper->info is
NULL. The caller, drm_client_dev_restore(), iterates through clients and
calls their restore callbacks. Since drm_client_dev_restore() breaks the lo=
op
on the first 0 return, this falsely signals success.

This means the display is not restored by other registered clients
(like drm_log) when userspace closes the DRM fd or exits. Should this return
a negative error code like -ENODEV to allow the loop to continue?

> +
>  	drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917154743.1621=
-1-shechenglong@xfusion.com?part=3D1
