Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2413C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22EE010E07A;
	Fri, 14 Aug 2026 14:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J/GAwrnv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B2910E07A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:13:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FE2442EAB;
 Fri, 14 Aug 2026 14:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0EA1F00ACA;
 Fri, 14 Aug 2026 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786716820;
 bh=1rAX6QJ0ggkFuG1VTCUDnuFcThuVYB6jwdwWyNw8/es=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J/GAwrnv5sonBHKNIyTKkGCYaaMGYCpCpInihsPzlItwAlTPJjB6Twbjb2vbAvEXk
 1SOhIwOM24GiIIrjrnuBvLoeg32oKYaI+G9wpD1OxiTggkJLB7OEBiyg3kosxr5zJr
 DitbEECUtMIHRs4sy3qoxqMHiod8I5siun6WMLZq08w2zIEeWHbzUkIpl7k+IqSwgn
 c+JkkITm176g0z2+E5pXFu6f7TQa8yw3hv66Pjh8o9MnIEe0z1bzRtQ9Fo5OvQs7Sf
 GICj2kgiUvGQuWYbKB339vvUkw4rXAMKt/G7zgc2tNcCB2HvqHro67nkAmg9tz2VGi
 uN47ibcDSjiJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] drm/panel: merge the drm_kms_helper module into
 the drm module
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-bridge-every-panel-v1-4-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-4-19cd5277cc8d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:13:39 +0000
Message-Id: <20260814141339.DC0EA1F00ACA@smtp.kernel.org>
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
- [Low] The use of `:=3D` instead of `+=3D` for `drm-$(CONFIG_DRM_KMS_HELPE=
R)` overwrites the previously defined `drm-y` list, causing all core DRM ob=
jects to be excluded from the build.
- [Low] Merging `drm_kms_helper` into the `drm` module breaks the build or =
module loading when `CONFIG_DRM=3Dy` and `CONFIG_DRM_KMS_HELPER=3Dm` becaus=
e Kbuild ignores `drm-m` for built-in objects.
--

--- Patch [4]: [PATCH 04/11] drm/panel: merge the drm_kms_helper module int=
o the drm module ---
commit d831428a6450fb748ee21e10b4e68b33d57ee2c3
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/panel: merge the drm_kms_helper module into the drm module

Work is in progress to make every drm_panel automatically create a panel_br=
idge,
which requires calling drm_panel_bridge APIs. This would create a circular
dependency loop on modular builds. This commit attempts to move the entire
drm_kms_helper into the drm module to resolve the dependency loop.

Link: https://lore.kernel.org/all/emuj2innmp6zmzd7pyakqzjqpdzhly6qfhakya3yd=
wmd63pl26@5jwxaidpikjw/
Link: https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-8-9d6f2c9=
c3058@bootlin.com/

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -139,7 +139,7 @@ obj-$(CONFIG_DRM_TTM_HELPER) +=3D drm_ttm_helper.o
>  # Modesetting helpers
>  #
> =20
> -drm_kms_helper-y :=3D \
> +drm-$(CONFIG_DRM_KMS_HELPER) :=3D \

[Severity: Low]
Does this `:=3D` assignment overwrite the core DRM objects defined earlier =
in
the Makefile? If `CONFIG_DRM_KMS_HELPER=3Dy`, this evaluates to `drm-y :=3D=
`,
replacing the previously built list for `drm-y`. This would cause the core
DRM files to be dropped from the build.

[Severity: Low]
What happens to the build if `CONFIG_DRM=3Dy` and `CONFIG_DRM_KMS_HELPER=3D=
m`?

In this configuration, the objects are appended to `drm-m`. Since the
parent object is built-in (`obj-y +=3D drm.o`), Kbuild ignores the `drm-m`
list entirely. Could this cause the KMS helpers to be silently omitted
from compilation, leading to unresolved symbols in modular drivers that
depend on them?

>  	drm_atomic_helper.o \
>  	drm_atomic_state_helper.o \

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-bridge=
-every-panel-v1-0-19cd5277cc8d@bootlin.com?part=3D4
