Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA29BC44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E4010ED6F;
	Tue,  7 Jul 2026 14:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k2N4TQ+V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A4710ED86
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:12:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 844E660018;
 Tue,  7 Jul 2026 14:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9E61F00A3E;
 Tue,  7 Jul 2026 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433535;
 bh=Gt09LEKUndiVYYYMJSzo6DYkKsxFB07zGbnbbg4BCQk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k2N4TQ+V4vLr6mOUnpMtQHmPAprYeJFQ2iNsLHJYinxKfP5omKlH9iCok7V0cRUPX
 Q/K5GPxdb6N5GpgE3OBcNriMI9r4ecgpYuupYEhSG6LJU4Q076cEznDHyif7YHa0k6
 onDBM/OBpWIoDGxWnjcbnkmvWZiVwOEpezhG6mfpnIlF+m+QlUIReg9sP2E+fd+g2J
 FpEUG/M5LXJoX5jYvvQfRd4kSpZZp8kSoGCacizsg80GZLoD83SRzDXh1DZbt0kyCe
 pHAA/4MbZ6OxnQ7QF0suYeD4lK2MF9//veQhFQNbXfGNVgYtrzCXEHbyHLKno3ShDV
 UxjaIKdStOCaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] ipack: tpci200: don't store pci_device_id
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, cassel@kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, dlemoal@kernel.org,
 linux-scsi@vger.kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-3-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-3-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:14 +0000
Message-Id: <20260707141214.CE9E61F00A3E@smtp.kernel.org>
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
- [High] Unconditional return of 1 in `ipack_unregister_bus_member` halts b=
us device iteration prematurely, leaving most devices orphaned but still re=
gistered.
--

commit 6023ba18e50f5578e133a944842fdee804f479b0
Author: Gary Guo <gary@garyguo.net>

    ipack: tpci200: don't store pci_device_id
   =20
    pci_device_id is not guaranteed to live longer than probe due to presen=
ce
    of dynamic ID. This stored ID is unused so remove it.

> diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tp=
ci200.c
> index 05dcb6675cd66..1cf51f7632932 100644
> --- a/drivers/ipack/carriers/tpci200.c
> +++ b/drivers/ipack/carriers/tpci200.c
> @@ -562,7 +562,6 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
> =20
>  	/* Save struct pci_dev pointer */
>  	tpci200->info->pdev =3D pdev;
> -	tpci200->info->id_table =3D (struct pci_device_id *)id;
> =20
>  	/* register the device and initialize it */
>  	ret =3D tpci200_install(tpci200);

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free duri=
ng
bus unregistration that I wanted to ask about.

When a carrier driver is unbound and calls ipack_bus_unregister(), it uses
bus_for_each_dev() to iterate and unregister child devices:

drivers/ipack/ipack.c:ipack_bus_unregister() {
    ...
	bus_for_each_dev(&ipack_bus_type, NULL, bus,
		ipack_unregister_bus_member);
	ida_free(&ipack_ida, bus->bus_nr);
	kfree(bus);
    ...
}

However, the callback unconditionally returns 1:

drivers/ipack/ipack.c:ipack_unregister_bus_member() {
    ...
	if (idev->bus =3D=3D bus)
		ipack_device_del(idev);

	return 1;
}

Since bus_for_each_dev() halts iteration on any non-zero return value, does
this stop after evaluating only the first device in the bus list?

If the iteration stops prematurely, the remaining devices would be orphaned=
 but
stay registered. Because ipack_bus_unregister() immediately frees the bus
structure after the iteration, could this result in a use-after-free if an
ipack client driver later binds to one of these orphaned devices or their s=
ysfs
attributes are accessed?

> diff --git a/drivers/ipack/carriers/tpci200.h b/drivers/ipack/carriers/tp=
ci200.h
> index e79ac64abcffa..a2bf3125794b7 100644
> --- a/drivers/ipack/carriers/tpci200.h
> +++ b/drivers/ipack/carriers/tpci200.h
> @@ -145,7 +145,6 @@ struct tpci200_slot {
>   */
>  struct tpci200_infos {
>  	struct pci_dev			*pdev;
> -	struct pci_device_id		*id_table;
>  	struct tpci200_regs __iomem	*interface_regs;
>  	void __iomem			*cfg_regs;
>  	struct ipack_bus_device		*ipack_bus;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D3
