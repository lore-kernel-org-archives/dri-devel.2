Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59569C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D2910EC08;
	Tue,  1 Sep 2026 08:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SiUwXMxj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B871810EC08
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:55:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F95441492;
 Tue,  1 Sep 2026 08:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9951F000E9;
 Tue,  1 Sep 2026 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788252927;
 bh=F7NP2+aACTgvDtigo+/r4ZBJvQ4uqczsBwLqSVNHXgQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SiUwXMxjG+66/FodulCHeCv65kZQLM/DvqOuc6PN+2NMfPR4Gz7JdwhR3f561Fcu9
 sOqOH09KolSES7MYJyIUDCT3yuVNff8thuiADBjmzy7av1gY3ey8UW97k5FMEIZWiZ
 UoKjZMHUS2P6ozqyFOQGBOe6FePS/6yRaZIr4QdWPS2tDp6QfUEMmnbpuEd6dZeyA8
 QE6gnY+gYbqGy1XxcQmcWuMJ8c0L3zwgnegOHMQO04TPmuTPdQWbMZkQ2JNAHi4xJF
 5hDC3oFFkyNdOeFPIkzetzgPcnsN+P7dceKZzwMWI8nk5rxLFp6PGXHG1q8PaZ65qf
 64cexfcYueC4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
To: "Xilin Wu" <sophon@radxa.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:55:26 +0000
Message-Id: <20260901085527.0F9951F000E9@smtp.kernel.org>
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

> The TC9563 PCI power-control driver powers off external downstream ports
> whose device tree nodes have status =3D "disabled".
>=20
> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
> powered-off port functions during PCI enumeration raises an Arm SError
> instead of returning an all-ones PCI error response. This prevents the
> board from completing boot.
>=20
> Commit 1a8c251cff20 ("PCI: move OF status =3D "disabled" detection to
> dev->match_driver") made disabled PCI functions remain discoverable so
> PCI fixups can still be applied, while suppressing driver binding later.
> Preserve that behavior for endpoint functions.
>=20
> For an unavailable node describing a PCI-to-PCI bridge, however, the
> node also represents a subordinate bus that must not be enumerated.
> Check the device tree node before reading the Vendor ID and return a PCI
> error response without accessing config space when such a bridge is
> disabled.
>=20
> Functions not described by device tree and disabled endpoint functions
> remain discoverable.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D1

