Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33B1C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0641210F318;
	Fri, 21 Aug 2026 15:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dl9NAhFK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E75510F318
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:35:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA21E40566
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7F21F000E9;
 Fri, 21 Aug 2026 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787326520;
 bh=jLHNKbA99yECaUI/BMrcU0froAuN+E+u18PyFcTM2LA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dl9NAhFKd6Ullvue/DH02jSaKuaHLviHJWAuBzACtBivDQ7rHnWWJc8qb8Vq6hudC
 aTt+1HGP9AKUI2c2X3oPp8wUX5HQGnbbw36WyjrSVi/ZXDa+GXfrCLVNi3m4QciwD0
 cWMJ0nc1lFq1g1oQryulyiCk+YWEKO2VIWWy4iTfCzdUVYudJ5nfqKDnVYG/dyPqC5
 rrO7pqpWZZrlCCg5TpQDUANoU5JLUMHGBcp/Pfg/FWN4kuxh6yBj6jkclx+n74qoGq
 YdzrFw8zpSiAoxWuG2+jJfBStlDxQdRoctfr15D5R7tygoWVFFU+Uk2+tZJQi1pjJX
 TyhFFri5BRq2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 51/70] drm/loongson: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-51-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-51-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:35:20 +0000
Message-Id: <20260821153520.9D7F21F000E9@smtp.kernel.org>
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
- [Medium] Meaningful code and commit message mismatch regarding hardware r=
eset.
--

--- Patch [51]: [PATCH 51/70] drm/loongson: Convert to atomic_create_state =
---
commit 242c1e9da80c08d14806505d193ccb1acbb378d8
Author: Maxime Ripard <mripard@kernel.org>

drm/loongson: Convert to atomic_create_state

This commit converts the drm_crtc_funcs.reset hook to atomic_create_state f=
or the loongson driver. The change is made because the original hook only h=
andled state allocation and initialization without performing a hardware re=
set.

> The loongsoon crtc implementation provides a custom reset hook. However,
> this hook only allocates the state, initializes it with
> __drm_atomic_helper_crtc_reset(), and frees the previous state. It does
> not perform any hardware reset.
>=20
> Since the atomic_create_state hook is only meant to deal with state
> allocation and initialization, convert it accordingly. The hardware
> reset through ops->reset() is kept as part of the state creation
> since the core currently calls atomic_create_state in the same
> context where the reset hook was called.

[Severity: Medium]
Is the second paragraph of the commit message accurate for the loongson dri=
ver?

The first paragraph correctly notes that the original reset hook "does not
perform any hardware reset", but the second paragraph claims that "The
hardware reset through ops->reset() is kept". Since neither the old code nor
the new lsdc_crtc_create_state() function performs a hardware reset, could
this be a copy-paste error from another patch in the series?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D51
