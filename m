Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD414606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXBrqcb9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA8410E4D1;
	Tue, 17 Nov 2026 01:24:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544B510E4D1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:24:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9499D61417;
 Tue, 17 Nov 2026 01:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89E41F000C4;
 Tue, 17 Nov 2026 01:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794878674;
 bh=fUz9lscnO4Cx3RAzfp3z61lIY1HBMYfhVdYDoXwTuWg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=QXBrqcb9f7Y2eVglCRELwIhBq6eOIc+UcbutWMz3XAzAY9SQctzNLRTjwFrPabQQx
 WpCZ5MtDZ3gpxLcuWS9bAledg+McggA6+7Z14MoQPRSwnjg9CsAQZZCo80mb/d3REh
 QwMuqAykjs4teLpw2h1oUSmmT9ZD9c3FFNDwYIC8nAYhcvNPzMrRIe8oRswZiMUurh
 PyvsPxOj7HfNlF1Ci5JlLniz0ty1it7yfvbDv7Yb9UU8Zh52Um6LdELVKT065Iohl+
 GPZm81kCclxKXiZGD+ogiv1rtNFsRnLl2TFIEcLn9k+ZBoMnEIgS4nGt10OEfQ3Fx2
 SWwCiMjkBJaBg==
Message-ID: <sashiko-outbox-218040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] drm/vmwgfx: Reserve ttm object before resv usage
To: "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261117005945.806941-2-maaz.mombasawala@broadcom.com>
References: <20261117005945.806941-2-maaz.mombasawala@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 01:24:33 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/vmwgfx: UAF and NULL deref on guest_memory_bo in
  crc_generate_worker()
- [Low] drm/vmwgfx: missing Fixes trailer and inaccurate TTM type in
  commit message
--

commit 9ec8429beccaa97a3b1b9ddc00c56d85a9cbdb38
Author: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

> drm/vmwgfx: Reserve ttm object before resv usage
>=20
> We hit dma_resv_assert_held warnings, reserve the ttm base object when it=
's
> being used to avoid them.
>=20
> Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

[Severity: Low]
This fixes the unreserved BO map in compute_crc().  Should it include:

  Fixes: 7b0062036c3b ("drm/vmwgfx: Implement virtual crc generation")

Also, surf->res.guest_memory_bo->tbo is a struct ttm_buffer_object rather
than a struct ttm_base_object.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_vkms.c
> index 3d0d5dfa869f9..ef163d4b64d1f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> @@ -131,6 +131,7 @@ crc_generate_worker(struct work_struct *work)
>  	spin_unlock_irq(&du->vkms.crc_state_lock);
> =20
>  	if (surf) {
> +		int ret;
>  		if (vmw_surface_sync(vmw, surf)) {
>  			drm_warn(
>  				crtc->dev,
> @@ -138,7 +139,14 @@ crc_generate_worker(struct work_struct *work)
>  			return;
>  		}
> =20
> +		ret =3D ttm_bo_reserve(&surf->res.guest_memory_bo->tbo, false, false, =
NULL);
> +		if (ret !=3D 0) {
> +			drm_warn(&vmw->drm, "%s: failed reserve\n", __func__);
> +			goto done;
> +		}
>  		compute_crc(crtc, surf, &crc32);
> +		ttm_bo_unreserve(&surf->res.guest_memory_bo->tbo);

[Severity: High]
Can surf->res.guest_memory_bo become NULL or be freed while
crc_generate_worker() accesses it?

crc_generate_worker() holds a reference on surf, but res->guest_memory_bo
is only stabilized while surf->res is reserved or pinned.  During an
atomic commit, drm_atomic_helper_commit_tail() cleans up and unpins the
old plane state's surface before vmw_atomic_commit_tail() flushes
du->vkms.crc_generator_work.  For a dumb scanout buffer, vmw_dumb_create()
drops the surface's GEM reference on the BO, so once the FB and dumb BO
are destroyed, vmw_bo_free() clears surf->res.guest_memory_bo and frees
the BO even while crc_generate_worker() still holds surf:

CPU0                                  kworker (crc_generate_worker)
----                                  -----------------------------
vmw_atomic_commit_tail()
  drm_atomic_helper_commit_tail()
    ...
      vmw_stdu_primary_plane_cleanup_fb()
        vmw_resource_unpin(&surf->res)
                                      surf =3D vmw_surface_reference(...)
                                      vmw_surface_sync(vmw, surf)
vmw_bo_free()
  res->guest_memory_bo =3D NULL
  ...
  kfree(vbo)
                                      ttm_bo_reserve(
                                        &surf->res.guest_memory_bo->tbo, ..=
.)
                                        <-- NULL pointer dereference / UAF

If vmw_bo_free() or vmw_cmd_bind_gb_surface() changes
surf->res.guest_memory_bo between ttm_bo_reserve() and
ttm_bo_unreserve(), re-reading surf->res.guest_memory_bo in
ttm_bo_unreserve() also unlocks the wrong reservation object or
dereferences NULL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117005945.8069=
41-2-maaz.mombasawala@broadcom.com?part=3D1
