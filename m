Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46171C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1F910E5FC;
	Thu, 20 Aug 2026 11:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="He3JVklq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A59810E5FC
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:02:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0193D42AC2;
 Thu, 20 Aug 2026 11:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40A11F000E9;
 Thu, 20 Aug 2026 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787223758;
 bh=ileRf+I+bewjuwwRGTBqzEp98V1ArK4DRKMwWQGLs1I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=He3JVklq80ywpP990p88VEpDjQShskoF0gLzgwf3wrbgSl53FQP81l51PWMKorn7u
 vSvTNlw8W4kkaziDdwyN8WBqTe0yHuzz0nuUuAXoQmSMSoVP+1zKiOgNodYDeyKp4V
 Cs+sXGoLVs5rrnkDEEZp/3zCdqL3aCxNz35Yp+XV91omXC7OKsw0b9DhfXK+vPEHMT
 86SmDwQBEKOPyjJl+uHQHHZr2Hct8JXw0jBx3IztwF8Q9Z/iIgA9khYDCG2G2hBvcb
 w2xmmmqy8lkMXfyodQmvWpQDx85iRKTolBXi3CqS0Mj4wYbO0khaSSYetG0cj0Clp0
 Yf0bhwqrG1J0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dma-buf: heaps: Zero system shared heap pages after
 conversion
To: "Steven Price" <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260820105026.53208-3-steven.price@arm.com>
References: <20260820105026.53208-1-steven.price@arm.com>
 <20260820105026.53208-3-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 11:02:38 +0000
Message-Id: <20260820110238.A40A11F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] In `system_heap_allocate()`, if `set_memory_decrypted()` fails for=
 an intermediate page, the error handling path attempts to re-encrypt all p=
ages in the buffer, including those that were never decrypted. This can cau=
se state-transition hypercalls to fail on already-encrypted pages, permanen=
tly leaking pristine memory.
--

--- Patch [2]: [PATCH 2/2] dma-buf: heaps: Zero system shared heap pages af=
ter conversion ---
commit 6c2e28c1010d31d528df19fa7fecbc4eb3e5bcad
Author: Steven Price <steven.price@arm.com>

dma-buf: heaps: Zero system shared heap pages after conversion

This commit modifies the system_cc_shared heap to defer zeroing pages until
after they have been successfully converted from private to shared. This
ensures that the guest clears the memory after decryption, as the decryption
process changes the visible data.

> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c

[ ... ]

> @@ -461,9 +466,12 @@ static struct dma_buf *system_heap_allocate(struct d=
ma_heap *heap,
> =20
>  	if (cc_shared_buffer(buffer)) {
>  		for_each_sgtable_sg(table, sg, i) {
> -			ret =3D system_heap_set_page_decrypted(sg_page(sg));
> +			page =3D sg_page(sg);
> +			ret =3D system_heap_set_page_decrypted(page);
>  			if (ret)
>  				goto free_pages;

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak
pages if decryption fails midway?

If system_heap_set_page_decrypted() fails for an intermediate page, the
code jumps to free_pages. The free_pages label iterates over all pages in
the scatterlist unconditionally up to orig_nents:

free_pages:
        for_each_sgtable_sg(table, sg, i) {
                struct page *p =3D sg_page(sg);
                if (cc_shared_buffer(buffer) &&
                    system_heap_set_page_encrypted(p))
                        continue;
                __free_pages(p, compound_order(p));
        }

For pages later in the scatterlist that were never successfully decrypted,
system_heap_set_page_encrypted() will be called on already-encrypted memory.
If the hypervisor rejects this duplicate encryption request, the pristine
pages skip __free_pages() and are permanently leaked.

Is there a way to track exactly which pages were decrypted so the error path
only attempts to re-encrypt those specific pages?

> +
> +			clear_pages(page_address(page), 1 << compound_order(page));
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820105026.5320=
8-1-steven.price@arm.com?part=3D2
