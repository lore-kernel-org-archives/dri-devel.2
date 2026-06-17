Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16DECD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234A310EFA1;
	Wed, 17 Jun 2026 10:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DG3nRRoA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D938610EFA1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:50:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16D6B60122;
 Wed, 17 Jun 2026 10:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D301F000E9;
 Wed, 17 Jun 2026 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781693425;
 bh=kSRzqpwqMMOpBAbn3saqAFW8oi99L64RR0byDDKWOlM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DG3nRRoAhOD99XixELD6aSWZMieoMjBFHOugw2xI9xECy07RoYFpeXQPQThrYEF6A
 UQWF+utDiZsw15OrAXWSFRlQydcSZCsmWkHbEjAh98QcHGpkNo7UyMiq4Mt4MvS51P
 Ow5moDSjESDv625X7iAo1X2JJ7mUkXGHLTP190hPOBlixJ65wRUFusQTx0WKOzNzuf
 JL91Fuz2WDAabXqZAw4hZtGN3//TyupfWHdvIYyqBn/Mc1PjAdS383Ke14DNOkSpZm
 LqXA4XCEWFwpIVPsCVoTyjY7VCwakBPLVXOllVI/8WNtH1aux9TBhsn3nEkUqYGIgB
 hNR4qaDNS3H9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617103602.1491609-2-honglei1.huang@amd.com>
References: <20260617103602.1491609-1-honglei1.huang@amd.com>
 <20260617103602.1491609-2-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 10:50:25 +0000
Message-Id: <20260617105025.A3D301F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Compilation error due to missing `pages` member in `struct xe_svm_r=
ange`.

Pre-existing issues:
- [High] Critical error paths swallow error codes by jumping to `out`, caus=
ing an infinite GPU page fault livelock.
--

commit c7d50cf1df054885b8dfd4565b263894bfd104b3
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags

This commit splits the MM state flags out of drm_gpusvm_pages_flags and mov=
es
them to a new drm_gpusvm_range_flags structure. It keeps the mapping state
flags in drm_gpusvm_pages_flags and updates usage in the amd and xe drivers.

Link: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-=
2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177

> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index e1651e70c8f01..05578e187d204 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -134,7 +134,8 @@ xe_svm_garbage_collector_add_range(struct xe_vm *vm, =
struct xe_svm_range *range,
> =20
>  	range_debug(range, "GARBAGE COLLECTOR ADD");
> =20
> -	drm_gpusvm_range_set_unmapped(&range->base, mmu_range);
> +	drm_gpusvm_range_set_unmapped(&range->base, &range->pages, 1,
> +				      mmu_range);

[Severity: Low]
Does this cause a compilation error due to pages not being a direct member
of struct xe_svm_range? It looks like the pages struct is located inside the
embedded base field (range->base.pages).

While this might be fixed in a later patch in the series, should each commit
compile successfully on its own to preserve bisection?

[ ... ]

> @@ -1248,7 +1249,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *=
vm, struct xe_vma *vma,
> =20
>  	xe_svm_range_fault_count_stats_incr(gt, range);
> =20
> -	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem) {
> +	if (ctx.devmem_only && !range->base.flags.migrate_devmem) {
>  		err =3D -EACCES;
>  		goto out;
>  	}

[Severity: High]
This is a pre-existing issue, but can this error path swallow the error cod=
e by
jumping to the out label?

Looking at __xe_svm_handle_pagefault(), the out label appears to
unconditionally return 0:

out:
	xe_svm_range_fault_us_stats_incr(gt, range, start);
	return 0;

If we set err =3D -EACCES and jump to out, or if xe_svm_range_get_pages()
fails and jumps to out later in the function, does returning 0 cause the
caller to believe the page fault was handled successfully?

Since the pages weren't mapped, wouldn't the GPU immediately retry the
instruction and fault again, potentially causing an infinite livelock? Shou=
ld
these error paths jump to err_out instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617103602.1491=
609-1-honglei1.huang@amd.com?part=3D1
