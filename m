Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA08606A334
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHgPKYus
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C0889056;
	Wed, 18 Nov 2026 21:57:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B2389056
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:57:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2A224344B;
 Wed, 18 Nov 2026 21:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1C61F000D2;
 Wed, 18 Nov 2026 21:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795039055;
 bh=yGxCjuXpFhQpAfsX4OdPUV6dEwysgrlSCgNMDlA/sXc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=cHgPKYus+zXQ7cK2LhRYU6wYGwXMXwCozTa2R8B6OpTYB0jnbTOOiZa7+qtOh1a3W
 lq/qpyhhdePgDpo8223ii/2+T10Wyvusx7Dhw5KEhmm+QcoRv2VNp3yozIZ78wS5vo
 9yrnNoQSFa5+xDjBl4Bl/U0NrjPlAsLMtDs2pMpGBkTgVEQEJcLNiEnvr3JmYidUkx
 lEPkO5e7nR2FDR7OGyIFV3m54kVruEgfa+5fMPpI73SrzBdX2tI6hZy0J5YpNjBZxv
 Gd5zDdDbzvrmZwqRPwl/SCYSDcJiA/1Iq+rmCDdCEr9EWXXGFucCIGGPclP/Ed8l15
 2/r+Wi8Qm75SA==
Message-ID: <sashiko-outbox-222062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/20] drm/nouveau: Allow platform driver build with
 COMPILE_TEST=y
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261118214518.29317-20-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-20-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:57:31 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/nouveau: build failure in nouveau_platform_resume() when
  PM_DEVFREQ=3Dn
--

commit 7f3a768f8ef913fb90efb9c01241f3d8714fc297
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

drm/nouveau: Allow platform driver build with COMPILE_TEST=3Dy

This commit allows NOUVEAU_PLATFORM_DRIVER to be enabled when COMPILE_TEST=
=3Dy
even on non-Tegra architectures.

> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kc=
onfig
> index 3b5757aed9c84..d7b432c839e5f 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -34,7 +34,7 @@ config DRM_NOUVEAU
> =20
>  config NOUVEAU_PLATFORM_DRIVER
>  	bool "Nouveau (NVIDIA) SoC GPUs"
> -	depends on DRM_NOUVEAU && ARCH_TEGRA
> +	depends on DRM_NOUVEAU && (ARCH_TEGRA || COMPILE_TEST)
>  	default y
>  	help
>  	  Support for Nouveau platform driver, used for SoC GPUs as found

[Severity: Medium]
Does this break the build in nouveau_platform_resume() when
CONFIG_PM_SLEEP=3Dy and CONFIG_PM_DEVFREQ=3Dn?

DRM_NOUVEAU only has "select PM_DEVFREQ if ARCH_TEGRA", so when
ARCH_TEGRA=3Dn and COMPILE_TEST=3Dy, CONFIG_PM_DEVFREQ can remain disabled.
The fallback stub for gk20a_devfreq_resume() in
drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a_devfreq.h is missing the
pointer asterisk on its parameter:

drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a_devfreq.h:
    #if defined(CONFIG_PM_DEVFREQ)
    int gk20a_devfreq_init(struct nvkm_clk *base, struct gk20a_devfreq **de=
vfreq);
    int gk20a_devfreq_resume(struct device *dev);
    int gk20a_devfreq_suspend(struct device *dev);
    #else
    static inline int gk20a_devfreq_init(struct nvkm_clk *base, struct gk20=
a_devfreq **devfreq)
    {
    	return 0;
    }

    static inline int gk20a_devfreq_resume(struct device dev) { return 0; }
    static inline int gk20a_devfreq_suspend(struct device *dev) { return 0;=
 }
    #endif

Passing struct device *dev from nouveau_platform_resume() to
gk20a_devfreq_resume() then fails to compile with an incompatible type
error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118214518.2931=
7-1-ville.syrjala@linux.intel.com?part=3D19
