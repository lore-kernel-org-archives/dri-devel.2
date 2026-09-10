Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667D4C88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961A310EF9F;
	Thu, 10 Sep 2026 22:47:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dYauf2cp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E1A310EF9F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 22:47:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81451601F0;
 Thu, 10 Sep 2026 22:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F871F000FF;
 Thu, 10 Sep 2026 22:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789080439;
 bh=j0HIO4Rm49ICndcmBJd3Nh/hldg5pcD5mJ70dlNjB0s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dYauf2cpH1s3Ple5DOspGQBx+rz7A/M17+4G+rPp5oXMFjZ7OqRH+ZdVXSzJxbzEA
 ufsl96co6YPQ/Gao5OpbcqtYzxaidPvlkLkXYFcbF25kV4saaYmYIZSzLwQI0baQkC
 pIM5xrnCkkvNoJlyrNFAdVxWPan8nBTXcJyUkAWkyx3BdGX2kIudIOw83LswWcuwlH
 gKQK9SD9T8pClIxdkZW91F7FhTL5c9tX41I4EgVVmnbn+nXYlGwJXRZ85bNbJdL4tk
 dPHxNXtXhxyKbQeSX9BeqUk+UlB0HVFxbOAuMQLWRiKwgaRyLgL62xbgGXcRpSWjZf
 +7zJx8XD0yUTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: simple: Clean up resources on DSI attach
 failure
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910223803.8552-1-mhun512@gmail.com>
References: <20260910223803.8552-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 22:47:18 +0000
Message-Id: <20260910224719.15F871F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free (UAF) of the panel structure due to premature r=
egistration during probe
- [High] Unbalanced runtime PM and resource leak in panel_simple_remove()
- [High] TOCTOU race in panel_simple_shutdown() leading to lockless state c=
orruption
--

commit 887f69784ef5d71614e53c7181f7e8b567905759
Author: Myeonghun Pak <mhun512@gmail.com>

drm/panel: simple: Clean up resources on DSI attach failure

This patch modifies panel_simple_dsi_probe() to call panel_simple_remove()
when mipi_dsi_attach() fails. This cleans up common probe resources instead
of just undoing panel registration.

> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index c95964ba25a95..767068de68160 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -6552,11 +6552,8 @@ static int panel_simple_dsi_probe(struct mipi_dsi_=
device *dsi)
>  	dsi->lanes =3D desc->lanes;
> =20
>  	err =3D mipi_dsi_attach(dsi);
> -	if (err) {
> -		struct panel_simple *panel =3D mipi_dsi_get_drvdata(dsi);
> -
> -		drm_panel_remove(&panel->base);
> -	}
> +	if (err)
> +		panel_simple_remove(&dsi->dev);

[Severity: Critical]
This isn't a bug introduced by this patch, but could this error path lead to
a Use-After-Free (UAF) of the panel structure?

When panel_simple_dsi_probe() calls panel_simple_probe(), the panel is
allocated using devm_kzalloc() and registered globally via drm_panel_add().
At this point, it is visible to the system and a concurrent display driver
can discover it via of_drm_find_panel() and store a pointer to it.

If mipi_dsi_attach() fails here, panel_simple_remove() is called to
unregister it, and the probe function returns an error. Returning an error
triggers the driver core's devres cleanup, completely freeing the panel
structure memory. However, the concurrent display driver might still hold a
dangling pointer to this freed structure, resulting in a critical UAF upon
subsequent access (e.g., calling drm_panel_prepare()).

[Severity: High]
This is a pre-existing issue, but does calling panel_simple_remove() here
lead to an unbalanced runtime PM state and resource leak?

Looking at panel_simple_remove():

static void panel_simple_remove(struct device *dev)
{
    ...
    panel_simple_shutdown(dev);
    pm_runtime_dont_use_autosuspend(dev);
    pm_runtime_disable(dev);
    ...
}

panel_simple_shutdown() unprepares the panel, which calls
pm_runtime_put_autosuspend() to schedule an asynchronous suspend, but leaves
the device in the RPM_ACTIVE state. Then, pm_runtime_dont_use_autosuspend()
and pm_runtime_disable() cancel the pending autosuspend and disable runtime
PM entirely.

Because a synchronous suspend (e.g., pm_runtime_suspend or
pm_runtime_force_suspend) is omitted, the panel_simple_suspend() callback
never executes. Will this leave the panel's regulator and GPIO permanently
enabled, leading to a persistent hardware state and regulator enable count
leak?

[Severity: High]
This is also a pre-existing issue, but is there a TOCTOU race in
panel_simple_shutdown() (which is called by panel_simple_remove() above)?

In panel_simple_shutdown():

static void panel_simple_shutdown(struct device *dev)
{
    ...
    if (panel->base.enabled)
        drm_panel_disable(&panel->base);
    if (panel->base.prepared)
        drm_panel_unprepare(&panel->base);
    ...
}

These states are checked without holding any synchronization primitives
(such as DRM modeset locks). If this runs concurrently with a DRM display
controller performing a modeset (which independently calls
drm_panel_disable), both threads may observe panel->base.enabled =3D=3D true
simultaneously.

Could this lockless race lead to double-disabling of the panel, unbalanced
regulator disables, and potential hardware state corruption?

> =20
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910223803.8552=
-1-mhun512@gmail.com?part=3D1
