Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1403606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1eoPyEZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480FE10E13D;
	Wed,  4 Nov 2026 00:29:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7586610E13D
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 00:29:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B97960A8D;
 Wed,  4 Nov 2026 00:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA511F000C1;
 Wed,  4 Nov 2026 00:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793752172;
 bh=Phj/3A3+c8qLtTV4yeoJwZtccWt1ozqkbrUjZ1WAX+Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V1eoPyEZ8dckgA1jQAaHLZmpsMLspLTN/5p5US7OvQjQeKwEFFxHMm5yorMdGsne0
 ZeBOivLy2TEgGVtmYb/Wae7DcE8yMsV+asPOmGmrx0SMgzuo5pHC6ImAJeVJGUGt4i
 tDKa73TUIDnz6nNy7JfL3pZFPZObE8msYAPC2QzZ/kjdFr7rOcmP01jRDBhXPBrheg
 1hLgSFQhvF64APH/RSXFMguqyaIbuYpmnoy1hdBPyQ49L9SwovPruCjwaQXi1VuZ0u
 BeWltUiKVuPqweTMx6djMOdNBrKVTs/00NR4/MkpjZ0S0H5PGJGvNJGp4CoVq75T2H
 uhEQyojj9zNPA==
Message-ID: <sashiko-outbox-196312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] dma-buf-io: add tags for sharing ctx b/w files
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <9fc301319428c6c47fa183ff90d60abcca8ea63b.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
 <9fc301319428c6c47fa183ff90d60abcca8ea63b.1793751001.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:29:31 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] fs: uninitialized or stale f_dma_io_tag in init_file()
- [Low] fs: missing kernel-doc entry for f_dma_io_tag in struct file
--

commit 4c6695df72954d7137a1d0c3d35307639c41ca7f
Author: Pavel Begunkov <asml.silence@gmail.com>

dma-buf-io: add tags for sharing ctx b/w files

This commit adds an importer_tag field to struct dma_buf_io_ctx and an
f_dma_io_tag field to struct file so that a dma-buf I/O context can be
shared across compatible files belonging to the same subsystem instance.

> diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
> index d9f27650a851e..299edf0baaf32 100644
> --- a/include/linux/dma-buf-io.h
> +++ b/include/linux/dma-buf-io.h
> @@ -48,10 +48,32 @@ struct dma_buf_io_ctx {
>  	enum dma_data_direction			dir;
>  	bool					is_dead;
> =20
> +	/*
> +	 * Tags represent an instance of the subsystem the dma-buf I/O
> +	 * context is bound to, the set of underlying devices and subsystem
> +	 * specific map / context structure representations. Remember the
> +	 * registration file's tag (see struct file::f_dma_io_tag) and use
> +	 * it to filter out files that don't share it.
> +	 */
> +	unsigned long				importer_tag;
> +
>  	void					*dev_priv;
>  	const struct dma_buf_io_ops		*dev_ops;
>  };
> =20
> +/**
> + * dma_buf_io_file_compatible - Check compatibility b/w context and file.
> + * @ctx:	[in]	dma-buf I/O context
> + * @file:	[in]	file
> + *
> + * Returns true if the context can be used to issue I/O to the given fil=
e.
> + */
> +static inline bool dma_buf_io_file_compatible(const struct dma_buf_io_ct=
x *ctx,
> +					      const struct file *file)
> +{
> +	return file->f_dma_io_tag =3D=3D ctx->importer_tag;
> +}

[Severity: High]
Can file->f_dma_io_tag contain uninitialized or stale slab data here and in
dma_buf_io_ctx_create() in drivers/dma-buf/dma-buf-io.c?

In fs/file_table.c, alloc_empty_file(), alloc_empty_file_noaccount(), and
alloc_empty_backing_file() allocate struct file objects from filp_cache and
bfilp_cache via kmem_cache_alloc() without __GFP_ZERO. Because those caches
use SLAB_TYPESAFE_BY_RCU, init_file() explicitly initializes the fields of
struct file on allocation and reuse:

fs/file_table.c:init_file() {
	...
	f->f_iocb_flags =3D 0;
	f->f_pos	=3D 0;
	f->f_wb_err	=3D 0;
	f->f_sb_err	=3D 0;

	file_ref_init(&f->f_ref, 1);
	return 0;
}

Since init_file() does not zero f->f_dma_io_tag, if a tagged file is closed
and its slab object is reused for an unrelated file whose open path does not
set f_dma_io_tag, wouldn't the new file retain the previous file's
f_dma_io_tag and cause dma_buf_io_file_compatible() to report a match?

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c4..a9bb63cf6f9d8 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1293,6 +1293,12 @@ struct file {
>  		freeptr_t		f_freeptr;
>  	};
>  	file_ref_t			f_ref;
> +
> +	/*
> +	 * A tag representing the underlying subsystem for dma-buf I/O.
> +	 * See struct dma_buf_io_ctx::importer_tag.
> +	 */
> +	unsigned long			f_dma_io_tag;

[Severity: Low]
struct file in include/linux/fs.h has a kernel-doc comment block above its
definition. Should an @f_dma_io_tag entry be added there as well so
scripts/kernel-doc does not warn about an undescribed struct member during
documentation or W=3D1 builds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793751001.gi=
t.asml.silence@gmail.com?part=3D1
