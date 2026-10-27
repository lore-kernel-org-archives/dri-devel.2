Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD7606A320
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWOqY/JL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D517510F55E;
	Tue, 27 Oct 2026 13:51:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53DF10F552
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:51:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40D2443870;
 Tue, 27 Oct 2026 13:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A481F031E0;
 Tue, 27 Oct 2026 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793109062;
 bh=P2v0gHjY9zAAWw1CFgnJ759d38hfc3tu3TD+M1hb/Ec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MWOqY/JL95KVu5wNOZXs1+MAVPx6wb/1wiIPu91mGtell92MMtSufMUr6aJxY9Dox
 oRTiVrJr26/7jWdnuKYqLx1BtHE85rWf/PWsfcJ5wcXfnetESWo4AQnpZC2NCHHEoh
 eZ1d98esyAiPoT8dOqmznblCBl9hhZVualtuq4adpA9aGsskfeGxlUlNlZjQdEhz5x
 PPQGF83mqQoP3i3JgfJJel28zDu1hERPkVBynfTkKrj3pBrn8kdgqW39HxrYxkijnJ
 K+my9iyG7ub+HmBO4B7imckKsIOpv4+8jfBmunlJWZIm8Cy9XLIYnPMjpp5KpzTAON
 VaJ4Z0s3Uhi+Q==
Message-ID: <sashiko-outbox-186668@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: fix use-after-free of fastrpc_user in
 dma_buf release
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261027-fastrpc-fix-v1-1-4610a10a2901@oss.qualcomm.com>
References: <20261027-fastrpc-fix-v1-1-4610a10a2901@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:51:01 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] misc: fastrpc: reference cycle between fastrpc_user and dma_buf
--

commit dec722bc667a70cb2ae899023a7e5c5a5ba8d6fb
Author: Loic Poulain <loic.poulain@oss.qualcomm.com>

misc: fastrpc: fix use-after-free of fastrpc_user in dma_buf release

This commit fixes a use-after-free of struct fastrpc_user during dma_buf
release by taking a reference on fl in fastrpc_dmabuf_alloc() and dropping =
it
in fastrpc_release().

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992eed..36722ed66edff 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -796,8 +796,10 @@ static void fastrpc_unmap_dma_buf(struct dma_buf_att=
achment *attach,
>  static void fastrpc_release(struct dma_buf *dmabuf)
>  {
>  	struct fastrpc_buf *buffer =3D dmabuf->priv;
> +	struct fastrpc_user *fl =3D buffer->fl;
> =20
>  	fastrpc_buf_free(buffer);
> +	fastrpc_user_put(fl);
>  }
> =20
>  static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -1802,10 +1804,12 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_us=
er *fl, char __user *argp)
>  	exp_info.size =3D bp.size;
>  	exp_info.flags =3D O_RDWR;
>  	exp_info.priv =3D buf;
> +	fastrpc_user_get(fl);
>  	buf->dmabuf =3D dma_buf_export(&exp_info);
>  	if (IS_ERR(buf->dmabuf)) {
>  		err =3D PTR_ERR(buf->dmabuf);
>  		fastrpc_buf_free(buf);
> +		fastrpc_user_put(fl);
>  		return err;
>  	}

[Severity: High]
Does taking a reference on fl for the lifetime of the exported dma_buf crea=
te
a circular reference that leaks fl, map, and the coherent DMA buffer when a
dma_buf allocated by fastrpc_dmabuf_alloc() is mapped into the same
fastrpc_user session?

When userspace maps an exported dma_buf into the session (for example via
fastrpc_init_create_process() -> fastrpc_map_create() -> fastrpc_map_attach=
(),
fastrpc_req_mem_map() -> fastrpc_map_create(), or fastrpc_internal_invoke()=
 ->
fastrpc_get_args() -> fastrpc_create_maps()), fastrpc_map_attach() acquires=
 a
reference on the dma_buf and places the map on fl->maps:

drivers/misc/fastrpc.c:fastrpc_map_attach() {
	...
	map->fl =3D fl;
	map->fd =3D fd;
	map->buf =3D dma_buf_get(fd);
	...
	spin_lock(&fl->lock);
	list_add_tail(&map->node, &fl->maps);
	spin_unlock(&fl->lock);
}

In paths such as fastrpc_init_create_process() (or when a process exits
without calling fastrpc_req_mem_unmap()), that map remains on fl->maps until
the session is torn down.

However, fastrpc_device_release() only frees fl->sctx and drops the file's
reference on fl without draining fl->maps:

drivers/misc/fastrpc.c:fastrpc_device_release() {
	...
	fastrpc_session_free(cctx, fl->sctx);
	file->private_data =3D NULL;
	/* Release the reference taken in fastrpc_device_open */
	fastrpc_user_put(fl);

	return 0;
}

Because fl->maps is only drained in fastrpc_user_free() when fl->refcount
reaches zero:

drivers/misc/fastrpc.c:fastrpc_user_free() {
	...
	list_for_each_entry_safe(map, m, &fl->maps, node)
		fastrpc_map_put(map);
}

and fastrpc_free_map() is what calls dma_buf_put(map->buf) to trigger
fastrpc_release(), fl->refcount cannot reach zero until fastrpc_release()
calls fastrpc_user_put(fl), while fastrpc_release() cannot run until
fastrpc_user_free() drops the map on fl->maps.

Additionally, even if the dma_buf is not in fl->maps (for instance, when it=
 is
held open by another process after the fastrpc device fd is closed), keeping
fl alive until fastrpc_release() delays fastrpc_user_free() past
fastrpc_device_release(), leaving fl->init_mem, fl->maps, and fl->mmaps
allocated in the SMMU context bank after fastrpc_session_free() has already
released fl->sctx for reuse by another client.

Since fastrpc_buf_free(), fastrpc_dma_buf_attach(), and fastrpc_mmap() only
dereference buf->fl->cctx for fastrpc_ipa_to_dma_addr(), could struct
fastrpc_buf store a pointer (and reference, if needed) to struct
fastrpc_channel_ctx instead of pinning struct fastrpc_user?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fastrpc-fi=
x-v1-1-4610a10a2901@oss.qualcomm.com?part=3D1
