Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4C606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=db6l2nVp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C59B10E0BB;
	Wed, 21 Oct 2026 08:50:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D2410E0BB
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:49:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 476E441385;
 Wed, 21 Oct 2026 08:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A531F000C9;
 Wed, 21 Oct 2026 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792572599;
 bh=RxPeosVStRiGb09gsvmxDOp9nHATaNVkM6NfiT90suo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=db6l2nVpWHiONUbE8QnXuisFFFwUsy5xJpo54BrWP8sEmzDc+nDFII47m+GFEUoXq
 eaPfSsTPgewDXQ0ocbnqU1H1FepsWnB0u5a336ji+GwwYr9sNNW5Z1jmMMuyv5szrB
 DoaiOM694ZZtmzvnGkhZ62uKz/JDgRwQX9cslKBn6oA0gYWFXxEL2Z5GYtb07mHSbG
 yz5o3DhFZ9HkWECrXl2zZ0o0IadAwTC1wkzCT2EQX9qSuLxudFup5NFAkhEMsVeyiC
 67ba+NMy52jJJkwspQEAi6T2UGH8bAzXWl6OebqsyTuCoYoCGbsMu3trmr/uNbpbID
 eYWeNALLds2Bg==
Message-ID: <sashiko-outbox-179989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] udmabuf: Increase the default list length limit
To: "Val Packett" <val@invisiblethingslab.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261021083933.1983894-3-val@invisiblethingslab.com>
References: <20261021083933.1983894-1-val@invisiblethingslab.com>
 <20261021083933.1983894-3-val@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 08:49:58 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] udmabuf: order-10 contiguous allocation in udmabuf_ioctl_create_=
list()
- [Low] udmabuf: missing kernel-parameters.txt update for list_limit parame=
ter
--

commit 70d859f4b270b1a12dc2cb5cc01faf794efe4700
Author: Val Packett <val@invisiblethingslab.com>

udmabuf: Increase the default list length limit

This commit increases the default list_limit module parameter in
drivers/dma-buf/udmabuf.c from 1024 to 131072 to support larger page lists
for fragmented guest memory buffers.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 6fb69d8399c18..9aec0e3a1e49b 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -16,9 +16,9 @@
>  #include <linux/vmalloc.h>
>  #include <linux/iosys-map.h>
> =20
> -static int list_limit =3D 1024;
> +static int list_limit =3D 131072;

[Severity: Medium]
With list_limit raised to 131072, udmabuf_ioctl_create_list() in
drivers/dma-buf/udmabuf.c copies the user item array using
memdup_array_user():

	if (head.count > list_limit)
		return -EINVAL;
	list =3D memdup_array_user((void __user *)(arg + sizeof(head)),
				 head.count, sizeof(struct udmabuf_create_item));
	if (IS_ERR(list))
		return PTR_ERR(list);

	ret =3D udmabuf_create(filp->private_data, &head, list);
	kfree(list);

which calls memdup_user() in mm/util.c:

	p =3D kmem_buckets_alloc_track_caller(user_buckets, len, GFP_USER | __GFP_=
NOWARN);
	if (!p)
		return ERR_PTR(-ENOMEM);

Each struct udmabuf_create_item is 24 bytes, so a head.count of 80,000 to
131,072 entries requests roughly 1.83 MiB to 3 MiB (order 9 to order 10 on
4 KiB page systems).

Because memdup_array_user() -> memdup_user() ->
kmem_buckets_alloc_track_caller() allocates physically contiguous memory
without a vmalloc fallback, could this fail with -ENOMEM or stall in direct
compaction on hosts with fragmented physical memory (or fail unconditionally
when the maximum page allocation order is less than 10)?

Should udmabuf_ioctl_create_list() use vmemdup_array_user() and kvfree() for
list instead?

>  module_param(list_limit, int, 0644);
> -MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default =
is 1024.");
> +MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default =
is 131072.");

[Severity: Low]
Since list_limit in drivers/dma-buf/udmabuf.c is exposed as a kernel
command-line parameter via module_param(list_limit, int, 0644) (as
udmabuf.list_limit), should Documentation/admin-guide/kernel-parameters.txt
also be updated to document this parameter and its new default?

> =20
>  static int size_limit_mb =3D INT_MAX;
>  module_param(size_limit_mb, int, 0644);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021083933.1983=
894-1-val@invisiblethingslab.com?part=3D2
