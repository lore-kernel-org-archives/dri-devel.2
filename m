Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA0FC54FCD
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED59310E0C5;
	Wed, 29 Jul 2026 21:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PpVuTHqf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FBE10E0A8
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:55:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7088A600AA;
 Wed, 29 Jul 2026 21:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EFF1F000E9;
 Wed, 29 Jul 2026 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785362129;
 bh=5ptObQfym6EjnouarpVoft+ocuy7Vu/3xCz9HT5i1rA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PpVuTHqf1Tuzb8eD/EnftlssLmp+uk2JiHpQwcGhITXffNrj+dblBcKUEynVmud/q
 Ro3Ss8MpyE00Sc0328cTNqXQnRXZA94snbO0SGShigBZNkDWZSGN5LdvnLG/v4uZL/
 6EioUWGmRCl/XgrV6K9WFUjb4cg8DtCBLL/CkW1k87/lwDWhbL3LxAJvAlpPyW+1Xc
 rHGr6xwOQkRFtETukN3L+Iki95XUnON+T9nX/SjtiWWGJmkNvPXYzUdmrmtOnM1aea
 NswNYFHY16cLY5T6+ai8g4Rra8pHLefQFGHWyKoFjC2HI7vXJtg0hFcExCfmSKpVOK
 gN4Xa2M2KYLYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
To: "Leandro Ribeiro" <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729214505.185776-2-leandro.ribeiro@collabora.com>
References: <20260729214505.185776-1-leandro.ribeiro@collabora.com>
 <20260729214505.185776-2-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 21:55:28 +0000
Message-Id: <20260729215528.D6EFF1F000E9@smtp.kernel.org>
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
- [High] Unconditional dereference of `drm_format_info()` return value lead=
s to NULL pointer dereference for unrecognized formats.
--

--- Patch [1]: [PATCH 1/1] drm: use drm_warn() in validate_blend_mode_for_a=
lpha_formats() ---
commit 8bcc8b572cfd0496af9f1e8dd202524f50670fa0
Author: Leandro Ribeiro <leandro.ribeiro@collabora.com>

drm: use drm_warn() in validate_blend_mode_for_alpha_formats()

This commit replaces WARN() with drm_warn() in
validate_blend_mode_for_alpha_formats() to prevent fuzzers from tripping
over kernel warning reports for expected driver validation issues.

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index 3bcc7bf0900c4..3d9c554e08a87 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -869,8 +869,9 @@ static void validate_blend_mode_for_alpha_formats(str=
uct drm_plane *plane)
>  	for (i =3D 0; i < plane->format_count; i++) {
>  		fmt =3D drm_format_info(plane->format_types[i]);
>  		if (fmt->has_alpha) {

[Severity: High]
This is a pre-existing issue, but could this unconditionally dereference
fmt if drm_format_info() returns NULL?

If a driver exposes an unrecognized or custom pixel format that the core
DRM does not know about, drm_format_info() returns NULL. Since the
purpose of this validation function is to catch driver bugs, should we
check if fmt is NULL before checking fmt->has_alpha to avoid a kernel
panic?

> -			WARN(1, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode=
 not setup",
> -			     plane->base.id, plane->name);
> +			drm_warn(plane->dev,
> +				 "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not s=
etup",
> +				 plane->base.id, plane->name);
>  			break;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729214505.1857=
76-2-leandro.ribeiro@collabora.com?part=3D1
