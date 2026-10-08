Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B590DCA6016
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130EC10FD7F;
	Thu,  8 Oct 2026 21:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="knaC1qoR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2A610FD3F
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:09:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DEA141619;
 Thu,  8 Oct 2026 21:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E030F1F000FF;
 Thu,  8 Oct 2026 21:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791493774;
 bh=NJDbMjiAZGIEX6Xvd1t2m4pTGXaml9fxHZwWgvnCsJM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=knaC1qoRvwNQ+cE03z0Yz0EqlRxrlUZKGyptGG0p65sS5reqngE3fHPOVgv51ObKS
 3yQehfSK0GihnnJiuOwpJTdzypnaj4/6olbH3gdUKS7ECD0h4pI2b9eZLhbd/Lv5MR
 CkVgX/wepbQgozgXEGFq4au/Dc4q1sfaXf+WXy/Lbo7tzSIelLM92pq+mBR2itEauv
 Nirek7BMEU81qp+2a4D2mzdx2z/IyqMPNrPriMRLmSyem7zq8kKsirGEdLH7o1FlRq
 z6mUkEh3eR+xpkM8UC72G03eK0ZBvmSuNzFhU1BUXYSQ3Kx9GQ0026Rdk77VkzCIZH
 qn2PUSaFZpu7w==
Message-ID: <sashiko-outbox-164597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/tegra: Support swapping chroma planes
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-tegra-drm-yvu420-v1-1-dc1c443c00f3@gmail.com>
References: <20261008-tegra-drm-yvu420-v1-0-dc1c443c00f3@gmail.com>
 <20261008-tegra-drm-yvu420-v1-1-dc1c443c00f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 21:09:33 +0000
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
- [Low] drm/tegra: uninitialized swap_uv field in tegra_plane_atomic_duplic=
ate_state
--

commit 7a6701643e457b2ef09eac11050804bd4c35f58d
Author: Aaron Kling <webgeek1234@gmail.com>

drm/tegra: Support swapping chroma planes

The Tegra display controller supports some yuv types, but not their
chroma swapped variants. For example, yuv420 is supported but yvu420 is
not. This can be efficiently worked around by just passing the hardware
said chroma planes backwards. Add a flag to the plane state struct and
handling to both tegradc and nvdisplay paths.

> diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
> index e33a581e6490e..dba5f1b254e98 100644
> --- a/drivers/gpu/drm/tegra/plane.h
> +++ b/drivers/gpu/drm/tegra/plane.h
> @@ -49,6 +49,7 @@ struct tegra_plane_state {
>  	struct tegra_bo_tiling tiling;
>  	u32 format;
>  	u32 swap;
> +	bool swap_uv;

[Severity: Low]
Does tegra_plane_atomic_duplicate_state() need to copy this new swap_uv fie=
ld?

In drivers/gpu/drm/tegra/plane.c:tegra_plane_atomic_duplicate_state(), the
state object is allocated without zero-initializing memory, and then
explicitly copies fields like format, swap, and reflect_x:

	copy->format =3D state->format;
	copy->swap =3D state->swap;
	copy->reflect_x =3D state->reflect_x;
	copy->reflect_y =3D state->reflect_y;

Because a corresponding copy->swap_uv =3D state->swap_uv assignment is omit=
ted,
copy->swap_uv contains uninitialized heap memory. While this is partially
mitigated because tegra_plane_atomic_check() recomputes swap_uv for active
planes, the uninitialized memory persists if the plane is disabled
(!new_plane_state->crtc), which violates the state duplication contract and
could risk undefined behavior if the state is inspected later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-tegra-drm-=
yvu420-v1-0-dc1c443c00f3@gmail.com?part=3D1
