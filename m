Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF502CD3423
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FC910F41C;
	Thu, 30 Apr 2026 18:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="icJiVdCr";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C678910F3DB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:33:56 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so824138f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777574035; x=1778178835; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NXLg+nrr3M9M+FT0+QCr6ZD6pc/R7QelMFoBuHbRWoU=;
 b=icJiVdCrVQJSHrSMlUpLOdSjihE7hvLSJfh78XSZKpTJxbd+EESAHd+ZCqzRJcM8ZR
 88Cv+kjnO6uLvVoyW8fiK56WV07PyXyhaHn9Os5wdEgbcK8NdZBtSVFDrzO+YswKGs0h
 k0A78SrYkKyi3x6qBDkCJM5kA/CG9dRe5hfRAk6onKFrTJ/uTq8C7O3wZMJyNgqDomOv
 ETabyKWmk3l4rIYnJmD3YqcczkSKNOqCBBL5UZMFmA7fVS1trSg8b7kfmN5ivQZIwBKO
 31tU33045tCinT29NcjRZTjHoRhaoH71ThhZn64HlAZ+wRzYShOTPYozC6bxM3Uuvltf
 YjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777574035; x=1778178835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXLg+nrr3M9M+FT0+QCr6ZD6pc/R7QelMFoBuHbRWoU=;
 b=h5qetqse0VDDoT29vk2/rP8ZYSm7lleo5qCtUCAgrTampRXzIKH0h51xMqWN0L0kDz
 wYo7vKOwtzn7KcBT7bxlrWjY2LMa3YK21DwMEe6LjAKz8VYnQpR47ydYsIsrMIgnpvCG
 egthuODPtDE1kRVoQ3VJvbJd9p9z2b40LpfvnRpuuYWp8sY+fxyFxjf1o7hrcdqPCv4o
 U3B2tnjP/CX89BtmZvCsArmGPXZgajRzMIAFKMiKAKHuiqcljg+MY0KDi9k1+5EvhceL
 C7loZaLI7ZOZf9ZWIFAbv0x9q6t9UZj9ZaaLY7Gtd18ExaHda4rXG/5EiEAQ10qfq5sj
 zd2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HHVob03lKtRklzCLxKp6g7cOsNOZAErIW2+f9YaWBX0zrvEo4PYvllbJlhIcsbvt2L03gYdlPmz4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8lXEHsMOkdp1U1sjb67BsYMVmTQBlLNK0epRtbK5lrxS7W+o4
 TC7DQb4jmHS4qyiWjKzzPLAJueKGkPOPtPRvHmTgElPSkneYIZLf/TeR
X-Gm-Gg: AeBDiev3BhhpzDJJqgFiu59Mnr24wjqhLWwTbYjHUSzLCaxmnHQz8OPY+PF1StyqXMY
 yHs4t01K+ZNQw4gOfxJP07HoWVYCIirYHQP5nYrOJZTvq5CQq6uK7djVbUq6yeFEo7ZBzG/Iz+a
 cYACQNMBneYIaKVpED132Ex8KVM47BIYWJZJX21FsfzTVL0w47l930xJDXOLmp1d/eEj+F/oOl8
 UkASfj2GpVHUQ81Se79W3xu0eXnLQj4MYRTFyioXO5r9woS2gCeiJhUtBXt5SB193gKnDEzrWf+
 LpfdJI8IqwllnI2iuvqETdsmevRri6iMCu2uIVJIjSm3+Q8rFcKtKIm+Xt+LMu+F9OUMxTCMN7p
 7kK0BN7lIPYD8jnFhKGRqlLQFJLD0ahbJ0wBgTI7YdWb2NPcWlfzay9OmnveiUL462ZOdhF1tmN
 u6ScStnVHOv1XEnC+E7VrfxzT9CEHge/kVRz2ZjZ0caCjnN4kwnNp1FYmx0jj4KVhb/lBeput7V
 Pd1DYyHwTOJA1t96fhdxwttsaEFz0sP2htJ9NIidh67ognuxYXh3wQ76Bka/pdVl49jsidkRkW2
 ng==
X-Received: by 2002:a05:6000:1a8a:b0:43d:77a8:3baf with SMTP id
 ffacd0b85a97d-4493fa01beamr7079438f8f.32.1777574035154; 
 Thu, 30 Apr 2026 11:33:55 -0700 (PDT)
Received: from [10.109.92.8] (net-2-37-141-89.cust.vodafonedsl.it.
 [2.37.141.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b4216eecsm13579672f8f.9.2026.04.30.11.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 11:33:54 -0700 (PDT)
Message-ID: <6cce2f4d-7400-4618-82ce-cbd5004c92a4@gmail.com>
Date: Thu, 30 Apr 2026 19:33:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] file: add callback for creating long-term dmabuf
 maps
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <ae941457cf6cacb9d4c16b6ec904da9ef7fed97f.1777475843.git.asml.silence@gmail.com>
 <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com>
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

On 4/30/26 07:03, Christian König wrote:
> On 4/29/26 17:25, Pavel Begunkov wrote:
>> Introduce a new file callback that allows creating long-term dma
>> mapping. All necessary information together with a dmabuf will be passed
>> in the second argument of type struct io_dmabuf_token, which will be
>> defined in following patches.
> 
> Well first of all the naming is probably not the best. Maybe rather call that dma-buf attachment or context or mappping.

"Mapping" or "attachment" would be confusing as maps are created lazily
together with struct io_dmabuf_map. I can name it create_dmabuf_ctx(),
but I decided to use "token" not to collide with dmabuf terminology.
e.g. I wouldn't be surprised to see some dmabuf ctx in the dmabuf
implementation code. Maybe "*io_ctx" would be better.

> Then the patch should probably define the full interface and not just add the callback here and then the structure in a follow up patch.

I strongly prefer splitting patches so that they touch one tree at
a time whenever possible. tbh, I don't see much of a problem it being
not defined as it's just forwarded in first patches, but I can shuffle
it around in the series so that definitions come first.

-- 
Pavel Begunkov

