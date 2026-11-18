Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F80606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOe8egUr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9231E10FF9F;
	Wed, 18 Nov 2026 19:10:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083DE10FF9F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:10:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 110586388B;
 Wed, 18 Nov 2026 19:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EF41F000C9;
 Wed, 18 Nov 2026 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795029018;
 bh=R6Tp7kKIvhdbaRF+7wpHNKaBa531RGNxsU9Lhrw7REQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oOe8egUrBSI73m73VOeA0BJNqNIcBr6nI+lWV0ac1ERoeh3BJnCt9jtsCaW2YacaM
 9tU0i1uDKMqxocZcH3g3xtDHOWaBBVASw0wqVEl7qto/aUGsf6577ydkaWn9AlG7Ln
 J9WMYpL6lTQm9o964exCRTW8jG72O0spJ9w3Bml1CgXEN4ejwtlbUQgCoD42p0TbO8
 WNCRhYRRmaoyxG5YLj/1ZKKcEMwo/D1zgUKX0lsiJ0j/SWXvthfdpeEkLaOs//V9B2
 CYEhjGTuF2KuRxkVCkmzUZ4B0HlfBOBtvsUk2vNKCphMGyMWOQm9x8nevgiwyJj2w9
 wNwIL5g4+RjFA==
Message-ID: <sashiko-outbox-221824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC] drm/msm/dpu: set possible_crtcs on cursor planes
To: "Erik Tagirov" <erik@tagirov.ch>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <av4OfY5sML97l2F_@oasis>
References: <av4OfY5sML97l2F_@oasis>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 19:10:18 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/msm/dpu: missing Signed-off-by trailer and email text in
  commit message
- [Medium] drm/msm/dpu: restricting cursor possible_crtcs starves higher
  CRTCs of cursors
- [Low] drm/msm/dpu: missing Fixes trailer for cursor plane
  possible_crtcs bug
--

commit ca8af36e450982d481b162e2cd26c19bfc3c443d
Author: Erik Tagirov <erik@tagirov.ch>

> drm/msm/dpu: set possible_crtcs on cursor planes
>
> I am using a lesser known wayland compositor that uses the possible_crtcs=
 field of a plane to detect
> which one to use for the cursor. On the Lenovo T14s two cursor planes are=
 created, each with possible_crtcs set
> to 0xff. Which from my understanding means that they can be used with any=
 crtc.
>
> However, the compositor picks the wrong cursor plane which results in a l=
ag of ~17ms
> on each DRM_IOCTL_MODE_SETPLANE call. Making the cursor movements sluggis=
h.
>
> After some investigation, I found out that this is due to the legacy_curs=
or_update flag not being set
> in drm_atomic_helper_update_plane() which has an impact in msm_atomic_com=
mit_tail() where the fallback branch
> is taken.
>
> The lag is solved with the patch below.
>
> Best regards
> - Erik Tagirov
>
> The cursor plane must be used with the correct crtc to ensure an
> asynchronous commit

[Severity: High]
This commit is missing a Signed-off-by: trailer from the patch author to
certify the Developer's Certificate of Origin.  The commit message also
retains conversational email sign-off text ("The lag is solved with the
patch below. Best regards - Erik Tagirov") followed by a trailing sentence
fragment that should be folded into the commit description.

[Severity: Low]
This fixes the cursor plane possible_crtcs mask set when cursor planes
were enabled on DPU.  Should this include:

  Fixes: 07ca1fc0f8a0 ("drm/msm/dpu: enable cursor plane on dpu")

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
> index 1b6286dccfc00..ae14e146ec112 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -877,6 +877,9 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_=
kms)
>  			ret =3D PTR_ERR(crtc);
>  			return ret;
>  		}
> +		/* Ensure that cursor planes are commited asynchronously */
> +		if (cursor_planes[i])
> +			cursor_planes[i]->possible_crtcs =3D drm_crtc_mask(crtc);
>  	}

[Severity: Medium]
Does restricting cursor_planes[i]->possible_crtcs to drm_crtc_mask(crtc)
prevent higher-numbered CRTCs from using any hardware cursor plane?

Earlier in _dpu_kms_drm_obj_init(), DRM_PLANE_TYPE_CURSOR planes are only
created for catalog SSPPs that have BIT(DPU_SSPP_CURSOR) set:

drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:_dpu_kms_drm_obj_init() {
    ...
		if ((catalog->sspp[i].features & BIT(DPU_SSPP_CURSOR))
			&& cursor_planes_idx < max_crtc_count)
			type =3D DRM_PLANE_TYPE_CURSOR;
    ...
}

Across the DPU hardware catalogs, at most 1 or 2 SSPPs set
DPU_SSPP_CURSOR (for example, X1E80100 on the Lenovo T14s defines 2
cursor SSPPs, while max_crtc_count can be up to 5), so cursor_planes[i] is
NULL for i >=3D cursor_planes_idx.  Because DPU SSPPs (and virtual planes
when dpu_use_virtual_planes is enabled) can be routed to any CRTC's Layer
Mixer, pinning the 1 or 2 cursor planes exclusively to CRTC 0 and CRTC 1
causes __setplane_check() and drm_atomic_plane_check() to reject attaching
a cursor plane to any CRTC with index >=3D cursor_planes_idx, even when
CRTC 0 and CRTC 1 are disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/av4OfY5sML97l2F_@oa=
sis?part=3D1
