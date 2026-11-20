Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F260A2617
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpVSaYgS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924A010E0DA;
	Fri, 20 Nov 2026 13:43:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FE310E076;
 Fri, 20 Nov 2026 13:42:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0456162639;
 Fri, 20 Nov 2026 13:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0AF1F000C6;
 Fri, 20 Nov 2026 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795182175;
 bh=DelEkWRb0otuJ3Owk/bNvAUD48qPFcVpkVG0GdkPIyw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UpVSaYgSj1NtOF2npDd65U4IopbZzT3Hi6ZIqgFnGLCDO3Gz9D3X8hsrvlFN8b2vq
 Ht3A6P/uyAEZs8Xl2usjLVUEolwygAOoserrISqQ57UvsNrrASNEs1wl7gTUDQC4c/
 DPxaVbvyQSJwSuh/HjbvZ/7NShlFe6KHXux7nsFTAMK75rsqBcpMx1DC5ed/pykgWO
 ZCqvnrCBcXk880Wo334MC2BZzmu0cma+pnffkE6hZrX3G6gcxkp0nHpcjlcH00NDm5
 Xh+qzrinP/3wLbNonh0+OrQxLQ9uTdJZu04q8LTvKY/o9X7PWHu3K/nDowL1c2Hxao
 gM6AxXrB+3Ssw==
Message-ID: <sashiko-outbox-225261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/gem: Skip writeback of shmem folios with extra
 references
To: =?utf-8?b?S2lyeWwgU2h1dHNlbWF1IChNZXRhKQ==?= <kas@kernel.org>, "Jani
 Nikula" <jani.nikula@linux.intel.com>,
 "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Andi
 Shyti" <andi.shyti@linux.intel.com>, "David Hildenbrand" <david@kernel.org>,
 "Hugh
 Dickins" <hughd@google.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, kernel-team@meta.com
In-Reply-To: <20261119134243.3745282-1-kas@kernel.org>
References: <20261119134243.3745282-1-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:42:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/i915/gem: missing folio_unlock() after redirty in
  __shmem_writeback()
- [High] drm/i915/gem: invalid dirty-tag writeback helpers in
  __shmem_writeback()
--

commit eee676ed22d7c6fdff448f68a9e29b819f5d0c1e
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

drm/i915/gem: Skip writeback of shmem folios with extra references

This commit skips shmem writeback in __shmem_writeback() for folios that
carry references beyond the page cache and writeback_iter(), avoiding
writeback while an unmapped PMD may still have pending stores through a
stale TLB entry.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index bf9e7480f0f54..748772c358acd 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -316,9 +316,15 @@ void __shmem_writeback(size_t size, struct address_s=
pace *mapping)
>  	 * leaving only CPU mmapings around) and add those folios to the LRU
>  	 * instead of invoking writeback so they are aged and paged out
>  	 * as normal.
> +	 *
> +	 * The same goes for a folio with references beyond the page cache
> +	 * and writeback_iter(). A folio that was just unmapped can still be
> +	 * written through a stale TLB entry until the unmapping side flushes
> +	 * the TLB and drops its reference. pageout() checks the same.
>  	 */
>  	while ((folio =3D writeback_iter(mapping, &wbc, folio, &error))) {
> -		if (folio_mapped(folio))
> +		if (folio_mapped(folio) ||
> +		    folio_ref_count(folio) !=3D 1 + folio_nr_pages(folio))
>  			folio_redirty_for_writepage(&wbc, folio);
>  		else
>  			error =3D shmem_write_folio(folio);

[Severity: High]
Does skipping writeback here leave the folio locked?

writeback_iter() returns the folio locked via writeback_get_folio(), and
neither folio_redirty_for_writepage() nor the next writeback_iter() call
unlocks it.  Routing unmapped folios with extra references into the
folio_redirty_for_writepage() branch without calling folio_unlock() leaves
PG_locked set permanently, deadlocking later faults, reclaim or truncation
on that folio.

[Severity: High]
Can writeback_iter() and folio_redirty_for_writepage() be used on a shmem
mapping?

writeback_get_folio() looks up folios by PAGECACHE_TAG_DIRTY, but
shmem_aops uses noop_dirty_folio, which sets PG_dirty without tagging
mapping->i_pages.  As a result, writeback_iter() never finds dirty shmem
folios, and calling folio_redirty_for_writepage() on a shmem folio reaches
__folio_mark_dirty(), which triggers:

mm/page-writeback.c:__folio_mark_dirty() {
	...
	/*
	 * Shmem writeback relies on swap, and swap writeback is LRU based,
	 * not using the dirty mark.
	 */
	VM_WARN_ON_ONCE(folio_test_swapcache(folio) || shmem_mapping(mapping));
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119134243.3745=
282-1-kas@kernel.org?part=3D1
