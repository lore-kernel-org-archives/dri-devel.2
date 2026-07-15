Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F67C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB84010F0EF;
	Wed, 15 Jul 2026 14:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SXj8+Iox";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0DB10F0D9
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:19:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D0BAD42A72;
 Wed, 15 Jul 2026 14:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963351F000E9;
 Wed, 15 Jul 2026 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784125191;
 bh=lD2HksaOGQ3OpsivQGGXrTjZQHP/i3gax1OXplAHeFE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SXj8+Iox7/HDKoPv44gzrmr71RpxIijYUFA90QfKe9pH5knC2I1fjC10s+Jq2MX/h
 MgITlvgAImBnN9t7HllWnzVWVgq9dnwk/WPgcrnJTXavCgUiAXsiOw24puZJxzDr5i
 Rzn+UpV9owB0Fgh0gj2szpEQhkuuBtxfde+iC0BBwWpSy5nKAqeTmBWy7GLFR369X4
 AxKiGK97NsfJXzpV6tJ3Pjokh5GKoVYM98B0TxIzHfK//mcyxbuN9cd+7+G+FzTPat
 ob/Q5romi0DIPAvDt7NxgGug2pTaRAQGj4a77Rrz/ZfyynhR1bnvm35dXyB2djrPa0
 p4D6VPsZ+VI6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mtd: mtd_intel_dg: add survivability partition
To: "Alexander Usyskin" <alexander.usyskin@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715-cri_surviv-v1-1-61763a6f1076@intel.com>
References: <20260715-cri_surviv-v1-0-61763a6f1076@intel.com>
 <20260715-cri_surviv-v1-1-61763a6f1076@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:19:51 +0000
Message-Id: <20260715141951.963351F000E9@smtp.kernel.org>
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
- [High] Unsigned integer underflow in bounds checks allows out-of-bounds h=
ardware memory accesses when survivability mode is enabled.
--

--- Patch [1]: [PATCH 1/2] mtd: mtd_intel_dg: add survivability partition -=
--
commit 9f27e4e8d4c741d1106f13ea61bac2daf3838cad
Author: Alexander Usyskin <alexander.usyskin@intel.com>

mtd: mtd_intel_dg: add survivability partition

This commit adds an option to expose a fixed-sized survivability partition
starting from the beginning of storage. This can be used when the firmware
or hardware detects a failure involving a corrupted partition table,
allowing a full storage re-write.

> diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd=
_intel_dg.c
> index f2fa8f68d1905..d11ddc687c4ac 100644
> --- a/drivers/mtd/devices/mtd_intel_dg.c
> +++ b/drivers/mtd/devices/mtd_intel_dg.c
[ ... ]
> @@ -205,6 +206,13 @@ static unsigned int idg_nvm_get_region(const struct =
intel_dg_nvm *nvm, loff_t fr
>  {
>  	unsigned int i;
> =20
> +	/*
> +	 * When survivability region is enabled it positioned on index 0 and ha=
s region_id =3D 0
> +	 * Region 0 is special, via this region whole device memory can be acce=
ssed.
> +	 */
> +	if (nvm->survivability_enabled)
> +		return 0;
> +

[Severity: High]
Does this unconditional return of 0 create an underflow risk in the read,
write, and erase paths?

When survivability is enabled, idg_nvm_get_region() will always return
index 0. If nvm->size was inflated during initialization by parsing limits
from a corrupted partition table, a request could arrive with an offset
larger than nvm->regions[0].size.

In drivers/mtd/devices/mtd_intel_dg.c:intel_dg_mtd_read(), the bounds check
subtracts the offset from the region size:

    idx =3D idg_nvm_get_region(nvm, from);
   =20
    if (len > nvm->regions[idx].size - from)
        len =3D nvm->regions[idx].size - from;

If the from offset exceeds nvm->regions[0].size, the unsigned subtraction
will underflow, resulting in a very large value. This bypasses the length
truncation and allows out-of-bounds hardware memory accesses.

Could the same underflow occur in the bounds checks in intel_dg_mtd_write()
and intel_dg_mtd_erase()?

>  	for (i =3D 0; i < nvm->nregions; i++) {
>  		if ((nvm->regions[i].offset + nvm->regions[i].size - 1) >=3D from &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-cri_surviv=
-v1-0-61763a6f1076@intel.com?part=3D1
