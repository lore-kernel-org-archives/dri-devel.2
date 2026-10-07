Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C8FCA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 02:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B2910F46C;
	Wed,  7 Oct 2026 02:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ljgGfQBs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F9010F466
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 02:00:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E91F7602BA;
 Wed,  7 Oct 2026 02:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795FC1F008A0;
 Wed,  7 Oct 2026 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791338406;
 bh=WXZx5n5/hRclOBB7Bnz3Km+4xEql8XWhwonTBM89i14=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ljgGfQBs2XSWdJ8jj1mAypoxyxU2muW+TzMD3qfY//xJYESHQhEritrop2aaq/I9/
 OzrtFB3UpRqiwrQwiRTIBDtrF9kZd9mqsGL4llEVd/SEzo/glqABXft8/G1rfNdPws
 uxz7pEVJNncLKMfeKpeVYV95MuYj/m3vRw+J9G+tOU0Q9kXwXyXuVqfX+RGOYyC1vE
 PScSxNRlEI/22ytBUkcEPOnAFCOKSCDPXRD2QjkKg7mWZmaCDzUglf46hPac2gzJ7D
 XpiWDkSWVP+uuC70mrQhgAc4QV6VUNfRZeBO8//bsKIL66IWOPRIUUFbwYTX6EuCZf
 5vnUmYRVe7bMQ==
Message-ID: <sashiko-outbox-162577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/13] nvme-pci: add SGL support for the dmabuf path
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <0613da77bbb89c3128221ffed3a76af4817981cd.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
 <0613da77bbb89c3128221ffed3a76af4817981cd.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 02:00:06 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] nvme: redundant loop in dmabuf SGL chunk calculation executes only =
once
--

commit 5d24f863d7ba89114279230e25c2589da96688b4
Author: Anuj Gupta <anuj20.g@samsung.com>

nvme-pci: add SGL support for the dmabuf path

Add SGL support in addition to PRP for dmabuf-backed requests,
building the descriptor list from the mapping's sg_table.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
[ ... ]
> +static unsigned int nvme_pci_dmabuf_sgl_nents(struct request *req)
> +{
[ ... ]
> +		do {
> +			size_t chunk =3D min(remaining, sg_len);
> +
> +			nents++;
> +			sg_len -=3D chunk;
> +			remaining -=3D chunk;
> +		} while (sg_len && remaining);
> +	}
> +
> +	if (unlikely(remaining))

[Severity: Low]
Since chunk is the minimum of remaining and sg_len, subtracting it from both
guarantees that at least one of them will become zero on the first iteratio=
n.

Does this mean the while (sg_len && remaining) condition is always false
immediately, making the loop execute exactly once?

Is there a missing SGL segment length cap that was intended here?

[ ... ]
> +static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
> +		struct nvme_queue *nvmeq, unsigned int entries)
> +{
[ ... ]
> +		do {
> +			u32 chunk =3D min_t(size_t, remaining, sg_len);
> +
> +			if (WARN_ON_ONCE(mapped =3D=3D entries))
> +				goto err_free;
> +			nvme_pci_sgl_set_data(&sg_list[mapped++], addr, chunk);
> +
> +			addr +=3D chunk;
> +			sg_len -=3D chunk;
> +			remaining -=3D chunk;
> +		} while (sg_len && remaining);
> +	}

[Severity: Low]
This mapping loop shares the same logic as nvme_pci_dmabuf_sgl_nents().

Since chunk will fully consume either remaining or sg_len, the loop conditi=
on
(sg_len && remaining) will evaluate to false after the first iteration.

Could this logic be simplified, or was a chunk size limit omitted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791336930.gi=
t.asml.silence@gmail.com?part=3D8
