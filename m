Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD74C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8771D10F63A;
	Fri, 14 Aug 2026 15:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AsbtiwsL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BB210F63A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:10:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 68BE440E59
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B55C1F000E9;
 Fri, 14 Aug 2026 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786720217;
 bh=Ma9UI4vqLXgsqtw1WWj6SCx8eLMeQFSj8LotSQdbS9k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AsbtiwsL17ooC/5BY73yWfoItgEuEFIKY+aL/8Wxcr31Cg8z5FkcwJWWEK+5P5il4
 LKoWGYZHEw5T3dtxNTsvsXapkj22WcuMhMnfPz+Q1Lf0VffjamR6G20x5R7jW6gol1
 9PwSNFa1BnenhHVMba7TtJxjSkgasXaPqwr6rFyuu1NuYKOzKjWJR+vLfNc4J74OfI
 aKoSJyZmL5oNxxLaifuOkxnF0KYr51Qwx8rSSF8NvI2Jq6fY7FHvMsL2+2dkbJfgrj
 gUEj6fbRI1HOrWF5H3iWKu1of0z0hDDhJJsWT29v4ukLukn1WyCNia4k3z/uu4+lap
 WIBspi85JQf/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/61] drm/simple-kms: Switch to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-7-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-7-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:10:16 +0000
Message-Id: <20260814151017.2B55C1F000E9@smtp.kernel.org>
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
- [Low] The `reset_plane` function pointer remains in `struct drm_simple_di=
splay_pipe_funcs` despite the commit explicitly removing all core support f=
or it.
--

--- Patch [7]: [PATCH v2 07/61] drm/simple-kms: Switch to atomic_create_sta=
te ---
commit 40c453e97222f62dc64493eb74e4a3f1f2594633
Author: Maxime Ripard <mripard@kernel.org>

drm/simple-kms: Switch to atomic_create_state

This commit replaces drm_simple_kms_plane_reset() with
drm_simple_kms_plane_create_state(). It simplifies the initialization by
dispatching only to the new create_plane_state hook and removing support for
the old reset_plane hook.

> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/dr=
m_simple_kms_helper.c
> index 528968ea5c4be..c99ff74dca922 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
[ ... ]
> -	if (pipe->funcs->reset_plane)
> -		return pipe->funcs->reset_plane(pipe);
> +	if (!pipe->funcs || !pipe->funcs->create_plane_state)
> +		return drm_atomic_helper_plane_create_state(plane);

[Severity: Low]
Since support for the reset_plane callback is removed here, should the
reset_plane function pointer also be removed from struct
drm_simple_display_pipe_funcs in include/drm/drm_simple_kms_helper.h?

Leaving it in the struct means out-of-tree drivers might still compile
without warnings if they implement a reset_plane callback, but their
custom logic will be silently ignored at runtime.

> -	return drm_atomic_helper_plane_reset(plane);
> +	return pipe->funcs->create_plane_state(pipe);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D7
