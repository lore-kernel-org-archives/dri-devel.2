Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2440FCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F2B10EC96;
	Mon, 12 Oct 2026 04:51:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF59F10EC96;
 Mon, 12 Oct 2026 04:51:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 956C643BE5;
 Mon, 12 Oct 2026 04:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548871F0089B;
 Mon, 12 Oct 2026 04:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780674;
 bh=QDVeJ7g6n3+iEf/AfmJOAjovSZO1c6LMDDabTDsUtxw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ShlUnfeORoIvJDWP9kWanCYZhiuTJha+xsTahIFj6I1oh6WyrpAdktWC9vJDiVNbZ
 5Rlh+BeVz1dqZXZEiM+u6SVeScXIVNSx9zvf/pwLh+dNbH3m75diLLXtBKAAQJi82w
 GJNH5u5+HvvNmpuVUVYMdx+GI+ymQoNAd8keWwi+VXv29ruOBrWdUEYdkUBHxTyuF+
 RHrl/t2gwimOkIBV9ruXyzWzytfhOBgsCnthAUGwbzKtf2VKlZ4vc3BP5K07xwb36x
 pt3NAzMyFsFHIczAKwSzadYCUnkbPsuYFyw8VYn74u9ZWOeHY8T5zvBVRkXPOMzVJU
 DHvIHOfqcYTkw==
Message-ID: <sashiko-outbox-167634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 53/56] drm/i915/joiner: Move joiner pipe mask helper
 to intel_joiner.c
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-54-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-54-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:51:14 +0000
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
- [Low] refactor: duplicate intel_joiner_valid_primary_pipe_mask() declarat=
ion
--

commit 8219a04938cb40be1f657190cac49de622685e24
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/joiner: Move joiner pipe mask helper to intel_joiner.c

This commit moves the intel_joiner_valid_primary_pipe_mask() helper and
its dependencies from intel_display.c to intel_joiner.c to group joiner
functionality together. It also adds the function declaration to
intel_joiner.h.

> diff --git a/drivers/gpu/drm/i915/display/intel_joiner.h b/drivers/gpu/dr=
m/i915/display/intel_joiner.h
> index 85e19ed1527f5..962b9724c1126 100644
> --- a/drivers/gpu/drm/i915/display/intel_joiner.h
> +++ b/drivers/gpu/drm/i915/display/intel_joiner.h
> @@ -22,4 +22,6 @@ bool intel_joiner_candidate_valid(struct intel_connecto=
r *connector,
>  	for ((__num_joined_pipes) =3D 1; (__num_joined_pipes) <=3D (I915_MAX_PI=
PES); (__num_joined_pipes)++) \
>  		for_each_if(intel_joiner_candidate_valid(__connector, (__mode)->hdispl=
ay, __num_joined_pipes))
> =20
> +u8 intel_joiner_valid_primary_pipe_mask(struct intel_display *display, i=
nt num_joined_pipes);
> +

[Severity: Low]
This isn't a bug, but should the existing declaration of
intel_joiner_valid_primary_pipe_mask() in intel_display.h also be removed?

When this function was moved to intel_joiner.c, a new declaration was added
here, but the original prototype was left behind in intel_display.h. This
creates a duplicate function prototype. Callers in intel_display.c might
continue to compile by implicitly relying on the stale declaration instead
of properly including intel_joiner.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D53
