Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B135C5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99EA10EDBA;
	Tue, 11 Aug 2026 21:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="etETqwIw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FA810EDBA
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:55:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C94241669;
 Tue, 11 Aug 2026 21:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331781F000E9;
 Tue, 11 Aug 2026 21:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786485342;
 bh=/MjdMHL1JU7dALgMqjxxRavffyhdYh0C12LsStT0u3k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=etETqwIw2FxR9oig/eBWxiIhZs0xLCt9fNEDjmxqw5zidnbTBzsEKCiqNB4u23qS2
 PtSrGGUlBXUu141sOMiXWc5Yq3bQX3tigAYB+cy4pj2OVitT9Qav8ENslzzd1Q86fs
 kZ9z+FFsIHW0PSGf7ktIzqFMsx+9crssWlzBHkOiEar/IA4PDPk1b+2zvK43oIXpEB
 JJDU75u3432T7jmnDk8T5FuoI0DnPo44rkpho+1G6wrdSjnG0ywpFK4kIexFWeUIay
 gwkuO3Oumv9MNVhNe3vYJMpZtMJniPvH463L/3kM9xUlpdk/04PuteekSLYtkHhF1f
 L6aXeTkkmO1dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/11] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-claude-fixes-v5-11-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-11-3d692c9e98c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 21:55:41 +0000
Message-Id: <20260811215542.331781F000E9@smtp.kernel.org>
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
- [Medium] Incomplete patch falsely advertises new UAPI feature (hw_reset) =
by bumping the driver minor version, but omits the actual UAPI and driver i=
mplementations.
--

--- Patch [11]: [PATCH v5 11/11] drm/panfrost: Bump driver minor to reflect=
 new DUMP IOCTL req field ---
commit 05a98b7146163b4b69a5fa2ced180f71b22a96f4
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Expose expanded PERFCNT_DUMP IOCTL interface to user mode.

This commit bumps the panfrost driver minor version to 7 and adds a comment
indicating the addition of a hw_reset field to the PERFCNT_DUMP ioctl.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index ff23b1a979bb..2949ab3ca055 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -936,6 +936,7 @@ static void panfrost_debugfs_init(struct drm_minor *m=
inor)
>   * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
>   *	   PANFROST_IOCTL_QUERY_BO_INFO and
>   *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
> + * - 1.7 - adds PERFCNT_DUMP req hw_reset field
>   */
>  static const struct drm_driver panfrost_drm_driver =3D {
>  	.driver_features	=3D DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
> @@ -948,7 +949,7 @@ static const struct drm_driver panfrost_drm_driver =
=3D {
>  	.name			=3D "panfrost",
>  	.desc			=3D "panfrost DRM",
>  	.major			=3D 1,
> -	.minor			=3D 6,
> +	.minor			=3D 7,

[Severity: Medium]
Is this patch missing the corresponding UAPI and implementation changes?

The comment and version bump explicitly advertise the new hw_reset field to
userspace, but the modifications to struct drm_panfrost_perfcnt_dump in the
UAPI header and the actual driver logic in panfrost_ioctl_perfcnt_dump()=20
appear to be omitted.

Userspace checking the minor version might falsely believe the feature is
supported, leading to IOCTL failures or ignored fields. Should the version
bump occur together with the feature implementation in the same patch to
avoid intermediate breakage?

> =20
>  	.gem_create_object	=3D panfrost_gem_create_object,
>  	.gem_prime_import	=3D panfrost_gem_prime_import,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-claude-fix=
es-v5-0-3d692c9e98c2@collabora.com?part=3D11
