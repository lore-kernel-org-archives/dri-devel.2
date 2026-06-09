Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85A7CD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1983510E0EE;
	Tue,  9 Jun 2026 11:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d/iJco8e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9109D10E0EE
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 11:21:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B338601DC;
 Tue,  9 Jun 2026 11:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C851F00893;
 Tue,  9 Jun 2026 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781004101;
 bh=F1E+a/2FRLM00ky6l+DEunjH2UcYftAifgsatzZslk4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d/iJco8eI6TjLwzaiSr38qeLDrhr9MGf35lc8xmdemt8diXYTtuLyQ/PnWhN8JFMQ
 LwIjQkdf8k3ezWqyDGSVej48PvNmGpVkVzxA6apIb1aeJLOCC9H95AcXa06tx2+VO5
 uWBBcdO3VvOFRNWx4saq3bHAFrEPD44HhYln+QxBa1RFfEllpQcmCO4y3a9QDTxC76
 WybHOQl7ATp1LTNQv10aP5GdfB/nOa5toAiLWw7mHno6SYCeflkMuGkgIjl/ksvExQ
 Gqa3wkxaA9Qlyf8G7YFPogI2427swWFY+5urnBZmzKm5A+khXvAlAPD07VjdIGGGCM
 LGtkxLqM7kPFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] drm/atomic: track individual colorop updates
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609110420.1298352-4-mwen@igalia.com>
References: <20260609110420.1298352-4-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 11:21:40 +0000
Message-Id: <20260609112141.61C851F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `async_flip` validation for `DRM_MODE_OBJECT_COLOROP` allo=
ws colorop properties to be modified during async page flips, resulting in =
silently discarded updates.
- [High] Leaked `drm_property_blob` references in colorop state destruction.
--

commit e431074495b7fd11806af7e6be2bb0ec2ea72838
Author: Melissa Wen <mwen@igalia.com>

drm/atomic: track individual colorop updates

As we do for CRTC color mgmt properties, this commit uses the
color_mgmt_changed flag to track value changes in the color pipeline
of a given plane. This allows drivers to update color blocks as soon
as plane color pipeline or individual colorop values change.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index cd0fb5dc7d3ec..f799863c350c7 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
[ ... ]
> @@ -1271,8 +1296,10 @@ int drm_atomic_set_property(struct drm_atomic_stat=
e *state,
>  		break;
>  	}
>  	case DRM_MODE_OBJECT_COLOROP: {
> +		struct drm_plane_state *plane_state;
>  		struct drm_colorop *colorop =3D obj_to_colorop(obj);

[Severity: High]
This isn't a bug introduced by this patch, but does this block lack
validation for async_flip?

Unlike the blocks for planes, CRTCs, and connectors, there is no check for
async_flip here. If userspace submits an atomic commit with
DRM_MODE_PAGE_FLIP_ASYNC that modifies colorop properties, the ioctl
succeeds and modifies colorop_state inside the transaction.

However, drm_atomic_helper_async_commit() completely ignores colorops and
does not swap state->colorops. Could this lead to the updated state being
silently discarded and never applied to hardware, causing state divergence
between userspace expectations and kernel state?

>  		struct drm_colorop_state *colorop_state;
> +		bool replaced =3D false;
> =20
>  		colorop_state =3D drm_atomic_get_colorop_state(state, colorop);
>  		if (IS_ERR(colorop_state)) {


[Severity: High]
This is a pre-existing issue, but is there a leaked drm_property_blob
reference in colorop state destruction?

Looking at drm_colorop_atomic_destroy_state() in
drivers/gpu/drm/drm_colorop.c:

void drm_colorop_atomic_destroy_state(struct drm_colorop *colorop,
				      struct drm_colorop_state *state)
{
	kfree(state);
}

When an atomic state is committed or aborted, the atomic framework frees the
associated state objects by calling their respective destroy functions. This
function simply calls kfree(state) without dropping the reference to the da=
ta
blob (state->data) via drm_property_blob_put().

Because drm_atomic_helper_colorop_duplicate_state() explicitly increments t=
he
blob's reference count, and property setting acquires new blob references,
could failing to release the blob reference during state teardown lead to an
unbounded memory leak for every atomic update touching the color pipeline?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609110420.1298=
352-1-mwen@igalia.com?part=3D3
