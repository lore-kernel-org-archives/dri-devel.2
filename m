Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4308FC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA0310E169;
	Wed, 14 Oct 2026 16:43:34 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AE110E169
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:43:28 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49e73611928so39972645e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791996207; x=1792601007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MprqRVTku8rnnoqrNidogE79Hh/sbjcVtJHMk6QO0CA=;
 b=r//jeGLwHoq/ApAN7cmvr/mw6keZzztd1pvyc6eeVjU81ATrgk08cK/v9kb6N4LnxV
 m0MiPcTZ8rILdoSNfT2kiONSRTN2/vrfN/piqWWA1Z+frkvu/P05+ILEEIYrqMwDwlfA
 Xm2UuXagrtR1Jj+dZ7jyArkIboK5Y98Z4FI/qGAxEBH1UCOenNjPOJcH6N/0vC3u44ve
 jj3ishF9d49q2ifYr4k4rc+Hz5Z3+nmV++MDrN2zDTb/iMmFVj3qNvonuriFDrDi/KOD
 DC9I1gS6oaBRqncq22+Sh/dM4EjAOmFxOMDB7Vbnkh/YLOTZVfThYffMbkcFqf8Is6EQ
 P/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996207; x=1792601007;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MprqRVTku8rnnoqrNidogE79Hh/sbjcVtJHMk6QO0CA=;
 b=XXI4U4b5ks3zAlRxXy+6AIBovPLs9JaxHhymsrm4ZR+mAs79OaqIlj+pWj7OA7SEVP
 DUv1SYWwxwvTxnl/mYdtTPZ3u16zaFEXGMx9TBFlPa3qBgvk4zOsfiz2qg8FYgrUvHp8
 PX14VfKnsZaJuLQj737YPN6iw0PTtFFclr5Yl5JxatPmBkES+c6hBzKqXxutjzPn8vRj
 rlxK16T1Ofat7lGqZgIS2fIF5NGc+Nk04gmM6vDtJcmckwcwRP97zqrAekRJz8z+61TZ
 UxrikuhNrVf/EuRkXHoOgXo3pgib5N15+r4V94TLd0PgwLLaIYSjqVJLAZQ+BosZ2fil
 3zZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFLQQWz7YIabJ2ISQUBnRkKErDa0JNEOS5ADh7FGtiKEdfFjPLPIPUdV6gQRFBfEGHezuqK895HHs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKZhn/nmUJXM4eBJ75J9qe4IaCvgOFj35/txUB2InWhp1PAQk7A
 9eEV5cH7aFM85p3opPxWrIDmvoBcW+qKMtmR5PR7PBwR1aUAO4tFIbN3
X-Gm-Gg: AYBFou0qvBM/W82KDZgbWK/GoGBTEhSE6slRLvGPFDTcoiiVfgAdmIz62b2jrK6nK+0
 KyXolLu+wfe1qrKhL5CY+8C9WDHruyuRLajdSK9QTnGf6rm1yU6OgH93nUswcDselqDkTpWVcpW
 b1O9JE3HQjckkByD8/ONcJCd875OeWm2z6+XdKd7eCbMIqR2BMvRZEzU5xuP/4eTzBkoN25Vxne
 BqUo9CVOuu4BZqa2qPlCLjsygKHmZ5/ywjXuSAqDZsZDN/zpeamljiZUZeOuIrBH1aHXZrc09Ah
 Xjv50hzhuGSGMDewA7QykHER1eLcuoZ5/LHPx4g4I2QnkluN7j0zXyDu/GNYOHAt8uEfE09OJ3e
 +et7T1NGRbw1bF1ZY8TL2nmeyoTOStHUZDLAF65L4fZoyu8Qz5yV1g4aMg7XagfjHQOOwp7EwLP
 sALGZ/bKuHpODW43nnOzGLcsF/EW9k+hoC4PtDAoH6D1yShpYFwOiAHg6NkAzGVnNsr4TtJ/po7
 miP/QvdruBqW10f3rv9bybVmuyRxESPemZ295Y+s4JgFsvaA8YzvgaBUuU2dit0Hnk1Mka//0Ox
 Bf3l/4ZzqrNM2n6VFzwKIceuoPpEmYS8Ft3AcpTNnJ+OIlb0
X-Received: by 2002:a05:600c:83cf:b0:4a1:ac66:604b with SMTP id
 5b1f17b1804b1-4a1ac666a65mr120408565e9.1.1791996206748; 
 Wed, 14 Oct 2026 09:43:26 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd640be0sm4751135e9.1.2026.10.14.09.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 09:43:24 -0700 (PDT)
Message-ID: <7d3c3cc3-5c7b-4d28-82d8-2cdb5e010c29@gmail.com>
Date: Wed, 14 Oct 2026 17:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/13] block: introduce dma map backed bio type
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
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791975048.git.asml.silence@gmail.com>
 <39b964cf7510f42755188563da63d3d5acaf2aa9.1791975048.git.asml.silence@gmail.com>
 <20261014131554.GA16467@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261014131554.GA16467@lst.de>
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

On 10/14/26 14:15, Christoph Hellwig wrote:
> On Wed, Oct 14, 2026 at 12:02:02PM +0100, Pavel Begunkov wrote:
...>>   	case REQ_OP_DISCARD:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e929f94b25c7..1b7f8cbbda8b 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -3150,6 +3150,12 @@ void blk_mq_submit_bio(struct bio *bio)
>>   		goto queue_exit;
>>   	}
>>   
>> +	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
>> +		bdev_has_integrity_csum(bio->bi_bdev))) {
>> +		bio_endio_status(bio, BLK_STS_NOTSUPP);
> 
> Wrong indentation, conditions are never indented the same level as
> the following code block, even with the weirdest preferences.
> 
> /me note the patch from Anuj on the list actually got this right..

I had to split Anuj's patch in two, should've butchered it
while hand applying. I'll follow up on that unless Jens
already applied the change.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

-- 
Pavel Begunkov

