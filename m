Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB271C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEC610F277;
	Fri, 24 Jul 2026 02:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mdEvFbuJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D78310F277
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 02:38:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E498600AA;
 Fri, 24 Jul 2026 02:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1481F000E9;
 Fri, 24 Jul 2026 02:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784860684;
 bh=KO58rVx1oAOsQE2w4vu7zQqsrb+6Jl5SogsORmk7Pic=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mdEvFbuJkra41nkkk8yAHHjSv2U0nz3zovZaidauSta0oKj2l6A107hu49vK+HWMk
 x0+oFkNbsmlmCIKSkVZBJLB8Aa7Th0ubxHoKhwbK1xunl5pnR84PYXjkECR9Pe/CR/
 n8iuj+PfojqGwdRwSIjODrqeZBfx29VzlwJbLCwBZ2hlVq8cMFg+1sYSBx9NxfafVp
 8CkEzX7f7xBdAcP7sjwVONRaBHX1IGyAtUvpofQ17vmOPo6tdd31G/N6XSSwlaVHYc
 r4USRzWH+mcom1qV/sgY/l3PLiTEbwNL6h5lQ6KnQRxuA4/bhDRBJgCkf/WaEkR4YE
 ut4DrGdtpWDcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
To: "Armin Wolf" <W_Armin@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724022526.139370-3-W_Armin@gmx.de>
References: <20260724022526.139370-1-W_Armin@gmx.de>
 <20260724022526.139370-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 02:38:03 +0000
Message-Id: <20260724023804.2A1481F000E9@smtp.kernel.org>
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
- [Low] The `LOONGSON_LAPTOP` driver selects `ACPI_VIDEO` but does not sele=
ct `ACPI_WMI`, leading to an unmet direct dependency warning and subsequent=
 build/link failures on LoongArch.
--

--- Patch [2]: [PATCH v2 2/3] ACPI: video: Remove CONFIG_X86 handling from =
nvidia_wmi_ec_supported() ---
commit 7d6e691f0baea7ff60329d732c8876bffc4d3788
Author: Armin Wolf <W_Armin@gmx.de>

ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()
   =20
The WMI-ACPI driver now supports architectures other than x86.
Remove the CONFIG_X86 handling from video-detect and the associated
GPU drivers to simplify the resulting code.

> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f165d14cf61a3..cc1e58fa664b0 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -224,7 +224,7 @@ config ACPI_VIDEO
>  	tristate "Video"
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on INPUT
> -	depends on ACPI_WMI || !X86
> +	depends on ACPI_WMI

[Severity: Low]
Does this change create an unmet direct dependency for drivers on other
architectures that select ACPI_VIDEO?

For instance, in drivers/platform/loongarch/Kconfig, LOONGSON_LAPTOP
unconditionally uses "select ACPI_VIDEO". Since LOONGSON_LAPTOP was not
updated to also select ACPI_WMI, does Kconfig force ACPI_VIDEO to be
enabled without fulfilling this new ACPI_WMI dependency?

>  	select THERMAL
>  	help
>  	  This driver implements the ACPI Extensions For Display Adapters

[ ... ]

> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 458efa4fe9d4b..af9280b244f1b 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *context, =
void **rv)
>  	return AE_OK;
>  }
> =20
> -/* This depends on ACPI_WMI which is X86 only */
> -#ifdef CONFIG_X86
>  static bool nvidia_wmi_ec_supported(void)
>  {
>  	struct wmi_brightness_args args =3D {

[ ... ]

> @@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
>  	 */
>  	return args.ret =3D=3D WMI_BRIGHTNESS_SOURCE_EC;
>  }
> -#else
> -static bool nvidia_wmi_ec_supported(void)
> -{
> -	return false;
> -}
> -#endif

[Severity: Low]
Could this result in build or link failures on non-x86 architectures?

Since nvidia_wmi_ec_supported() calls wmi_evaluate_method(), if an
architecture like LoongArch forces ACPI_VIDEO to be built via select, but
ACPI_WMI is not built-in or enabled as a module, wmi_evaluate_method()
might be undeclared or missing during linkage.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724022526.1393=
70-1-W_Armin@gmx.de?part=3D2
