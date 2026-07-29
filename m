Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A47C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D366E10E021;
	Wed, 29 Jul 2026 11:28:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="odZQmLKi";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0773C10E021
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:28:42 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c15f020a223so130718166b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785324520; x=1785929320; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LDeRfN9blSLpZUyGDvy3JYR8gWm0jeyVXT2Ay7oVK6c=;
 b=odZQmLKil7FZTds8DT2yNCK4BYQorMheQc63tAADXXFhV01RGwpYB8CWKu16FHmt7J
 ZcntLaRjDaVLk6o0/qkT3PGyiHrc50m5D0Q1hLiwcS+Mz11ns3JVc7VQLuCZ/nvd044Z
 l5RRk2QfVXtsM89nEPH6T48lyVeJoO/7qSpv2x5UlxH40kHG9LJfuBvjXfLCSDPybAuZ
 4najRIXKqz9+DJGJtHYGU97f30KPnv7ZBFGzdtSn+XvH4dWkj3NXFUo9Phcom2UylO17
 gQKnVt60D237Hb6XWJhJvguqcinrNYflvDEuhDrHKDvMRErOMijSBva4xjDhCLDd5t1+
 5YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785324520; x=1785929320;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LDeRfN9blSLpZUyGDvy3JYR8gWm0jeyVXT2Ay7oVK6c=;
 b=FHHD+qbBgWE/NQ8HoioKJbnArkRHjw4w6sQTe2T0AXdlhuM0wldh/xYDl2q2lNsMpY
 owDdU/5nTr8hJKLWoYFA6zPc2EV31+N0pgsJqKbUZA9xATBAjwiwE0TsCcFWPR36o2VV
 abVDzlAsqrcPVSB5Q/EczTFpRUOCd0N0JHyxBb9WjQEKDhBGonX8y6CdJbKGKdElzQ8K
 HKifZ2PQHr0Unj/ixDGgbzQdFXMS1vgJr8UT+7xlDYuqecbYTHo6J2mzI74AEG6CJ8Be
 aZwbZv+iCgJSzSVy3beuMMUXug0CMCWKcTUVRk4rRsvzLw8LxdVQg45HQoG7XdMt31HJ
 ZNjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU4BcPUC2lstpBEQxrlsFDNUr2VxjguyNi0XotQjJyM+OO6TQ6Ue6X5xSi8DOx66TCpXkawymmGzk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMa1rlddQIZYu2QAFWMiPJxZK/Qac3pxzuefCOSkE9FwTphWJv
 81mHNnb0BLA5DMkqO/NsL6vXdUlLhxzYS+RBFGO/n8DB68lqYhjVdIq/
X-Gm-Gg: AR+sD13TCiugfjyZ56zd5wz8jEinmpBNK2GcRQxozWpToT0Ajzl6SIzwTh9PRAOqAql
 6F0Sh9yOKrOo020v1qKbB78D8TECHEza/NaDTIF+6ESBrAHwZvoQW9tS7D6pPHcpopLrrp4lHxc
 Ipy6o4s2SbsDe+/gNYapK3aSgQ1S4aWJFd8fMe9tx3aQ40pNaL98kT2nyEDACQApxznNaGifwsA
 kZ3Fy84bgSN/AGDYZyQ8gnMAgVNb2aLYHWhQTDHwQUmfZi457egjhsCBTRMF/iOw8TExBtaVZGC
 6Omp53pltw8K1u1wG+vztYIgpuGXfFghzyBqrJoVOGQUfYxEWRsExeGrSOXaHeiBRdflxUDavwd
 hsURJ4XETPLq4hG8e8o9BJ/dcMbq8FgT1LvpXSAH0PvV0qIJi93EBPHlXCGnuYOjhu0ZbAEkK7O
 f/J+fpU+AxuMnA6vL1+XscEbpE5ccvn6qSRWv/dk8XlI7mtFKUh/Q7fRZ5YvZXoD9EnAQXYc280
 QvI0CC5JmLacapiw3xDskEZG4RKPpcd0WGbFFkvGH3GPW5fTuAEiMuK+3PepbBweZkZY45MlReE
 3ePu
X-Received: by 2002:a17:907:842:b0:c16:5b3f:52e0 with SMTP id
 a640c23a62f3a-c1f72147104mr346195966b.38.1785324520387; 
 Wed, 29 Jul 2026 04:28:40 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:640]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83cea5f8sm100629666b.24.2026.07.29.04.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 04:28:39 -0700 (PDT)
Message-ID: <872e7a5e-011e-4415-98dc-96c9066b0614@gmail.com>
Date: Wed, 29 Jul 2026 12:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <20260729065421.GA9468@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065421.GA9468@lst.de>
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

On 7/29/26 07:54, Christoph Hellwig wrote:
> Might help to say this applies to Jens' for-next branch for those trying
> to apply the patches..

Ah yes, and there is a branch as well:
git: https://github.com/isilence/linux.git rw-dmabuf-v4
url: https://github.com/isilence/linux/tree/rw-dmabuf-v4

-- 
Pavel Begunkov

