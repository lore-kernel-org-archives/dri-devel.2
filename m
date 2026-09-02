Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A4FC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F6010F35F;
	Wed,  2 Sep 2026 21:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="da4CbVoo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B855210F357;
 Wed,  2 Sep 2026 21:44:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB01E601EF;
 Wed,  2 Sep 2026 21:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C0E1F000E9;
 Wed,  2 Sep 2026 21:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788385469;
 bh=qZyUzYY6QlEYxgbIhjzO1Yd42FOasqddg78sQt4mobk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=da4CbVoogY+qZOq8zgtj4ODk0wCHlCAu9yuR1ea9vxYpoRtqJSVNVGdrpqzE3yBVH
 OCXAV+5rv7PYNKRCefwzdABAOyIuMuKVuxO/4X29OmReyORg6G0MYgMSBI6kH0nUZV
 Eaeq2fch8sXaar208pd13gHQ9PcNvE2GYLmkoO+jqFZgHOmP8AW0IvD+fGmnvwiyPu
 PxmWxAxcZc4bWhHCMfDGcFq1HBre3jmE/bmmBtVmyM2VZu9wCG6lK38jIvW+mO5Tp7
 rgyTH6aoA/+uEilFwef3X/mdB7vhocwRN8G4Cl+Q9sup6BlH6jlah0RUmJEcxis9at
 Q5Ze9ZjTf4LSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
To: "Jonathan Cavitt" <jonathan.cavitt@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260902212549.347805-2-jonathan.cavitt@intel.com>
References: <20260902212549.347805-1-jonathan.cavitt@intel.com>
 <20260902212549.347805-2-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 21:44:28 +0000
Message-Id: <20260902214429.53C0E1F000E9@smtp.kernel.org>
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
- [High] Logical OR (||) used instead of bitwise OR (|) when packing ASID a=
nd SRCID into pf.consumer.id.
--

commit 1788c2503016dd2829d88985880f0d679983c0b4
Author: Jonathan Cavitt <jonathan.cavitt@intel.com>

    drm/xe/pagefault: Add SRCID to pagefault struct

This commit adds SRCID information to the pagefault struct to report the
hardware unit that caused the pagefault, folding it into the same field as
ASID to keep the struct compact.

> diff --git a/drivers/gpu/drm/xe/xe_guc_pagefault.c b/drivers/gpu/drm/xe/x=
e_guc_pagefault.c
> index 8f8210a732e98..036175faadd4a 100644
> --- a/drivers/gpu/drm/xe/xe_guc_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_guc_pagefault.c
> @@ -108,7 +108,13 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32=
 *msg, u32 len)
>  				      << PFD_VIRTUAL_ADDR_HI_SHIFT) |
>  		(FIELD_GET(PFD_VIRTUAL_ADDR_LO, msg[2]) <<
>  		 PFD_VIRTUAL_ADDR_LO_SHIFT);
> -	pf.consumer.asid =3D FIELD_GET(PFD_ASID, msg[1]);
> +
> +	BUILD_BUG_ON(XE_MAX_ASID > XE_PAGEFAULT_ASID_MASK);
> +
> +	pf.consumer.id =3D FIELD_PREP(XE_PAGEFAULT_ASID_MASK,
> +				    FIELD_GET(PFD_ASID, msg[1])) ||
> +			 FIELD_PREP(XE_PAGEFAULT_SRCID_MASK,
> +				    FIELD_GET(PFD_SRC_ID, msg[0]));

[Severity: High]
Is this intended to be a bitwise OR (|) rather than a logical OR (||)?

Using a logical OR will result in pf.consumer.id being assigned a boolean
value (1 or 0) rather than the packed ASID and SRCID bits. When
xe_pagefault_service() extracts the ASID using FIELD_GET, it will likely
read 1 rather than the true ASID of the faulting VM. This misroutes page
faults and breaks virtual memory management.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902212549.3478=
05-1-jonathan.cavitt@intel.com?part=3D1
