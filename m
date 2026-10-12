Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BB8CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC38210E5FB;
	Mon, 12 Oct 2026 20:21:18 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE00010E5FB
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:21:12 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-6d00d120b28so1449537eaf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836472; x=1792441272;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7YdOwQKvIOtKNWjhAuzTAXTxb0yaTLWKFCpvhJolByA=;
 b=g0/ShmIz1WuyfWqAa3izlOdrnR5TFdTR9dfZqUp1qlYNLgUTdQ5CRhtojAzg++z58y
 tfbAfp0HHX4BlF1qUCmv4RCzNhU32b7TSyFDv049JrfNrrUKjcxFSbkbskbhhX98B6PQ
 hi+In+d7SEE7z5jh3e779160/Ephp7elKKn1tk+pPwjCSim24n7m6FhJJpcYO50kInaa
 vcwMQDRg4830CzeoLK++O6PQFj23HKn1Wdv/EDGs0gvhDKQIdFzvgTldaqPIj2GneWKi
 S4wtOudZ9niPrzaroQv+mfs7R56PgQ982w5RLM6dLpyGd9zib2FUB+4f+gi4vyPhYlgt
 LmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836472; x=1792441272;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7YdOwQKvIOtKNWjhAuzTAXTxb0yaTLWKFCpvhJolByA=;
 b=TwfN0ZFn15NNgmdH1imy9mGUrjGG95661IwMrwAvPEj1RJhi6UsPppck+Y+XGaWRlx
 lgaj+YqZYPTp7Fi03aOMT16pGMnFkZUjio4SSthEra/nsLYKmiOZ4a32aY/Gvet/y8dc
 GUttNWs5TFy0AItw4mpZ4Tbsu/0rD2RlrkuH+av3ud2dIFGULKHcDKyjyHLZqz3cj2da
 sKhOZybTPhiAwvk8Memxy92V7H2CkTzJ8paX5mlTc0/mjqnEtHXXKR525M78CJwwiOhf
 Wm+60UFFugGzFhWpz8vs4iUPPqIu2j67O9Bk77p8OxzkVHtR+iXqehOnZPoN7enhw+Vb
 e9PQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLf9wRHgbgDRmgxyCey8/xe3ZTvYZC1lPYHDjP9xZ4NPiaxPxIfCx94Df9Ry/LqCZyT5hDHa1MlBw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLcXVeG+yHAUC7GyoFgAZ06/MK10gXx6y5XQJInj3SdLqV+6/4M
 jMtDx874adC+JajR/AuiBDkE5nd3hv8S6DncvQdTm0yu8LW0riNxgeXtXIyZU/ojD8c=
X-Gm-Gg: AYBFou0gd/7bqGYsyzIuKnaNZGy6LXUipFubh4TRaWUiaTkiDAs1vPr5Y1iL6P/ID25
 96KsIibod3itAnUUHergRypQKF5CYsZDQwv93CLFVPHce2Z5NMbSSkLIfoUUAQQ1bHM8wDw4nTL
 5nsl8ktCiPLnRPU7Xb6Im4iPrKLkhN28Y1An9DikS/wezg70foSTkzrXO9j2NvEBY0lARuVb4Pl
 vqNv49rP1ODaaIqs7N+dkT72WabnKYZ5X3FEG8rDB/uSqMcAGO/h8F26osFCKRpR2leIm1Qpoyj
 Q1FUd3ZOd2F5FNgdvtWHqfGyL/5+OYmJ10T+Q5vZayGtSzuHgPnL00VvwYTyRmoJnp25/fvAPqi
 qPeVs5MUHmJE55GjalD+hSaPpNkMlMZCGKOZAbIlesrTNJxwv2u4hhlUfNemjrusgwyvsVGb+Z4
 1YwThaOdd3XtGUNhToY2zuNSdK+PlG/kvUh6lxefic3f1DHjnx8t5KumtHL2/XVyTf36M0/hMNy
 Bx9WjoiwzRa4qvKkvBR1DCLaAy/ZqnvRzCIN4gdjq7ho14t28ZuwxIivg==
X-Received: by 2002:a05:6820:162a:b0:6f7:75ab:f969 with SMTP id
 006d021491bc7-6f775bb41f5mr1943854eaf.66.1791836471882; 
 Mon, 12 Oct 2026 13:21:11 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ef02d91a5asm10237414eaf.14.2026.10.12.13.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 13:21:10 -0700 (PDT)
Message-ID: <07d36bc7-637f-4554-9d6f-039e88852dc6@kernel.dk>
Date: Mon, 12 Oct 2026 14:21:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/13] block: add dma-buf support for raw bdev
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <CGME20261007014324epcas5p2a7f3b03f118c9a1d1c633fe839ed1e46@epcas5p2.samsung.com>
 <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336930.git.asml.silence@gmail.com>
 <bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com>
Content-Type: text/plain; charset=UTF-8
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

On 10/8/26 6:27 AM, Anuj Gupta/Anuj Gupta wrote:
> On 10/7/2026 7:12 AM, Pavel Begunkov wrote:
>> +static int blkdev_init_dma_buf_io_ctx(struct file *file,
>> +				      struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct block_device *bdev = file_bdev(file);
>> +	struct gendisk *disk = bdev->bd_disk;
>> +
>> +	if (!(file->f_flags & O_DIRECT))
>> +		return -EINVAL;
>> +	if (!disk->fops->init_dma_buf_io_ctx)
>> +		return -EOPNOTSUPP;
> 
> dma-buf doesn't work with PI: bi_dmabuf_map aliases bi_io_vec, and 
> blk_integrity_iterate() walks it as bvecs to generate/verify the 
> checksum. rw-dmabuf liburing test hangs on a PI enabled NVMe. Something 
> like below is needed:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e929f94b25c7..1b7f8cbbda8b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3150,6 +3150,12 @@ void blk_mq_submit_bio(struct bio *bio)
>                  goto queue_exit;
>          }
> 
> +       if (unlikely(op_is_dmabuf(bio->bi_opf) &&
> +               bdev_has_integrity_csum(bio->bi_bdev))) {
> +               bio_endio_status(bio, BLK_STS_NOTSUPP);
> +               goto queue_exit;
> +       }
> +
>          if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
>                  bio_endio_status(bio, BLK_STS_NOTSUPP);
>                  goto queue_exit;
> diff --git a/block/fops.c b/block/fops.c
> index e9da48ab73be..6c6700df943c 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -976,6 +976,8 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
>                  return -EINVAL;
>          if (!disk->fops->init_dma_buf_io_ctx)
>                  return -EOPNOTSUPP;
> +       if (bdev_has_integrity_csum(bdev))
> +               return -EOPNOTSUPP;
>          return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
>   }

Can you send a separate patch? I've queued this series up for some
testing.

-- 
Jens Axboe
