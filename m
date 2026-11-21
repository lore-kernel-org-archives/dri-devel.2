Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8560606A332
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXYxXQMb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A3510E26C;
	Sat, 21 Nov 2026 09:32:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5694510E26C;
 Sat, 21 Nov 2026 09:32:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23790440F4;
 Sat, 21 Nov 2026 09:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4761F000C6;
 Sat, 21 Nov 2026 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795253525;
 bh=OVi23gSPMcbMEwChatdHlZ1dUfXu0akeL1A8Ael//3s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QXYxXQMbG0ku9AkOmwPf1NK5ehfNIeFG80vN5QEh0B2/iO+9JK2+8NL7HpzjB1oJh
 AIO/oOKL9IpB/6JbCaDIBAHbh24J9NMOx/a6YpYjcrW2IqkgDUDoRfALv10G3UvJUf
 0mRnLLDVxEC6mFRUKxfkgNu1GWwkj8Uif9RrsgOUxHFke+d4gjJCwFdUwQ8na/xk/b
 EoaF4vJcYQYNg45O466mez9wCn43oNRr2z20lK8Ysm9Dr+A3J3qLFnyUueVYjEP1U0
 9HnSd0G9TNLiIlHOgYnmqmCo7aps8mcZNGjvX0wPH1MG0BpJR9u9XcS+2hzcOTZy0F
 b3AZQDFaHHqzg==
Message-ID: <sashiko-outbox-226862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/ttm: Don't warn on oversized page directory
 allocations
To: "Shuicheng Lin" <shuicheng.lin@intel.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
In-Reply-To: <20261121091815.1436090-2-shuicheng.lin@intel.com>
References: <20261121091815.1436090-2-shuicheng.lin@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 09:32:04 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/ttm: missing __GFP_NOWARN in
  ttm_sg_tt_alloc_page_directory()
--

commit b4df7a501d5e41a0a776550ea76ddd972d2c5a9c
Author: Shuicheng Lin <shuicheng.lin@intel.com>

drm/ttm: Don't warn on oversized page directory allocations

This commit passes __GFP_NOWARN to kvcalloc() in
ttm_tt_alloc_page_directory() and ttm_dma_tt_alloc_page_directory() to
prevent user-controlled BO sizes from triggering oversized allocation
warnings in kvmalloc().

> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index b645a18181843..5dc9d3795b046 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -117,7 +117,8 @@ EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_tt_create);
>   */
>  static int ttm_tt_alloc_page_directory(struct ttm_tt *ttm)
>  {
> -	ttm->pages =3D kvcalloc(ttm->num_pages, sizeof(void*), GFP_KERNEL);
> +	ttm->pages =3D kvcalloc(ttm->num_pages, sizeof(void *),
> +			      GFP_KERNEL | __GFP_NOWARN);
>  	if (!ttm->pages)
>  		return -ENOMEM;
> =20
> @@ -127,7 +128,8 @@ static int ttm_tt_alloc_page_directory(struct ttm_tt =
*ttm)
>  static int ttm_dma_tt_alloc_page_directory(struct ttm_tt *ttm)
>  {
>  	ttm->pages =3D kvcalloc(ttm->num_pages, sizeof(*ttm->pages) +
> -			      sizeof(*ttm->dma_address), GFP_KERNEL);
> +			      sizeof(*ttm->dma_address),
> +			      GFP_KERNEL | __GFP_NOWARN);
>  	if (!ttm->pages)
>  		return -ENOMEM;
> =20

[Severity: Medium]
Should ttm_sg_tt_alloc_page_directory() immediately below also pass
GFP_KERNEL | __GFP_NOWARN to kvzalloc_objs()?

drivers/gpu/drm/ttm/ttm_tt.c:ttm_sg_tt_alloc_page_directory() {
	ttm->dma_address =3D kvzalloc_objs(*ttm->dma_address, ttm->num_pages);
	if (!ttm->dma_address)
		return -ENOMEM;

	return 0;
}

ttm_sg_tt_init() calls ttm_sg_tt_alloc_page_directory() for
TTM_TT_FLAG_EXTERNAL objects (such as ttm_bo_type_sg), which can be
reached when importing a dma-buf > 1 TiB via DRM_IOCTL_PRIME_FD_TO_HANDLE
(for example through amdgpu_gem_prime_import() ->
amdgpu_dma_buf_create_obj() -> amdgpu_gem_object_create(), which creates
and validates the BO in AMDGPU_GEM_DOMAIN_CPU before attaching the
dma-buf), triggering the same WARN_ON_ONCE(size > INT_MAX) in
__kvmalloc_node_noprof().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121091815.1436=
090-2-shuicheng.lin@intel.com?part=3D1
