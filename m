Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EC2C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 552D610F2D4;
	Thu,  2 Jul 2026 11:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FNqtpt+Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2D410F2CB
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 11:04:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5605842A2D;
 Thu,  2 Jul 2026 11:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164E91F0155F;
 Thu,  2 Jul 2026 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782990280;
 bh=Bq03anLMCHT33HJ7S1NqbZzqCJ8qcgVqyBO+LmRFi+A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FNqtpt+ZmO2yztk7/I3uBjLZsK6lcKAUcsIAajdFoKwdiUhOOb6czmHKdNtzDusg1
 t720YqdH5kv0Ds+FnPO4/ikw8jHi9e0wo/ejWLlnC/bj74T+c9+o/uIS2Cm86opHq1
 mFKVSVNfJIbkIBpZWgj+SmUi+0Vlvq44KWaoq1/QUUoZof/dDgLJ8h6SHDvyzW3OBz
 DuqMAZU2vFULzZRAGhQx1IUogTFivPzcU9uYIYFyt+JlEddGQdrN1nBUT23DiLiYVb
 qaRtRVJwbxzZuHrEvjtPjFSkazqZr7U9tL+oiI/LkwYpj2Xp97/iOfaDyYyBDnQUxW
 SjpKr3YgWqT7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: add missing IRQ_DOMAIN select to
 QCOM_SCM
To: "Julian Braha" <julianbraha@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701110344.1999068-1-julianbraha@gmail.com>
References: <20260701110344.1999068-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 11:04:39 +0000
Message-Id: <20260702110440.164E91F0155F@smtp.kernel.org>
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
- [High] `qcom_scm_get_waitq_irq()` returns 0 on failure, but `qcom_scm_pro=
be()` only checks `if (irq < 0)`. This causes the driver to skip the fallba=
ck `platform_get_irq_optional()` and incorrectly attempt to request IRQ 0, =
leading to a probe failure.
--

commit a810ba9e83e9707877b7e2fd4e5099068b665038
Author: Julian Braha <julianbraha@gmail.com>

firmware: qcom: scm: add missing IRQ_DOMAIN select to QCOM_SCM

This commit adds the missing select for IRQ_DOMAIN to the QCOM_SCM kconfig.
This ensures the driver will compile successfully since it relies on
irq_create_fwspec_mapping().

> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index b477d54b495a6..9d137fa2aa232 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -7,6 +7,7 @@
>  menu "Qualcomm firmware drivers"
> =20
>  config QCOM_SCM
> +	select IRQ_DOMAIN

[Severity: High]
This is a pre-existing issue, but since this patch ensures the code
using irq_create_fwspec_mapping() is compiled, I noticed a potential
regression in how its return value is handled.

In drivers/firmware/qcom/qcom_scm.c:qcom_scm_get_waitq_irq():

	return irq_create_fwspec_mapping(&fwspec);

If irq_create_fwspec_mapping() fails, it returns 0. However, when
checked in qcom_scm_probe():

	irq =3D qcom_scm_get_waitq_irq(scm);
	if (irq < 0)
		irq =3D platform_get_irq_optional(pdev, 0);

Since 0 is not less than 0, the check misses the failure. Does this cause
the driver to skip the fallback path and incorrectly attempt to request
irq 0, resulting in a probe failure?

Should this check be updated to if (irq <=3D 0) to properly trigger the
fallback path?

>  	select QCOM_TZMEM
>  	tristate
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701110344.1999=
068-1-julianbraha@gmail.com?part=3D1
