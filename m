Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C709FC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C3210E132;
	Tue, 25 Aug 2026 11:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n8Yi0aWy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C9710E132
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 11:07:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44D2F40068;
 Tue, 25 Aug 2026 11:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054AB1F000E9;
 Tue, 25 Aug 2026 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787656070;
 bh=EnKR26LQb9Tlx63aWed1RgyrV9jxjVT4jbK2UfS4014=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n8Yi0aWyW6iYU9/DKLwBOyY+LKAu42g1mvPYO1AfH4Fy0HmCisniFljHBjg7sDpvW
 6aLFzAxKxWb/cjTdl4mvu5cbzNdGw6K+U4RHl9ynPnqE9e3nkESF0ir5REwJOWglDj
 o1ZUdTrM+HVcslTIaQspcgiNg03PKrIYEFaI6BMZP9xgh90ukYCas5x3VPRFKcizx2
 mpUbwXKkWEyKGk0RtDNX0xBIc85IjPRooWFT93QYTlH7lkZZO/l4q1RbjuqjLAjTar
 LGbML+7Q92P5McnbmmpyyoCaKVqNTPGSk3PZ/FJMnnsasFLxoX2bzJNu1MtX7oaEIZ
 NcGWsyNq1+i0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
To: "Roshan Kumar" <roshaen09@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825105427.686619-1-roshaen09@gmail.com>
References: <20260825105427.686619-1-roshaen09@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 11:07:49 +0000
Message-Id: <20260825110750.054AB1F000E9@smtp.kernel.org>
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
- [High] The initial atomic plane state defaults to an invalid pixel blend =
mode, which contradicts the newly added blend mode property that only suppo=
rts `DRM_MODE_BLEND_PIXEL_NONE`.
--

--- Patch [1]: [PATCH] drm/pl111: Advertise no pixel blending ---
commit e96a716603035744ccddd019e74ade69db24a36e
Author: Roshan Kumar <roshaen09@gmail.com>

drm/pl111: Advertise no pixel blending

This commit adds a pixel blend mode property to the PL111 display plane to
satisfy validation introduced in commit 860e748bddcc, advertising only
DRM_MODE_BLEND_PIXEL_NONE. This resolves a syzkaller panic during boot on
vexpress-a15 managers.

Link: https://github.com/google/syzkaller/issues/7805

> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl11=
1/pl111_display.c
> index 5d10bc5fdf1f6..758b297cbdea5 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
[ ... ]
> @@ -596,5 +597,10 @@ int pl111_display_init(struct drm_device *drm)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D drm_plane_create_blend_mode_property(&priv->pipe.plane,
> +						   BIT(DRM_MODE_BLEND_PIXEL_NONE));

[Severity: High]
Will this cause atomic commits to fail with -EINVAL for standard userspace
compositors?

Because pl111 uses drm_simple_display_pipe_init() and lacks a custom
reset_plane hook, the DRM core falls back to drm_atomic_helper_plane_reset()
which unconditionally sets plane_state->pixel_blend_mode =3D=20
DRM_MODE_BLEND_PREMULTI during __drm_atomic_helper_plane_state_init().

Since this newly created property only supports DRM_MODE_BLEND_PIXEL_NONE,
userspace reading the initial state and submitting it back will provide an
enum value that is not in the allowed mask. This causes=20
drm_property_change_valid_get() to reject the commit.=20

Does the driver need a custom reset hook to initialize the plane state to
DRM_MODE_BLEND_PIXEL_NONE instead of relying on the default initialization?

> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825105427.6866=
19-1-roshaen09@gmail.com?part=3D1
