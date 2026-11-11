Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05EC606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I38io5c7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B4D410E9A8;
	Wed, 11 Nov 2026 02:18:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C44D10E9A8
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 02:18:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD0DB63812;
 Wed, 11 Nov 2026 02:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CF41F0089F;
 Wed, 11 Nov 2026 02:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794363482;
 bh=KciehyaHcyjRA/0EwuWkFj2vKpQU1D4YWFxmm7Y+bhA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I38io5c75yu4iDPNmGhrY6LbFR6DvdXEFuuq7LQArkqnkrx1nbCATeQPqrudmiPWm
 fnUgOm9udpPYA0b3V2m7t3Wj3lrRpaYRX6GquSv47/267mG1QqAat8KKWvvrPADZk9
 agbo+NEtZIBEEaXcYIrYWMVF5czxZLqExaescjOee5ah1Q3rIW/wTroEalORq3GCuC
 AO/wdwKNnH0IG9mmNOg64wWPez15XXM0wKOKsFp46J6/GyhBSYvzRpNRtfseQk887/
 BYio0Q/1I5XySdr2RTksYWz/YLCLIeiWFpqHPU9HUwu2k8yIiJR6IlcGgaLSGken4M
 iRT25lavR46iQ==
Message-ID: <sashiko-outbox-208077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] PCI: Cache bridge firmware secondary bus number
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-vfct-regression-v5-1-f49fae981bf3@amd.com>
References: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
 <20261110-vfct-regression-v5-1-f49fae981bf3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:18:01 +0000
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
- [Medium] PCI: unconfigured secondary bus 0 cached as valid in
  pci_scan_bridge_extend()
--

commit fd23152db632066be6cd9884f50d5722e11a3151
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI: Cache bridge firmware secondary bus number

This commit caches a bridge's firmware-assigned secondary bus number on
struct pci_dev during pass 0 of bridge scanning so devices enumerated in
pass 1 can still access the original bus number after renumbering.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..14b3dd7dac271 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1418,6 +1418,10 @@ static int pci_scan_bridge_extend(struct pci_bus *=
bus, struct pci_dev *dev,
> =20
>  	pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
>  		secondary, subordinate, pass);
> +	if (!pass && !dev->fw_sec_busnr_valid) {
> +		dev->fw_sec_busnr =3D secondary;
> +		dev->fw_sec_busnr_valid =3D true;
> +	}

[Severity: Medium]
Does this mark dev->fw_sec_busnr_valid as true even when secondary is 0
(unconfigured by firmware or hot-plugged) or 0xff (failed config read)?

Bus 0 is the root bus and is never a valid secondary bus behind a bridge.
When firmware leaves a bridge unconfigured for pass 1 to assign, this caches
dev->fw_sec_busnr =3D 0 with dev->fw_sec_busnr_valid =3D true, so consumers
checking bridge->fw_sec_busnr_valid will use bus 0 instead of falling back
to pdev->bus->number.

Note that simply gating this assignment on secondary > 0 && secondary < 0xff
would leave dev->fw_sec_busnr_valid false on an initially unconfigured
bridge, allowing a later rescan to cache the runtime-assigned bus number, so
tracking whether pass 0 has already run may need to be separate from whether
fw_sec_busnr is valid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vfct-regre=
ssion-v5-0-f49fae981bf3@amd.com?part=3D1
