Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1B4CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B3210F177;
	Wed, 30 Sep 2026 04:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oz5sXAJ1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35FE10F177
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:00:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C6AF601DE;
 Wed, 30 Sep 2026 04:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DC11F000FF;
 Wed, 30 Sep 2026 04:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790740846;
 bh=OaxzJgw4HaoU9abiRnIVopiM1i40QZJM6de289U3q/o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oz5sXAJ1/eoegQgdvBe4+rKiHBdQ0rJiDdNllv7aroUlnpPcu51crBNFO1/m/o/0F
 Gjw0U0l+xO9J1QIMlH8GDHEfRZ7qHPYJRGtTsnVkCOotVhBoOZprpZZyvz8Hp8/ttu
 fknxJceuhhvXnbE5JsFjBb7cOCMb/sj1elXDXT0D5RJFRgZ5Hd0VmQHO6jayGacZYw
 n5z1zjxPhmqs/1mcSIxrTZtLTpugAAMBdPk02rYvGgZl4LF2U9tVqYNMxoUa5tdylL
 nWi5dF9RpeGu1bmQ/J6L/8vLDnuuLYVjdGA8nZNRr+DnfgHKJM/iSTZD9IFMIrZPx2
 x0REavYQCO2dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 18/20] accel/amdxdna: Implement runtime suspend and
 resume support
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-19-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-19-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:00:45 +0000
Message-Id: <20260930040045.D5DC11F000FF@smtp.kernel.org>
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
- [Low] pm: dev_pm_ops and runtime callbacks lack pm_ptr() wrappers
--

commit 43e22dab09d226fdbeb4b68267732652cfce0172
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Implement runtime suspend and resume support

Add runtime suspend/resume for AIE4 driver. This updates amdxdna_pm.c
to implement amdxdna_pm_runtime_suspend() and amdxdna_pm_runtime_resume(),
and acquires an RPM reference across amdxdna_sriov_configure().

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index 1d0b91e732602..4933962844f94 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -467,18 +467,27 @@ static void amdxdna_remove(struct pci_dev *pdev)
> =20
>  static const struct dev_pm_ops amdxdna_pm_ops =3D {
>  	SYSTEM_SLEEP_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume)
> -	RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL)
> +	RUNTIME_PM_OPS(amdxdna_pm_runtime_suspend, amdxdna_pm_runtime_resume, N=
ULL)
>  };

[Severity: Low]
Does this code introduce a regression by preventing the dev_pm_ops structure
and its callbacks from being optimized out?

When building with CONFIG_PM=3Dn, assigning the dev_pm_ops structure direct=
ly
without the pm_ptr() wrapper in the pci_driver definition:

static struct pci_driver amdxdna_pci_driver =3D {
	...
	.driver.pm =3D &amdxdna_pm_ops,
};

means the amdxdna_pm_ops structure and the newly added callbacks
(amdxdna_pm_runtime_suspend and amdxdna_pm_runtime_resume referenced via
RUNTIME_PM_OPS) will be linked into the kernel as dead code.

Should this assignment be updated to use pm_ptr(&amdxdna_pm_ops) to ensure
the dead code is eliminated when PM support is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D18
