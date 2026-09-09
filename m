Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F33CC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C73A10F126;
	Wed,  9 Sep 2026 12:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GFp4wp3S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A07910F126
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:50:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25ACA406CF;
 Wed,  9 Sep 2026 12:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37BC1F00A3A;
 Wed,  9 Sep 2026 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788958212;
 bh=kwOgTbt16/wNGRvPWiDHy9D4g3X2PThLHC+BNn3lcGo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GFp4wp3SkaeP2BqvNi4AZRNFf1vUIdm0/11pOmqnxK4H7JxhbyR1wItafLKC4I7gg
 JINuGEopcbBpCdSAl794Ih25Z/QTkmlGiaXeMr5EzAzBfVOFp5D0VVcvJESk+dTIH2
 j89IiQi4fMw5BFAtqs9STp8fuYq0p6oFDURivYC1rxMzqYx5CfogPalind079PfpbB
 4y3D7GjJw7pDLe0rEJad73tlJFZPFQEwOrxMRV81hkyrRHdJniJcjn6BZHNXGJF/Ks
 wO5jKyUqKMqjL5917HoAKS9+YZ0J87R+HSMJRYdXoXqiN9F/3aMWu7T75N7xRjumD2
 v8RP2vu94XX6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/tiny: arcpgu: Replace simple display pipe with
 regular atomic helpers
To: "Davide Bonatto" <bonatto.davide@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909124108.168371-1-bonatto.davide@gmail.com>
References: <20260909092455.131962-1-bonatto.davide@gmail.com>
 <20260909124108.168371-1-bonatto.davide@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 12:50:11 +0000
Message-Id: <20260909125011.D37BC1F00A3A@smtp.kernel.org>
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
- [High] NULL pointer dereference in `arc_pgu_crtc_atomic_check` due to imp=
roper plane state retrieval API.
--

commit 80a9a4e01830c51d120962eff87086ac506b2424
Author: Davide Bonatto <bonatto.davide@gmail.com>

drm/tiny: arcpgu: Replace simple display pipe with regular atomic helpers
   =20
This commit migrates the arcpgu driver from the deprecated simple display p=
ipe
helpers to explicitly managing individual plane, CRTC, and encoder objects
using standard atomic helpers.

> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index c93d61ac0bb75..adda406927332 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c

[ ... ]

> @@ -189,54 +203,133 @@ static void arc_pgu_mode_set(struct arcpgu_drm_pri=
vate *arcpgu)

[ ... ]

> +static int arc_pgu_crtc_atomic_check(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crct_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	struct arcpgu_drm_private *arcpgu =3D crtc_to_arcpgu_priv(crtc);
> +	struct drm_plane_state *plane_state;
> +
> +	if (!crct_state->enable)
> +		return 0;
> +
> +	plane_state =3D drm_atomic_get_new_plane_state(state, &arcpgu->plane);
> +	if (IS_ERR(plane_state))
> +		return PTR_ERR(plane_state);
> +

[Severity: High]
Can this result in a NULL pointer dereference during partial atomic commits?

When an atomic commit updates a CRTC property but does not modify the plane
and does not trigger a modeset, the plane might not be added to the atomic
state. In that case, drm_atomic_get_new_plane_state() returns NULL, not an
ERR_PTR.

Because IS_ERR(NULL) evaluates to false, the error check is bypassed, and
evaluating !plane_state->fb will dereference the NULL pointer. Should this
use drm_atomic_get_plane_state() instead, which safely attaches the plane to
the commit and returns an ERR_PTR on failure, or alternatively check for
NULL before dereferencing?

> +	if (!plane_state->fb)
> +		return -EINVAL;
> +
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909124108.1683=
71-1-bonatto.davide@gmail.com?part=3D1
