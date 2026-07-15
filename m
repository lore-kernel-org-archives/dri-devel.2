Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C4FC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663FC10EE59;
	Wed, 15 Jul 2026 18:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LM+XKe5L";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0144E10EE59
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:03:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C46B61838;
 Wed, 15 Jul 2026 18:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50161F000E9;
 Wed, 15 Jul 2026 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784138610;
 bh=CJf1T9Sn4t5DNWf2vegcNJqYhDuTkVAr506bg49Dfj4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LM+XKe5LNQ075Sj5RY6MjsEcrCthq9U5bNvRi39IlueKCRy9yaKsZbRwfOVBw9Bj5
 qudaeoc7gEC22hi/O+Y5DLmqPNQYBaqDhx0TIX5RpmrvTmmqDcfuODyUq/4QBGtTl2
 ZziQSc+rBlKq8Z+9J4cMUvd8zs9Mj4lrR0C5Lq7RUCyC01UlRdY1yxDAcq7HS6JN2g
 GJuN+Yq15UFgTEe/ssG32Y86VOIhD49BdPmd0T2mfiB4ZyJWlWDaRfydKpSaN4bAh7
 fdzjkiftKpBNf+VMadhHd1+fVdMbMc8JlYWfTyOLgGXRpXOG9kxR5TbiYNwVwE6W+O
 CUxZmvknSIPeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
To: "Matt Evans" <matt@ozlabs.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260715174737.15287-3-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:03:29 +0000
Message-Id: <20260715180329.C50161F000E9@smtp.kernel.org>
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
- [High] Skipping `synchronize_rcu()` when `p2pdma->pool` is NULL causes a =
Use-After-Free of `pdev->p2pdma` and its XArray.
--

--- Patch [2]: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE ---
commit 963552636d1deb6dc48ba93e918ef61646e05d1a
Author: Matt Evans <matt@ozlabs.org>

PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE

This commit introduces CONFIG_PCI_P2PDMA_CORE and refactors the basic
provider functionality into a new p2pdma_core.c file. This allows drivers
to use pcim_p2pdma_provider() without a hard dependency on the full P2P DMA
management features.

> diff --git a/drivers/pci/p2pdma_core.c b/drivers/pci/p2pdma_core.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/p2pdma_core.c
[ ... ]
> +static void pci_p2pdma_release(void *data)
> +{
> +	struct pci_dev *pdev =3D data;
> +	struct pci_p2pdma *p2pdma;
> +
> +	p2pdma =3D rcu_dereference_protected(pdev->p2pdma, 1);
> +	if (!p2pdma)
> +		return;
> +
> +	/* Flush and disable pci_alloc_p2p_mem() */
> +	pdev->p2pdma =3D NULL;
> +	pci_p2pdma_release_pool(pdev, p2pdma);
> +	xa_destroy(&p2pdma->map_types);
> +}

[Severity: High]
This is a pre-existing issue, but does skipping synchronize_rcu() when the
pool is NULL lead to a use-after-free?

Looking at pci_p2pdma_release_pool() in drivers/pci/p2pdma.c, it skips
synchronize_rcu() if the pool has not been set up:

void pci_p2pdma_release_pool(struct pci_dev *pdev, struct pci_p2pdma *p2pdm=
a)
{
        if (!p2pdma->pool)
                return;

        synchronize_rcu();
        gen_pool_destroy(p2pdma->pool);
        sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
}

If a driver initializes P2PDMA without setting up a pool, p2pdma->pool
will be NULL. When the device is unbound, devres executes
pci_p2pdma_release().

Because pci_p2pdma_release_pool() returns early, synchronize_rcu() is
skipped. pci_p2pdma_release() then immediately calls
xa_destroy(&p2pdma->map_types) and the p2pdma structure is freed.

Could concurrent RCU readers, such as pci_p2pdma_map_type() during a
DMA-BUF mapping, access the destroyed xarray or the freed struct and
trigger a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D2
