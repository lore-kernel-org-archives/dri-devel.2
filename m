Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5B3C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EC310E4DB;
	Thu, 23 Jul 2026 10:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R3zzC/yk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661A610E4DB
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4241600AD;
 Thu, 23 Jul 2026 10:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501831F00A3A;
 Thu, 23 Jul 2026 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784803879;
 bh=1YUgOU5YQOpqGEkel1nnnfdlkuaUWEz+gJxrsf5RN7w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R3zzC/yk3tQSkN+W/sM/gNcDL5oSfFi4uLneGVHKkd4YZw8IxdUA9E0SAM2xgX7CP
 0R+J5WydUpmFxFlLEoGTJeCkLzQS2lEwikgt2lz0QsAQz/A1IjbGJagYQ6yUGoZXv9
 9roj0YNbT6yzgYvStwFfzizlvHTMr/JlNOQaGZuMhvnuk9wVJdJpbcPA4y1QW3noCe
 Fs5M08Bvp8LNrNMg8TIFxwxgs4H8uuN50RflGUqtxtoehS+uYRqvbLT4Ntl85OyGYX
 BCDBh5AXkUhpws9h6YTSHI6k28zSr9wWKrTE5dl/N9b6NA0yS0fgNxrVJ9YzzinUfU
 DDpjjERNMXJVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] drm/i915/gem: Count mapped pages in a folio
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723102542.3245495-2-krzysztof.karas@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
 <20260723102542.3245495-2-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:51:18 +0000
Message-Id: <20260723105119.501831F00A3A@smtp.kernel.org>
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
- [Medium] Memory leak of the scatterlist array when max_segment < PAGE_SIZ=
E.
--

--- Patch [1]: [PATCH v4 1/5] drm/i915/gem: Count mapped pages in a folio -=
--
commit 3685bb29aed2da7225e7f1cb1cc9319380f378f3
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm/i915/gem: Count mapped pages in a folio

This commit addresses scatterlist overloading by correctly handling folio
pages above the max_segment boundary, tracking the count to ensure a folio
is fully covered before reading the next.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 06543ae60706e..af195db63038e 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
[ ... ]
> @@ -88,6 +91,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915,=
 struct sg_table *st,
>  	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
>  		return -ENOMEM;
> =20
> +	if (max_segment < PAGE_SIZE)
> +		return -EINVAL;
> +

[Severity: Medium]
Does this code leak the scatterlist array when max_segment < PAGE_SIZE?

Because this validation check is placed in shmem_sg_alloc_table() after
sg_alloc_table() has already successfully allocated memory for st->sgl,
returning directly bypasses the cleanup. It looks like we might need to
call sg_free_table(st) before returning -EINVAL to avoid leaking the array.

>  	/*
>  	 * Get the list of pages out of our struct file.  They'll be pinned
>  	 * at this point until we release them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723102542.3245=
495-1-krzysztof.karas@intel.com?part=3D1
