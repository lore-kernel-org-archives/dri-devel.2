Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0D2CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610B710E5CC;
	Wed, 30 Sep 2026 12:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pXBuxTRT";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC25110E5CC
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:49:15 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso33248465e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790772554; x=1791377354; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/dhWIKwIs8lapn2MMhEevzHPS2BYYvsR1AqGmdi+y+4=;
 b=pXBuxTRTK5fVaWIZMvXL4vf7BtdBZ8NaEue4Zpz6Ys7xthONsMdiwhQBWXxTJoVyOL
 kVoYH/ToA7/abr4bS1vHK7lynKUcEes+shNyqvnmpDZcxk8GvXjT4hAx9PGNMYQYfz/0
 yyVFqHr+7h5KHAK4cyOQ1gi+mYu6dRERMXsNUuyM+Ox67wnrJTL/D1qHW5cLfzy/1KXP
 ySG/TM4E+vyfu16nfq5V033id/LTdYCCwlEFivWtcIiszwpL+LgwMvAql8QGZ8ie+E2d
 tfgkJZ/q/7lOutlwH+DOb1OsvrPCJuz06CRfswOoH5iSP2oWqMbkRAs2ok1lbazk0CMO
 9zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790772554; x=1791377354;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/dhWIKwIs8lapn2MMhEevzHPS2BYYvsR1AqGmdi+y+4=;
 b=Stf074+IWRNu2D4KHjau2/JllHApW0/DaQreGs6xxz6A2IQPKgxw+hLXFsSZeDsLTG
 Hu7h6SYnPTCWvQ5wjTpbTUXkFxPtiBYm/KNzAF1wNsu+Y04waIDY/WXZ4Ih1+0KfAPF4
 Jx+nmbN614gPDIb+wcIucFCfGYwz3F3AUYnQiQi5/HhYy8nb+DiDkNpOIRLJUXeDNd59
 MuRh9p2q8EiIbQVo1ONuO6MDGtjBdlmWnzuG5dXYCPF/Td5AtLtuv7Kcvqhlw88EZarC
 Czjbdi236kBK+vgEsIA0AzfdPxwWpSQVviH5AFoO8p29vWEQpm/ejBiBA/S+NadrubjB
 2eqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5EgZqrK+U60vIn1+KlI4jGIyFy88aNIr3IunDVnSk2Yxxw6XB2PXz4f5mOe3nHsYhnjptuD2ZWgc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mrjgszhwR44dfU8m1reRvPvRg3UkkHIDfHH5Qq/RP3JCUGAKll
 b2JSttbek2AYKbuV/BIz0+JZ7OkM8q9YTfuRq/oFFN7VZiyI7PI68bfq
X-Gm-Gg: AYBFou3LwPXxlp3R7FjoSOSAL+4OnVEULUxO1KrB5YpTRge7UdGAmkJtZXKYZNYxI31
 IIOwHS2RuVipzh3XNGK35v3I5CqdePOmIIAYvqXlssYSlG80HaDGucLrksaImKlPrCdnxh2lLPa
 +mGSloCyqVW6cw+hUMCpFHIibJLxPXJecJVECnU4rsrx/GtVvfCj5McEPD3kmP/YzDISqm+1Rzq
 p11+jT5v4Uwg9xa7hiW/oG5yKobjwgoGJXQ+FoLOGoE+35zVdXmL6pSy9GJYhnZIuV/ND9mm9IS
 aq7JK+NrwcW9FImCmN8uuDp4R4I3+1gbwRlyB/8U2slcOwsEoIxk2K6mbswnp2p1r4M4jxeMTn3
 M90VZydWaZ3feNM/gYmv4m6FHY0qIRxI4gsG2Ob07CWtLqR+4HlRdbwrDyP7PPyS1c1kmfyqRep
 P+w2CTgTMQlbY5FoaUOnEugwLbJvMFuxYIodQFyruGNYblciH18usdF/mOZm3AXBjFtG7QTbfU8
 3C/dl8ElCy55IRTMzFv4IA4phWEI+0nZeLIrL1+1amr4x+JrMOA3GNAOc+hH1MWepQc92UiJPYT
 T4LIy3p6cHK/Ef8hyvYEC8NZVa8mQnwTJr4q
X-Received: by 2002:a05:600d:864b:10b0:4a0:2dd:7573 with SMTP id
 5b1f17b1804b1-4a01b12b666mr16604625e9.33.1790772554145; 
 Wed, 30 Sep 2026 05:49:14 -0700 (PDT)
Received: from [10.54.182.141] (82-132-212-25.dab.02.net. [82.132.212.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cb8abc1sm3766935e9.0.2026.09.30.05.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 05:48:57 -0700 (PDT)
Message-ID: <c07404e0-33f6-4e5f-a80a-e1901b42dc39@gmail.com>
Date: Wed, 30 Sep 2026 13:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
 infrastructure
From: Pavel Begunkov <asml.silence@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
 <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
 <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
Content-Language: en-US
In-Reply-To: <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/30/26 11:08, Pavel Begunkov wrote:
> On 9/30/26 04:00, Matthew Brost wrote:
>> On Mon, Sep 21, 2026 at 02:38:45PM +0100, Pavel Begunkov wrote:
> ...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>>> +{
>>> +    struct dma_buf *dmabuf = ctx->dmabuf;
>>> +    struct dma_buf_io_map *map;
>>> +    long ret;
>>> +
>>> +    guard(mutex)(&ctx->map_create_mutex);
>>> +
>>> +    scoped_guard(mutex, &ctx->map_mutex) {
>>> +        if (ctx->maps_killed)
>>> +            return ERR_PTR(-ENOENT);
>>> +        /* recheck under the lock in case it has already been re-created */
>>> +        map = __dma_buf_io_get_map(ctx);
>>> +        if (map)
>>> +            return map;
>>> +    }
>>> +
>>> +    dma_buf_io_wait_active_maps(ctx);
>>> +
>>> +    ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
>>> +    if (ret)
>>> +        return ERR_PTR(ret);
>>> +
>>> +    ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>>> +                    true, MAX_SCHEDULE_TIMEOUT);
>>> +    if (ret <= 0) {
>>> +        if (!ret)
>>> +            ret = -EAGAIN;
>>> +        dma_resv_unlock(dmabuf->resv);
>>> +        return ERR_PTR(ret);
>>> +    }
>>> +
>>> +    map = ctx->dev_ops->map(ctx);
>>
>> I'm playing around this code now.
>>
>> I think you need the dma_resv_wait_timeout after the 'map'?
>>
>> If a device doesn't support p2p ->map() will typically trigger an async
>> migrate to system memory and data will be moving but the map is valid -
>> Xe 100% does this, I checked AMDGPU and fairly confident it has the same
>> async behavior.
> 
> There is a wait right before because I read somewhere in dma-buf
> comments that I need to do that, sounds a bit odd if I need to
> wait on fences before and after. I can add it, just curious how
> come that other dma_buf_map_attachment() callers don't need to do
> that. Or maybe they wait somewhere else?

I can't find it, so maybe it was the comment below and I mixed
sth up back then. I'll move it after ->map().


* Note that for non-dynamic exporters the driver must guarantee that
* that the memory is available for use and cleared of any old data by
* the time this function returns.  Drivers which pipeline their buffer
* moves internally must wait for all moves and clears to complete.
* Dynamic exporters do not need to follow this rule: For non-dynamic
* importers the buffer is already pinned through @pin, which has the
* same requirements. Dynamic importers otoh are required to obey the
* dma_resv fences.
*

-- 
Pavel Begunkov

