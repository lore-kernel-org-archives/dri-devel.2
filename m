Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6C606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZbqZz5P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E578910ECAC;
	Mon,  2 Nov 2026 10:26:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C78710ECA4;
 Mon,  2 Nov 2026 10:26:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EFD9E4047C;
 Mon,  2 Nov 2026 10:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD71D1F000C1;
 Mon,  2 Nov 2026 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793615184;
 bh=xiZWR7MaKJ5/XXRMcZ/1gL4X0GDJb0I7yF/H3xu1WfI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GZbqZz5P/aT/gcn9afjUbb7UYctEY01COLwzCiuHisjLqNMiH7kgZtQY/ucNnMxtK
 7pg3OYAz5f1gfLVZL9yaQGkOXCNbG8gBltpQvGBXHidvOywEyhX2TScd2UrmBVNdGK
 jyvtquDGbaLUV3kf/P+bC8opPN/QpRwlhzCfjZp/926kwpwhtpHq9Xibk1doVI9CQE
 HiH+xA6Rc1Vu94bh1OMtk53ax+xYJUehOhj2wJXbQAsc+pHIL9J2JnwWq+P06OXuPd
 OvryaoWCdE9sFCkME7RZS3eDcNOpZ7xsHOVeZABB9Vmw6PS/Vv/uov5cuiOODpqCTi
 1jxCIZ5/r9xWw==
Message-ID: <sashiko-outbox-193253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 2/7] drm/ttm: Add NUMA node aware restore helpers
To: "Himal Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261102101803.455921-11-himal.prasad.ghimiray@intel.com>
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
 <20261102101803.455921-11-himal.prasad.ghimiray@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:26:24 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/ttm: unused helper and EXPORT_SYMBOL() on ttm_pool_restore_and_=
alloc()
--

commit 8d0a6d62696c67cc37673b025155aa37dad8e6a7
Author: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

drm/ttm: Add NUMA node aware restore helpers

This commit introduces ttm_tt_restore_node() and
ttm_pool_restore_and_alloc_node() so callers can preserve a specific NUMA
node placement when restoring backed-up TTM pages.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 54d2f6b5c229c..2107dc6c69b36 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -962,6 +962,30 @@ EXPORT_SYMBOL(ttm_pool_alloc_node);
>   */
>  int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  			       const struct ttm_operation_ctx *ctx)
> +{
> +	return ttm_pool_restore_and_alloc_node(pool, tt, ctx, NUMA_NO_NODE);
> +}
> +EXPORT_SYMBOL(ttm_pool_restore_and_alloc);

[Severity: Low]
Is ttm_pool_restore_and_alloc() still needed now that ttm_tt_restore() in
drivers/gpu/drm/ttm/ttm_tt.c delegates to ttm_tt_restore_node(), which
calls ttm_pool_restore_and_alloc_node() directly?

Previously, ttm_pool_restore_and_alloc() was an unexported TTM-internal
helper whose only caller was ttm_tt_restore(), and external drivers cannot
call it directly because only ttm_tt_restore() and ttm_tt_restore_node()
clear TTM_TT_FLAG_BACKED_UP on tt->page_flags. With ttm_tt_restore()
switched over to ttm_tt_restore_node(), ttm_pool_restore_and_alloc() has no
remaining callers in the tree, yet it is kept and newly exported with
EXPORT_SYMBOL().

Should ttm_pool_restore_and_alloc() and its EXPORT_SYMBOL() be dropped (or
kept unexported if there is a planned internal user)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102101803.4559=
21-9-himal.prasad.ghimiray@intel.com?part=3D2
