Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4FDCA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE5B112158;
	Fri,  9 Oct 2026 13:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oxzfR+w3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFEE112158
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:36:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AAE9860098;
 Fri,  9 Oct 2026 13:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3883E1F000FF;
 Fri,  9 Oct 2026 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791552971;
 bh=h8N5JEuuFSo+H1X+3M+DKhVU/ltqD/92S+cYFBN2atc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oxzfR+w31s9zxgKrV9EjeSZggn9R6Nye5vQxoiLvoq86fwQbXEDDm0SLff5HJr9sf
 houVYAmUxjP1bCPVEkciD1k2bzaBZPDrnarYT/Cff2Dj5FqIGXbReBxSQhDbwQj/Sv
 f9396HHMxIfNcZlpdzRLCHF5ZwBNrgeNJJ5FquHXik0DQKdwEjv/pvLnXvS+B6PlCr
 yh1N9iRvKn/VfZvN8aAH3rkhXQLuD1ODDfANdqTElCRVEjs6o1yURqL9ZRYpOySmgh
 dNOsHcM3yc1XhTH3xwkyeBUf47k+7rT/VuqmMK7wXfPcArjgoxIGDzFzC/XTKB98Bv
 7ZWpmmx04KPQw==
Message-ID: <sashiko-outbox-165650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Split out a7xx/a8xx device tables
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009131927.551319-3-robin.clark@oss.qualcomm.com>
References: <20261009131927.551319-1-robin.clark@oss.qualcomm.com>
 <20261009131927.551319-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:36:10 +0000
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
- [Medium] drm: missing weight index 0 in a810_pwrup_reglist_regs
- [Low] drm: a640_gbif declared as extern in C file instead of shared header
--

commit 417ccf9a602a6ae58f1d68b6bfbd7ec7f4880b14
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a6xx: Split out a7xx/a8xx device tables

This commit splits the Adreno GPU device tables into separate a7xx and a8xx
catalog files. It moves hardware configuration arrays and structs to these =
new
files to organize generation without conflicts across GPU generations.

> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a7xx_catalog.c
> @@ -0,0 +1,496 @@
[ ... ]
> +#include "a6xx_gpu.h"
> +#include "a6xx.xml.h"
> +#include "a6xx_gmu.xml.h"
> +
> +extern const struct adreno_reglist a640_gbif[];
> +

[Severity: Low]
Is it intentional to declare a640_gbif as an extern array directly inside
a7xx_catalog.c?

This bypasses type checking across translation units and causes
-Wmissing-prototypes and -Wmissing-declarations warnings on W=3D1 builds. It
is generally preferred to put shared declarations in a common header like
a6xx_gpu.h instead of placing ad-hoc externs inside C files.

> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> @@ -0,0 +1,1847 @@
[ ... ]
> +static const uint32_t a810_pwrup_reglist_regs[] =3D {
> +	REG_A6XX_UCHE_MODE_CNTL,
[ ... ]
> +	REG_A7XX_SP_READ_SEL,
> +	REG_A6XX_TPL1_NC_MODE_CNTL,
> +	REG_A6XX_TPL1_DBG_ECO_CNTL,
> +	REG_A6XX_TPL1_DBG_ECO_CNTL1,
> +	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(1),
> +	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(2),
> +	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(3),

[Severity: Medium]
Does this sequence intentionally omit index 0 for the bicubic weights table?

The a810_pwrup_reglist_regs array is used to restore critical hardware state
on power-up for the A810 GPU. The bicubic weights table initialization in
this array skips REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(0), directly jumping to
index 1.

Other GPUs (like a830, a840, a850, and a750) correctly include index 0 in
their power-up lists. Missing the 0th index here means the weight will not
be restored during power-up or preemption, potentially leading to
unpredictable bicubic filtering behavior or data corruption on the GPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009131927.5513=
19-1-robin.clark@oss.qualcomm.com?part=3D2
