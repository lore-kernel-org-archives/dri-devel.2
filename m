Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F43DC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C875A10E708;
	Sat, 11 Jul 2026 03:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ccTDYRDk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B705110E708
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:15:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 062E460051;
 Sat, 11 Jul 2026 03:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9137C1F000E9;
 Sat, 11 Jul 2026 03:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739749;
 bh=fzX/uwnectF4S9u4w2ORwhjvuIbg5buAfn9kwccK3Yw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ccTDYRDkzhcwSKARzns4yAJ3Hl1M8InQuGyZ3FzkLgNFtoK0sgEmq1ZIywRIjWVTd
 mRbySkzHJQ0KMrgrZrYURYIxIgc7Pzkg2lQceEFurZRtOqHv6W8/SpMuRVz99CvcEa
 HaaoTyLeihy8jEqtD9bE7lKD6y5Tg+1LCVsusI+hci324/ScAOQjS5phIUb+o3iz+B
 nuXL1BaiXaVRgJ3b2sDIKTbUdgz91ilJajbckYBIaketwKf+eQP4RdIYFBlvbvZcV7
 F9ZDSm35RptWnu/uw6YkDg43e/zHzpPu1PiHShOa2Ag+coa/z172ay+cufvdbw7IET
 8zIUUeIghcs4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 27/33] drm/xe: Add IOVA-based xe_res_cursor variant
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-28-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-28-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:15:49 +0000
Message-Id: <20260711031549.9137C1F000E9@smtp.kernel.org>
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
- [Low] The newly added `is_iova` block in `xe_res_next()` is mathematicall=
y unreachable and completely redundant.
--

--- Patch [27]: [PATCH v3 27/33] drm/xe: Add IOVA-based xe_res_cursor varia=
nt ---
commit 41ab8ab5c8919ddc065db2f6f0c78d6b5b1b51d0
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add IOVA-based xe_res_cursor variant

This patch introduces a variant of xe_res_cursor for walking buffer objects
DMA mapped using the IOVA-based DMA API. It adds an is_iova flag to
distinguish single contiguous IOVA mappings and updates the cursor functions
to handle this contiguous segment appropriately.

> diff --git a/drivers/gpu/drm/xe/xe_res_cursor.h b/drivers/gpu/drm/xe/xe_r=
es_cursor.h
> index 0522caafd89d7..f0f1d699e16e5 100644
> --- a/drivers/gpu/drm/xe/xe_res_cursor.h
> +++ b/drivers/gpu/drm/xe/xe_res_cursor.h
[ ... ]
> @@ -283,6 +327,13 @@ static inline void xe_res_next(struct xe_res_cursor =
*cur, u64 size)
>  		return;
>  	}
> =20
> +	if (cur->is_iova) {
> +		/* Single contiguous IOVA segment. */
> +		cur->start +=3D size;
> +		cur->size =3D cur->remaining;
> +		return;
> +	}
> +

[Severity: Low]
Is this block reachable?

In xe_res_first_iova(), cur->size is initialized to the full size, matching
cur->remaining.

When xe_res_next(cur, size) is called, it first decrements cur->remaining:

	cur->remaining -=3D size;
	if (!cur->remaining)
		return;

If the cursor isn't exhausted, the original cur->remaining must have been
greater than size. Since cur->size equals the original cur->remaining for
single contiguous IOVA mappings, cur->size will also be greater than size.=
=20

This means execution will always enter the generic segment advancement block
immediately preceding this one:

	if (cur->size > size) {
		cur->size -=3D size;
		cur->start +=3D size;
		return;
	}

Does this make the newly added is_iova block mathematically unreachable dead
code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D27
