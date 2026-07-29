Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C51C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E32B10E66C;
	Thu, 30 Jul 2026 07:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="a/vx3sBp";
	dkim-atps=neutral
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654FF10EC40
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:31:15 +0000 (UTC)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260729133113epoutp047e72fee530f6e04c625cea6b54a0adb1~GxeE_0P0_2784827848epoutp04g
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260729133113epoutp047e72fee530f6e04c625cea6b54a0adb1~GxeE_0P0_2784827848epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1785331873;
 bh=ZDJk27gz63Bjx+XAUOCj+oZxhX4eQ8qfTG8bNQ0cMfY=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=a/vx3sBpS/twRkYi1yYleTFghokVhPFGbyJBTuoA0tnB3E+P8eDvzp6JfzVf3SEz3
 X42C0s/dWsZL55ZqOZKs8UOHQgWrNJJT7qY9tQd+sBH5Uh+TAM8gFdOCvbZR5Gdzow
 w4HlYs4R0lC4adNXeJEodErFhPZUbOhGLjE6zSqQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20260729133112epcas5p3bd1d18bb66b0f8808d9cacfabc76c032~GxeENHPUg2902429024epcas5p3H;
 Wed, 29 Jul 2026 13:31:12 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4h9CsC4dk9z6B9m5; Wed, 29 Jul
 2026 13:31:11 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20260729133110epcas5p4c215a866cd371ec48e2608765dc26ad9~GxeCj-bm90481504815epcas5p4d;
 Wed, 29 Jul 2026 13:31:10 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260729133105epsmtip2d312a27a0649b2d7cf4807b11b2517f0~Gxd95g22x2496024960epsmtip2k;
 Wed, 29 Jul 2026 13:31:05 +0000 (GMT)
Message-ID: <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Date: Wed, 29 Jul 2026 19:01:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] io_uring/rsrc: extend buffer update
To: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
 Joshi <joshi.k@samsung.com>, Jason Gunthorpe <jgg@nvidia.com>, Damien Le
 Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer
 <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Benjamin
 Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, Ilya
 Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <633d33d8e278999f55126794fce948343403494a.1785274111.git.asml.silence@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260729133110epcas5p4c215a866cd371ec48e2608765dc26ad9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260728213008epcas5p418dfc10b7ef786e162ade86d14430475
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213008epcas5p418dfc10b7ef786e162ade86d14430475@epcas5p4.samsung.com>
 <633d33d8e278999f55126794fce948343403494a.1785274111.git.asml.silence@gmail.com>
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:56 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 7/29/2026 2:59 AM, Pavel Begunkov wrote:
> @@ -882,8 +894,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
>   	struct io_imu_folio_data data;
>   	bool coalesced = false;
>   
> -	if (!uaddr) {
> -		if (size)
> +	if (desc->type >= __IO_REGBUF_TYPE_MAX)
> +		return ERR_PTR(-EINVAL);
> +	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
> +		return ERR_PTR(-EINVAL);

desc->flags  isn't validated here, unlike __resv. nonzero flags should 
be rejected too?

> +
> +	if (desc->type == IO_REGBUF_TYPE_EMPTY) {
> +		if (uaddr || size)
>   			return ERR_PTR(-EFAULT);
>   		/* remove the buffer without installing a new one */
>   		return NULL;

