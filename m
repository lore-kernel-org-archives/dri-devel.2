Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17426C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB8510E4B6;
	Tue, 30 Jun 2026 08:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VS9WrEWp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1059610E4B6
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:57:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63270600FC;
 Tue, 30 Jun 2026 08:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50921F000E9;
 Tue, 30 Jun 2026 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782809857;
 bh=41buIM/Q+w80gRS8AZdrg3Bztv7yXLsijgIRQ9WwQhk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VS9WrEWp2+uFk9ky0I/rBGJax4vSUsrDOfLdvE9A8o48S93Z5kC6StJa/M7/xNM2e
 BuzZ57NcR5Y1KMm1Gd/24fZ0jBHovFpBn4+iddUcBezCrh8dkx1d29O5aEYdAWRKrP
 DQQINQ7h9+C6Q5saTXIOYunH+JTD9o7AuTZ1yF6MInsSYz5hwdmC2VvLw1k7+ZerND
 3EZ/26WFMKVdTONfHFZV4RxPFbmCLN6LxNyy56kOj/u3lgGT5Ov3tB06k+COjeC4Oo
 bOz2KPyDv+XVjJGc0ExVN3sZxd5hLYNE0XWbe411KkFLNtNKP9kQSi9jFwqBFWG1lM
 aqD8JB2Vxrzjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] drm/i915: Add DRIVER_PLANE_COLOR_PIPELINE driver
 feature
To: "Robert Mader" <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630084229.529682-4-robert.mader@collabora.com>
References: <20260630084229.529682-1-robert.mader@collabora.com>
 <20260630084229.529682-4-robert.mader@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:57:36 +0000
Message-Id: <20260630085736.E50921F000E9@smtp.kernel.org>
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
- [High] The i915 driver API contract violation: fails to ignore legacy pre=
-blend color operations (COLOR_ENCODING and COLOR_RANGE) when the DRM_CLIEN=
T_CAP_PLANE_COLOR_PIPELINE capability is set.
- [Medium] The DRIVER_PLANE_COLOR_PIPELINE feature flag is missing for the =
Xe driver, making the plane color pipeline capability unavailable despite s=
hared and implemented support.
--

commit be3a060691e463c76013f01322ae2330b3817960
Author: Robert Mader <robert.mader@collabora.com>

drm/i915: Add DRIVER_PLANE_COLOR_PIPELINE driver feature
   =20
Which is now required for DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE.

> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i9=
15_driver.c
> index f0105c5b49a71..139848bf903cb 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1860,7 +1860,7 @@ static const struct drm_driver i915_drm_driver =3D {
>  	.driver_features =3D
>  	    DRIVER_GEM |
>  	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ |
> -	    DRIVER_SYNCOBJ_TIMELINE,
> +	    DRIVER_SYNCOBJ_TIMELINE | DRIVER_PLANE_COLOR_PIPELINE,

[Severity: High]
Does enabling this feature reveal a logic bug where legacy color properties
aren't ignored when the client uses plane color pipelines?

When a client uses DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE and configures a col=
or
pipeline on a plane with a YUV framebuffer, the driver unconditionally copi=
es
legacy UAPI properties to the hardware state in
drivers/gpu/drm/i915/display/intel_plane.c:

intel_plane_copy_uapi_to_hw_state() {
	...
	plane_state->hw.color_encoding =3D from_plane_state->uapi.color_encoding;
	plane_state->hw.color_range =3D from_plane_state->uapi.color_range;
	...
}

This leads to the hardware input CSC being programmed using the legacy
color_encoding in drivers/gpu/drm/i915/display/skl_universal_plane.c:

icl_program_input_csc() {
	...
	const u16 *csc =3D input_csc_matrix[plane_state->hw.color_encoding];
	...
}

Will this cause a hidden YUV-to-RGB conversion to be applied, violating the
explicit color pipeline contract?

[Severity: Medium]
Since the Xe driver shares the i915 display stack and fully implements plane
color pipelines, does it also need this driver feature flag?

Userspace attempting to set DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE on Xe hardw=
are
will currently get -EOPNOTSUPP because the feature is missing in
drivers/gpu/drm/xe/display/xe_display.c:

xe_display_driver_set_hooks() {
	...
	driver->driver_features |=3D DRIVER_MODESET | DRIVER_ATOMIC;
	...
}

Should DRIVER_PLANE_COLOR_PIPELINE be added to xe_display_driver_set_hooks()
as well?

>  	.release =3D i915_driver_release,
>  	.open =3D i915_driver_open,
>  	.postclose =3D i915_driver_postclose,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630084229.5296=
82-1-robert.mader@collabora.com?part=3D3
