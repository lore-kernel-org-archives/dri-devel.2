Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDD4C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D069210EB8F;
	Wed, 29 Jul 2026 10:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KdnQl/ux";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E75C10EB6E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:37:31 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c12614b81c9so141396066b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785321450; x=1785926250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
 b=KdnQl/uxGsmM3HVwSLKuc5nRS5UwnaGlq0Itxg2UVPjOYjCndQIanT6XLNavGBW4bC
 t9CzVdzTJGbOE2fO5GWCidcDMhsNv4Zt5zwVj3eIp3Hv0rZG6A/tNl9PH/ss0ozrCqlz
 4PptpAlZeoyQA9ltctybB6JewXSsGOVZBj59QX2SwlRb2gJSdzP8Lcv14Hqoq41VYXQC
 5SM8ycOOmhKqRahNKaajw7c5IKAhx7WeY5X9QXjhij005GQht2PkELEqdBZQJHvLYpNX
 6Frgp5jk4eWs6MP5Vt6/un/ivj8T0J+NCebyxdc0zO3tncaNhvjG6swDASWWhA7Sqyao
 N1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785321450; x=1785926250;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
 b=TmJ6pVlRHfkpV93AgM4xDLtzEjJsozZwdMKToJisNqVFTiyNAbpoLJv9O243EATsIV
 1iuLx6qX29TqWF2HRsJcAWtyopAEi6LxVK73X+R1B4LmIlBonwLqLTievcRG8H8Kfita
 +l3PjNteMl+CEGPFOdR20eapgc6Sv+MZxCVdD3IIouvLDTew6N8tu3GjgGs97LxBiQY9
 ry568l7j8ZfXWOcXivGaZS7An9Zma73wVOPe2DGjPxvI8COVcj+cikfi0beK4ovnJD9J
 xyyD1DXJMQ8kGARQIhBHiq5LC62uLjEcP//JGzI52PLEjlWD+K5uZs/biapF0gbZaqHL
 JNAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rozg7z4P/Xpg4ZqY0KzbzQOe/kh/aneeEMSsUWocCZzaI5m0ZY1CptzOYNgkt1CkYLzN6NbtRkD8D4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDWh+ab+Sue1i/1ybEFi5Q/r2aOlXWLQ3SrckrEQmUSTIHFnIk
 n3hu7Cx5XT3Nvqco5Z0RMuuxnubxFGPBjwBOl0Na1EEcdWLehVXPZSId
X-Gm-Gg: AR+sD12fdLEMQf1FkjLhna5r1yodXNZhKhFoiMImLRXndCQsxiOgfMOa4JFeTOqJ5EZ
 rbalmSzyQ755uzRbVbdHJFFG1IyX59kz80KVbbEQckjHuNFLFQVvVFrExqCQv6bJzlz62ZPz9ye
 hxzOavnJ5DaLXGgdj5xehZx7TPLEBAbkuVMuUinRDrbRBM45C0mmuKjySJDc+vwn/1XljpN6/dj
 p+Xhg2uYbYHW85/hZQTQGhDDgUx6L6ixmD1eOXn2WvE1C4w1hn9G4ZZJqhPgP0D1XkcXgxGUcuR
 tDhUJMg5pf1sOvxyb3rNBk9Gd8aWy6m71nwiiWFzpMQ2ncs8pQtL3+lQj8hDvbIK9T3XhTJYOIt
 4cs5tqqJGy1UE60K9BJjmFwcC0tATAfaUgpNFUPueSHJK0JwPrKMeYJE+IZ0ACQaeM9iXQi8q3Y
 tqrLM/WEFqILdZfB3iDt2PXeHTv5vMgZQNRtQ/8NJ4Egf7PCga8fUwaGCs0q6UF2yaP/EG5Ww9h
 65XutVsdPHcR0Es/zQ71Yfu6b0POatQua6z0Q5f2dkyEfCLPoMi3IncZzONdzQJu0IazWRU5Rdd
 HSeSsWKdCqMGJ5w9jUE=
X-Received: by 2002:a17:907:9617:b0:c1c:62b4:1ebf with SMTP id
 a640c23a62f3a-c1f721913ddmr365145166b.60.1785321449861; 
 Wed, 29 Jul 2026 03:37:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:640]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f84026c47sm93918766b.63.2026.07.29.03.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 03:37:28 -0700 (PDT)
Message-ID: <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
Date: Wed, 29 Jul 2026 11:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
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
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <20260729065927.GA9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065927.GA9534@lst.de>
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

On 7/29/26 07:59, Christoph Hellwig wrote:
> The method name feels a bit convoluted, but given all the
> previous discussions I don't care too strongly.  I'll leave
> the dma-buf side review to those who understand it.

I assume you mean this:

+	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);

I agree, and all dma_buf_io_[ctx,map] look clunky, but I don't
see what I can drop out of the name. Suggestions? Maybe I at least
should make the fs op sth like "register_dma_buf".

-- 
Pavel Begunkov

