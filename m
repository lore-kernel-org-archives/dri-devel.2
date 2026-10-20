Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C39606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WezSuAqu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCB110E1DB;
	Tue, 20 Oct 2026 01:51:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D15710E1F3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:51:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62349601FA;
 Tue, 20 Oct 2026 01:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE321F000C4;
 Tue, 20 Oct 2026 01:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792461109;
 bh=nS3t8PNTxr+6STLBPOKmbynDEcyP7pa8cVWuCTfFfro=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WezSuAqunr+msTkgraU4p38zLKnTQZ5Grn+DNT6cK3loMNEIwKgL4o2yt7yxBLzDn
 bsztUoIDoN5TBejC9aZYz4yYEkw234KtBgyN79nYR8YiL+gk3pF58dujJDmmR8Sfud
 NOUfScg8xs+m90xIwf79mB28rkWlSdisuInLzMiUiWTd0H78wIWnn3TC4G8h6gRqV9
 lHaZtdLGNgGgMzmUsN8rX67DKUi/UObkDklVYKQ9QtceS8neEgsgJ/se4/AVGxQ1sa
 Etd54fE8m1LYM3FEJ6UCpda6TqV9M1uNbMz4YMhwYDklWtFmT/WMV6A6k5/4JZcsKS
 udDgJzobkyZqA==
Message-ID: <sashiko-outbox-178418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: Preserve the initial bus number in pci_dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261019-vfct-regression-v1-1-5a63ddd378dd@amd.com>
References: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
 <20261019-vfct-regression-v1-1-5a63ddd378dd@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:51:48 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI: NULL pointer dereference in pci_alloc_dev() when bus is NULL
--

commit 8257f74f7a4f8e2e670cc3291997e9d0a2cd7a56
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI: Preserve the initial bus number in pci_dev

This commit adds an initial_bus_number field to struct pci_dev and populates
it during pci_alloc_dev() so drivers can match devices using their initial
firmware-visible bus number even after bus number reassignment.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..580b288d5c64f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2508,6 +2508,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  	INIT_LIST_HEAD(&dev->bus_list);
>  	dev->dev.type =3D &pci_dev_type;
>  	dev->bus =3D pci_bus_get(bus);
> +	dev->initial_bus_number =3D bus->number;

[Severity: High]
Can bus be NULL here?

pci_bus_get() in drivers/pci/bus.c explicitly checks if bus is NULL before
dereferencing it:

struct pci_bus *pci_bus_get(struct pci_bus *bus)
{
	if (bus)
		get_device(&bus->dev);
	return bus;
}

There are also several in-tree callers that pass NULL to pci_alloc_dev(),
such as make_local_pdev() in drivers/scsi/megaraid.c, alpha_core_agp_setup()
in drivers/char/agp/alpha-agp.c, and parisc_agp_setup() in
drivers/char/agp/parisc-agp.c:

	*pdev =3D pci_alloc_dev(NULL);

Wouldn't dereferencing bus->number unconditionally in pci_alloc_dev() cause
a NULL pointer dereference for these callers?

>  	dev->driver_exclusive_resource =3D (struct resource) {
>  		.name =3D "PCI Exclusive",
>  		.start =3D 0,

[ ... ]

>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-vfct-regre=
ssion-v1-0-5a63ddd378dd@amd.com?part=3D1
