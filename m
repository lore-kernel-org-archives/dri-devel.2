Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE86606A330
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWvNhVJF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804DB10E680;
	Mon,  9 Nov 2026 06:41:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C45810E726
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:41:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE120401A1;
 Mon,  9 Nov 2026 06:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7502F1F0089F;
 Mon,  9 Nov 2026 06:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794206489;
 bh=ZgRNxWhVyfBlNOykyczYkbtI3fNVy6vBHgAtBVKJ0Og=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=WWvNhVJFv+U9jCGHwdiWdFuWDcR0UcVRJy3UZSl7W28sWKk+GKDOo0qOCe3w/nRNO
 2/sWD1yrrpvMCDV86lDp2Epx68/Zu/JrE1vh4s+vcsE8dytIQOjvMZ+EVwqBpmmX7B
 H2GT1rEfpYjK2pGB+vK0nhgWuP4t1X5uQrEjQBZ6Mb8/ULtWarRShje91NQ7KrjmUl
 9YidQ/6MllR4cH10AuhY1hFqEx4dc7qibwRVj/KFw8DXQJmNVqwUh5JJqSbsNj2TmR
 5UVjFIpHnLUCYO42Jc4nNwYBpbBZaODvMiGQAYGsIbsHXqi0aDu6Lv43mONcui0sd9
 dHdep928FJQdQ==
Message-ID: <sashiko-outbox-204500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/6] drm/gma500: Make SGX MMU insertion checked
 and transactional
To: "Gabriel Gama" <operatingsystemsdepression@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261109063303.32658-5-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
 <20261109063303.32658-5-operatingsystemsdepression@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 06:41:29 +0000
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
- [Low] drm/gma500: missing Fixes trailer for SGX MMU page-table bug
  fixes
--

commit b5c47bf3ab6f62c803717a8b203c45789315c003
Author: Gabriel Gama <operatingsystemsdepression@gmail.com>

> drm/gma500: Make SGX MMU insertion checked and transactional
>
> Validate 32-bit mapping extents, PFNs and tiled geometry before changing
> PTEs. Serialize changes with the write semaphore and undo only the
> inserted prefix on allocation failure or collision, preserving existing
> entries. Do not allocate tables or decrement counts when removing holes.
>
> Use 64-bit exclusive endpoints so mapping the last GPU page does not wrap
> on i386. Zero-page requests remain no-ops.
>
> Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>

[Severity: Low]
This fixes several bugs in SGX MMU page-table management, such as
allocating page tables and underflowing pt->count when removing unmapped
holes, wrapping 32-bit endpoints on i386, and taking driver->sem in read
mode during PTE updates.  Should this include a Fixes tag?

  Fixes: 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109063303.3265=
8-1-operatingsystemsdepression@gmail.com?part=3D4
