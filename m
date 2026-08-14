Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B6FC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2469A10E0DF;
	Fri, 14 Aug 2026 07:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oq1qJOvI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B4710E0DF
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:18:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6325D40B4E;
 Fri, 14 Aug 2026 07:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197DA1F000E9;
 Fri, 14 Aug 2026 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786691909;
 bh=mIFIrVNSsUR7LHEZ/HhymCjqsadDiliMNpd7RF2oFfM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Oq1qJOvI45uTpPE+vd8LFfyaqjAiQiHVhOy05TR45jIY0Lx1VEBr/UMCFl0bPgTBG
 vDjaFcSFIoCwWlf8RtprcIBTLVe8PdO7iBq4aOI6l2N60+i/Vq0ylIH9B/6HTmZhFn
 qMM0lvDzRE2OnWC+zuBhOzKsl2U9hqpUloVlf0oSngrtIa8q0iMN9O1JL1E6roJE3f
 JVHJgAv9TycEcjuA4a5TH2M+823JFODTtpf0pakTXkXRXiUNbVksJYZZh2Rp4T4RpX
 R/9QERjPcylpGgMJiPQCSW2dWZqkW2SYgQLiZa+bLCXGBWXYonGGGaKIEAwh0GRYaN
 E5BbqAXy3ZCzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] accel/amdxdna: return early from a zero-length
 flush
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260813164659.IDBUto6a23fvw6tqWeXNt2bHxg4diPNnnDHJA2p9YYo@z>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
 <20260813164659.IDBUto6a23fvw6tqWeXNt2bHxg4diPNnnDHJA2p9YYo@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:18:28 +0000
Message-Id: <20260814071829.197DA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `SYNC_BO` ioctl unconditionally maps the target buffer into ke=
rnel virtual memory, allowing unprivileged userspace to exhaust `vmalloc` s=
pace and permanently pin physical memory (DoS).
- [High] Dangling `abo->client` pointer causes Use-After-Free in `amdxdna_g=
em_del_bo_usage` when a shared BO outlives its creator client.
- [High] Lockless access to `abo->base.pages` in `amdxdna_flush_bo` causes =
Use-After-Free during `SYNC_BO` on DEV BOs if vmap fails.
- [Medium] Integer overflow in `flush_end` computation causes `SYNC_BO` to =
silently skip flushing DEV BOs when `args->size` is `U64_MAX`.
--

--- Patch [2]: [PATCH v3 2/3] accel/amdxdna: return early from a zero-lengt=
h flush ---
commit af59e76eb538c56b42cb7c548539fdedd358a3a4
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: return early from a zero-length flush

SYNC_BO does not constrain its size, so a request for zero bytes reaches
amdxdna_flush_bo(). On the vmap path that calls drm_clflush_virt_range()
with a length of zero, which flushes the byte in front of the region
rather than anything the caller asked to maintain; on the import path it
flushes the whole scatterlist, since that arm ignores the range.

Nothing needs flushing for an empty range, so answer before choosing a
path.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index d7d36c9523253..1798003cdd45c 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> static void
> amdxdna_gem_del_bo_usage(struct amdxdna_gem_obj *abo)
> {
> 	struct amdxdna_client *client =3D abo->client;
>=20
> 	if (amdxdna_gem_skip_bo_usage(abo))
> 		return;
>=20
> 	guard(mutex)(&client->mm_lock);

[Severity: High]
This isn't a bug introduced by this patch, but can abo->client be a dangling
pointer here?

When a BO is exported via PRIME and imported by another process, open_ref
becomes 2, but abo->client is not updated because amdxdna_gem_obj_open()
returns early:

amdxdna_gem.c:amdxdna_gem_obj_open() {
	...
	abo->open_ref++;
	if (abo->open_ref > 1)
		return 0;
	...
}

If the creator process closes the BO and exits, its amdxdna_client struct
is freed, leaving abo->client dangling. When the importing process later
closes the BO, amdxdna_gem_obj_close() calls amdxdna_gem_del_bo_usage(),
which attempts to acquire the lock inside the freed client struct.
Could this lead to a Use-After-Free?

[ ... ]

> @@ -1259,6 +1259,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj =
*abo, u64 offset, u64 size)
>  		return -EINVAL;
> =20
>  	size =3D min(abo->mem.size, end) - offset;
> +	if (!size)
> +		return 0;
> +
>  	if (is_import_bo(abo))
>  		drm_clflush_sg(abo->base.sgt);
>  	else if (amdxdna_gem_vmap(abo))

[Severity: High]
This is a pre-existing issue, but does this unconditionally map the target
buffer into kernel virtual memory without ever unmapping it?

Any unprivileged user can allocate large BOs and call the SYNC_BO ioctl on
them. Since amdxdna_gem_vunmap() is only called on free, does this allow an
attacker to exhaust vmalloc space and permanently pin physical memory?

>  		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
>  	else if (abo->base.pages)

[Severity: High]
This isn't a bug introduced by this patch, but is abo->base.pages accessed
locklessly while the DEV BO is completely unpinned?

During SYNC_BO on an AMDXDNA_BO_DEV, the DEV BO and its heaps are not pinne=
d.
If amdxdna_gem_vmap() fails, the code falls back here. Since the BO is unpi=
nned
and no locks are held, can a concurrent thread unpin the BO and cause the
shrinker to free the pages array, leading to a Use-After-Free in
drm_clflush_pages()?

>  		drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);

[ ... ]

> 	if (abo->type =3D=3D AMDXDNA_BO_DEV) {
> 		struct amdxdna_gem_obj *heap;
> 		unsigned long heap_id;
> 		u64 bo_start =3D amdxdna_gem_dev_addr(abo);
> 		u64 flush_start =3D bo_start + args->offset;
> 		u64 flush_end =3D flush_start + args->size;

[Severity: Medium]
This is a pre-existing issue, but can flush_end overflow here?

If a user passes U64_MAX as args->size, flush_end wraps around to a small
value. This makes the intersection check (start >=3D end) evaluate to true,
silently skipping the flush. Could this lead to data corruption for the
application using the NPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813164700.4396=
0-1-taimuraz@kaitmazov.com?part=3D2
