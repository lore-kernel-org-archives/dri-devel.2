Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6420CCA5FBE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE2C10E25A;
	Wed, 30 Sep 2026 10:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zz/TQ3Oj";
	dkim-atps=neutral
Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com
 [74.125.228.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B9410E25A
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:09:48 +0000 (UTC)
Received: by mail-ed2-f31.google.com with SMTP id
 4fb4d7f45d1cf-6ae19959791so385893a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790762987; x=1791367787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ruocdeJmKgpaQFus+PucSGDLt7ZSCHmy/3XR1sTVzPs=;
 b=Zz/TQ3OjgXuG2Polq/3bf55rGDqMt2e8wZNTWJUdsp/YW4ikAr3zKwLXrTvT7YHgky
 HxOWlfUhE9+A7xDdklvn6NdKg+bOBBbcpMgfscX9AlhwQld3zNgI1QCIQKi1L8BVcf79
 tpkVz4W8MfKogXPuhP9KjutTWCQ7u/GaXXcusWvEBBsxqxZqhf9TyOk2GWVVs4cXz08B
 DP+09cdKjvd/emCCu8Ju6hW7FuNAsi8E95L3AJdLRjRSTiinzNuqWWUVhycE52VHetjK
 1cgARfP9R+74PDcdLZhlDN2+OyMIPJyATwHuCjlqV+2AUit1ChtZIGiFziPnVeyyxdQZ
 Tjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790762987; x=1791367787;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ruocdeJmKgpaQFus+PucSGDLt7ZSCHmy/3XR1sTVzPs=;
 b=kPyPWzysnt6gImGsul51x/w36sOG3bbdHgm7/uKPcMN/2j1vXDufdTUTNtqHjHqjUi
 1mnUUZ4blZZyTWT5wxXyejDat198jCIxp2CRwjWGP6gd4gLbp5eg6beWJlgTJlveNieo
 QwaDflTjc1EHMFg+ZEAo+Go7R2pSoZZlqWuV0hPmFArMXl8+s8zE7xRnWiFmPlHZhjCQ
 tajSSFuORMAP2dhur8RubRvh0f8nCmI+SA9JZecA1QF9qNdV4e1jUQb83U4DAMnZ4ahm
 GMVYyzn/7hXOVQ/RWRCax/1SJyY72/Y6JF7pwvniZf2qI1zaTHVSbdWN+uY7YbGRk4Zs
 XpCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfmlpSe8WOBVdQOVlBjUiNuFR9FAxavt8nTeoue1v9/Wnw0qZ5mq3UqTQGcIy/nmOw4MN36wfIxfk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIz2W+4hxfS3EL0WmZOBI7d8jbKejy9nFN4gadiZaHgmNOVJtpx
 VTqO8eu2DhFZ3MEUtqaolLkQnk3s791QNBcGrExNq/6KwdeqiurgcLev
X-Gm-Gg: AYBFou0kMLBkhNhD3J5ArxKV/xKYxDrt/4w5BrzCdK9SCF4LukXCXW1K3c0Z26bMah4
 BpqarrDcDIVOQ61/0o9ttxBY8aNIKw+5kdMq6VvImymyisj4EKnf1cYD2H1RrPWHhUahWK5pGVC
 2XdEoxrYxtKbqngf6zTWbYFBJ56mAPtMxsiPwHftGIUhDLP8DD7WYonhn8WzHKX+sC07sycVCvG
 iE/5vxCAdA01WbeLfA0/WsagQ3DrmLTdQL6V1GiYa55XYif43YzgN3pBtq0KDaPMMYQVPHfuVeN
 GkLvhva54g/RpBpYRLWJ9fNb9WDEEuzE4nLtS1fCCNaNH7BHWOAnnYj2SYckZq2OIVSxiczC00q
 l+BVatokw+8cnmwu3mT3cMRzVkYsvWPtqoN/KI2+79GBuKEebwo65KkUzVDZicWoJ700p6s+wE7
 3X8mmxmdH/jzUqLZ0Dyke2EZOhnn8txKEk4fR0IL3KEm/PSSBMDd7qwJrBYREe7zi86Li6joCDu
 mKT5DQcXPKc870jSMUPf1rzrmuYA/h6PK8nKWBYsFcPm7wqck5vGU1G9dYcCWh+bCuBdIlOEqfr
 bP5kMthS7fB6/beQGxumk79JG52PsmM1J/ZHZofMF7Uhx5ow
X-Received: by 2002:a05:6402:27d0:b0:6aa:ec02:7de1 with SMTP id
 4fb4d7f45d1cf-6ae199152a4mr634773a12.24.1790762987076; 
 Wed, 30 Sep 2026 03:09:47 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ae15690dbbsm551642a12.22.2026.09.30.03.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 03:09:46 -0700 (PDT)
Message-ID: <77db5aa5-f160-48fb-ab59-a754b100bc34@gmail.com>
Date: Wed, 30 Sep 2026 11:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: agk@redhat.com, akpm@linux-foundation.org, anuj20.g@samsung.com,
 axboe@kernel.dk, bmarzins@redhat.com, brauner@kernel.org,
 christian.koenig@amd.com, dm-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, hch@lst.de, io-uring@vger.kernel.org,
 jack@suse.cz, joshi.k@samsung.com, kbusch@kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
 matthew.brost@intel.com, mpatocka@redhat.com, nj.shetty@samsung.com,
 phil.cayton@intel.com, sagi@grimberg.me, snitzer@kernel.org,
 sumit.semwal@linaro.org, tushar.gohad@intel.com, viro@zeniv.linux.org.uk,
 william.power@intel.com
References: <cover.1790602223.git.asml.silence@gmail.com>
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
 <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
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

On 9/29/26 16:45, Christophe JAILLET wrote:
...>> +    for_each_sgtable_dma_sg(sgt, sg, tmp) {
>> +        dma_addr_t dma_addr = sg_dma_address(sg);
>> +        unsigned long sg_len = sg_dma_len(sg);
>> +
>> +        if ((sg_len % NVME_CTRL_PAGE_SIZE) ||
>> +            (dma_addr % NVME_CTRL_PAGE_SIZE)) {
>> +            ret = -EINVAL;
>> +            goto err;
>> +        }
>> +        while (sg_len) {
>> +            map->dma_list[i++] = dma_addr;
>> +            dma_addr += NVME_CTRL_PAGE_SIZE;
>> +            sg_len -= NVME_CTRL_PAGE_SIZE;
>> +        }
>> +    }
>> +
>> +    ret = dma_buf_io_init_map(ctx, &map->base, sgt);
>> +    if (ret)
>> +        goto err;
>> +    map->nr_entries = nr_entries;
>> +    map->sgt = sgt;
>> +    return &map->base;
>> +err:
>> +    if (sgt)
>> +        dma_buf_unmap_attachment(attach, sgt, ctx->dir);
>> +    kfree(map);
> 
> kvfree()?

Sashiko also flagged this one. I'm going to apply the nits from
both emails, thanks.

-- 
Pavel Begunkov

