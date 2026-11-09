Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A1606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4bPQMhv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9069110E6EB;
	Mon,  9 Nov 2026 06:07:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BF510E6EB
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:07:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A81A62D3B;
 Mon,  9 Nov 2026 06:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC22C1F008A1;
 Mon,  9 Nov 2026 06:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794204439;
 bh=/YqoHOLiIjuIeYC5F6PrrjzGiIMa8S+ij0yA+FRnX1c=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=d4bPQMhvHlVpgF5ACUDt+Bgk8lKEds16iqo5CKhboWf9q1LDuaFK7ljcOY/EJJgmQ
 +lWyLVBms+erJDp1bPuacGQ0k5dBCWQFOIjohsSSIH+qE+Cita/kX+qFwjbhJjjfwP
 p5ilhM+TUHlG7y9SN1PR46Y1p1qpQPHqisGc/c9DLWfLTuF0S7wkrjb4qxQquw1F2z
 sFOU/0p+setHybKCvmO2RjtOaSgCXn5r/JjCRjFKWqkZJlK3/bMsDO458anQmsg1D1
 B2+7G55R36hRZ9GIlbonivt+AZTVd3/bL9OMv68T0kdGz4IeKtjwrvJUQdPYUMumq9
 JJPMViNBGiVPw==
Message-ID: <sashiko-outbox-204484@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/6] drm/gma500: Add software-only KUnit coverage
 for SGX page tables
To: "Gabriel Gama" <operatingsystemsdepression@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261109055451.17458-7-operatingsystemsdepression@gmail.com>
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
 <20261109055451.17458-7-operatingsystemsdepression@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 06:07:19 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/gma500: NULL deref and double free in psb_mmu_test_exit()
  on init error
--

commit 0ae7cbd175ba45e2df744da8590157d933a675ae
Author: Gabriel Gama <operatingsystemsdepression@gmail.com>

drm/gma500: Add software-only KUnit coverage for SGX page tables

This commit adds a built-in KUnit test suite for GMA500 SGX page-table
operations using a software page directory without hardware access.

> diff --git a/drivers/gpu/drm/gma500/mmu_test.c b/drivers/gpu/drm/gma500/m=
mu_test.c
> new file mode 100644
> index 0000000000000..0581c7d9ac4ac
> --- /dev/null
> +++ b/drivers/gpu/drm/gma500/mmu_test.c
> @@ -0,0 +1,222 @@
[ ... ]
> +static int psb_mmu_test_init(struct kunit *test)
> +{
> +	struct psb_mmu_test_context *ctx;
> +	int i;
> +
> +	ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	test->priv =3D ctx;
> +	spin_lock_init(&ctx->driver.lock);
> +	init_rwsem(&ctx->driver.sem);
> +	ctx->pd =3D psb_mmu_alloc_pd(&ctx->driver, 1, 0);
> +	if (!ctx->pd)
> +		return -ENOMEM;
> +	for (i =3D 0; i < ARRAY_SIZE(ctx->pages); i++) {
> +		ctx->pages[i] =3D alloc_page(GFP_DMA32);
> +		if (!ctx->pages[i]) {
> +			while (i--)
> +				__free_page(ctx->pages[i]);
> +			psb_mmu_free_pagedir(ctx->pd);
> +			return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void psb_mmu_test_exit(struct kunit *test)
> +{
> +	struct psb_mmu_test_context *ctx =3D test->priv;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ctx->pages); i++)
> +		__free_page(ctx->pages[i]);
> +	psb_mmu_free_pagedir(ctx->pd);
> +}

[Severity: Medium]
Can psb_mmu_test_exit() cause a NULL pointer dereference or double free
when psb_mmu_test_init() fails?

KUnit runs suite->exit(test) via kunit_run_case_cleanup() even when
suite->init(test) returns a non-zero error.  If kunit_kzalloc() or
psb_mmu_alloc_pd() fails, psb_mmu_test_exit() dereferences a NULL ctx or
ctx->pd; if alloc_page() fails, psb_mmu_test_init() frees ctx->pages[] and
ctx->pd without clearing the pointers, and psb_mmu_test_exit() frees them
again while passing NULL for the unallocated pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109055451.1745=
8-1-operatingsystemsdepression@gmail.com?part=3D6
