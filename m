Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B81C55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9203610E685;
	Thu, 30 Jul 2026 16:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EnbjHEOd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388B710E12C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:24:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2517406A5;
 Thu, 30 Jul 2026 16:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8911F000E9;
 Thu, 30 Jul 2026 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785428682;
 bh=07qfWJ04WA6VLQNYAj86S7GSrjWrgwT376cdg4uFMCA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EnbjHEOdYZG4Eh0vaiDyD31uyooLlsP1fujiuqMtCpuI4bk2OBnqYyO8/JjDeE0fy
 Rk54tyyHtxOVzDajiHYdWhkr7DfW939QJts1Ss2xfKlIapBC933uLbnJaFP2iQ7eIC
 oRxP3lVUWyYNRsjgweyrka8MzW40ZSyDW+ZqaEkwGGp33TrH9yKmSHqya0o62dVE95
 g+7L7t7TDG9rtUJW3uJ+o0hW+HzS7fn64Bd8KK5eMqXWnJ3WToccqtUMH2aQYCY81c
 m11/4uwLu8BtqM/RVokT0Jp2iqz6Qa7TyoAEzkSfxBcsTzibX5o/S69kHZIVxPSjwA
 pT4XtrlJjq8wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] iommu/msm: track a context master per device and
 IOMMU
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730-fix-qcom-smmu-v2-1-18e0daf2d836@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v2-0-18e0daf2d836@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v2-1-18e0daf2d836@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:24:42 +0000
Message-Id: <20260730162442.AA8911F000E9@smtp.kernel.org>
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
- [High] Lookup and attach paths fail to walk the full ctx_list, breaking s=
upport for multiple devices per IOMMU, and causing out-of-bounds reads on e=
mpty lists.

Pre-existing issues:
- [High] Memory leak of `io_pgtable_ops` and associated page tables in `msm=
_iommu_domain_free`.
- [High] Attaching multiple devices to the same domain overwrites the domai=
n configuration, leaking page tables and destroying spinlocks.
--

--- Patch [1]: [PATCH v2 1/3] iommu/msm: track a context master per device =
and IOMMU ---
commit f63bf88b6236e0420150c158cf3fee05438de180
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

    iommu/msm: track a context master per device and IOMMU
   =20
    insert_iommu_master() decided whether to allocate a struct
    msm_iommu_ctx_dev by testing whether the IOMMU's ctx_list was empty,
    caching the result in dev_iommu_priv, then unconditionally dereferenced
    the master:

[ ... ]

>     Neither key is right. A master describes one device on one IOMMU
>     instance: the attach and lookup paths find a device on an IOMMU by
>     walking that IOMMU's ctx_list for a master whose of_node matches. The

[Severity: High]
Does this code actually walk the list as described?

Looking at find_iommu_for_dev() and msm_iommu_attach_dev() in
drivers/iommu/msm_iommu.c, it appears they only check the first entry:

	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
		master =3D list_first_entry(&iommu->ctx_list,
					  struct msm_iommu_ctx_dev,
					  list);
		if (master->of_node =3D=3D dev->of_node) {

Will this fail to attach any subsequently added devices on the same IOMMU,
and also cause an out-of-bounds read if the list is empty?

>     ctx_list emptiness test is per-IOMMU, and the dev_iommu_priv cache is
>     per-device, so the two disagree as soon as one device spans several

[ ... ]

> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 4ef1e8c8244b0..d6ef17cf6d108 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does msm_iommu_domain_free() leak the page
tables?

drivers/iommu/msm_iommu.c:msm_iommu_domain_free() {
    ...
    priv =3D to_msm_priv(domain);
    kfree(priv);
    ...
}

Should this call free_io_pgtable_ops(priv->iop) before freeing the priv
struct to avoid leaking the io_pgtable_ops and associated page tables?


[Severity: High]
This is a pre-existing issue, but does msm_iommu_attach_dev() overwrite the
domain configuration when attaching multiple devices to the same domain?

drivers/iommu/msm_iommu.c:msm_iommu_attach_dev() {
    ...
	priv->dev =3D dev;
	msm_iommu_domain_config(priv);
    ...
}

Does unconditionally calling msm_iommu_domain_config() for every attach
operation overwrite the priv->iop pointer (leaking the original page tables)
and re-initialize the page table lock (pgtlock), destroying any active lock
state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-fix-qcom-s=
mmu-v2-0-18e0daf2d836@oss.qualcomm.com?part=3D1
