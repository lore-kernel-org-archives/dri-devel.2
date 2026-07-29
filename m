Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6707CC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4DDD10E064;
	Wed, 29 Jul 2026 13:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YQD4vcIy";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9E110E04D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:43:45 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a051b73866so1226259a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785332624; x=1785937424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GoC91kED98vuJAvVTLdEFxjWPhyWXTYJuu42/1RW6zQ=;
 b=YQD4vcIyZZDS5Mtj6jOTY5BzeJf6+qGVyM0fCNQf3Zt5cWMupgurSRQGoBCgFeDuM+
 1R0oKkNL6JvXnK1xt1ZMhgJJ+pkgYCSOm8qLbO4VNcyO0kvKGPGfkhfMUhPe+ZbJ6rhn
 TFvOqRlgK8XfuvmqQ0mmjRIjQgWoPurY4bIsKUYJfIxrluswJbzRVgC4J8GpUKrLPSIr
 3S9b3FBDqXuPr+Fc+2Q2hJljnfV0Cn8JKy2kCamThUmLiADeHVOTgDZaDE+BMOCOpDJn
 VWid5pA4OZVrNOegp2OtRZIDonWL/ARrttMKn6e26Iy2dKJmJBD2GOuXpueDMmtBtn+4
 R/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332624; x=1785937424;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GoC91kED98vuJAvVTLdEFxjWPhyWXTYJuu42/1RW6zQ=;
 b=EszsANEIYGlM7pMtHuSYApP6dUP+nov1qkHk6Bwo4GTdEIPFxkYlgHjXjTu8cJCQwt
 oc+goEvMy7UZc8WyXDvREx/w/W3/qnlrqwhxwBLGWVejrSXaMUcyjSoeCwiyZ92bOTV2
 vAOiUJeejv9NfESNNrAXa9rLr68ZOBip1DbU1o2/3VYa2XaZiT8vV1jpZtd11jA//BZL
 1bP+spztYs00BTu55LGnkJEX78g/yMKZFGDx9aB8DmtLllwj05YTM0KyflZsDoGMGrTJ
 kaikHD5LcCDT/1467x9O66y2Gbx/yGgNWuAUeJRllXCAqnq70maf6bOPaL3uz9JKWeBt
 KGpw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSacpdeO+Axam9AMTTtEKYratmKNqg+PA2Xdd8NqI52qB/mrC/P13RN99VnIjR5OUsXjk1Plzgeqw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcPZAm5d/PngyIIiZn2imKqWlz+mMfsQGQ7T+AfNiyXH4Skmdb
 2qsTuEExGZHb5PzSEtxG9or470ctFRcam32NeR2IGe3vZ+ezRtCgSQxH
X-Gm-Gg: AR+sD10DTwS1bxtm6qRmTqL8dMg3ZKWEjtlrreL0vjN1o4/MJRPXXhEqqkGi8Cpo7RL
 ikIGdooR5gdcIzXxlv3aHQ0+YGgziAAfnfOzS55avkHxrhxhy3xI7nK7eZB+G7DgfJ18hxMzW46
 C/Li5MG8yjIm6qsn4jdXhQ2P4Y9ma9u4y4VihZLLCdcrA02BIweviOYmzBAt/7LJvOibQonDwlb
 KJV7VjGqJZpflu1LajnJipvEuMf5iL+wdPkiTM24hJ+9TLlxPC+Gcy+F9hLWDoesuPJli7u8goR
 k3mKFrQoqnKDqegUu9Q8yHhDNQyQqeA48a7NbCMu40ly1rZ02xKb75+dU9JKnVaYkrytCYVNTOb
 25YPJ4G4s/bRbiIego11Sr9tTbHujuAoGPCQZ5igMuAOac20aZMb7SRi2mMXM9WN/RBYOutXadV
 9K87IWwK8AbopPnlnuP9v4URmRCHy3spWcqpzn3AzWk9cGtwmmy1nbl7LU0PdOW4rgYDX2TTutW
 EoKgehV/e7EVNXPrPWE/niscO06ZiaExeXCM5WCodmIHOyXJ30dfrONLhUdFOb10/AFwtGQ4czt
 sz0hi3otKDtlKr2vptg=
X-Received: by 2002:a05:6402:24c8:b0:697:ecb4:b86c with SMTP id
 4fb4d7f45d1cf-6a034a0b240mr2761963a12.2.1785332624180; 
 Wed, 29 Jul 2026 06:43:44 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:640]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050c49fb5sm868560a12.14.2026.07.29.06.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 06:43:43 -0700 (PDT)
Message-ID: <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
Date: Wed, 29 Jul 2026 14:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered
 buffers
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
 <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
 <583fdfb2-5368-467f-a388-6d388859c995@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <583fdfb2-5368-467f-a388-6d388859c995@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/29/26 14:30, Anuj Gupta/Anuj Gupta wrote:
> On 7/29/2026 2:59 AM, Pavel Begunkov wrote:
>> +static struct io_rsrc_node *io_register_dmabuf(struct io_ring_ctx *ctx,
>> +						struct io_uring_regbuf_desc *desc)
>> +{
>> +	struct io_rsrc_node *node = NULL;
>> +	struct io_mapped_ubuf *imu = NULL;
>> +	struct io_regbuf_dma *regbuf = NULL;
>> +	struct file *target_file = NULL;
>> +	struct dma_buf *dmabuf = NULL;
>> +	int ret;
>> +
>> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	if (ctx->flags & IORING_SETUP_IOPOLL)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	if (desc->uaddr || desc->size)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	ret = -ENOMEM;
>> +	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
>> +	if (!node)
>> +		return ERR_PTR(-ENOMEM);
>> +	imu = io_alloc_imu(ctx, 0);
>> +	if (!imu)
>> +		goto err;
>> +	regbuf = kzalloc(sizeof(*regbuf), GFP_KERNEL);
>> +	if (!regbuf)
>> +		goto err;
>> +
>> +	ret = -EBADF;
>> +	target_file = fget(desc->target_fd);
>> +	if (!target_file)
>> +		goto err;
>> +
>> +	dmabuf = dma_buf_get(desc->dmabuf_fd);
>> +	if (IS_ERR(dmabuf)) {
>> +		ret = PTR_ERR(dmabuf);
>> +		dmabuf = NULL;
>> +		goto err;
>> +	}
>> +	if (dmabuf->size > SZ_1G) {
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	ret = dma_buf_io_ctx_create(target_file, &regbuf->ctx, dmabuf,
>> +				    DMA_BIDIRECTIONAL);
>> +	if (ret)
>> +		goto err;
>> +
>> +	regbuf->target_file = target_file;
>> +	imu->nr_bvecs = 1;
> 
> There is no bvec backing a dmabuf imu - should this be 0?

Doesn't really matter as it's not used. It's 1 to say that
it's just 1 contig segment, but I can just zero it to avoid
confusion.

> 
>> +	imu->ubuf = 0;
>> +	imu->len = dmabuf->size;
>> +	imu->folio_shift = 0;
>> +	imu->release = io_release_reg_dmabuf;
>> +	imu->priv = regbuf;
>> +	imu->flags = IO_REGBUF_F_DMABUF;
>> +	imu->dir = IO_IMU_DEST | IO_IMU_SOURCE;
>> +	refcount_set(&imu->refs, 1);
>> +	node->buf = imu;
>> +	dma_buf_put(dmabuf);
>> +	return node;
>> +err:
>> +	kfree(regbuf);
>> +	if (imu)
>> +		io_free_imu(ctx, imu);
>> +	if (node)
>> +		io_cache_free(&ctx->node_cache, node);
>> +	if (target_file)
>> +		fput(target_file);
>> +	if (dmabuf)
>> +		dma_buf_put(dmabuf);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +
> 
> nit: extra newline here
> 
>> +static int io_import_dmabuf(struct io_kiocb *req,
>> +			   int ddir, struct iov_iter *iter,
>> +			   struct io_mapped_ubuf *imu,
>> +			   size_t len, size_t offset,
>> +			   unsigned issue_flags)
>> +{
>> +	struct io_regbuf_dma *db = imu->priv;
>> +	struct dma_buf_io_map *map;
>> +
>> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
>> +		return -EOPNOTSUPP;
>> +	if (!len)
>> +		return -EFAULT;
>> +	if (req->file != db->target_file)
>> +		return -EBADF;
>> +
>> +	if (req->flags & REQ_F_DROP_DMABUF) {
>> +		map = req->dmabuf_map;
>> +		goto init_iter;
>> +	}
> 
> O_DIRECT is checked only during registration; we should recheck
> (file->f_flags & O_DIRECT) per request.

Nobody should be able to clear O_DIRECT, unless I missed something?
And fwiw, io_uring wouldn't be the right place to do it.

-- 
Pavel Begunkov

