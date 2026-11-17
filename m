Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE4606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwnzOcTO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606F610EBAC;
	Tue, 17 Nov 2026 16:27:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652D310EBAC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:27:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C089642CC1;
 Tue, 17 Nov 2026 16:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EDB1F000C4;
 Tue, 17 Nov 2026 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794932842;
 bh=akhEmnx3YjZqj24Vfvji/np6SNjLbY/sSln+xnmbE4o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nwnzOcTOAi9NwQJnT15uZ5AHPIU85HL5865T6hbP93vLMdflP7IQ53S7cvYLHOjuB
 cQ+BeyvAz4hyPzGEJBEphKrVMYWDk4mRjiKwgE8ssFuNUT+HKgQmLwDvTvUWMxmDhI
 sIxCZ/iXGo+kG281vR0SAoD8u1nL4haKqkDI7KHACB6osU5EiVS7LyFQtwwv6D2Aew
 xbOd3m3ic01PXz8Wu+/8NP9QDCXPNbTSWNz5eniMq2zsd6ke5J1ZcVMtJc3HiR2tX8
 B+w4dnCUh4v9CmwTJDAmjbh9xm9pJydW7bcy2kaqix97R5vgkT60OIGjPsdy6KhUG1
 13djMyHuwY+jg==
Message-ID: <sashiko-outbox-219170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: heaps: system: zero pages after
 set_memory_decrypted()
To: "Ying Xiao" <eagleshaw@google.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261117155431.1654298-1-eagleshaw@google.com>
References: <20261117155431.1654298-1-eagleshaw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 16:27:22 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] dma-buf: heaps: double encryption and memory leak in
  system_heap_allocate() [1]
--

commit 8e29228b9a5d6486d110b63bcefe3df39d060082
Author: Ying Xiao <eagleshaw@google.com>

dma-buf: heaps: system: zero pages after set_memory_decrypted()

This commit skips __GFP_ZERO when allocating pages for the
system_cc_shared heap and zeroes the pages in
system_heap_set_page_decrypted() after set_memory_decrypted() succeeds.

> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index c8959eadc71d1..5f98d0df11e76 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c

[ ... ]

> @@ -438,7 +453,8 @@ static struct dma_buf *system_heap_allocate(struct dm=
a_heap *heap,
>  			goto free_buffer;
>  		}
> =20
> -		page =3D alloc_largest_available(size_remaining, max_order);
> +		page =3D alloc_largest_available(size_remaining, max_order,
> +					       cc_shared_buffer(buffer));
>  		if (!page)
>  			goto free_buffer;
> =20

[Severity: Critical]
This problem wasn't introduced by this patch, but does the free_pages
error path in system_heap_allocate() call system_heap_set_page_encrypted()
on pages that were never decrypted [1] when
system_heap_set_page_decrypted() fails partway through the scatterlist?

drivers/dma-buf/heaps/system_heap.c:system_heap_allocate() {
    ...
	if (cc_shared_buffer(buffer)) {
		for_each_sgtable_sg(table, sg, i) {
			ret =3D system_heap_set_page_decrypted(sg_page(sg));
			if (ret)
				goto free_pages;
		}
	}
    ...
free_pages:
	for_each_sgtable_sg(table, sg, i) {
		struct page *p =3D sg_page(sg);
    ...
		if (cc_shared_buffer(buffer) &&
		    system_heap_set_page_encrypted(p))
			continue;
		__free_pages(p, compound_order(p));
	}
    ...
}

At free_pages, for_each_sgtable_sg() resets i to 0 and iterates over the
entire scatterlist instead of only the entries that were decrypted.
Calling system_heap_set_page_encrypted() on pages that are still encrypted
can fault in confidential computing guests, or fail and skip
__free_pages(), leaking the pages.

[1] https://sashiko.dev/#/bug/linux-ece74ffb-d452-4ab2-b56e-aa5701dddcf3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117155431.1654=
298-1-eagleshaw@google.com?part=3D1
