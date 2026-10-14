Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91957CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 22:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D2710EB60;
	Wed, 14 Oct 2026 22:39:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A22110EB60
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 22:39:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73E636020C;
 Wed, 14 Oct 2026 22:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EF61F000C4;
 Wed, 14 Oct 2026 22:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792017568;
 bh=ad6cNbqHt/sc3BRCYB+827CEAISwAiORnHy2KBYihYo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZvmC71JJUFuMyLV4v4W0oc3YOQhXQrX/ksI7rutaJMG5ArmKMHcOAoz9PvAhREIJV
 24SzQ61pXXYKlT4Fs+e4j/WmI8Fskd09MA9VHQCyinYhhJyk8vi2A1JxQ9kM9Mdm+t
 vnV6AO4tE/3KKGcAP2b7oCDuhDfqNE7vRec6T2O64TvobWCJePdhPJ/MAFwCQVcyrP
 o8qUDhu0aU3EBGQtDwC8or87BzGWBj3Gk0s/fetU0YhRj+vAV8Xi6HrTEMMLN6jcJu
 +/YXA+pcK9EniKAozn1MwaRqXza4gEZ5xvxbn546nCf4hpXCqYl7W+kdFoel5RhdMO
 46HLLS4k8LNcg==
Message-ID: <sashiko-outbox-171985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: Fall back to the native mode, not
 the first, on eDP/LVDS
To: "Hugo Sales" <hugo@hsal.es>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014223041.171317-2-hugo@hsal.es>
References: <20261014223041.171317-1-hugo@hsal.es>
 <20261014223041.171317-2-hugo@hsal.es>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 22:39:27 +0000
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
- [Medium] drm: uninitialized stack memory read in create_stream_for_sink()
--

commit c9acc168fa3f685b9a0bbaf87f6642a89b782aef
Author: Hugo Sales <hugo@hsal.es>
drm/amd/display: Fall back to the native mode, not the first, on eDP/LVDS

This commit updates create_stream_for_sink() to fall back to the native
mode stored in the encoder when the preferred mode is no longer present
in the connector's mode list. This is limited to eDP and LVDS panels where
amdgpu handles scaling automatically.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5983

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 428a5f9377c62..a1dc3e28764cf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1470,6 +1472,7 @@ create_stream_for_sink(struct drm_connector *connec=
tor,
>  	struct dc_stream_state *stream =3D NULL;
>  	struct drm_display_mode mode;
>  	struct drm_display_mode saved_mode;
> +	struct drm_display_mode native_mode;
>  	struct drm_display_mode *freesync_mode =3D NULL;
>  	bool native_mode_found =3D false;
>  	bool recalculate_timing =3D false;

[ ... ]

> @@ -1529,6 +1532,31 @@ create_stream_for_sink(struct drm_connector *conne=
ctor,
>  			break;
>  		}
>  	}
> +
> +	/*
> +	 * After a probe with size limits smaller than the preferred mode,
> +	 * connector->modes no longer has that mode, and the first mode left
> +	 * would become the stream timing. fbdev emulation probes with limits
> +	 * that video=3D can set below the native size. The encoder has a copy =
of
> +	 * the preferred mode from amdgpu_dm_get_native_mode(), made on every
> +	 * probe before the limits apply, so use that copy. Only do this for eDP
> +	 * and LVDS panels, which take only their native timing. On other
> +	 * connectors mode_valid can also reject the preferred mode, and then
> +	 * the first valid mode is the right one
> +	 */
> +	if (!native_mode_found && aconnector && !aconnector->mst_root && aconne=
ctor->drm_edid &&
> +	    (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP ||
> +	     connector->connector_type =3D=3D DRM_MODE_CONNECTOR_LVDS)) {
> +		struct drm_encoder *encoder =3D amdgpu_dm_connector_to_encoder(connect=
or);
> +
> +		if (encoder && to_amdgpu_encoder(encoder)->native_mode.clock) {
> +			drm_mode_copy(&native_mode, &to_amdgpu_encoder(encoder)->native_mode);

[Severity: Medium]
Does this result in an uninitialized stack memory read?

The native_mode variable is declared on the stack without initialization.
When passed to drm_mode_copy(), that function starts by attempting to
preserve the existing list node pointers of the destination:

void drm_mode_copy(struct drm_display_mode *dst,=20
                   const struct drm_display_mode *src)
{
        struct list_head head =3D dst->head;

        *dst =3D *src;
        dst->head =3D head;
}

Because native_mode is uninitialized, reading dst->head accesses garbage
data. While this won't corrupt an active list (since the garbage is written
back to a local variable that is never linked), it still triggers undefined
behavior and can cause Kernel Memory Sanitizer (KMSAN) warnings.

Could we initialize native_mode when it is declared to avoid this?
For example: struct drm_display_mode native_mode =3D { 0 };

> +			drm_mode_set_crtcinfo(&native_mode, CRTC_INTERLACE_HALVE_V);
> +			preferred_mode =3D &native_mode;
> +			native_mode_found =3D true;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014223041.1713=
17-1-hugo@hsal.es?part=3D1
