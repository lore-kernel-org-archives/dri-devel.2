Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBCDC4450F
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A9410F03F;
	Wed, 15 Jul 2026 14:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gp7/MJgq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9749510F03F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:32:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2D8B600BB;
 Wed, 15 Jul 2026 14:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372901F00A3A;
 Wed, 15 Jul 2026 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784125923;
 bh=0oPGzhU/tG0FFJFd2Zn/8xnXqm2rg9zDCMAO6d6GufY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gp7/MJgqV/7CapAHG/b2nzap/P5a4JX/4/v30rBzRvoGZOzlqeoTPP5VKOydeDma2
 keZVDnVmlOtgXzKbFxSxx3fvKdOta2JiPtVWkf20ApkO46kMeaAR0g92zJ2zneRmmH
 QfiqXGKh5Ptzsz6HBWu1Hmvse9PZ2AtIUVPqwk3vvWYkXVNcWBK58QcuVSqZyZSM7X
 DNqQIIrToNjKiKVThcrsAAMFxwrMzVxeUHIhoeIbSQybzudnbrStmcFeCJiy7FwmM8
 nb72QcUR1o9R7QBjStEH5PkFzu/j2m1RvhUpeY8an2nTsbXVixlY7yNKSZESWJB63+
 aHj+MDv2im91A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/xe/nvm: define survivabilty partition
To: "Alexander Usyskin" <alexander.usyskin@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715-cri_surviv-v1-2-61763a6f1076@intel.com>
References: <20260715-cri_surviv-v1-0-61763a6f1076@intel.com>
 <20260715-cri_surviv-v1-2-61763a6f1076@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:32:02 +0000
Message-Id: <20260715143203.372901F00A3A@smtp.kernel.org>
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
- [High] Enabling the survivability region causes an infinite loop during e=
rase operations at the 8MB boundary, and bypasses bounds checks via integer=
 underflow on reads and writes.
--

--- Patch [2]: [PATCH 2/2] drm/xe/nvm: define survivabilty partition ---
commit b38b020b9c762ee5ac9265db46b43fe2139de54d
Author: Alexander Usyskin <alexander.usyskin@intel.com>

drm/xe/nvm: define survivabilty partition
   =20
Define 8M survivability partition for CRI when
storage is open for write.

> diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
> index 1ea67eaeae243..54de0dbe1fa4d 100644
> --- a/drivers/gpu/drm/xe/xe_nvm.c
> +++ b/drivers/gpu/drm/xe/xe_nvm.c
[ ... ]
> @@ -67,6 +68,7 @@ static bool xe_nvm_writable_override(struct xe_device *=
xe)
>  		reg =3D PCODE_SCRATCH(0);
>  		test_bit =3D FDO_MODE;
>  		test_val =3D FDO_MODE;
> +		s_size =3D SZ_8M;

[Severity: High]
Does enabling this survivability region cause an infinite loop during erase
operations in the MTD driver?

When this patch sets the size to 8MB and survivability is enabled, all
accesses are forced to use region 0, which has a hardcoded size of 8MB:

drivers/mtd/devices/mtd_intel_dg.c:idg_nvm_get_region() {
    ...
	if (nvm->survivability_enabled)
		return 0;
    ...
}

If a user performs an erase operation at or crossing the 8MB boundary, it c=
an
trigger an infinite loop in intel_dg_mtd_erase():

drivers/mtd/devices/mtd_intel_dg.c:intel_dg_mtd_erase() {
    ...
	if (len > nvm->regions[idx].size - from)
		len =3D nvm->regions[idx].size - from;
    ...
}

When from reaches 8MB (the size of region 0), size - from evaluates to 0. T=
his
sets len to 0. This can cause the operation to return 0 immediately without
decreasing total_len, leading to an infinite while (total_len > 0) loop.

Additionally, read and write operations starting beyond 8MB might cause
size - from to underflow to a massive positive number, bypassing bounds che=
cks.

>  		break;
>  	case XE_BATTLEMAGE:
>  		reg =3D HECI_FWSTS2(DG2_GSC_HECI2_BASE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-cri_surviv=
-v1-0-61763a6f1076@intel.com?part=3D2
