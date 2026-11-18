Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB8606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlkRObmb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5909B10E1AA;
	Wed, 18 Nov 2026 21:58:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8700D10E1AA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:58:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8527063BDA;
 Wed, 18 Nov 2026 21:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F01D1F000C5;
 Wed, 18 Nov 2026 21:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795039128;
 bh=Wx3ws9rKu/jSRAsuESKhDT68ZKv+FT+IW9DeP4vFJ4M=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=IlkRObmbkNsAbh7LI/bsXUV+iv7sWe4ZVkYFNrXOTVb/BWmppB5TYfSj/dIcJe9vt
 c5ejHtVL/5Kg+/Y8CdPMdB4nYEN2nemK0Bx68HW8LHiXW/Rits7MLIeXMXemYk+sdA
 SWxeUEOujE+eCqq7+MEd4mfPALaEnfhcCdH+xfhDzMw2PjImnYrbRhML9siVlg/5TZ
 c25qGqPznamG+6KwAliVY3sv3134/FQLs1Xp3VOoum7kWzzdcMuxhvRefhwlBrNLfZ
 Rw+sLPv9ONsiDyAFjTPZqXIm91/RNh8U/OshaadZaO++22mEfADFs25GRoVnV5mYc2
 dQbUsuuu/fBVA==
Message-ID: <sashiko-outbox-222063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/20] drm/imagination: Allow build with COMPILE_TEST=y
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261118214518.29317-16-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-16-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:58:47 +0000
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
- [Medium] drm/imagination: COMPILE_TEST build failure on 64-bit
  8KB/32KB page configs
--

commit 3a0a5d98906b6758538e2c13acfa780422a1a949
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

drm/imagination: Allow build with COMPILE_TEST=3Dy

This commit allows DRM_POWERVR to be built on any 64-bit architecture when
COMPILE_TEST is enabled.

> diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagin=
ation/Kconfig
> index 1fd4c635c2c96..a048d3c859385 100644
> --- a/drivers/gpu/drm/imagination/Kconfig
> +++ b/drivers/gpu/drm/imagination/Kconfig
> @@ -3,7 +3,8 @@
> =20
>  config DRM_POWERVR
>  	tristate "Imagination Technologies PowerVR (Series 6 and later) & IMG G=
raphics"
> -	depends on (ARM64 || RISCV && 64BIT)
> +	depends on ARM64 || RISCV || COMPILE_TEST
> +	depends on 64BIT
>  	depends on DRM
>  	depends on MMU
>  	depends on PM

[Severity: Medium]
Does enabling DRM_POWERVR under COMPILE_TEST && 64BIT break the build on
64-bit targets with 8KiB or 32KiB pages (such as sparc64, alpha, or 64-bit
mips with PAGE_SIZE_8KB/PAGE_SIZE_32KB)?

drivers/gpu/drm/imagination/pvr_mmu.h defines PVR_DEVICE_PAGE_SIZE as
PAGE_SIZE, and drivers/gpu/drm/imagination/pvr_mmu.c only supports 4KiB,
16KiB, 64KiB, 256KiB, 1MiB, and 2MiB pages, failing with an #error on any
other host page size.  Should DRM_POWERVR also depend on !PAGE_SIZE_8KB &&
!PAGE_SIZE_32KB (or restrict to supported page sizes)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118214518.2931=
7-1-ville.syrjala@linux.intel.com?part=3D15
