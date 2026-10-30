Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526F606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOb6zsoE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDCA10E48B;
	Fri, 30 Oct 2026 13:45:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303F210E48B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:45:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E147E40163;
 Fri, 30 Oct 2026 13:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82031F000C1;
 Fri, 30 Oct 2026 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793367922;
 bh=09y08Q9Y9BZQ0nkW0NvhxbsfTMAxo13TTiEHuW6Ap9w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hOb6zsoEGeIZfNBpS4cWncR+YztnqY6KdOglpqxI0/EWb9HloaE0jhwqHm+JVapAq
 6y788ic1wCEooO5DG7XcZOoW5vmJqvhQlqVXjgrGO2sQidj5Iv5UamC0IAMDj/yPGK
 3YVHDyTKJF4XtlAc7Sfd2I62WYpY+8dXBOiNaLMdIw6CGYwz0E0Eyrhkms7ahYH3UN
 N61IRhLJUM4FLzH1TcsyCtmhWIWDchKdd0jVwH3RPhi2VjRvj4bchK8Oybkv+Jv839
 SwcILZklOcxkpk57pUXXIwpKzlDwcM+IizB9a/nPDMeopQRvsBjOMnBik8V3chWjUX
 01UmHMtxsYjZw==
Message-ID: <sashiko-outbox-191080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 3/3] drm/verisilicon: stop to reuse
 atomic_disable for invisible planes
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030133233.197189-4-zhengxingda@iscas.ac.cn>
References: <20261030133233.197189-1-zhengxingda@iscas.ac.cn>
 <20261030133233.197189-4-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 13:45:22 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] drm/verisilicon: uninitialized dc and output in plane atomic_u=
pdate()
- [High] drm/verisilicon: plane visibility state mismatch with atomic_enabl=
e()
--

commit 3080d00108f48782cd8c1c8ee016e9473b324e57
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/verisilicon: stop to reuse atomic_disable for invisible planes

This commit factors out helper functions to disable cursor and primary
planes directly from their atomic_update callbacks when state->visible is
false, avoiding a NULL CRTC dereference in the old plane state when calling
atomic_disable.

> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/=
drm/verisilicon/vs_cursor_plane.c
> index 1fa6b7578b27e..8dd6caadb7075 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> @@ -99,6 +99,15 @@ static void vs_cursor_plane_commit(struct vs_dc *dc, u=
nsigned int output)
>  			VSDC_CURSOR_CONFIG_IMG_UPDATE);
>  }
> =20
> +static void vs_cursor_plane_disable(struct vs_dc *dc, unsigned int outpu=
t)
> +{
> +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +			   VSDC_CURSOR_CONFIG_FMT_MASK,
> +			   VSDC_CURSOR_CONFIG_FMT_OFF);
> +
> +	vs_cursor_plane_commit(dc, output);
> +}
> +
>  static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
>  					   struct drm_atomic_commit *atomic_state)
>  {
> @@ -126,11 +135,7 @@ static void vs_cursor_plane_atomic_disable(struct dr=
m_plane *plane,
>  	unsigned int output =3D vcrtc->id;
>  	struct vs_dc *dc =3D vcrtc->dc;
> =20
> -	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> -			   VSDC_CURSOR_CONFIG_FMT_MASK,
> -			   VSDC_CURSOR_CONFIG_FMT_OFF);
> -
> -	vs_cursor_plane_commit(dc, output);
> +	vs_cursor_plane_disable(dc, output);
>  }
> =20
>  static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
> @@ -146,7 +151,7 @@ static void vs_cursor_plane_atomic_update(struct drm_=
plane *plane,
>  	dma_addr_t dma_addr;
> =20
>  	if (!state->visible) {
> -		vs_cursor_plane_atomic_disable(plane, atomic_state);
> +		vs_cursor_plane_disable(dc, output);
>  		return;
>  	}

[Severity: Critical]
Does vs_cursor_plane_atomic_update() pass uninitialized dc and output values
to vs_cursor_plane_disable() when !state->visible is true?

In drivers/gpu/drm/verisilicon/vs_cursor_plane.c, vcrtc, output, and dc are
only initialized from state->crtc after the !state->visible early return:

drivers/gpu/drm/verisilicon/vs_cursor_plane.c:vs_cursor_plane_atomic_update=
() {
	struct drm_crtc *crtc =3D state->crtc;
	struct vs_dc *dc;
	struct vs_crtc *vcrtc;
	unsigned int output;
	dma_addr_t dma_addr;

	if (!state->visible) {
		vs_cursor_plane_disable(dc, output);
		return;
	}

	vcrtc =3D drm_crtc_to_vs_crtc(crtc);
	output =3D vcrtc->id;
	dc =3D vcrtc->dc;
}

When a cursor plane is updated while invisible, vs_cursor_plane_disable()
will dereference the uninitialized pointer dc->regs and index
VSDC_CURSOR_CONFIG(output) with an uninitialized output variable.

[Severity: High]
How does disabling the plane in hardware on !state->visible interact with
vs_cursor_plane_atomic_enable() and subsequent visible updates?

In drm_atomic_helper_commit_planes(), funcs->atomic_update() runs before
funcs->atomic_enable(). When a previously unbound plane (old_plane_state->c=
rtc
is NULL) is bound to a CRTC while invisible (new_plane_state->crtc is
non-NULL and new_plane_state->visible is false):

1. vs_cursor_plane_atomic_update() calls vs_cursor_plane_disable() and
   returns early without programming VSDC_CURSOR_ADDRESS(output), size, or
   position registers.
2. drm_atomic_plane_enabling() evaluates to true because !old_plane_state->=
crtc
   && new_plane_state->crtc, so drm_atomic_helper_commit_planes() immediate=
ly
   calls vs_cursor_plane_atomic_enable():

drivers/gpu/drm/verisilicon/vs_cursor_plane.c:vs_cursor_plane_atomic_enable=
() {
	...
	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
			   VSDC_CURSOR_CONFIG_FMT_MASK,
			   VSDC_CURSOR_CONFIG_FMT_ARGB8888);

	vs_cursor_plane_commit(dc, output);
}

Won't vs_cursor_plane_atomic_enable() unconditionally re-enable the plane in
hardware without a valid framebuffer address or geometry configured?

Conversely, if a plane that is already bound to a CRTC moves off-screen so
state->visible becomes false, vs_cursor_plane_atomic_update() sets
VSDC_CURSOR_CONFIG_FMT_OFF via vs_cursor_plane_disable(). When a later comm=
it
moves the plane back on-screen while remaining on the same CRTC
(old_plane_state->crtc and new_plane_state->crtc are both non-NULL, and
new_plane_state->visible becomes true), drm_atomic_plane_enabling() is fals=
e,
so vs_cursor_plane_atomic_enable() is not called and
vs_cursor_plane_atomic_update() never restores VSDC_CURSOR_CONFIG_FMT_ARGB8=
888.
Will the cursor plane remain disabled in hardware?

> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu=
/drm/verisilicon/vs_primary_plane.c
> index c12fe54096c33..56e4c0e168871 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -60,6 +60,14 @@ static void vs_primary_plane_commit(struct vs_dc *dc, =
unsigned int output)
>  			VSDC_FB_CONFIG_EX_COMMIT);
>  }
> =20
> +static void vs_primary_plane_disable(struct vs_dc *dc, unsigned int outp=
ut)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +			  VSDC_FB_CONFIG_EX_FB_EN);
> +
> +	vs_primary_plane_commit(dc, output);
> +}
> +
>  static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
>  					   struct drm_atomic_commit *atomic_state)
>  {
> @@ -89,10 +97,7 @@ static void vs_primary_plane_atomic_disable(struct drm=
_plane *plane,
>  	unsigned int output =3D vcrtc->id;
>  	struct vs_dc *dc =3D vcrtc->dc;
> =20
> -	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			  VSDC_FB_CONFIG_EX_FB_EN);
> -
> -	vs_primary_plane_commit(dc, output);
> +	vs_primary_plane_disable(dc, output);
>  }
> =20
>  static void vs_primary_plane_atomic_update(struct drm_plane *plane,
> @@ -109,7 +114,7 @@ static void vs_primary_plane_atomic_update(struct drm=
_plane *plane,
>  	dma_addr_t dma_addr;
> =20
>  	if (!state->visible) {
> -		vs_primary_plane_atomic_disable(plane, atomic_state);
> +		vs_primary_plane_disable(dc, output);
>  		return;
>  	}

[Severity: Critical]
Similarly, in drivers/gpu/drm/verisilicon/vs_primary_plane.c, doesn't
vs_primary_plane_atomic_update() also call vs_primary_plane_disable(dc,
output) before vcrtc, output, and dc are initialized from state->crtc,
dereferencing uninitialized dc->regs and using an uninitialized output index
in VSDC_FB_CONFIG_EX(output) when !state->visible?

[Severity: High]
Does vs_primary_plane_atomic_update() have the same state mismatch with
vs_primary_plane_atomic_enable()?

When old_plane_state->crtc is NULL, new_plane_state->crtc is non-NULL, and
new_plane_state->visible is false, vs_primary_plane_atomic_update() returns
early without programming VSDC_FB_ADDRESS(output) or geometry registers, and
then vs_primary_plane_atomic_enable() sets VSDC_FB_CONFIG_EX_FB_EN and
commits the plane in hardware anyway.

And if an already-bound primary plane transitions from visible to invisible
(clearing VSDC_FB_CONFIG_EX_FB_EN in vs_primary_plane_disable()) and then
back to visible on the same CRTC, neither vs_primary_plane_atomic_enable()
nor vs_primary_plane_atomic_update() sets VSDC_FB_CONFIG_EX_FB_EN again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030133233.1971=
89-1-zhengxingda@iscas.ac.cn?part=3D3
