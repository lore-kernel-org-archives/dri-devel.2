Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA39ACD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 206B510F34C;
	Thu, 18 Jun 2026 15:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e0LuW1FE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5AE410F34C
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:45:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03D1F60103;
 Thu, 18 Jun 2026 15:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9103D1F000E9;
 Thu, 18 Jun 2026 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781797505;
 bh=pgChZgqJm/l1PaDKbq5XsuUjQ5dxJAODW7B3nAmQXlI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e0LuW1FEs5Mv0ej/iKVS9e+m1fSNavYhbaxo1wfmFieah3X5y3YaAZz7yqboLewxu
 TgbnP2Mu3JV96AuFTVkDovruVS2GZZXnFcAjwfYwwyREjbkQr/4MygNMsBsNE6m0eQ
 d3YQ1M5tx2BjVrxOg0Kf6Pxznz91TTKSDQOTsCTbEt6Wwg0YlGmHWrwfXKOMPy3XNd
 7z3rAQ9LaKrBiZfq6e8OafVJfpDPNibYGAl/tSoFiQPE8dvMyJOsTnOyUNHLSAuksj
 zp1tuWFzrxl94WiEknoX+5KSSZD1QoHBNzXIbzuK2TcFPGvQG3fXGdIMI/J9bcCFTQ
 9dZoQjtj12ASA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
To: "Jonathan Cavitt" <jonathan.cavitt@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618153312.877948-2-jonathan.cavitt@intel.com>
References: <20260618153312.877948-1-jonathan.cavitt@intel.com>
 <20260618153312.877948-2-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 15:45:05 +0000
Message-Id: <20260618154505.9103D1F000E9@smtp.kernel.org>
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
- [Low] The format specifier `%ld` is incorrectly used for an `unsigned lon=
g` value.
--

commit 18f63f8d431959e86df8128bf9d2756c13aca8e3
Author: Jonathan Cavitt <jonathan.cavitt@intel.com>

drm/xe/pagefault: Add SRCID to pagefault struct

This commit adds SRCID information to the pagefault struct to report the
hardware unit that resulted in the pagefault. It squashes the SRCID with the
ASID to keep the struct compact.

> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pa=
gefault.c
> index dd3c068e1a399..2a21203b1a2a0 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
[ ... ]
> @@ -242,14 +243,16 @@ static bool xe_pagefault_queue_pop(struct xe_pagefa=
ult_queue *pf_queue,
> =20
>  static void xe_pagefault_print(struct xe_pagefault *pf)
>  {
> -	xe_gt_info(pf->gt, "\n\tASID: %d\n"
> +	xe_gt_info(pf->gt, "\n\tASID: %ld\n"

[Severity: Low]
Should this format specifier be %lu instead of %ld?

In xe_pagefault_print(), the ASID value is now extracted using
FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id). Because=20
XE_PAGEFAULT_ASID_MASK is constructed using GENMASK(), the FIELD_GET() macro
evaluates to an unsigned long.=20

Passing an unsigned long to %ld causes a format string type mismatch. While
the 24-bit positive ASID value will format without memory corruption at=20
runtime, %lu is the correct format specifier for unsigned long values.

>  		   "\tFaulted Address: 0x%08x%08x\n"
>  		   "\tFaultType: %lu\n"
>  		   "\tAccessType: %lu\n"
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618153312.8779=
48-1-jonathan.cavitt@intel.com?part=3D1
