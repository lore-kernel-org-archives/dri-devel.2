Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABA2C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 04:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE7410E444;
	Mon,  7 Sep 2026 04:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BSmdMv+M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744EB10E444
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 04:12:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D3D443930;
 Mon,  7 Sep 2026 04:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E301F00A3A;
 Mon,  7 Sep 2026 04:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788754358;
 bh=apN/osQtuUpzfSOKKff21McSm92BImn5zURdyxok5r4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BSmdMv+MHW3SbgEsuuyQne0PzMvFh2wDFpERfbQ8WWyz4FBb2/m8TnWhMT6Woumb6
 /6KbR29UEZCf42wmFEiux3BC7n9+oHXaXf/GLMeRjq1cyKAw72r4zQUK9ISQGNm/ZW
 du6xDlbe32FUhdV5XsPZr2MCc1Or+YqOaTwinI1rj0WaqsSATDMJh+6ROY2JTiEW3g
 sSPNU6uzx4uFNgBUrnFu2kNnStlwB91vmXX9mwEYAPTOtKqaavDGPlzax15399S8kZ
 YiKpKmznFhvqjg2lftIrzr5VL9c4LPmCjR6jfr2XlHMY3iCRevXmcKgPAA/AhJQgcJ
 mA80R2kUznJ4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/client: fix restore of partially initialized client
To: shechenglong <shechenglong@xfusion.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907035147.1339-1-shechenglong@xfusion.com>
References: <20260907035147.1339-1-shechenglong@xfusion.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:12:37 +0000
Message-Id: <20260907041237.C7E301F00A3A@smtp.kernel.org>
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
- [High] Memory leak of drm_client_buffer and its virtual memory mapping if=
 register_framebuffer() fails.
--

commit 99c42165eff4a5954aaf41ad682bb169178e6b09
Author: shechenglong <shechenglong@xfusion.com>

drm/client: fix restore of partially initialized client

This commit fixes a NULL pointer dereference that occurs when closing a
DRM file descriptor for a partially initialized fbdev client. It skips
the restore process in drm_fbdev_client_restore() if no valid fbdev
framebuffer is found.

> diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm=
/clients/drm_fbdev_client.c
> index 91d196a397cf2..1c16bc1084c40 100644
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
> +

[Severity: High]
This is a pre-existing issue, but since the commit message mentions mirrori=
ng
the logic from drm_fbdev_client_unregister(), does the current cleanup path
leak the drm_client_buffer when probing fails?

In drivers/gpu/drm/drm_fb_helper.c:__drm_fb_helper_initial_config_and_unloc=
k(),
drm_fb_helper_single_fb_probe() allocates fb_helper->buffer (which creates =
the
framebuffer and maps memory). If the subsequent call to register_framebuffe=
r()
fails, it returns without cleaning up the buffer:

drivers/gpu/drm/drm_fb_helper.c:__drm_fb_helper_initial_config_and_unlock()=
 {
    ...
    ret =3D register_framebuffer(info);
    if (ret < 0)
        return ret;
    ...
}

The caller handles this error by calling drm_fb_helper_fini(), which frees
fb_helper->info via framebuffer_release() and sets fb_helper->info to NULL.
Importantly, framebuffer_release() only frees the struct without invoking
the fb_destroy callback.

Later, when the client is unregistered, drm_fbdev_client_unregister() takes
the else branch because fb_helper->info is NULL:

drivers/gpu/drm/clients/drm_fbdev_client.c:drm_fbdev_client_unregister() {
    if (fb_helper->info) {
        ...
    } else {
        /*
         * Partially initialized client, no framebuffer device yet
         */
        drm_client_release(&fb_helper->client);
    }
}

This skips drm_fb_helper_unregister_info() and the associated fb_destroy()
callback, permanently leaking fb_helper->buffer, its backing GEM object,
and its virtual memory mapping.

This leak can be triggered by resource exhaustion, limit reached (FB_MAX), =
or
other failures during register_framebuffer(). Could the error handling path
be updated to ensure the buffer is properly destroyed when this occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907035147.1339=
-1-shechenglong@xfusion.com?part=3D1
