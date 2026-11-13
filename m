Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1EF606A335
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGow0KRZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C386B1127E2;
	Fri, 13 Nov 2026 20:35:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9478D1127C4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:35:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4821E446D6;
 Fri, 13 Nov 2026 20:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0426F1F000C5;
 Fri, 13 Nov 2026 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794602144;
 bh=wJsX16EFvd30JW5jg2EVTt0hVGv7RMHmaEpjBoaNp8M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mGow0KRZX7p1iUrhYaaxiAduX2KKSf4IJdtcNBVk6H+SwGhsKgS7NEoYJx5YtzQE3
 SG7a+oIu/p5mhYhApC3LRQF+cglq2x+hHJicFoXSNUH2P+Ut/TrJfhHhGjfJuboJQW
 MF198rPbALW7lhWTdk1OOLmuCwBJu++ZTjqTS1d3yxTuqLYJq05WZeog1q444HRchw
 KxhfGjBQ11YcRzIBeW3FeeQR7TGzFBZ1YX7Qo1Qw9m+HzM+OXjsX05uBFsfWoZq9XX
 YWKsOzgbJqgNuZRHC2RLTCdi8nyxuWtOcWnn8lA/37PpkOjTr9lJy4aVZCknHQ6p1V
 LHClH5IAh1CsQ==
Message-ID: <sashiko-outbox-213653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/dmem: free migration arrays on early fault
 returns
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113195436.2659094-1-gourry@gourry.net>
References: <20261113195436.2659094-1-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:35:43 +0000
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
- [Critical] drm/nouveau/dmem: uncopied folio mapped on error in
  nouveau_dmem_migrate_to_ram() [1]
--

commit 33edd5aee5de0eaebe288aeb01245d89558426c2
Author: Gregory Price (Meta) <gourry@gourry.net>

drm/nouveau/dmem: free migration arrays on early fault returns

This commit fixes memory leaks of the source and destination PFN arrays in
nouveau_dmem_migrate_to_ram() when migrate_vma_setup() fails or finds no
pages to migrate.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nou=
veau/nouveau_dmem.c
> index eacac80558344..ae98e177a240b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -233,10 +233,12 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struc=
t vm_fault *vmf)
>  	 * than just one page on CPU fault. When such fault happens it is very
>  	 * likely that more surrounding page will CPU fault too.
>  	 */
> -	if (migrate_vma_setup(&args) < 0)
> -		return VM_FAULT_SIGBUS;
> +	if (migrate_vma_setup(&args) < 0) {
> +		ret =3D VM_FAULT_SIGBUS;
> +		goto err;
> +	}
>  	if (!args.cpages)
> -		return 0;
> +		goto err;
> =20
>  	if (order)
>  		dpage =3D folio_page(vma_alloc_folio(GFP_HIGHUSER | __GFP_ZERO,

[Severity: Critical]
This problem wasn't introduced by this patch, but if
nouveau_dmem_copy_folio() fails later in nouveau_dmem_migrate_to_ram()
[1], does jumping to done cause migrate_vma_finalize() to map the
uncopied destination folio into the process page tables?

drivers/gpu/drm/nouveau/nouveau_dmem.c:nouveau_dmem_migrate_to_ram() {
	...
	args.dst[0] =3D migrate_pfn(page_to_pfn(dpage));
	if (order)
		args.dst[0] |=3D MIGRATE_PFN_COMPOUND;
	dfolio =3D page_folio(dpage);

	svmm =3D folio_zone_device_data(sfolio);
	mutex_lock(&svmm->mutex);
	nouveau_svmm_invalidate(svmm, args.start, args.end);
	err =3D nouveau_dmem_copy_folio(drm, sfolio, dfolio, &dma_info);
	mutex_unlock(&svmm->mutex);
	if (err) {
		ret =3D VM_FAULT_SIGBUS;
		goto done;
	}

	nouveau_fence_new(&fence, dmem->migrate.chan);
	migrate_vma_pages(&args);
	...
done:
	migrate_vma_finalize(&args);
}

Because args.src[0] still has MIGRATE_PFN_MIGRATE set and args.dst[0]
holds a valid PFN, migrate_vma_finalize() -> __migrate_device_finalize()
treats the aborted migration as successful even though migrate_vma_pages()
never ran.  It installs the zeroed destination folio without initialized
mapping or rmap state and frees the source VRAM folio, corrupting
userspace memory and mm invariants when the folio is later unmapped or
reclaimed.

[1] https://sashiko.dev/#/bug/linux-1d44e729-3bbd-4dee-aa29-0b3e8aaa45ea

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195436.2659=
094-1-gourry@gourry.net?part=3D1
