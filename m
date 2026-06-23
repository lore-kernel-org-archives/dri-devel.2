Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519E7CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB0710EBF3;
	Tue, 23 Jun 2026 17:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SBI6GWTo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A6510EBF3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 17:04:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 06822401CB;
 Tue, 23 Jun 2026 17:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31841F000E9;
 Tue, 23 Jun 2026 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782234278;
 bh=ZQnB+mLPZ4RyJwtDMy46Wn+3HlQs8Hpn2R9m4Tmsbss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SBI6GWToCQKXF1e2fVk0W/QQIBGYLWLJ9hHQUPKNid0V0kqanAuMipGafOz9V18Ht
 g7JOYT8UyLLF252tgc4EN+irpEDelwycuAyeQREvG0eQ9Cdpj2HRY6KkGR4t2ZcXsU
 0hr2lfLTss+s7R7SKM/7DWRqDYoROHWL/E8yVQtBITBaIQJWLL8uPcxfXEpxGcBncF
 e3L+JxrVOc1Qhg5QDA93ZhGxa/4srrQp/9uTnuEH6lp1Jvqw+UmYShn6BteuczlJ4Z
 Zc8afWoIPqDlNUcycIxlz08diFb2ODvUnjUUzqeiC3vu9cIGIlmvHc0L8ovWYQkYsq
 cF4NTOGH/3XnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
To: "Jonathan Cavitt" <jonathan.cavitt@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623164610.1019512-2-jonathan.cavitt@intel.com>
References: <20260623164610.1019512-1-jonathan.cavitt@intel.com>
 <20260623164610.1019512-2-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:04:38 +0000
Message-Id: <20260623170438.C31841F000E9@smtp.kernel.org>
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
- [Low] The format specifier `%ld` is used for an `unsigned long` argument =
in `xe_pagefault_print()`, causing a signedness mismatch.
--

commit a84658007b56ca870c768c6042faa49f53ab109e
Author: Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: drm/xe/pagefault: Add SRCID to pagefault struct

This commit adds SRCID information to the pagefault struct to report the
hardware unit that triggered the pagefault. It folds the SRCID into the
existing ASID field to maintain a compact structure.

> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pa=
gefault.c
> index dd3c068e1a399..3b0510f2a72e6 100644
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
Does this code introduce a format specifier mismatch? FIELD_GET() returns an
unsigned long, but the format string uses %ld which expects a signed long.
Should this use %lu instead to maintain format string type safety?

>  		   "\tFaulted Address: 0x%08x%08x\n"
>  		   "\tFaultType: %lu\n"
>  		   "\tAccessType: %lu\n"
>  		   "\tFaultLevel: %lu\n"
>  		   "\tEngineClass: %d %s\n"
> -		   "\tEngineInstance: %d\n",
> -		   pf->consumer.asid,
> +		   "\tEngineInstance: %d\n"
> +		   "\tSRCID: 0x%02lx\n",
> +		   FIELD_GET(XE_PAGEFAULT_ASID_MASK,
> +			     pf->consumer.id),
>  		   upper_32_bits(pf->consumer.page_addr),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623164610.1019=
512-1-jonathan.cavitt@intel.com?part=3D1
