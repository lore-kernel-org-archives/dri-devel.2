Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA84CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3540C10E107;
	Mon, 12 Oct 2026 13:27:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A293E10E107
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:27:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C022B60AA2;
 Mon, 12 Oct 2026 13:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5061F0089C;
 Mon, 12 Oct 2026 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811633;
 bh=2a8IY6ihrF/gTQ2fXArY+120l2A5nACvHhB7AIt2Bvs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bAYBjPppzrnzYJm/VDfb+Fl/rAzi2aynaH8l1Bex6+tEYUhnTmRvusx5PXPtwMWzP
 VUIBD+xFfqbRYkClqlIeMGiO2AetzdZNdPTGvmxOzIZMHhIomLwhLgVgnQimT5gIS+
 9Ql3wEFEMk99RTfrAKL4fcJ25msm8zMKBZb4Si6J/Z/DqMzOexzg3FeS1+Rh7dEVfc
 2UOcvBHuWhaq/KMkMlOXBh/wqufWd0A1N8JdMoNMwVG+AyslTrfuaFamj2zJc96Fn5
 XsarEJh883niEH0P0kH8OXVjj3Tf4JgmNsb7sSTItsU4eDhOAip3O64KBGYcYjv9hD
 hdwi1FKa8Q9KQ==
Message-ID: <sashiko-outbox-168177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 17/18] PCI/P2PDMA: Evaluate the ATS path for clients
 with ATS enabled
To: "Leon Romanovsky" <leon@kernel.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-17-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-17-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:27:12 +0000
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
- [High] pci: pci_p2pdma_distance_many() evaluates compatibility without ap=
plying client ATS constraints
--

commit 254b102fe424913edc3d5f94f8d41bc5d0de2b20
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Evaluate the ATS path for clients with ATS enabled

P2PDMA assumes every client issues Untranslated Requests. A device with
ATS enabled may translate any address it is handed, including a bus
address, and Translation Blocking can reject its Translated Requests on
a route the Untranslated answer called usable.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index e38081f797611..a5fc622e3114f 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c

[ ... ]

> @@ -1660,10 +1706,10 @@ pci_p2pdma_map_type_tlp(struct p2pdma_provider *p=
rovider, struct device *dev,
>  		 pci_p2pdma_map_type_name(type), type, provider_state);
> =20
>  	if (type =3D=3D PCI_P2PDMA_MAP_UNKNOWN)
> -		return calc_map_type_and_dist(pdev, client, &dist, tlp_flags,
> +		type =3D calc_map_type_and_dist(pdev, client, &dist, tlp_flags,
>  					      true);
> =20
> -	return type;
> +	return pci_p2pdma_client_map_type(pdev, client, per_mapping, type);
>  }

[Severity: High]
Does pci_p2pdma_distance_many() also need to apply these new ATS constraint=
s?

While this patch successfully updates pci_p2pdma_map_type_tlp() to evaluate=
 ATS
routing constraints for P2PDMA clients, pci_p2pdma_distance_many() continues
to evaluate mapping compatibility without them:

drivers/pci/p2pdma.c:pci_p2pdma_distance_many() {
    ...
		pci_client =3D find_parent_pci_dev(clients[i]);
		if (!pci_client) {
    ...
		map =3D calc_map_type_and_dist(provider, pci_client, &distance, 0,
					     verbose);
    ...
}

If a client has ATS enabled and its Untranslated route is usable but its
Translated route is blocked by Translation Blocking (or lacks a whitelisted
host bridge), pci_p2pdma_distance_many() evaluates the Untranslated mapping
with tlp_flags=3D0, and incorrectly returns success.=20

When the driver subsequently attempts to map memory, the ATS-aware mapping
logic will return PCI_P2PDMA_MAP_NOT_SUPPORTED and fail unexpectedly at
runtime, breaking the API contract of the distance validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D17
