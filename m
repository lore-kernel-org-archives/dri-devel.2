Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205F8C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 691DB10EF52;
	Thu, 20 Aug 2026 08:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WyLu+exO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DF710EF52
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:45:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83D53434FA;
 Thu, 20 Aug 2026 08:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBB21F000E9;
 Thu, 20 Aug 2026 08:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787215515;
 bh=wFFZr4TiBK4VeuVB2Xv/wX9V7dIIpeAA+1xM6qZpkPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WyLu+exOgyWHHC9a8FizP6qIb3afSGrQ42FkxQGv5A9joAv2FdQle38yTUv64/aXt
 HP5fO6K2xOXpiOcbZ9Eym2OuIurK4+3ColBd8/N2u6aiqnmkiTORnJbfaauF0t4olE
 XaoDeWZkxA01SkqFo2u0Ry85NS5wDeg3QEoGGKmu74ba3cXGhMvX1nZG20dEu3kmQH
 mV2FAf+f16v21VDOyrDxyejrYUdGuj/aqqXHQJcBmByGQM+WXaDG27QKKzVx/AHLL2
 a0nmew2VUBgSXYfhgAMca1t2WeAMVx6ns2Va460nJRkzlQiZz8JAP30Q2CYONMTgCx
 y+6wERz5mVHLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/vkms: Skip pre_blend_color_transform when
 pipeline is all bypassed
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820083123.544655-4-oushixiong1025@163.com>
References: <20260820083123.544655-1-oushixiong1025@163.com>
 <20260820083123.544655-4-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 08:45:14 +0000
Message-Id: <20260820084515.3DBB21F000E9@smtp.kernel.org>
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
- [High] The VKMS asynchronous composer worker accesses the global `colorop=
->state` directly without locking or using a snapshotted atomic state, lead=
ing to Use-After-Free (UAF) and screen tearing.
--

--- Patch [2]: [PATCH 2/2] drm/vkms: Skip pre_blend_color_transform when pi=
peline is all bypassed ---
commit 8ff3a905b0e8440dde34c1e49a7de87eb5e0a637
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/vkms: Skip pre_blend_color_transform when pipeline is all bypassed

This commit skips the per-pixel unpacking and processing loop in
pre_blend_color_transform() when the color pipeline is completely empty
or all color operations are bypassed. It adds a pipeline_all_bypassed()
helper to check the bypass state.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index f3fb203946e83..1806c249da6fc 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
[ ... ]
> @@ -190,13 +190,29 @@ static void apply_colorop(struct pixel_argb_s32 *pi=
xel, struct drm_colorop *colo
>  	}
>  }
> =20
> +static bool pipeline_all_bypassed(struct drm_colorop *colorop)
> +{
> +	while (colorop) {
> +		struct drm_colorop_state *colorop_state =3D colorop->state;

[Severity: High]
This is a pre-existing issue, but does accessing the global colorop->state
locklessly in the async composer worker risk a use-after-free?

If the composer worker reads colorop->state while userspace queues new
non-blocking commits, the following sequence seems possible:

1. The composer worker reads colorop->state (pointing to commit C2's state).
2. The worker is preempted.
3. Userspace queues another commit (C3), making C2 the old state.
4. C3 finishes its tail work and frees C2's state via cleanup_planes().
5. The preempted worker resumes and dereferences the now-freed C2 state.

The existing per-pixel loop in pre_blend_color_transform() in vkms_composer=
.c
already reads colorop->state directly, so this architectural flaw is
pre-existing. However, this new pipeline_all_bypassed() helper repeats the
pattern. Should the worker be using a snapshotted atomic state instead of
reading the global colorop->state?

> +
> +		if (!colorop_state || !colorop_state->bypass)
> +			return false;
> +		colorop =3D colorop->next;
> +	}
> +	return true;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820083123.5446=
55-1-oushixiong1025@163.com?part=3D2
