Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A175C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF23110E5C9;
	Wed,  8 Jul 2026 10:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RWgMDt+X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDA010E5C9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 10:05:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEF1241FB4
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 10:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B991F000E9;
 Wed,  8 Jul 2026 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783505120;
 bh=DrCLEoqs4lxKdeGd94Ebzz7tops+Ir9FkUZooyLG98E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RWgMDt+X+IriXKJCfzSFmd71C/LEVkPZrzDkaXTtPtaNcQS2YqD133q/iOs9nkI1/
 By7/NgV+zgaaI1Q7aE2cOnrJo+7wxocYhoILzGVyEbhkyh7+pFZd27t0MQeQ91hu3O
 VmQwXSnMdnbwwAQ7427+bv7EEH683RSJg1oilUlGL1I+K8GieHgmU8IOuaBgA6PSH4
 tt3skucH1fm40I5yhJpcfkfyjDui1z59p3aR3dMv99l6IQgFBRLVEglb2PWapqPAdV
 NWemMBBfBa4e7NyyJFqnZMJUEpKG5luck4gubLEcl7zbk8tn2geU66YLWn3b2Qw468
 Yyba4oVAIxm9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/imx: include dc-drv.h to avoid sparse warning
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260708095645.385291-2-jirislaby@kernel.org>
References: <20260708095645.385291-1-jirislaby@kernel.org>
 <20260708095645.385291-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:05:19 +0000
Message-Id: <20260708100520.08B991F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The use of pm_sleep_ptr() discards runtime PM callbacks when CONFI=
G_PM is enabled but CONFIG_PM_SLEEP is disabled, leading to a kernel oops o=
n probe.
--

--- Patch [2]: [PATCH 2/2] drm/imx: include dc-drv.h to avoid sparse warnin=
g ---
commit 92fb37945f1af608d237fde0454ddaa90bee5644
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

drm/imx: include dc-drv.h to avoid sparse warning

This commit adds an include of dc-drv.h in dc-ic.c to fix a sparse warning.
The warning indicated that dc_ic_driver was not declared.

> diff --git a/drivers/gpu/drm/imx/dc/dc-ic.c b/drivers/gpu/drm/imx/dc/dc-i=
c.c
> index d8aa46ee6a7a0..0f2fc7aecf31f 100644
> --- a/drivers/gpu/drm/imx/dc/dc-ic.c
> +++ b/drivers/gpu/drm/imx/dc/dc-ic.c
> @@ -14,6 +14,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> =20
> +#include "dc-drv.h"
> +
>  #define USERINTERRUPTMASK(n)	(0x8 + 4 * (n))
>  #define INTERRUPTENABLE(n)	(0x10 + 4 * (n))

[ ... ]

drivers/gpu/drm/imx/dc/dc-ic.c:dc_ic_driver {
	.probe =3D dc_ic_probe,
	.remove =3D dc_ic_remove,
	.driver =3D {
		.name =3D "imx8-dc-intc",
		.suppress_bind_attrs =3D true,
		.of_match_table	=3D dc_ic_dt_ids,
		.pm =3D pm_sleep_ptr(&dc_ic_pm_ops),
	},
};

[Severity: High]
This isn't a bug introduced by this patch, but can using pm_sleep_ptr() here
cause a kernel oops on probe?

If the kernel is configured with CONFIG_PM=3Dy but CONFIG_PM_SLEEP=3Dn,
pm_sleep_ptr() evaluates to NULL, dropping the entire PM operations
structure including the runtime PM callbacks set by RUNTIME_PM_OPS().

During device probe, pm_runtime_resume_and_get() would execute successfully
since the device lacks PM callbacks. As a result, dc_ic_runtime_resume()
is skipped and the AXI clock (clk_axi) is never enabled.

The probe function then calls regmap_write() to mask and clear interrupts.
Does accessing memory-mapped registers over an unclocked AXI bus trigger a
synchronous external bus abort? Should this use pm_ptr() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708095645.3852=
91-1-jirislaby@kernel.org?part=3D2
