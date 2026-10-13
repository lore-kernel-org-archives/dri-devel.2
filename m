Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E64CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361BC10E11E;
	Tue, 13 Oct 2026 20:02:56 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD7B610E11E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:02:49 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so20387455e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791921768; x=1792526568; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ht3KL+dVHT63kyImKLUa9SErnOvImt82gs/Vf44c6SY=;
 b=YHpEMeVK1fy4Vw5DSQLzWXTbmR+d5Lmev9PbN1+BmENDneNbgiKQJ2b4MTBxgFSdXH
 73mq26CtR0iQxAa54GGB83aIF0mp/BrbA/cH6P7ZoCx6R8p6N1E0QMudUh7eunaLO3y5
 F75JduMQc9Z2H4qlEK47YjN4TTzRUTS5cZosk8w+KFOzdkK2GcH88hL31kmHcUDvUO6q
 6COsATu3vI4tDUno+LQno7nGga9caDC03D8LL+daOUcy6Ytvt5Zvg2Ft9yFSrc+yhD7/
 DeN8MPSBurSX1BFpxNCci+s+2Rlaz4jKiPhMssP3Whl+YgIlEiKGTRHoxgb2CZhkYzgL
 EKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791921768; x=1792526568;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ht3KL+dVHT63kyImKLUa9SErnOvImt82gs/Vf44c6SY=;
 b=NE92UknJBAgC4+BwO/dBQxxPAgAfBtgTy0LPsWEtIsksRbqLbyDp8VLS4i7rZoRnn0
 NdcXpkCI0v0RhG05nHfJyHeoQdvq3DN3QVogc57zQBIEP33aG5IbMjAWHo0Px/HxpWwn
 w0taJibpLCAeAOn8FVacgoW60XaNHDukvQw/oqYWV+WcTnVVuvztCwsv5jtqOmWTNo95
 o0Qks9vudrwoM73sWqRqfNAJ16d369HjorL/oM+AuT+dCQG9ycrNqwwiulc+FwA9V7Iy
 4xEx47k4farAqxsKTpcyyoJRYwSbT7qhytue4P/7wiG5lRJ0GyD0ooFPXydT2bjc6FhU
 6iBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByjGN5Y5LMAZQP1QcLRS+82496EzXT+Eb2Q8oXS72ELimRD/0uCKf/wetmn9FteXMFxzRSygUO/vrk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJOvN3/izX6zUGcLwsCtqNt9KCis2KQWRIiYol6b9T54Zraw/OU
 XOzq78/YbR8w/+HEGJt0C7khQqkG+jrgyHcaMwxKNU+HjhRCg8vYXOy4
X-Gm-Gg: AYBFou1zrFFYyd3xTcXzgchHTa+btd3C//6UMnD/wW78+mDBKb6fsw7XxdNLz9dMGmM
 E1QCBVKC2/CVdQb25MAdPkRpLjDiFFE8fw02+bB6QiE/PU8aQWYfRPg66tqefdysBoAmX8ZZVHr
 rHXqHt4q025VaUfoCkogMyEIquGJUa+EmlKZdbovyymiOCDXl0M/4IBd1FgG3Nzp61P6eIKwPhW
 fwh7QrZeZRaJUIUEuSJgFfmxqzWreAppjcxvAP/lTBja1Mo4JFQScpO4GbHF75OewtfcVeTj1xk
 hEIoLJ5MxQeY7nNPNR0FLTECuOzaxtQPABM5C5aC22yVMctWjPhJXPXy71B2mcA/tgAabuxQ8kP
 Vn/bZqqbfQ3WaXxEQ8pbNxi8q6FAN/cegfchNG6VYv4fx7GVyH7kUpPJj2zCoqgr6i8Juo7XqCt
 +sfPlog1iD1LfQYv9iNM7fj/qJ7m/47tHu6zd81xtx3EofbNUEfv/Ykv6Bg4x8Non8ZBReUNg4c
 8bNUaC6MTOzAmxEI3FTjc59PcxRSGpETJnZmUKQ0O/bln7MKqfpMZZb/6JkkmFdMrkNQPMxqMcX
 3QVcKV/Xkwfn7Sx3PRYq3GbC32A/QIaPPsUHb7SV/qDTJwiVQI37lW/itvs=
X-Received: by 2002:a05:600c:46cc:b0:4a0:8b1:f5c with SMTP id
 5b1f17b1804b1-4a18e4b583fmr268480065e9.22.1791921767928; 
 Tue, 13 Oct 2026 13:02:47 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bead84esm384426465e9.13.2026.10.13.13.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 13:02:47 -0700 (PDT)
Message-ID: <63fa3e64-44a8-4539-960c-946cebc8fce5@gmail.com>
Date: Tue, 13 Oct 2026 21:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/13] dma-buf: introduce initial file I/O
 infrastructure
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
 William Power <william.power@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <b44df9fed6e346110c504ee312bb0083c7e75574.1791336930.git.asml.silence@gmail.com>
 <aszbv7TgDOPHBEem@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aszbv7TgDOPHBEem@gsse-cloud1.jf.intel.com>
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

On 10/12/26 14:08, Matthew Brost wrote:
> On Wed, Oct 07, 2026 at 02:42:44AM +0100, Pavel Begunkov wrote:
>> The goal is to be able to natively use dma-buf in the read-write / IO
>> path. This patch adds basic building blocks serving as a glue and API
>> between drivers and upper layer subsystems providing the uAPI. Later
>> patches implement it for NVMe raw block devices and expose it to the
>> user space via io_uring.
>>
>> There are two main objects. struct dma_buf_io_ctx and struct
>> dma_buf_io_map. The ctx is used during initial registration and serves
>> as an interface between the upper layer user like io_uring and to the
>> importer subsystem / driver. The map represents the actual dma map
>> established for the target device[s] with dma_buf_map_attachment() and
>> stored in a device specific format. The context is created via a new
>> file operation ->init_dma_buf_io_ctx.
>>
>> The ctx-map separation exists to facilitate map invalidation (see
>> dma_buf_io_invalidate_mappings()). A ctx can create
>> multiple maps during its lifetime, but there can only be no more than
>> one (active) map attached to it. Invalidation drops the active map
>> if present, and any new I/O request will try to create a new one.
>>
>> The primary task of dma_buf_io_map is to count requests using it
>> and wait for their completion when we want to destroy the DMA map.
>>
>> [un]mapping and any work with dma addresses is delegated to the
>> importer driver via an ops table stored in the ctx, see struct
>> dma_buf_io_ops. Only the target driver / subsystem knows about devices
>> it wants to use the dma-buf with, especially in case of multi-device
>> filesystems or stacking in the future.
>>
> 
> Full disclosure Pavel incorporated some of my ideas wrt to locking
> cleanup which I shared off the list.
> 
> So I can't in fairness give an RB but:
> Acked-by: Matthew Brost <matthew.brost@intel.com>
> 
> For the series - I can give this and I have pulled to code + have Xe
> nvme + IGT setup showing this working:
> 
> Tested-by: Matthew Brost <matthew.brost@intel.com>

Thanks for the suggestions and testing!

-- 
Pavel Begunkov

