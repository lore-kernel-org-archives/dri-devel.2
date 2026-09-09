Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E303BC79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D6710F07A;
	Wed,  9 Sep 2026 09:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iegvzD2E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53A110F065;
 Wed,  9 Sep 2026 09:32:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0E38405CF;
 Wed,  9 Sep 2026 09:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02581F00A3D;
 Wed,  9 Sep 2026 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788946365;
 bh=pjZHiFRHuvig4QcBz8WoADhabzi1k9JT3b4nNK9B9To=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iegvzD2E1kx7hSizRGHiMOswmqoAprg+Br1Aw423R9194IJZ+etFpV/rPjahaMqKE
 81LR+RC1HvJMLV/Efvbt9Qm6ApupMF/dtPtCQvo2BiMAwWhq+hj+ORHY8DtvmS+gXb
 qLiJLUeLqZ5uhmbELUM46bgKOeGqLYrXMTocjOMxZnsCXAKzo+p3cvO6uG2EPIN4mn
 m11sf3tUbzccfkDQ3uX0wZJ65FBmtD7yjqAD2V0ZOArfu+n2e5RuOF6QxxBiU3iuVX
 YHCwMih+14WXhr0Z4EJ8MatUL6TdVaS6rw8S3UJsqs/4Hurzd0+nEnQOvJh9eNf8gR
 0bp6eJSD6iY8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/14] drm/panic: Move panic display code into helper
 library
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 imx@lists.linux.dev, gary@garyguo.net, "Michael
 S. Tsirkin" <mst@redhat.com>, wsa+renesas@sang-engineering.com,
 intel-gfx@lists.freedesktop.org, ojeda@kernel.org, Frank.Li@kernel.org,
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260909085826.64529-14-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-14-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:32:44 +0000
Message-Id: <20260909093244.E02581F00A3D@smtp.kernel.org>
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
- [Low] CONFIG_DRM_PANIC_SCREEN_QR_CODE can be enabled without its source c=
ode being compiled.
--

commit cfc7923d9a3badf08604fdffe1b2f5534bf2b0b6
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Move panic display code into helper library

This commit moves the panic display code and drm_plane_helper_display_panic=
_screen()
into a new drm_panic_helper.c library. It renames symbols and updates the Q=
R-related
code accordingly, linking the object files into the drm_kms_helper module.

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e635fcffd3790..f0c340aa2ec60 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
[ ... ]
> @@ -157,6 +156,8 @@ drm_kms_helper-y :=3D \
>  	drm_simple_kms_helper.o \
>  	drm_vblank_helper.o
>  drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) +=3D bridge/panel.o
> +drm_kms_helper-$(CONFIG_DRM_PANIC_HELPER) +=3D drm_panic_helper.o
> +drm_kms_helper-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) +=3D drm_panic_helper_=
qr.o

[Severity: Low]
Does this allow CONFIG_DRM_PANIC_SCREEN_QR_CODE to be enabled without its
source code being compiled?

Since drm_panic_helper_qr.o is now built into drm_kms_helper, if a kernel is
configured with CONFIG_DRM_KMS_HELPER=3Dn and CONFIG_DRM_PANIC_SCREEN_QR_CO=
DE=3Dy,
the QR code source (drm_panic_helper_qr.rs) will be silently omitted from t=
he
build. The definition for CONFIG_DRM_PANIC_SCREEN_QR_CODE in
drivers/gpu/drm/Kconfig currently does not depend on or select DRM_KMS_HELP=
ER.

Should the Kconfig dependencies be updated to prevent this configuration
mismatch?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D13
