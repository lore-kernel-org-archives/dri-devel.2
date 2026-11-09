Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4175606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSBXK+kg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E66210E679;
	Mon,  9 Nov 2026 06:00:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F6210E679
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:00:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 837B761E50;
 Mon,  9 Nov 2026 06:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7371F008A2;
 Mon,  9 Nov 2026 06:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794204051;
 bh=BtxXXEj6g6S/ZZeqMfxxcRqlmgNMx4GZsUDduWAsMos=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=GSBXK+kgtdGlgSWWXPJQYDICEN9zqTBoUByIcyxpO55andua52u9ymqjbSyROZjlC
 MCoQRXtnjD8o25lsChUZEDA1F6w71fHGbUqqfVcSKFQouC/KmxEzdjvcbN//EMd4a0
 RDuHn1oUNsiH6cB5M7VOH9CcE/AtzVoz/j2IG+hOSz09XdLLEtstPnDMnuCxF/pdue
 Osk1Nk/XAT83m0djIyR4KNne4BPvxXmr1ngN9CsLUNVKWHW6q9fddK5JUstA2OAVVv
 uCTx/7VUOgDpIZjnRRquNd79gsz/fxHFD2CTlzm6zfsyJcjbGxxPGC1pegZUF/GVQt
 xRAkKxilpdhTA==
Message-ID: <sashiko-outbox-204475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/6] drm/gma500: Fix SGX page-table cache-flush
 mapping lifetime
To: "Gabriel Gama" <operatingsystemsdepression@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261109055451.17458-4-operatingsystemsdepression@gmail.com>
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
 <20261109055451.17458-4-operatingsystemsdepression@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 06:00:50 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/gma500: missing Fixes: trailer for SGX MMU cache-flush fixes
--

commit c92354a62278204d941ae70ac0f3b2869cb66190
Author: Gabriel Gama <operatingsystemsdepression@gmail.com>

> drm/gma500: Fix SGX page-table cache-flush mapping lifetime
>
> Flush the modified directory entry before unmapping it. The old order
> uses a kmap_atomic pointer outside its mapping lifetime, which DMA32
> direct mappings can mask. Use kmap_local_page under the existing spinlock.
>
> Also calculate the CLFLUSH iteration count only on the path that uses it,
> avoiding division by an uninitialized cache-line size when CLFLUSH
> is absent.
>
> Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>

[Severity: Low]
Both the post-unmap cache flush in psb_mmu_pt_alloc_map_lock() and the
unconditional division by clflush_add in psb_mmu_alloc_pt() were
introduced in 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling
logic").  Should this include a Fixes: tag?

  Fixes: 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109055451.1745=
8-1-operatingsystemsdepression@gmail.com?part=3D3
