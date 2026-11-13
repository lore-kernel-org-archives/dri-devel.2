Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E58606A33F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maJrQxHB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEDA510E6F1;
	Fri, 13 Nov 2026 01:05:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24F710E6E8;
 Fri, 13 Nov 2026 01:05:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B16D443461;
 Fri, 13 Nov 2026 01:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676931F000C5;
 Fri, 13 Nov 2026 01:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794531935;
 bh=Xor1D90R6iiLgXTH6Jj6+gZ7TXwLffLx35r4VJvkDic=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=maJrQxHBYDHvx+LuOe4ZPgDUH44hhKkJioVLZhm5y52tpkyaogIiD9NKUSal3Dc2M
 cfqx7aVkF2BGTP+CtNbDME2ass3KIGdXwWoMZ2GOtXwNdADg1CC6ecv8pj+nm9W45L
 Db1+sT4W8HfgX3MJdDZ9+ZHR3J1wGsjL6nSh5SI+Gf3Xr8T3WaMSCGYuJWVev9cOWc
 nbwBGpB0W3mDeP+MV4ZFwYr0oDSYBH0PFzgJFF+t2S5BwPv+PJ1D0z2wN3zjhKDCWf
 MvKFn/qoYaYT/G2BydKx8o16HfBYPq6JFRJi0yEC76BqslckHOjtVMMfw1GtWr50OL
 59ciCpY7pZp7A==
Message-ID: <sashiko-outbox-212033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] PCI: Cache bridge firmware secondary bus number
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-vfct-regression-v7-1-69b1e0cf45c2@amd.com>
References: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
 <20261112-vfct-regression-v7-1-69b1e0cf45c2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:05:35 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: dead fw_sec_bus_sampled in pci_read_bridge_windows() and
  log mismatch
--

commit d3720492f32e5a284ef73b3dc9f69d02b13df2c4
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI: Cache bridge firmware secondary bus number

This commit caches the firmware-assigned secondary bus number on a PCI
bridge's struct pci_dev in pci_read_bridge_windows() before bus renumbering
can occur.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..f20a4b8f7a23b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -505,14 +505,26 @@ static void pci_read_bridge_mmio_pref(struct pci_de=
v *dev, struct resource *res,
>  static void pci_read_bridge_windows(struct pci_dev *bridge)
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
here?

pci_read_bridge_windows() is only called from pci_setup_device() when
pci_scan_device() first allocates and initializes a new struct pci_dev.  On
later bus rescans, pci_scan_single_device() finds the existing device via
pci_get_slot() and returns early without calling pci_setup_device() or
pci_read_bridge_windows().  Because pci_read_bridge_windows() runs at most
once per bridge instance on a zero-initialized struct pci_dev,
fw_sec_bus_sampled is always false on entry and is never read elsewhere,
making the bitfield and the commit message's rescan explanation unnecessary.
In addition, since bus 0 is the root bus and fw_sec_busnr is only set when
secondary > 0 && secondary < 0xff, fw_sec_bus_valid is redundant with
checking whether fw_sec_busnr is non-zero.

[1] https://lore.kernel.org/r/eba45235-a6b1-4a48-9c56-9e069c299478@amd.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-vfct-regre=
ssion-v7-0-69b1e0cf45c2@amd.com?part=3D1
