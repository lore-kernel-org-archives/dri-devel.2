Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E7D606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRhnfypU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F7210E956;
	Tue, 10 Nov 2026 08:58:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F2410E209
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:58:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31F8B63026;
 Tue, 10 Nov 2026 08:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF701F008A2;
 Tue, 10 Nov 2026 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794301099;
 bh=0Bu21ovXMOyTmy02V+QAgPwJVMzMuzRtIVuSBvE6hmk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QRhnfypUiD/i4bR6hPFq1LhumsrHn48AnIYpXYg+MPeo5DHsyuzbvnERf/Yl1kXW7
 WCnODItDx9QCZ5i/8vQDtHF65ljUJcB2hHuT/vVyupBXaullalIaOoe/ctbcwJnsm4
 JeIpeI2IsD+CDqA+bVdxJ+1fbpyJpqyYCo6bO1r5iUj34LRoPat9kDiCgeaQhRiCZn
 Ogp8TXOZ9FW9uKX4AmQD2oeLI8GwBk9oZizRF4kuWDwZjqFNPK7aGv1AaluA3JJ/u3
 otTjNrspgHdn5yWwnzBk8Kk9/wj3/lsA1eVeew+15s3+aW+x3k3CFsmzsMtrXIRObf
 5lg8iygf1yrcg==
Message-ID: <sashiko-outbox-206683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/ttm: check for NULL resource in ttm_bo_kmap()
To: kaii-k <harshicon28@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109202330.1816799-1-harshicon28@gmail.com>
References: <20261109202330.1816799-1-harshicon28@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:58:19 +0000
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
- [Low] drm/ttm: inaccurate Fixes trailer in ttm_bo_kmap() NULL check
  commit
--

commit 96feeda5517d178ff64fe467f6cc8933b44eb0d5
Author: Harsh Parmar <kaii02ctf@gmail.com>

> drm/ttm: check for NULL resource in ttm_bo_kmap()
>
> A buffer object can legitimately have no backing store: a driver may
> call ttm_bo_init_reserved() with zero placements, which leaves
> bo->resource NULL. It can also become NULL after the backing store has
> been released.
>
> ttm_bo_kmap() dereferences bo->resource unconditionally (res->size),
> causing a NULL pointer dereference and kernel oops when called on such a
> buffer.
>
> Bail out with -EINVAL if the buffer has no backing store.
>
> Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
> Signed-off-by: Harsh Parmar <kaii02ctf@gmail.com>

[Severity: Low]
In d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer"),
ttm_bo_init_reserved() still unconditionally pointed bo->resource at the
embedded bo->_mem, so bo->resource could not be NULL on an initialized
buffer object.

Leaving bo->resource NULL when ttm_bo_init_reserved() is called with zero
placements was introduced by 180253782038 ("drm/ttm: stop allocating dummy
resources during BO creation"), and leaving it NULL after releasing backing
store in ttm_bo_pipeline_gutting() was introduced by c7ea16f6a47f
("drm/ttm: stop allocating a dummy resource for pipelined gutting").
Should the Fixes: tag reference those commits instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109202330.1816=
799-1-harshicon28@gmail.com?part=3D1
