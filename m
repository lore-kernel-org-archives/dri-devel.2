Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F436C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F365B10E9E1;
	Tue, 25 Aug 2026 10:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b6KkT5PX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5856810E9E1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:55:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 411B7417EC;
 Tue, 25 Aug 2026 10:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5C41F000E9;
 Tue, 25 Aug 2026 10:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787655311;
 bh=smqlEI+iss/oRc8vAkuVtJowcTFF3/wmPovvthiHXS4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b6KkT5PXAO0MztW22pRPhhZZVFXN9m98ku7Ysrh9IV8ylQjPN1W2FAYR9Mv9lCQmU
 oWgOSFXQZpN3/rlgynpREiipW8YhsUd2WlzT5WIMEGeDkr9D1m0ZMWSQVI/xfpcq5Y
 4CWngtAoyX+AB84COfEBU699bRUfeQkI0/yxkBzCjd3YqOWo310TsjN6MlwoXzk1Ec
 C34O8YoBKr0QkzovK9TokHrZ5PWopntE5ryvxY/nRAAY/up7xmSfxxXnsN2tKHdGL7
 JwLpDdSqYknthOY5exKKal4h666T5zZ7HYv5gyPuj5khA1nRZwPqMOwHJfHECQAUE9
 M5S0CVrD09oDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825104152.670588-1-oushixiong1025@163.com>
References: <20260825104152.670588-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:55:10 +0000
Message-Id: <20260825105510.EC5C41F000E9@smtp.kernel.org>
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

New issues:
- [Medium] The patch excludes AVIVO-capable RS600, RS690, and RS740 IGPs fr=
om being matched, causing a loss of color map support.

Pre-existing issues:
- [High] The device ID heuristic incorrectly identifies modern non-AVIVO GP=
Us as AVIVO, which can lead to invalid register writes.
--

--- Patch [1]: [PATCH] drm/sysfb: ofdrm: Fix is_avivo() constant comparison=
 bug ---
commit aeacd4e00d7ba70a30fc346d0e3ce8c00c4f6b2b
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug

This patch replaces a constant comparison (PCI_VENDOR_ID_ATI_R600 >=3D 0x94=
00)
with a check against the device ID parameter to fix a logic error.

> diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
> index 819aed466727e..1d95df522ad58 100644
> --- a/drivers/gpu/drm/sysfb/ofdrm.c
> +++ b/drivers/gpu/drm/sysfb/ofdrm.c
> @@ -238,7 +238,7 @@ static bool is_avivo(u32 vendor, u32 device)
>  	/* This will match most R5xx */
>  	return (vendor =3D=3D PCI_VENDOR_ID_ATI) &&
>  	       ((device >=3D PCI_VENDOR_ID_ATI_R520 && device < 0x7800) ||

[Severity: High]
This isn't a bug introduced by this patch, but does the overly broad upper
bound in is_avivo() incorrectly identify modern AMD GPUs as AVIVO hardware?

Looking at modern GPU device IDs (like Fiji with ID 0x7300, or Navi 10 with
ID 0x731F), they fall directly into this legacy range check (device < 0x780=
0).

If present on an Open Firmware system, would the driver mistakenly match th=
em
as OFDRM_MODEL_AVIVO, map the PCIe BAR, and attempt color map updates by do=
ing
MMIO writes to legacy AVIVO offsets (0x6480, 0x6488, 0x6494)? Could this
overwrite unrelated or critical registers on modern DCN/DCE architectures,
causing memory corruption or hardware lockups?

> -		(PCI_VENDOR_ID_ATI_R600 >=3D 0x9400));
> +		(device >=3D PCI_VENDOR_ID_ATI_R600));

[Severity: Medium]
Does fixing this typo accidentally break support for legacy AVIVO IGPs in t=
he
0x79xx range?

The original flawed constant check unintentionally allowed devices like RS6=
00,
RS690, and RS740 IGPs (e.g., device ID 0x791e) to be matched as AVIVO when
is_avivo() is called during boot.

By bounding the checks to device < 0x7800 and device >=3D 0x9400 (assuming
PCI_VENDOR_ID_ATI_R600 is 0x9400), does this exclude the 0x79xx range,
causing these IGPs to be incorrectly classified as OFDRM_MODEL_UNKNOWN
rather than OFDRM_MODEL_AVIVO, and subsequently causing the driver to skip
initializing cmap functions?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825104152.6705=
88-1-oushixiong1025@163.com?part=3D1
