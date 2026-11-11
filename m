Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4875606A331
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AR62WAXQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE1810FC7C;
	Wed, 11 Nov 2026 17:09:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3876910FC7C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:09:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D308542A8B;
 Wed, 11 Nov 2026 17:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820831F00A06;
 Wed, 11 Nov 2026 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794416948;
 bh=cOfFlp6bO6i/FqBYSiep7rAGIpU7paxYRheGtlQOPBo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AR62WAXQ1Lg/Mo1XeIcZw0Wcs7dIjwbMObrZprydMC5IwfIR3iS5YICAD82UAlFwV
 3e9Xz/0iTVANeVKpM0Gmv4HjZ78Z21luAIwLiYe1/IS4/q06QXQHmzhqa+7YfDRmyf
 7VpNP1EKEb2i9Gncj6Cv5gtvpr3yCw2kw1DUJZMGbRYZOfwJDxhHxMG5B13psCMmX6
 WbaA3ShhfMS1By8yv0UKSZzrOpI1hjQKb5mE/AR9c3E9Q5V1WJEVKxyU0XHwkt79rc
 WN7+iCHnimWle6KTZDPb293/TRs5WVaXmtM8tiF8eZ8s8CLtEF3GMj+1mxqaT1exuH
 m3FyKlhYBBLfg==
Message-ID: <sashiko-outbox-209377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] PCI: Cache bridge firmware secondary bus number
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-vfct-regression-v6-1-393797bbb6e3@amd.com>
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
 <20261111-vfct-regression-v6-1-393797bbb6e3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:09:08 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: dead fw_sec_bus_sampled in pci_read_bridge_windows() and
  log mismatch
--

commit 263ccf4863cf26244ff7441d7c145a467a3a1fcd
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI: Cache bridge firmware secondary bus number

This commit caches the firmware-assigned secondary bus number on bridge
devices in pci_read_bridge_windows() so downstream devices can query the
original bus number after bus renumbering.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..f20a4b8f7a23b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -505,14 +505,26 @@ static void pci_read_bridge_windows(struct pci_dev =
*bridge)
>  {
>  	u32 buses;
> +	u8 secondary;
> +	u8 subordinate;
>  	u16 io;
>  	u32 pmem, tmp;
>  	struct resource res;
> =20
>  	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
>  	res.flags =3D IORESOURCE_BUS;
> -	res.start =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> -	res.end =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	secondary =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> +	subordinate =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	res.start =3D secondary;
> +	res.end =3D subordinate;
> +
> +	if (!bridge->fw_sec_bus_sampled) {
> +		bridge->fw_sec_bus_sampled =3D true;
> +		if (secondary > 0 && secondary < 0xff) {
> +			bridge->fw_sec_busnr =3D secondary;
> +			bridge->fw_sec_bus_valid =3D true;
> +		}
> +	}

[Severity: Low]
As reported by Lazar, Lijo on v5 [1], is bridge->fw_sec_bus_sampled needed
here, and does the commit message match where the bus number is now saved?

pci_read_bridge_windows() is only called from pci_setup_device() ->
pci_scan_device() when a struct pci_dev is first allocated and zeroed.
Later bus rescans find the existing device in pci_scan_single_device() via
pci_get_slot() and return early without calling pci_setup_device() or
pci_read_bridge_windows() again, so fw_sec_bus_sampled is always false on
entry and is never read elsewhere.

Also, the commit message still describes saving the bus number during pass
0 of bridge scanning and guarding against rescans, which no longer matches
caching it in pci_read_bridge_windows() (and since a valid secondary bus
number is always non-zero, fw_sec_bus_valid is redundant with checking
fw_sec_busnr !=3D 0).

[1] https://lore.kernel.org/r/eba45235-a6b1-4a48-9c56-9e069c299478@amd.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-vfct-regre=
ssion-v6-0-393797bbb6e3@amd.com?part=3D1
