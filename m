Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1345C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91AB10E3C4;
	Tue,  1 Sep 2026 08:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bmWDl5dK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A1810E3C4
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:46:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FCAD4040E;
 Tue,  1 Sep 2026 08:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA291F000E9;
 Tue,  1 Sep 2026 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788252415;
 bh=7FB/v3/L/C3aJrzmEio19J9f3fuCjeRPdhfz8DfMXFY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bmWDl5dKIJ+iJd2/KcA8O/jm+HGZD4STZaKCqwFMsyjw1hDOpj54optHWw2SkhDt3
 yvMZpj0MkrhTAyBb5js+ZE1Xn7XmwDvFMabBZoCE+opSHpI4kcLq3k8cpS1GTp5SLf
 XM+J3U4PD7rOUWW78Us1YwJNJND+C+qaZyBOOKQOGkrYiJfSOeWn4pkAEtvBhMO1PC
 xnIhLP/L0zJSmMYjxH43VKWT3MFAWZ2BH/vEZgPiOTS30PVPz4y5ia46QhxHxJgfK1
 bXg3ZqmzCQub3V9+7p9BivX12UeKdt5jwnCjzX658R+VDZnL+Sp4tGdW7PxITrd0//
 483uzjfw9QJAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/ast: create blend mode property on cursor plane
To: "Qinyun Tan" <qinyuntan@linux.alibaba.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901083234.1828755-2-qinyuntan@linux.alibaba.com>
References: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
 <20260901083234.1828755-2-qinyuntan@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:46:54 +0000
Message-Id: <20260901084654.DBA291F000E9@smtp.kernel.org>
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
- [High] The cursor plane's initial atomic state for the blend mode propert=
y is set to an unsupported value (`DRM_MODE_BLEND_PREMULTI`), which breaks =
atomic state restoration.
--

commit 1ab10188d3825ff30d7b2814879afdf8a8dc65e6
Author: Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: drm/ast: create blend mode property on cursor plane

This patch adds a blend mode property to the ast cursor plane to satisfy the
drm_mode_config_validate() warning about missing blend modes on planes
exposing an alpha pixel format. The newly created property only advertises
DRM_MODE_BLEND_COVERAGE.

> diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_c=
ursor.c
> index fd19c45f2abe2..690d4cd1db5ee 100644
> --- a/drivers/gpu/drm/ast/ast_cursor.c
> +++ b/drivers/gpu/drm/ast/ast_cursor.c

[ ... ]

> @@ -355,6 +356,8 @@ int ast_cursor_plane_init(struct ast_device *ast)
>  	}
>  	drm_plane_helper_add(cursor_plane, &ast_cursor_plane_helper_funcs);
>  	drm_plane_enable_fb_damage_clips(cursor_plane);
> +	drm_plane_create_blend_mode_property(cursor_plane,
> +					     BIT(DRM_MODE_BLEND_COVERAGE));

[Severity: High]
Does this mismatch with the default reset hook and break atomic state
restoration?

The cursor plane uses DRM_GEM_SHADOW_PLANE_FUNCS in ast_cursor_plane_funcs,
which defaults to drm_gem_reset_shadow_plane(). That function calls the
core DRM helper __drm_atomic_helper_plane_state_init(), which hardcodes
plane_state->pixel_blend_mode =3D DRM_MODE_BLEND_PREMULTI. The driver does
not provide a custom .reset hook to override this default.

Since the blend mode property is created here to strictly support only
DRM_MODE_BLEND_COVERAGE, it doesn't support the DRM_MODE_BLEND_PREMULTI
value assigned by the default reset hook.

Because of this mismatch, userspace state queries will return an invalid
enum value that is not in the property's valid enum mask. If a compositor
attempts to save and restore this exact state using the atomic ioctl,
drm_property_change_valid_get() will reject it with -EINVAL. This could
break compositor initialization, virtual terminal switching, and
read-modify-write atomic commits on the cursor plane.

Could we add a custom reset hook to initialize the blend mode to
DRM_MODE_BLEND_COVERAGE, or include DRM_MODE_BLEND_PREMULTI in the
property's valid enum mask?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901083234.1828=
755-1-qinyuntan@linux.alibaba.com?part=3D1
