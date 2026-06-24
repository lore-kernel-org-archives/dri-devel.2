Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A83DCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9D210EFE7;
	Wed, 24 Jun 2026 17:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RO6Wa6Ex";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B806E10EFE7
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:20:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 224AF600C3;
 Wed, 24 Jun 2026 17:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B436D1F00A3A;
 Wed, 24 Jun 2026 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782321646;
 bh=Y2vPDWg4Ag9QelVU6tWGJAc/wX8vktArIsLoRERUhFQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RO6Wa6ExPwRbj1TAX5ktv+OmfGytYNAUmi6Othy1RzT8ZMNs5KzngLwUqtJ9ZiJbG
 gqV1vQOEOOjPkc56U9eNdvdHHO7p2qQe/tbmFZGueejMqqFjO1gqAUvyWeQpxYDePj
 KWVlFxwsbMZMwR8RdTG8ECoOk0oJHG65dRrHGNRk5blUcpWBxNw+TuXs2gRjOhbRca
 RYyHjOVyOVIA+MR3De0rtO3h2kd7iK2Z0xqFj04qyRK9BZrW07iEvaWNpWzPKDMite
 +vRs2skz9thyK+YfO0tgJg1xAsBo4ZLDd2ZbrjFvitk2KUvcy2AhYX+Fy7sBSh5Se2
 KvU94jDJ0QCsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] drm/amd/display: Allow backlight registration
 to fail
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624165751.2014759-7-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-7-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:20:46 +0000
Message-Id: <20260624172046.B436D1F00A3A@smtp.kernel.org>
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
- [High] Propagating backlight registration failures causes the entire AMDG=
PU driver probe to fail, completely breaking all display outputs.
--

commit 290c274dbf0e6988a8d83dadd2c54c417b03e056
Author: Mario Limonciello (AMD) <superm1@kernel.org>

drm/amd/display: Allow backlight registration to fail

This commit changes backlight registration in the AMD display manager to
return error codes instead of ignoring them. This allows upstream callers
to detect when backlight initialization fails.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9b3e2fc6cef5d..2f87940aaea42 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -8225,7 +8230,9 @@ amdgpu_dm_connector_late_register(struct drm_connec=
tor *connector)
>  			return r;
>  	}
> =20
> -	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
> +	r =3D amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
> +	if (r)
> +		return r;

[Severity: High]
Will returning this error abort the entire GPU probe?

If backlight_device_register() fails in amdgpu_dm_register_backlight_device=
()
(for instance, due to a sysfs name collision, memory allocation failure, or
ACPI issue), propagating this error here causes drm_connector_register() and
ultimately drm_dev_register() to fail.

Because generic framebuffers like efifb or simpledrm are explicitly removed
by aperture_remove_conflicting_pci_devices() before drm_dev_register() is
called, does failing the PCI probe at this stage leave the system with a
dead screen and no display driver at all?

Should a non-critical backlight initialization failure be treated as fatal =
to
the entire display adapter?

> =20
>  	if ((connector->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort) ||
>  	    (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624165751.2014=
759-1-mario.limonciello@amd.com?part=3D6
