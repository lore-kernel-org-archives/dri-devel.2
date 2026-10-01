Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1707ECA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7971710F67E;
	Thu,  1 Oct 2026 13:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GngcDDBV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F294310F67E
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:15:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9E2560A52;
 Thu,  1 Oct 2026 13:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F50F1F000FF;
 Thu,  1 Oct 2026 13:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790860508;
 bh=YPQcl+2hdQB930rYPjewmwTMJsK6jvBrW9cCTzQbfvU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GngcDDBVwFwgLNbSha1zfcCWcld0lWXM57js4DNSc0WaJ3rHSXo27OVb9bGeDbZ8q
 3TsZeqVRBCWb4MwpVCEfiOhw/Wy5wMD7xxAcnQj6A98SdbVHFADl+c6fQBba6NCmnf
 tY5er2sa1hx//lNJPr3+2fQNM0cGdvIsh9LA8op3w2Rk50ZI7/7/96DlSzzb0/Mue6
 eUqSGLX/Y+bz7Kf1b3ZzDPkFZa9y6iZMC8QA9O+sA1rA2lwgVvCe3r1hl5Y5e0rScm
 EAIMRsj/YSZzjavILTdrCfbLXDN4M63MFI6sAz+daMTLXyKjI9ah9CK6rw0GphlHgs
 tnL8y/k5h4vwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 16/24] drm/mipi-dsi: notify about DSI attach
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261001-drm-bridge-hotplug-v2-16-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-16-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:15:07 +0000
Message-Id: <20261001131508.5F50F1F000FF@smtp.kernel.org>
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
- [Medium] drm: commit message contradicts ATTACHED event semantics
--

commit 3106f1037d08f7d82066d0ccd2f170f5facd1bf0
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/mipi-dsi: notify about DSI attach

This commit introduces an event notification when a DSI device is attached =
to
its host. This is added in preparation for DRM bridge hotplug support.

>     In preparation to support DRM bridge hotplug, let the drm_mipi_dsi co=
de
>     emit an event when a DSI device is attached to the corresponding DSI =
host,
>     so that this event can trigger the actions needed to deconfigure the
>     pipeline and unregister the connector as appropriate.

[Severity: Medium]
Does this commit message contradict the ATTACHED event semantics used in
mipi_dsi_attach() in drivers/gpu/drm/drm_mipi_dsi.c?

The commit message explicitly claims the DRM_MIPI_DSI_ATTACHED event is
intended to trigger actions to "deconfigure the pipeline and unregister the
connector". However, since this event is emitted when a device is attached,
shouldn't it be used to configure the pipeline and register the connector
(which is what the hotplug helper actually does)?

The teardown path is structurally safe because error unwinding (via devres)
calls drm_bridge_remove(), which detaches the bridge from the encoder and
emits DRM_BRIDGE_DETACHED. The hotplug helper correctly listens to
DRM_BRIDGE_DETACHED to unregister the connector, meaning the lifecycle is
perfectly symmetrical without needing a dedicated DRM_MIPI_DSI_DETACHED
event.

Could the commit message be updated to reflect that this event triggers
configuration and registration rather than deconfiguration and
unregistration?

> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_ds=
i.c
> index 3ac1dd5ad640a..eaa474da4a519 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
[ ... ]
> @@ -386,6 +387,8 @@ int mipi_dsi_attach(struct mipi_dsi_device *dsi)
> =20
>  	dsi->attached =3D true;
> =20
> +	drm_event_notifier_notify(DRM_MIPI_DSI_ATTACHED, dsi);
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D16
