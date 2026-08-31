Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF435C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BEFA10E340;
	Mon, 31 Aug 2026 22:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mhwwJTz4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02D210E340
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 22:39:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A44340350;
 Mon, 31 Aug 2026 22:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049AE1F000E9;
 Mon, 31 Aug 2026 22:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788215976;
 bh=Hsy9qGm17h6phI4jhB7PGMVQJlssPMud6DVlvMPsKSA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mhwwJTz4rZ8gQh9H0yQEXw01Ejqf8J75mXtMVhuStNis/C1QLaQRdZ6ZGXPfK9NAJ
 XeHFcwusvCuWHeqQ2DeganuqbnbtIM7OwzP8h9/6B5zRiLBAfab5E9dB1EFHYpqSo1
 4sxKeU737pU+uf0WY1jM9CGm4m4TGKfPVp8C2H5SWbAYdNp8C1CTWYlp1XHWibTl3f
 WhpuKe8aJy6YvgZLefi2VMZGHg5DcB5EjKzYosEbPuNUfqq0VFJZTYBIQ0SkESLeCR
 xysPPRIF6St4ZKcYZDXwHNpoxN8DD0JMcx0UavmkNl2/FYR9cI+HiGqc2rKqLPgm0i
 WSapHcFo2bFlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 35/40] drm/rz-du: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-35-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-35-1877c7aa57b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:39:35 +0000
Message-Id: <20260831223936.049AE1F000E9@smtp.kernel.org>
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
- [High] Invalid pointer dereference on initialization error path due to in=
correct list iterator usage.
--

commit 3bffdb77add6a2ca9d3e5bb1dea2bfe6e12b39b0
Author: Maxime Ripard <mripard@kernel.org>
Subject: drm/rz-du: Convert to atomic_create_state

This commit converts the plane reset implementation to use atomic_create_st=
ate
by creating a pristine state without resetting hardware. The conversion was
done using a Coccinelle semantic patch.

> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/d=
rm/renesas/rz-du/rzg2l_du_vsp.c
> index 1efa0f0451fe9..944bc9ac9589d 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> @@ -266,26 +266,23 @@ static void rzg2l_du_vsp_plane_atomic_destroy_state=
(struct drm_plane *plane,

[ ... ]

>  static const struct drm_plane_funcs rzg2l_du_vsp_plane_funcs =3D {
>  	.update_plane =3D drm_atomic_helper_update_plane,
>  	.disable_plane =3D drm_atomic_helper_disable_plane,
> -	.reset =3D rzg2l_du_vsp_plane_reset,
> +	.atomic_create_state =3D rzg2l_du_vsp_plane_create_state,
>  	.atomic_duplicate_state =3D rzg2l_du_vsp_plane_atomic_duplicate_state,
>  	.atomic_destroy_state =3D rzg2l_du_vsp_plane_atomic_destroy_state,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a pre-existing issue in rzg2l_du_vsp_get_drm_plane():

drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c:rzg2l_du_vsp_get_drm_plane() {
	...
	struct drm_plane *plane =3D NULL;

	drm_for_each_plane(plane, &rcdu->ddev) {
		struct rzg2l_du_vsp_plane *vsp_plane =3D to_rzg2l_vsp_plane(plane);

		if (vsp_plane->index =3D=3D pipe_index)
			break;
	}

	return plane ? plane : ERR_PTR(-EINVAL);
}

Is it possible for drm_for_each_plane() to finish without finding a match?

Since drm_for_each_plane() is a wrapper around list_for_each_entry(), the l=
oop
iterator "plane" is not set to NULL when the list is exhausted. If no match
is found (e.g., if vsp_plane->index =3D=3D pipe_index is never true), the l=
oop
terminates without a break, leaving "plane" containing an invalid pointer
derived from the list head offset.

The ternary check "plane ? plane : ERR_PTR(-EINVAL)" will then evaluate to
true and return this invalid pointer instead of the error. This invalid poi=
nter
could then be dereferenced during initialization on the error path by
drmm_crtc_init_with_planes(), leading to memory corruption or a kernel cras=
h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-plane-reset-v3-0-1877c7aa57b3@kernel.org?part=3D35
