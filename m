Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13858C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1F110EF76;
	Thu, 20 Aug 2026 08:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PcHIV64T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3443D10EF7A
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:57:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E103040900;
 Thu, 20 Aug 2026 08:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40021F00A3A;
 Thu, 20 Aug 2026 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787216264;
 bh=ITz6/HpahUbMyKH9h7gEp7gHICi4t26dNBTktcjU9U4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PcHIV64T5dlgSRhVRA+LvCCNZumbsoQrsn1WCgOEgdYPviHeSIhtgfn2R4/OttAiD
 R1yu5em57XB6a/zvIgz9lS2851rhFvPikjpONugz3vu7iAylvjszUuKYHVkbLgiGGq
 wlj+5CVUjaeMcj/xThAum1CedyKijZT6O7EiHvKOPTHsLWeGqj+G/I1OIXf9JHOdaY
 PrRGlt+booinW/qB7dY26qHoW46a5mY2JSx5BaVJu3ylITdB6TVvOGlowQkfcGwohc
 weDZvsunik9e/fqtL1c51PP0F7R54xnOMqAC7hIzKR9dnJ2IaNJpKB0ohpc+EMpevN
 95Os80NZ4zbAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel: habanalabs: pm: use SIMPLE_DEV_OPS for pm struct
To: "Li Jun" <lijun01@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819065917.2488984-1-lijun01@kylinos.cn>
References: <20260819065917.2488984-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 08:57:43 +0000
Message-Id: <20260820085744.A40021F00A3A@smtp.kernel.org>
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
- [Low] The patch uses the explicitly deprecated `SIMPLE_DEV_PM_OPS` macro,=
 introducing `-Wunused-function` compiler warnings when `CONFIG_PM_SLEEP` i=
s disabled.
--

--- Patch [1]: [PATCH] accel: habanalabs: pm: use SIMPLE_DEV_OPS for pm str=
uct ---
commit 7be438c53b791de9d91a0802f0d42bfdaf8018e9
Author: Li Jun <lijun01@kylinos.cn>

accel: habanalabs: pm: use SIMPLE_DEV_OPS for pm struct

This commit replaces the manual assignment of dev_pm_ops with the
SIMPLE_DEV_PM_OPS macro to ensure the freeze, thaw, poweroff, and restore
callbacks are properly assigned and to prevent errors in s4.

> diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/a=
ccel/habanalabs/common/habanalabs_drv.c
> index 220954d730136..ca316f495fe61 100644
> --- a/drivers/accel/habanalabs/common/habanalabs_drv.c
> +++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
> @@ -1630,10 +1630,7 @@ static void hl_pci_reset_done(struct pci_dev *pdev)
>  	hl_device_reset(hdev, flags);
>  }
> =20
> -static const struct dev_pm_ops hl_pm_ops =3D {
> -	.suspend =3D hl_pmops_suspend,
> -	.resume =3D hl_pmops_resume,
> -};
> +static SIMPLE_DEV_PM_OPS(hl_pm_ops, hl_pmops_suspend, hl_pmops_resume);

[Severity: Low]
Will this introduce -Wunused-function warnings for hl_pmops_suspend() and
hl_pmops_resume() when the kernel is built with CONFIG_PM_SLEEP disabled?

Since SIMPLE_DEV_PM_OPS evaluates to empty when CONFIG_PM_SLEEP=3Dn, and the
callback functions lack the __maybe_unused attribute, they become completely
unreferenced.

Would it be better to use the modern DEFINE_SIMPLE_DEV_PM_OPS() macro
instead, which uses pm_sleep_ptr() to safely drop the references without
triggering compiler warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819065917.2488=
984-1-lijun01@kylinos.cn?part=3D1
