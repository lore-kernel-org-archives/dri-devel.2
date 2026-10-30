Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8212606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vm9H4rfB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F1A10E25A;
	Fri, 30 Oct 2026 13:43:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368BC10E25A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:43:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0477643AE9;
 Fri, 30 Oct 2026 13:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC8C1F000C1;
 Fri, 30 Oct 2026 13:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793367825;
 bh=Cptkbi4FwLUv2rOjxk1WA4VwTjAXE3k1tKKauF7Mkzo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vm9H4rfBjorSEdTS7Qjk5NrweZcdRirXIsOH42L8NoTLQBDbYkC1fsGxy/lH3f5Fc
 uG9LlgMmsPp7kWPgeWBkuAE80ukdsDVsu844iS2FubnV3G84jcGvbhpKMn89Hk9Evw
 h72LNR0EFjPQo5rKncTxpSSwba0bTTw0GNuFX4nkvrlG/phkrw55MFNZ9k0LJ0LbCi
 ZqKrL3gBzyZCGPp2utqQPfdFh3TUxlAQ1f7UPqMmJ05dhZZIkNf62SLE4h1QmqNcBi
 nQnilRT79UEaqTZ+cALg3/Wsd1yAcy0Q+y1r6Awkg20YDYevhZMlf/tQ/Gnx/GRwmQ
 BRdLN8pgGlPdQ==
Message-ID: <sashiko-outbox-191078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 1/3] drm/verisilicon: fix DC8200 primary plane
 disable clearing FB_EN
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030133233.197189-2-zhengxingda@iscas.ac.cn>
References: <20261030133233.197189-1-zhengxingda@iscas.ac.cn>
 <20261030133233.197189-2-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 13:43:45 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/verisilicon: vs_primary_plane_atomic_disable() misuse on invis=
ible plane
--

commit b5d25e699c72e0d03ee4c0a85f55bde0b05d2253
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: fix DC8200 primary plane disable clearing FB_EN

This commit changes vs_primary_plane_atomic_disable() to call
regmap_clear_bits() instead of regmap_set_bits() on VSDC_FB_CONFIG_EX_FB_EN
when disabling the primary plane.

> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu=
/drm/verisilicon/vs_primary_plane.c
> index 95f4a06039e76..c12fe54096c33 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -89,8 +89,8 @@ static void vs_primary_plane_atomic_disable(struct drm_=
plane *plane,
>  	unsigned int output =3D vcrtc->id;
>  	struct vs_dc *dc =3D vcrtc->dc;
> =20
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_FB_EN);
> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +			  VSDC_FB_CONFIG_EX_FB_EN);
> =20
>  	vs_primary_plane_commit(dc, output);
>  }

[Severity: High]
Now that vs_primary_plane_atomic_disable() clears VSDC_FB_CONFIG_EX_FB_EN, =
can
calling it from vs_primary_plane_atomic_update() when !state->visible leave
VSDC_FB_CONFIG_EX_FB_EN permanently cleared when the plane becomes visible
again on the same CRTC?

In drivers/gpu/drm/verisilicon/vs_primary_plane.c,
vs_primary_plane_atomic_update() handles invisible planes by calling
vs_primary_plane_atomic_disable():

	if (!state->visible) {
		vs_primary_plane_atomic_disable(plane, atomic_state);
		return;
	}

When a primary plane is already attached to a CRTC (old_plane_state->crtc !=
=3D
NULL) and transitions from visible to !visible (for example, when the CRTC =
is
disabled while the plane stays attached, which vs_primary_plane_atomic_chec=
k()
allows via can_update_disabled =3D true), vs_primary_plane_atomic_update() =
calls
vs_primary_plane_atomic_disable() and clears VSDC_FB_CONFIG_EX_FB_EN.

When that plane later transitions back from !visible to visible on the same
CRTC (old_plane_state->crtc !=3D NULL && new_plane_state->crtc !=3D NULL),
drm_atomic_helper_commit_planes() calls vs_primary_plane_atomic_update() and
checks drm_atomic_plane_enabling(old_plane_state, new_plane_state), which o=
nly
tests (!old_plane_state->crtc && new_plane_state->crtc). Because
old_plane_state->crtc is non-NULL, vs_primary_plane_atomic_enable() is not
called, and vs_primary_plane_atomic_update() never sets
VSDC_FB_CONFIG_EX_FB_EN:

static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
					   struct drm_atomic_commit *atomic_state)
{
	...
	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
			VSDC_FB_CONFIG_EX_FB_EN);

Conversely, if a previously disabled plane (old_plane_state->crtc =3D=3D NU=
LL) is
attached to a CRTC with new_plane_state->visible =3D=3D false:

1. vs_primary_plane_atomic_update() calls vs_primary_plane_atomic_disable(),
   which looks up old_plane_state via drm_atomic_get_old_plane_state() and
   dereferences state->crtc (NULL) via vcrtc->id and vcrtc->dc:

	struct drm_plane_state *state =3D drm_atomic_get_old_plane_state(atomic_st=
ate,
								       plane);
	struct drm_crtc *crtc =3D state->crtc;
	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
	unsigned int output =3D vcrtc->id;
	struct vs_dc *dc =3D vcrtc->dc;

2. drm_atomic_helper_commit_planes() then sees drm_atomic_plane_enabling() =
=3D=3D
   true and calls vs_primary_plane_atomic_enable(), setting
   VSDC_FB_CONFIG_EX_FB_EN and committing the plane even though
   vs_primary_plane_atomic_update() returned early without programming
   VSDC_FB_ADDRESS, VSDC_FB_STRIDE, or VSDC_FB_SIZE.

Commit 3080d00108f4 ("drm/verisilicon: stop to reuse atomic_disable for
invisible planes") later in the series replaces the
vs_primary_plane_atomic_disable() call in vs_primary_plane_atomic_update()
with vs_primary_plane_disable(dc, output), but calls it before dc and output
are initialized and still leaves VSDC_FB_CONFIG_EX_FB_EN cleared after a
!visible to visible transition on the same CRTC (and enabled on an initial
!visible attach).

Should VSDC_FB_CONFIG_EX_FB_EN and VSDC_FB_CONFIG_EX_DISPLAY_ID instead be
managed in vs_primary_plane_atomic_update() based on state->visible rather
than in a separate atomic_enable callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030133233.1971=
89-1-zhengxingda@iscas.ac.cn?part=3D1
