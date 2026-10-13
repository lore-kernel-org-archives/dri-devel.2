Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E387BCC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489DC10E91F;
	Tue, 13 Oct 2026 20:13:25 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4597210E91F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:13:19 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso1964215e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791922397; x=1792527197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z2hIuYUY9dxFL1uM5B7+C8H4OaVqNBpDv98EiuOQjRo=;
 b=cE16vwM1aSg5S3QO2ABFuW51z6Gdpb2ceZEwld9sirHRwaa1AU6d+o9lZYcCiBxMEP
 ol33dIaMmA7bbuis9KJuQ6hMPfh4roI8bNIw81lG+GvKiurG9/Q13wZK6TrHQAX3JwxZ
 8mukPCQ3yaYD5pPQKaVJv6FUjarWDCm+6mx3+Vf71HZQ+95Et5E9z5IW/kqUTmZMD4Br
 3XZn3iOoDlblMuZYmFVXFdH6qjfFxC5ffwsDHM6/N+sKm3OhNRQrjPRP0s2BKl/V399h
 AKP8kNuEFOVoRHAIk7gu5yAmykCBm48vTBoCl79my8TwA4zx72i/+g3SuH+E5ZQ/IQBG
 I2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922397; x=1792527197;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z2hIuYUY9dxFL1uM5B7+C8H4OaVqNBpDv98EiuOQjRo=;
 b=IXGSGPaNDdXFz3i8GskZ8Q9upOH1HVrJbiZDOe/6Ks9U9xK953FHzzsn5pUrAWIyAN
 orHUfUSTWSrGvvX1EtYHBZcjfmrOL07c/s0ee1rZrkaN8Jau+c0qvdUGklrpPDHOi7A7
 YNtljd3iaxsKAk/LcF/Ok6bvP1RCuS7+7qHGsGKmM7hDmcLNYxThYClkAGOtS0mWXFfA
 00WMxn+BbKjPhaoeRrOQlBfWuUYtN776NMJ7XxoEsT5BHjZ/GfKHqzC9/xttEYF1eV64
 0cJUf9/zSx0XtzpZfOAssm0WcyP8HRNFFAyzYDEFW3mlarIyguvO2LF6MGq40vT810GK
 XUWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwt1I10lCet/Z3Qjsf9oNDJAG8hMDbuHqHEqiHF/9GpSv+ZF4/RZoUEXuXA8M3JB61F/Y+mcjHaUgQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMmSa0fsfpe5i03uOn38rA4Genum5wiDryCf+e9E1e20kJpOSx
 ZXQXlHYXQ/3/01E3p76TGd4u9iFVdd9fhnvKhNCH7hA72R9w59BevOJF
X-Gm-Gg: AYBFou1tdxkMwcuZwR+HuyG8TLA9FrgIDHCzp/nA+cXHQ38/x7KDg4yiEhzxoAe9kWB
 y+GIjOxm/h20+DKcZ9qi6F/thiX3rOFw+UDZKWR5wj/QBFsMISHaZEAXRTfV1qhkKI/h093Wggm
 0KWTjqRwqvg0Yk8fDDy9M40GNRbupzqfZye16c53wu3k4MwI9lulc9NqWr3qccZAhU8nlFTpUKC
 6QbyWFjYdfrCtc5gGqsZqP/UfYgZ8LXThEWuGwplv1FFM7TkioN4v08QT+NDuhsPVU0sumg7Os0
 6u4cy0wZ7yaZ2DWk2ZXH6I2P9MvWuTlQmTD0TGahpzL7V1gbUHZSXoKpQ0g41AvwDl7m7dxRKBG
 iHOnLFGwxh4vCECm+1Mbcr7HU8cDM6try05rTrRA+N1K/cdQrGMvIEPh+yifXnsuCLhuUEAJjsy
 rP3BNO/V+mC9NnEkB1Hit00aIIsS659hY/BF8m6iU82hO+Jd/XpsY50U3FtLw0AHW8+/h6jm/BJ
 ksoWtbB2zaW17xsU+Vz4s8Cm/AMprMpEpLXrARb7UExKnTWmMK4DAdH2VqyMJ5p+DIa5pXvn42v
 reeoe3vz9P4vR/dbyxwYeyZMuPkIJYhBMOP3//GtCNVF20QK
X-Received: by 2002:a05:600c:4f42:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a18e3ecfc8mr324117205e9.0.1791922397398; 
 Tue, 13 Oct 2026 13:13:17 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be97d1esm608335675e9.8.2026.10.13.13.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 13:13:16 -0700 (PDT)
Message-ID: <736950e0-c890-441e-bfa0-ef5d2b7b7d4a@gmail.com>
Date: Tue, 13 Oct 2026 21:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/13] block: add dma-buf support for raw bdev
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <CGME20261007014324epcas5p2a7f3b03f118c9a1d1c633fe839ed1e46@epcas5p2.samsung.com>
 <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336930.git.asml.silence@gmail.com>
 <bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com>
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

On 10/8/26 13:27, Anuj Gupta/Anuj Gupta wrote:
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

Thanks, I already took it into v10! There is some some confusion
with the branches, but will get incorporated in either case.

-- 
Pavel Begunkov

