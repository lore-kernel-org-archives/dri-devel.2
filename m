Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850CCCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD7D10E514;
	Mon, 15 Jun 2026 15:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ar3iybqO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F7410E514
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:33:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CA2D601E1;
 Mon, 15 Jun 2026 15:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18D81F000E9;
 Mon, 15 Jun 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781537622;
 bh=6AjC6XjOX61yxIs9K83xQ18hyh50u0vg4kCu1YoanDg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ar3iybqOKQYIXZWMkcncNUVVj0sdj44I16Q4OOLjfpOxZ97audLQD+Q+ApxNyv6vx
 Ff+QTYTB93tLmGggD07BC1+1dXnAvUrpcXN6oF9S6TaBzAAcS2LYWS+2NIjqa7/cSG
 xHjILUGxlZzqTnFE1FxxBZ00ZvXemkIEedcLxZWxuMFXDwqzOllEFANQW0dzxSbCx7
 MX1GCOzAb+bTAhjf3qjzDJb9jg2r0DotuY93wBEBU10eIERIMDukNfY/dva062wfjH
 F7cA4xIpz5lD8wf5RjKigCm8zOe4aXXs93lJmWibsCNw5bjCYBmrApB/c7ZqBSOzi0
 09gycpLH1w6/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/dp: fix kernel-doc for struct drm_dp_vsc_sdp
To: "Jani Nikula" <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615153027.1899784-1-jani.nikula@intel.com>
References: <20260615153027.1899784-1-jani.nikula@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 15:33:41 +0000
Message-Id: <20260615153341.F18D81F000E9@smtp.kernel.org>
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
- [Medium] The commit title and message incorrectly reference `struct drm_d=
p_vsc_sdp` instead of `struct drm_dp_as_sdp`.
--

commit 8304279d14f731f52c93218e1e0ba5c553ab15f4
Author: Jani Nikula <jani.nikula@intel.com>

drm/dp: fix kernel-doc for struct drm_dp_vsc_sdp

This commit aims to add the missing coasting_vtotal kernel-doc member
documentation.

> drm/dp: fix kernel-doc for struct drm_dp_vsc_sdp
>=20
> Add the missing coasting_vtotal kernel-doc member documentation for
> struct drm_dp_vsc_sdp.

[Severity: Medium]
Are the commit title and message referencing the correct structure?

The commit message states the documentation is being added for
struct drm_dp_vsc_sdp, but looking at the diff below, the code modifies
the kernel-doc block for struct drm_dp_as_sdp instead.

> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/dr=
m_dp_helper.h
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -115,6 +115,7 @@ struct drm_dp_vsc_sdp {
>   * @duration_decr_ms: Successive frame duration decrease
>   * @target_rr_divider: Target refresh rate divider
>   * @mode: Adaptive Sync Operation Mode
> + * @coasting_vtotal: Coasting vtotal
>   */
>  struct drm_dp_as_sdp {

[Severity: Medium]
Does this coasting_vtotal member belong to struct drm_dp_as_sdp as modified
here, or was it intended for struct drm_dp_vsc_sdp?

It appears the git diff hunk header might have misleadingly displayed
struct drm_dp_vsc_sdp as the context, while the actual modification is
applied to the documentation block for struct drm_dp_as_sdp. Could the
commit message be updated to match the code, or was the documentation
added to the wrong structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615153027.1899=
784-1-jani.nikula@intel.com?part=3D1
