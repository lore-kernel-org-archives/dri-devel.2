Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30865C624D7
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6069010E64C;
	Wed,  2 Sep 2026 21:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hUEoQhmD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0381C10E516;
 Wed,  2 Sep 2026 21:37:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5E5D4351A;
 Wed,  2 Sep 2026 21:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725041F000E9;
 Wed,  2 Sep 2026 21:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788385033;
 bh=wRB8hK2Y/UgBgNqKV5n1XtlF8RhVqn5WRRbr67Zlx3M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hUEoQhmDDSUYU1joNSy5BoGAA9gHaBHYFZARPcNFEzDefaY2JUu9mtnVQshORmC8o
 cG7//w34Cztw7c/ALMy1cs4otq/3r9RAtFozsHouh068F2DIfvHx7qnIxHK6E3/1Vt
 L5syagkHt0RLUUAVrvf2xObNsMgdZvLkeA0SCMLgYSYWH/V/Vl+MbkgzuUwoxIQ0Mw
 8QSIKM9W75w5hAgfvIYNBT54iJzCh76j6MCoHzGS+Wypa6dHpTb/NH1z7HoNwPDsHv
 9GyOgp8polPrXEwlu7YClLT/GcwrXuryvc+vIiS9CuCnjqvNjDX6nSdfoTO8IyODLS
 C00Gz9Tfw2F3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm/xe/vm: Add srcid to xe_vm_get_property_ioctl
 fault report
To: "Jonathan Cavitt" <jonathan.cavitt@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260902212549.347805-3-jonathan.cavitt@intel.com>
References: <20260902212549.347805-1-jonathan.cavitt@intel.com>
 <20260902212549.347805-3-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 21:37:13 +0000
Message-Id: <20260902213713.725041F000E9@smtp.kernel.org>
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
- [High] Logical OR (`||`) is incorrectly used instead of bitwise OR (`|`) =
when squashing ASID and SRCID into `pf.consumer.id`, corrupting both values.
--

commit 307b4c2649f6f7d7b3a698b8e497542ed1a82f2f
Author: Jonathan Cavitt <jonathan.cavitt@intel.com>

drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault report

This commit adds the SRCID of the faulting hardware unit to the return
of the xe_vm_get_property_ioctl fault report.

> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 19b3d0be79282..753a5fc55baa0 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -655,6 +655,7 @@ void xe_vm_add_fault_entry_pf(struct xe_vm *vm, struc=
t xe_pagefault *pf)
>  				  pf->consumer.fault_type_level);
>  	e->fault_level =3D FIELD_GET(XE_PAGEFAULT_LEVEL_MASK,
>  				   pf->consumer.fault_type_level);
> +	e->srcid =3D FIELD_GET(XE_PAGEFAULT_SRCID_MASK, pf->consumer.id);

[Severity: High]
Will this always read a zero SRCID due to a logical OR in
xe_guc_pagefault_handler()?

When squashing ASID and SRCID into pf.consumer.id, the code uses a logical =
OR
(||) instead of a bitwise OR (|):

drivers/gpu/drm/xe/xe_guc_pagefault.c:xe_guc_pagefault_handler() {
    ...
	pf.consumer.id =3D FIELD_PREP(XE_PAGEFAULT_ASID_MASK,
				    FIELD_GET(PFD_ASID, msg[1])) ||
			 FIELD_PREP(XE_PAGEFAULT_SRCID_MASK,
				    FIELD_GET(PFD_SRC_ID, msg[0]));
    ...
}

Because the logical OR evaluates to a boolean (0 or 1), the actual bitmasks
are destroyed. This means FIELD_GET(XE_PAGEFAULT_SRCID_MASK, pf->consumer.i=
d)
will always evaluate to 0 here. Additionally, this silently corrupts the AS=
ID
to 0 or 1, which may cause xe_pagefault_asid_to_vm() to look up the wrong VM
or fail entirely.

Could the logical OR (||) in xe_guc_pagefault_handler() be replaced with a
bitwise OR (|) to prevent this data loss?

> =20
>  	list_add_tail(&e->list, &vm->faults.list);
>  	vm->faults.len++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902212549.3478=
05-1-jonathan.cavitt@intel.com?part=3D2
