Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C633C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE6D10F58B;
	Thu,  9 Jul 2026 12:26:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mb3xCaTO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FEB10F58B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:26:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B78046001A;
 Thu,  9 Jul 2026 12:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F61F000E9;
 Thu,  9 Jul 2026 12:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599985;
 bh=4oNtjp0+lQe6aKq8n8XrdVNGAX1bbeeZkkZ7w2laZjw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mb3xCaTODR6xW9iZFuU+KJTQSsJmgJECuKvRt84I9dwoZUZcMIhtnNqn3XLUJY84D
 k3BZNWsxV6QML/dITauJimWFgNF7djBX7rb4KCifiPTP0RXGi6hM+fSf7LM2PxW+Yk
 cz/oM1qMDTIclH+hq7lcaR327kOOKIXBjXAAfWXXLct7GH38QkYDf/TjMthIJFOZRc
 612Yl8b2PTff7i3c3uqjUfhfqDjN1vFx4im1+SrXDQrVYKDzFVo/lFYxdxHDcSuqXu
 rmIlGGdulbEhhvey7UJB3QlFAhjPRWBVztfo5uzJiCoC6IoBbHLtBMKyLySAUeL6NM
 shsHwFTlCi3JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/atomic: Clear plane pipeline for legacy clients
To: "Robert Mader" <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709115855.53725-1-robert.mader@collabora.com>
References: <20260709115855.53725-1-robert.mader@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:26:23 +0000
Message-Id: <20260709122625.433F61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Implicitly clearing `color_pipeline` in `drm_atomic_get_plane_stat=
e` without adding the affected colorops causes hardware state desynchroniza=
tion.
- [Medium] Piecemeal reset of color pipelines for legacy clients leads to v=
isually inconsistent planes on the same CRTC.
--

--- Patch [1]: [PATCH v1] drm/atomic: Clear plane pipeline for legacy clien=
ts ---
commit 58ecff67ea2c28b7e6969be3a82eb9da9e435470
Author: Robert Mader <robert.mader@collabora.com>

drm/atomic: Clear plane pipeline for legacy clients

This commit clears the color_pipeline pointer in drm_atomic_get_plane_state=
()
for legacy clients that do not enable DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE.
This ensures non-bypass color pipelines are reset to clean bypass-only
states.

Link: https://lore.kernel.org/all/CAFZQkGzw2MZGivy=3DoyYgZE3_dmxu-z-NbDgzh9=
uyqSsj=3DMG=3D2w@mail.gmail.com/
Link: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 735ab7badc2ec..581fde90dbd8d 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -656,6 +656,9 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *=
state,
>  	state->planes[index].new_state =3D plane_state;
>  	plane_state->state =3D state;
> =20
> +	if (!state->plane_color_pipeline)
> +		plane_state->color_pipeline =3D NULL;

[Severity: High]
Does clearing the color_pipeline here prevent the old colorops from being
added to the atomic transaction?

If a legacy client takes over the display after a modern compositor configu=
red
a color pipeline, setting plane_state->color_pipeline to NULL means callers
will skip adding the affected colorops.

This appears to orphan the old active colorops from the atomic commit,
meaning driver hardware programming will not see the transition to disable
them, leaving the hardware out of sync with software state.

[Severity: Medium]
Will this piecemeal reset lead to visually inconsistent planes on the same =
CRTC?

Because this reset is tied to plane state retrieval, a legacy client perfor=
ming
a partial update (like DRM_IOCTL_MODE_CURSOR) will only add the specific ta=
rget
plane to the transaction.

Other active planes on the same CRTC would not have drm_atomic_get_plane_st=
ate()
called for them, so their complex color pipelines would remain fully active=
 while
the updated plane is forced to bypass.

> +
>  	drm_dbg_atomic(plane->dev, "Added [PLANE:%d:%s] %p state to %p\n",
>  		       plane->base.id, plane->name, plane_state, state);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709115855.5372=
5-1-robert.mader@collabora.com?part=3D1
