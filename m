Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00844606A681
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKTiTFCm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECEA10E123;
	Sat, 21 Nov 2026 05:58:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550D410E05C;
 Sat, 21 Nov 2026 05:58:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 516A2601C7;
 Sat, 21 Nov 2026 05:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF51F000C4;
 Sat, 21 Nov 2026 05:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795240728;
 bh=nHgcj4reAewShIct0fcYEQHlKrmsjIW5S883i48uYO0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NKTiTFCmUe9wV/wkagz+EE4Kd6FBLLeeRild/NLY+1KadNk2ZDKp+Aol1cruswpDc
 dyoxXGVMj2zWLx1VrpmZdBd5cvQT7anKY5OWfaFpfwcwAHH17lung+G3bGPvkL2CbA
 dnkqBIt9f6NaoRWUZQvkcEeyveyi8ETSBlP51zM6mF7LvR68mzS90wjinQAqySZftz
 x16OkaQd0ZdtTxTcpVgI33MAFFC6H59HWgr8N7jxVjZ02oVCR2TGNmJrSKmKL6Nef0
 tbprkB97zbxR6P0oJcAHbQPOBK3bc+ItmqIKVHkT0so+bJF8nWG5rVwZ+NHRJvOz3o
 ywc7F1pQrtbqg==
Message-ID: <sashiko-outbox-226681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/24] udmabuf: Convert to the SGT mapping type
To: "Alistair Popple" <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261120-dma_mapping_type_v4-v3-13-c0183a409bdf@nvidia.com>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-13-c0183a409bdf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 05:58:47 +0000
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
- [High] udmabuf: premature publication of ubuf->sg in
  begin_cpu_udmabuf()
--

commit f138ffdf3b226fef46f9eda6001d750e3e320cdd
Author: Alistair Popple <apopple@nvidia.com>

udmabuf: Convert to the SGT mapping type

This commit converts udmabuf to the SGT mapping type by having
get_sg_table() and put_sg_table() operate on a caller-allocated struct
sg_table and embedding the DMA-buf mapping table in struct
dma_buf_sgt_mapping.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index df6dd00462423..ef77ae063ae4c 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c

[ ... ]

> @@ -226,16 +233,19 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
>  	struct device *dev =3D ubuf->device->this_device;
> =20
>  	if (!ubuf->sg) {
> -		ubuf->sg =3D get_sg_table(dev, buf, direction);
> -		if (IS_ERR(ubuf->sg)) {
> -			int ret;
> +		int ret;
> +
> +		ubuf->sg =3D kzalloc_obj(*ubuf->sg);
> +		if (!ubuf->sg)
> +			return -ENOMEM;
> =20
> -			ret =3D PTR_ERR(ubuf->sg);
> +		ret =3D get_sg_table(dev, buf, ubuf->sg, direction);
> +		if (ret) {
> +			kfree(ubuf->sg);
>  			ubuf->sg =3D NULL;
>  			return ret;
> -		} else {
> -			ubuf->sg_dir =3D direction;
>  		}
> +		ubuf->sg_dir =3D direction;
>  	}
> =20
>  	dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);

[Severity: High]
Can assigning ubuf->sg before get_sg_table() finishes expose an
uninitialized, unmapped, or freed sg_table to concurrent
DMA_BUF_IOCTL_SYNC callers?

dma_buf_ioctl() invokes begin_cpu_udmabuf() and end_cpu_udmabuf() without
holding a lock.  Previously, get_sg_table() allocated, populated, and
DMA-mapped a local struct sg_table before returning it to be stored in
ubuf->sg.  With ubuf->sg assigned immediately after kzalloc_obj(), a
second thread can observe a non-NULL ubuf->sg while the first thread is
still inside get_sg_table() (or after kfree(ubuf->sg) on the error path):

CPU0                                  CPU1
begin_cpu_udmabuf()
  ubuf->sg =3D kzalloc_obj(...)
  get_sg_table(..., ubuf->sg, ...)
    sg_alloc_table_from_pages()
                                      begin_cpu_udmabuf()
                                        if (!ubuf->sg) /* false */
                                        dma_sync_sgtable_for_cpu(...,
                                                                 ubuf->sg,
                                                                 ...)
                                          /* uninitialized or freed sgt */

If two threads both enter the !ubuf->sg block, the second kzalloc_obj()
also overwrites ubuf->sg while the first thread passes ubuf->sg to
get_sg_table(), leaking the first allocation and initializing the same
struct sg_table concurrently.

Allocating into a local struct sg_table *sg and assigning ubuf->sg only
after get_sg_table() succeeds avoids publishing the table prematurely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dma_mappin=
g_type_v4-v3-0-c0183a409bdf@nvidia.com?part=3D13
