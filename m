Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D700AC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC2810F290;
	Fri, 24 Jul 2026 03:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BJxT60/m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5383E10F290
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 03:15:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB0CA40463;
 Fri, 24 Jul 2026 03:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634E51F000E9;
 Fri, 24 Jul 2026 03:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784862899;
 bh=GcYM/v7wttbntoDAy735DHJsFHJ5S4fvgM2FmDVO6Lk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BJxT60/mr8+oZjUzf97vRDDFb8/bnDSqTFwq+5FzgLH9EAfHQq32Hm99O2dT0AbRN
 KqzetvOotb+UyZ1nkNalnYKLTMO/fIT4pzsCo4bskDgbqj3eGGTln3IdY5E+fTbwOE
 Rlfb1tJ02EibTZgzWUbxE//pK+JtQhVd30MAnKvjBKzvFT0MjwjnMqpnNZ4a4MLgEm
 zliH4VZuxe1p9GCFF/IeZxHwpGobJ1U6hDU5RpxFfq6hkkL8UJTFogRWulP2y8UjY5
 0Bav25jBhXWqnch4ZKld9uG3mkExFYYlIlVZRlvE+EykcvQWPq80ZVFRi6e4a/GoA+
 90KP4qzP7KwpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
To: "Armin Wolf" <W_Armin@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724025959.142826-3-W_Armin@gmx.de>
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <20260724025959.142826-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 03:14:58 +0000
Message-Id: <20260724031459.634E51F000E9@smtp.kernel.org>
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
- [Medium] Incomplete refactoring: nouveau driver omitted from ACPI_VIDEO a=
nd ACPI_WMI Kconfig updates.
--

--- Patch [2]: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from =
nvidia_wmi_ec_supported() ---
commit a642691d3c901391482edfbe3099e7d703a15135
Author: Armin Wolf <W_Armin@gmx.de>

ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()

This commit removes the X86 architecture dependency from video-detect
and updates multiple DRM drivers to select ACPI_WMI and ACPI_VIDEO
without requiring X86. This allows the WMI-ACPI driver to support
other architectures.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 12e4a41bf1f04..50305630f5335 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>  	# ACPI_VIDEO's dependencies must also be selected.
>  	select INPUT if ACPI
>  	select ACPI_VIDEO if ACPI
> -	# On x86 ACPI_VIDEO also needs ACPI_WMI
> -	select X86_PLATFORM_DEVICES if ACPI && X86
> -	select ACPI_WMI if ACPI && X86
> +	select ACPI_WMI if ACPI
>  	help
>  	  Choose this option if you have a recent AMD Radeon graphics card.

[Severity: Medium]
Should the nouveau DRM driver's Kconfig also be updated to remove the X86
dependency for these options?

While this patch successfully updates amdgpu, gma500, i915, radeon, and xe,
it appears DRM_NOUVEAU was omitted. In drivers/gpu/drm/nouveau/Kconfig, it
currently retains the architecture-specific checks:

config DRM_NOUVEAU
...
	select ACPI_WMI if ACPI && X86
...
	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
	select BACKLIGHT_CLASS_DEVICE if ACPI && X86
	select INPUT if ACPI && X86
	select THERMAL if ACPI && X86
	select ACPI_VIDEO if ACPI && X86

Does this omission mean nouveau will fail to automatically select ACPI_VIDEO
and its dependencies on non-x86 architectures, leading to a loss of
out-of-the-box ACPI backlight and WMI functionality compared to the other
DRM drivers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724025959.1428=
26-1-W_Armin@gmx.de?part=3D2
