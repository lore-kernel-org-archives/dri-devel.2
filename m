Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5826CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40CE710ECD8;
	Thu, 11 Jun 2026 06:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HPPCR2HR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1BE10ECD8
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:03:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53E9643048;
 Thu, 11 Jun 2026 06:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5F61F00893;
 Thu, 11 Jun 2026 06:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781157832;
 bh=msKTlNpYzKlXKu5Hu0doBn+oKa0orbopMYpah3YSvmE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HPPCR2HRGCtxX9Ox/LJRBFE+RVvFT6KB7xT1RAcsG3gH/E1uhHgbce3T8tNyUA4TT
 WHjx+KG6ncOnRvFLebredhjfvHzD5Ke/kfVpwcP+DnVYAXg3kBpJdyX4ME37tcwNFm
 iVft4WxR13LZ5tKvREl8Oe+kauZUY4a/L7/L4+uwJzVXAiE96oNtxUnG8je0B+wDw8
 bvbuUul1D/pGZRw2efkfoYAasFkyZUnWXO1oooQSx9sK0F5S71OVSkGIAHBOcJRocO
 eryAJ0cDTZzBidUbNS9zyyQXy3V/9bbDrps9JHk+DKyW6m4g2yFCR9lM53buqg7OH8
 AyWaT12SaFuEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 2/3] accel/amdxdna: Fix notifier_wq lifetime race
 during device removal
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611055150.3070216-2-lizhi.hou@amd.com>
References: <20260611055150.3070216-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:03:51 +0000
Message-Id: <20260611060352.1A5F61F00893@smtp.kernel.org>
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
- [High] Asynchronous work item `amdxdna_hmm_unreg_work` dereferences a pot=
entially freed `vm_area_struct` during MMU notifier release.
--

commit 9bd885c56a90bdf89e66e4a081996397ef692196
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix notifier_wq lifetime race during device removal
   =20
This commit fixes a use-after-free race during device removal by converting
notifier_wq to use drmm_alloc_ordered_workqueue. This ensures the workqueue
lifetime is managed by DRM and remains valid until resources are released.

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index 470bf4fc744bf..b943c06a451ef 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
[ ... ]
> @@ -389,9 +389,9 @@ static int amdxdna_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>  	if (ret)
>  		return ret;
> =20
> -	xdna->notifier_wq =3D alloc_ordered_workqueue("notifier_wq", WQ_MEM_REC=
LAIM);
> -	if (!xdna->notifier_wq) {
> -		ret =3D -ENOMEM;
> +	xdna->notifier_wq =3D drmm_alloc_ordered_workqueue(ddev, "notifier_wq",=
 WQ_MEM_RECLAIM);
> +	if (IS_ERR(xdna->notifier_wq)) {
> +		ret =3D PTR_ERR(xdna->notifier_wq);

[Severity: High]
This is a pre-existing issue, but can the work items queued to this
workqueue trigger a use-after-free on a vm_area_struct?

Looking at drivers/accel/amdxdna/amdxdna_gem.c, when handling an
MMU_NOTIFY_UNMAP event, the hmm_unreg_work is queued to this notifier_wq
to execute asynchronously. The worker eventually calls amdxdna_umap_release=
()
which dereferences the vma:

if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
        mapping_clear_unevictable(vma->vm_file->f_mapping);

Since the work item is asynchronous, couldn't the core memory management
subsystem tear down the mapping and free the vm_area_struct before
amdxdna_umap_release() executes, leading to a use-after-free when accessing
vma->vm_file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611055150.3070=
216-1-lizhi.hou@amd.com?part=3D2
