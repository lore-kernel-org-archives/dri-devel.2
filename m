Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F771CD8CB2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2CD10ECDA;
	Thu, 11 Jun 2026 06:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Usr28TQR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 917A610ECDA
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:06:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC56C60209;
 Thu, 11 Jun 2026 06:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AD31F00893;
 Thu, 11 Jun 2026 06:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781157994;
 bh=GkhGAm04CjUjfbgcZQ2jbY+It/DnjbeeVeYe4rwyq5E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Usr28TQR+f50moF4NOaEEiRZkzEWwoFzdjqvsuhUAvgLxZDCae/YErrOfipeYnRyH
 qIAOX9mGups49UhlwdlpcUUsxZnq2rV5ckpGanCTM8Jnsuxgl+TpJDKX0gTKhPX9sJ
 Hk+myN4rC51LbtSJXWEodEghqCsyywWvAfF+eKDRKQcdFAAh5k8WISULSuJOiPt4HW
 /jYcb3s+9zho52UG4pd6nvsBMt9MpUKqdI9LWpAMSS098mscxDC6puOBh9IuJVmgLD
 ZtlR0PZGEBJvCmaTp8hlGvE5TqaQTHLH9Enr+5bRnC5TAPe2Cvmi2aL8EZszWmJn/s
 9WIItlLf+za4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 1/3] accel/amdxdna: Fix amdxdna_client lifetime race
 during device removal
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611055150.3070216-1-lizhi.hou@amd.com>
References: <20260611055150.3070216-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:06:34 +0000
Message-Id: <20260611060634.77AD31F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Ignored return value of `drmm_mutex_init()` for `xdna->client_lo=
ck` can result in using a destroyed mutex.

Pre-existing issues:
- [High] Missing drm_dev_enter() in amdxdna_drm_open() and ioctls allows ra=
ces with device unplug, leading to use-after-free and hardware access on to=
rn-down devices.
- [High] Unchecked return value of `init_srcu_struct()` allows execution wi=
th an uninitialized SRCU context.
--

commit 16ed88a14ca5cdcb72cc707cc054f2d2b9526777
Author: Lizhi Hou <lizhi.hou@amd.com>
accel/amdxdna: Fix amdxdna_client lifetime race during device removal

This patch decouples hardware teardown from client cleanup in the amdxdna
driver. It restricts amdxdna_remove() to hardware-related cleanup and=20
defers releasing per-client resources to amdxdna_drm_close() when the file
is actually closed.

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index 65489bb3f2b07..470bf4fc744bf 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -138,9 +138,11 @@ static int amdxdna_drm_open(struct drm_device *ddev,=
 struct drm_file *filp)
>  		    xdna->dev_info->dev_heap_max_size);
>  	mutex_init(&client->mm_lock);
> =20
> +	mutex_lock(&xdna->client_lock);
>  	mutex_lock(&xdna->dev_lock);
>  	list_add_tail(&client->node, &xdna->client_list);
>  	mutex_unlock(&xdna->dev_lock);
> +	mutex_unlock(&xdna->client_lock);

[Severity: High]
This is a pre-existing issue, but does amdxdna_drm_open() need to check the
return value of init_srcu_struct() called just prior to this block?=20

If the internal allocation fails and returns -ENOMEM, the SRCU context
remains uninitialized, which could lead to a NULL pointer dereference when
later using srcu_read_lock().

[Severity: High]
This is also a pre-existing issue, but should amdxdna_drm_open() and ioctls
like amdxdna_drm_get_info_ioctl() be protected by drm_dev_enter()?

Without it, an open operation could race with device unplug, successfully
bind SVA after amdxdna_remove() has processed the client list, and then
later cause a use-after-free during amdxdna_drm_close() when it attempts to
unbind SVA on a torn-down IOMMU.=20

Similarly, an unprotected ioctl could access hardware state after it has
been torn down.

[ ... ]

> @@ -372,6 +370,7 @@ static int amdxdna_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>  		return -ENODEV;
> =20
>  	drmm_mutex_init(ddev, &xdna->dev_lock);
> +	drmm_mutex_init(ddev, &xdna->client_lock);

[Severity: Medium]
Is it safe to ignore the return value of drmm_mutex_init() here?=20

If the internal memory allocation for the managed cleanup action fails, the
macro will automatically destroy the mutex and return an error code. Since
amdxdna_probe() ignores this and continues, could subsequent driver
operations end up using a destroyed mutex?

>  	init_rwsem(&xdna->notifier_lock);
>  	INIT_LIST_HEAD(&xdna->client_list);
>  	pci_set_drvdata(pdev, xdna);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611055150.3070=
216-1-lizhi.hou@amd.com?part=3D1
