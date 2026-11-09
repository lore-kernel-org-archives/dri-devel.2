Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02090606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R66cymm0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A01410E266;
	Mon,  9 Nov 2026 09:50:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F66C10E864
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 09:50:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22B6243C90;
 Mon,  9 Nov 2026 09:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECC31F0089F;
 Mon,  9 Nov 2026 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794217848;
 bh=z0TXwKsFxHmGwv+CQae9ixB1i6zW+jUYwo4faHZTSmQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=R66cymm0FqDe7b5Ls3cqzmcpqtBRL0sUtkHWL8010Dr6D0EF1o0Sl9Z+uzU5Dul1a
 yliEAKQ3rAQ1nLBI3XszzOViRqyE+u+kBjNZ8OE4O5J6dwRvMTPPktwjZyH9DyxF4H
 Rq5aRXRBgkw8ApBgJWMK6d4recZXm3FBcoah9B7a0HJI0xSHhjTUWKKaTiVGCGC5Kg
 BW32+asUCpv6FGmzOI3MFUQD/hx3yvdnOORvQHXtTwPb7A7Iq/0enaIBJrMFTfMws0
 ps3N25vhALFr2arbt0A9TEucx4dudbF6pywT8jw1ryuR7oR8acaCucSsxjaTKtRWN/
 CXaZFv91KteFQ==
Message-ID: <sashiko-outbox-204751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem-atomic-helper: fix fence leak on
 dma_fence_chain_alloc() failure
To: "Chengyu Liu" <lui2012qwq@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261107165303.13508-1-lui2012qwq@gmail.com>
References: <20261107165303.13508-1-lui2012qwq@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:50:47 +0000
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
- [Low] drm/gem-atomic-helper: missing Fixes trailer for commit
  1ea28bc5542d
--

commit b6d9ff23bfcc702d784107d5026972257646c1fc
Author: Chengyu Liu <lui2012qwq@gmail.com>

> drm/gem-atomic-helper: fix fence leak on dma_fence_chain_alloc() failure
>
> In drm_gem_plane_helper_prepare_fb(), when both "new" (the plane's GEM
> singleton fence) and "fence" (explicit or previous plane's) exist, they
> are wrapped in a freshly allocated chain.  If dma_fence_chain_alloc()
> fails, the error path runs before dma_fence_chain_init() adopts "new",
> and error: only puts "fence" - leaking one fence reference per failure.
>
> Put "new" in the allocation-failure branch.
>
> Found by static analysis.
>
> Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>

[Severity: Low]
Should this commit include a Fixes: tag for the commit that introduced the
leak:

  Fixes: 1ea28bc5542d ("drm: handle kernel fences in drm_gem_plane_helper_p=
repare_fb v2")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107165303.1350=
8-1-lui2012qwq@gmail.com?part=3D1
