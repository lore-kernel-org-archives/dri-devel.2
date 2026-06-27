Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB89C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E1610F773;
	Sat, 27 Jun 2026 03:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gvFzLMt8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B218A10F773
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:46:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26386600C8;
 Sat, 27 Jun 2026 03:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2911F000E9;
 Sat, 27 Jun 2026 03:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532003;
 bh=5lskZHw2ElEAM+0T62Qstgtx8Dw8dbqyE0kbIrw6C2M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gvFzLMt8naUxCxwSN233aeUIW7FAnQpFepNVcSuOSZFkoEzhxrQfmSU1zd46L7qa1
 fOXzh+5ygy8AM6u6S82Yn/D7QYr8bMXZU2JNpa1WdtS9hjzFicPok49zfWmTRnaSTz
 1YnlKyCivgIvoUwNKNo1wDlgL0pr1T3halhF0QLumUkhzHfjnComIS3m8uOttgb0Yu
 icNv4mbJR+RZ8MlNw6UW5ycBLAEOmLwehavC+GlCewR3ogz8YpkcWr54t+QyqlLL12
 fkwBczOibDyIEvdvHFyLN4I9rrO781704I1egjEoLpCLSWdCMujp2wqYT6UAPcXL0x
 5qCMHbdFpCIZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/38] drm/vkms: Introduce config for plane name
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-13-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-13-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:46:43 +0000
Message-Id: <20260627034643.AC2911F000E9@smtp.kernel.org>
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
- [High] The user-configurable plane name is passed directly as a format st=
ring to `drmm_universal_plane_alloc()`, leading to a format string injectio=
n vulnerability.
- [Medium] `drm_get_rotation_name` incorrectly expects an array index rathe=
r than a rotation bitmask, causing it to return wrong strings for valid rot=
ation masks.
--

commit ecb2a628cbf8a89c520eb57344c9fb30aaf1876c
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane name
   =20
This commit introduces a configuration option for setting a plane's name in
the VKMS driver using ConfigFS.

> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index 68cb2a3335e64..f351202031244 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
[ ... ]
> @@ -228,7 +229,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device=
 *vkmsdev,
>  					   &vkms_plane_funcs,
>  					   vkms_formats, ARRAY_SIZE(vkms_formats),
>  					   NULL, vkms_config_plane_get_type(plane_cfg),
> -					   NULL);
> +					   vkms_config_plane_get_name(plane_cfg));

[Severity: High]
Can this cause a format string injection vulnerability?

Since the plane name is user-configurable via ConfigFS, a user could provid=
e a
name containing format specifiers like "plane-%px". When this is passed dir=
ectly
as the format string argument to drmm_universal_plane_alloc(), it could lea=
d to
out-of-bounds memory reads or a kernel panic.=20

Should this be passed as "%s", vkms_config_plane_get_name(plane_cfg) instea=
d?

>  	if (IS_ERR(plane))
>  		return plane;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D13
