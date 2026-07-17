Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC93CC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26BEE10F507;
	Fri, 17 Jul 2026 10:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XZ5lMVO2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3338310F507
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:56:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D0F904098A;
 Fri, 17 Jul 2026 10:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBB61F000E9;
 Fri, 17 Jul 2026 10:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784285797;
 bh=AfzAnI9SK1ZuYXIm5H+sH2lefylA+qnGFnCgoRPEqrA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XZ5lMVO2bzA0PgvY1y2ZIofZiqsglI0TURvtRC4zO9h0DJ6CAmGMEVTyidUzprIJw
 AUxEKr8tVorZ6I2Rg2n51kEl3iu5rYcW7L72NPyvxqD10L6rvvNS+fQSWzJC3yiTRZ
 7bt3cMtB7ow2/UVCZYNwMd7gvSvIQJ0W5+fDfaskXQkh3Nd493Yal9YE2rgGTA7NOv
 YtN4VbHeVgE9hvUAD1I5IEUjgxRMC4kxteV789vuc3yIN2vK+HiCHaDUCNJoey+ASP
 I5SXQDXdxYVDGczh8pJfoRdCxlIXjCbUsE0tv7MCaL5ExmhUPp/mpgGLSQJBxWDwlm
 5+I5KaPg9yhKA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 1/8] misc/arm-cla: Add driver skeleton and
 documentation
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717104759.123203-2-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 10:56:37 +0000
Message-Id: <20260717105637.9FBB61F000E9@smtp.kernel.org>
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
- [Medium] The EL2 specific memory translation context (MTC) registers are =
defined as absolute indices rather than relative offsets, breaking consiste=
ncy with the common MTC offsets.
- [Low] Headers rely on implicit inclusions for data types and device struc=
ts.
--

--- Patch [1]: [RFC PATCH v1 1/8] misc/arm-cla: Add driver skeleton and doc=
umentation ---
commit 8a70e14ab5fcacc24591a3baaa6d296f8a8f4c6b
Author: Jean-Philippe Brucker <jpb@kernel.org>

misc/arm-cla: Add driver skeleton and documentation

This adds the initial Kconfig, build-system plumbing, and driver header
definitions for the Arm Core Local Accelerator driver. It also adds
documentation describing the CLA programming model and access rules.

> diff --git a/drivers/misc/arm-cla/arm-cla-regs.h b/drivers/misc/arm-cla/a=
rm-cla-regs.h
> new file mode 100644
> index 0000000000000..fcd187ecb7771
> --- /dev/null
> +++ b/drivers/misc/arm-cla/arm-cla-regs.h
> @@ -0,0 +1,177 @@
[ ... ]
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +
> +/* Registers */
> +#define CLA_REG_DATA(i)			(0x00 + (8 * (i)))
[ ... ]
> +#define CLA_PLxCTRL_AVAIL		BIT(0)
> +#define CLA_PLxCTRL_DBGPERM		GENMASK(3, 1)
> +#define CLA_PLxCTRL_PREP(accid, v)	((u64)(v) << (8 * (accid)))

[Severity: Low]
Should linux/types.h be included in drivers/misc/arm-cla/arm-cla-regs.h?

The CLA_PLxCTRL_PREP macro casts the value to u64, but the header doesn't
include linux/types.h. This could lead to build failures if the header is
included directly in new source files without prior type inclusions.

[ ... ]
> +/* Common register offsets */
> +#define CLA_MTC_PSTATE			0
> +#define CLA_MTC_TTBR0			1
> +#define CLA_MTC_TTBR1			2
> +#define CLA_MTC_TCR			3
> +#define CLA_MTC_SCTLR			4
> +#define CLA_MTC_MAIR			5
> +#define CLA_MTC_TCR2			8
> +
> +/* EL2 specific register offsets */
> +#define CLA_MTC_HCR_EL2			80
> +#define CLA_MTC_VTTBR_EL2		81
> +#define CLA_MTC_VTCR_EL2		82

[Severity: Medium]
Are these EL2 specific register offsets intended to be relative offsets lik=
e the
common ones (0-8)?

They are currently defined as absolute indices (80, 81, 82). If the driver
applies these by adding the base index (e.g., CLA_MTC_REGIDX_PL2, which is =
64)
to the offset, using CLA_MTC_HCR_EL2 (80) would yield an index of 144. This
would exceed the defined CLA_MTC_PL_SIZE (64) and target the wrong hardware
address space.

> diff --git a/drivers/misc/arm-cla/arm-cla.h b/drivers/misc/arm-cla/arm-cl=
a.h
> new file mode 100644
> index 0000000000000..f265d7b602686
> --- /dev/null
> +++ b/drivers/misc/arm-cla/arm-cla.h
> @@ -0,0 +1,38 @@
[ ... ]
> +#include <linux/types.h>
> +
> +#include "arm-cla-regs.h"
> +
> +/* Number of accelerators per CLA */
> +#define CLA_NUM_ACC		8
> +#define CLA_NUM_DATA_REGS	8
> +#define CLA_SRSTATE_LEN		8
> +
> +/**
> + * struct cla_dev - CLA device
> + *
> + * Immutable state:
> + * @cpu:		The CPU this CLA is attached to.
> + * @dev:		The platform device.
> + */
> +struct cla_dev {
> +	unsigned int cpu;
> +	struct device *dev;
> +};
> +
> +#define cla_dbg(dev, fmt, ...) \
> +	dev_dbg((dev)->dev, "[%u] " fmt, (dev)->cpu, ##__VA_ARGS__)

[Severity: Low]
Does this header need to include linux/device.h and linux/dev_printk.h?

The cla_dbg macro uses dev_dbg() and dereferences struct device. Relying on
implicit inclusions can cause build issues if arm-cla.h is included in
a different order or in new files.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717104759.1232=
03-1-ryan.roberts@arm.com?part=3D1
