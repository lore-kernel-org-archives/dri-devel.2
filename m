Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB9ACA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0710110E9EB;
	Mon,  5 Oct 2026 11:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPrTFkIM";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF9F10E9EB
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 11:45:46 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a022e9cbebso13766415e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791200744; x=1791805544; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CiogbugpChE2nuDY1/c0G9NHgdsv6JGGhiKd4//mw4Q=;
 b=dPrTFkIMwf1lyMmq3mzXEM6FECgLcLdsdm7y6OfRKCJIEs7FRjO/caMuOm/5ZsF0z4
 k0MMEjTtpkOE6zICGRZiQjRJiX0jsBSx8u2pvnupNjVwVCpzLB7N8JeVGsmewTRjstfM
 753sasuiYFeISB+/Xf/zf8jNjTKh9Ss58Tj9I4wbPpaSrUVnlw/tvtP/8ZVvVsri5xUR
 TPC/VIiPI5TT4SkdEb+2K5HKyYjeoUdisVbT98moTIDjgJbNp38OaHUIcxmwgO9JT4Ag
 fAD1kvJADTTsVLAC6NFy1VD6byBiA98SjgUMtygpJOghim+N9zzsIRxHd+hw0tP4Ti7l
 R6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791200744; x=1791805544;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CiogbugpChE2nuDY1/c0G9NHgdsv6JGGhiKd4//mw4Q=;
 b=0rjxUpwfhVrKwGB8xHTd1+2gypSaAmNQi98/NHOLaGuwpK0dnX4p3c7SQpRmGTggqu
 pHu+nErHLMDIjV4Mn2pvrS7E7dWFsq/sWwojpF/e9328KY9RCsvVEf9unFRD465xzw6j
 17TTHuqGreA2DrRzpmwLAerXCYqk+944th6HUaY9MI9PvDUzUQcR0c6OyMAgD5bHSBMQ
 rFiorY8pGjG9T6VD7ngtxSsr0CKn1604XamunWj/qBwtSn3IRr/SSqx/daQw/q6dVdRV
 F2fzLMEfibIjgZRhe/hBIU2lHzXv9nQlFyoVnc4CXjN5ErxS4UlJ7rvRBMpS0dsVmDwo
 zrWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy88h2w/JZ0N91/eEflyPpk55zT/w/gwU9dbvY7R1Qoc79MV0sTfX2QFwoRxWuI409IUy9DBfsLCbQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kEaiQ218etV09QvBvdM0WJtSaMTd1GAHtcoKz5MhJq/sR1smBK
 Utgce1BOYTikGk5gFFaT3zHQMfhdLt7nZQlMUBjb5ym955ImlE/9hYNa
X-Gm-Gg: AYBFou0Xz3/YYQyTjhUaTKclubL01nxZlXp4z1honSQgS6e0PRO9ukk9aMDq8ixZxJE
 b+jicDSVZjh9yk+Gm9+Gy7WmcAgdwK7TH6m/NLcnT3/y6cgiMcxMU0Wk+qg4iAhLluYAJWkEtYC
 JpYjmQw20Nmqmgh6YypN+L202nY/fjAKF77pkm2i1h7S/lT+0UYG7zTfl82ZYortx/4Ez26xA0f
 IXco8d+/hiAEbSBtADUDgtSZfxLFnaH0V2rGsl/8taz7xGtPt8p9vjMw1Lh9EV3gafWO2QGGcD9
 mDnQBfgYRwMeT6nGWvXCKtVsvMedRWU4kp9ItgZ5ZoKn2v3oIOoo2r6qG89Ef2ekTuv1XiOXB6u
 Y+NO45Vo/Lbds/p5YOvOvTcmwix4I0Lf1iI652tTdbl1iy5bNbfEdqUBdsHjmJxkKXEm74qVYTi
 tBO7GZtsRfv+2HnDQq+kEyypDNWyB4AlvfWp27scAm49e31RNMRcJFkeQQSsfa3K2WIvRtwIuGC
 o/sFA61WC1Ya0/A8Xl0ciA6z+I1S85v/RULBrnmOSMorOlvRUBa5xMmMKb5abhOBHJk1rhuNtI=
X-Received: by 2002:a05:600c:c165:b0:4a0:108:3b54 with SMTP id
 5b1f17b1804b1-4a02758e674mr183842705e9.32.1791200744219; 
 Mon, 05 Oct 2026 04:45:44 -0700 (PDT)
Received: from [10.41.30.1] ([161.12.45.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027735be1sm472096485e9.11.2026.10.05.04.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 04:45:43 -0700 (PDT)
Message-ID: <cc7fb229-7e6f-4ccf-bea4-864ddbd36a02@gmail.com>
Date: Mon, 5 Oct 2026 12:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
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
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
 <20261005091554.GD10727@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261005091554.GD10727@lst.de>
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

On 10/5/26 10:15, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 02:32:22PM +0100, Pavel Begunkov wrote:
>> +static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
>> +		struct request *req)
>> +{
>> +	struct device *dev = nvme_dev->dev;
>> +	enum dma_data_direction dma_dir;
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +
>> +	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +	dma_sync_sgtable_for_cpu(dev, map->sgt, dma_dir);
> 
> This can use rq_dma_dir in the argument.  Same for the other DMA API
> calls.

Will change

> Btw, given how larger the dmabuf code is now, have you considered
> splitting it into a new nvme-pci-dmabuf.c file?

Let me see

-- 
Pavel Begunkov

