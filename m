Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EE7C55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A78710EED2;
	Thu, 30 Jul 2026 13:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MF1o1UqE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9080D10EED2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:52:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1642740D75;
 Thu, 30 Jul 2026 13:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D2A1F000E9;
 Thu, 30 Jul 2026 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785419528;
 bh=zn/kZKB0ZHrY3ckEzzFFPRDvk/t0mHA9yIAA2VD0pGM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MF1o1UqEl+uetZxTBADGNdIP4HGsSWuQggFkJBj8QutmMI3ChNX67tOzwPqZ1T5HE
 MFGGHhGS15hYX/epFquEpSpPEja1bffHu1qFpsLPdH2kcqiZvrT5cVf0XdDhGUcwO4
 MshcyMwAQHDeRzurLIJhHaX1L2P7KwYx5InrOPjDUzvQ4x52O97Kg4iruIoturCipP
 hLNwcnzZsl34lToz0ELGe820Jvyz/LWIqG/p/OvJmdKKpexKUAfETwKJcSnm5fjzan
 KbdOw9ld8YoOdNAt8JadWmVhRprKDoGOzR+6GPHIH70RxdQoFbR72G/vC0GzCf1DdV
 J4bhqO/3ImZnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] iommu/msm: track a context master per device and IOMMU
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:52:07 +0000
Message-Id: <20260730135207.C2D2A1F000E9@smtp.kernel.org>
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
- [High] Incomplete Refactoring breaking Device Attachment for Shared IOMMU=
s.

Pre-existing issues:
- [High] Out-of-bounds Read / Undefined Behavior due to `list_first_entry()=
` on potentially empty `ctx_list`.
- [High] Lockless Access / Race Condition during TLB flushes iterating over=
 `ctx_list`.
--

--- Patch [1]: [PATCH 1/3] iommu/msm: track a context master per device and=
 IOMMU ---
commit c8d40e4c746f720804d5ad115bf7e9dd560b624f
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

iommu/msm: track a context master per device and IOMMU

insert_iommu_master() decided whether to allocate a struct
msm_iommu_ctx_dev by testing whether the IOMMU's ctx_list was empty,
caching the result in dev_iommu_priv, then unconditionally dereferenced
the master.

> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 4ef1e8c8244b0..aab87ccbcada9 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -601,24 +601,27 @@ static int insert_iommu_master(struct device *dev,
>  				struct msm_iommu_dev **iommu,
>  				const struct of_phandle_args *spec)
>  {
[ ... ]
> -	if (list_empty(&(*iommu)->ctx_list)) {
> -		master =3D kzalloc_obj(*master, GFP_ATOMIC);
> -		if (!master) {
> -			dev_err(dev, "Failed to allocate iommu_master\n");
> -			return -ENOMEM;
> -		}
> -		master->of_node =3D dev->of_node;
> -		list_add(&master->list, &(*iommu)->ctx_list);
> -		dev_iommu_priv_set(dev, master);
> +	/* A master describes one device on one IOMMU instance. */
> +	list_for_each_entry(master, &(*iommu)->ctx_list, list)
> +		if (master->of_node =3D=3D dev->of_node)
> +			goto add_sid;
> +
> +	master =3D kzalloc_obj(*master, GFP_ATOMIC);
> +	if (!master) {
> +		dev_err(dev, "Failed to allocate iommu_master\n");
> +		return -ENOMEM;
>  	}
> +	master->of_node =3D dev->of_node;
> +	list_add(&master->list, &(*iommu)->ctx_list);

[Severity: High]
Is it possible this change breaks device attachment for shared IOMMUs?

By allowing multiple masters to be added to ctx_list, find_iommu_for_dev()
and msm_iommu_attach_dev() might fail because they still only check the
first entry:

drivers/iommu/msm_iommu.c:find_iommu_for_dev() {
    master =3D list_first_entry(&iommu->ctx_list,
                              struct msm_iommu_ctx_dev,
                              list);
    if (master->of_node =3D=3D dev->of_node) {
    ...
}

When a second device probes, it is added to the head of the list. When the
first device subsequently tries to attach, it would compare its of_node
against the new head (the second device), fail the match, and return -ENODE=
V.

Furthermore, when a match is found in msm_iommu_attach_dev(), it iterates
over all masters in ctx_list (even those belonging to other devices):

drivers/iommu/msm_iommu.c:msm_iommu_attach_dev() {
    ...
    list_for_each_entry(master, &iommu->ctx_list, list) {
        if (master->num) {
            dev_err(dev, "domain already attached");
    ...
}

Will this improperly attach all devices sharing the IOMMU to the same domai=
n,
breaking domain isolation?

[Severity: High]
This isn't a bug introduced by this patch, but could calling
list_first_entry() on a potentially empty ctx_list cause an out-of-bounds
read?

During device probe, find_iommu_for_dev() and msm_iommu_attach_dev() iterate
over all registered IOMMUs in qcom_iommu_devices and unconditionally call
list_first_entry():

drivers/iommu/msm_iommu.c:find_iommu_for_dev() {
    master =3D list_first_entry(&iommu->ctx_list,
                              struct msm_iommu_ctx_dev,
                              list);
    if (master->of_node =3D=3D dev->of_node) {
    ...
}

If an IOMMU has been registered but no devices have been attached to it yet
(such as during early bus probing), its ctx_list is empty. list_first_entry
on an empty list yields an invalid pointer.

Could this lead to a panic via page fault when master->of_node is
dereferenced?

[Severity: High]
This is a pre-existing issue, but does using list_add() here introduce a ra=
ce
condition with concurrent lockless readers?

The TLB flush functions (__flush_iotlb and __flush_iotlb_range) iterate over
iommu->ctx_list without holding msm_iommu_lock or using RCU primitives:

drivers/iommu/msm_iommu.c:__flush_iotlb() {
    ...
    list_for_each_entry(master, &iommu->ctx_list, list)
        SET_CTX_TLBIALL(iommu->base, master->num, 0);
    ...
}

At the same time, insert_iommu_master() modifies this same ctx_list using
list_add() (a non-RCU primitive) while holding msm_iommu_lock.

Since this patch allows multiple masters per IOMMU, can a concurrent TLB
flush observe torn pointers or partially initialized nodes if a second devi=
ce
is probed while the first device is actively performing DMA/unmap operation=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-fix-qcom-s=
mmu-v1-0-b12fa067804e@oss.qualcomm.com?part=3D1
