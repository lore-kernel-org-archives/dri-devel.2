Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEC8C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3188410ECF1;
	Tue, 22 Sep 2026 13:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="brCYqMvj";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB0F10E489
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:54:42 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9f0b20so629809266b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790085280; x=1790690080; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ufPZGPSZBLf6/pwvKrChnuajCoyQv+QtMvUQGkdovhk=;
 b=brCYqMvj1NQmx7R3EuomJBheG2vgVgxKPhS0DujAZqeLuxj6u0qw0DfwpG1lFmVA6b
 4K/Kp36EeS/JSg5HpHfk2MrD4ZvvHD99PDt2F0eWkL57D/z/85CrZSaIX/1m6diIYXCN
 nR/pZUQ+QmUa6RCE/BOhHDSyVgTh4cMQG+wxBLZVbGWEOFtnBNJM6UYcl2BKyFRht9jR
 U/G4C5PR81iDG52JpIrgRjtj93XsHL4FQIgRQ4gL/6r8xB0hrHS2HNoZjzqDnoUe+bG2
 RELC1MsYWrtI3Yf+c8LSNt+fj3bnrwzHIPB17JqZrhpFNNNPDFwjQVVZ0lwAkK7G/iVW
 df7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790085280; x=1790690080;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ufPZGPSZBLf6/pwvKrChnuajCoyQv+QtMvUQGkdovhk=;
 b=DwIroJrZZB3jXSx7KH6bsjyr7iTwvX6RqzYt6gtdgLEimMQMSiYrQ2lIMKGTlj6qvN
 cVEeUtj+e+IX3U876kLQ5V7hCXDe7ij9XIVvSjbMmXpEoKMA/BUdppfSm5EQqB8zMYVj
 Ao2D6esDlyX8Vu9wX5N/2DzJa6DEBzok8PpqLeqj8xf5sBcFrDThcvNwfQzo7WyOvvu0
 90Wky+P9cpV+ffZ20ojsqxHh2/SPAj0T1+CT0C+3x243obFDEaE0wOMlx5Idm6/MrGEL
 V3XjJt45VYdKA263q6f3h1FU+uOIDmxxoIgYQdgANFDRHT3bW8vyTmKWkxl/kCfFtYTN
 WgYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoD51pMFiWVBBWnfuINsvrc7ZMrwchGwop8o7QHwGKdOoU2lV0oMogsvcTuzP1yrWM9qKJy9aRTzM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqhNXmbfMbbjfe5HYwJKhW3FQhQ8kRho2K4iHpD48kaPlEicMZ
 iFNfbsRFnlapdIq+9YuUVFuopnn+Po14HiWjXGAYfUhaTG7mRM8tsq0B
X-Gm-Gg: AYBFou2ojyD0yXVwP8na6aZQurEnbKvzw5SSXmvRHhWl38kqCU3NnpjdjVH5okAjq99
 vk/8dmqL6Cckxv7DlUFx1/BTl2GV+t+rDXII1MQnhP3+K1veI1xXegO4XP3XAZJoe7i+84xOumr
 xoheJlgNIR1vxHNtpqI8nGbZSX+LizCq8Gtp/Bwvq7/9F8HzG8lGaY94QVcwXPL0j/6qt2tVlQl
 SyPU1sZ8eDlfxEKJmUDb3NtiJaBbAlXQ2910fuQr/xFzopaED9P8xsVQ0lfpKS6OQS4pvWMoZ6Q
 LUqUnTl3CgLJFtWEcE8+VzHWVhO5Zq0FaCMlXrh+GkE+xjpA3GqAptSkk3bCoNCSGbVFR1ksX2p
 F7ATPkxXbQJ8LES9n2Ls+82Ub+xBQ3y0M5J8kFCn9wgTN86oCCOxKasTFpHSfTbahgiInySkBv2
 wvtsA9ItOBAQuwddiVdQSEM1AfDDxSOw9083nkGIKIiV5RcIVz/8nOxa9j3el80ohs3Evr4Drxc
 lidtLdHefLusEUlPpxIOH08UHJ4RyajcMWeCzP+AEWSytTGG6wFSGw+ovw0weUTy4O1YpYWHaS+
 AyA5QALkM/qYwR6RHGkXzTQV9YNg
X-Received: by 2002:a17:906:c111:b0:c29:f5d8:9c6d with SMTP id
 a640c23a62f3a-c2a15802eb7mr1217098966b.28.1790085280498; 
 Tue, 22 Sep 2026 06:54:40 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-197.dab.02.net. [82.132.213.197])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a9c5baa1bsm93202166b.39.2026.09.22.06.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 06:54:39 -0700 (PDT)
Message-ID: <cce62c72-278a-44d1-9cf7-e0beb0b72688@gmail.com>
Date: Tue, 22 Sep 2026 14:54:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/13] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <a3ee719abc440ca139f1a945fdaf43a45f0c6b57.1789997898.git.asml.silence@gmail.com>
 <20260922131610.GA30468@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260922131610.GA30468@lst.de>
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

On 9/22/26 14:16, Christoph Hellwig wrote:
> On Mon, Sep 21, 2026 at 02:38:48PM +0100, Pavel Begunkov wrote:
>> Premapped buffers don't require a generic bio_vec since these have
>> already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf
> 
> s/strore/store/
> 
> Can you please expland on the splitting considerations a bit?  Preferably
> both in a comment for the details, and in the commit log for how we
> arrived at them and why they are fine for now?

I'll add something to the commit log, but not sure which specific
details in comments you mean. Do you want me to expand the comment
above limiting the number of segments? Maybe I should add there that
it's stricter than necessary and might cause more splitting than
necessary? This one:

/*
  * Limit by the number of segments. We don't expose the underlying
  * mapping layout, but with a known minimum segment size, any I/O
  * consisting of N full segments should be able to cover at least
  * this much.
  */

-- 
Pavel Begunkov

