Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5495DC55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0AB10EFCE;
	Thu, 30 Jul 2026 16:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O9ZV6KP+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A70E10E4D5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:20:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D0D760A5C;
 Thu, 30 Jul 2026 16:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96891F000E9;
 Thu, 30 Jul 2026 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785428439;
 bh=LoS/wMYqXtA8xQSV077CZgrXXesftml0Qec3QyvykVQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O9ZV6KP+1wlO+HqstVF4SkjcjbE6qPs8rdKItZ9r8g+BeQ84Ii6OxCiu2J8JK5mWT
 rNTGtSPvuJ9aDSMra+Ca02MXkK9L7YRNH/wav+sIhK+zMdqBsZ9NG9X/A9HGXM7lbT
 qC+8pnYmCA49a+SQuCoZfCZJ9Z3UAjgG+VmOD5ix1bf2lGvSHM6xcl/RBy4b2+yiHJ
 0G6wr8oSYm4yctJ6fDbEGN+rGQ/jF5liEtK8ArhnGuLJajT/ANEmEV5+bVIpzcTpXE
 HX9B5HFm+i6o8a88H4HXrx0stpTYnxxrfuEos4FsY586NB/MDH+4HtINQn+Ab63aHL
 vE4qqoYJHZqtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] iommu/msm: use the IOMMU device for page table
 allocation
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730-fix-qcom-smmu-v2-2-18e0daf2d836@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v2-0-18e0daf2d836@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v2-2-18e0daf2d836@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:20:38 +0000
Message-Id: <20260730162038.C96891F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unchecked `list_first_entry` usage on potentially empty `ctx_l=
ist` causes out-of-bounds reads and fundamentally breaks support for multip=
le masters.
- [Critical] Adding an IOMMU device to a domain's list overwrites shared li=
st pointers, corrupting lists if attached to multiple domains.
- [Critical] Hardware registers are accessed during probe before bus clocks=
 are enabled.
- [High] I/O page tables are permanently leaked when an IOMMU domain is fre=
ed.
- [High] Attaching multiple devices to a domain unconditionally re-initiali=
zes locks and reallocates page tables, leaking memory and breaking domain c=
onsistency.
- [High] The `io_pgtable_ops` structure is leaked on error paths during dev=
ice attachment.
- [High] IOMMU clocks are left persistently enabled if device attachment fa=
ils.
--

--- Patch [2]: [PATCH v2 2/3] iommu/msm: use the IOMMU device for page tabl=
e allocation ---
commit e64cb01e4df1d4190662ca41772b64a8225c289f
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: iommu/msm: use the IOMMU device for page table allocation

This patch updates the MSM IOMMU driver to allocate page tables using the
IOMMU device rather than the client device. This prevents issues on ARM32
where the client device's DMA ops might map tables through the very IOMMU
they describe. It locates the IOMMU instance before configuring the domain
and passes its device to io-pgtable.

> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index d6ef17cf6d108..30e2d061ecd1d 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c

[ ... ]

> @@ -336,7 +335,8 @@ static void msm_iommu_domain_free(struct iommu_domain=
 *domain)
>  	spin_unlock_irqrestore(&msm_iommu_lock, flags);
>  }

[Severity: High]
This is a pre-existing issue, but does msm_iommu_domain_free() permanently
leak the dynamically allocated page tables?

msm_iommu_domain_free() frees the priv container via kfree(priv) but does n=
ot
call free_io_pgtable_ops(priv->iop) to release the io-pgtable resources. Wi=
ll
this lead to a permanent memory leak when the domain is freed?

> =20
> -static int msm_iommu_domain_config(struct msm_priv *priv)
> +static int msm_iommu_domain_config(struct msm_priv *priv,
> +				   struct msm_iommu_dev *iommu)
>  {

[ ... ]

> @@ -400,8 +400,15 @@ static int msm_iommu_attach_dev(struct iommu_domain =
*domain, struct device *dev,
>  	struct msm_priv *priv =3D to_msm_priv(domain);
>  	struct msm_iommu_ctx_dev *master;
> =20
> -	priv->dev =3D dev;
> -	msm_iommu_domain_config(priv);
> +	spin_lock_irqsave(&msm_iommu_lock, flags);
> +	iommu =3D find_iommu_for_dev(dev);
> +	spin_unlock_irqrestore(&msm_iommu_lock, flags);
> +	if (!iommu)
> +		return -ENODEV;
> +
> +	ret =3D msm_iommu_domain_config(priv, iommu);

[Severity: High]
This is a pre-existing issue, but does unconditionally calling
msm_iommu_domain_config() on every device attach corrupt the shared domain=
=20
state?

When multiple devices are attached to an active IOMMU domain,=20
msm_iommu_attach_dev() executes msm_iommu_domain_config() for every attach.
This blindly executes spin_lock_init(&priv->pgtlock) and reassigns priv->iop
without freeing the previous allocation.

Could this permanently leak the first device's page tables and force the
driver to track a new structure that does not match the hardware state?

Additionally, there are a few pre-existing regressions in this file that mi=
ght
warrant review:

[Severity: Critical]
This is a pre-existing issue, but does the list lookup in=20
msm_iommu_attach_dev() safely handle an empty ctx_list?

drivers/iommu/msm_iommu.c:msm_iommu_attach_dev() {
    ...
	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
		master =3D list_first_entry(&iommu->ctx_list,
					  struct msm_iommu_ctx_dev,
					  list);
		if (master->of_node =3D=3D dev->of_node) {
    ...
}

If an IOMMU probes with no masters yet, could list_first_entry() generate a=
=20
bogus pointer and cause an out-of-bounds read on master->of_node?=20

Also, if an IOMMU has multiple masters, does this lookup inadvertently limit
matching to only the first appended master?

[Severity: High]
This is a pre-existing issue, but are the io-pgtable allocations permanently
leaked on the error path during device attachment?

drivers/iommu/msm_iommu.c:msm_iommu_attach_dev() {
    ...
				master->num =3D
					msm_iommu_alloc_ctx(iommu->context_map,
							    0, iommu->ncb);
				if (IS_ERR_VALUE(master->num)) {
					ret =3D -ENODEV;
					goto fail;
				}
    ...
fail:
	spin_unlock_irqrestore(&msm_iommu_lock, flags);

	return ret;
}

Since msm_iommu_domain_config() already succeeded in allocating priv->iop,=
=20
does jumping to the fail label and returning without unwinding priv->iop=20
permanently leak these resources?

[Severity: Critical]
This is a pre-existing issue, but does adding the IOMMU device to a domain's
list inadvertently corrupt the list if it is attached to multiple domains?

drivers/iommu/msm_iommu.c:msm_iommu_attach_dev() {
    ...
			__disable_clocks(iommu);
			list_add(&iommu->dom_node, &priv->list_attached);
		}
	}
    ...
}

Since dom_node is a single list_head in the shared msm_iommu_dev structure,=
=20
would attaching a second domain to the master forcefully overwrite its
next and prev pointers, breaking the first domain's list?

[Severity: High]
This is a pre-existing issue, but are the IOMMU clocks left persistently
enabled if device attachment fails?

drivers/iommu/msm_iommu.c:msm_iommu_attach_dev() {
    ...
		if (master->of_node =3D=3D dev->of_node) {
			ret =3D __enable_clocks(iommu);
			if (ret)
				goto fail;
            ...
				if (IS_ERR_VALUE(master->num)) {
					ret =3D -ENODEV;
					goto fail;
				}
    ...
fail:
	spin_unlock_irqrestore(&msm_iommu_lock, flags);

	return ret;
}

If an error occurs after __enable_clocks(), does jumping to the fail label
without calling __disable_clocks() leave the clocks unbalanced and drain
power?

[Severity: Critical]
This is a pre-existing issue, but are hardware registers accessed during pr=
obe
before the bus clocks are enabled?

drivers/iommu/msm_iommu.c:msm_iommu_probe() {
    ...
	msm_iommu_reset(iommu->base, iommu->ncb);
	SET_M(iommu->base, 0, 1);
	SET_PAR(iommu->base, 0, 0);
    ...
}

If the hardware is in a power-managed domain, would accessing unclocked=20
registers synchronously trigger an external abort and panic the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-fix-qcom-s=
mmu-v2-0-18e0daf2d836@oss.qualcomm.com?part=3D2
