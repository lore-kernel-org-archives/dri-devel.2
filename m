Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04B2C624CE
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 23:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E0F10E37A;
	Mon, 31 Aug 2026 23:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A5T9axmm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7205410E353;
 Mon, 31 Aug 2026 23:30:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A17B0602D4;
 Mon, 31 Aug 2026 23:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DCC1F00A3D;
 Mon, 31 Aug 2026 23:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788219045;
 bh=2zO10rBrRpKl0LAWoCRYxG2ZffFXZtrJhPtXIXE0svo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A5T9axmm0+ijeMdvnp7jyCY5QMZI9GekkkoOSFcwGRpOPhxoiQdotr9pV/F4YascR
 26yQxxrjZ+VeDPW3k0prSnte1CwI9ABsLlUfN6ghw8s1UDz9tooJQYMtuM/uHN4xwD
 0VIgwQRix+tmiCyeVTQoly/GhyoTVFwQP43HDzCDeScAtTGZL74rFDpaDN9BV/FftQ
 kfTTz+JwwGMrrUQMFuS5/aNE5RKVIlqTt6ZhllXKn/RhW/ZxwHBMU1lWygPvMmj5U9
 DDNRcSg8WnoEaRCuOFnbl91U4m3FDgwHU4/o/Cae4OhTyWVXDuE+Hq7p5InwQVYeez
 O1Zm1cXkA+YpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/12] drm/xe: Indicate support for luminance on the
 connector
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260831210531.2334221-11-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
 <20260831210531.2334221-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:30:44 +0000
Message-Id: <20260831233045.12DCC1F00A3D@smtp.kernel.org>
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
- [Medium] The commit silently introduces and enables a new, undocumented D=
RM feature flag (DRIVER_GEM_GPUVA), which is completely unrelated to connec=
tor luminance.
--

commit 2a9c8dfbbc421c84ac6987dc02eb16939b1f82f5
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/xe: Indicate support for luminance on the connector

This commit enables the connector to show luminance information for eDP pan=
els=20
in the xe driver by setting the DRIVER_CONNECTOR_LUMINANCE driver feature.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index f9791c850e520..b65bbe8fde0c3 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -397,7 +397,8 @@ static const struct drm_driver regular_driver =3D {
>  	    XE_DISPLAY_DRIVER_FEATURES |
>  	    DRIVER_GEM |
>  	    DRIVER_RENDER | DRIVER_SYNCOBJ |
> -	    DRIVER_SYNCOBJ_TIMELINE,
> +	    DRIVER_CONNECTOR_LUMINANCE |
> +	    DRIVER_SYNCOBJ_TIMELINE | DRIVER_GEM_GPUVA,

[Severity: Medium]
Does this code intentionally enable DRIVER_GEM_GPUVA for the xe driver
in this patch?=20

The commit message only mentions adding support for luminance on the
connector, which suggests this flag might have been accidentally squashed
into this patch.

>  	.open =3D xe_file_open,
>  	.postclose =3D xe_file_close,
> =20
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 449160b9863f6..bda0f0bd7b16b 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -125,6 +125,13 @@ enum drm_driver_feature {
>  	 */
>  	DRIVER_CONNECTOR_LUMINANCE           =3D BIT(10),
> =20
> +	/**
> +	 * @DRIVER_GEM_GPUVA:
> +	 *
> +	 * Driver supports GEM GPU virtual addressing.
> +	 */
> +	DRIVER_GEM_GPUVA               =3D BIT(11),
> +

[Severity: Medium]
Is the DRIVER_GEM_GPUVA flag definition meant to be included here?=20

It appears unrelated to the connector luminance changes described in the
commit message and might belong in a separate, dedicated patch.

>  	/* IMPORTANT: Below are all the legacy flags, add new ones above. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831210531.2334=
221-1-mario.limonciello@amd.com?part=3D10
