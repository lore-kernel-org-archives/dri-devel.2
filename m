Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14073606A326
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWhSpSYw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D66112A40;
	Fri, 20 Nov 2026 13:14:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C41112A40
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:14:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E9AB42B1D
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58F71F000C6;
 Fri, 20 Nov 2026 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180484;
 bh=bjOWxH083jOdi6bi8rRC6QlUglBHBJIAo5CBpGI8Gws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dWhSpSYwNbOBBVYfEwNyzChuEEBCGayIZljQNIBVF6x+l7tXvczleXqdAbG7WJhDL
 cx3OlehnC/pfUhs/pplhWydMo+3kU9SRT+Gl9aJqFw0WQgtKLba5geTHJQfbZJjj3R
 csSdNM7agXIse5AObIWnjKdyzd9LHd0Pg5p4UqMQooKMg0a6Z+B7pRvF+/YKqGN1bR
 Ok42UR9/UGbbiOf6pT9LVyDHvRflZ3NsQxB3N3Q/EYQzf9oryrqShk4sG7yiVDIdWW
 fKUvccmvavq8IMMoReHu6AK93C1Iet0oye8CWBfkD/6x55N3A51r6mb5bxV++cY6T2
 fnUs/aCnHTkUQ==
Message-ID: <sashiko-outbox-225200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 24/42] drm/atomic-state-helper: Provide
 atomic_compare_state helpers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-24-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-24-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:14:43 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/atomic-state-helper: false mismatch on cropped plane src
  rect in compare
--

commit 2ca1ed51cdf19bd9781aa9d57f8d3b278be9993f
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-state-helper: Provide atomic_compare_state helpers

This commit adds default atomic state comparison helpers for planes, CRTCs,
connectors, and bridges to support post-commit hardware state readout
verification.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/=
gpu/drm/drm_atomic_state_readout_helper.c
> index 80eb467baefcf..d39d8e40f8947 100644
> --- a/drivers/gpu/drm/drm_atomic_state_readout_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
[ ... ]
> @@ -938,6 +939,396 @@ void drm_atomic_helper_sro_install_state(struct drm=
_atomic_sro_state *state)
[ ... ]
> +bool drm_atomic_helper_plane_compare_state(struct drm_plane *plane,
> +					   struct drm_printer *p,
> +					   struct drm_plane_state *expected,
> +					   struct drm_plane_state *actual)
> +{
[ ... ]
> +	/*
> +	 * NOTE: We can't check src_x and src_y: the source offsets are
> +	 * baked into the DMA base address and cannot be read back.
> +	 */
> +	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_w);
> +	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_h);
[ ... ]
> +	STATE_CHECK_PTR(ret, p, plane->name, expected, actual, color_pipeline);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.x1);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.x2);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.y1);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.y2);

[Severity: Medium]
Won't comparing src.{x1,x2,y1,y2} always report a false mismatch whenever a
plane is committed with a non-zero src_x or src_y?

drm_atomic_helper_check_plane_state() initializes expected->src from
drm_plane_state_src() with x1 =3D src_x, y1 =3D src_y, x2 =3D src_x + src_w=
, and
y2 =3D src_y + src_h before clipping.  Since src_x and src_y are baked into
the DMA base address and cannot be read back, actual->src read out from
hardware will be rooted at (0, 0) instead of (src_x, src_y).  In addition,
src.{x1,x2,y1,y2} are 16.16 fixed-point values, so STATE_CHECK_S32 prints
them as raw integers on mismatch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D24
