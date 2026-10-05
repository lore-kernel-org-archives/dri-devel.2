Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DEBCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759E210E5C3;
	Mon,  5 Oct 2026 11:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uvrs/1oE";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4CD10E5C3
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 11:43:19 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b01c41135so1073586f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791200598; x=1791805398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=25uBlo4GDqcGkj4VAPKdolkwb50w3Is4u8TLMjz2GGs=;
 b=Uvrs/1oEOAHSnDE9GkFGm/lMnROS0wgw1YZLJLJk/w83ZwIdnI4CtyjP5WcH3Wy6ya
 5ozMuJWjgcOc1IbuHcYBgLB/NhvY9wON9TOB8/wDiEq0G64rI1qT0FFbn3yym2Uhgi+l
 KN7KiWTzuenl+q5BpC2JjELoJknCrjoNgzfyP+3uZf/5ciZDujFbd01PfJQR/w/0yh2h
 jJjzMHRyGGyp3El70bOY9oYCHZPLdWT13gjqbmk+xRIHttvKMw42q7UAWUULd5WzwVna
 cM5JZdUPzaef7DbRQOh/q97PsQ1YDCioW47wy5hWFlbN23DHZ67dOndX6w/jO/MnGpbo
 HW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791200598; x=1791805398;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=25uBlo4GDqcGkj4VAPKdolkwb50w3Is4u8TLMjz2GGs=;
 b=RETNaoKjGa7C2GajJy0mWUZQi54ganrSV+gED21PM0KbaSu+Ky+rU1Unnk2M+82/1m
 bVgPreqtMK/VlN4WGSLRKZuOwawW98/r6az6oVPAH6UUVH4769GUF68sNxc+Is7MjkTe
 KHLDaXvsshWmEcjYo1OJDLgdT4qsiHsPHJxnPsEy3os7dHAD9kX8cl3loaN2gaOmS5vt
 epOZjHjVgvcy6ArsoE6qCaXUCxEWmLBXIwtF534Er4eLkJ+G3UNV6HxVlVsFZJi+p03o
 PbFT1kSuzUJM+qrd4jOsmBIBf1KD2NL6LeHZr0hukb2ANfiIfTFq467Zm71vlLkfp9ZT
 KfDw==
X-Forwarded-Encrypted: i=1;
 AKwUvByV9LnRVqYOcnAk412skvYxwaeRWxWuE0HP0EyyX00Ze/nTxaaPauq10YAx2f3JSto3RFzvbp9A8ok=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJV02Ns7chdTOJG9Ova64/xLUUC+tLSWoeirKJHx2PEyyEbGFjR
 euH2Ssa7hKDBI8NUfFbfNQlJ7fFAIecNQhpAh9v4ksWm6g7MJfn8Secn
X-Gm-Gg: AYBFou2L+DhgtLWP48DQ9C/2FK97d71B+cjXb4wsptODV0OzVaXLZGOBLclf7LdMqZY
 mDq/Zeyd1Qd18aW6xEy8mxKJb7C66vE4mJT6It5BSFpujVUE7AgzMNidr9TxmLzQNnpeUKnjnCj
 K/EQvLk3aaZ9IC6Q3J4MNcplUwTtAyu8bSaVG+e6Dq5V0UCAcn9NuDWTHaqGZL549b4Wo75vNA2
 0G4AMoxcPH49DuXd1EqZT/DWy9UemvR4yaUTmOvp5NK0WXVSf/FRkG8Qdwawr1rocRwE42Y01xY
 lH1bvvJs5eh4zUCFYAy65yxqMF04USmomCaKCcK9Rw+VwGWGFxZueWOR08dMVN7euOMygxtKd8w
 64E/+leTT1+e0/DVXaZFijQ1ZCzruzae6DwvIVRLfoeZOToG4nfyx2sl06HdQLESSG61BrA0vuo
 tLCkB9Fnf26AW5doMxheaOrMuLv213uUML91vAowxOTmwEzdd/gQZlYmAhgsWGDRHBofbOUg7l9
 ulCSYlLpzMn0ZYcv/QYe8v9I7cYKYdOIZXSgmJK+wZklC5MbBETumz1Eq5zYtygKeq/k70YW0c=
X-Received: by 2002:a05:6000:40de:b0:48b:d2d:2fcc with SMTP id
 ffacd0b85a97d-48b1272d0c6mr17543670f8f.9.1791200597696; 
 Mon, 05 Oct 2026 04:43:17 -0700 (PDT)
Received: from [10.41.30.1] ([161.12.45.16]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622704a5sm6943895f8f.15.2026.10.05.04.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 04:43:17 -0700 (PDT)
Message-ID: <be0012e5-872f-42f3-bace-5066a09cd9e6@gmail.com>
Date: Mon, 5 Oct 2026 12:43:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/13] block: add dma-buf support for raw bdev
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
References: <cover.1790602223.git.asml.silence@gmail.com>
 <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
 <20261005091111.GB10727@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261005091111.GB10727@lst.de>
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

On 10/5/26 10:11, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 02:32:21PM +0100, Pavel Begunkov wrote:
>> Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
>> the call to a new struct block_device_operations operation. Also reject
>> dma-buf backed iterators for buffered IO.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> [pavel: reject dma-buf without O_DIRECT]
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> The Sashiko report about the errno on fallback here looks real,
> and is probably easily fixed by setting a proper errno.

I'm going to move the check into blkdev_buffered_write(),
this should cover both paths. direct_write_fallback() will
see -EOPNOTSUPP and fail appropriately.

-- 
Pavel Begunkov

