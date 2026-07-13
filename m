Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE03C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A7E310E547;
	Mon, 13 Jul 2026 05:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hsM0Jp6c";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C13010E547
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:34:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DA8C60018;
 Mon, 13 Jul 2026 05:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5501F000E9;
 Mon, 13 Jul 2026 05:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783920889;
 bh=xOtGlmeHnh4cfJlXl+UUiDNxxyNwG95RqLwvTPoSeMc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hsM0Jp6cKUlEUVJygAGQQiXjp4Qu5PUChhf6cf6H2uInwQNlK0gH+x4R0zryb5Fd9
 dQ1OzYSxtehZ7rVZ0906Kb7A/yBFDxjFWEzoK0xbXjbLMkJQalBCLO9LQ5bN1I/tyy
 C/KcLejGm097o73+5gtWqL2nuWYHSSk58zETi4+z0gXzr2YkLbrLyL3vOtXABHAFXr
 LAve8a7EFoLIGNwsEvJt6LOVY7I+vwZKJZU8XPxIDS1Fvc0RpTkUmZWY2SpDIdDbxS
 mrZRoX7SQRvhlJGPqi6vroTRxxW3b99MDPvl+MRnqRTHecy468x4aqsHyJC90/Gw64
 yjd/buXFGbOxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/4] misc: fastrpc: Move fdlist to invoke context
 structure
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713052236.3033744-2-ekansh.gupta@oss.qualcomm.com>
References: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
 <20260713052236.3033744-2-ekansh.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:34:48 +0000
Message-Id: <20260713053448.CE5501F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Arbitrary kernel memory read to userspace via untrusted `rpra`=
 pointers.
- [Critical] Use-After-Free via DSP-manipulated `fdlist` dropping active ma=
p references.
- [Medium] Memory leak of `fastrpc_map` objects on timeout or interruption.
--

--- Patch [1]: [PATCH v13 1/4] misc: fastrpc: Move fdlist to invoke context=
 structure ---
commit 3273bebbc8c035be416508d67400b312f049c6e6
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

misc: fastrpc: Move fdlist to invoke context structure

This commit moves the fdlist from being recalculated during
fastrpc_put_args() to being stored directly in the fastrpc_invoke_ctx
structure. This centralizes its handling and simplifies the meta buffer
preparation and reading logic.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c681..02c2765e1188c 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -1165,18 +1167,11 @@ static int fastrpc_put_args(struct fastrpc_invoke=
_ctx *ctx,
>  	union fastrpc_remote_arg *rpra =3D ctx->rpra;
>  	struct fastrpc_user *fl =3D ctx->fl;
>  	struct fastrpc_map *mmap =3D NULL;
> -	struct fastrpc_invoke_buf *list;
> -	struct fastrpc_phy_page *pages;
> -	u64 *fdlist;
> -	int i, inbufs, outbufs, handles;
> +	u64 *fdlist =3D ctx->fdlist;
> +	int i, inbufs;
>  	int ret =3D 0;
> =20
>  	inbufs =3D REMOTE_SCALARS_INBUFS(ctx->sc);
> -	outbufs =3D REMOTE_SCALARS_OUTBUFS(ctx->sc);
> -	handles =3D REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDL=
ES(ctx->sc);
> -	list =3D fastrpc_invoke_buf_start(rpra, ctx->nscalars);
> -	pages =3D fastrpc_phy_page_start(list, ctx->nscalars);
> -	fdlist =3D (uint64_t *)(pages + inbufs + outbufs + handles);
> =20
>  	for (i =3D inbufs; i < ctx->nbufs; ++i) {
>  		if (!ctx->maps[i]) {

[Severity: Medium]
This is a pre-existing issue, but does this code leak the fastrpc_map
objects if an invoke operation times out or is interrupted?

If fastrpc_internal_invoke() exits early for timeouts or signals, it skips
fastrpc_put_args() and leaves the context in the pending list:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
    ...
    if (err !=3D -ERESTARTSYS && err !=3D -ETIMEDOUT) {
        /* We are done with this compute context */
        spin_lock(&fl->lock);
        list_del(&ctx->node);
        spin_unlock(&fl->lock);
        fastrpc_context_put(ctx);
    }
    ...
}

When the DSP eventually replies, the completion callback asynchronously fre=
es
the context via fastrpc_context_free(). However, fastrpc_context_free() does
not execute the fdlist cleanup logic:

drivers/misc/fastrpc.c:fastrpc_context_free() {
    ...
    for (i =3D 0; i < ctx->nbufs; i++)
        fastrpc_map_put(ctx->maps[i]);
    ...
}

Are maps the DSP returned in fdlist to be released permanently leaked in th=
is
scenario?

[Severity: Critical]
This is a pre-existing issue, but can a compromised DSP cause a
use-after-free by manipulating the untrusted fdlist?

In fastrpc_put_args(), the kernel iterates over fdlist and drops references
for maps without verifying if they are actively in use by the current
context:

drivers/misc/fastrpc.c:fastrpc_put_args() {
    ...
    for (i =3D 0; i < FASTRPC_MAX_FDLIST; i++) {
        if (!fdlist[i])
            break;
        if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
            fastrpc_map_put(mmap);
    }
    ...
}

If a malicious DSP injects file descriptors of actively used maps (e.g.,
those in ctx->maps[i]), it could cause their reference count to drop to zero
prematurely. When the context is subsequently destroyed, the kernel drops
references again:

drivers/misc/fastrpc.c:fastrpc_context_free() {
    ...
    for (i =3D 0; i < ctx->nbufs; i++)
        fastrpc_map_put(ctx->maps[i]);
    ...
}

Could this lead to memory corruption when ctx->maps[i] is freed twice?

[Severity: Critical]
This is a pre-existing issue, but does this code allow arbitrary kernel mem=
ory
disclosure via untrusted rpra pointers?

The rpra array resides within ctx->buf->virt, a DMA-mapped buffer accessible
by the DSP. In fastrpc_put_args(), the kernel blindly reads the source poin=
ter
and length directly from this shared memory:

drivers/misc/fastrpc.c:fastrpc_put_args() {
    ...
            void *src =3D (void *)(uintptr_t)rpra[i].buf.pv;
            void *dst =3D (void *)(uintptr_t)ctx->args[i].ptr;
            u64 len =3D rpra[i].buf.len;

            if (!kernel) {
                if (copy_to_user((void __user *)dst, src, len)) {
    ...
}

If a compromised DSP manipulates rpra[i].buf.pv and rpra[i].buf.len to point
to arbitrary kernel addresses, will the kernel pass these directly to
copy_to_user(), leaking sensitive data to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713052236.3033=
744-1-ekansh.gupta@oss.qualcomm.com?part=3D1
